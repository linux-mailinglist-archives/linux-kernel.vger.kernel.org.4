Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FB770741B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjEQVWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjEQVW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:22:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA81A24B;
        Wed, 17 May 2023 14:22:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DE5264B62;
        Wed, 17 May 2023 21:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00CEC4339C;
        Wed, 17 May 2023 21:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684358516;
        bh=XvBexFj2rQW5zTYaB8rdYO9gB1RQcrsqk8ElYdEfk6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bo61x4//DPXMD6MwNBu/U4gPZFZiPY4VHbxUBWqvfzucpmlBJ3my9PPVDKfUBVPwt
         7amwvotIJ/q2SahHGqw35NxHwIXP2SOcL1CK80F/GjbdtgnWmN5N2Y6zF8FyXhp4o9
         d8ahE2PaLgnYWKXRtoDUuMQxM1bqUM2ZLs/7LrWq7TgNbyl4WXvL79WPujjE3JDcA4
         8gNnS/5Q/9V4j0ZDeKSKVXSoGioDeYdDJvYtWqDkfUHobg+ThBVE/KjNNNrBKM5ssD
         lid+JdiudVC0LTXyHKx1KNs0RiHsg8Jy6NIosGWXOdkbIbFsk5uPoOtDYnD5IfJPov
         9zFZ8npUYJnYQ==
Date:   Wed, 17 May 2023 15:22:45 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/2][next] scsi: lpfc: Replace one-element array with
 flexible-array member
Message-ID: <6c6dcab88524c14c47fd06b9332bd96162656db5.1684358315.git.gustavoars@kernel.org>
References: <cover.1684358315.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684358315.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/295
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/lpfc/lpfc_ct.c | 6 ++++--
 drivers/scsi/lpfc/lpfc_hw.h | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index f3bdcebe67f5..e880d127d7f5 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -3748,7 +3748,8 @@ lpfc_vmid_cmd(struct lpfc_vport *vport,
 		rap->obj[0].entity_id_len = vmid->vmid_len;
 		memcpy(rap->obj[0].entity_id, vmid->host_vmid, vmid->vmid_len);
 		size = RAPP_IDENT_OFFSET +
-			sizeof(struct lpfc_vmid_rapp_ident_list);
+			sizeof(struct lpfc_vmid_rapp_ident_list) +
+			sizeof(struct entity_id_object);
 		retry = 1;
 		break;
 
@@ -3767,7 +3768,8 @@ lpfc_vmid_cmd(struct lpfc_vport *vport,
 		dap->obj[0].entity_id_len = vmid->vmid_len;
 		memcpy(dap->obj[0].entity_id, vmid->host_vmid, vmid->vmid_len);
 		size = DAPP_IDENT_OFFSET +
-			sizeof(struct lpfc_vmid_dapp_ident_list);
+			sizeof(struct lpfc_vmid_dapp_ident_list) +
+			sizeof(struct entity_id_object);
 		write_lock(&vport->vmid_lock);
 		vmid->flag &= ~LPFC_VMID_REGISTERED;
 		write_unlock(&vport->vmid_lock);
diff --git a/drivers/scsi/lpfc/lpfc_hw.h b/drivers/scsi/lpfc/lpfc_hw.h
index 19b2d2754f32..b2123ec4df88 100644
--- a/drivers/scsi/lpfc/lpfc_hw.h
+++ b/drivers/scsi/lpfc/lpfc_hw.h
@@ -1415,12 +1415,12 @@ struct app_id_object {
 
 struct lpfc_vmid_rapp_ident_list {
 	uint32_t no_of_objects;
-	struct entity_id_object obj[1];
+	struct entity_id_object obj[];
 };
 
 struct lpfc_vmid_dapp_ident_list {
 	uint32_t no_of_objects;
-	struct entity_id_object obj[1];
+	struct entity_id_object obj[];
 };
 
 #define GALLAPPIA_ID_LAST  0x80
-- 
2.34.1

