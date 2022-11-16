Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AE062BB62
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbiKPLUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiKPLU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:20:26 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733A640472;
        Wed, 16 Nov 2022 03:08:06 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z18so25999653edb.9;
        Wed, 16 Nov 2022 03:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRqWOgr29xDH1fYV3Mu2fM7aLIITb2J/GYz8FCJV65E=;
        b=gtG9J7BA9XWVdr9tol2qm5EP6jmQ/1HH87PMu86DaksArOQ+LoH/RZZKt0ylLe7FFx
         bdX1zvmpuCv9p/I01pBta88mj/spOAFec60VsIiIthH+hDlucAPTqbbXVVJ6GCXd6NIv
         KmQ0Kjye/VGm9NRRYdVRjZc4p85irx8BxzbX0YfrlXOnCU2IB4zRE7+JOCvkW4akm0XW
         5V8bh0wSRvcf50xUnOYmVb3WtoXKSOvBDQfzj/yVgnQMnpHI9fcDCdbahXU+NUrGss+0
         TnzQ7XCkNhNTjpWi5YK4B+h8UiZvFcOCkrSo+pDCiBWOwtSRi76udWZag3EkgA+s0C92
         bV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRqWOgr29xDH1fYV3Mu2fM7aLIITb2J/GYz8FCJV65E=;
        b=AaJs+cIs0lTM82QM2YA0qdE02ihwy/jzNpZjQs0pqDm0f+pZBszY8RdzYuWjn564Ff
         NKGOYvlf9GKLrk1pXpT3ZPoJKABp1siVu5dwYjiGdthDNzjRAa4cW66RvRght9k1f8Os
         XQMekwpro5jgXeP3yQ8FmBKmRiKhmyn3ja1rxLbiNW4qHGzc+y05tukO3CoRS8NxJgLQ
         2gCHzf1sEWhQw/rc0ivGFXAA0k+mc33rs4jMud/xDaHdUxCYUWKcqYou2dflOz8kLujx
         NZAHSx7dyICVP8C2CUyQem4MXZA5gs0fBTUS6IP/afDFUl/bdHgt7GfeBbBYeOk8XQGP
         JEog==
X-Gm-Message-State: ANoB5pl5cZhzY1GoK7uptQz7WkaokjKfUo8plnEoCGuCYYsOrsvCGLTD
        vSMgB9W50TrDl18UNnHyYwI=
X-Google-Smtp-Source: AA0mqf45qDgc3IPPx3lojwVTXi94BAukTNO9gHkyqFQHU2wZZtQTFcmJGcv11DHLohVzrnQd4OQQlQ==
X-Received: by 2002:aa7:c2c4:0:b0:459:1788:5e49 with SMTP id m4-20020aa7c2c4000000b0045917885e49mr18411373edp.321.1668596884888;
        Wed, 16 Nov 2022 03:08:04 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0073d9a0d0cbcsm6686577ejf.72.2022.11.16.03.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:08:04 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id C1DF1BE2DE0; Wed, 16 Nov 2022 12:08:03 +0100 (CET)
Date:   Wed, 16 Nov 2022 12:08:03 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hyunwoo Kim <imv4bel@gmail.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dvb-core: Fix UAF due to refcount races at
 releasing
Message-ID: <Y3TEk7Nr3yAQIozQ@eldamar.lan>
References: <20220908132754.30532-1-tiwai@suse.de>
 <87sfklgozd.wl-tiwai@suse.de>
 <87k056dekm.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k056dekm.wl-tiwai@suse.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 11, 2022 at 09:06:33AM +0200, Takashi Iwai wrote:
> On Wed, 21 Sep 2022 09:34:30 +0200,
> Takashi Iwai wrote:
> > 
> > On Thu, 08 Sep 2022 15:27:54 +0200,
> > Takashi Iwai wrote:
> > > 
> > > The dvb-core tries to sync the releases of opened files at
> > > dvb_dmxdev_release() with two refcounts: dvbdev->users and
> > > dvr_dvbdev->users.  A problem is present in those two syncs: when yet
> > > another dvb_demux_open() is called during those sync waits,
> > > dvb_demux_open() continues to process even if the device is being
> > > closed.  This includes the increment of the former refcount, resulting
> > > in the leftover refcount after the sync of the latter refcount at
> > > dvb_dmxdev_release().  It ends up with use-after-free, since the
> > > function believes that all usages were gone and releases the
> > > resources.
> > > 
> > > This patch addresses the problem by adding the check of dmxdev->exit
> > > flag at dvb_demux_open(), just like dvb_dvr_open() already does.  With
> > > the exit flag check, the second call of dvb_demux_open() fails, hence
> > > the further corruption can be avoided.
> > > 
> > > Also for avoiding the races of the dmxdev->exit flag reference, this
> > > patch serializes the dmxdev->exit set up and the sync waits with the
> > > dmxdev->mutex lock at dvb_dmxdev_release().  Without the mutex lock,
> > > dvb_demux_open() (or dvb_dvr_open()) may run concurrently with
> > > dvb_dmxdev_release(), which allows to skip the exit flag check and
> > > continue the open process that is being closed.
> > > 
> > > Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > 
> > Any review on this?
> > 
> > FWIW, now CVE-2022-41218 is assigned for those bugs as a security
> > issue.
> 
> A gentle ping again.
> 
> Or if any other fix for this security issue is already available,
> please let me know.

is this correct, the fix is yet missing (or was it fixed by other
means?).

Regards,
Salvatore

> > 
> > > ---
> > >  drivers/media/dvb-core/dmxdev.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
> > > index f6ee678107d3..9ce5f010de3f 100644
> > > --- a/drivers/media/dvb-core/dmxdev.c
> > > +++ b/drivers/media/dvb-core/dmxdev.c
> > > @@ -790,6 +790,11 @@ static int dvb_demux_open(struct inode *inode, struct file *file)
> > >  	if (mutex_lock_interruptible(&dmxdev->mutex))
> > >  		return -ERESTARTSYS;
> > >  
> > > +	if (dmxdev->exit) {
> > > +		mutex_unlock(&dmxdev->mutex);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > >  	for (i = 0; i < dmxdev->filternum; i++)
> > >  		if (dmxdev->filter[i].state == DMXDEV_STATE_FREE)
> > >  			break;
> > > @@ -1448,7 +1453,10 @@ EXPORT_SYMBOL(dvb_dmxdev_init);
> > >  
> > >  void dvb_dmxdev_release(struct dmxdev *dmxdev)
> > >  {
> > > +	mutex_lock(&dmxdev->mutex);
> > >  	dmxdev->exit = 1;
> > > +	mutex_unlock(&dmxdev->mutex);
> > > +
> > >  	if (dmxdev->dvbdev->users > 1) {
> > >  		wait_event(dmxdev->dvbdev->wait_queue,
> > >  				dmxdev->dvbdev->users == 1);
> > > -- 
> > > 2.35.3
> > > 
> 
