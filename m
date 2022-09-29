Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B575EF744
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbiI2ONM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiI2ONG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:13:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DFD1B85D7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:13:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664460784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U6eCrG1bH2S5fazyYRexbB2EWVUobKqy0ORHgIDtUYs=;
        b=2g6I7PM7tVIp0xbIrsWRmMwSlnQSNBLRAtDvVxGvExqAsBrGpQzn7MU/FpE3DOEemN899Z
        zcDBfbuXSdNPC83MBHqfUkpVQ7fu3VMOgYKUadQ+vjYZ2OAz1xjAp9e9QC5OQkzRVFgo9O
        jJwFB7tNqtfRgXt5dUdcLaI4meMSFqoapyBbehk3304QKYdnnAEuA5TekI0Jz55QL3JSDc
        1h1IVon9JkkT9y4wlyEiJ8bR9SK4uDV4yLs0nML54GpqErdpGulhsQ3Rze0vsn+obQbFvA
        ItRD+EVC/YDU8vkW0kGiwasvUu2QNAKVUb2/ZB8XvZoVyAMM2+Gs9k7CfGz6Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664460784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U6eCrG1bH2S5fazyYRexbB2EWVUobKqy0ORHgIDtUYs=;
        b=jncNNLCbNfH8hPTqrL9DjDR3m8DpnXXaYuiHXNE0yLH7NCPMzcboRdAHe6567mUYhzlxud
        L94aX1AGNyN7fKDw==
To:     Conor Dooley <conor.dooley@microchip.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Conor Dooley <conor@kernel.org>, senozhatsky@chromium.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [resend][bug] low-probability console lockups since 5.19
In-Reply-To: <YzV40LbMHcW1S/9O@wendy>
References: <Yy3dsSgpDnovBdEn@spud> <YzR8fzyjhggO+/tT@spud>
 <98f62903-3d6f-30b4-82ef-3b0460824907@leemhuis.info>
 <YzVlYaUPcRmlfE7c@wendy> <YzVvl+rv3iZS9vxk@alley> <YzV40LbMHcW1S/9O@wendy>
Date:   Thu, 29 Sep 2022 16:19:03 +0206
Message-ID: <877d1m46c0.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-29, Conor Dooley <conor.dooley@microchip.com> wrote:
> I will, possibly tonight but probably not, run the bisection again
> with the threaded printer merge reverted. Hopefully it is not filled
> with conflicts if I go that way...

It might be easier for you to just apply the following patch to run your
tests . This simple patch disables kthread usage.

John Ogness


diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b095fb5f5f61..9679887c0805 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3605,6 +3605,10 @@ static int __init printk_activate_kthreads(void)
 {
 	struct console *con;
 
+	/* hack: never activate kthreads */
+	if (!printk_kthreads_available)
+		return 0;
+
 	console_lock();
 	printk_kthreads_available = true;
 	for_each_console(con)
