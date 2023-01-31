Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FDA683AAC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjAaXpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjAaXo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:44:59 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597714ED07;
        Tue, 31 Jan 2023 15:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675208698; x=1706744698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=by5qRdZTxe0QTHHwMBIcWAw1uHYiJKW6XwzKCf+gNJo=;
  b=A15JtwrfA3ghpprrnQuDEzlAjBxflazXs/OwFmuqPrLseaL5kvvX9TUC
   hcVg4qSwL7O22utSKEyxe3jPHm4jTYOfc5opkI6VAve5cq7z/8pOyHnxm
   8uExTXO0KAuv5mUoWZNb3/ky8tUH6p0ECJcHpWX632ctFmpQLpxiNbDxg
   NOAFDZsPhIiTUcKzexkN7HzfkOr9Xiw+n8Ie08fOmQ7RZifj0gq/zXw9a
   nM+y5UpSdEwVMDMKujD/83y79Do9wwGm6AYZ6PJtd4HRtFbRpz2EkBgLm
   //FwtzC6jvo98SM/tkIJtbICRO1gPnRm049yM1hXxneWV4oYkokDlQpA6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="390360446"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="390360446"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 15:44:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="773192036"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="773192036"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 15:44:55 -0800
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
Subject: [PATCH 5/5] platform/x86/intel/ifs: Trace support for array test
Date:   Tue, 31 Jan 2023 15:43:02 -0800
Message-Id: <20230131234302.3997223-6-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230131234302.3997223-1-jithu.joseph@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
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
 include/trace/events/intel_ifs.h         | 27 ++++++++++++++++++++++++
 drivers/platform/x86/intel/ifs/runtest.c |  1 +
 2 files changed, 28 insertions(+)

diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
index d7353024016c..db43df4139a2 100644
--- a/include/trace/events/intel_ifs.h
+++ b/include/trace/events/intel_ifs.h
@@ -35,6 +35,33 @@ TRACE_EVENT(ifs_status,
 		__entry->status)
 );
 
+TRACE_EVENT(ifs_array,
+
+	TP_PROTO(int cpu, union ifs_array activate, union ifs_array status),
+
+	TP_ARGS(cpu, activate, status),
+
+	TP_STRUCT__entry(
+		__field(	u64,	status	)
+		__field(	int,	cpu	)
+		__field(	u32,	arrays	)
+		__field(	u16,	bank	)
+	),
+
+	TP_fast_assign(
+		__entry->cpu	= cpu;
+		__entry->arrays	= activate.array_bitmask;
+		__entry->bank	= activate.array_bank;
+		__entry->status	= status.data;
+	),
+
+	TP_printk("cpu: %d, array_list: %.8x, array_bank: %.4x, status: %.16llx",
+		__entry->cpu,
+		__entry->arrays,
+		__entry->bank,
+		__entry->status)
+);
+
 #endif /* _TRACE_IFS_H */
 
 /* This part must be outside protection */
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index ec0ceb6b5890..4fd80d91ea29 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -301,6 +301,7 @@ static void ifs_array_test_core(int cpu, struct device *dev)
 		stop_core_cpuslocked(cpu, do_array_test, msrvals);
 		status.data = msrvals[1];
 
+		trace_ifs_array(cpu, activate, status);
 		if (status.ctrl_result)
 			break;
 
-- 
2.25.1

