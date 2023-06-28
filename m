Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148F9741711
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjF1RP5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Jun 2023 13:15:57 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:40082 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjF1RPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:15:55 -0400
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-98e1fc9d130so1380366b.0;
        Wed, 28 Jun 2023 10:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687972553; x=1690564553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LwO02mTObe+XE/ZbgwuNMH8tuDZ5edg4iqXBtgQBUk=;
        b=kKJAovd8nDzpuJeNEu5eeMukFFz8qURc8zZVc8LTOuB1ldZ+dJCitRwMdxD9HsweZj
         rosi5KfXb+I8aoIaKsh0MksjapsyQVDjU7rECgirmmnuwCvGAdvMtlYa68OTnaD7wly/
         eb02hVEs5AoYfY+uNdgLpYTiznBulnPpmJVyjNcerrb6TRCiiFOPcWTBsyQonzqLlmAQ
         BavAH6474ohDGKUBpmnq4yN6/aJVs3wq4OfNHskktL4l6cMM53V4lK9Dxt7p8HqPPVfQ
         irLEGItqKrVp2lkegKCA4DB+V9Hu8m4zImfZkhJcq2n4v7ecVdPlJfLh5b1O9ULs9tfI
         EyZA==
X-Gm-Message-State: AC+VfDzT6P4vekd0Dvki5rgM0B03eIDbEPGA5/7GR3jLG9FEfsLOPHuw
        d3kDz4XGbWuYTNagoX+Jvx0+7RLT3E6WxpRKJTc=
X-Google-Smtp-Source: ACHHUZ7CIqElFwO2Gj2NC5FB5TW+/D7zez7V8RQplT4jstVJg2zFWxQSotgNlm2pZfDQJSupgWsdvRNx0BvzMADpE8M=
X-Received: by 2002:a17:906:209e:b0:98e:886:e6bc with SMTP id
 30-20020a170906209e00b0098e0886e6bcmr9714752ejq.6.1687972553371; Wed, 28 Jun
 2023 10:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230628105652.1670316-1-abel.vesa@linaro.org>
In-Reply-To: <20230628105652.1670316-1-abel.vesa@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Jun 2023 19:15:42 +0200
Message-ID: <CAJZ5v0i-+b+oFOP92rhNw_UOKu3-QOy_-stQRa5X2HbaTq9XMA@mail.gmail.com>
Subject: Re: [PATCH 0/2] PM: domains: Add control for switching back and forth
 to HW control
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        avel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 12:57 PM Abel Vesa <abel.vesa@linaro.org> wrote:
>
> This is just a resend of [1]. This resend just adds the back story behind
> the need for such a generic API as a cover letter. Also added my SoB tag
> to Ulf's patch.
>
> Some of the newer Qualcomm platforms support handing of the control of
> some of the GDSCs (implemented as power domains in Linux) to some device
> firmware. The idea behind such approach is that the firmware knows best
> when such a power domain can be powered off or not and leads most of the
> time to better power consumption.
>
> At this point, if such GDSC provides HW control support, the current
> implementation is switching to HW control right after the GDSC gets
> powered on and it is left in HW control mode until right before the
> request for power off is done. This needs to remain as is for now, as we
> do not know for sure what each firmware expects from its related GDSCs.
> For example, the venus driver expects the codec GDSCs to remain always
> in HW control mode, otherwise the firmware would crush.
>
> But in some cases, the consumer driver needs to switch back and forth.
> And the explanation for such case is when a driver needs to interract
> with the device (e.g. reading status bits) and the firmware doesn't
> guarantee the GDSC will be enabled when in HW mode. Therefore, the
> consumer would need to switch back to SW mode, do its thing, and then
> switch again back to HW mode.
>
> This is where the patch from Ulf comes in. It allows consumers that
> actually need to control the HW/SW mode to do so.
>
> The GDSC patch just implemets the set_hwmode op and sets it for each
> GDSC that provides HW control mode.
>
> [1] https://lore.kernel.org/all/20230627104033.3345659-1-abel.vesa@linaro.org/
>
> Abel Vesa (1):
>   clk: qcom: gdsc: Add support for set_hwmode_dev
>
> Ulf Hansson (1):
>   PM: domains: Allow devices attached to genpd to be managed by HW
>
>  drivers/base/power/domain.c | 66 +++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/gdsc.c     | 22 +++++++++++++
>  include/linux/pm_domain.h   | 15 +++++++++
>  3 files changed, 103 insertions(+)
>
> --

I can queue up this series if I get an ACK for the second patch.
