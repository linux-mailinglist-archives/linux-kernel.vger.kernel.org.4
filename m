Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3ED5E5A36
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 06:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiIVE2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 00:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiIVE2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 00:28:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBB3AE9CA;
        Wed, 21 Sep 2022 21:28:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9552AB829F9;
        Thu, 22 Sep 2022 04:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8C2C433C1;
        Thu, 22 Sep 2022 04:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663820920;
        bh=tWSCYk4ZSoVou22LxOw2uWNE5Vi+oMt7ylUBlRbR7Vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBRq4D7ZWG6gaSv+DdtCbgetQCTL3WCmZYc68VNK01Q7CkzWY5CnYCHXOIsesBKuO
         9kWPIbFrDfWVEz2GorlkBZto9rDSTYjWNyGO1KKl9ayS6YXWKiMIsoc1U+kayIeZfK
         4008LBsO4fkvC3coQ9cByPactT6conJdSWBtMzxmKYll4rnmnkGd/+7hGPAFU9GRww
         JDroPHGRqp51LOtMuVJWgm1ZLoHw9dGDELkd2kg5ifpIphDjvoO3dm7V7F8bDOMex9
         3ukfCqVKXnr6JhDF6QP9Bkodw+Fz7ggHgMQstl7UgZiT5ERbPKoQZcZmcnbXhaC4oJ
         7zpVe6Zw/o7pQ==
Date:   Wed, 21 Sep 2022 23:28:35 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kevin Barnett <kevin.barnett@microsemi.com>,
        Don Brace <don.brace@microchip.com>, storagedev@microchip.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/3][next] scsi: smartpqi: Replace one-element array with
 flexible-array member
Message-ID: <c80c0979933e0c05e80d95792ef167a28640a14b.1663816572.git.gustavoars@kernel.org>
References: <cover.1663816572.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663816572.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element array with flexible-array
member in struct MR_DRV_RAID_MAP and refactor the the rest of the code
accordingly.

It seems that the addition of sizeof(struct report_log_lun) in all the
places that are modified by this patch is due to the fact that
the one-element array struct report_log_lun lun_entries[1]; always
contributes to the size of the containing structure struct
report_log_lun_list.

Notice that at line 1267 while allocating memory for an instance of
struct report_log_lun_list, some _extra_ space seems to be allocated
for one element of type struct report_log_lun, which is the type of
the elements in array lun_entries:

 1267         internal_logdev_list = kmalloc(logdev_data_length +
 1268                 sizeof(struct report_log_lun), GFP_KERNEL);

However, at line 1275 just logdev_data_length bytes are copied into
internal_logdev_list (remember that we allocated space for logdev_data_length +
sizeof(struct report_log_lun) bytes at line 1267), and then exactly
sizeof(struct report_log_lun) bytes are being zeroing out at line 1276.

 1275         memcpy(internal_logdev_list, logdev_data, logdev_data_length);
 1276         memset((u8 *)internal_logdev_list + logdev_data_length, 0,
 1277                 sizeof(struct report_log_lun));

All the above makes think that it's just fine if we transform array
lun_entries into a flexible-array member and just don't allocate
that extra sizeof(struct report_log_lun) bytes of space. With this
we can remove that memset() call and we also need to modify the code
that updates the total length (internal_logdev_list->header.list_length)
of array lun_entries at line 1278:

 1278         put_unaligned_be32(logdev_list_length +
 1279                 sizeof(struct report_log_lun),
 1280                 &internal_logdev_list->header.list_length);

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
on memcpy().

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/204
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
And of course, it'd be great if maintainers can confirm what I described
in the changelog text. :)

 drivers/scsi/smartpqi/smartpqi.h      |  2 +-
 drivers/scsi/smartpqi/smartpqi_init.c | 10 +++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
index e550b12e525a..d1756c9d1112 100644
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
index b971fbe3b3a1..544cd18a90d7 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -1264,8 +1264,7 @@ static int pqi_get_device_lists(struct pqi_ctrl_info *ctrl_info,
 	logdev_data_length = sizeof(struct report_lun_header) +
 		logdev_list_length;
 
-	internal_logdev_list = kmalloc(logdev_data_length +
-		sizeof(struct report_log_lun), GFP_KERNEL);
+	internal_logdev_list = kmalloc(logdev_data_length, GFP_KERNEL);
 	if (!internal_logdev_list) {
 		kfree(*logdev_list);
 		*logdev_list = NULL;
@@ -1273,11 +1272,8 @@ static int pqi_get_device_lists(struct pqi_ctrl_info *ctrl_info,
 	}
 
 	memcpy(internal_logdev_list, logdev_data, logdev_data_length);
-	memset((u8 *)internal_logdev_list + logdev_data_length, 0,
-		sizeof(struct report_log_lun));
-	put_unaligned_be32(logdev_list_length +
-		sizeof(struct report_log_lun),
-		&internal_logdev_list->header.list_length);
+	put_unaligned_be32(logdev_list_length,
+			   &internal_logdev_list->header.list_length);
 
 	kfree(*logdev_list);
 	*logdev_list = internal_logdev_list;
-- 
2.34.1

