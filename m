Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D583F73197B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbjFONCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343660AbjFONBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:01:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BE4213F;
        Thu, 15 Jun 2023 06:01:36 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qhj3R4qN5z18MJL;
        Thu, 15 Jun 2023 20:56:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 21:01:33 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <will@kernel.org>, <jonathan.cameron@huawei.com>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <shenyang39@huawei.com>,
        <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>
Subject: [PATCH v5 0/3] Add support for HiSilicon SoC uncore PMU
Date:   Thu, 15 Jun 2023 20:59:23 +0800
Message-ID: <20230615125926.29832-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for HiSilicon UC/H60PA/PAv3 PMU driver.

PAv3 PMU: Compared with the PAv2 PMU, the PAv3 PMU has different event.
The PAv3 PMU removed some events which are supported by PAv2 PMU. The
older PA PMU driver will probe v3 as v2. Add the HISI0275 HID for PAv3
PMU to distinguish different.

H60PA PMU: The H60PA PMU and PA are two different devices. The H60PA PMU
supports higher bandwidth, and the PA PMU delay is relatively low.
Different HIDs are used to distinguish the delay.

UC PMU: Each cluster is integrated with a unified cache (UC) PMU, which
provides consistency between NUMA and UMA domains. It sits between
L2 and the memory system.

Change since v4:
- Add new HID to distinguish PAv2 and PAv3 according to Mark's suggestion.
Link: https://lore.kernel.org/lkml/20230609075608.36559-1-hejunhao3@huawei.com/

Change since v3:
- Modify the UC PMU patch commit message according to Jonathan's comment.
Link: https://lore.kernel.org/linux-arm-kernel/20230608113719.27433-1-hejunhao3@huawei.com/

Change since v2:
- Modify the driver description according to Jonathan's comment.
Link: https://lore.kernel.org/linux-arm-kernel/20230531104625.18296-1-hejunhao3@huawei.com/

Change since v1:
- Improve according to Yicong's suggestion
- Fixes build warning of "-Wmissing-prototypes"
Link: https://lore.kernel.org/lkml/20230523131825.6102-1-hejunhao3@huawei.com/

Junhao He (3):
  drivers/perf: hisi: Add support for HiSilicon H60PA and PAv3 PMU
    driver
  drivers/perf: hisi: Add support for HiSilicon UC PMU driver
  docs: perf: Add new description for HiSilicon UC PMU

 Documentation/admin-guide/perf/hisi-pmu.rst |   8 +
 drivers/perf/hisilicon/Makefile             |   2 +-
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c | 127 ++++-
 drivers/perf/hisilicon/hisi_uncore_pmu.c    |   4 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h    |  14 +
 drivers/perf/hisilicon/hisi_uncore_uc_pmu.c | 578 ++++++++++++++++++++
 6 files changed, 716 insertions(+), 17 deletions(-)
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_uc_pmu.c

-- 
2.33.0

