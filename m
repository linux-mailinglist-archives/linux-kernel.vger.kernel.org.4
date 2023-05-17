Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB01A70741E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjEQVWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjEQVWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:22:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91BE93C5;
        Wed, 17 May 2023 14:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2926463F50;
        Wed, 17 May 2023 21:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D3FC433D2;
        Wed, 17 May 2023 21:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684358531;
        bh=+UBNma6+QwyfRTTsSbQ+zHDD3QPnoGuxziYDj6m1XuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yc8dU4J0tcVwCGLSjyi8RGTiECnCafsxjGaY8F+XnNdSSERYxet03Roajsp7Q28/B
         /bzFtVxGzCuLFM3DWHQ4NSZUcmpSUBkE/RPkhLHsczLNARSYJHXuCiqWa8U0PUmyOl
         j0Vs8lcpZG0kkSl0fC2TM8kEsV0tzLpWOJQnI8m0grj9Ln+IVotdDkOM8aN82Knz3y
         +FY1HAXD/98BeGiVmxs82ploHDxgyWw+l+5UFxW1fkalbMCrOv1NKoIks0GzcYqS3o
         dWO22EB5vtHBZk0PO1NYVub58HII6h03jc7y+rzeufa0yJtUA97PbS8Q/CedTaqJ6N
         nCKTX3NbHKaAw==
Date:   Wed, 17 May 2023 15:23:01 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/2][next] scsi: lpfc: Use struct_size() helper
Message-ID: <99e06733f5f35c6cd62e05f530b93107bfd03362.1684358315.git.gustavoars@kernel.org>
References: <cover.1684358315.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684358315.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
 drivers/scsi/lpfc/lpfc_ct.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index e880d127d7f5..3b95c56023bf 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -3748,8 +3748,7 @@ lpfc_vmid_cmd(struct lpfc_vport *vport,
 		rap->obj[0].entity_id_len = vmid->vmid_len;
 		memcpy(rap->obj[0].entity_id, vmid->host_vmid, vmid->vmid_len);
 		size = RAPP_IDENT_OFFSET +
-			sizeof(struct lpfc_vmid_rapp_ident_list) +
-			sizeof(struct entity_id_object);
+			struct_size(rap, obj, rap->no_of_objects);
 		retry = 1;
 		break;
 
@@ -3768,8 +3767,7 @@ lpfc_vmid_cmd(struct lpfc_vport *vport,
 		dap->obj[0].entity_id_len = vmid->vmid_len;
 		memcpy(dap->obj[0].entity_id, vmid->host_vmid, vmid->vmid_len);
 		size = DAPP_IDENT_OFFSET +
-			sizeof(struct lpfc_vmid_dapp_ident_list) +
-			sizeof(struct entity_id_object);
+			struct_size(dap, obj, dap->no_of_objects);
 		write_lock(&vport->vmid_lock);
 		vmid->flag &= ~LPFC_VMID_REGISTERED;
 		write_unlock(&vport->vmid_lock);
-- 
2.34.1

