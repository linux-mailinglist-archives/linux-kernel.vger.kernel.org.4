Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D656F6F9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjEDQLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEDQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:11:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA06F4C24
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683216700; x=1714752700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E4rAAIn8gnIQkYgR+pnMvP2Kv1Kl0qcueSQjiIL0uLg=;
  b=BsA6lh+SwQ4vf4CZecmjYeECNbknBjIF/Dhr/nsnR9mY0T+mHEHtsR2Q
   LKkKWS4LSgZj2or4amj4BXDL8Zbe5MADmA7u23o9bl2Kod7lsJ2agV9Lv
   c49Ff/BUBkdKSPWzt5cj86yn+ddI1lHMq29KV4fK2eRQpFajGGKWlj3hJ
   6DbVUuZJCSGsDPYTKLTqr/RhPT0XzDorZaxe4mxhaHZXh2HwAeapTVZlb
   3HJ2wHKKwrG3eUmqonh7UvSv9Q2qvhkJTvdC2KA7zagJKrGsW8/ZkQ3u1
   +ea/7akBgUQkQi6atvpu438TpQzNuQYOmbp6cPxmT/mIfHdB48pY+YbCt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="377049021"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="377049021"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 09:09:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766633506"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766633506"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga004.fm.intel.com with ESMTP; 04 May 2023 09:09:29 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim C Chen <tim.c.chen@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 1/6] sched/topology: Propagate SMT flags when removing degenerate domain
Date:   Thu,  4 May 2023 09:09:51 -0700
Message-Id: <73cf0959eafa53c02e7ef6bf805d751d9190e55d.1683156492.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1683156492.git.tim.c.chen@linux.intel.com>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim C Chen <tim.c.chen@linux.intel.com>

When a degenerate cluster domain for core with SMT CPUs is removed,
the SD_SHARE_CPUCAPACITY flag in the local child sched group was not
propagated to the new parent.  We need this flag to properly determine
whether the local sched group is SMT.  Set the flag in the local
child sched group of the new parent sched domain.

Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/topology.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 051aaf65c749..6d5628fcebcf 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -719,8 +719,13 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 
 		if (sd_parent_degenerate(tmp, parent)) {
 			tmp->parent = parent->parent;
-			if (parent->parent)
+
+			if (parent->parent) {
 				parent->parent->child = tmp;
+				if (tmp->flags & SD_SHARE_CPUCAPACITY)
+					parent->parent->groups->flags |= SD_SHARE_CPUCAPACITY;
+			}
+
 			/*
 			 * Transfer SD_PREFER_SIBLING down in case of a
 			 * degenerate parent; the spans match for this
-- 
2.32.0

