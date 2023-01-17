Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8D366E4A0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjAQRPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjAQRPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:15:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF2E4995E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:14:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 834CFB812A2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E857CC433D2;
        Tue, 17 Jan 2023 17:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673975659;
        bh=0RA5VQ07f/HrBMWCFsrbNWImIYN8yY1W6+rD/bVFEv0=;
        h=From:To:Cc:Subject:Date:From;
        b=kE8CMM3yw6tB/dFlycLo5y1IEGrN1ZcuNNP6hupsCPE8UKaOkfnMwVt9nt+PxOypi
         9Rsbcsd4Fe2OzsZyBU1ijgqEBI8P8ISC9TKLWmmnp61rza/PFRHDmE6mem4KUlVZX4
         mG+Jzga7khG/MzhNs4o3UyMDSKpTkJW2OsCiCq7LTnq5YJICrfIm5mCZLbfx2FpYJF
         nNabNAtN0L+edaQKjCyZL6GYu6XB0S1/9wOr5iTcFNTP4zOzXNAUlOSO4q7nbMk703
         zVFTfuYTm+aMxH/1uA4nu7zn41Ltk4pMBojaxR871iQ8hg+0lzcMfnKm+5F9tYv8B6
         ownfd8RjQrBTw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virt: sevguest: add CONFIG_CRYPTO dependency
Date:   Tue, 17 Jan 2023 18:13:56 +0100
Message-Id: <20230117171416.2715125-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This driver fails to link when CRYPTO is disabled, or in a loadable module:

WARNING: unmet direct dependencies detected for CRYPTO_GCM
WARNING: unmet direct dependencies detected for CRYPTO_AEAD2
  Depends on [m]: CRYPTO [=m]
  Selected by [y]:
  - SEV_GUEST [=y] && VIRT_DRIVERS [=y] && AMD_MEM_ENCRYPT [=y]

x86_64-linux-ld: crypto/aead.o: in function `crypto_register_aeads':

Fixes: d63670d23e60 ("virt: sevguest: Rename the sevguest dir and files to sev-guest")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/virt/coco/sev-guest/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
index f9db0799ae67..da2d7ca531f0 100644
--- a/drivers/virt/coco/sev-guest/Kconfig
+++ b/drivers/virt/coco/sev-guest/Kconfig
@@ -2,6 +2,7 @@ config SEV_GUEST
 	tristate "AMD SEV Guest driver"
 	default m
 	depends on AMD_MEM_ENCRYPT
+	select CRYPTO
 	select CRYPTO_AEAD2
 	select CRYPTO_GCM
 	help
-- 
2.39.0

