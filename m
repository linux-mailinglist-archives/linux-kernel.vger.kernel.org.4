Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D676D2E97
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 08:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjDAGdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 02:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDAGdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 02:33:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211081D85C;
        Fri, 31 Mar 2023 23:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1B8EB832B2;
        Sat,  1 Apr 2023 06:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0847EC433EF;
        Sat,  1 Apr 2023 06:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680330819;
        bh=d70Vp8SNdPL0Uf4Gb8aXU2perlHFjj5G3Axx7WjxzYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+ZuQgTCa5Qmy2Rxm6+7EV+2kGx6gz+OrviWZhznK9QTPAgPROVDCdahjcBYKZF+w
         3kbqR1cdVu8dDF1pZ6Hn68yv5PgsOr8FQs7eKCUi0DLzabBmRrg04o8BBe3Ll8+N74
         yQc/lyhvny53egzpRPxslwHxFR+zDizHpJIuL870=
Date:   Sat, 1 Apr 2023 08:33:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hannes Reinecke <hare@suse.de>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>, linux-mmc@vger.kernel.org
Subject: Re: BUG FIX: [PATCH RFC v3] memstick_check() memleak in kernel
 6.1.0+ introduced pre 4.17
Message-ID: <ZCfQQDkw3D_BXJaZ@kroah.com>
References: <7d873dd3-9bab-175b-8158-c458b61a7122@alu.unizg.hr>
 <f74219a7-1607-deb4-a6ae-7b73e2467ac7@alu.unizg.hr>
 <df560535-2a8e-de21-d45d-805159d70954@alu.unizg.hr>
 <2023033124-causing-cassette-4d96@gregkh>
 <4d80549f-e59d-6319-07fd-1fbed75d7a1c@alu.unizg.hr>
 <ZCfO90WwyS6JwaHi@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCfO90WwyS6JwaHi@kroah.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 08:28:07AM +0200, Greg KH wrote:
> On Sat, Apr 01, 2023 at 08:23:26AM +0200, Mirsad Goran Todorovac wrote:
> > > This patch is implying that anyone who calls "dev_set_name()" also has
> > > to do this hack, which shouldn't be the case at all.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > This is my best guess. Unless there is dev_free_name() or kobject_free_name(), I don't
> > see a more sensible way to patch this up.
> 
> In sleeping on this, I think this has to move to the driver core.  I
> don't understand why we haven't seen this before, except maybe no one
> has really noticed before (i.e. we haven't had good leak detection tools
> that run with removable devices?)
> 
> Anyway, let me see if I can come up with something this weekend, give me
> a chance...

Wait, no, this already should be handled by the kobject core, look at
kobject_cleanup(), at the bottom.  So your change should be merely
duplicating the logic there that already runs when the struct device is
freed, right?

So I don't understand why your change works, odd.  I need more coffee...

thanks,

greg k-h
