Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8126073DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiJUJTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiJUJTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:19:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E351EA0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:19:21 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtzLc5nVKzmVHS;
        Fri, 21 Oct 2022 17:14:32 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 17:19:18 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <dedekind@linutronix.de>, <haver@vnet.ibm.com>,
        <bbrezillon@kernel.org>
CC:     <lizetao1@huawei.com>, <boris.brezillon@free-electrons.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Fix use-after-free and kmemleak in ubi_resize_volume()
Date:   Fri, 21 Oct 2022 18:21:55 +0800
Message-ID: <20221021102157.1341807-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes two memory usage issues.

Patch 1 resolves the use-after-free issue, this is happening in volume 
resizing failed. In volume resizing process, the old eba table will be
replaced by the new. But on error handing patch, the old eba will be 
freed, which causing an use-after-free fault when resizing volume
next time.

Patch 2 resolves the kmemleak issue, this is also happening in volume
resizing failed. "new_eba_tbl" is created by ubi_eba_create_table() 
but destroyed by kfree().

Li Zetao (2):
  ubi: Fix use-after-free when volume resizing failed
  ubi: Fix unreferenced object reported by kmemleak in
    ubi_resize_volume()

 drivers/mtd/ubi/vmt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.31.1

