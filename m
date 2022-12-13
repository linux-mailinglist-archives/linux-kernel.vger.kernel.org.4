Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F4464B178
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiLMIsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbiLMIro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:47:44 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534A85F83;
        Tue, 13 Dec 2022 00:47:42 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id d2so9987676qvp.12;
        Tue, 13 Dec 2022 00:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ETNiNZlm2nbqIrIPTG+fUaXHM2BEGv4OzFo/ACQLOD4=;
        b=gCN/lXh+gDdkCFk3yEwfWnMrvvtBHWJSBS8nuRBCSZCJOyUTFeNzSvgU3Vd9TWef49
         gkNb3pB8IwaBajWKx/3jKDb4+PnsSO/gt9MZdrdRkkufByQUs+9a0Q6+STdYdhi3zjyC
         cxvYO0noNq6nYGU0Gersb6TKxBCTAlIQY/S41iSKkG/dnpYayFy3OtAlKY4AqO/kjSyw
         LyZrdIcIxzr6YFtCGdRDenHgpaee5KpN8kkuskEkfyeSmqERpeyrcEO31+hMyRf8alAp
         D3nyLHZPmWLduBvEccmfZbfPs4ueY8qYMUJjeZiVJASW0HdWxbgQLjsKLWCFJ9ILP48/
         Ax6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETNiNZlm2nbqIrIPTG+fUaXHM2BEGv4OzFo/ACQLOD4=;
        b=16DZJp7nAjWsWPTXEQGW+mH7XSQZgSCChyXMsb+w0mb4tQJNe+0OHJDsKSciJy2hkB
         FCJT2pJAHyp3Xo/f4XbAKKeXZUO0zVqw82yOqPDax/3+AmJVoT2Uat0yU/t1A6YtoC7c
         5u5dICA74RN83C/602fd08AnZe5NLdZHMdSzYJc6U1yzbyyZwAZ3mRZVkoVfeoI3d3cL
         O62lmbUvwPP7pS4oeEO09iHgwSWkO0KF3unCcptTMyB7rZl8tdvonpJsLTPzL7j8Wado
         W1YFGSWRvyFuVSJm5iojIVS1eCbsA2lYYVPEZDHDl96lgIVXDFX5/CpkmJ36PPbRKV2v
         pdjg==
X-Gm-Message-State: ANoB5pkIfAA+JYbwClX/xdC7RC4EVkKNrM5CBQpWY7SNjB7pPLxaLXSb
        ZWsSamYMxwTueun7PwM0m1wXrrPgISvRdhb4Q+8=
X-Google-Smtp-Source: AA0mqf4kOlnjtjWs9mfBBLyFt0NOzcbazMTa4ayNP2AryQv4xiwUUDTmt2BMhH9faSqXfwgLMFOb0mEynO7TcPYDQVU=
X-Received: by 2002:a05:6214:141a:b0:4c7:5bac:bbee with SMTP id
 pr26-20020a056214141a00b004c75bacbbeemr19354210qvb.107.1670921261423; Tue, 13
 Dec 2022 00:47:41 -0800 (PST)
MIME-Version: 1.0
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-18-victor.shih@genesyslogic.com.tw> <7d4f7f9e-a54c-c00e-2da7-c3e6dfd79869@intel.com>
In-Reply-To: <7d4f7f9e-a54c-c00e-2da7-c3e6dfd79869@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Tue, 13 Dec 2022 16:47:29 +0800
Message-ID: <CAK00qKAx_KAsCYuP6n6g0-VD+4tZ4=Fn-d7NdG_fBDpv2GQM5g@mail.gmail.com>
Subject: Re: [PATCH V5 17/26] mmc: sdhci-uhs2: add clock operations
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adrian

On Wed, Nov 2, 2022 at 1:14 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 19/10/22 14:06, Victor Shih wrote:
> > This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 36 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 9ceae552c323..afaca5d96938 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -11,6 +11,7 @@
> >   */
> >
> >  #include <linux/delay.h>
> > +#include <linux/ktime.h>
> >  #include <linux/module.h>
> >
> >  #include "sdhci.h"
> > @@ -403,6 +404,37 @@ int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >       return 0;
> >  }
> >
> > +static int sdhci_uhs2_disable_clk(struct mmc_host *mmc)
> > +{
> > +     struct sdhci_host *host = mmc_priv(mmc);
> > +     u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +
> > +     clk &= ~SDHCI_CLOCK_CARD_EN;
> > +     sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
> > +{
> > +     struct sdhci_host *host = mmc_priv(mmc);
> > +     u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +     u32 val;
> > +     /* 20ms */
> > +     int timeout_us = 20000;
> > +
> > +     clk |= SDHCI_CLOCK_CARD_EN;
> > +     sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +     if (read_poll_timeout_atomic(sdhci_readw, val, (val & SDHCI_CLOCK_INT_STABLE),
> > +                                  10, timeout_us, true, host, SDHCI_CLOCK_CONTROL)) {
> > +             pr_err("%s: Internal clock never stabilised.\n", mmc_hostname(host->mmc));
> > +             sdhci_dumpregs(host);
> > +             return 1;
> > +     }
> > +     return 0;
> > +}
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * Driver init/exit                                                          *
> > @@ -560,6 +592,10 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >
> >       if (!host->mmc_host_ops.uhs2_detect_init)
> >               host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
> > +     if (!host->mmc_host_ops.uhs2_disable_clk)
> > +             host->mmc_host_ops.uhs2_disable_clk = sdhci_uhs2_disable_clk;
> > +     if (!host->mmc_host_ops.uhs2_enable_clk)
> > +             host->mmc_host_ops.uhs2_enable_clk = sdhci_uhs2_enable_clk;
>
> As mentioned before ->uhs2_disable_clk() and ->uhs2_enable_clk()
> are never called.
>

I will update it in the patch#16 of the new [PATCH V6].

> >
> >       return 0;
> >  }
>

Thanks, Victor Shih
