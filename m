Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAEC704F45
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjEPN06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjEPN0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:26:46 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4453C06
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:26:41 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-559de1d36a9so198812437b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684243600; x=1686835600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGagm1vXHI1PkP46CvbXLMsj7cO3QztZA8duCtTtb9o=;
        b=BBDLr2yOIkdn9JKzHqYWUkrKaIfjzbMkTadnGY1ZOnmf9QF4/c1936OfgcGm3G63Fa
         ow5K2+8E5csy8HO2ALThpbGKKexPNId0nennqUcuP64RY1HSRZtCffZ0OlxWkTZpTZfU
         UfP5WmGBzrzweooe5c9/D9b5skt21fDxqqaAXbdFWtVu6cBJhdFf/IxS8NlBDz0soFo2
         DMNBYaXY4XcELgmk9tOIFcO+mmOBXQ/Utq7FER7OurDYa5dJVYRdY1m+WNGdJ3C9Dn3U
         dAQFrsr7Dkqr3L17JEWZDI4NdKXuweMdEDuUX05tSg/dR8xEwVTHcboJ1kbtHc9s+K8t
         joMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684243600; x=1686835600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGagm1vXHI1PkP46CvbXLMsj7cO3QztZA8duCtTtb9o=;
        b=EEvf7G5sh4ArTJ9dXAiqD4Kr3YO9+klRCiWcM1lOug/Ott985byGnxkO3lwlptgoml
         /TDDMB8Q5R4vb/hR/+yPP05oGEVKRncaFqS3CmvdRfLB7qQHZhmL7fa+sGhx3YpZgEq+
         eCSC7ncsgtWGncvCQjaqFYqAby4uVy5d/CJNtK2XIFnFBVmk2xdi4E5nsBt3k8Wb7CO8
         IxJGursjTi8NPg0lKa5dYFWdJqerZm52JdpNibKa8Kizt0/Tw1j+uKrBrQz4vRUE6OMQ
         rvnn9CBIFFmYRWkcPiFGAyYOtJFHgrfO13g+D8LMcq5ST1TlfeSNSyRc81ku10yJqgnj
         X7+A==
X-Gm-Message-State: AC+VfDxh3iTjIZGsZTikmMhF3SuBfbZbzY2DQid08mAzwT/n4BtAGF2W
        7h+yAipdlh51ZOQgJTxtHjbZ8/seB6dzWoCAPRgKIg==
X-Google-Smtp-Source: ACHHUZ7LfAT/h2IDwvGEtGcDXQaR7qhOni6QpToaDztdO6FuXnQFiEK4SxBy4djuaTxTZzIOEeabxbQAAZ9Ql1yj9F8=
X-Received: by 2002:a81:6e8b:0:b0:561:206a:ee52 with SMTP id
 j133-20020a816e8b000000b00561206aee52mr9950068ywc.24.1684243600338; Tue, 16
 May 2023 06:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230513113510.177666-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230513113510.177666-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 May 2023 15:26:29 +0200
Message-ID: <CACRpkdboE8yp+TvR=UaTSL2r+k739D-fQuk3+152h84_TYs3Lg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sc8180x: gracefully handle missing IO
 memory resource
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 1:35=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> If device was probed with incorrect DT or ACPI tables, the IO memory
> resource would be missing and driver would derefernce NULL pointer in
> sc8180x_pinctrl_add_tile_resources().  Add simplep check if IO memory
> resource was provided to silence Smatch warning:
>
>   drivers/pinctrl/qcom/pinctrl-sc8180x.c:1664 sc8180x_pinctrl_add_tile_re=
sources() error: potentially dereferencing uninitialized 'mres'.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied as non-urgent fix.

Yours,
Linus Walleij
