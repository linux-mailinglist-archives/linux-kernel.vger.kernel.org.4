Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A73963342D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiKVDpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiKVDpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:45:51 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240F728E21
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:45:50 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGVX03BqFzRpPY;
        Tue, 22 Nov 2022 11:45:20 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 11:45:48 +0800
Received: from [10.67.108.193] (10.67.108.193) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 11:45:48 +0800
Subject: Re: [PATCH v2] rapidio: fix possible UAF when kfifo_alloc() fails
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <mporter@kernel.crashing.org>, <alex.bou9@gmail.com>,
        <yangyingliang@huawei.com>, <jakobkoschel@gmail.com>,
        <jhubbard@nvidia.com>, <error27@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20221119040335.46794-1-wangweiyang2@huawei.com>
 <20221121140410.dfe2816f743c62fe0c71639d@linux-foundation.org>
From:   wangweiyang <wangweiyang2@huawei.com>
Message-ID: <54d0de14-afcb-e3c7-16f9-df1b1f2a7e30@huawei.com>
Date:   Tue, 22 Nov 2022 11:45:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20221121140410.dfe2816f743c62fe0c71639d@linux-foundation.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.193]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

on 2022/11/22 6:04, Andrew Morton wrote:
> On Sat, 19 Nov 2022 12:03:35 +0800 Wang Weiyang <wangweiyang2@huawei.com> wrote:
> 
>> If kfifo_alloc() fails in mport_cdev_open(), goto err_fifo and just free
>> priv. But priv is still in the chdev->file_list, then list traversal
>> may cause UAF. This fixes the following smatch warning:
>>
>> drivers/rapidio/devices/rio_mport_cdev.c:1930 mport_cdev_open() warn: '&priv->list' not removed from list
>>
>> ...
>>
>> Changes in v2:
>> - Avoid adding the new instance onto the list until the new instance
>>   has been fully initialized.
> 
> But it still isn't fully initialized.

Yes, I ignored that the initialization is still going on.

> 
>>  drivers/rapidio/devices/rio_mport_cdev.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
>> index 3cc83997a1f8..86b28c4cd906 100644
>> --- a/drivers/rapidio/devices/rio_mport_cdev.c
>> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
>> @@ -1904,10 +1904,6 @@ static int mport_cdev_open(struct inode *inode, struct file *filp)
>>  
>>  	priv->md = chdev;
>>  
>> -	mutex_lock(&chdev->file_mutex);
>> -	list_add_tail(&priv->list, &chdev->file_list);
>> -	mutex_unlock(&chdev->file_mutex);
>> -
>>  	INIT_LIST_HEAD(&priv->db_filters);
>>  	INIT_LIST_HEAD(&priv->pw_filters);
>>  	spin_lock_init(&priv->fifo_lock);
>> @@ -1920,6 +1916,9 @@ static int mport_cdev_open(struct inode *inode, struct file *filp)
>>  		ret = -ENOMEM;
>>  		goto err_fifo;
>>  	}
>> +	mutex_lock(&chdev->file_mutex);
>> +	list_add_tail(&priv->list, &chdev->file_list);
>> +	mutex_unlock(&chdev->file_mutex);
>>  
>>  #ifdef CONFIG_RAPIDIO_DMA_ENGINE
>>  	INIT_LIST_HEAD(&priv->async_list);
> 
> Here we're still setting up state at *priv.  I'm thinking the list
> addition shouldn't occur until after the 
> 
> 	filp->private_data = priv;
> 
> Or just prior to it.  I'm not sure what the atomicity rules are for
> file.private versus mport_dev.file_list.

I prefer to put the list addition just prior to the

	filp->private_data = priv;

to keep mport_cdev_release() in reverse order of init. If it's ok with
you, I'll send a new patch later.

> .
> 
