Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EE072E2B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbjFMMSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242245AbjFMMSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:18:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C8D10C6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:17:59 -0700 (PDT)
Message-ID: <20230613121615.762734722@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686658678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9CaNHDYSUbbGc4RwsKkuSl3Vh+jfDiEx4Q/XI2wrZ6E=;
        b=g7pEVjNyx6dO3YLmKuqLdZq8xnkl7rWlZCyBJA93QQQoZACRDYPfAvTeUe+3YTMarHIqbI
        EJ/cChZla8NMoXa1u5NftFQndVRHdG0OKh7Cuo3IhGgeU0MJOVTzp4TPVZRPKGge7ym5AD
        mizCvJdQUHiQMQ1cIKFy4LFc2mF0PIO5woL2DcMzi7SMgkPub+aDLW/nbVmEpS5k1q6afR
        ouL16j3drh3EPfcEJ0y4uMP+zhTcb64iTQmNZyVEswNxahdKKtMOjKreAzNBSnEJWBjUka
        geK8Dv0i9mBAIYpZtBWfLRV/VWjhcHgZge8GYANML7K430Q/vhqdg9PCoEfy7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686658678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9CaNHDYSUbbGc4RwsKkuSl3Vh+jfDiEx4Q/XI2wrZ6E=;
        b=FsGtQBIlN01SMmNLlLVp1CCzWGYi9iqlxLiuts/hjVGmofq2C1N4ztCtz0aMmqh4Tri4wm
        AAyVpZsZq/E9uSAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [patch V2 3/8] x86/smp: Remove pointless wmb() from native_stop_other_cpus()
References: <20230613115353.599087484@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 13 Jun 2023 14:17:58 +0200 (CEST)
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
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/smp.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -174,9 +174,6 @@ static void native_stop_other_cpus(int w
 
 		atomic_set(&stop_cpus_count, num_online_cpus() - 1);
 
-		/* sync above data before sending IRQ */
-		wmb();
-
 		apic_send_IPI_allbutself(REBOOT_VECTOR);
 
 		/*

