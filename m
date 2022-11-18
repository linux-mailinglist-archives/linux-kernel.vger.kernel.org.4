Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083CB62F104
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiKRJWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241876AbiKRJWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:22:13 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F323FAE58;
        Fri, 18 Nov 2022 01:22:12 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id fz10so2765083qtb.3;
        Fri, 18 Nov 2022 01:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=608m7xEE/4C1c1/2Z7UfY7sG1iZCUcPOix9CSLSRzEk=;
        b=ikUEYthT16cSfd2SWwtC8w6yvdu7JqZpvcw/gJcYXFnIx92djm9vEujVofSt2RJVOv
         jNtuslOG0wy1gI8Er2k1E+5FmNHvLER5bxU/IjlZregrxrpHAZksOUSI6l8vZjVy8mLr
         8DfR2uElp3cMcfk3M+/m75M1/p2vU7uKxiIeCGTY23cdX0SNFFlDLvt+Gz9fDweHA+vt
         vlz6X7Uy00mKX/nTDw+IvM4nmKb2ayPrxwxFHGMYyrbv5hOL9Ehv/UOTczJBxuh2DbvS
         xV2SZ5wJBDwydrysmOjTRxz95kBMLYLKAIeXCPlujkWMnB7//ktxcq4DqsY4+J2jJRAw
         UW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=608m7xEE/4C1c1/2Z7UfY7sG1iZCUcPOix9CSLSRzEk=;
        b=1EBUJtqGKiK06aP4bLaVR6lkpfbfmPLDhnPEItCMWmlAQaUF+vzbbbV7fu35o6mnQ0
         qkyqtjgpeEwppTQErnhU1wZP+6jYA1tVx91jXXgD/Ycth/inZrAC8IihbYO9EHCwBEIL
         WXbNsecK9DvsYWZKko9HjsO+cahF5V6opyi69Lb2fHSUXyfHhVoDnuhhMdpJnWrHAT/j
         9twbX5Ey1hB51OczjlrjBemhU0+66jewdTecXvc0Gq8mYLGek9goawPgUbhp9L+F/Gs+
         yWyCRBYZqYc0R5Y8Ds4bCI52ng9IboO3Ldxtemrj02i9d72X/cNnKMPdLyVwIi0j9o5x
         nekw==
X-Gm-Message-State: ANoB5pkzVcO0t+/GMvc35QcM/fcTruCZedoxgrWm3PIhKeGbXs+LyrKZ
        aVIeXmqy/dX4FO/OMnHgvCxY4dY+ehl9+EslearCM5OrVii6nw==
X-Google-Smtp-Source: AA0mqf6gBXuIWGRkpl70E2TZiCmWvSS3vzUG1ukUke/5aNW7azuGVeHrm/EwzxEaXVCBpWSnCXz6zaZzNHsbTB+70H0=
X-Received: by 2002:ac8:4d51:0:b0:3a5:1e6e:ad6a with SMTP id
 x17-20020ac84d51000000b003a51e6ead6amr5726443qtv.556.1668763332161; Fri, 18
 Nov 2022 01:22:12 -0800 (PST)
MIME-Version: 1.0
References: <20221111084214.14822-1-wenchao.chen666@gmail.com>
 <20221111084214.14822-2-wenchao.chen666@gmail.com> <CAPDyKFqvbFLeVFHrd12Q1VdNy3TFmpRaNyuk4AJjNukPzNpT5w@mail.gmail.com>
In-Reply-To: <CAPDyKFqvbFLeVFHrd12Q1VdNy3TFmpRaNyuk4AJjNukPzNpT5w@mail.gmail.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Fri, 18 Nov 2022 17:22:01 +0800
Message-ID: <CA+Da2qxX2kPX8ArHnh=xk=M3qE7fBD=3D+pV3VkT-S2_1kCzXA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: sdhci: Fixed too many logs being printed during tuning
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, megoo.tang@gmail.com,
        lzx.stg@gmail.com
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

On Wed, Nov 16, 2022 at 11:21 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 11 Nov 2022 at 09:42, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
> >
> > From: Wenchao Chen <wenchao.chen@unisoc.com>
> >
> > During the HS200 tuning process, too many tuning errors are printed in
> > the log.
> >
> > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > ---
> >  drivers/mmc/host/sdhci.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index fef03de85b99..a503b54305eb 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -3401,6 +3401,10 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
> >                 if (host->pending_reset)
> >                         return;
> >
> > +               command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
> > +               if (command == MMC_SEND_TUNING_BLOCK || command == MMC_SEND_TUNING_BLOCK_HS200)
> > +                       return;
> > +
>
> Please use mmc_op_tuning() instead of open-coding this. I also need an
> ack from Adrian to apply this.

Thank you for your review, I will update the next version.

>
> >                 pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
> >                        mmc_hostname(host->mmc), (unsigned)intmask);
> >                 sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
> > --
> > 2.17.1
> >
>
> Kind regards
> Uffe
