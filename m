Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE54072BB39
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjFLIwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjFLIwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:52:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0C6103;
        Mon, 12 Jun 2023 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686559919; x=1718095919;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=QitlA6B4BYqBP6zfLZfHaIPFUxXsTq0ZJfSC4gOQuEM=;
  b=mpn01PaIfGNe85S9CZHHHb5fjwiM0GchW0YTH94wrj7DHVHV5jdZP9cP
   KPNw0Lc5qqFWLVvY5XnVlcTG9cmupAk80aG+K6LuQ0FDSIR5mQTurC+Ql
   pypNP6TtzWzNuVAYuF8/sZjuU7Mjs+k2wYpXsJRv0UH6LxkUgc6wUrtad
   fd0ynqjGgZRZV0tjvTasEq+eUh4DBy544CUx4VlXmJIHWs/qjjlMVDEOd
   iHoMC1veisQ6s6u3MpQVzPO0lpp4KU2aD2S8UD++21dcEBJTVX2snuUsN
   qLydjQQ0nOMH2MQ3tGQQknRiqBDHzzdOXy7mfmrZwgZXpwynjYqCzIObF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="347613307"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="347613307"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 23:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="835365318"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="835365318"
Received: from apeer-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.251.3.238])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 23:56:21 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Mon, 12 Jun 2023 00:55:57 -0600
Subject: [PATCH v3 2/4] tools/testing/cxl: Fix command effects for
 inject/clear poison
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230602-vv-fw_update-v3-2-869f82069c95@intel.com>
References: <20230602-vv-fw_update-v3-0-869f82069c95@intel.com>
In-Reply-To: <20230602-vv-fw_update-v3-0-869f82069c95@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=QitlA6B4BYqBP6zfLZfHaIPFUxXsTq0ZJfSC4gOQuEM=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCltB6ewBtZ85E7kS4w9qny354gha8v3mcoXM/V9edidA
 xQPOVR3lLIwiHExyIopsvzd85HxmNz2fJ7ABEeYOaxMIEMYuDgFYCKBigx/JWVuFAkq/7Ji2HXP
 uzXkxf+w57khvXGqReJ8+3as4Tf+w/C/bM9CGfXpMW+XrTg64VdE967COxUMk/WSDSdEnNnptlm
 RFwA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

