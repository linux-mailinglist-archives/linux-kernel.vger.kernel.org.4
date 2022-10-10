Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680175FA7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJJWnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJJWnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:43:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C4B66A4F;
        Mon, 10 Oct 2022 15:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441784; x=1696977784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eQESRMBh/lxlX7p179P4x0M4lLpqCwoTA2mtPcsMflg=;
  b=l1Ycjd45lydV+gqUgjrfPVnx8NdaBYMWlDlNEy/WsTeuJEvwT/YaY1gp
   xp6pPrs0lSW8rxoFVU3Z5hROkwZh8chWBHQgv4jBB+h/Q6ZKypuVgb+7R
   TgS5mjbAbRmp3vj4a792Om1thOZClJVuAj+T1QSAmCorn7bicFEa4BC8q
   DlblEgb6XdIsjR8jWUw61i6ASZhoJHxtbLwc1ln7TpQIIIU10oABnD1sm
   71xdv8aLld6tYKjoJgfa/kgMLP4S8rVkhyOgOw0dWrAhzEv4YzXwZyGJq
   ZSTWUjw74uRItl8bKH83tBpTuaiIyhQ8V+tZpbSK0zIzt/tSDYdO6ERd5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="287615375"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="287615375"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="621191330"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="621191330"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.252.141.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:03 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [RFC V2 PATCH 01/11] cxl/mbox: Add debug of hardware error code
Date:   Mon, 10 Oct 2022 15:41:21 -0700
Message-Id: <20221010224131.1866246-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221010224131.1866246-1-ira.weiny@intel.com>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

If a mailbox command fails the driver always reports ENXIO.  But this
may not be enough information to understand why the hardware, or in my
case Qemu, was failing.

Add a debug print of the error code returned from the hardware.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 16176b9278b4..6c4d024ad0e8 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -181,8 +181,11 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
 	if (rc)
 		return rc;
 
-	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
+	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS) {
+		dev_dbg(cxlds->dev, "MB error : %s\n",
+			cxl_mbox_cmd_rc2str(&mbox_cmd));
 		return cxl_mbox_cmd_rc2errno(&mbox_cmd);
+	}
 
 	/*
 	 * Variable sized commands can't be validated and so it's up to the
-- 
2.37.2

