Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE73A5E68D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiIVQxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiIVQxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:53:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560C2EB124;
        Thu, 22 Sep 2022 09:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08DB4B83916;
        Thu, 22 Sep 2022 16:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265F7C433D6;
        Thu, 22 Sep 2022 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663865608;
        bh=Tb8Ym6SKz0DJBU5P9QYR//IAXv6Q6jQSGIGCbpUCXyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rV/iE1vfsm1ImiHzuXh7DCL9kB78ZiP71qIOnppVKd+fnxdrlpVnkcDC3nGt53YL2
         hh0tEEFw18AJEMfMAJEghWWU1AwgN9kg1O2B8KQM896qmeahg4IVSdYVYRH5QtnNew
         O5q1LS2PnVhjZAu8nxvT7zEIVE2hq1RBFu1ci45HFaRu4bFd2gcmYbI4B93GLs9vLr
         PoD9AqtwGziH+cJlorgn2IQzjTzBzknNc74C4itROgN8Urwo2SY6A9GRg28S991U3A
         N/W/oC4aEITNJ/MhSDIrmYc/i1IQxZfiSeGGBC3EQQTMv2afY+9YpzGjCH8Wpr8pF3
         Vnt1FaTUcBd9w==
Date:   Thu, 22 Sep 2022 11:53:23 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     HighPoint Linux Team <linux@highpoint-tech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/2][next] scsi: hptiop: Replace one-element array with
 flexible-array member
Message-ID: <6238ccf37798e36d783f5ce5e483e6837e98be79.1663865333.git.gustavoars@kernel.org>
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

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element array with flexible-array
member in struct hpt_iop_request_scsi_command and refactor the rest of the
code, accordingly.

The following pieces of code suggest that the one element of array sg_list
in struct hpt_iop_request_scsi_command is not taken into account when
calculating the total size for both struct hpt_iop_request_scsi_command
and the maximum number of elements sg_list will contain:

1047         req->header.size = cpu_to_le32(
1048                                 sizeof(struct hpt_iop_request_scsi_command)
1049                                  - sizeof(struct hpt_iopsg)
1050                                  + sg_count * sizeof(struct hpt_iopsg));

1400         req_size = sizeof(struct hpt_iop_request_scsi_command)                            1401                 + sizeof(struct hpt_iopsg) * (hba->max_sg_descriptors - 1);

So it's safe to replace the one-element array with a flexible-array
member and update the code above, accordingly: now we don't need to
subtract sizeof(struct hpt_iopsg) from sizeof(struct hpt_iop_request_scsi_command)
because this is implicitly done by the flex-array transformation.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/205
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/hptiop.c | 3 +--
 drivers/scsi/hptiop.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index f18b770626e6..cfc6546e35a6 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -1046,7 +1046,6 @@ static int hptiop_queuecommand_lck(struct scsi_cmnd *scp)
 	req->lun = scp->device->lun;
 	req->header.size = cpu_to_le32(
 				sizeof(struct hpt_iop_request_scsi_command)
-				 - sizeof(struct hpt_iopsg)
 				 + sg_count * sizeof(struct hpt_iopsg));
 
 	memcpy(req->cdb, scp->cmnd, sizeof(req->cdb));
@@ -1398,7 +1397,7 @@ static int hptiop_probe(struct pci_dev *pcidev, const struct pci_device_id *id)
 	host->max_cmd_len = 16;
 
 	req_size = sizeof(struct hpt_iop_request_scsi_command)
-		+ sizeof(struct hpt_iopsg) * (hba->max_sg_descriptors - 1);
+		+ sizeof(struct hpt_iopsg) * hba->max_sg_descriptors;
 	if ((req_size & 0x1f) != 0)
 		req_size = (req_size + 0x1f) & ~0x1f;
 
diff --git a/drivers/scsi/hptiop.h b/drivers/scsi/hptiop.h
index 363d5a16243f..ef2f2aca598c 100644
--- a/drivers/scsi/hptiop.h
+++ b/drivers/scsi/hptiop.h
@@ -228,7 +228,7 @@ struct hpt_iop_request_scsi_command {
 	u8     pad1;
 	u8     cdb[16];
 	__le32 dataxfer_length;
-	struct hpt_iopsg sg_list[1];
+	struct hpt_iopsg sg_list[];
 };
 
 struct hpt_iop_request_ioctl_command {
-- 
2.34.1

