Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE45625158
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiKKDNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiKKDM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:12:59 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8468A5CD12;
        Thu, 10 Nov 2022 19:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668136378; x=1699672378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JdyavRtcyKYFKOnnExa3qY1SoXZOphSrTHOAQ8KDAJw=;
  b=MApE+J/RoaEae/iGA01GOeL8nmN+cv22SONSdf4UWytH0xCw1oR8AdAD
   96S7Ey6bFaPh6G3Wh9PtpNeD1yejXRHUeYzIfViXO9e2VekSMn7/mstaq
   ChB7+RNMV2DUBCoo8uY0pr29MhkThHUp1SZ95osPtBnm26GHqxmRyKuiP
   Xn+zA2fuAtiEe2QL+TZWvnAVBS1EFXwcv3uk6VOjOJv11fHVfAlZFbLKX
   ZApGaRcJBtBvQoW81DUl/6sA27AxFNGdscP1GHKlUc4kQYh5L5MbUn2mp
   Eqv/9osZyRXGauBRlpmCYKt1fd+EB3rbMxr3HElNXdM6InzTv+4jQNsGC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="310224418"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="310224418"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:12:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="812296101"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="812296101"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.161.45])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:12:57 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] tools/testing/cxl: Mock the max err records field of Identify cmd
Date:   Thu, 10 Nov 2022 19:12:43 -0800
Message-Id: <14b883bd220ff388cc3a287cf104d83d53a2f520.1668115235.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1668115235.git.alison.schofield@intel.com>
References: <cover.1668115235.git.alison.schofield@intel.com>
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

From: Alison Schofield <alison.schofield@intel.com>

The CXL mbox command Identify reports the maximum media error
records that a device will report. Mock it here for testing
the GET POISON LIST mbox command.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/mem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index aa2df3a15051..f0704d090073 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -111,6 +111,10 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
 	};
 
+	__le32 val = cpu_to_le32(SZ_64);
+
+	memcpy(id.poison_list_max_mer, &val, 3);
+
 	if (cmd->size_out < sizeof(id))
 		return -EINVAL;
 
-- 
2.37.3

