Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCF5721258
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjFCUH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjFCUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:07:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF540E6E
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:07:24 -0700 (PDT)
Message-ID: <20230603200459.657036052@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685822817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OuVg+D0jb4HgNSp9ye4aSRcei5b/KvEx573nuovh52M=;
        b=2c8fwqxhQVPxRmc3T8a6DTenMMCD77hCal25+SdWF5dospABEuvQdNa7fPQ200NSevXmyM
        2bDOr9OSVJYCqteJH5Z+xRmCIOVx3922ppsxRicluntiRO3yPjnPA0Yl+3oRiY2Hh6ni4F
        pNJH/J8rkLA8watPvcCHMG2tj2xVutVwgAQ0ietWzQyg3zIv455V6Yg4emvRqH6IbPolyq
        hkOs04DC1n0f2IrBNjmVvl0BT9wknSawj9wG6YB/6ocgtaZxkpMw02/TqpAGZuH0SAWKhz
        YJUaMh0n3ZEwmv2cxXw/MSLlmL2nml5smSvYPiRJuKJ9JComN1YswOAv9Oqhyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685822817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OuVg+D0jb4HgNSp9ye4aSRcei5b/KvEx573nuovh52M=;
        b=LxAcG02Z6CBSPAUoOkIBhVDAchgubOdBNxyjsaJizVfW84GwfH0L7pCA0KKKeVC9waPHh9
        0B2NSgeAuIKCbKCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [patch 1/6] x86/smp: Remove pointless wmb() from native_stop_other_cpus()
References: <20230603193439.502645149@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat,  3 Jun 2023 22:06:56 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wmb() after the successfull atomic_cmpxchg() is complete voodoo along
with the comment stating "sync above data before sending IRQ".

There is no "above" data except for the atomic_t stopping_cpu which has
just been acquired. The reboot IPI handler does not check any data and
unconditionally disables the CPU.

Remove this cargo cult barrier.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/smp.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -171,9 +171,6 @@ static void native_stop_other_cpus(int w
 		if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
 			return;
 
-		/* sync above data before sending IRQ */
-		wmb();
-
 		apic_send_IPI_allbutself(REBOOT_VECTOR);
 
 		/*

