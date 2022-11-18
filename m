Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E36662F1E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbiKRJxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiKRJw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:52:59 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B39D283
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:52:58 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NDBsX2Dkdz15McD;
        Fri, 18 Nov 2022 17:52:32 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 17:52:56 +0800
Received: from [10.67.108.193] (10.67.108.193) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 17:52:56 +0800
Subject: Re: [PATCH] rapidio: fix possible UAF when kfifo_alloc() fails
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <mporter@kernel.crashing.org>, <alex.bou9@gmail.com>,
        <yangyingliang@huawei.com>, <jakobkoschel@gmail.com>,
        <jhubbard@nvidia.com>, <error27@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20221117021802.46872-1-wangweiyang2@huawei.com>
 <20221117124517.9d8290e553b1e6d76b1ff7e8@linux-foundation.org>
From:   wangweiyang <wangweiyang2@huawei.com>
Message-ID: <a594de3b-7fe6-02f3-0d8f-2da785726d6e@huawei.com>
Date:   Fri, 18 Nov 2022 17:52:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20221117124517.9d8290e553b1e6d76b1ff7e8@linux-foundation.org>
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

On 2022/11/18 4:45, Andrew Morton wrote:
> On Thu, 17 Nov 2022 10:18:02 +0800 Wang Weiyang <wangweiyang2@huawei.com> wrote:
> 
>> If kfifo_alloc() fails in mport_cdev_open(), goto err_fifo and just free
>> priv. But priv is still in the chdev->file_list, then list traversal
>> may cause UAF. This fixes the following smatch warning:
>>
>> drivers/rapidio/devices/rio_mport_cdev.c:1930 mport_cdev_open() warn: '&priv->list' not removed from list
>>
>> Fixes: e8de370188d0 ("rapidio: add mport char device driver")
>> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
>> ---
>>  drivers/rapidio/devices/rio_mport_cdev.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
>> index 3cc83997a1f8..c66b2c552b38 100644
>> --- a/drivers/rapidio/devices/rio_mport_cdev.c
>> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
>> @@ -1930,6 +1930,9 @@ static int mport_cdev_open(struct inode *inode, struct file *filp)
>>  	filp->private_data = priv;
>>  	goto out;
>>  err_fifo:
>> +	mutex_lock(&chdev->file_mutex);
>> +	list_del(&priv->list);
>> +	mutex_unlock(&chdev->file_mutex);
>>  	kfree(priv);
>>  out:
>>  	return ret;
> 
> Surely it would be better to avoid adding the new instance onto the
> list until the new instance has been fully initialized?
> 

Thanks for your review. I'll send out a v2 patch later.
