Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25226ABA22
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCFJlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCFJlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:41:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E3323317
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:41:13 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678095672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BOrGTM7BDYE8QZ2J/VBzKXeTEqRBMGFOKicW/V1olgY=;
        b=YVXCXkGKBZXVVczCkr2vnhgv9hPBD3lFgSZbudMoHlgQ4aioGpCVxmflaqatuNknTHydCJ
        Fa8oKMGiUhncuietpVmVYAUwzbwZvpMP8W/lFr0LxCQ2f4xD8mQKuJprsLKFTKB5sHGMNR
        4tHn/I9wDaq0uF7XTcwA0aq8jhy7Zqjh5dDD/Ejk0nlMxzFzO5W4+a+Gxvv7WnPyliEh3F
        Q6/q8tPWzF5OOy/vA2IuixuobYvve7epbYL2zZAumbDdvhW6pKHcqeXY0QMVOob4odzXz3
        gy6NKmct0+Q5P1clwEhKm0sh0fW6FytoiX7/zLWG3yHi1N8DrPIKroH4Ho4HqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678095672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BOrGTM7BDYE8QZ2J/VBzKXeTEqRBMGFOKicW/V1olgY=;
        b=C9qOtz+Vf/cuqF9x3+Ppea29gy638cVUztFw2HWaFfNwI5nXLdnDEkYG5nvDxkTjOZsKmC
        eA9W/c4vr0ZtINAA==
To:     Dan Carpenter <error27@gmail.com>, oe-kbuild@lists.linux.dev,
        Petr Mladek <pmladek@suse.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 06/18] printk: nobkl: Add acquire/release logic
In-Reply-To: <0a7e5230-3a8d-496a-a42b-bda2dc82ea9a@kili.mountain>
References: <0a7e5230-3a8d-496a-a42b-bda2dc82ea9a@kili.mountain>
Date:   Mon, 06 Mar 2023 10:45:46 +0106
Message-ID: <87356i2p7h.fsf@jogness.linutronix.de>
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

On 2023-03-06, Dan Carpenter <error27@gmail.com> wrote:
> smatch warnings:
> kernel/printk/printk_nobkl.c:391 cons_try_acquire_spin() warn: signedness bug returning '(-16)'

Great catch. That function used to return bool, but recently changed to
int. The consequence of the bug is that a waiter could prematurely abort
the spin.

diff --git a/kernel/printk/printk_nobkl.c b/kernel/printk/printk_nobkl.c
index 78136347a328..bcd75e5bd9c8 100644
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -305,7 +305,7 @@ static bool cons_setup_request(struct cons_context *ctxt, struct cons_state old)
  * handover request setup by cons_setup_handover() is now invalidated and
  * must be performed again).
  */
-static bool cons_try_acquire_spin(struct cons_context *ctxt)
+static int cons_try_acquire_spin(struct cons_context *ctxt)
 {
 	struct console *con = ctxt->console;
 	struct cons_state cur;
