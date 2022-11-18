Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4CA62F025
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbiKRIxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiKRIxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:53:46 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903A712A82
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:53:44 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ND9Y96wLMz15Mkl;
        Fri, 18 Nov 2022 16:53:17 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:53:41 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:53:41 +0800
Subject: Re: [PATCH 0/6] ubifs: Fix wrong space calculation while doing budget
To:     <richard@nod.at>, <s.hauer@pengutronix.de>,
        <miquel.raynal@bootlin.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <20221011034732.45605-1-chengzhihao1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <8207d8f9-8b30-cfbb-9a5f-56294cb35601@huawei.com>
Date:   Fri, 18 Nov 2022 16:53:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20221011034732.45605-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/10/11 11:47, Zhihao Cheng 写道:

Hi. Richard
Just a reminding. Could you please look through following series(Some of 
them is sent several months ago), I wish these can be merged in 6.1, 
thanks a lot:

ubi infinite loop: 
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=304485
ubi uaf in sysfs: 
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=311956
ubi fastmap: 
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=313063
ubifs assertion failed about writepage: 
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=302776
ubifs space budget: 
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=322220

> This series of patches fix ubifs wrong budget space calculations,
> which could make make_reservation() failed with ENOSPC error code
> and let ubifs become read-only.
>
> Zhihao Cheng (6):
>    ubifs: Rectify space budget for ubifs_symlink() if symlink is
>      encrypted
>    ubifs: Rectify space budget for ubifs_xrename()
>    ubifs: Add comments and debug info for ubifs_xrename()
>    ubifs: Fix wrong dirty space budget for dirty inode
>    ubifs: do_rename: Fix wrong space budget when target inode's nlink > 1
>    ubifs: Reserve one leb for each journal head while doing budget
>
>   fs/ubifs/budget.c |  9 ++++-----
>   fs/ubifs/dir.c    | 18 +++++++++++++++++-
>   2 files changed, 21 insertions(+), 6 deletions(-)
>

