Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0F56872C8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjBBBJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBBBJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:09:03 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1493FF15;
        Wed,  1 Feb 2023 17:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675300141; x=1706836141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3lMOfD9F6HuX4w1wpmWNiLldjGCwlcw1Bc5PlcqtZGk=;
  b=BdWTLquQStoqvr3AYh73dCP9fXsv9OUc571XyhIk1WuS/richcZrytHC
   PRJNhNEH1J+nn9gFFlTxyTuJDTCC5jLmDFUpWJJ6xo9muWw9eaEdJWYoF
   zBdoVZqRi2N9Fl8gbPNoNpCvt6/N0o/JDq3BY+eB/mduVbRzwAOEBvZYc
   qN/0BcWJhvyhvmSlnrDjc+sLaM2vrt8wlb72UZhacA47AjFDJW2Rig9Aq
   +RCkE6VFlpwS6GJHqu4K6K2ZNs6+RaibC7oLayq67TdhQs1TCZ9kY/GHW
   3OdvL4J4WUHfSEA1g/YegcN4BRvClZYNgfZaw2zF03+nMXD/+TmS/2rLm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355654303"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="355654303"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="665087924"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="665087924"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2023 17:08:15 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: [PATCH 1/7] platform/x86/intel/vsec: Add TPMI ID
Date:   Wed,  1 Feb 2023 17:07:32 -0800
Message-Id: <20230202010738.2186174-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
References: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TPMI (Topology Aware Register and PM Capsule Interface) VSEC ID to
create an aux device. This will allow TPMI driver to enumerate on this
aux device.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index bb81b8b1f7e9..a82b2a5ed99d 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -64,6 +64,7 @@ enum intel_vsec_id {
 	VSEC_ID_WATCHER		= 3,
 	VSEC_ID_CRASHLOG	= 4,
 	VSEC_ID_SDSI		= 65,
+	VSEC_ID_TPMI		= 66,
 };
 
 static enum intel_vsec_id intel_vsec_allow_list[] = {
@@ -71,6 +72,7 @@ static enum intel_vsec_id intel_vsec_allow_list[] = {
 	VSEC_ID_WATCHER,
 	VSEC_ID_CRASHLOG,
 	VSEC_ID_SDSI,
+	VSEC_ID_TPMI,
 };
 
 static const char *intel_vsec_name(enum intel_vsec_id id)
@@ -88,6 +90,9 @@ static const char *intel_vsec_name(enum intel_vsec_id id)
 	case VSEC_ID_SDSI:
 		return "sdsi";
 
+	case VSEC_ID_TPMI:
+		return "tpmi";
+
 	default:
 		return NULL;
 	}
-- 
2.31.1

