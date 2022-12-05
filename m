Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE751642142
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 02:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiLEBzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 20:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiLEBzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 20:55:46 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB840BE11
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 17:55:44 -0800 (PST)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NQRSc67KlzFpVh;
        Mon,  5 Dec 2022 09:54:56 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 5 Dec
 2022 09:55:43 +0800
Message-ID: <6146c2f8-c78d-34b4-2f54-7b8fc3190f82@huawei.com>
Date:   Mon, 5 Dec 2022 09:55:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] erofs: Fix pcluster become inline when m_pa is zero
Content-Language: en-US
To:     <syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
        <jefflexu@linux.alibaba.com>
References: <20221203094527.129869-1-chenzhongjin@huawei.com>
 <Y4tNEUupN/1/AFOW@debian> <Y4tR52dEWMhRMC2C@debian>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <Y4tR52dEWMhRMC2C@debian>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/12/3 21:40, Gao Xiang wrote:
> On Sat, Dec 03, 2022 at 09:20:17PM +0800, Gao Xiang wrote:
>> Hi Zhongjin,
>>
>> On Sat, Dec 03, 2022 at 05:45:27PM +0800, Chen Zhongjin wrote:
>>> syzkaller reported a memleak:
>>> https://syzkaller.appspot.com/bug?id=62f37ff612f0021641eda5b17f056f1668aa9aed
>>>
>>> unreferenced object 0xffff88811009c7f8 (size 136):
>>>    ...
>>>    backtrace:
>>>      [<ffffffff821db19b>] z_erofs_do_read_page+0x99b/0x1740
>>>      [<ffffffff821dee9e>] z_erofs_readahead+0x24e/0x580
>>>      [<ffffffff814bc0d6>] read_pages+0x86/0x3d0
>>>      ...
>>>
>>> syzkaller constructed a case: in z_erofs_register_pcluster(),
>>> ztailpacking = false and map->m_pa = zero. This makes pcl->obj.index
>>> become zero although pcl is not an inline pcluster.
>> Thanks for the patch!
>>
>> We should just fail out if map->m_pa / EROFS_BLKSIZ == 0.
>>
>>> Then following path adds refcount for grp, but the it won't be put
>>> because pcl is inline, which makes pcl not released when shrink.
>>>
>>> z_erofs_readahead()
>>>    z_erofs_do_read_page() # for another page
>>>      z_erofs_collector_begin()
>>>        erofs_find_workgroup()
>>>          erofs_workgroup_get()
>>>
>>> To fix this, add an attribute in z_erofs_pcluster to mark the inline
>>> state which not depends on index of grp.
>> I think the main reason is "inline pcluster _always_ did memory leak
>> before since I don't find any chance to these free inline pclusters
>> in the current codebase.
>>
>> Actually I submitted a patch for this, could you check/review this
>> if possible?
>> https://lore.kernel.org/r/20221202033327.52702-1-hsiangkao@linux.alibaba.com
> Oh, I just realized my patch may be incorrect, I think we need to
> just fail out this (since m_pblk == 0 cannot be a real pcluster,
> since it has on-disk super block at least):
>
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index ab22100be861..e14e6c32e70d 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -496,7 +496,8 @@ static int z_erofs_register_pcluster(struct
> z_erofs_decompress_frontend *fe)
>   	struct erofs_workgroup *grp;
>   	int err;
>   
> -	if (!(map->m_flags & EROFS_MAP_ENCODED)) {
> +	if (!(map->m_flags & EROFS_MAP_ENCODED) ||
> +	    !(map->m_pa >> PAGE_SHIFT)) {
>   		DBG_BUGON(1);
>   		return -EFSCORRUPTED;
>
>
> Could you resend next version behaving like the above?
Thanks for your time and review!

I just didn't know weather m_pa is legal to be zero.
I tested this and simply fail here can also solve the memleak.

Have sent v2 for this. And the title is slightly changed, see:
[PATCH v2] erofs: Fix pcluster memleak when m_pa is zero

Best,
Chen
> Thanks,
> Gao Xiang
>
>> Thanks,
>> Gao Xiang
>>
>>> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
>>> Reported-by: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com
>>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>>> ---
>>>   fs/erofs/zdata.c | 2 +-
>>>   fs/erofs/zdata.h | 5 ++++-
>>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>>> index b792d424d774..fef2624d19e3 100644
>>> --- a/fs/erofs/zdata.c
>>> +++ b/fs/erofs/zdata.c
>>> @@ -517,7 +517,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>>>   	DBG_BUGON(!mutex_trylock(&pcl->lock));
>>>   
>>>   	if (ztailpacking) {
>>> -		pcl->obj.index = 0;	/* which indicates ztailpacking */
>>> +		pcl->is_inline = true;  /* which indicates ztailpacking */
>>>   		pcl->pageofs_in = erofs_blkoff(map->m_pa);
>>>   		pcl->tailpacking_size = map->m_plen;
>>>   	} else {
>>> diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
>>> index d98c95212985..35051ad27521 100644
>>> --- a/fs/erofs/zdata.h
>>> +++ b/fs/erofs/zdata.h
>>> @@ -78,6 +78,9 @@ struct z_erofs_pcluster {
>>>   		unsigned short tailpacking_size;
>>>   	};
>>>   
>>> +	/* I:  whether it is inline or not */
>>> +	bool is_inline;
>>> +
>>>   	/* I: compression algorithm format */
>>>   	unsigned char algorithmformat;
>>>   
>>> @@ -115,7 +118,7 @@ struct z_erofs_decompressqueue {
>>>   
>>>   static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
>>>   {
>>> -	return !pcl->obj.index;
>>> +	return pcl->is_inline;
>>>   }
>>>   
>>>   static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
>>> -- 
>>> 2.17.1
>>>
