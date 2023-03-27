Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46F56CA88D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjC0PFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjC0PFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:05:38 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB2A30D3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:05:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32RF4YkC115278;
        Mon, 27 Mar 2023 10:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679929474;
        bh=DLARxJLSXFtQS9cMddjuDaqL/7ZyzMy919eU9NUm9jg=;
        h=From:Subject:Date:To:CC;
        b=EazO9qv96Nla2O179AgnRgAuBjAYtDzQBwUs3DBf+ltrJ6/ArEAtNZdz7GdnNBHPI
         RG5KNOhapuwDUlKwxE/Z6g0hReQxcGVlg3Bq4pRrLQL5jWrmenOO9r0MOXgTS/eUTG
         ywm6krgLi4Qk4OJWRR/Z9TWVYY5Hpbx+kQQn7CFU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32RF4YkP084766
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Mar 2023 10:04:34 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 27
 Mar 2023 10:04:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 27 Mar 2023 10:04:33 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32RF4VTj080647;
        Mon, 27 Mar 2023 10:04:31 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH RFC v2 0/2] irqchip: irq-ti-sci-inta: Add initial IRQ
 affinity support
Date:   Mon, 27 Mar 2023 20:34:25 +0530
Message-ID: <20230327-irq-affinity-upstream-v2-0-1474e518f1cb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHmwIWQC/23NQQ6CQAyF4auQrm0Cg2SMWxMP4NawKGNHunCEF
 g2GcHcH1y7/5H15CxirsMGxWED5LSbPlMPtCgg9pTuj3HKDK11d1s6j6IgUoySZPvgabFKmB1K
 1D4eGGq68h2w7MsZOKYV+03/RthuUo8y//ytczido1/ULJGOAo5QAAAA=
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
X-Mailer: b4 0.12.2
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt Aggregator (INTA) IP INTA on TI's K3 SoCs convert DMA global
events (MSI like) to wired interrupts (VINT). 64 events can be mapped to
single VINT. Currently driver maps multiple events to single wired
interrupt line.  This makes setting IRQ affinity impossible as
migrating wired interrupt to different core will end up migrating all
events to that core.  And since DMA events related to networking IPs and
other high IRQ load IPs are behind this INTA logic, it creates load on a
single CPU, thus limiting overall performance of these peripherals

This series add ability to reserve have 1:1 mapping for certain events
(typically networking peripherals) using static soc specific data. These
VINTs are reserved at boot. IRQ affinity is handled at parent IRQ chip
(GIC or INTR - GIC).
This will provide consistent userspace irrespective of module
load/unload or probe order.

Based on discussions at [0]

Since RFC v1:
Rewrite patches to reserve few VINTs for direct mapping.

[0] v1:https://lore.kernel.org/linux-arm-kernel/20230122081607.959474-1-vigneshr@ti.com/#r

---
Vignesh Raghavendra (2):
      irqchip: irq-ti-sci-inta: Allocates VINTs at probe
      irqchip: irq-ti-sci-inta: Add direct mapped interrupts

 drivers/irqchip/irq-ti-sci-inta.c | 289 +++++++---
 1 file changed, 212 insertions(+), 77 deletions(-)
---
base-commit: 011eb7443621f49ca1e8cdf9c74c215f25019118
change-id: 20230327-irq-affinity-upstream-a14c85a5e177

Best regards,
-- 
Vignesh

