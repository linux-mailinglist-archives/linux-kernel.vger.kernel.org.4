Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC246BF74C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 02:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCRB5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 21:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRB5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 21:57:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C70A4A1E3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 18:57:15 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pdkb741ZMzHwhh;
        Sat, 18 Mar 2023 09:54:59 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Sat, 18 Mar
 2023 09:57:12 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 0/5] ubi: Enhanced fault injection capability for the UBI driver
Date:   Sat, 18 Mar 2023 09:56:16 +0800
Message-ID: <20230318015621.1408243-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing fault injection capability of UBI is too simple.
It uses hard-coded fault probability values and lacks other
configurable options. As a result, these interfaces are difficult
to use when digging defects in the abnormal path of code and
reproducing some problems.

The kernel provides a powerful fault injection framework, which
provides rich configurable fault injection attributes during runtime.
So it can be used to improve the fault injection capability of the 
UBI driver.

This series of patches refactor the existing fault injection interface
and add some fault injection types to help testers and developers
find potential problems in the code.

ZhaoLong Wang (5):
  ubi: Using the Fault Injection Framework to refactor the debugfs
    interface
  ubi: Split io_failures into write_failure and erase_failure
  ubi: Add six fault injection type for testing
  ubi: Reserve sufficient buffer length for the input mask
  mtd: Add several functions to the fail_function list

 drivers/mtd/mtdcore.c   |   6 +-
 drivers/mtd/ubi/Kconfig |   8 ++
 drivers/mtd/ubi/debug.c | 185 +++++++++++++++++++-------------------
 drivers/mtd/ubi/debug.h | 190 ++++++++++++++++++++++++++++++++++++----
 drivers/mtd/ubi/io.c    | 101 ++++++++++++++++++---
 drivers/mtd/ubi/ubi.h   |  68 +++++---------
 6 files changed, 390 insertions(+), 168 deletions(-)

-- 
2.31.1

