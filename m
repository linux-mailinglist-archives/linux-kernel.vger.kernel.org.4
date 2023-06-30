Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1C4743B68
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjF3MEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjF3MEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:04:13 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4FBE72
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 05:04:12 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U946kv019050;
        Fri, 30 Jun 2023 05:04:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=wphDQnsgQHriFEZB5037roDvSuzFkZdpHT41NkU4ayw=;
 b=A4RHuflsqT/53cykmrH1DQuajwz6hNlZkan/pWtAHYzi/qi407DdoPZ+2AzVLVDqlC+0
 rUdVd/3UG99v9IZvIBqFDqpE1oIsdXT3aym4eSpumbissSQXpozis6ypgKjcHgdfaMWQ
 PPwf9RGK827cEosWp068Gxnkbb1ytkuca/MuBapZXCogyea7R+njtLfiC9E6/e6HRwYU
 D2irrNRO3fkvnlR5X+CCya+lWzMVSBH7Lzw7NBpl7uCHIg8n+ZkNQfOf6su+U3/XY+U+
 hzrAaE+imyXm8SbPOKD9ihqpZP9k6SCZFfyiSNVlLITwY0l1hut4P94eDDEi7xKei/7I HA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rgvpc63b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 05:03:59 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 30 Jun
 2023 05:03:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 30 Jun 2023 05:03:57 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
        by maili.marvell.com (Postfix) with ESMTP id 315A83F707E;
        Fri, 30 Jun 2023 05:03:54 -0700 (PDT)
From:   Gowthami Thiagarajan <gthiagarajan@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <gcherian@marvell.com>, <lcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH 0/6] Marvell Odyssey uncore performance monitor support
Date:   Fri, 30 Jun 2023 17:33:45 +0530
Message-ID: <20230630120351.1143773-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YzVLSv1g9Qkn0NsajL7vG70DEJEJzXLn
X-Proofpoint-ORIG-GUID: YzVLSv1g9Qkn0NsajL7vG70DEJEJzXLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches introduces support for uncore performance monitor
units (PMUs) on the Marvell Odyssey platform. The PMUs covered in this
series include the PEM PMU, LLC-TAD PMU and DDR PMU.

Patches 1, 3 and 5 adds support for PEM pmu, LLC-TAD pmu, DDR pmu
respectively.
Patches 2, 4 and 6 deal with their respective device tree bindings.

Gowthami Thiagarajan (6):
  perf/marvell: Marvell PEM performance monitor support
  dt-bindings: perf: marvell: Add YAML schemas for Marvell PEM pmu
  perf/marvell : Odyssey LLC-TAD performance monitor support
  dt-bindings: perf: marvell: Add YAML schemas for Marvell Odyssey
    LLC-TAD pmu
  perf/marvell: Odyssey DDR Performance monitor support
  dt-bindings: Add YAML schemas for Marvell Odyssey DDR PMU

 .../bindings/perf/marvell-cn10k-ddr.yaml      |   9 +-
 .../bindings/perf/marvell-odyssey-pem.yaml    |  38 ++
 .../bindings/perf/marvell-odyssey-tad.yaml    |  63 +++
 MAINTAINERS                                   |  15 +
 drivers/perf/Kconfig                          |  14 +
 drivers/perf/Makefile                         |   2 +
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 404 +++++++++++++---
 drivers/perf/marvell_odyssey_tad_pmu.c        | 406 ++++++++++++++++
 drivers/perf/marvell_pem_pmu.c                | 433 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 10 files changed, 1318 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-odyssey-pem.yaml
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-odyssey-tad.yaml
 create mode 100644 drivers/perf/marvell_odyssey_tad_pmu.c
 create mode 100644 drivers/perf/marvell_pem_pmu.c

-- 
2.25.1

