Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12321671BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjARMRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjARMQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:16:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DEC87676;
        Wed, 18 Jan 2023 03:38:05 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:38:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674041884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BcUQYZ96tFsTx3Oz80QuQtPOfWnxr0yC84im1agAA+k=;
        b=BrL/+FfWHb6bHdp0UDwZkltDH7K6F9ysc9A3rMd5/OBa0EzZxnwkmPRaLaeE8sqqWI2bhm
        ztckiwgkOWvhzoNsFn702imTDgveIdE/fxespoy67R38DPTAzKBqMp0eROBZR4hb40FzIw
        Gf17766qd1zaxyQPUDtv7XxRfyFhk9ndiTwJQu1he5EeALX5KDAkqg+CL1OqfKRYnu/XXg
        lfLSRwJyBfmonDWOAoZUa/0cLeTTC6EvVVnmkw7PueRyNgSEn0HMtv1Fz3AeghqMF74kUn
        9V294iS5SbGW+/icr0/BJ87HsxOzPLAPv075a61qcCpKoa1cFzbkUfKzgE+IHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674041884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BcUQYZ96tFsTx3Oz80QuQtPOfWnxr0yC84im1agAA+k=;
        b=Uy83QisAqHn08tZVOI/xVxgmvPCRkFKR/ZIggtTEHMKEQJ6wxWP9ObsMMQCtvxwsKuVBIJ
        IrxHDiYoXkiXtqDg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle: mvebu: Fix duplicate flags assignment
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230117164642.1672784-1-arnd@kernel.org>
References: <20230117164642.1672784-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <167404188365.4906.1521700530191201209.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3b8645e9ec7eb42e7df7a367d6787a3af53f37a9
Gitweb:        https://git.kernel.org/tip/3b8645e9ec7eb42e7df7a367d6787a3af53f37a9
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 17 Jan 2023 17:46:35 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Jan 2023 12:03:54 +01:00

cpuidle: mvebu: Fix duplicate flags assignment

The added '.flags' value is sometimes ignored here because
it gets overwritten by another initialization:

  drivers/cpuidle/cpuidle-mvebu-v7.c:24:33: error: initialized field overwritten [-Werror=override-init]
     24 | #define MVEBU_V7_FLAG_DEEP_IDLE 0x10000
        |                                 ^~~~~~~
  drivers/cpuidle/cpuidle-mvebu-v7.c:69:43: note: in expansion of macro 'MVEBU_V7_FLAG_DEEP_IDLE'
  ...

Merge the two fields into one.

Fixes: 4ce40e9dbe83 ("cpuidle, armada: Push RCU-idle into driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230117164642.1672784-1-arnd@kernel.org
---
 drivers/cpuidle/cpuidle-mvebu-v7.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
index 114bd09..563dba6 100644
--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -52,21 +52,20 @@ static struct cpuidle_driver armadaxp_idle_driver = {
 	.name			= "armada_xp_idle",
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
-		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 100,
 		.power_usage		= 50,
 		.target_residency	= 1000,
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.name			= "MV CPU IDLE",
 		.desc			= "CPU power down",
 	},
 	.states[2]		= {
-		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 1000,
 		.power_usage		= 5,
 		.target_residency	= 10000,
-		.flags			= MVEBU_V7_FLAG_DEEP_IDLE,
+		.flags			= MVEBU_V7_FLAG_DEEP_IDLE | CPUIDLE_FLAG_RCU_IDLE,
 		.name			= "MV CPU DEEP IDLE",
 		.desc			= "CPU and L2 Fabric power down",
 	},
@@ -77,12 +76,11 @@ static struct cpuidle_driver armada370_idle_driver = {
 	.name			= "armada_370_idle",
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
-		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 100,
 		.power_usage		= 5,
 		.target_residency	= 1000,
-		.flags			= MVEBU_V7_FLAG_DEEP_IDLE,
+		.flags			= MVEBU_V7_FLAG_DEEP_IDLE | CPUIDLE_FLAG_RCU_IDLE,
 		.name			= "Deep Idle",
 		.desc			= "CPU and L2 Fabric power down",
 	},
@@ -93,11 +91,11 @@ static struct cpuidle_driver armada38x_idle_driver = {
 	.name			= "armada_38x_idle",
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
-		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 10,
 		.power_usage		= 5,
 		.target_residency	= 100,
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.name			= "Idle",
 		.desc			= "CPU and SCU power down",
 	},
