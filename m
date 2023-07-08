Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E572E74BD73
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 14:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGHMcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 08:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjGHMce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 08:32:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC1B10FF
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hi8xZv3kp+ZMXDHujeHE4MCbxE/IeD639P+0kPjf6lQ=; b=Bb20ypz/EKXowf/2x3o84ZThQF
        c6W5aqRCw9gSxDWAGgd8f29Dq6Y8+N7QZPcE/nyFnUe3hf1BnclGqC7h4DuY4byvnSQGiL+4avXn5
        YRz27j8igvtdDe7fxyD/dYOd1o2jc3UNqVK9UZ+7cNYTwEbmnNKLlF/UmCSDni7Gcobx/Eo9o/ORp
        KJI031XpDVhGMgmni02Kzcicohov5Y6p9VRuPl6KpTtjwydjQvO2C8Ty2mLFyfeGenjF5X5rT3KVj
        TwwVTyBCxjIHfHUWZ0UgPPffpZCI7iZrRmOON6cBwoRhIWeObQuWyfsdYy9y6BBk66OZaiEWhceKH
        fwb1NjBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qI76D-00Ct0m-2S; Sat, 08 Jul 2023 12:31:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFC7D300222;
        Sat,  8 Jul 2023 14:31:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B158224B8B4FF; Sat,  8 Jul 2023 14:31:37 +0200 (CEST)
Date:   Sat, 8 Jul 2023 14:31:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [Patch v3 5/6] sched/x86: Add cluster topology to hybrid CPU
Message-ID: <20230708123137.GB2934075@hirez.programming.kicks-ass.net>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
 <e64678a22c57d572dcac20a0d492d406d56bf881.1688770494.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e64678a22c57d572dcac20a0d492d406d56bf881.1688770494.git.tim.c.chen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 03:57:04PM -0700, Tim Chen wrote:
> From: Tim C Chen <tim.c.chen@linux.intel.com>
> 
> Cluster topology was not enabled on hybrid x86 CPU as load balance
> was not properly working for cluster domain.  That has been fixed and
> cluster domain can be enabled for hybrid CPU.
> 
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>

Yeah, you didn't actually try appling this to something recent did ya
:-)

You missed 8f2d6c41e5a6 ("x86/sched: Rewrite topology setup").

I'll replace this patch with the below.

---
 arch/x86/kernel/smpboot.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ed2d51960a7d..3b751d79cdfb 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -632,14 +632,9 @@ static void __init build_sched_topology(void)
 	};
 #endif
 #ifdef CONFIG_SCHED_CLUSTER
-	/*
-	 * For now, skip the cluster domain on Hybrid.
-	 */
-	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) {
-		x86_topology[i++] = (struct sched_domain_topology_level){
-			cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS)
-		};
-	}
+	x86_topology[i++] = (struct sched_domain_topology_level){
+		cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS)
+	};
 #endif
 #ifdef CONFIG_SCHED_MC
 	x86_topology[i++] = (struct sched_domain_topology_level){
