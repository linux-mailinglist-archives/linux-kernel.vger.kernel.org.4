Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7C270605E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjEQGoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjEQGoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:44:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8A1E4
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:44:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f42c865534so3653925e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684305838; x=1686897838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BYh5QIQtk4kmFE1xMQJyAJuDhOQqL6TYhGJxqGSU/rI=;
        b=V2z0EA6Y9sZUBXjA8aV9Qwb+urdngocKOnk3tisuUQBqBvymqx9kMH85aqmor6lc9m
         82//pVd5pkK32RB+25T5kLmoXp0OjGakbP4aXnrmitpbuCsvGB/X4wcOb6hZjLHOTRqO
         atbIgc6cERpei+vdAOIj5bFUaxSWZeGc1O810XrFMWz/tRIVT15BaBoISxumVCkvCPJ9
         qe+w7thGz9gygazDAH5jZaCDkvJ7tuC/q+B5RcLuBryqggyAu3ooFftSN9vr8IP1gcaT
         pY727dXSMTN/WZqdNZFwZSPOmCYM0Aa38oeCFK04EFhjuZqHcQukhb0156DcW6vhGADb
         tXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684305838; x=1686897838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYh5QIQtk4kmFE1xMQJyAJuDhOQqL6TYhGJxqGSU/rI=;
        b=L25Wte55oId+c1LYlIo6GD+kdSMtlOBAfbcBC0PuuPlouLx2r6FZqqcT/WXWQUPuUF
         +CFVju0GNFQtpkkymlP09NDUJXnUqHGCwCi5vCmy9okpiG05A6QgXVR0beEzghO0v+CK
         x7QM4dbSKTGttjN9vvuau7wjYDqeDcilwILFYxBYQUwwdHiPmfnzmOc18mA0i+J7Hs65
         qICflyygFcLAl1m9d1blFl1Gd+vrq4/Ovnhzziw0KIiHeg5s7DnZaVHreMBEdMD2zny9
         8QJPolC1xNpjP7h6DiY3cmIif4FNvtJ9WFvsP721GNME7jG1YHkK96exSJFJJ3+qMyA/
         B5fA==
X-Gm-Message-State: AC+VfDxczkMnC0/JmFAs1GeO0NQVM0m8qNdTYp6zBjz+AWh2rLZYNNJU
        OPt8pErlhBi9XBO73W4OAXmwGA==
X-Google-Smtp-Source: ACHHUZ5oF9sWrtoOmyRCmE4Py+UM6kGi80A5+mVJo6ihWlsyf3Xwd2FqXPUuK7pw8noGbdlcmt/tlQ==
X-Received: by 2002:a1c:7913:0:b0:3f4:2e13:ccdc with SMTP id l19-20020a1c7913000000b003f42e13ccdcmr20339518wme.0.1684305838473;
        Tue, 16 May 2023 23:43:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f2-20020a1cc902000000b003f50237bd9csm1176690wmb.19.2023.05.16.23.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:43:56 -0700 (PDT)
Date:   Wed, 17 May 2023 09:43:53 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [cocci] [PATCH] firmware: ti_sci: Fix exception handling in
 ti_sci_probe()
Message-ID: <afe15264-c05c-417c-9492-29b271e05747@kili.mountain>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
 <f1eaec48-cabb-5fc6-942b-f1ef7af9bb57@web.de>
 <20230516152043.bq2hnessstrhbc6s@distort>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230516152043.bq2hnessstrhbc6s@distort>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 10:20:43AM -0500, Nishanth Menon wrote:
> On 22:10-20230405, Markus Elfring wrote:
> > Date: Wed, 5 Apr 2023 22:00:18 +0200
> 
> B4 does'nt pick this patch up cleanly. And for some reason, I get
> mangled patch from public-inbox as well :( a clean git-send-email might
> help.
> 

It's an awkward thing.  B4 doesn't work because Markus was banned from
LKML because he doesn't listen to feedback.

> > 
> > The label “out” was used to jump to another pointer check despite of
> 
> Please use " for quotes.
> 
> > the detail in the implementation of the function “ti_sci_probe”
> > that it was determined already that the corresponding variable
> > contained an error pointer because of a failed call of
> > the function “mbox_request_channel_byname”.
> 
> > 
> > * Thus use more appropriate labels instead.
> > 
> > * Delete two redundant checks.
> > 
> 
> How about this:
> 
> Optimize out the redundant pointer check in exit path of "out" using
> appropriate labels to jump in the error path
> > 
> Drop the extra EoL
> 
> > This issue was detected by using the Coccinelle software.
> 
> Curious: what rule of coccicheck caught this?
> 
> > 
> > Fixes: aa276781a64a5f15ecc21e920960c5b1f84e5fee ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
> 
> 12 char sha please. Please read Documentation/process/submitting-patches.rst
> 

For example, Markus has been told to use 12 char shas several times
before.

> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  drivers/firmware/ti_sci.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> > index 039d92a595ec..77012d2f4160 100644
> > --- a/drivers/firmware/ti_sci.c
> turns out as =2D-- instead of -- (might check the git format-patch
> output closer).
> 
> > +++ b/drivers/firmware/ti_sci.c
> > @@ -3433,18 +3433,18 @@ static int ti_sci_probe(struct platform_device *pdev)
> >  	info->chan_rx = mbox_request_channel_byname(cl, "rx");
> >  	if (IS_ERR(info->chan_rx)) {
> >  		ret = PTR_ERR(info->chan_rx);
> > -		goto out;
> > +		goto remove_debugfs;
> >  	}
> > 
> >  	info->chan_tx = mbox_request_channel_byname(cl, "tx");
> >  	if (IS_ERR(info->chan_tx)) {
> >  		ret = PTR_ERR(info->chan_tx);
> > -		goto out;
> > +		goto free_mbox_channel_rx;
> >  	}
> >  	ret = ti_sci_cmd_get_revision(info);
> >  	if (ret) {
> >  		dev_err(dev, "Unable to communicate with TISCI(%d)\n", ret);
> > -		goto out;
> > +		goto free_mbox_channel_tx;
> >  	}
> > 
> >  	ti_sci_setup_ops(info);
> > @@ -3456,7 +3456,7 @@ static int ti_sci_probe(struct platform_device *pdev)
> >  		ret = register_restart_handler(&info->nb);
> >  		if (ret) {
> >  			dev_err(dev, "reboot registration fail(%d)\n", ret);
> > -			goto out;
> > +			goto free_mbox_channel_tx;
> >  		}
> >  	}
> > 
> > @@ -3470,11 +3470,12 @@ static int ti_sci_probe(struct platform_device *pdev)
> >  	mutex_unlock(&ti_sci_list_mutex);
> > 
> >  	return of_platform_populate(dev->of_node, NULL, NULL, dev);

There is a bug here because the resources are not freed if
of_platform_populate() fails.  The "info" struct is devm_ allocated but
it's still on the &ti_sci_list list, so that will lead to a use after
free.

regards,
dan carpenter

> > -out:
> > -	if (!IS_ERR(info->chan_tx))
> > -		mbox_free_channel(info->chan_tx);
> > -	if (!IS_ERR(info->chan_rx))
> > -		mbox_free_channel(info->chan_rx);
> > +
> > +free_mbox_channel_tx:
> > +	mbox_free_channel(info->chan_tx);
> > +free_mbox_channel_rx:
> > +	mbox_free_channel(info->chan_rx);
> > +remove_debugfs:
> >  	debugfs_remove(info->d);
> >  	return ret;
> >  }

