Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B5E5E68E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIVQzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiIVQzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:55:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077D8EBBE7;
        Thu, 22 Sep 2022 09:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C11F61174;
        Thu, 22 Sep 2022 16:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA108C433D6;
        Thu, 22 Sep 2022 16:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663865740;
        bh=1N0rd5RJ3Ul9SCZ4T2rRaDizkLin0KOSZngzGl1tosk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sz3IdCtAkGCeVQJZJuUVgCYBOrm9+IRz+B7j3I97RQglT1VCfWEzKsCJ15/d4iih3
         2tAmgwDaovv14B4N5idxwI22tQsyaoXYrrNkh0ExD4v65h9z3JaVvOE63uPPUECywy
         /zyz4snqs6yoSe/YS2Za9fg6nMsNyKPZkTUnt5UXp5KbBMDdw/+ZXZ31muB9fhMwrw
         Q7DCR4urmApykWCl8ezAXmnXebe18r1Q3KbPuivdrVkYb9wcb+31SJTJYn3jXRgRJt
         Xa6fIak4jjfNsenc6Nz9RJ6i1QZQ0X9CeAALigXUX6YUbXnV8IjRL7i0eghWJ+zGjL
         BeEkZV9hY2GEw==
Date:   Thu, 22 Sep 2022 11:55:33 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     HighPoint Linux Team <linux@highpoint-tech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/2][next] scsi: hptiop: Use struct_size() helper in code
 related to struct hpt_iop_request_scsi_command
Message-ID: <54e2bb1e39b21394c5a90cacbadfb6136b012788.1663865333.git.gustavoars@kernel.org>
References: <cover.1663865333.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663865333.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/scsi/hptiop.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index cfc6546e35a6..7e8903718245 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -1044,9 +1044,7 @@ static int hptiop_queuecommand_lck(struct scsi_cmnd *scp)
 	req->channel = scp->device->channel;
 	req->target = scp->device->id;
 	req->lun = scp->device->lun;
-	req->header.size = cpu_to_le32(
-				sizeof(struct hpt_iop_request_scsi_command)
-				 + sg_count * sizeof(struct hpt_iopsg));
+	req->header.size = cpu_to_le32(struct_size(req, sg_list, sg_count));
 
 	memcpy(req->cdb, scp->cmnd, sizeof(req->cdb));
 	hba->ops->post_req(hba, _req);
@@ -1396,8 +1394,8 @@ static int hptiop_probe(struct pci_dev *pcidev, const struct pci_device_id *id)
 	host->cmd_per_lun = le32_to_cpu(iop_config.max_requests);
 	host->max_cmd_len = 16;
 
-	req_size = sizeof(struct hpt_iop_request_scsi_command)
-		+ sizeof(struct hpt_iopsg) * hba->max_sg_descriptors;
+	req_size = struct_size((struct hpt_iop_request_scsi_command *)0,
+			       sg_list, hba->max_sg_descriptors);
 	if ((req_size & 0x1f) != 0)
 		req_size = (req_size + 0x1f) & ~0x1f;
 
-- 
2.34.1

