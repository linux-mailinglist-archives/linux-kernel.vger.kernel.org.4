Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35076DBBF6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 17:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjDHPtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 11:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDHPtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:49:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7E4CA07
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 08:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74FE360AB7
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 15:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4256C433EF;
        Sat,  8 Apr 2023 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680968960;
        bh=0pyF5BprYbz87qK2AZkPwODALXJFq6DUsJqadpHT440=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QEVLzhN5SEkX1+QZq/Bau27bV5Mh9AnbArhHdJyNTVbn9zfH8iAnGGGBoITMNBoN/
         A4Bmgui6JPgoyuvxc2sHGX+q8KPsszDv91VfHzJgJiNfA8NIzDoeqs8X1yrLj34bKD
         HroYGax7WJ+bYG++j11uqGfNrb/+H7RUp+PEoOy5Jf6ZSBcEZ9boFo3Eaei1aUvF0z
         +FHQLQpu0vXtA7lqBBxvuKhQDiiqJ/mgEXjt3KSrSn9O7rBLL0rPg5CuS5MTA953Pp
         R/MNQ4q1u+rEEGFCfpD4VwoEUSTWB/K0i2MPt6N/AKHmUAmQnTVQrfy41NOOTFidnZ
         D6ALlSY8iR3ww==
Received: by pali.im (Postfix)
        id 17A9D1C97; Sat,  8 Apr 2023 17:49:18 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] powerpc/85xx: mpc85xx_ds: Simplify mpc85xx_exclude_device() function
Date:   Sat,  8 Apr 2023 17:48:08 +0200
Message-Id: <20230408154814.10400-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408154814.10400-1-pali@kernel.org>
References: <20230408154814.10400-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

