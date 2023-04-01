Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DE56D2F5F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDAJXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDAJXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:23:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D49C17F;
        Sat,  1 Apr 2023 02:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6DFDB80113;
        Sat,  1 Apr 2023 09:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BD8C433EF;
        Sat,  1 Apr 2023 09:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680341019;
        bh=xe2FK0WRlUWJA2rnbwuZibGmIyVYOBezRSeKkD++XF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jROC8P1bz3OzcWhMwxmgit2uWhKMmR27+P6K7rtZX9QFduHqN0vzhmWpvSYdpF1Sp
         BARkmmwTzP1891MJwRZH2OwcuVZKLc773BUAFKMMIQUpt+yUnRzRvu86T8+M3/UaLc
         0LNKzcTU05TfSMmsfTxVMP23aEp7H8cAz/LSFUJc=
Date:   Sat, 1 Apr 2023 11:23:36 +0200
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
Message-ID: <2023040112-immovably-cytoplasm-44ee@gregkh>
References: <7d873dd3-9bab-175b-8158-c458b61a7122@alu.unizg.hr>
 <f74219a7-1607-deb4-a6ae-7b73e2467ac7@alu.unizg.hr>
 <df560535-2a8e-de21-d45d-805159d70954@alu.unizg.hr>
 <2023033124-causing-cassette-4d96@gregkh>
 <4d80549f-e59d-6319-07fd-1fbed75d7a1c@alu.unizg.hr>
 <ZCfO90WwyS6JwaHi@kroah.com>
 <ZCfQQDkw3D_BXJaZ@kroah.com>
 <2023040127-untrue-obtrusive-1ea4@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023040127-untrue-obtrusive-1ea4@gregkh>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 11:18:19AM +0200, Greg KH wrote:
> On Sat, Apr 01, 2023 at 08:33:36AM +0200, Greg KH wrote:
> > On Sat, Apr 01, 2023 at 08:28:07AM +0200, Greg KH wrote:
> > > On Sat, Apr 01, 2023 at 08:23:26AM +0200, Mirsad Goran Todorovac wrote:
> > > > > This patch is implying that anyone who calls "dev_set_name()" also has
> > > > > to do this hack, which shouldn't be the case at all.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > 
> > > > This is my best guess. Unless there is dev_free_name() or kobject_free_name(), I don't
> > > > see a more sensible way to patch this up.
> > > 
> > > In sleeping on this, I think this has to move to the driver core.  I
> > > don't understand why we haven't seen this before, except maybe no one
> > > has really noticed before (i.e. we haven't had good leak detection tools
> > > that run with removable devices?)
> > > 
> > > Anyway, let me see if I can come up with something this weekend, give me
> > > a chance...
> > 
> > Wait, no, this already should be handled by the kobject core, look at
> > kobject_cleanup(), at the bottom.  So your change should be merely
> > duplicating the logic there that already runs when the struct device is
> > freed, right?
> > 
> > So I don't understand why your change works, odd.  I need more coffee...
> 
> I think you got half of the change correctly.  This init code is a maze
> of twisty passages, let me take your patch and tweak it a bit into
> something that I think should work.  This looks to be only a memstick
> issue, not a driver core issue (which makes me feel better.)

Oops, forgot the patch.  Can you try this change here and let me know if
that solves the problem or not?  I have compile-tested it only, so I
have no idea if it works.

If this does work, I'll make up a "real" function to replace the
horrible dev.kobj.name mess that a driver would have to do here as it
shouldn't be required that a driver author knows the internals of the
driver core that well...

thanks,

greg k-h

--------------------


diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index bf7667845459..bbfaf6536903 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -410,6 +410,7 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
 	return card;
 err_out:
 	host->card = old_card;
+	kfree_const(card->dev.kobj.name);
 	kfree(card);
 	return NULL;
 }
@@ -468,8 +469,10 @@ static void memstick_check(struct work_struct *work)
 				put_device(&card->dev);
 				host->card = NULL;
 			}
-		} else
+		} else {
+			kfree_const(card->dev.kobj.name);
 			kfree(card);
+		}
 	}
 
 out_power_off:
