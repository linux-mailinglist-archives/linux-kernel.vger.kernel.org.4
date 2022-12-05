Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07664371B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiLEVmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiLEVlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A4D27904;
        Mon,  5 Dec 2022 13:41:52 -0800 (PST)
Date:   Mon, 05 Dec 2022 21:41:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670276507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHAaAKFaSzlMYMVDJBVPWGjBBLmEsISs8adZvUKpx6k=;
        b=C205CIM9U7BvJzoGZ84nF+0r8gfs0W0vegXvayO1eaz37CYFOv+PwKQ8Fs5iXQ9bnGJLHC
        jDc6FLFqxFEcdUVrstaSK163U3K6Frp5+zNqaNEQ5ByAGZYOihL1mKUrAlpuTb5SIuV62e
        9DnmgeVbR7Enmgdw1muiMb+3pgDp7VKGrg/mojv8fUNLpLXWiHlajDc4XMIZ942Ogq5rJf
        X7dnUDURRJ45RDBiGAXQtIK/7LzLa4EyfGDiyrWJPvQvJgk52GqOj8jMSZoEbvbXN9uL+d
        htoUCxzbxORQKOlQHRGfDP0WwcBfF9BrMmo+osuLdKe+3g3u+MUp9hQ1smZPjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670276507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHAaAKFaSzlMYMVDJBVPWGjBBLmEsISs8adZvUKpx6k=;
        b=WQbPvXp1J2t0sriRYmfi1ZofW7Zwx1Pg0XhQEz3o+vB3Q84OAm7htJsnkF+2/Dw3bu9OtY
        /vMNj5HWXCIpvWAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] x86/apic/msi: Enable MSI_FLAG_PCI_MSIX_ALLOC_DYN
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.787373104@linutronix.de>
References: <20221124232326.787373104@linutronix.de>
MIME-Version: 1.0
Message-ID: <167027650732.4906.2697847868957858271.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     486254ad967dbef37fd797dd296fe69b465aa0f9
Gitweb:        https://git.kernel.org/tip/486254ad967dbef37fd797dd296fe69b465aa0f9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 22:22:34 +01:00

x86/apic/msi: Enable MSI_FLAG_PCI_MSIX_ALLOC_DYN

x86 MSI irqdomains can handle MSI-X allocation post MSI-X enable just out
of the box - on the vector domain and on the remapping domains,

Add the feature flag to the supported feature list

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.787373104@linutronix.de

---
 arch/x86/include/asm/msi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index 7702958..935c6d4 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -63,7 +63,7 @@ struct msi_msg;
 u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid);
 
 #define X86_VECTOR_MSI_FLAGS_SUPPORTED					\
-	(MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MSIX)
+	(MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN)
 
 #define X86_VECTOR_MSI_FLAGS_REQUIRED					\
 	(MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS)
