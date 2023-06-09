Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A4E729C6D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbjFIOKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjFIOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:10:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D050D4200;
        Fri,  9 Jun 2023 07:09:50 -0700 (PDT)
Date:   Fri, 09 Jun 2023 14:09:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686319760;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JDj8IzLM0Jtl37BLKjWXAZXxtw67psPlf3t0DxPDuDo=;
        b=P4IQbUFdfX6NtRDMfJE594Kla40bSHV2mCGURzdZa7NY9jPt5CxfcCK5h56MEpFRozC912
        7pDXQNY7odH1DtpU7Qkue04i91DgbXmpr7GgewpiSCQpBYbcvgH/+ud3241nY8JXUXzVNg
        uBKYwK8kG7d4Hj71qOK8UJ8r+quqWQqP5jOUkACG6yQug1hVmNLdQqosdz936zvefdHiDi
        EIh4XFruUpvD+QS5lGsWOgY3obKVKIEu5UDen314L4a4j8nFz4siDrxBzzoieLqA0ONW+B
        dqCzPbvUgocmUkSni/4L3G2yQ8ihhfQ/FZ7Jhq7+mwo66HLAkrj+PwILi25uJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686319760;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JDj8IzLM0Jtl37BLKjWXAZXxtw67psPlf3t0DxPDuDo=;
        b=pNN28+o7WNi7tymYMweYJRysbpH6XrDXBwrh5FbrLBsUm1XGI8N30ZuI4z5JTLri2YBtv2
        whrxyDv/oBF6NdDg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] virt: sevguest: Add CONFIG_CRYPTO dependency
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230117171416.2715125-1-arnd@kernel.org>
References: <20230117171416.2715125-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <168631975954.404.17946185529019055660.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     84b9b44b99780d35fe72ac63c4724f158771e898
Gitweb:        https://git.kernel.org/tip/84b9b44b99780d35fe72ac63c4724f158771e898
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 17 Jan 2023 18:13:56 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 09 Jun 2023 15:53:07 +02:00

virt: sevguest: Add CONFIG_CRYPTO dependency

This driver fails to link when CRYPTO is disabled, or in a loadable
module:

  WARNING: unmet direct dependencies detected for CRYPTO_GCM
  WARNING: unmet direct dependencies detected for CRYPTO_AEAD2
    Depends on [m]: CRYPTO [=m]
    Selected by [y]:
    - SEV_GUEST [=y] && VIRT_DRIVERS [=y] && AMD_MEM_ENCRYPT [=y]

x86_64-linux-ld: crypto/aead.o: in function `crypto_register_aeads':

Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230117171416.2715125-1-arnd@kernel.org
---
 drivers/virt/coco/sev-guest/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
index f9db079..da2d7ca 100644
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
