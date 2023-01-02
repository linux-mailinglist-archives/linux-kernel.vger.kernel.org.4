Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB05065AD2E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 06:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjABFMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 00:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjABFKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 00:10:42 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E903E5F84
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 21:08:42 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230102050840epoutp02d205aff25a51cd8eaf050ab1da3a0792~2ZbCgDjGQ1845618456epoutp02I
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 05:08:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230102050840epoutp02d205aff25a51cd8eaf050ab1da3a0792~2ZbCgDjGQ1845618456epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672636120;
        bh=QuTmYE28MUecwpy1+68iyqX/b1xd0I8r7MjhXIX+ErA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=J5TqYZgRlXfjecOSxm3Y4BjXRghOHsLhpi2PP7NlnQD+7v4SRbRTzdSxkYJaMDsdD
         59i8zXz5ny56tPi8Q9h+rpBF+DegAbpIKFC5HhJxSHJVgowI63eauzuCGPnLBm9TLI
         kP2sOzEk/1cDK5OvLL24EVo5eD0aQcjkmR1wU9XQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230102050840epcas2p480bbcdb30003e8d21989f6749436ffe2~2ZbCB9aog2715427154epcas2p4-;
        Mon,  2 Jan 2023 05:08:40 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NlkRD0Qwqz4x9Q8; Mon,  2 Jan
        2023 05:08:40 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.3C.15497.7D662B36; Mon,  2 Jan 2023 14:08:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230102050839epcas2p4b9d09d926f9a14c3b8e8df2574d334c3~2ZbBVCKeh3229832298epcas2p4I;
        Mon,  2 Jan 2023 05:08:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230102050839epsmtrp1d67c37d7ee0b27b3e64180842a7b72e7~2ZbBUUyvD1063610636epsmtrp1y;
        Mon,  2 Jan 2023 05:08:39 +0000 (GMT)
X-AuditID: b6c32a48-225ff70000023c89-6d-63b266d79048
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.C8.02211.7D662B36; Mon,  2 Jan 2023 14:08:39 +0900 (KST)
Received: from PlatFormDev3.dsn.sec.samsung.com (unknown [10.166.246.26]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230102050839epsmtip1211b1f9fbfc0c19521ee465b336f03c4~2ZbBHEVlF0461604616epsmtip1E;
        Mon,  2 Jan 2023 05:08:39 +0000 (GMT)
From:   JaeHun Jung <jh0801.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Seungchull Suh <sc.suh@samsung.com>,
        Daehwan Jung <dh10.jung@samsung.com>,
        JaeHun Jung <jh0801.jung@samsung.com>
Subject: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Date:   Mon,  2 Jan 2023 14:08:31 +0900
Message-Id: <20230102050831.105499-1-jh0801.jung@samsung.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmqe71tE3JBl9v21gca3vCbnFnwTQm
        i+bF69ks7j78wWJxedccNotFy1qZLbru3mB0YPfYtKqTzWP/3DXsHn1bVjF6fN4kF8ASlW2T
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SBkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE7o3fD
        ZcaC69IVjya2sTUwrhXrYuTkkBAwkVj94wUziC0ksINRYsLMyC5GLiD7E6PEoh9HmCGcb4wS
        jc8fssF0TD76hQ0isZdRYtqrF4wQzj9GiePvLoDNYhPQltg3ZxE7iC0iECYxcdk+FpAiZoHb
        jBIr5l1gBEkIC7hI3Hj+EqyBRUBV4tPqq2ANvAK2ElNm7WCHWCcvcfrENUaIuKDEyZlPWEBs
        ZqB489bZYPdJCJxil7g/bSpQAweQ4yKxapsQRK+wxKvjW6DmSEm87G+DsrMldm14wwxhV0j0
        9C9jgbCNJWY9a2cEGcMsoCmxfpc+xERliSO3oLbySXQc/gu1iFeiow1qkarEwcabUEOkJb71
        vmOEsD0kuvpa2SGhGyvRcGIB6wRG+VlIfpmF5JdZCHsXMDKvYhRLLSjOTU8tNiowgcdpcn7u
        JkZwGtTy2ME4++0HvUOMTByMhxglOJiVRHgvf16XLMSbklhZlVqUH19UmpNafIjRFBi6E5ml
        RJPzgYk4ryTe0MTSwMTMzNDcyNTAXEmcN2jr/GQhgfTEktTs1NSC1CKYPiYOTqkGpoM5TCp7
        bub+3bd+sdzeA26SOVfSZO2OMVjfP1da/vrwi+9Lv6zufBuadsKstyNt52GzQ0UeJmWH5PT1
        4k+KnJOdbN3EadY0Tdj27B31C4Fp15tmtn2SmBQb0+N1NGjmuxLZMxkKPgtT6sVffec4evy8
        zfvcOsMIPibBec9PcW7eedB/UvWRkoYTz+L/Tt9f/pzp8EO/YJfWEpa13Sq9G9/Pnu30psBT
        c8e2vKzz4hIeG448sdENyXQT2JYy6eaUvGeSMuU/7TsPz01wqrJ6tC7RaVdX40S2U+/WpcUv
        yMz1uN8p3Z675+yF2aknkrWSLy/8buoUsHPperMcQ4va7/m834u08ni3fjxccen+PCWW4oxE
        Qy3mouJEAHNHThEMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnO71tE3JBl/OyFkca3vCbnFnwTQm
        i+bF69ks7j78wWJxedccNotFy1qZLbru3mB0YPfYtKqTzWP/3DXsHn1bVjF6fN4kF8ASxWWT
        kpqTWZZapG+XwJXRu+EyY8F16YpHE9vYGhjXinUxcnJICJhITD76ha2LkYtDSGA3o8T/Z73M
        EAlpiZ2dU5kgbGGJ+y1HWCGK/jBKfDg+jQUkwSagLbFvziJ2EFtEIEzi36OLLCBFzAJ3GSWa
        TkxkA0kIC7hI3Hj+Emwqi4CqxKfVV8EaeAVsJabM2sEOsUFe4vSJa4wQcUGJkzOfgC1gBoo3
        b53NPIGRbxaS1CwkqQWMTKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYLDU0tzB+P2
        VR/0DjEycTAeYpTgYFYS4b38eV2yEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tS
        s1NTC1KLYLJMHJxSDUxXZpldT/ic/Uj5+J+c/7k/tvzh33qixzVC3vnrAg2+26IF6rVrF2jN
        rK1r0/zUu9ZHkc9LV27iJPXE9VeFWz/E/lffWaK6lH2KZXrguyvK1+daCB+7xfshWr7ZUKT7
        8ku+nwxnWhj7ph3+drlr9qPkuvrHOso5E6ZP7w64vvDX67R+6ee3tHedfiMY8ScgPtltR6N0
        76UXs5+t6tU6lCaqEn7vu5vymdZ7OY2dmcmKxUeNAlfd4b1lPHm6u0rXp1WRFzzSXQUXRUTb
        /GhoqPp08b9KbKqxvfHGD3wl+78YPXFcdvvEtn+J/W+luRZf17xutELH2jyxdQL/vhn80q0G
        O5ZdehMTlRV/vpL91SYlluKMREMt5qLiRABaTgyIvgIAAA==
X-CMS-MailID: 20230102050839epcas2p4b9d09d926f9a14c3b8e8df2574d334c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230102050839epcas2p4b9d09d926f9a14c3b8e8df2574d334c3
References: <CGME20230102050839epcas2p4b9d09d926f9a14c3b8e8df2574d334c3@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes very rarely, The count is 0 and the DWC3 flag is set has status.
It must not have these status. Because, It can make happen interrupt storming
status.
So, It have to clean up DWC3_EVENT_PENDING flags set when count is 0.
It means "There are no interrupts to handle.".

(struct dwc3_event_buffer *) ev_buf = 0xFFFFFF883DBF1180 (
	(void *) buf = 0xFFFFFFC00DBDD000 = end+0x337D000,
	(void *) cache = 0xFFFFFF8839F54080,
	(unsigned int) length = 0x1000,
	(unsigned int) lpos = 0x0,
	(unsigned int) count = 0x0,
	(unsigned int) flags = 0x00000001,
	(dma_addr_t) dma = 0x00000008BD7D7000,
	(struct dwc3 *) dwc = 0xFFFFFF8839CBC880,
	(u64) android_kabi_reserved1 = 0x0),

(time = 47557628930999, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628931268, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
(time = 47557628932383, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628932652, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
(time = 47557628933768, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628934037, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
(time = 47557628935152, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628935460, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
(time = 47557628936575, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628936845, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
(time = 47557628937960, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628938229, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
(time = 47557628939345, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628939652, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
(time = 47557628940768, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628941037, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
(time = 47557628942152, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628942422, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
(time = 47557628943537, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628943806, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
(time = 47557628944922, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628945229, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
(time = 47557628946345, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628946614, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
(time = 47557628947729, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628947999, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),

Signed-off-by: JaeHun Jung <jh0801.jung@samsung.com>
---
 drivers/usb/dwc3/gadget.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 789976567f9f..5d2d5a9b9915 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4355,8 +4355,11 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	 * irq event handler completes before caching new event to prevent
 	 * losing events.
 	 */
-	if (evt->flags & DWC3_EVENT_PENDING)
+	if (evt->flags & DWC3_EVENT_PENDING) {
+		if (!evt->count)
+			evt->flags &= ~DWC3_EVENT_PENDING;
 		return IRQ_HANDLED;
+	}
 
 	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
 	count &= DWC3_GEVNTCOUNT_MASK;
-- 
2.31.1

