Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164FB624746
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiKJQnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiKJQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:42:58 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F7445090;
        Thu, 10 Nov 2022 08:42:41 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u6so1811561plq.12;
        Thu, 10 Nov 2022 08:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0Bkeksc+JU6uP4xdShj8Y+HGEDm7CwPTGv2ALxNg04=;
        b=len4gBwN8VHIreknSYmGb2GGStzknWhC+b1LxxOpkclP8nvv/Lo+OTpvyGUr5u/FMq
         wtbFABu69jS+TZSR/LfBPto0lIntB9xIt5716LbqKh67kiqA/2FdRj7/TYsKDrFrj98g
         BbyhTD+ZSs5QHZNvpvBgg9xKZ5toE4xeAs2Xu64nhT6G18y+DfyXvrYLtb+nOoiiPRS5
         /BeCEgnI7LRZvpEQWVnZvVNR+BXTsghJy2aVqghhpkbgpy3Mk2GX/qerLMocLCOekVPK
         v58hrOqEs14H2ISBw0QW5ticHd/oWStfpcQb5QdQFgOwEcP5rgk/GcKjMsN9G2N8rhpE
         e0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0Bkeksc+JU6uP4xdShj8Y+HGEDm7CwPTGv2ALxNg04=;
        b=AtjCWf1kpMUl1KOOvDkRAvskGavomwOEkrcrZrLTeV2qASl/+yYR+w9MpKA2xxG/DT
         PNeDhL7vtn6W0dCiACeGcVICUJBOjqB1KtD5w7/N8akznSvsS/p8PgmUy3i0fUXc6cjR
         FpRhX7qsFlm3rIVRH8GHYVcBTDU+4uMCy8eMsX0r+GudzTw9DRwV/lc9Az7mv3VAr5st
         WNE0pHzJJAsiOh/5UW8btxWNb2m5yLe31uL3QvVFcGKmqDnrBe2rKttuq6Kh7JfRT5un
         egK55AfHN6L4kdwr8ErHfjHj04SfZXG5F7kal2IbI0vAxh/3HH0s26XPbttnPI/sczuz
         voFg==
X-Gm-Message-State: ACrzQf2COvjyZ1H3HDPvB6cFKFMBotou7xvf/qo6JS0Ljv2/Cu4TULZj
        P5LlW3pc4zigdOuSyLzIwS0=
X-Google-Smtp-Source: AMsMyM4cpY+dtldkMz0ZRMnn3uJeMduGWKK1Z5eajCuyhlIP+qwmPxgFQebxNqjLbwO3HjtpbcyjrA==
X-Received: by 2002:a17:90a:5d12:b0:213:c7ce:ea6f with SMTP id s18-20020a17090a5d1200b00213c7ceea6fmr1478606pji.27.1668098561334;
        Thu, 10 Nov 2022 08:42:41 -0800 (PST)
Received: from biggie ([103.230.148.184])
        by smtp.gmail.com with ESMTPSA id d20-20020a170902e15400b00182d25a1e4bsm11374397pla.259.2022.11.10.08.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:42:40 -0800 (PST)
Date:   Thu, 10 Nov 2022 22:12:24 +0530
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     sean@mess.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com
Subject: Re: [PATCH] drivers/media/rc: Fix a race condition in send_packet()
Message-ID: <Y20p8NxOo6GWm4cX@biggie>
References: <20221019050214.107448-1-gautammenghani201@gmail.com>
 <Y19UAV8R4xN7HMAo@biggie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y19UAV8R4xN7HMAo@biggie>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:20:15AM +0530, Gautam Menghani wrote:
> On Wed, Oct 19, 2022 at 10:32:14AM +0530, Gautam Menghani wrote:
> > The function send_packet() has a race condition as follows:
> > func send_packet()
> > {
> >     // do work
> >     call usb_submit_urb()
> >     mutex_unlock()
> >     wait_for_event_interruptible()  <-- lock gone
> >     mutex_lock()
> > }
> > 
> > func vfd_write()
> > {
> >     mutex_lock()
> >     call send_packet()  <- prev call is not completed
> >     mutex_unlock()
> > }
> > 
> > When the mutex is unlocked and the function send_packet() waits for the
> > call to complete, vfd_write() can start another call, which leads to the
> > "URB submitted while active" warning in usb_submit_urb(). 
> > Fix this by removing the mutex_unlock() call in send_packet() and using
> > mutex_lock_interruptible().
> > 
> > Fixes: 21677cfc562a ("V4L/DVB: ir-core: add imon driver")
> > Link: https://syzkaller.appspot.com/bug?id=e378e6a51fbe6c5cc43e34f131cc9a315ef0337e
> > Reported-by: syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com
> > 
> > Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> > ---
> >  drivers/media/rc/imon.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
> > index 735b925da998..91d8056666ec 100644
> > --- a/drivers/media/rc/imon.c
> > +++ b/drivers/media/rc/imon.c
> > @@ -646,15 +646,14 @@ static int send_packet(struct imon_context *ictx)
> >  		pr_err_ratelimited("error submitting urb(%d)\n", retval);
> >  	} else {
> >  		/* Wait for transmission to complete (or abort) */
> > -		mutex_unlock(&ictx->lock);
> >  		retval = wait_for_completion_interruptible(
> >  				&ictx->tx.finished);
> >  		if (retval) {
> >  			usb_kill_urb(ictx->tx_urb);
> >  			pr_err_ratelimited("task interrupted\n");
> >  		}
> > -		mutex_lock(&ictx->lock);
> >  
> > +		ictx->tx.busy = false;
> >  		retval = ictx->tx.status;
> >  		if (retval)
> >  			pr_err_ratelimited("packet tx failed (%d)\n", retval);
> > @@ -955,7 +954,8 @@ static ssize_t vfd_write(struct file *file, const char __user *buf,
> >  	if (ictx->disconnected)
> >  		return -ENODEV;
> >  
> > -	mutex_lock(&ictx->lock);
> > +	if (mutex_lock_interruptible(&ictx->lock))
> > +		return -ERESTARTSYS;
> >  
> >  	if (!ictx->dev_present_intf0) {
> >  		pr_err_ratelimited("no iMON device present\n");
> > -- 
> > 2.34.1
> > 
> 
> Hi,
> 
> Please review the above fix and let me know if any changes are required.
> 
> Thanks,
> Gautam

Hi,

Please review this patch and let me know if this patch needs any changes.

Thanks,
Gautam
