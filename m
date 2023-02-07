Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831CF68E336
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBGV7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBGV7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:59:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82B5E384;
        Tue,  7 Feb 2023 13:59:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 438E961300;
        Tue,  7 Feb 2023 21:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DB0C433EF;
        Tue,  7 Feb 2023 21:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675807169;
        bh=2+uIJL7a04k5IP8kjsAfJlykmzdA/z7j0xIh6qAmfQQ=;
        h=Date:From:To:Cc:Subject:From;
        b=mDv+mckUu4WGUseKZhRfbTuak+Y/9Xb3qWYXMwj6RibBZrw4xfkq/R5tCLGDw8ebB
         kKF9rPQQA9Uy6wRpWCn8KW4kbqhnxe01Lg+cXPIs3tWn+zTpqjcz+N2U5XlM48Q91l
         g2awmj3ww1qo8ZsnG3okQSYq35kNY5Go3ByokLcUg/gcwUUGeq1m6HjVhkScK9zlml
         kxoKGR67rR4LC0RVPPoYambWbxBzimeeJNUttmWfKCdzblnTj4DM7RRZXlkQGTZCFH
         QwO3a60J/Z91kpcX/cMKWa1KlVL2xVC7idrS0hyfrahQzQan23m150uyAEmgDtmF4I
         U3BvIuyq/5xkQ==
Date:   Tue, 7 Feb 2023 15:59:43 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH v3][next] scsi: smartpqi: Replace one-element array with
 flexible-array member
Message-ID: <Y+LJz/r6+UeLqnV3@work>
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
Acked-by: Don Brace <don.brace@microchip.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Amplify the existing comment instead of adding a new one. By Don
   Brace[1].
 - Add Don's Acked-by tag to the changelog.
   Link: https://lore.kernel.org/linux-hardening/d881ad98-a291-1c9b-53dc-199f23f1625e@embeddedor.com/ [1]

Changes in v2:
 - In v1 we thought that the original code was allocating one too-many
   entries for the list. However, Don Brace commented that the allocation
   was actually intentional[2]. So, I added a code comment with his feedback.
   Link: https://lore.kernel.org/linux-hardening/16e6c434-44af-2efb-d4bc-a253e93e5590@embeddedor.com/  [2]

v1:
 - Link: https://lore.kernel.org/linux-hardening/c80c0979933e0c05e80d95792ef167a28640a14b.1663816572.git.gustavoars@kernel.org/

 drivers/scsi/smartpqi/smartpqi.h      | 2 +-
 drivers/scsi/smartpqi/smartpqi_init.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

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
index d0446d4d4465..49a8f91810b6 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -1259,7 +1259,8 @@ static int pqi_get_device_lists(struct pqi_ctrl_info *ctrl_info,
 			"report logical LUNs failed\n");
 
 	/*
-	 * Tack the controller itself onto the end of the logical device list.
+	 * Tack the controller itself onto the end of the logical device list
+	 * by adding a list entry that is all zeros.
 	 */
 
 	logdev_data = *logdev_list;
-- 
2.34.1

