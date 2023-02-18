Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8412669BDFB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 00:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBRXm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 18:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBRXm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 18:42:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61C913D66
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 15:42:25 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676763744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qt+0zng5Oh6L2knYijsZ26b7cnl+EI19F2XKzZDZ684=;
        b=Eh0ws980tdbReK6Qvx+KSssIYDYL391h+cIpFCZogJ3I8K3ao83qsGEjbbpNe0Sl0QTkv+
        FE1Cu+cYYiOyt+x7v+wrrFx9szKq35DeHPyd24p1i8/rPnlSlJPEq9ppkFz64yt3KFvim5
        68yC8TZXzgVlTegvc85ImxwDrPSuo5MEmaxsOO2RGRKNLyilBxrRQKDI3z0+qLE1s9iipo
        xpK8lC1AjuHX8ylGIeJs3RiFRiIjRn3EHzgWkgUQP5GEI4HW7/pk6CyhuNSy1qBC6KENCi
        /LiKbkTO0Xra6yKyGsyR25XYJJbfHwoOhamCM/eS3pYlUlBZtADN2B1Nd8aR+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676763744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qt+0zng5Oh6L2knYijsZ26b7cnl+EI19F2XKzZDZ684=;
        b=SkhHs/RzgcZc102S5qyShi3jL0XuWynp33KpJoH9PFPbmaJV4K18nL1szJRXq/ZOzt+44M
        nBxoHlYAsZ8mgxCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v6.2
Message-ID: <167676366161.269954.1941292974323519398.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 19 Feb 2023 00:42:23 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-=
02-19

up to:  2b129f0b24ab: PCI/MSI: Provide missing stubs for CONFIG_PCI_MSI=3Dn


A single fix for the PCI/MSI infrastructure:

 The addition of the new alloc/free interfaces in this cycle forgot to
 add stub functions for pci_msix_alloc_irq_at() and pci_msix_free_irq()
 for the CONFIG_PCI_MSI=3Dn case


Thanks,

	tglx

------------------>
Reinette Chatre (1):
      PCI/MSI: Provide missing stubs for CONFIG_PCI_MSI=3Dn


 include/linux/pci.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index adffd65e84b4..254c8a4126a8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1621,6 +1621,18 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned in=
t min_vecs,
 					      flags, NULL);
 }
=20
+static inline struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsi=
gned int index,
+						   const struct irq_affinity_desc *affdesc)
+{
+	struct msi_map map =3D { .index =3D -ENOSYS, };
+
+	return map;
+}
+
+static inline void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map ma=
p)
+{
+}
+
 static inline void pci_free_irq_vectors(struct pci_dev *dev)
 {
 }

