Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AAB74D406
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjGJK5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGJK5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:57:20 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2B6B1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:57:18 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-c4d1b491095so5119086276.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688986638; x=1691578638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hQ+EFWyqPVcfn5r85TOW215yYJLlf1C3/IC93ziXGxY=;
        b=PzhQlBjaM4jeJGSImOyz1ZKexDQBVzCzztUYmrsaN8K16WDBb8fafy5vLGyNBlt6mf
         YwpccViGjravk9wLkiCI5xn+RuLKdPAsmmKgGjN0lola57N+ovFkc9d7ML9ZycPz/ZXR
         P/HMedJSWHo/bKlp7bC4Q1/4hVmVJkUiQoSHMGWfFl8lJcp7GyXCtCgwIS6fvv0Dx9ib
         rtPBLZdkjbf69RbFhk+5P96bRPH4uTf0b0P/u9iBrsPiAuAxnEixR/q9fkcmRN5vSsqN
         AALX1wIbFTHR2g1R2V9+N+pN5JYWUxN/7egH+CCmSEDE/jhi2fCEEu0fJJM+TXHzrHKc
         E/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688986638; x=1691578638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQ+EFWyqPVcfn5r85TOW215yYJLlf1C3/IC93ziXGxY=;
        b=P5h1EqxXb6vMGB6pOgKDVLX5gmvK51h0gWMfy+/0lJNnOfHVZyM1euWOgcWZeMxkQ/
         4kSMhER1pujwfGvKLCuV7Eg6EGYCka7SYQEMRblyqsKHTCKa32Tca/BN0uhPwG+JQixw
         yG5PwbNywfFiI8WfRnKg/px8qCx6LxbwNKBZgnwQRNiIu2/LE50OkK0m0pXhy8r0q8b+
         JDAtdZQjrcQnlSjHXxV8/0sRSuDKFNRJ89nRbZjHsYE9Xyk5G/LCJYHrcW1j42MGuyOP
         44rhOB/XQc6JAq8W6FZdlpz7rMbTZ8dAGFMuimHfhvoIlGcqi4w7eO2b+fVoaPZh0h4n
         LqWw==
X-Gm-Message-State: ABy/qLYQP1RcSUQpsETLRkl2lAgBXIKk7ndPQoB1DO+x5+JKVoAQm7xP
        xZ7mssTx4go0qPQfamBZrW3cY9FCTOVwXKfZIgCWQA==
X-Google-Smtp-Source: APBJJlFP31r0f+V4DbCx5wQyP+r7v8c+VPJ9DzC9fX2DwSE7AhcEXpNB8BSIrlMcH1EsJCOxstOmKdIeJSUGELnMiTg=
X-Received: by 2002:a25:2d18:0:b0:c72:c9fc:79ff with SMTP id
 t24-20020a252d18000000b00c72c9fc79ffmr5108472ybt.54.1688986637931; Mon, 10
 Jul 2023 03:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230709201309.274306-1-dmitry.baryshkov@linaro.org>
 <20230709201309.274306-3-dmitry.baryshkov@linaro.org> <0408a6f6-356e-af6a-3e32-1781aec2854f@linaro.org>
 <74aa7196-e76c-a1c8-9b0f-1d5f236d3467@linaro.org>
In-Reply-To: <74aa7196-e76c-a1c8-9b0f-1d5f236d3467@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 10 Jul 2023 13:57:06 +0300
Message-ID: <CAA8EJpppsaKqKY0V9O1JMUGiE8USzg8b0ZPZwn-0bwg1wYD6Tw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: typec: qcom-pmic-typec: register drm_bridge
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 at 13:04, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 10.07.2023 12:02, Bryan O'Donoghue wrote:
> > On 09/07/2023 21:13, Dmitry Baryshkov wrote:
> >> The current approach to handling DP on bridge-enabled platforms requires
> >> a chain of DP bridges up to the USB-C connector. Register a last DRM
> >> bridge for such chain.
> >>
> >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> ---
> >>   drivers/usb/typec/tcpm/Kconfig                |  1 +
> >>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 39 +++++++++++++++++++
> >>   2 files changed, 40 insertions(+)
> >>
> >> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> >> index 5d393f520fc2..0b2993fef564 100644
> >> --- a/drivers/usb/typec/tcpm/Kconfig
> >> +++ b/drivers/usb/typec/tcpm/Kconfig
> >> @@ -79,6 +79,7 @@ config TYPEC_WCOVE
> >>   config TYPEC_QCOM_PMIC
> >>       tristate "Qualcomm PMIC USB Type-C Port Controller Manager driver"
> >>       depends on ARCH_QCOM || COMPILE_TEST
> >> +    depends on DRM || DRM=n
> >>       help
> >>         A Type-C port and Power Delivery driver which aggregates two
> >>         discrete pieces of silicon in the PM8150b PMIC block: the
> >> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> >> index a905160dd860..0722fb8d75c4 100644
> >> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> >> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> >> @@ -17,6 +17,9 @@
> >>   #include <linux/usb/role.h>
> >>   #include <linux/usb/tcpm.h>
> >>   #include <linux/usb/typec_mux.h>
> >> +
> >> +#include <drm/drm_bridge.h>
> >> +
> >>   #include "qcom_pmic_typec_pdphy.h"
> >>   #include "qcom_pmic_typec_port.h"
> >>   @@ -33,6 +36,9 @@ struct pmic_typec {
> >>       struct pmic_typec_port    *pmic_typec_port;
> >>       bool            vbus_enabled;
> >>       struct mutex        lock;        /* VBUS state serialization */
> >> +#ifdef CONFIG_DRM
> >> +    struct drm_bridge    bridge;
> >> +#endif
> >
> > IMO there's no reason to ifdef the structure. Its up to you if you want to change it nor not, I have no strong feelings about it.
> +1, there's no ifdefs in the drm_bridge.h header that would make this not compile

It is quite typical to idef unused structure fields. For example
OF-related fields are frequently ifdef'ed.
Let's see what the maintainers will say.

>
> Konrad
> >
> > Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> >
> > ---
> > bod



-- 
With best wishes
Dmitry
