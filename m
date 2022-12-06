Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706B66442C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiLFL7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiLFL6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:58:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A1286FB;
        Tue,  6 Dec 2022 03:57:58 -0800 (PST)
Date:   Tue, 06 Dec 2022 11:57:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670327876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ng/LNbhDzxZQgxT8OoCtHu1I5ZIbZUJTJ9AIa13S1w=;
        b=pHzgrHtxN28tIu6L7f0id02HAlMG2N8bYyJwXQs7nEIK4NRMOhz0LtO08Xa119YksXG+0P
        FYECwnMaVKVA443XMzDioQ/aXsEUWT1ka/DJ09WVAVURS37avxIu+if91h+q/kFyu65q+j
        npbIFzLdLdJK3ZO4eiPs48Uf1gYGd2pUoq6Ae8FtksCB5sJR0DVDbxCh79HvJiYPFwKMTO
        ApzE55PYxAiXi5mxmkJMkBa8Xhp7K8sQ79Ldew6LvDfe+r3WJENhnC8XLx1AqjW3+oLt34
        yK2Nk2N5R/cLYFGl9lrA9lXTXh6NqyCEQW7wYj9Tf32GNDYQUrVQ61bowiay6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670327876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ng/LNbhDzxZQgxT8OoCtHu1I5ZIbZUJTJ9AIa13S1w=;
        b=MiEj5BBgE0owB/ni48YA1ckUJP0tIAhHhWM2OcnFixv3ZUtQrVFQeORNdrMDrDwg9iz7bu
        CnUpt+5rwv+jRIAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v2m: Include arm-gic-common.h
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221121140048.470680255@linutronix.de>
References: <20221121140048.470680255@linutronix.de>
MIME-Version: 1.0
Message-ID: <167032787643.4906.14992962434440513220.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     72a3f8f22a36aaf05da8941535d1c553fe049b2b
Gitweb:        https://git.kernel.org/tip/72a3f8f22a36aaf05da8941535d1c553fe0=
49b2b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 21 Nov 2022 15:39:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 Dec 2022 12:50:17 +01:00

irqchip/gic-v2m: Include arm-gic-common.h

W=3D1 build complains:

drivers/irqchip/irq-gic-v2m.c:570:12: warning: no previous prototype for =E2=
=80=98gicv2m_init=E2=80=99 [-Wmissing-prototypes]
  570 | int __init gicv2m_init(struct fwnode_handle *parent_handle,

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221121140048.470680255@linutronix.de

---
 drivers/irqchip/irq-gic-v2m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 6e1ac33..fcc871a 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/irqchip/arm-gic-common.h>
=20
 /*
 * MSI_TYPER:
