Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38586E3F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjDQGRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjDQGRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:17:42 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E95F30D3;
        Sun, 16 Apr 2023 23:17:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VgDPlFK_1681712255;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VgDPlFK_1681712255)
          by smtp.aliyun-inc.com;
          Mon, 17 Apr 2023 14:17:36 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        robin.murphy@arm.com, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, xueshuai@linux.alibaba.com
Subject: [PATCH v3 0/3] drivers/perf: add Synopsys DesignWare PCIe PMU driver support
Date:   Mon, 17 Apr 2023 14:17:26 +0800
Message-Id: <20230417061729.84422-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2 addressing comments from Baolin:
- remove redundant macro definitions
- use dev_err to print error message
- change pmu_is_register to boolean
- use PLATFORM_DEVID_NONE macro
- fix module author format

Changes since v1:

1. address comments from Jonathan:
- drop marco for PMU name and VSEC version
- simplify code with PCI standard marco
- simplify code with FIELD_PREP()/FIELD_GET() to replace shift marco
- name register filed with single _ instead double
- wrap dwc_pcie_pmu_{write}_dword out and drop meaningless snaity check 
- check vendor id while matching vesc with pci_find_vsec_capability()
- remove RP_NUM_MAX and use a list to organize PMU devices for rootports
- replace DWC_PCIE_CREATE_BDF with standard PCI_DEVID
- comments on riping register together

2. address comments from Bjorn:
- rename DWC_PCIE_VSEC_ID to DWC_PCIE_VSEC_RAS_DES_ID
- rename cap_pos to ras_des
- simplify declare of device_attribute with DEVICE_ATTR_RO
- simplify code with PCI standard macro and API like pcie_get_width_cap()
- fix some code style problem and typo
- drop meaningless snaity check of container_of

3. address comments from Yicong:
- use sysfs_emit() to replace sprintf()
- simplify iteration of pci device with for_each_pci_dev
- pick preferred CPUs on a near die and add comments
- unregister PMU drivers only for failed ones
- log on behalf PMU device and give more hint
- fix some code style problem

(Thanks for all comments and they are very valuable to me)

This patchset adds the PCIe Performance Monitoring Unit (PMU) driver support
for T-Head Yitian 710 SoC chip. Yitian 710 is based on the Synopsys PCI Express
Core controller IP which provides statistics feature.


Shuai Xue (3):
  docs: perf: Add description for Synopsys DesignWare PCIe PMU driver
  drivers/perf: add DesignWare PCIe PMU driver
  MAINTAINERS: add maintainers for DesignWare PCIe PMU driver

 .../admin-guide/perf/dwc_pcie_pmu.rst         |  61 ++
 Documentation/admin-guide/perf/index.rst      |   1 +
 MAINTAINERS                                   |   6 +
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/dwc_pcie_pmu.c                   | 855 ++++++++++++++++++
 6 files changed, 931 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst
 create mode 100644 drivers/perf/dwc_pcie_pmu.c

-- 
2.20.1.12.g72788fdb

