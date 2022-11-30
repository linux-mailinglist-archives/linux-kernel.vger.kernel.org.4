Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2FC63D516
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiK3L6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiK3L6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:58:43 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BB56F34B;
        Wed, 30 Nov 2022 03:58:41 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so1699808pjs.4;
        Wed, 30 Nov 2022 03:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aWiaIM/RLdCXMf3+kK2o0eHaoRkScfMlFpmz93oiZvg=;
        b=KgyBBrvoTl8ZK6B3XyV7ajz4tvkA9eTCbZ1Y7pjlVM+lzaIh5R4viXDEj5KlAj/tZ+
         JNgS30D2D12HClBeseFCcDGr2620EOCMEU2BoXW9wuki4xQZGsnK1GdNF31gCzCSMWdN
         JE4wxJNhcyoWQlIHSPc/xix/USQqZt7xNLW6w7veo8vc/lU/zHE6tOLIJ1Wws9wL0Jst
         3VV0QUMC2msr4h3izEUnsd4PFqxMBwq06UXOJ9AzASXxvUgXU+OyS5P6gRke7GnSBkxO
         NOUR3FJLYDJKJNewA5IpWghH/xchqsBOPpv+X7NyzfGha17PBvux6QSJGdgb76kvOzNp
         HU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWiaIM/RLdCXMf3+kK2o0eHaoRkScfMlFpmz93oiZvg=;
        b=shdiVdp6zOHSpipZ1Uxi5vuLXor+TQf3k/92adYyEuj1TZ9FXo0cbTFAHPd03rvBYQ
         hlw+f73FPs5qnkqtsHtHWdQjuQFFlKwEMkhtXm2d3I/7/tsTcmghMLsdm2KZ0MB37Nvy
         rWhb3r3MnodA/lSKe2S9Dp6mMbsaavvxPQWpHS+7slwXJ64LrKATBQHs0VBpOUyBneYx
         E+y0oU9dFCKELQRtZqSjzAnvgVfzDzoslFQkWlKQ9uyse6ZLkGIxGXofN41LGHuw+kMO
         cbycYawz37CAmz87Y4pXE4fCMaFtSniPda2ug0POE/2H4gHKDLE8uXUxb7BozXhzUr7H
         nlow==
X-Gm-Message-State: ANoB5pnxLSVc2h8DPR9w4hLNVY7K1cuSO5GmtIC2plpZq6Nrabbf1LQb
        UzlmGD29XWzuBVWNOhFQjAZrcqxsLnxuTv1BVHM=
X-Google-Smtp-Source: AA0mqf4OsPK5DKFWhTrZn18tpVAP2Z+hwtnajgpvT2Bph0B5dFDjxUS66DKpb+bd1gnbV4k3TzXAF7S2UHzHNV/dIt8=
X-Received: by 2002:a17:90a:d918:b0:219:3e68:1d03 with SMTP id
 c24-20020a17090ad91800b002193e681d03mr13782340pjv.77.1669809520974; Wed, 30
 Nov 2022 03:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20221130080224.12831-1-wenchao.chen@unisoc.com> <9c93dd3e-f80d-7421-05b8-9f692d33d2f2@linux.alibaba.com>
In-Reply-To: <9c93dd3e-f80d-7421-05b8-9f692d33d2f2@linux.alibaba.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Wed, 30 Nov 2022 19:58:29 +0800
Message-ID: <CA+Da2qzFh3_5Z0Po5C+ds4xo0qAudkbo=xM3tYHfpsNb=BE6hw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix no reset data and command after
 voltage switch
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com,
        gengcixi@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 6:48 PM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 11/30/2022 4:02 PM, Wenchao Chen wrote:
> > After switching the voltage, no reset data and command will cause
> > CMD2 timeout.
> >
> > Fixes: 29ca763fc26f ("mmc: sdhci-sprd: Add pin control support for voltage switch")
> > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > ---
> >   drivers/mmc/host/sdhci-sprd.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > index b92a408f138d..464508be8ec8 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -470,7 +470,7 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> >       }
> >
> >       if (IS_ERR(sprd_host->pinctrl))
> > -             return 0;
> > +             goto reset;
> >
> >       switch (ios->signal_voltage) {
> >       case MMC_SIGNAL_VOLTAGE_180:
> > @@ -496,6 +496,7 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> >               break;
> >       }
> >
> > +reset:
> >       /* Wait for 300 ~ 500 us for pin state stable */
> >       usleep_range(300, 500);
>
> If no pin state switching, still need stable time? Otherwise looks good
> to me.
>

Thank you for your review. I will update it in the next version.

> >       sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
