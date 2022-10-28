Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508F3610AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJ1GrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJ1GqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:46:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BC21BE932;
        Thu, 27 Oct 2022 23:43:14 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:43:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939389;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/AwNFqOWTlu3ckteTP0xnDuHtpt1peKf1P8IqbpEvhA=;
        b=LVmjIJk69zkJDINXCqRe04IiDcmRR+CVI++soorbt7Qpi+ZDnWORdM+jNXhrzPIoi5Opxe
        vrvO2pjrCV6kiyLNw7xHuoPk8V8wS5C5eXFZeo18LrHOJ6xacUmAuuQ0qentcS/3OLgU/G
        PKlt5RAP2w7aVbSiVG/jrFXhI0qyoOD35Qc/tXbp9Ql/srHcblGi2EfWpqHbu1IZAoYhrc
        jnCJSS878I92JYy66+2QO2rdVxsPmTP/JmmrHV1M57iIiS4MbIXLgYB427Cy0Qq8Yv/a5G
        XLloNSzBAWlPGGKXU0SyoBKBBMMk2nIYK0YmqnydU9Sg2xFR1gWNXnl+DmexRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939389;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/AwNFqOWTlu3ckteTP0xnDuHtpt1peKf1P8IqbpEvhA=;
        b=QJmvcukZvE83K7C4w+8fXiJI3LqunT8Kwr6TNd+8eP28znf/xgeB7U8pia0CiWcPSZeZdA
        OjxF0b4uxAgfGuDg==
From:   "tip-bot2 for Rafael Mendonca" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt/sev-guest: Remove unnecessary free in init_crypto()
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221018015425.887891-1-rafaelmendsr@gmail.com>
References: <20221018015425.887891-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Message-ID: <166693938775.29415.2368858785626989918.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     c6fbb759d68898aad40e57d09ed18df6094a1874
Gitweb:        https://git.kernel.org/tip/c6fbb759d68898aad40e57d09ed18df6094a1874
Author:        Rafael Mendonca <rafaelmendsr@gmail.com>
AuthorDate:    Mon, 17 Oct 2022 22:54:25 -03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 27 Oct 2022 14:24:18 +02:00

virt/sev-guest: Remove unnecessary free in init_crypto()

If the memory allocation for the auth tag fails, then there is no need
to free it.

Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221018015425.887891-1-rafaelmendsr@gmail.com
---
 drivers/virt/coco/sev-guest/sev-guest.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index f422f9c..e9704ae 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -152,12 +152,10 @@ static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *k
 	crypto->a_len = crypto_aead_authsize(crypto->tfm);
 	crypto->authtag = kmalloc(crypto->a_len, GFP_KERNEL_ACCOUNT);
 	if (!crypto->authtag)
-		goto e_free_auth;
+		goto e_free_iv;
 
 	return crypto;
 
-e_free_auth:
-	kfree(crypto->authtag);
 e_free_iv:
 	kfree(crypto->iv);
 e_free_crypto:
