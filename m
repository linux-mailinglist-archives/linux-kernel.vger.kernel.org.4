Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7D669244
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbjAMJFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbjAMJEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:04:23 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B36755D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:04:05 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o13so18304859pjg.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zt7o8mGSey8mVhw10mPNKPVnAWSwiJUiUWfZxevgFM=;
        b=LvpLZZGyqxgQkhNmzgfZKniI5kjlNpm3T5oc+JklXv39y7j2DiD+um706Aaw+KVRpx
         mZEnqUXu69NW0+HCY23D6Tx8K+e89aF7d8F63qcjQ5/Jn9+jPk5F0vBshiFY2vldec0T
         xfG25TsDWvA93P7uOa8YdrYkMySS4ewd51j2Qlchbp+WVaGdcfjeC2hd+iiHM5gsR8CT
         /YhFYvQfyWYmILwzvekDQhc8byZo2BIjh5qcTNO41J1LloyI6eo04jpf7QRuPCv16HeQ
         SyNff8AdvDosgvCtygrHFQhhxjDx4GWGo77WQ4jGI/p7ztvN/5ugsUwDd/tEnVFG/CsZ
         a02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zt7o8mGSey8mVhw10mPNKPVnAWSwiJUiUWfZxevgFM=;
        b=M/ITYTl+iHzwGo8VlJoUXIRBMPUt+8LG/lWHdyMbz9cANN4tUAxWfNyafbPkCPlkvR
         F8mnDcMAQ3W8xUk//kaZgZ7oZAZWFURXqjfn8aoFoZFpCE+g5Y4anPgSU5HP2+bNOJh/
         uzLy9fKq1eZ4hhaql3SUmJKk/HoFi8YQHBsMh8xbARVeyoNnPOUQEoCw2iZ+p8Enz0mI
         1YtsDFbHGbXqypfgeHh7Gmvxd759Hsf7cFxFTDyr3wekfXJCGe0synF9UU/+ACMTo4GE
         XTfslCgOKQ6r2443vSf+tU1l6K6LHNsTn/9vN4XyXKR+FaVTHHSgnAlNVIApxISRiaXt
         9Eyg==
X-Gm-Message-State: AFqh2kpubLpadAb1KxNz45e95Z5X/e3wjDKHeJzo5yBMfaKm8JmjdKZv
        mvAx3q1i12YSAls7WL/CD24WJoxaMpd2U09uR/VXOw==
X-Google-Smtp-Source: AMrXdXsifyFFGZOyVJ3vdvcqAJ/NB4SkH3SHpN3A9qmrrBoWSh6LxuKjJazYR3ZoS+pxYjBz079LNg==
X-Received: by 2002:a05:6a21:3a45:b0:9d:efbe:e607 with SMTP id zu5-20020a056a213a4500b0009defbee607mr93246543pzb.35.1673600645525;
        Fri, 13 Jan 2023 01:04:05 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id p15-20020a170902e74f00b00189bf5deda3sm13645510plf.133.2023.01.13.01.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 01:04:05 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Jingoo Han <jingoohan1@gmail.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Shunsuke Mie <mie@igel.co.jp>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, Li Chen <lchen@ambarella.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] PCI: dwc: support align_mem() callback for pci_epc_epc
Date:   Fri, 13 Jan 2023 18:03:49 +0900
Message-Id: <20230113090350.1103494-3-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113090350.1103494-1-mie@igel.co.jp>
References: <20230113090350.1103494-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DWC PCIe EPC driver has alignment restriction for mapping as
pci->region_align. Use it to align memory.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index d06654895eba..7a7d7513b612 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -444,6 +444,18 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
 	dw_pcie_stop_link(pci);
 }
 
+static u64 dw_pcie_ep_align_mem(struct pci_epc *epc, u64 addr, size_t *size)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	u64 aaddr;
+
+	aaddr = ALIGN_DOWN(addr, pci->region_align);
+	*size += addr - aaddr;
+
+	return aaddr;
+}
+
 static int dw_pcie_ep_start(struct pci_epc *epc)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -474,6 +486,7 @@ static const struct pci_epc_ops epc_ops = {
 	.set_msix		= dw_pcie_ep_set_msix,
 	.get_msix		= dw_pcie_ep_get_msix,
 	.raise_irq		= dw_pcie_ep_raise_irq,
+	.align_mem		= dw_pcie_ep_align_mem,
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
-- 
2.25.1

