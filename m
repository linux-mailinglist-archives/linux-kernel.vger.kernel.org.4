Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2566673DED4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjFZMTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjFZMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:19:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA3E10DE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:19:07 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QqRdx6QH2zlVwY;
        Mon, 26 Jun 2023 20:16:21 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 20:19:03 +0800
Message-ID: <faeb60a9-8bde-d31d-acf5-a2bcda6cad72@huawei.com>
Date:   Mon, 26 Jun 2023 20:19:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
To:     <thornber@redhat.com>, <dm-devel@redhat.com>, <agk@redhat.com>,
        <snitzer@kernel.org>, Joe Thornber <ejt@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Hou Tao <houtao1@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>, yangerkun <yangerkun@huawei.com>
From:   Li Lingfeng <lilingfeng3@huawei.com>
Subject: [Question] Can DATA_DEV_BLOCK_SIZE_MIN_SECTORS be set to a smaller
 value
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.155]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

Recently, I found that the used space of the thin-pool will keep rising 
if I use dm-thin as follow:

// create dm-thin
dmsetup create linear_1 --table "0 2097152 linear /dev/sdc 0"
dmsetup create linear_2 --table "0 16777216  linear /dev/sdc 2097153"
dd if=/dev/zero of=/dev/mapper/linear_1 bs=4096 count=1
dmsetup create pool --table "0 16777216 thin-pool /dev/mapper/linear_1 
/dev/mapper/linear_2 128 0 1 skip_block_zeroing"
dmsetup message /dev/mapper/pool 0 "create_thin 0"
dmsetup create thin --table "0 14680064 thin /dev/mapper/pool 0"

// mkfs and mount with discard
mkfs.ext4 /dev/mapper/thin
mount /dev/mapper/thin /mnt/test -o discard
cd /mnt/test

// create a file(17KB)
dd if=/dev/random of=testfile bs=1k count=17 oflag=direct
sync

// truncate the file and write it for many times
dd if=/dev/random of=testfile bs=1k count=17 oflag=direct
sync
...

Ext4 will issue discard IO to dm-thin when truncating file. However, 
DATA_DEV_BLOCK_SIZE_MIN_SECTORS is set as 64KB which means the discard 
covers less than a block when I truncating a 17KB file. As the result of 
it, discard bio will end in process_discard_bio(), and more and more 
blocks will leak.

I'm curious about the reason behind setting 
DATA_DEV_BLOCK_SIZE_MIN_SECTORS to 64KB. Is there any specific 
consideration for this? Would it be possible to set this minimum limit 
to a smaller value, such as 4KB?

