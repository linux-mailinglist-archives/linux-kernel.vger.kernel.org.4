Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F106E70EC93
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbjEXEgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjEXEgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:36:35 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FAA119;
        Tue, 23 May 2023 21:36:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d30ab1ef2so316099b3a.2;
        Tue, 23 May 2023 21:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684902993; x=1687494993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNmZVzHPNYe1buo3/rEgQ8cLDHfxurxRloet1IrmRds=;
        b=L4ZNDbmvPS1FAsPIRYGUw5AQRalWbg2TPILH73+8JpM+CQetUW2p1P1mBB223wZOl3
         04EUSr7bvYbHd3EZZzsoT0IlOoedu+CnS35UfCUW6wkHNk2wZHs/EGG2Kd2bzmBtH/ba
         sXc4CXREl7blKv0bFoZQmC1SZVldI6x18V5Zq5PtN/WXVfaf8Op4rTChqDE1T5J05MOZ
         iA5pbG4p2pFurimNTz4AfdoOFOdqIuZYQ9y6jdfOslmxOWWTVN+FABDpu5bK0NfUmD4c
         JUvHRrTVRHPeuyv1Ge5CW+iZt6vYVUg8R8TibDM4YV0ZxCq3KN61sQ7MsNJCz+CLcWX2
         4bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684902993; x=1687494993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNmZVzHPNYe1buo3/rEgQ8cLDHfxurxRloet1IrmRds=;
        b=X5X7Z4woIeIZQOLgJt6Nurivwx69f4FpFQMD+mamoQV3fjSvScA+WohECqPsJFv8n1
         qRgXMGvQM1lgUjcrJK/9gs0IbWXmyjVbeaKKBz5NLcpQj8I6s9nzw+JAA+VQGck1/2UT
         SWIeLcKRsYRI3Goiz4Qr0nbFP9CwKfw4n1AwWgu6BF1ztyirNCR1UGFMrNyvKt6yc9nU
         is1juiGy9ancWL5OPkiefV45wvzOJbZDTWsstBdX/y6q6F1YxAgQRdo7YYJ6Ykw6Ipvc
         PCKkuxeDBiovDqasgb6PHRlyGS8FRKYQ+uERn1rAc/iI/H4CnYFTFlRb1gtGP3BeITHI
         qa3Q==
X-Gm-Message-State: AC+VfDyvSpbQH0t7Vrnq/qY/9idqWjcCwqu9V3xu76lJumSoBNr8HZm8
        4pndSMjeNgrY7hMmqMQsNaoRYr+Zx+s=
X-Google-Smtp-Source: ACHHUZ6C9I9ieWwZhGmOZyB7F7NfjBAY3WkQCzbrPBsmhT5owL2Z3FC8rg1+b90cMgVZNg5RetAoSg==
X-Received: by 2002:a05:6a00:1408:b0:64d:2c61:4b1 with SMTP id l8-20020a056a00140800b0064d2c6104b1mr1361439pfu.11.1684902993209;
        Tue, 23 May 2023 21:36:33 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78802000000b006413bf8becesm6532656pfo.63.2023.05.23.21.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 21:36:32 -0700 (PDT)
Date:   Wed, 24 May 2023 12:36:27 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: cdev: fix a crash on line-request release
Message-ID: <ZG2USw7TTdFSRZ3E@sol>
References: <20230523155101.196853-1-brgl@bgdev.pl>
 <ZG1TLBsOy4mZQlW3@sol>
 <ZG1x5pcyTN2Fio4J@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG1x5pcyTN2Fio4J@sol>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 10:09:42AM +0800, Kent Gibson wrote:
> On Wed, May 24, 2023 at 07:58:36AM +0800, Kent Gibson wrote:
> > On Tue, May 23, 2023 at 05:51:01PM +0200, Bartosz Golaszewski wrote:
> > > When a GPIO device is forcefully unregistered, we are left with an
> > > inactive object. If user-space kept an open file descriptor to a line
> > > request associated with such a structure, upon closing it, we'll see the
> > > kernel crash due to freeing unexistent GPIO descriptors.
> > > 
> > 
> > > @@ -1565,17 +1571,21 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
> > >  
> > >  static void linereq_free(struct linereq *lr)
> > >  {
> > > +	struct gpio_device *gdev = lr->gdev;
> > >  	unsigned int i;
> > >  
> > >  	for (i = 0; i < lr->num_lines; i++) {
> > >  		if (lr->lines[i].desc) {
> > >  			edge_detector_stop(&lr->lines[i]);
> > > -			gpiod_free(lr->lines[i].desc);
> > > +			down_write(&gdev->sem);
> > > +			if (gdev->chip)
> > > +				gpiod_free(lr->lines[i].desc);
> > > +			up_write(&gdev->sem);
> 
> Ummm, taking another look at the oops I sent you, the crash actually
> occurs in edge_detector_stop():
> 
> May 23 11:47:06 firefly kernel: [ 4216.877056] Call Trace:
> May 23 11:47:06 firefly kernel: [ 4216.877512]  <TASK>
> May 23 11:47:06 firefly kernel: [ 4216.877924]  irq_domain_deactivate_irq+0x19/0x30
> May 23 11:47:06 firefly kernel: [ 4216.878543]  free_irq+0x257/0x360
> May 23 11:47:06 firefly kernel: [ 4216.879056]  linereq_free+0x9b/0xe0
> May 23 11:47:06 firefly kernel: [ 4216.879608]  linereq_release+0xc/0x20
> May 23 11:47:06 firefly kernel: [ 4216.880230]  __fput+0x87/0x240
> May 23 11:47:06 firefly kernel: [ 4216.880744]  task_work_run+0x54/0x80
> 
> That free_irq() call is in edge_detector_stop() (which apparently is inlined),
> not in gpiod_free().
> 
> So pretty sure this patch doesn't even solve my problem, but I will test
> it to confirm.
> 

Yeah, doesn't fix my problem still crashes.

If the line request doesn't have edge detection enabled (so no
irq) then I don't get a crash.
i.e. use gpioset to request the line, rather than gpiomon.

(To provide background for anyone else trying to follow along, the
scenario is:
1. create a gpio-sim
2. request a line
3. destroy the gpio-sim
4. release the line.

3 triggers this error:

May 24 11:11:12 firefly kernel: [  200.027280] gpio_stub_drv gpiochip0: REMOVING GPIOCHIP WITH GPIOS STILL REQUESTED

and 4 triggers a crash - if the requested line holds an irq.)

I would point out:
/**
 * gpiochip_remove() - unregister a gpio_chip
 * @gc: the chip to unregister
 *
 * A gpio_chip with any GPIOs still requested may not be removed.
 */
void gpiochip_remove(struct gpio_chip *gc)

which is where that dev_crit() is, so destroying the gpio-sim has already
invalidated that contract.

Anyway, it seems my problem is the forced removal of the gpiochip invalidates
the irq that the line request is holding.
Not sure how best to deal with that.

Moving the edge_detector_stop() inside the "if (gdev->chip)" check of
your patch does prevent crash.
But in that case edge_detector_stop() does other cleanup that is no longer
getting done.
Perhaps if the chip is gone then zero line->irq prior to calling
edge_detector_stop()?
Again, this is starting to feel like a hack for gpiolib not being good
at telling the client that it has to pull the rug.
Though according the the gpiochip_remove() docs, it WONT pull the rug,
so you get that.

Cheers,
Kent.
