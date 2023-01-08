Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA332661A81
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 23:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbjAHWl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 17:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjAHWlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 17:41:20 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2944F01F;
        Sun,  8 Jan 2023 14:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1673217671;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=XJkNB7M2uzWaXUezNZhIWw8zxGs2iBO99QLhdOOLpXA=;
    b=l7DNhPITdyIFswQNIbsWHMpvoFfkJMX8EHCJT5HkuHxFh1LaPGb0NnpYb9l2RczOHW
    tc1yHVHduJbEBDrBCCtqJEO9d8X2SSQipPa5uae8fMsSQVLQhWIs6KvwUj2m56u4tg0s
    G9TjVLLA1mWlA4qwpPLqiZ1RtQqtbyZAnCpfmn9tdaNHedHx6xaeGtctmv9jUd9IeLyd
    DdzXJkq8DiV+40t1RQ+cRb7a6jWqNu982cRC0VoxiWna4rIpcuesqvuzn3oyNVViPdBB
    W+Xs/CjR7fXEdC+VkzXd4eB8OGBNuIYD2FO0tLQ6XkHNlbvcqYksDni7EPRV5y30jdb8
    Fo3A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1UnWvo/SqbTSXcQZxAZvLxWc5msS6txu0oUh"
X-RZG-CLASS-ID: mo02
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id 905423z08MfBAeB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 8 Jan 2023 23:41:11 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        quic_cang@quicinc.com, quic_xiaosenh@quicinc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 3/3] scsi: ufs: core: bsg: Fix cast to restricted __be16 warning
Date:   Sun,  8 Jan 2023 23:40:57 +0100
Message-Id: <20230108224057.354438-4-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230108224057.354438-1-beanhuo@iokpp.de>
References: <20230108224057.354438-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Fix the following sparse endianness warning:

"sparse warnings: drivers/ufs/core/ufs_bsg.c:91:25: sparse: sparse: cast to
restricted __be16."

For consistency with endianness annotations of other UFS data structures,
change __u16/32 to __be16/32 in UFS ARPMB data structures.

Fixes: 6ff265fc5ef6 ("scsi: ufs: core: bsg: Add advanced RPMB support in ufs_bsg")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 include/uapi/scsi/scsi_bsg_ufs.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/uapi/scsi/scsi_bsg_ufs.h b/include/uapi/scsi/scsi_bsg_ufs.h
index 276e2772328f..2801b65299aa 100644
--- a/include/uapi/scsi/scsi_bsg_ufs.h
+++ b/include/uapi/scsi/scsi_bsg_ufs.h
@@ -97,18 +97,18 @@ struct utp_upiu_req {
 };
 
 struct ufs_arpmb_meta {
-	__u16	req_resp_type;
+	__be16	req_resp_type;
 	__u8	nonce[16];
-	__u32	write_counter;
-	__u16	addr_lun;
-	__u16	block_count;
-	__u16	result;
+	__be32	write_counter;
+	__be16	addr_lun;
+	__be16	block_count;
+	__be16	result;
 } __attribute__((__packed__));
 
 struct ufs_ehs {
 	__u8	length;
 	__u8	ehs_type;
-	__u16	ehssub_type;
+	__be16	ehssub_type;
 	struct ufs_arpmb_meta meta;
 	__u8	mac_key[32];
 } __attribute__((__packed__));
-- 
2.25.1

