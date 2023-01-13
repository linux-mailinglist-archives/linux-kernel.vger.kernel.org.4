Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88052669021
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239755AbjAMIJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbjAMII6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:08:58 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FCDC2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:07:35 -0800 (PST)
Received: from dggpemm100011.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NtYmz52hNzqVDx;
        Fri, 13 Jan 2023 16:02:43 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 dggpemm100011.china.huawei.com (7.185.36.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 13 Jan 2023 16:07:32 +0800
Message-ID: <3475f910-68fd-76da-c7f9-4fcc32d878e7@huawei.com>
Date:   Fri, 13 Jan 2023 16:07:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
To:     <linux-kernel@vger.kernel.org>, Joe Thornber <ejt@redhat.com>
CC:     <snitzer@redhat.com>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <zhangxiaoxu5@huawei.com>
From:   "lilingfeng (A)" <lilingfeng3@huawei.com>
Subject: Question about how to trigger BUG_ON() in sm_disk_new_block()
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.155]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100011.china.huawei.com (7.185.36.112)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I notice the patch 4feaef830de7ffdd8352e1fe14ad3bf13c9688f8 (dm space 
map common: fix to ensure new block isn't already in use) can explain 
the BUG_ON() in sm_disk_new_block().
However, I'm still confused since I can't find the code path in which 
'begin' field was not being updated (as you say "increment of a data 
block reference count due to breaking sharing of a neighbour block in 
the same btree leaf").

What I found are as below:
break_sharing
  alloc_data_block
   dm_pool_alloc_data_block
    dm_sm_new_block
     sm_disk_new_block
      sm_ll_find_free_block
      smd->begin = *b + 1

May I bother you to list the path?

Thanks

