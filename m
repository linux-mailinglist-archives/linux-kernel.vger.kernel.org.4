Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA80676B90
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 09:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjAVIR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 03:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjAVIR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 03:17:26 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AFB222DA
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 00:17:25 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30M8GoEQ039892;
        Sun, 22 Jan 2023 02:16:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674375410;
        bh=kYHRqnEqZ1qxwcvzfJ33cl40TcqRpaJOwIy9wGR4XGU=;
        h=From:To:CC:Subject:Date;
        b=mN/39yVtf/MVt1QGsl/c3qU0FtdAWKZdFSnniW60n9wrWi+MVZzAwXLKnTBDPtM7o
         AysXC39P7rP0spYvQV00WVxOUMa2RlO38OxrX5x2J2ZUNumglTy3B1G1fiD1g1UjdM
         uhQdYFm+fT+4xzE8uCTJF3gO9Fdnsa4VAmN/1/Iw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30M8Gox1021099
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 22 Jan 2023 02:16:50 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 22
 Jan 2023 02:16:49 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 22 Jan 2023 02:16:49 -0600
Received: from ula0132425.ent.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30M8GjIc079831;
        Sun, 22 Jan 2023 02:16:46 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [RFC PATCH 0/2] irqchip: irq-ti-sci-inta: Add IRQ affinity support
Date:   Sun, 22 Jan 2023 13:46:05 +0530
Message-ID: <20230122081607.959474-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

This series rewrites events to VINT mapping logic to have only one event
mapped to VINT as much as possible. It falls back to aggregating events
when run of unique VINTS.  In most systems there are enough VINTs to not
need aggregation. Also, if IRQ affinity and hint is set by client
driver, such VINTs are reserved and no more events are mapped to those
VINTs.

This allows to implement IRQ affinity callback as simple propagation to
affinity setting to parent irqchip (GIC).

Vignesh Raghavendra (2):
  irqchip: irq-ti-sci-inta: Don't aggregate MSI events until necessary
  irqchip: irq-ti-sci-inta: Introduce IRQ affinity support

 drivers/irqchip/irq-ti-sci-inta.c | 84 +++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 20 deletions(-)

-- 
2.39.0

