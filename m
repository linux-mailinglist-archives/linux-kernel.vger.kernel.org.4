Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335C162B034
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 01:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiKPAoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 19:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiKPAoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:44:06 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410E32AC7D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 16:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668559445; x=1700095445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IhFBAznLG1DY+6oqG9WaOOSep20Baj1si3bnp+y4wkA=;
  b=WGzt4t8oEe5VRtFUZSR9YTHmXHXLsYKP2c8+bU7oFvYlMauG+nxZmu9L
   tH2CnGuEz3Gx24ZjqyGwvCZzgtHNo7WtSQV+/jox/Zoeu3qp+blZOPNB7
   kEwW3NQJ9IJ+DyHVEexlsgWsXlzdu+aanSNcnHfc6t0v8F0NWg2zyAILo
   xKVxQ/iYDwC3S7l7FomA1xRVW/DR3x5F3lhD7vGJGSQawOD8AX9XEZag/
   uMNpO27m6Na2Cp+ARsgCOHLr5hc3fDsKYNTAS7hXdnMEhtGTqptTuLnsQ
   h7gK0r6xmGBheHHOoRVqgGOLK+/1yF1X7xKGFyrT3s1jKRof06nobx1SZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="299935334"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="299935334"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 16:44:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="707941468"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="707941468"
Received: from nrobin-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.45.56])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 16:44:01 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 19A4110443E; Wed, 16 Nov 2022 03:43:59 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     kirill@shutemov.name
Cc:     dave.hansen@intel.com, dave.hansen@linux.intel.com,
        jejb@linux.ibm.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        martin.petersen@oracle.com, oe-kbuild-all@lists.linux.dev,
        x86@kernel.org
Subject: [PATCH 1/2] scsi: Fix get_user() in call sg_scsi_ioctl()
Date:   Wed, 16 Nov 2022 03:43:52 +0300
Message-Id: <20221116004353.15052-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221116004353.15052-1-kirill.shutemov@linux.intel.com>
References: <20221115155802.p3vjnk7eqqcyskt3@box.shutemov.name>
 <20221116004353.15052-1-kirill.shutemov@linux.intel.com>
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

get_user() expects the pointer to be pointer-to-simple-variable type,
but sic->data is array of 'unsigned char'. It violates get_user()
contracts.

Cast it explicitly to 'unsigned char __user *'. It matches current
behaviour.

This is preparation for fixing sparse warnings caused by Linear Address
Masking patchset.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
---
 drivers/scsi/scsi_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 2d20da55fb64..72b3ab5137b8 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -519,7 +519,7 @@ static int sg_scsi_ioctl(struct request_queue *q, fmode_t mode,
 		return -EFAULT;
 	if (in_len > PAGE_SIZE || out_len > PAGE_SIZE)
 		return -EINVAL;
-	if (get_user(opcode, sic->data))
+	if (get_user(opcode, (unsigned char __user *)sic->data))
 		return -EFAULT;
 
 	bytes = max(in_len, out_len);
-- 
2.38.0

