Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABC470EB1C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjEXCJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbjEXCJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:09:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463CE13E;
        Tue, 23 May 2023 19:09:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d341bdedcso210483b3a.3;
        Tue, 23 May 2023 19:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684894189; x=1687486189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xKPIWA3CAjuMGYvOhL97tRnA9pPRqPJKuzf3V63NRY=;
        b=jVPY7/7rj2VJmjL48Bq/sr3r4+FGL5pN9llKFBU1e4HJycT0CqZBJm0KMddUTJGJl9
         oS4DDH4gy3U565k09m5mEnDRTlt92Tf9aXotRZILJiuPKKwhvQp0DOhW1LwunqNEWtgm
         MRG4BZfC6CbKbzzNLEp7psgoqTZ3EZcBhE5kZatmF/EehDn/2uFFooigkrIIgSvxLjfS
         F2TF/fvs2U5fHB0qomdQz6Rwy+B+o8ZZHTkhJpP3LiWdx4dTkls+vLcWrJcWfRY3+60l
         zPBTUTm1tGbJJF/XbXBCy6AP5qpwByJJWamc8o+0tVySHBtSrKt4imq80nncY3jbQClW
         5Shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684894189; x=1687486189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xKPIWA3CAjuMGYvOhL97tRnA9pPRqPJKuzf3V63NRY=;
        b=iw7xo1N0zNL18DRD+OIgnXk4IOHHpatgXYqVZtwnieojxpREc1rUn7BAVMz38c119/
         zm6zR7J65oTCGuNToLb9Fdv4Ihxc/w8fVnAwdAvIrOxyP3RSFTRWJYdotc+I6riwSWYv
         FGmIj2hi7vl7JgXYo2CzND7FBlZfF7kl5CXuVCRfwMtM2Tf2zs0ygsSv6PqmV7d/sGHP
         WXd/uw5bttHbV6vXuukMy8ihYvoCd/RkecSSKb5RafH90ve0fBlMB1ic4Tf1XV6g4Wly
         TRdFSwviU5f5zNa/TXjOobNW/p9LH9koqV2mEWbpPB3bO2RdO657sLPUc0h4tAtz1vOQ
         BLkQ==
X-Gm-Message-State: AC+VfDzsB7314+G3hq9v33MPGRLNhr83ntHf27iTHiCa0AWa8WTu43OI
        gvakrML+a2emKrZEvNxk8Zc=
X-Google-Smtp-Source: ACHHUZ5aB+GmqMyvL5WJGJQQbnrJ2MYFD3V6qfthFIKJZb0yfHL6+I2CLd8enAO3Y9Wk2Ps3CEST/w==
X-Received: by 2002:a05:6a21:9008:b0:101:3112:c839 with SMTP id tq8-20020a056a21900800b001013112c839mr11920525pzb.15.1684894188541;
        Tue, 23 May 2023 19:09:48 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id p9-20020a654909000000b005348af1b84csm5936310pgs.74.2023.05.23.19.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 19:09:48 -0700 (PDT)
Date:   Wed, 24 May 2023 10:09:42 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: cdev: fix a crash on line-request release
Message-ID: <ZG1x5pcyTN2Fio4J@sol>
References: <20230523155101.196853-1-brgl@bgdev.pl>
 <ZG1TLBsOy4mZQlW3@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG1TLBsOy4mZQlW3@sol>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 07:58:36AM +0800, Kent Gibson wrote:
> On Tue, May 23, 2023 at 05:51:01PM +0200, Bartosz Golaszewski wrote:
> > When a GPIO device is forcefully unregistered, we are left with an
> > inactive object. If user-space kept an open file descriptor to a line
> > request associated with such a structure, upon closing it, we'll see the
> > kernel crash due to freeing unexistent GPIO descriptors.
> > 
> 
> > @@ -1565,17 +1571,21 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
> >  
> >  static void linereq_free(struct linereq *lr)
> >  {
> > +	struct gpio_device *gdev = lr->gdev;
> >  	unsigned int i;
> >  
> >  	for (i = 0; i < lr->num_lines; i++) {
> >  		if (lr->lines[i].desc) {
> >  			edge_detector_stop(&lr->lines[i]);
> > -			gpiod_free(lr->lines[i].desc);
> > +			down_write(&gdev->sem);
> > +			if (gdev->chip)
> > +				gpiod_free(lr->lines[i].desc);
> > +			up_write(&gdev->sem);

Ummm, taking another look at the oops I sent you, the crash actually
occurs in edge_detector_stop():

May 23 11:47:06 firefly kernel: [ 4216.877056] Call Trace:
May 23 11:47:06 firefly kernel: [ 4216.877512]  <TASK>
May 23 11:47:06 firefly kernel: [ 4216.877924]  irq_domain_deactivate_irq+0x19/0x30
May 23 11:47:06 firefly kernel: [ 4216.878543]  free_irq+0x257/0x360
May 23 11:47:06 firefly kernel: [ 4216.879056]  linereq_free+0x9b/0xe0
May 23 11:47:06 firefly kernel: [ 4216.879608]  linereq_release+0xc/0x20
May 23 11:47:06 firefly kernel: [ 4216.880230]  __fput+0x87/0x240
May 23 11:47:06 firefly kernel: [ 4216.880744]  task_work_run+0x54/0x80

That free_irq() call is in edge_detector_stop() (which apparently is inlined),
not in gpiod_free().

So pretty sure this patch doesn't even solve my problem, but I will test
it to confirm.

Cheers,
Kent.
