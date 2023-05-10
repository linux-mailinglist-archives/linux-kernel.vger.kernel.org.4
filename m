Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852D96FDF19
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbjEJNtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbjEJNtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:49:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1F049D9;
        Wed, 10 May 2023 06:49:11 -0700 (PDT)
Date:   Wed, 10 May 2023 13:49:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683726550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3CUVMRHP/ypNgb8JPhTrDX1Fy7uqajPDfdvFNptxK8=;
        b=afQZlGc7k86PSie8RsYEHgo4OhO6gT2JAgL9h2K3hj/EandjRv7FLjbwK7OpA9MQxPsOdd
        /bcmzmsEOIKnFM9Vt5YfRJiTVf1Zx64uWjN8cA6uTXRycqtokT2v7mKMlRbjxdeppD7hUt
        X4+hZmGRvRs3tlyauTU6xIMeeTjeKqjj7fjGQO8rfqg98uhVeENQW6JcHhUWLhUGzFW7uO
        xBJ5E89M5H6W2/i/GHE57N/Aw8ah7t+1x4ViZodYxATp6R+O1+jS5zOAffXmZDDvjQaTA4
        dUzL6k4i3lD+nvYXyuhKZhHNzhPylP0TwNyMneKuIyNWeUb47+hUqA4hXyL7RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683726550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3CUVMRHP/ypNgb8JPhTrDX1Fy7uqajPDfdvFNptxK8=;
        b=aEMEgFV8FFa/aYOdgsymqSz8KzJwB0IPxmCCzoUVtDf1vMkVrza9q5On3P6zZRYvg8NWNc
        U0I+b+tqt0RJcgCQ==
From:   "tip-bot2 for Chen Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/sched: Add the SD_ASYM_PACKING flag to the die
 domain of hybrid processors
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230406203148.19182-13-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-13-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168372655018.404.15652276815766387273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     044f0e27dec6e30bb8875a4a12c5f2594964e93f
Gitweb:        https://git.kernel.org/tip/044f0e27dec6e30bb8875a4a12c5f2594964e93f
Author:        Chen Yu <yu.c.chen@intel.com>
AuthorDate:    Thu, 06 Apr 2023 13:31:48 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:38 +02:00

x86/sched: Add the SD_ASYM_PACKING flag to the die domain of hybrid processors

Intel Meteor Lake hybrid processors have cores in two separate dies. The
cores in one of the dies have higher maximum frequency. Use the SD_ASYM_
PACKING flag to give higher priority to the die with CPUs of higher maximum
frequency.

Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230406203148.19182-13-ricardo.neri-calderon@linux.intel.com
---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a335abd..34066f6 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -583,7 +583,7 @@ static struct sched_domain_topology_level x86_hybrid_topology[] = {
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
 #endif
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ cpu_cpu_mask, x86_sched_itmt_flags, SD_INIT_NAME(DIE) },
 	{ NULL, },
 };
 
