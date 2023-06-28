Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572BC7417B1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjF1R5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjF1R4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:56:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFD426B7;
        Wed, 28 Jun 2023 10:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9B2261426;
        Wed, 28 Jun 2023 17:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB67C433C0;
        Wed, 28 Jun 2023 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687974979;
        bh=oURmBWezquiCxtgzQofhLG2vCq/AGJynRcxtSxdHtso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kutrpgvcj50b2E0D25+J+Q1Qzv+1OZq6w/2/qYqixf1eZbltUDqp0P0utmW2fLHgI
         1g+flEQ6xrEepEkkuv+wr7qu3DYNxUpD1TBOlg8xFN1TZb8b9gHuzEOEnDAiWC7EHz
         wAEFETeWqMRdqTqpEk2Y9G5wQBGCfRgSIEoD7+W7xaabLbj71RF4b3RJTy60j0NEQ5
         gIvMhuPy1/5A6cHNbArJlNCF1EqgXT4giwrXIPOdf+FpeRhS3FXsHd4ynapG7RkWqA
         SgUlCifBVQTU6L1IrEORnAO8ET/RNVlYdm18rgjICXK49Hg5rVk4ICxOvKlrqeSA1H
         183vSoEdJzxIQ==
Date:   Wed, 28 Jun 2023 11:57:13 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 08/10][next] scsi: aacraid: Replace one-element array with
 flexible-array member in struct sgmap
Message-ID: <0c7402fe6448186cda5a2618a35eb5f8d1cbb313.1687974498.git.gustavoars@kernel.org>
References: <cover.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687974498.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace one-element array with flexible-array member in struct
sgmap and refactor the rest of the code, accordingly.

Issue found with the help of Coccinelle and audited and fixed,
manually.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/ClangBuiltLinux/linux/issues/1851
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/aacraid/aachba.c   | 24 ++++++++++--------------
 drivers/scsi/aacraid/aacraid.h  |  2 +-
 drivers/scsi/aacraid/commctrl.c |  4 ++--
 drivers/scsi/aacraid/comminit.c |  3 +--
 4 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 03ba974f6b2a..b2849e5cc104 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -1336,8 +1336,7 @@ static int aac_read_block(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u32
 	if (ret < 0)
 		return ret;
 	fibsize = sizeof(struct aac_read) +
-			((le32_to_cpu(readcmd->sg.count) - 1) *
-			 sizeof (struct sgentry));
+		  le32_to_cpu(readcmd->sg.count) * sizeof(struct sgentry);
 	BUG_ON (fibsize > (fib->dev->max_fib_size -
 				sizeof(struct aac_fibhdr)));
 	/*
@@ -1471,8 +1470,7 @@ static int aac_write_block(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u3
 	if (ret < 0)
 		return ret;
 	fibsize = sizeof(struct aac_write) +
-		((le32_to_cpu(writecmd->sg.count) - 1) *
-		 sizeof (struct sgentry));
+		  le32_to_cpu(writecmd->sg.count) * sizeof(struct sgentry);
 	BUG_ON (fibsize > (fib->dev->max_fib_size -
 				sizeof(struct aac_fibhdr)));
 	/*
@@ -1590,9 +1588,9 @@ static int aac_scsi_64(struct fib * fib, struct scsi_cmnd * cmd)
 	/*
 	 *	Build Scatter/Gather list
 	 */
-	fibsize = sizeof (struct aac_srb) - sizeof (struct sgentry) +
-		((le32_to_cpu(srbcmd->sg.count) & 0xff) *
-		 sizeof (struct sgentry64));
+	fibsize = sizeof(struct aac_srb) +
+		  (le32_to_cpu(srbcmd->sg.count) & 0xff) *
+		  sizeof(struct sgentry64);
 	BUG_ON (fibsize > (fib->dev->max_fib_size -
 				sizeof(struct aac_fibhdr)));
 
@@ -1621,9 +1619,9 @@ static int aac_scsi_32(struct fib * fib, struct scsi_cmnd * cmd)
 	/*
 	 *	Build Scatter/Gather list
 	 */
-	fibsize = sizeof (struct aac_srb) +
-		(((le32_to_cpu(srbcmd->sg.count) & 0xff) - 1) *
-		 sizeof (struct sgentry));
+	fibsize = sizeof(struct aac_srb) +
+		  (le32_to_cpu(srbcmd->sg.count) & 0xff) *
+		  sizeof(struct sgentry);
 	BUG_ON (fibsize > (fib->dev->max_fib_size -
 				sizeof(struct aac_fibhdr)));
 
@@ -1691,8 +1689,7 @@ static int aac_send_safw_bmic_cmd(struct aac_dev *dev,
 	fibptr->hw_fib_va->header.XferState &=
 		~cpu_to_le32(FastResponseCapable);
 
-	fibsize  = sizeof(struct aac_srb) - sizeof(struct sgentry) +
-						sizeof(struct sgentry64);
+	fibsize  = sizeof(struct aac_srb) + sizeof(struct sgentry64);
 
 	/* allocate DMA buffer for response */
 	addr = dma_map_single(&dev->pdev->dev, xfer_buf, xfer_len,
@@ -2264,8 +2261,7 @@ int aac_get_adapter_info(struct aac_dev* dev)
 		dev->a_ops.adapter_bounds = aac_bounds_32;
 		dev->scsi_host_ptr->sg_tablesize = (dev->max_fib_size -
 			sizeof(struct aac_fibhdr) -
-			sizeof(struct aac_write) + sizeof(struct sgentry)) /
-				sizeof(struct sgentry);
+			sizeof(struct aac_write)) / sizeof(struct sgentry);
 		if (dev->dac_support) {
 			dev->a_ops.adapter_read = aac_read_block64;
 			dev->a_ops.adapter_write = aac_write_block64;
diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 94eb83d38be6..3fbc22ae72b6 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -507,7 +507,7 @@ struct sge_ieee1212 {
 
 struct sgmap {
 	__le32		count;
-	struct sgentry	sg[1];
+	struct sgentry	sg[];
 };
 
 struct user_sgmap {
diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index e7cc927ed952..df811ad4afaa 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -561,8 +561,8 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 		rcode = -EINVAL;
 		goto cleanup;
 	}
-	actual_fibsize = sizeof(struct aac_srb) - sizeof(struct sgentry) +
-		((user_srbcmd->sg.count & 0xff) * sizeof(struct sgentry));
+	actual_fibsize = sizeof(struct aac_srb) +
+		(user_srbcmd->sg.count & 0xff) * sizeof(struct sgentry);
 	actual_fibsize64 = actual_fibsize + (user_srbcmd->sg.count & 0xff) *
 	  (sizeof(struct sgentry64) - sizeof(struct sgentry));
 	/* User made a mistake - should not continue */
diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
index bd99c5492b7d..d8dd89c87b01 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -523,8 +523,7 @@ struct aac_dev *aac_init_adapter(struct aac_dev *dev)
 	dev->max_fib_size = sizeof(struct hw_fib);
 	dev->sg_tablesize = host->sg_tablesize = (dev->max_fib_size
 		- sizeof(struct aac_fibhdr)
-		- sizeof(struct aac_write) + sizeof(struct sgentry))
-			/ sizeof(struct sgentry);
+		- sizeof(struct aac_write)) / sizeof(struct sgentry);
 	dev->comm_interface = AAC_COMM_PRODUCER;
 	dev->raw_io_interface = dev->raw_io_64 = 0;
 
-- 
2.34.1

