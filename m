Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E24465D07E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjADKRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjADKRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:17:21 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB81BCE0E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:17:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A8A6B3FB17;
        Wed,  4 Jan 2023 10:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672827438; bh=MLdyNUGqhsrRED5hjRcjh0VIn12dU5ghryHGCfnHNXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SRK2pJSe8FIQQ802ij/JBfeeRQR9w0uoN/kMMc6Z90lZUZ2yWsK0JP1YbkyOUupWn
         bOwUplD5+or6TeojFIlOB8/WrzpsBw7vwbFkNGectMMX2UKX3l5J298llbVGubvlVT
         j3Vzf7wwisCsBsc//+VIB5MSEIAj84SNCisk+hiLKBUsUj172bBEIFDGN+r3r8dd1Q
         +Jtu7soMD7JaSIkpqJB5gpzFhBaNDo2+RnLGguThHgc43kcBcLvjI+f52sYwJc7Fkl
         4Exgw0TwnQOFaOnA1vsUMht1fUT0yYkz9V4uBu+j0FanBrtU1uVj094IgHEq/FAeBi
         H4fBMYHakRcLA==
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Uday Shankar <ushankar@purestorage.com>, asahi@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH] nvme-pci: Add NVME_QUIRK_IDENTIFY_CNS quirk to Apple T2 controllers
Date:   Wed,  4 Jan 2023 19:16:42 +0900
Message-Id: <20230104101641.12215-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230104092148.15578-1-marcan@marcan.st>
References: <20230104092148.15578-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mirrors the quirk added to Apple Silicon controllers in apple.c.
These controllers do not support the Active NS ID List command and
behave identically to the SoC version judging by existing user
reports/syslogs, so will need the same fix. This quirk reverts
back to NVMe 1.0 behavior and disables the broken commands.

Fixes: 811f4de0344d ("nvme: avoid fallback to sequential scan due to transient issues")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Note: this is untested (since probably nobody with a T2 is running
6.2 RCs yet), but given that these controllers share the same firmware
codebase and some other quirks, it is almost certain they regressed
just like the M1/M2 controllers did. Existing syslogs from T2 machines
show the same errors we were getting on M1/M2 prior to the regression,
which points to them having the same issue of treating CNS as a binary
flag as in NVMe 1.0 all along.

Sven has asked some of the T2 folks if they can test a 6.2 RC to verify
the same regression happened, so hopefully we can get confirmation that
this needs fixing (and the fix works), but if we end up getting no
feedback I'd lean towards just getting this applied as a fix since it's
unlikely to break anything and highly likely to fix a regression.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b13baccedb4a..91f8adcf6056 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3495,7 +3495,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
 				NVME_QUIRK_128_BYTES_SQES |
 				NVME_QUIRK_SHARED_TAGS |
-				NVME_QUIRK_SKIP_CID_GEN },
+				NVME_QUIRK_SKIP_CID_GEN |
+				NVME_QUIRK_IDENTIFY_CNS },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
 };
--
2.35.1

