Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F9767F846
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjA1NrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbjA1NrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:47:20 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E767B2C67F;
        Sat, 28 Jan 2023 05:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674913621; bh=gd5UWYqxyut4hFbuycUVp9wAsaqAqcJEe6vfKpfaam8=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=gmJb4ZPTz8TIq/N3zIiOh/kZW/AEttO7GI5GWgEAheoqEumfAvU4cAb1a8Dn+ZFpm
         BN1ZOUqGOJmsHBY58Q2hjJausL7s9xYnnmK6TF/qTH3ssmITFJZ+XC0nmnXit+dPnh
         K/f6z4cACCc2SonLcBsezz81CDcQxpKun4Mq7lH8=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 28 Jan 2023 14:47:01 +0100 (CET)
X-EA-Auth: oerXmIxjLYD8tGh7VgjiBI5PhYp9cA4egWTF4yfqqtZHb3UknEQUcIXNTiwvgFl8t/W+oXY3LGDKHaKs00E1GTEVe7G1yVsS
Date:   Sat, 28 Jan 2023 19:16:55 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: hpsa: Use min helper for comparison and assignment
Message-ID: <Y9UnT4j51kHrMvhm@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code by using min_t() helper macro for logical evaluation
and value assignment. Use the _t variant macro since the variable
types are not same.
Proposed change is identified using minmax.cocci semantic patch script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/hpsa.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index c74fec4c2bd6..e030d07c4341 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -2665,12 +2665,10 @@ static void complete_scsi_command(struct CommandList *cp)
 	case CMD_TARGET_STATUS:
 		cmd->result |= ei->ScsiStatus;
 		/* copy the sense data */
-		if (SCSI_SENSE_BUFFERSIZE < sizeof(ei->SenseInfo))
-			sense_data_size = SCSI_SENSE_BUFFERSIZE;
-		else
-			sense_data_size = sizeof(ei->SenseInfo);
+		sense_data_size = min_t(size_t, SCSI_SENSE_BUFFERSIZE, sizeof(ei->SenseInfo));
 		if (ei->SenseLen < sense_data_size)
 			sense_data_size = ei->SenseLen;
+
 		memcpy(cmd->sense_buffer, ei->SenseInfo, sense_data_size);
 		if (ei->ScsiStatus)
 			decode_sense_data(ei->SenseInfo, sense_data_size,
@@ -3630,11 +3628,9 @@ static bool hpsa_vpd_page_supported(struct ctlr_info *h,
 				buf, HPSA_VPD_HEADER_SZ);
 	if (rc != 0)
 		goto exit_unsupported;
+
 	pages = buf[3];
-	if ((pages + HPSA_VPD_HEADER_SZ) <= 255)
-		bufsize = pages + HPSA_VPD_HEADER_SZ;
-	else
-		bufsize = 255;
+	bufsize = min_t(uint, (pages + HPSA_VPD_HEADER_SZ), 255);
 
 	/* Get the whole VPD page list */
 	rc = hpsa_scsi_do_inquiry(h, scsi3addr,
-- 
2.34.1



