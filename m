Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C640697209
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjBNXqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjBNXp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:45:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3044C2914A;
        Tue, 14 Feb 2023 15:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676418358; x=1707954358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U58Wafc7htqFPRhoLYl7u0MCfTww372m3K2hlfQ7h3U=;
  b=iKz26d3AoUeirHw5J6DgmLk8LanUUvaFm9QZxoMDU5C5lApMg+fLySWO
   v+7ADvbWdzq4LsNW4m4/XwbBb6ND8suIl2rjmIc9ktbsbDcKVkFmn5guh
   9iYlgzl1htpaAxf6q7Qjcpc3ME6eRvdBk7HsXe8H6BxbywHjAtQ4CvCSH
   ExGRGHRejqdPnBXYTX/l2TVyWPkZ3FVwDvh8f67l2V3r9iPutrciLZyl1
   jtkrbAy3v6FNSKstI/e2z70Lk8i4Ld2eKLUYfVNWDXqD8wwN/d9gnWdsY
   95ySRR5V6+A1o+PWJrGU6Uly2liCTzAiJTPnOFx5aQOMTyE6Mghg2OAx0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="417523039"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="417523039"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 15:45:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="669391020"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="669391020"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 15:45:56 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH v2 5/7] platform/x86/intel/ifs: Trace support for array test
Date:   Tue, 14 Feb 2023 15:44:24 -0800
Message-Id: <20230214234426.344960-6-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230214234426.344960-1-jithu.joseph@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230214234426.344960-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable tracing support in array test flow.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 include/trace/events/intel_ifs.h         | 25 ++++++++++++++++++++++++
 drivers/platform/x86/intel/ifs/runtest.c |  1 +
 2 files changed, 26 insertions(+)

diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
index d7353024016c..d15037943b80 100644
--- a/include/trace/events/intel_ifs.h
+++ b/include/trace/events/intel_ifs.h
@@ -35,6 +35,31 @@ TRACE_EVENT(ifs_status,
 		__entry->status)
 );
 
+TRACE_EVENT(ifs_array,
+
+	TP_PROTO(int cpu, union ifs_array activate, union ifs_array status),
+
+	TP_ARGS(cpu, activate, status),
+
+	TP_STRUCT__entry(
+		__field(	u64,	activate	)
+		__field(	u64,	status	)
+		__field(	int,	cpu	)
+	),
+
+	TP_fast_assign(
+		__entry->activate	= activate.data;
+		__entry->status	= status.data;
+		__entry->cpu	= cpu;
+	),
+
+	TP_printk("cpu: %d, array_list: %.8llx, array_bank: %.4llx, status: %.16llx",
+		__entry->cpu,
+		__entry->activate & 0xffffffff,
+		(__entry->activate >> 32) & 0xffff,
+		__entry->status)
+);
+
 #endif /* _TRACE_IFS_H */
 
 /* This part must be outside protection */
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 12880fca0aa8..e74004fab1aa 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -299,6 +299,7 @@ static void ifs_array_test_core(int cpu, struct device *dev)
 		stop_core_cpuslocked(cpu, do_array_test, msrvals);
 		status.data = msrvals[1];
 
+		trace_ifs_array(cpu, activate, status);
 		if (status.ctrl_result)
 			break;
 
-- 
2.25.1

