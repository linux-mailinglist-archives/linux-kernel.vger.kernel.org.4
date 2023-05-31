Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC1A7173F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjEaC4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjEaC4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:56:43 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E27111C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:56:41 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565d354b59fso50913227b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685501800; x=1688093800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l63BPFHG/8A+DlS6bj6aZarLbZJd7JSZfr8s+sxk1kU=;
        b=wzQLoolkF4+jrat6q+ubEjQngrEqfsaw/HCc1Ve9bqpxoiPtgOtB/OBpBsBE7v6tsy
         PmNAc6Sp58LnySwGc5c/HtBhKvJsTIWXL5TsmFF0L4qAJl1N2bS+y2H9WxAA7MoiahaG
         IQZgLkNBjqiFe+PzxALHR1TbsYXjtzKfOHF3UpvfJ89zoXDSFGsCqehX+rUE2RvvdT3R
         r1VbD0ZZhCjmGpNw6hVHGabrdUDLKyunklcpm/pNN4zvIdwtTSC4QJEAwX0U627+rs9/
         4LxGwcw+5HX+wpChEHfAOLMS6V1A9w1wenuB0+oSrprkYNvIuG2bldmCztyk7C+IHHjC
         9u9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685501800; x=1688093800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l63BPFHG/8A+DlS6bj6aZarLbZJd7JSZfr8s+sxk1kU=;
        b=Dly0WomDvaj5YWD7EYHv13OMxzEhIhWpEgvS3riplLZmdiIwnWD/44LZw2PIITfhvP
         o1UHiLhALVbkBASTEi9PuTsNhcAhvHamNHx53mgnRmJ/j+nywlzx5eEUdjFxB3qHGdKI
         ghonSOx3iz7/SUdrycRNs87CENk/5f0+LfsvyjawqbNp29GJ2El0DQec2Y5Llyn+HY0E
         ULBgPFK471M4i2qQKyU0vhHlHi2WQchQl9szyDldJk991LN4vyOQTGc0XE1PIiz9qAHK
         5NOmGpq1+PxaRPUiOtyBYYLdtW2aziVjC32CYar0QqkysqOgUJb93I9Yf3GnEMU+I7nu
         JR/Q==
X-Gm-Message-State: AC+VfDzsz1/aKwishslUPhF2De6WV4QiUdoP/A0XWCd1V4fMHFEgdexb
        rkVcaQ6vcGg17bh9wWRUK12cBbA4YsDAfVxa+oahdIGM3naKyrqQ
X-Google-Smtp-Source: ACHHUZ7nxozK+OzM2cHrCcQBYx9QECrpocSGlUndYud5X7WsYdFzxQhxBFPWubzuzPJkE/PoszYCKS5y+jQXk6Fg0Uw=
X-Received: by 2002:a81:6c94:0:b0:565:c21d:8ec6 with SMTP id
 h142-20020a816c94000000b00565c21d8ec6mr4823798ywc.6.1685501800664; Tue, 30
 May 2023 19:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230527040905.stmnoshkdqgiaex6@ripper> <20230528001010.47868-3-guptarud@gmail.com>
 <fb65244e-ab3b-c473-57b9-2da80e67be4a@linaro.org> <CT04D1K5GOBT.29Y5DO5HHS57V@Latitude-E6420>
In-Reply-To: <CT04D1K5GOBT.29Y5DO5HHS57V@Latitude-E6420>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 31 May 2023 05:56:29 +0300
Message-ID: <CAA8EJppVHW845p-JJ-9qP6x8pJz64nEN2t2Da+u=yHc6+4pyBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: Add qcom,usb-hs-phy-msm8960
To:     Rudraksha Gupta <guptarud@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 at 05:49, Rudraksha Gupta <guptarud@gmail.com> wrote:
>
> On Tue May 30, 2023 at 9:22 AM EDT, Krzysztof Kozlowski wrote:
> > On 28/05/2023 02:10, Rudraksha Gupta wrote:
> > > Adds qcom,usb-hs-phy-msm8960 compatible
> > >
> >
> > Please use subject prefixes matching the subsystem. You can get them for
> > example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> > your patch is touching.
> >
> > Best regards,
> > Krzysztof
>
> It seems like "dt-bindings:" is the subject prefix for this file. Would
> you like me to use another prefix instead?

At least it should be "dt-bindings: phy: ". However as this change
covers existing file, it probably should be "dt-bindings: phy:
qcom,usb-hs-phy: "

-- 
With best wishes
Dmitry
