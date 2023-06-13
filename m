Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9839A72C6CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbjFLOBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbjFLOA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:00:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E78210D3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:00:53 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QftWK1SPcz18Lc7;
        Mon, 12 Jun 2023 21:55:57 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 22:00:51 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     Jan Kara <jack@suse.com>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH 0/2] Fix out-of-bound access if pagecache of udf device is corrupted
Date:   Tue, 13 Jun 2023 11:22:52 +0800
Message-ID: <20230613032254.1235752-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following steps would cause out-of-bound access and even cause kernel
panic when using udf:

dd if=/dev/zero of=udf.img bs=1M count=512
mkfs.udf udf.img
mount -o loop -t udf udf.img /mnt
dd if=/dev/random of=/dev/loop0 bs=512 count=1 seek=128
umount /mnt

[if /mnt is mounted on /dev/loop0]

It is because we did not check if udf_sb_info->s_lvid_bh is valid in
udf_sb_lvidiu().

Although it's illegal to write backend device since filesystem has been
mounted, but we should avoid kernel panic if it happened.

The first patch add a helper function to check if the data is valid.
The second patch just call the helper function, if check failed, return
NULL from udf_sb_lvidiu()

Wenchao Hao (2):
  udf: add helper function udf_check_tagged_bh to check tagged page
  udf:check if buffer head's data when getting lvidiu

 fs/udf/misc.c    | 60 ++++++++++++++++++++++++++++--------------------
 fs/udf/super.c   |  2 ++
 fs/udf/udfdecl.h |  1 +
 3 files changed, 38 insertions(+), 25 deletions(-)

-- 
2.35.3

