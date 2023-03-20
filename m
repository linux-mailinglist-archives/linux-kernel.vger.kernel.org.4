Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513C16C2038
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjCTSqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCTSpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:45:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC59159FC;
        Mon, 20 Mar 2023 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679337536; x=1710873536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UvYJIwBTHdBBZXZqPdQKayC0/G29FFNNPv4XihGRHPw=;
  b=bX34Pd3gWFh48zNcT2KCJOw4VbCJcw/d2jCbO0euWLMLF8X8QtiA58wj
   /aMhMpLNmacLQE63OxLAui6nUaXiliTHQ6XMAHTkA3rSg2q4X5dMUoPwC
   JVqeXXr+zDhiJOSMTIeCxg+HDzXKH+ty3ywR60A0a6OREeEQ5X2uaRJfT
   63RRIHWfmAu9btiLTpFsS3fXa0Me4XdQ33mG6VW7m2TviI2ePd7Lui369
   G3gvqBCCPYqmbtFNMeAvGV/5bEnFjcM0EJrLbwhnglLZps3Y2/6MxUqGb
   5DPBvWKpGVItq2X6VC2Rb/wzt6ix1M11TBowm1CL3MlWGFgwpyDLRXupk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="322588307"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="322588307"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:35:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="791730818"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="791730818"
Received: from spalihov-mobl2.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.34.182])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:35:38 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf intel-pt: Add event type names UINTR and UIRET
Date:   Mon, 20 Mar 2023 20:35:16 +0200
Message-Id: <20230320183517.15099-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320183517.15099-1-adrian.hunter@intel.com>
References: <20230320183517.15099-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UINTR and UIRET are listed in table 32-50 "CFE Packet Type and Vector
Fields Details" in the Intel Processor Trace chapter of The Intel SDM
Volume 3 version 078.

The codes are for "User interrupt delivered" and "Exiting from user
interrupt routine" respectively.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 976f8bfe099c..c9296d8b33c0 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1906,7 +1906,7 @@ static int perf_sample__fprintf_synth_evt(struct perf_sample *sample, FILE *fp)
 	struct perf_synth_intel_evt *data = perf_sample__synth_ptr(sample);
 	const char *cfe[32] = {NULL, "INTR", "IRET", "SMI", "RSM", "SIPI",
 			       "INIT", "VMENTRY", "VMEXIT", "VMEXIT_INTR",
-			       "SHUTDOWN"};
+			       "SHUTDOWN", NULL, "UINTR", "UIRET"};
 	const char *evd[64] = {"PFA", "VMXQ", "VMXR"};
 	const char *s;
 	int len, i;
-- 
2.34.1

