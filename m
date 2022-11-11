Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D705625159
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiKKDNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiKKDND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:13:03 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC2F5CD29;
        Thu, 10 Nov 2022 19:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668136380; x=1699672380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y00FqPXd0tXMVfbMPOYOFfjRtaD0786m2Qc/OlOfGUE=;
  b=IUdDeEcWfeS9KM33cf7hVpD8Az0gL3y3vfxU+Fdsb/MJyFviz3FLIoc4
   cWZKLYlVg8Y0FM88FSzBw9vZAVE1vsPIGhFu5Lr8Ce0mc4VA/dARTEOjX
   WYefm52/CWHIPPhsaAsDFZ9l7kwJRJMOXfGXMe39WhE2bMzeajtRigpWQ
   dQBhP8LU2lxYyhh6e0CCegh+SAXh/mP+c4cJZDZqpErXu6m39qnd+j44k
   FHg5ubgQA7PTMhD0ADaP+pb8upN0lgv3SsyTK9iqyTV5UZcZyj4rSOnoc
   ycT1a7EUUmvJ5Uy/MHebiwf4Wj78WVpPIW/W7rGrpBna/tEIa26F9MlzU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="310224419"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="310224419"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:13:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="812296108"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="812296108"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.161.45])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:12:59 -0800
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
Subject: [PATCH v3 6/6] tools/testing/cxl: Mock the Get Poison List mbox command
Date:   Thu, 10 Nov 2022 19:12:44 -0800
Message-Id: <7accc4b25613bd04ded1c48fa317dcf08803575f.1668115235.git.alison.schofield@intel.com>
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

Return fake poison error records when the get poison list mbox
command is issued. This supports testing the kernel tracing
and cxl list capabilities for media errors.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/mem.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index f0704d090073..f729e055605d 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -38,6 +38,10 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
 		.effect = cpu_to_le16(0),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
+		.effect = cpu_to_le16(0),
+	},
 };
 
 /* See CXL 2.0 Table 181 Get Health Info Output Payload */
@@ -207,6 +211,30 @@ static int mock_health_info(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
+static int mock_get_poison(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+{
+	struct {
+		struct cxl_mbox_poison_payload_out poison_out;
+		struct cxl_poison_record record;
+	} mock_poison_list = {
+		.poison_out = {
+			.count = cpu_to_le16(1),
+		},
+		.record = {
+			/* .address encodes DPA and poison source bits */
+			.address = cpu_to_le64(CXL_POISON_SOURCE_INTERNAL),
+			.length = cpu_to_le32(1),
+		},
+	};
+
+	if (cmd->size_out < sizeof(mock_poison_list))
+		return -EINVAL;
+
+	memcpy(cmd->payload_out, &mock_poison_list, sizeof(mock_poison_list));
+	cmd->size_out = sizeof(mock_poison_list);
+	return 0;
+}
+
 static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct device *dev = cxlds->dev;
@@ -234,6 +262,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_GET_HEALTH_INFO:
 		rc = mock_health_info(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_GET_POISON:
+		rc = mock_get_poison(cxlds, cmd);
+		break;
 	default:
 		break;
 	}
-- 
2.37.3

