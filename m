Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F5A67D486
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjAZSmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjAZSmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:42:33 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F314474C7;
        Thu, 26 Jan 2023 10:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674758553; x=1706294553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lazqj33+wcKOHpjgmXNXHNJZww2MNyt2EHBaLJXRYCw=;
  b=YZr0bbBfahBUfu/3SAMOQ6hI6BwMxQ8CQFasPDZ5HwLV8kesrv8s24Hl
   0WtUe9oo8GJn8+c+IALbhD/LlfL/SU3gSzPTB5qofKctBLWJTrqFrUo5O
   ShanDrlviRiTEOeOGS5wHs2QY8SGYhwixZvyGox93/YAIQOSZJCJHH3wM
   6od47+f5NrPNwX9WRpbqQrmPETE+U01LzrqGmGjNSnxIknaDJ4HNj07kX
   Majv+Ly4+zHupenxDshgdJYVAUU1db7mBqhns5iPiMUy8Hn4ii9X7/4H9
   kygaLFTiKrRg32zbGrA3E4+K1P7LDjFoY0bwfxQ9t/LqnVDxSkRWnGg3k
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="354203361"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="354203361"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:42:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="991745452"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="991745452"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:42:06 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 5/7] x86/resctrl: Add a new "snc_ways" file to the monitoring info directory.
Date:   Thu, 26 Jan 2023 10:41:55 -0800
Message-Id: <20230126184157.27626-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126184157.27626-1-tony.luck@intel.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it easy for the user to tell if Sub-NUMA Cluster is enabled by
providing an info/ file.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a0dc64a70d01..392e7a08d083 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -997,6 +997,14 @@ static int rdt_num_rmids_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdt_snc_ways_show(struct kernfs_open_file *of,
+			     struct seq_file *seq, void *v)
+{
+	seq_printf(seq, "%d\n", snc_ways);
+
+	return 0;
+}
+
 static int rdt_mon_features_show(struct kernfs_open_file *of,
 				 struct seq_file *seq, void *v)
 {
@@ -1451,6 +1459,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdt_num_rmids_show,
 		.fflags		= RF_MON_INFO,
 	},
+	{
+		.name		= "snc_ways",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdt_snc_ways_show,
+		.fflags		= RF_MON_INFO,
+	},
 	{
 		.name		= "cbm_mask",
 		.mode		= 0444,
-- 
2.39.1

