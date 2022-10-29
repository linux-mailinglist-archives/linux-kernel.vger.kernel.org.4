Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4183E612511
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 21:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJ2TTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 15:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJ2TTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 15:19:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FC463F2;
        Sat, 29 Oct 2022 12:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 79170CE010F;
        Sat, 29 Oct 2022 19:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5793C433C1;
        Sat, 29 Oct 2022 19:19:36 +0000 (UTC)
Date:   Sat, 29 Oct 2022 15:19:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-usb@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [RFC][PATCH v2 20/31] timers: usb: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221029151952.076821f2@gandalf.local.home>
In-Reply-To: <20221029145241.GA3296895@roeck-us.net>
References: <20221027150525.753064657@goodmis.org>
        <20221027150928.983388020@goodmis.org>
        <4e61935b-b06b-1f2d-6c2b-79bdfd569cd6@roeck-us.net>
        <20221028140129.040d9acc@gandalf.local.home>
        <20221028141007.05f5c490@gandalf.local.home>
        <20221028195959.GA1073367@roeck-us.net>
        <20221029145241.GA3296895@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2022 07:52:41 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> With the diffs I sent earlier applied, the warning still seen is
> 
> WARNING: CPU: 0 PID: 9 at lib/debugobjects.c:502 debug_print_object+0xd0/0x100
> ODEBUG: free active (active state 0) object type: timer_list hint: neigh_timer_handler+0x0/0x480
> 
> That happens with almost every test, so I may have missed some others
> in the noise.

Can you add this?

-- Steve

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 3c4786b99907..3e2586c72c7e 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -895,6 +895,8 @@ void neigh_destroy(struct neighbour *neigh)
 	if (neigh_del_timer(neigh))
 		pr_warn("Impossible event\n");
 
+	del_timer_try_shutdown(&neigh->timer);
+
 	write_lock_bh(&neigh->lock);
 	__skb_queue_purge(&neigh->arp_queue);
 	write_unlock_bh(&neigh->lock);
