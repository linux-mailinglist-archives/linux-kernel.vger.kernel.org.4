Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909166B3897
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjCJI3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjCJI32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:29:28 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1914EDDB3F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:29:27 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-53916ab0c6bso84174887b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678436966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ8WEFzt5Db0FqLZyEfnb3WolQj2HUPnMgEi1F3RxYY=;
        b=uHHamRINr0AyuQK5iTvGzBKyhZZnSuP7G6a6oLT/A77BR2+RvuA9gbwSKGVjD08Vjp
         I9QAUERfxdUCi3CMO8zJ8FtAZ3Zs/euFEJ+GSzb409WdKV81zwWphmfTJfeS0cg0lO8u
         XSa5ZhhV1Oorrn5gZCcz8cz/e7yPChRQBH/GU7t32+Jci/jCaiCE6/zWrk3gML12b9qc
         zqulLmrXD8IsMzWdhI8Onco0H9O/41fOx8wyZ901DbBS97lSty8nJUJzKPJPPfpnyOZU
         VCDPRO04K5HVrYJFxcpU5neheCxK1mDTsvIUOJCawoq5d8TruAVsoFQRrB4zjrPcsDG4
         jZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678436966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQ8WEFzt5Db0FqLZyEfnb3WolQj2HUPnMgEi1F3RxYY=;
        b=pw+syTcHhqgjjl7/CdmUiSBXF5sKBpJEQZdHunbgUFTxxph0s1KqCHyy7AFXuuZ0Lc
         M5gcvbFeIaD+zB6SydvSEUa72z2wUQwnCoDCYB13+fPnk2K9anN7RAotQECfpACbEGnq
         PnOd+wHPMGRuVMKSo54GwUadRW7axey3MUAWsNDoWR0feeXTjL6TU0rzAveN737cNPYY
         qBFYyrdW3JbvulaKirb6OtVMvmMC0PJA3fCyKJG/UJ2GiBLKyGKf12wPsqMOJL47nsrH
         idhkGJrDwzwdaxGVxv1CLYtw5eOzylhCA4LMzVrdLeptymJNy7vv8SciMFj3kb4xMAHA
         Qjrw==
X-Gm-Message-State: AO0yUKVrvrqlK+bS/Khxki18IC0Zthbk1vzro4j5IYUnSQnaxgdDB77l
        X0/iYReFP8L9H7KCYYyP2643U7c6VUcNB0cBEGYX+XOMxf9n5rQi
X-Google-Smtp-Source: AK7set86T8CEE44n5qgyc35gLPXwP69XifWW2duU0TPqtWVwZ+MpWW6b0Wlp6bSqS7vEkPRVJrk3MfYAtVr1gml/l/4=
X-Received: by 2002:a81:ac4b:0:b0:533:9ffb:cb12 with SMTP id
 z11-20020a81ac4b000000b005339ffbcb12mr16351128ywj.10.1678436965961; Fri, 10
 Mar 2023 00:29:25 -0800 (PST)
MIME-Version: 1.0
References: <20230309225041.477440-1-sre@kernel.org> <20230309225041.477440-7-sre@kernel.org>
In-Reply-To: <20230309225041.477440-7-sre@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 09:29:14 +0100
Message-ID: <CACRpkdYTD3OZ-44N0oRD93gToxR_DoFSkLhvNjrRpCms2TX5nw@mail.gmail.com>
Subject: Re: [PATCHv1 06/11] power: supply: generic-adc-battery: drop charge
 now support
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 11:50=E2=80=AFPM Sebastian Reichel <sre@kernel.org> =
wrote:

> Drop CHARGE_NOW support, which requires a platform specific
> calculation method.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

I agree. If we want to support this, we should use the generic
methods with interpolation tables defined in DT as well, and it also
ideally requires load compensated resistance calculation to figure
out Ri so this can bring any kind of reasonable precision.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
