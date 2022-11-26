Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C63A6393A4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 04:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKZDVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 22:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKZDVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 22:21:01 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D862159FD7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 19:20:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VVhOwfb_1669432849;
Received: from 30.15.198.69(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VVhOwfb_1669432849)
          by smtp.aliyun-inc.com;
          Sat, 26 Nov 2022 11:20:50 +0800
Message-ID: <dd919a21-956b-77ef-c5d2-92ef554b31c8@linux.alibaba.com>
Date:   Sat, 26 Nov 2022 11:20:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2] erofs: check the uniqueness of fsid in shared domain
 in advance
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jia Zhu <zhujia.zj@bytedance.com>, houtao1@huawei.com
References: <20221125110822.3812942-1-houtao@huaweicloud.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20221125110822.3812942-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

Thanks for catching this!


On 11/25/22 7:08 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When shared domain is enabled, doing mount twice with the same fsid and
> domain_id will trigger sysfs warning as shown below:
> 
>  sysfs: cannot create duplicate filename '/fs/erofs/d0,meta.bin'
>  CPU: 15 PID: 1051 Comm: mount Not tainted 6.1.0-rc6+ #1
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x38/0x49
>   dump_stack+0x10/0x12
>   sysfs_warn_dup.cold+0x17/0x27
>   sysfs_create_dir_ns+0xb8/0xd0
>   kobject_add_internal+0xb1/0x240
>   kobject_init_and_add+0x71/0xa0
>   erofs_register_sysfs+0x89/0x110
>   erofs_fc_fill_super+0x98c/0xaf0
>   vfs_get_super+0x7d/0x100
>   get_tree_nodev+0x16/0x20
>   erofs_fc_get_tree+0x20/0x30
>   vfs_get_tree+0x24/0xb0
>   path_mount+0x2fa/0xa90
>   do_mount+0x7c/0xa0
>   __x64_sys_mount+0x8b/0xe0
>   do_syscall_64+0x30/0x60
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> The reason is erofs_fscache_register_cookie() doesn't guarantee the primary
> data blob (aka fsid) is unique in the shared domain and
> erofs_register_sysfs() invoked by the second mount will fail due to the
> duplicated fsid in the shared domain and report warning.
> 
> It would be better to check the uniqueness of fsid before doing
> erofs_register_sysfs(), so adding a new flags parameter for
> erofs_fscache_register_cookie() and doing the uniqueness check if
> EROFS_REG_COOKIE_NEED_NOEXIST is enabled.
> 
> After the patch, the error in dmesg for the duplicated mount would be:
> 
>  erofs: ...: erofs_domain_register_cookie: XX already exists in domain YY
> 
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


-- 
Thanks,
Jingbo
