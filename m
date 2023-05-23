Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DAD70E651
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbjEWUPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjEWUPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:15:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2D5129;
        Tue, 23 May 2023 13:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA75461272;
        Tue, 23 May 2023 20:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10F5C433EF;
        Tue, 23 May 2023 20:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684872921;
        bh=bY6N2RxrtkdOJFb0NaV4w4DW0/gqoN0tnW3Zao2HvYs=;
        h=Date:From:To:Cc:Subject:From;
        b=VtH6B7WzLJnkm8MmBMlZKipm/TbzeB4OX83fSJgoGJ5oQ2CUPK9ftS5U+bOcPV2NY
         K36tlHrkzJQ7hIKjyEP6+eMmgQucr12O4S8p2F9b4ZW/qy6kcOC0yIpMF36HuWlPgL
         erqzRg86D56gfnFn66FoSvOhR935/mVd1ep2Qul4MTE5AXfZomouGrlHCUt8Q1VdO1
         VnzGJj4jYVVecWXH8HALGANFWejiL0IhawonWUGH6apKlvrtXPCqV3xzzEemT6Nqtx
         keZtujjY5IBag47VzYQHcwZmf0abFZM3rWG79aMOVjeCVRhn4P5j6evgtZfzUdPRrj
         IWga5Zh5hVcUg==
Date:   Tue, 23 May 2023 14:16:13 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH v2][next] scsi: lpfc: Use struct_size() helper
Message-ID: <ZG0fDdY/PPQ/ijlt@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer struct_size() over open-coded versions of idiom:

sizeof(struct-with-flex-array) + sizeof(typeof-flex-array-elements) * count

where count is the max number of items the flexible array is supposed to
contain.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use literal 1 in call to struct_size(), instead of rap->no_of_objects
   (Kees Cook). 

v1:
 - Link: https://lore.kernel.org/linux-hardening/99e06733f5f35c6cd62e05f530b93107bfd03362.1684358315.git.gustavoars@kernel.org/

 drivers/scsi/lpfc/lpfc_ct.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index e880d127d7f5..f52aeb73af8d 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -3747,9 +3747,7 @@ lpfc_vmid_cmd(struct lpfc_vport *vport,
 		rap->no_of_objects = cpu_to_be32(1);
 		rap->obj[0].entity_id_len = vmid->vmid_len;
 		memcpy(rap->obj[0].entity_id, vmid->host_vmid, vmid->vmid_len);
-		size = RAPP_IDENT_OFFSET +
-			sizeof(struct lpfc_vmid_rapp_ident_list) +
-			sizeof(struct entity_id_object);
+		size = RAPP_IDENT_OFFSET + struct_size(rap, obj, 1);
 		retry = 1;
 		break;
 
@@ -3767,9 +3765,7 @@ lpfc_vmid_cmd(struct lpfc_vport *vport,
 		dap->no_of_objects = cpu_to_be32(1);
 		dap->obj[0].entity_id_len = vmid->vmid_len;
 		memcpy(dap->obj[0].entity_id, vmid->host_vmid, vmid->vmid_len);
-		size = DAPP_IDENT_OFFSET +
-			sizeof(struct lpfc_vmid_dapp_ident_list) +
-			sizeof(struct entity_id_object);
+		size = DAPP_IDENT_OFFSET + struct_size(dap, obj, 1);
 		write_lock(&vport->vmid_lock);
 		vmid->flag &= ~LPFC_VMID_REGISTERED;
 		write_unlock(&vport->vmid_lock);
-- 
2.34.1

