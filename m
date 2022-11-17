Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89B62E987
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbiKQXX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiKQXXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:23:15 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D36274A91;
        Thu, 17 Nov 2022 15:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668727394; x=1700263394;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1vf+nxtKsojFCFBBwNt1MycZfyiXZfZyH/YixPFSLlM=;
  b=Ow/Fa2lQiysdU6TqdjWVzqTc/bhhB1C0ddbuOzZdto9UkNvNL/MEyhz/
   HNF9mP2SoiWObyxy6HqUgwCKR5oj+6D51T3z30OqQTk/jt++0GBEZoJnL
   aWV1I+/VdXGbs3vaggNibWN4vm/0R5OAmonPzKm2Fr/EXgahO5rOGZ5m0
   UUkbD5rOmzZWuPkHlaa7nSEryg/Gb+uF/mC4yHtpADYTcDrFInEQwVHAM
   KgrcJWum+5MOsJPYCOL1OwbGbbR0DO6u8N9scK7fDwu/RcpWhHEfG7EY/
   Ko2WcTm67eV8UD4AhsYnsLrzHB2SauFnmpCm6eZbWHJzTmQ9fCG3OE/Jy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="292704100"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="292704100"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 15:23:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="969064618"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="969064618"
Received: from cvadim-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.60.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 15:23:11 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5FA7D109763; Fri, 18 Nov 2022 02:23:09 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, David.Laight@ACULAB.COM,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2] scsi: Fix get_user() in call sg_scsi_ioctl()
Date:   Fri, 18 Nov 2022 02:23:04 +0300
Message-Id: <20221117232304.1544-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_user() expects the pointer to be pointer-to-simple-variable type,
but sic->data is array of 'unsigned char'. It violates get_user()
contracts.

Explicitly take pointer to the first element of the array. It matches
current behaviour.

This is preparation for fixing sparse warnings caused by Linear Address
Masking patchset.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
---
 drivers/scsi/scsi_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 2d20da55fb64..fdd47565a311 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -519,7 +519,7 @@ static int sg_scsi_ioctl(struct request_queue *q, fmode_t mode,
 		return -EFAULT;
 	if (in_len > PAGE_SIZE || out_len > PAGE_SIZE)
 		return -EINVAL;
-	if (get_user(opcode, sic->data))
+	if (get_user(opcode, &sic->data[0]))
 		return -EFAULT;
 
 	bytes = max(in_len, out_len);
-- 
2.38.0

