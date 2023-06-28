Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E725774179E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjF1R4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:56:17 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:37064 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjF1Rzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:55:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3378161447;
        Wed, 28 Jun 2023 17:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09A2C433CB;
        Wed, 28 Jun 2023 17:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687974937;
        bh=7JUyr2dX63IraG+7yBFRgMvzzEv6qsJXwBtXtsyQIRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+poLz5iSuMCS+/NCh2iMU0fnKSOL7K0254QTfODdY9ehKFz7PwZ0L1424dV6bpuP
         LazKhf9sGQAhwjY0vGc/YP9CSllExeuAk22cq1kcd5OpvjpMMYGSX22Fd2SgJsH3QM
         eUknnw01QGNcAYfq3Je4I1bvBkhtMWG/4P2AlqsCZzL4PsbHneJaaYYM+QYuqBPqEi
         2lgDhdhdZweMvvV8udarefvKiJdLy37c42fM/6kgvqXqm6UC5pA0pGKz4Nyvoqfsnc
         RTvctdvyBTOVJj3Ua9ychfylMelEmD7e5rITvKO3qpvQj6FbkxPAUeXATeB8iMMnfg
         Dy1Hz6czDnb4A==
Date:   Wed, 28 Jun 2023 11:56:31 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 06/10][next] scsi: aacraid: Use struct_size() helper in code
 related to struct sgmapraw
Message-ID: <be2e5ecf1c4410ab419e2290341fbc8a0e2ba963.1687974498.git.gustavoars@kernel.org>
References: <cover.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687974498.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer struct_size() over open-coded versions.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/aacraid/aachba.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index b3c0c2255e55..03ba974f6b2a 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -1266,8 +1266,7 @@ static int aac_read_raw_io(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u3
 		if (ret < 0)
 			return ret;
 		command = ContainerRawIo;
-		fibsize = sizeof(struct aac_raw_io) +
-			  le32_to_cpu(readcmd->sg.count) * sizeof(struct sgentryraw);
+		fibsize = struct_size(readcmd, sg.sg, le32_to_cpu(readcmd->sg.count));
 	}
 
 	BUG_ON(fibsize > (fib->dev->max_fib_size - sizeof(struct aac_fibhdr)));
@@ -1400,8 +1399,7 @@ static int aac_write_raw_io(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u
 		if (ret < 0)
 			return ret;
 		command = ContainerRawIo;
-		fibsize = sizeof(struct aac_raw_io) +
-			  le32_to_cpu(writecmd->sg.count) * sizeof(struct sgentryraw);
+		fibsize = struct_size(writecmd, sg.sg, le32_to_cpu(writecmd->sg.count));
 	}
 
 	BUG_ON(fibsize > (fib->dev->max_fib_size - sizeof(struct aac_fibhdr)));
-- 
2.34.1

