Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DBA7390C2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjFUU0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjFUU02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:26:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2011BFC;
        Wed, 21 Jun 2023 13:26:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B207E616A1;
        Wed, 21 Jun 2023 20:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37288C433C0;
        Wed, 21 Jun 2023 20:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687379185;
        bh=IldafOrMYKZpxWjdW8Dzn1OfaBUtuI1eV2ylNsc6e4U=;
        h=Date:From:To:Cc:Subject:From;
        b=Y2yqS/Y4fgeMMrBp4GVpPiqQbkfNRrlEDKuueTlTQcPCkJMvcZl93ZvoNBGz2WDfd
         prh5aeFF+odgcGV6AHJovFc1nEKh5cxfzd3S8h2m07GFMUckTezMG4N7GGzAN8fHY4
         d7JdCsfUVoBNmj2AlNadrUd87AzKOuZrRDvoL7MP1Vq9vBRZUd95XDNOMPjmUqQUKx
         JMS2PKX5AmaDfvzGLvKQ6Fu1YquE0AdOgntp9F8JvZUElb/mbC3KGDpstXFzmfDT7D
         xBHLVodDHNUxpMCFx2G+bfNhum2wBPFITdhqY5+waVCPStH3gMdb50Jy2z/dIh2biy
         84S6CUf4NnFcQ==
Date:   Wed, 21 Jun 2023 14:27:20 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] scsi: smartpqi: Replace one-element arrays with
 flexible-array members
Message-ID: <ZJNdKDkuRbFZpASS@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element arrays with flexible-array
members in a couple of structures, and refactor the rest of the code,
accordingly.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy().

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/204
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi.h      | 4 ++--
 drivers/scsi/smartpqi/smartpqi_init.c | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
index f960b5095d09..e392eaf5b2bf 100644
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
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 19af36e9a16d..6aaaa7ebca37 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -1203,7 +1203,6 @@ static inline int pqi_report_phys_luns(struct pqi_ctrl_info *ctrl_info, void **b
 	unsigned int i;
 	u8 rpl_response_format;
 	u32 num_physicals;
-	size_t rpl_16byte_wwid_list_length;
 	void *rpl_list;
 	struct report_lun_header *rpl_header;
 	struct report_phys_lun_8byte_wwid_list *rpl_8byte_wwid_list;
@@ -1232,9 +1231,9 @@ static inline int pqi_report_phys_luns(struct pqi_ctrl_info *ctrl_info, void **b
 
 	rpl_8byte_wwid_list = rpl_list;
 	num_physicals = get_unaligned_be32(&rpl_8byte_wwid_list->header.list_length) / sizeof(rpl_8byte_wwid_list->lun_entries[0]);
-	rpl_16byte_wwid_list_length = sizeof(struct report_lun_header) + (num_physicals * sizeof(struct report_phys_lun_16byte_wwid));
 
-	rpl_16byte_wwid_list = kmalloc(rpl_16byte_wwid_list_length, GFP_KERNEL);
+	rpl_16byte_wwid_list = kmalloc(struct_size(rpl_16byte_wwid_list, lun_entries,
+						   num_physicals), GFP_KERNEL);
 	if (!rpl_16byte_wwid_list)
 		return -ENOMEM;
 
-- 
2.34.1

