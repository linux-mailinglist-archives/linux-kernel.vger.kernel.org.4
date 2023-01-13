Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9425466923E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbjAMJFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240978AbjAMJEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:04:08 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BBE74585
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:03:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o13so18304559pjg.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2IGTDiZZXtJu9cR7T8erEmC5AfST+0ZDpypGxRmfERY=;
        b=LRJ3p9XiclsVeIR3PUf7eY8K7aD9yrcYSJDDVcXjRarKOLB+UrAGGjl2s2fiCl78Pv
         xkG0NCT9d4jpNm2RJjIxJgPhG4sFMynJX+uaZYf2L2so0Bc6U2OiNsQurAuwyvrg95dw
         4DZDPs656oolqZdRZJkqT7rDYPI1zOy/6l96FymZLJXetlBY9XBAi9ZRVoHWTxsqfl0/
         oIM+dLDZ+TXsUb2A18u0Fw9R8T49Q8qe8wT6ZyAdpsjb1TKmjKYfq1jG5iWVRMo3zbDC
         w1HJ+v0O1CQa828lig78yqXcTDedtaRnnXV5uY13Chkt/Jznpah1jMk2p/1uLJ7iNDCq
         hNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IGTDiZZXtJu9cR7T8erEmC5AfST+0ZDpypGxRmfERY=;
        b=ppUij1h9MnShGm5570CYITqO8k2/YbCdRBF9U/gZ6fc+9oqeplRz/ppT4i1nr4OPsa
         NSBu+Fg/pz2TQSu4lJ0FLoywyhOKI0ULZtTut0HCRM2mT47rEIr0A8sRz5LItGlDE55I
         Je3epxPpcnXLF0LNEXqMZX15ZiM/DwDv6L3QvIC0CvmRdmoHhWwRo81YHDcovro13Nf/
         IqIZQUwbn8rQ3LijNXiaR94rZngTrUkqp69+xOOIuqwKwxLza3mwQ0yO78sAFd9wlcT1
         iqgVVQfsooVC/p19DT3c4GdcM3jtYhO7xEzkpMXCT5D6JpCMPf74W5K1zMx1MVJJt1Pi
         5Qwg==
X-Gm-Message-State: AFqh2koOjOyexy30PaXzU1oSaKzZsMl+zJ7McnhBEjb+DRHgG+7/HTIY
        IPX1z6xsJP3ROf/JiP6PvKh9cgh/aV67nVjv1Gou0A==
X-Google-Smtp-Source: AMrXdXtpZSgowNq73sjmSDHhDEN5OcDqcZlw7Rr6wKeiNZQk/sUbNQwMNnjflJMQTGU/aJ4BUP8n/w==
X-Received: by 2002:a17:902:e8d4:b0:192:6b23:e38b with SMTP id v20-20020a170902e8d400b001926b23e38bmr8413010plg.24.1673600638396;
        Fri, 13 Jan 2023 01:03:58 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id p15-20020a170902e74f00b00189bf5deda3sm13645510plf.133.2023.01.13.01.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 01:03:58 -0800 (PST)
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
Subject: [RFC PATCH 0/3] Deal with alignment restriction on EP side
Date:   Fri, 13 Jan 2023 18:03:47 +0900
Message-Id: <20230113090350.1103494-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
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

Some PCIe EPC controllers have restriction to map PCIe address space to the
local memory space. The mapping is needed to access memory of other side.
On epf test, RC module prepares an aligned memory, and EP module maps the
region. However, a EP module which emulate a device (e.g. VirtIO, NVMe and
etc) cannot expect that a driver for the device prepares an aligned memory.
So, a EP side should deal with the alignment restriction.

This patchset addresses with the alignment restriction on EP size. A
content as follows:
1. Improve a pci epc unmap/map functions to cover the alignment restriction
with adding epc driver support as EPC ops.
2. Implement the support function for DWC EPC driver.
3. Adapt the pci-epf-test to the map/unmap function updated at first patch.

I tested this changes on RENESAS board has DWC PCIeC.

This is a RFC, and it has patches for testing only. Following changes are
not included yet:
1. Removing alignment codes on RC side completely
2. Adapting map/unmap() changes to pci-epf-ntb/vntb

Best,
Shunsuke

Shunsuke Mie (3):
  PCI: endpoint: support an alignment aware map/unmaping
  PCI: dwc: support align_mem() callback for pci_epc_epc
  PCI: endpoint: support pci_epc_mem_map/unmap API changes

 .../pci/controller/dwc/pcie-designware-ep.c   | 13 +++
 drivers/pci/endpoint/functions/pci-epf-test.c | 89 +++++--------------
 drivers/pci/endpoint/pci-epc-core.c           | 57 +++++++++---
 include/linux/pci-epc.h                       | 10 ++-
 4 files changed, 90 insertions(+), 79 deletions(-)

-- 
2.25.1

