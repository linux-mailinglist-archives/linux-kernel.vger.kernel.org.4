Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48D85B4A93
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiIJW2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiIJW1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:27:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27CB38454
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:41 -0700 (PDT)
Message-ID: <20220910222300.641069948@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Op91FjKbY7zuuyXzPveWYDshKfFSBgIymEIf7Nbwy78=;
        b=p3epJnlAok0bykrF/9hop/Y4Gc4YEycgVLrQfbxVRktkx0Zy+r+bknnbQeso6VCN+Jh87E
        np1+sMZajRr5bqSCzDAwof2POu5DN0TGAFy40z8uOxXeGgPpDIcQojCrkxvhGLrOAXmzJV
        nXgzqfGcvSAmomI4qgGpShpkPWjp6D66Dp+0RDIfWGbS6Z2BglDUY3ev+18yseWdd9AZ88
        DSTmxslCMEUXLrjciMj45ZyMoMNTIDBxVAlacl4GAyYPYit227inbiIyDpWfmONX9GAZlD
        6cMYszFbguLcbs1CG0UPrT+4+PC2jK4or7HhMmHhlashOWRxhgdUVRxapZ7cDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Op91FjKbY7zuuyXzPveWYDshKfFSBgIymEIf7Nbwy78=;
        b=7LIdKBipkXx6981nWNV+4x5sokZ3n0m+LQsMZCqVNXTlsqk/miZwa3CcgaI2vkYA9rKBTM
        VidiF4MGpgNQD/Bw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [patch RFC 05/29] printk: Mark __printk percpu data ready __ro_after_init
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:39 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable cannot change post boot.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/printk/printk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -430,7 +430,7 @@ static struct printk_ringbuffer *prb = &
  * per_cpu_areas are initialised. This variable is set to true when
  * it's safe to access per-CPU data.
  */
-static bool __printk_percpu_data_ready __read_mostly;
+static bool __printk_percpu_data_ready __ro_after_init;
 
 bool printk_percpu_data_ready(void)
 {

