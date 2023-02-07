Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C4A68DE53
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjBGQ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjBGQ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:57:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034793A594;
        Tue,  7 Feb 2023 08:57:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B44F7B81A01;
        Tue,  7 Feb 2023 16:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C78C433EF;
        Tue,  7 Feb 2023 16:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675789036;
        bh=MNtjrR3i9zJVMbXrA2OM0kVsyK6vBzmxrxtfk069rf4=;
        h=Date:From:To:Cc:Subject:From;
        b=Ffwz5mg+uOZwkbqk3CdPXkwZ9FrLo9uSsNsNsQw5kweSC29zByMBR7kj4y9ueasMc
         jRK5le8mzpZz7Edq+RS1FjPxmELIf+LJrw6uQueXrTWqcChbuB3lwdBxirpX3xuPwt
         8a6E8Ogxb1IIkG2nkAF3mLxbNg3cb0eM6HmSn32YmeUTnjyrY7OI4Xs77BXyfZYSGX
         MX7uuhhUpgKNFStumGa+0gZQ95FRrhOGdj76UJxXEMw+XtLu+EjcWv4LJK2AcKXoJa
         1X/eBUoosJnhIHkk5u7N4HRU4LRO618snZyFBz26qfYuBlTezr1rEoD07bspuuhlfJ
         oXqEH0duQFRdw==
Date:   Tue, 7 Feb 2023 10:57:29 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH v2][next] scsi: smartpqi: Replace one-element array with
 flexible-array member
Message-ID: <Y+KC+VJ5xdmMaMUc@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element array with flexible-array
member in struct report_log_lun_list.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
on memcpy().

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/204
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 In v1 we thought that the original code was allocating one too-many
 entries for the list. However, Don Brance commented that the allocation
 was actually intentional[1]. So, I added a code comment with his feedback.
 Link: https://lore.kernel.org/linux-hardening/16e6c434-44af-2efb-d4bc-a253e93e5590@embeddedor.com/  [1]

v1:
 Link: https://lore.kernel.org/linux-hardening/c80c0979933e0c05e80d95792ef167a28640a14b.1663816572.git.gustavoars@kernel.org/

 drivers/scsi/smartpqi/smartpqi.h      | 2 +-
 drivers/scsi/smartpqi/smartpqi_init.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
index af27bb0f3133..228838eb3686 100644
--- a/drivers/scsi/smartpqi/smartpqi.h
+++ b/drivers/scsi/smartpqi/smartpqi.h
@@ -954,7 +954,7 @@ struct report_log_lun {
 
 struct report_log_lun_list {
 	struct report_lun_header header;
-	struct report_log_lun lun_entries[1];
+	struct report_log_lun lun_entries[];
 };
 
 struct report_phys_lun_8byte_wwid {
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index d0446d4d4465..af8f1a8e9f8f 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -1277,6 +1277,10 @@ static int pqi_get_device_lists(struct pqi_ctrl_info *ctrl_info,
 	logdev_data_length = sizeof(struct report_lun_header) +
 		logdev_list_length;
 
+	/*
+	 * Notice that we take on an extra list entry (struct report_log_lun)
+	 * that is all zeros for the controller itself.
+	 */
 	internal_logdev_list = kmalloc(logdev_data_length +
 		sizeof(struct report_log_lun), GFP_KERNEL);
 	if (!internal_logdev_list) {
-- 
2.34.1

