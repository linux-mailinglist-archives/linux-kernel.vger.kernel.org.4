Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53C87305E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjFNRS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbjFNRSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:18:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A61270F;
        Wed, 14 Jun 2023 10:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686763092; x=1718299092;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/AmoSSmYynJbMOebYCDV5FrFBblS9nyHhJ1GF9w1uYM=;
  b=cXnYKcD8tG00/f8BTPqoVaIcXTqWpRis8U/e3b8Af8GgrjBQwsFv7Dot
   zFVQN5BTnlYgO5SPDoIvIV4rqsmo+5xwQ4NM/2k6rF4HNMgjstjHut04i
   qmYPIeocNjT1TXAHt99YVEdbNH1otVZ8hqDcl3Z1CtKt24iiS5aUrt/sf
   L9jJWLSLCTPZAIl/l5Kk4ry/iufqitz1nrCVWIYoQZS0lEE0nSuX3/f+6
   /yob5jHt9qH7SP+FSKbUeA7Do96JxxRSoXsKEsZn8KAW24BbvfnbtTc09
   OvSdMWKrQ4LHCGoIr5XFPW+Ttof1cePTKB+1H4lt9JC6T9WXRbtczeZgW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362054371"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="362054371"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 10:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="662470736"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="662470736"
Received: from mahbubu1-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.209.44.245])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 10:18:08 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Wed, 14 Jun 2023 11:17:41 -0600
Subject: [PATCH v4 2/4] tools/testing/cxl: Fix command effects for
 inject/clear poison
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230602-vv-fw_update-v4-2-c6265bd7343b@intel.com>
References: <20230602-vv-fw_update-v4-0-c6265bd7343b@intel.com>
In-Reply-To: <20230602-vv-fw_update-v4-0-c6265bd7343b@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=/AmoSSmYynJbMOebYCDV5FrFBblS9nyHhJ1GF9w1uYM=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCmd3/xZfsQkvj39/KBnxglTMZ13OnU1V1uLz5mwuW7Z+
 1yz7YF7RykLgxgXg6yYIsvfPR8Zj8ltz+cJTHCEmcPKBDKEgYtTACZyMZWRYY5dkvK1hMQnu8S0
 6zwnn2t/dfvTVt7bRldsCnSNTxstZGJk2L9x36/uNTfW7f4iuvUpD/PTf7e+tG4wv/nh7qPoVXx
 /OjkB
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CXL spec (3.0, section 8.2.9.8.4) Lists Inject Poison and Clear
Poison as having the effects of "Immediate Data Change". Fix this in the
mock driver so that the command effect log is populated correctly.

Fixes: 371c16101ee8 ("tools/testing/cxl: Mock the Inject Poison mailbox command")
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 tools/testing/cxl/test/mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 34b48027b3de..403cd3608772 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -52,11 +52,11 @@ static struct cxl_cel_entry mock_cel[] = {
 	},
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
-		.effect = cpu_to_le16(0),
+		.effect = cpu_to_le16(EFFECT(2)),
 	},
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_CLEAR_POISON),
-		.effect = cpu_to_le16(0),
+		.effect = cpu_to_le16(EFFECT(2)),
 	},
 };
 

-- 
2.40.1

