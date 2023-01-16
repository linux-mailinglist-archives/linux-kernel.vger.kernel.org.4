Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E69066CFAB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjAPTno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjAPTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:43:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C622C664;
        Mon, 16 Jan 2023 11:43:27 -0800 (PST)
Date:   Mon, 16 Jan 2023 19:43:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673898206;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTL33mkl+z34Nws6m744aZKk/w6dXKgVBTtPQtshBio=;
        b=xC2n5EF1n57WjfSrVASE2pXoUs+DkUBijFE/H3fIYGXyj+FssS3b03D1Vf5/9+3fXITBFk
        bAyeR7mirK215jBfH5hPzuSecB2qZSafJ0DFFJ596UJsJ28VP4uBJepUP30B4uPUKTQTsW
        6sEkpvzeSGObZZCgsaV2h/SIEHA5tcUywohSjmKCAT5jNoto41b6GESe45tyRf2SmdmEVi
        csSNGvxvbXob8eD3IBRWQzBJPDsoBuEcaywSw9B/hwL8aaGZ/MML40xWt50zP9g8oFTt5t
        CePgoI2iFh9BNFsFxI1TCaxYWlb3Ar+hsEIZgvJNpWOpY4Ys9/9nj2zdmSqQ9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673898206;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTL33mkl+z34Nws6m744aZKk/w6dXKgVBTtPQtshBio=;
        b=noz/LJ3P8HK8iK9bsRVBRG70uiU/iBJEjqQMgtp3NnM7CtJsIoN4GNZcxTlt8czcEMr1Qj
        8K9KyfS5OikYDYBQ==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/pci/xen: Set MSI_FLAG_PCI_MSIX support in Xen
 MSI domain
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <4bffa69a949bfdc92c4a18e5a1c3cbb3b94a0d32.camel@infradead.org>
References: <4bffa69a949bfdc92c4a18e5a1c3cbb3b94a0d32.camel@infradead.org>
MIME-Version: 1.0
Message-ID: <167389820601.4906.4662164438390754868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0a3a58de319552525507a3497da86df039a5e4e0
Gitweb:        https://git.kernel.org/tip/0a3a58de319552525507a3497da86df039a=
5e4e0
Author:        David Woodhouse <dwmw2@infradead.org>
AuthorDate:    Sun, 15 Jan 2023 22:14:19=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Jan 2023 20:40:44 +01:00

x86/pci/xen: Set MSI_FLAG_PCI_MSIX support in Xen MSI domain

The Xen MSI =E2=86=92 PIRQ magic does support MSI-X, so advertise it.

(In fact it's better off with MSI-X than MSI, because it's actually
broken by design for 32-bit MSI, since it puts the high bits of the
PIRQ# into the high 32 bits of the MSI message address, instead of the
Extended Destination ID field which is in bits 4-11.

Strictly speaking, this really fixes a much older commit 2e4386eba0c0
("x86/xen: Wrap XEN MSI management into irqdomain") which failed to set
the flag. But that never really mattered until __pci_enable_msix_range()
started to check and bail out early. So in 6.2-rc we see failures e.g.
to bring up networking on an Amazon EC2 m4.16xlarge instance:

[   41.498694] ena 0000:00:03.0 (unnamed net_device) (uninitialized): Failed =
to enable MSI-X. irq_cnt -524
[   41.498705] ena 0000:00:03.0: Can not reserve msix vectors
[   41.498712] ena 0000:00:03.0: Failed to enable and set the admin interrupts

Side note: This is the first bug found, and first patch tested, by running
Xen guests under QEMU/KVM instead of running under actual Xen.

Fixes: 99f3d2797657 ("PCI/MSI: Reject MSI-X early")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/4bffa69a949bfdc92c4a18e5a1c3cbb3b94a0d32.came=
l@infradead.org

---
 arch/x86/pci/xen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index b94f727..7905504 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -433,6 +433,7 @@ static struct msi_domain_ops xen_pci_msi_domain_ops =3D {
 };
=20
 static struct msi_domain_info xen_pci_msi_domain_info =3D {
+	.flags			=3D MSI_FLAG_PCI_MSIX,
 	.ops			=3D &xen_pci_msi_domain_ops,
 };
=20
