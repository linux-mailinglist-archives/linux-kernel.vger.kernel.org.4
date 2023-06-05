Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E78723119
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjFEUVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjFEUUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:20:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B29313A;
        Mon,  5 Jun 2023 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685996453; x=1717532453;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0+TEi7rDE45s/tGzvp1DbBroD1RgvmAgvEMbWroZX+s=;
  b=nrnvBANsjK084/uhYMgtubk8uf42DbgcZXELctQkctslY1Oh4wEPdaU6
   ID+13/XBKjiS3oajJxVBgpZZG8UpNb/AcpDTNYohqHRQ005q6MI/M0R3K
   fqid/ILR0uwx9AwVkt0fRo4cBI2XfHx9P4MAdVAGSuIuJyZZbZQ5oAAwR
   sSpEhFeus5kseybLxB87laHFAzJ8MH9FutKBjUeHvaYoL5HNRuRivnbH9
   TUE9Nr/WQ3v2WA5VdQNc2k8M0WWx3qyvoJnppLFFfov5tzNlPygkCpFGw
   z4apRxl/tpoPvjbj6EdwLXcPOlQHbbr8ExcmObkTH39MJ5ky75VlcFGYK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336093130"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="336093130"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:20:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="832934191"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="832934191"
Received: from kmsalzbe-mobl1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.209.52.9])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:20:51 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Mon, 05 Jun 2023 14:20:23 -0600
Subject: [PATCH v2 2/4] tools/testing/cxl: Fix command effects for
 inject/clear poison
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230602-vv-fw_update-v2-2-e9e5cd5adb44@intel.com>
References: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
In-Reply-To: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=0+TEi7rDE45s/tGzvp1DbBroD1RgvmAgvEMbWroZX+s=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCl1zovOGG+8ouP57qlyTsGmmQxzpe4nWK74elt7qVf6g
 U2qFZZCHaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZiIjRjD/5x9MjlvOp49fayV
 fWn1m2ne8+zWuUQpac7n2+4v9cfiTjEjw2P5pGXJDawSm68psRaWCMf7nehlesRSzNe3ZPKnCXo
 BLAA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

