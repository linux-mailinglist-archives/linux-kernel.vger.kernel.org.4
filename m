Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C00D6DBE25
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 02:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjDIAJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 20:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDIAJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 20:09:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1298883D9
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 17:09:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A37A60ABE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 00:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9F2C4339B;
        Sun,  9 Apr 2023 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680998961;
        bh=0pyF5BprYbz87qK2AZkPwODALXJFq6DUsJqadpHT440=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U07AaPokjtBAc0C4wIr+iJMgavSe0ByRUzmmXqJlDdYCbUJSH38NDgqI0nNzbcz3w
         xRLhvM3KoZGuNoHiKe7j/w77n8Lk9Xv1kYOQhBICBAiUXPHqE/KEc5xYZ24P4253Dc
         T58A45KCBunC2OGxMpLLjAJXh2kS1yG3yXLDs4hmolj+wG/3ALNnhPKmje/Guspry4
         fqn3bKiQvC1+E2hZ8PGrOO7hpseGM2jWQa0s0HBgYTa0wslyDJ4b126Q+ouOU5pk0h
         Cntrs68Ij/Nek/GDWz8h6ISC7/NnTXnn0fM0V3Mt7UVtMQ34m/wfeXRUob+OoZLnU0
         fDa1zssTDuViQ==
Received: by pali.im (Postfix)
        id 3944F1C97; Sun,  9 Apr 2023 02:09:18 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] powerpc/85xx: mpc85xx_ds: Simplify mpc85xx_exclude_device() function
Date:   Sun,  9 Apr 2023 02:08:06 +0200
Message-Id: <20230409000812.18904-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230409000812.18904-1-pali@kernel.org>
References: <20230409000812.18904-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function mpc85xx_exclude_device() is installed and used only when
pci_with_uli is fsl_pci_primary. So replace check for pci_with_uli by
fsl_pci_primary in mpc85xx_exclude_device() and move pci_with_uli variable
declaration into function mpc85xx_ds_uli_init() where it is used.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index ed7b71d55b10..0c905a838942 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -108,12 +108,10 @@ void __init mpc85xx_ds_pic_init(void)
 }
 
 #ifdef CONFIG_PCI
-static struct device_node *pci_with_uli;
-
 static int mpc85xx_exclude_device(struct pci_controller *hose,
 				   u_char bus, u_char devfn)
 {
-	if (hose->dn == pci_with_uli)
+	if (hose->dn == fsl_pci_primary)
 		return uli_exclude_device(hose, bus, devfn);
 
 	return PCIBIOS_SUCCESSFUL;
@@ -124,6 +122,7 @@ static void __init mpc85xx_ds_uli_init(void)
 {
 #ifdef CONFIG_PCI
 	struct device_node *node;
+	struct device_node *pci_with_uli;
 
 	/* See if we have a ULI under the primary */
 
-- 
2.20.1

