Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32CF5E5A38
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 06:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiIVE3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 00:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiIVE3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 00:29:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06BD25E1;
        Wed, 21 Sep 2022 21:29:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C68762832;
        Thu, 22 Sep 2022 04:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36547C433C1;
        Thu, 22 Sep 2022 04:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663820975;
        bh=EfiAy9Nuu3BGiITJOCEnI1KFmxHsmaipEfKhciPmywM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HTsizo4XhUohxGxUTpHNNvqwUDVmhN3dvzGCRv/Y9oQg9F4gfK/Y+mmUHwsZgXA9f
         2Hdqn+B6dtB3NTUkuPWVjJnhZR31VOGL0+5GyzArhNcpbYBm9I7fiZP4Gs3S9GGxgv
         CtGBs0nFdL6hkKUybapAKUIW0Ei+/IIM5NhMwH2aD2+QBJEOKVJxPiNdB1zbnt2KhT
         7rOolhUjTNBdEkhjy36ewgSXadklXQ22pKRvnjRwpAuK4m/k9uINvFSZG9A08hXdpL
         PT1lr+MGEZ+sAB1b8mywboILE6S4xwDS3s4pO+ApW/mxVuyZGcz2RZxmX4kafsrYbf
         p/4ePm4GK7LOw==
Date:   Wed, 21 Sep 2022 23:29:29 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kevin Barnett <kevin.barnett@microsemi.com>,
        Don Brace <don.brace@microchip.com>, storagedev@microchip.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/3][next] scsi: smartpqi: Replace one-element arrays with
 flexible-array members
Message-ID: <62bb7891b3a752e7302286030ba9fafe58dffb1e.1663816572.git.gustavoars@kernel.org>
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
member in structures report_phys_lun_8byte_wwid_list and
report_phys_lun_16byte_wwid_list.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
on memcpy().

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/204
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
index d1756c9d1112..b31b42530674 100644
--- a/drivers/scsi/smartpqi/smartpqi.h
+++ b/drivers/scsi/smartpqi/smartpqi.h
@@ -982,12 +982,12 @@ struct report_phys_lun_16byte_wwid {
 
 struct report_phys_lun_8byte_wwid_list {
 	struct report_lun_header header;
-	struct report_phys_lun_8byte_wwid lun_entries[1];
+	struct report_phys_lun_8byte_wwid lun_entries[];
 };
 
 struct report_phys_lun_16byte_wwid_list {
 	struct report_lun_header header;
-	struct report_phys_lun_16byte_wwid lun_entries[1];
+	struct report_phys_lun_16byte_wwid lun_entries[];
 };
 
 struct raid_map_disk_data {
-- 
2.34.1

