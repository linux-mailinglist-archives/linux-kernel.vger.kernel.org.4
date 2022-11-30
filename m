Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1596163DCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiK3SMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiK3SMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:12:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FADC79
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:12:32 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1E59C1F37C;
        Wed, 30 Nov 2022 18:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669831951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zlPQLAGlmwY4o7JcXhwU2s+c287QM312H56RNlPzmj0=;
        b=hZFtK5YBVVvSh8SP9G3Khp+j+fBLRiAB3Th627uROetC/rhRSvvbIl5UlSZoxPqG6il/ya
        /Nu8ftgObh8FFL3MSKvNoKX0efnnpKKzVu1lYSXBaicHFDzrS1Ta9tML2VuYPEkI5/feE5
        MuB1uIkikpTCCyktZCWkmk4IK+Twd3w=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C74FA2C14F;
        Wed, 30 Nov 2022 18:12:30 +0000 (UTC)
Date:   Wed, 30 Nov 2022 19:12:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     John Ogness <john.ogness@linutronix.de>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [printk] 8fc5f5fc7f:
 WARNING:at_kernel/printk/printk.c:#console_flush_all
Message-ID: <Y4edCzx75AY9b0xS@alley>
References: <202211302326.2915f85f-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211302326.2915f85f-yujie.liu@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-12-01 00:57:06, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed WARNING:at_kernel/printk/printk.c:#console_flush_all due to commit (built with clang-14):
> 
> commit: 8fc5f5fc7f52a733fcc8b3939d172b9248e63871 ("printk: introduce console_list_lock")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> [    0.000000][    T0] ------------[ cut here ]------------
> [ 0.000000][ T0] WARNING: CPU: 0 PID: 0 at kernel/printk/printk.c:116 console_flush_all (printk.c:?) 

When I checked out the commit 8fc5f5fc7f52a733fcc8b3939d172b9248e63871
("printk: introduce console_list_lock") then
kernel/printk/printk.c:116 is:

114	 void lockdep_assert_console_list_lock_held(void)
115	{
116		lockdep_assert_held(&console_mutex);
117	}
118	EXPORT_SYMBOL(lockdep_assert_console_list_lock_held);

It is used in

#define for_each_console(con)						\
	lockdep_assert_console_list_lock_held();			\
	hlist_for_each_entry(con, &console_list, node)

that is used in

static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
{
[...]
		for_each_console(con) {

that is called without console_list_lock().

Hmm, we could not take console_list_lock() here. It would violate lock
ordering. console_flush_all() is called under console_lock(). And
console_list_lock() is taken outside of console_lock() in register_console().

Fortunately, we do not have to do it. for_each_console() is still safe
under console_lock() at this stage. And later patches will switch
it to for_each_console_srcu() that will not require
console_list_lock().

So, the solution is to remove the assert in for_each_console() in
the commit 8fc5f5fc7f52a733fcc8b3939d172b9248e63871 ("printk:
introduce console_list_lock").

We need to add the assert later when removing the console_lock()
synchronization of @console_list in register_console().

Best Regards,
Petr
