Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DB97417B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjF1R6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:58:18 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:38110 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjF1R4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:56:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8435F61425;
        Wed, 28 Jun 2023 17:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20271C433C0;
        Wed, 28 Jun 2023 17:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687975014;
        bh=td4cyQQksCxGhpEodkvmN0yoaLrNPgSUoTLfY9rGDgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fB+3roWxpteaF0aMShsipBAj4bahjfCFQctyoGq3B5zVfMEaqDe1n2TIWQmB68bxh
         48BVgJYR8oLZtdVm9fFLMMr95TUufrtPx/eLi4IEMv9AXbOnvJvD4KVPQWbVt2egTH
         1DINJwCnOgM2gFFjZM/r5lJ1Cd4Gu8d+9gqYl1sPHBKSNR0y74nuNdMkq+S7DHkAWx
         3le0rEcZPDCBQY/VD5LtH7yfMFOgW41OqkK5b2DHNEdy92QVcRV0j/sEuFiL3hGC8p
         UUcqI+BTPD6vtl7oZwqtj1HSBRPa9aVbPOWeGMokq/ZMyluYqtGbomLM/sMeLxBYlD
         HewzNxyoc1/xA==
Date:   Wed, 28 Jun 2023 11:57:48 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 10/10][next] scsi: aacraid: Replace one-element array with
 flexible-array member in struct user_sgmap
Message-ID: <2ebb702f25c4764fb36ab29f4f40728e12b0e42b.1687974498.git.gustavoars@kernel.org>
References: <cover.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687974498.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace one-element array with flexible-array member in struct
user_sgmap and refactor the rest of the code, accordingly.

Issue found with the help of Coccinelle and audited and fixed,
manually.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/ClangBuiltLinux/linux/issues/1851
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/aacraid/aacraid.h  | 2 +-
 drivers/scsi/aacraid/commctrl.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index fb3d93e4a99e..7d3f2f7348ff 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -512,7 +512,7 @@ struct sgmap {
 
 struct user_sgmap {
 	u32		count;
-	struct user_sgentry	sg[1];
+	struct user_sgentry	sg[];
 };
 
 struct sgmap64 {
diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index df811ad4afaa..74eb33eb70d3 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -523,7 +523,7 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 		goto cleanup;
 	}
 
-	if ((fibsize < (sizeof(struct user_aac_srb) - sizeof(struct user_sgentry))) ||
+	if ((fibsize < sizeof(struct user_aac_srb)) ||
 	    (fibsize > (dev->max_fib_size - sizeof(struct aac_fibhdr)))) {
 		rcode = -EINVAL;
 		goto cleanup;
-- 
2.34.1

