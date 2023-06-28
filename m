Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2C37417B9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjF1R57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:57:59 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:37780 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjF1R4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:56:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7E6E613F8;
        Wed, 28 Jun 2023 17:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58625C433C8;
        Wed, 28 Jun 2023 17:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687974996;
        bh=ps8O/vvPqe7Ml4jiez90Tc0cMsCWoN+RGXBfPOYX34A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WG4eyi+y/ciMnIh9VHVyG7YzFresIOZuA2+mhnPV1La9FwqYgE2e01/tdVZObtSG6
         Zsd6nqmm2hz+BeWguL/Jgp1VzbT6qpVOiKgHGfocitCOkmJUvV0FJMWCteaCVYBZDL
         owdOva+i9k46ziaBdY+Y8oKnAFxdE7v62qj12oHNFZyHUTxSEGxiw3m4DpC8gZm75b
         ZMTc4zObcE6hLBcpVmIRKet5ElUEPIItC/LF3xPd2hSKA3VE6YhFbT5P+evMcxxIpO
         5pi38cjb+wnWTyDOUO5xJHRmPSmwVRjHSBzK2BpCBX2rmX4d6P/IGqBVNcsZcXK3kx
         /fteion7OzC/g==
Date:   Wed, 28 Jun 2023 11:57:30 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 09/10][next] scsi: aacraid: Replace one-element array with
 flexible-array member in struct sgmap64
Message-ID: <169a28c9e45d1f237308b1ca716122c5d0ee3488.1687974498.git.gustavoars@kernel.org>
References: <cover.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687974498.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace one-element array with flexible-array member in struct
sgmap64 and refactor the rest of the code, accordingly.

Issue found with the help of Coccinelle and audited and fixed,
manually.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/ClangBuiltLinux/linux/issues/1851
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/aacraid/aachba.c  | 9 +++------
 drivers/scsi/aacraid/aacraid.h | 2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index b2849e5cc104..90df697e7c5f 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -1301,8 +1301,7 @@ static int aac_read_block64(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u
 	if (ret < 0)
 		return ret;
 	fibsize = sizeof(struct aac_read64) +
-		((le32_to_cpu(readcmd->sg.count) - 1) *
-		 sizeof (struct sgentry64));
+		  le32_to_cpu(readcmd->sg.count) * sizeof(struct sgentry64);
 	BUG_ON (fibsize > (fib->dev->max_fib_size -
 				sizeof(struct aac_fibhdr)));
 	/*
@@ -1433,8 +1432,7 @@ static int aac_write_block64(struct fib * fib, struct scsi_cmnd * cmd, u64 lba,
 	if (ret < 0)
 		return ret;
 	fibsize = sizeof(struct aac_write64) +
-		((le32_to_cpu(writecmd->sg.count) - 1) *
-		 sizeof (struct sgentry64));
+		  le32_to_cpu(writecmd->sg.count) * sizeof(struct sgentry64);
 	BUG_ON (fibsize > (fib->dev->max_fib_size -
 				sizeof(struct aac_fibhdr)));
 	/*
@@ -2271,8 +2269,7 @@ int aac_get_adapter_info(struct aac_dev* dev)
 			dev->scsi_host_ptr->sg_tablesize =
 				(dev->max_fib_size -
 				sizeof(struct aac_fibhdr) -
-				sizeof(struct aac_write64) +
-				sizeof(struct sgentry64)) /
+				sizeof(struct aac_write64)) /
 					sizeof(struct sgentry64);
 		} else {
 			dev->a_ops.adapter_read = aac_read_block;
diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 3fbc22ae72b6..fb3d93e4a99e 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -517,7 +517,7 @@ struct user_sgmap {
 
 struct sgmap64 {
 	__le32		count;
-	struct sgentry64 sg[1];
+	struct sgentry64 sg[];
 };
 
 struct user_sgmap64 {
-- 
2.34.1

