Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACA3662636
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbjAIMzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbjAIMzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:55:15 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4A2164B7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 04:55:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZEaZ.Q_1673268909;
Received: from 192.168.3.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZEaZ.Q_1673268909)
          by smtp.aliyun-inc.com;
          Mon, 09 Jan 2023 20:55:10 +0800
Message-ID: <9f4c8bf0-db3e-b97a-504d-6015b75a2174@linux.alibaba.com>
Date:   Mon, 9 Jan 2023 20:55:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: fix kvcalloc() misuse with __GFP_NOFAIL
To:     Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com
References: <20230106031937.113318-1-hsiangkao@linux.alibaba.com>
 <cbd4bc97-4ffb-45c5-8c3c-b9b81b20d813@linux.alibaba.com>
 <c949dfe9-572f-61ee-a587-1f71be2f13d7@kernel.org>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <c949dfe9-572f-61ee-a587-1f71be2f13d7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 2023/1/9 18:34, Chao Yu wrote:
> On 2023/1/6 13:06, Gao Xiang wrote:
>>
>>
>> On 2023/1/6 11:19, Gao Xiang wrote:
>>> As reported by syzbot [1], kvcalloc() cannot work with  __GFP_NOFAIL.
>>> Let's use kcalloc() instead.
>>>
>>> [1] https://lore.kernel.org/r/0000000000007796bd05f1852ec2@google.com
>>> Reported-by: syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com
>>
>> Fixes: fe3e5914e6dc ("erofs: try to leave (de)compressed_pages on stack if possible")
>> Fixes: 4f05687fd703 ("erofs: introduce struct z_erofs_decompress_backend")
>>
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>> ---
>>>   fs/erofs/zdata.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>>> index ccf7c55d477f..08e982c77985 100644
>>> --- a/fs/erofs/zdata.c
>>> +++ b/fs/erofs/zdata.c
>>> @@ -1032,12 +1032,12 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>>>       if (!be->decompressed_pages)
>>>           be->decompressed_pages =
>>> -            kvcalloc(be->nr_pages, sizeof(struct page *),
>>> -                 GFP_KERNEL | __GFP_NOFAIL);
>>> +            kcalloc(be->nr_pages, sizeof(struct page *),
>>> +                GFP_KERNEL | __GFP_NOFAIL);
>>>       if (!be->compressed_pages)
>>>           be->compressed_pages =
>>> -            kvcalloc(pclusterpages, sizeof(struct page *),
>>> -                 GFP_KERNEL | __GFP_NOFAIL);
>>> +            kcalloc(pclusterpages, sizeof(struct page *),
>>> +                GFP_KERNEL | __GFP_NOFAIL);
> 
> How about using kfree instead of kvfree for .decompressed_pages and
> .compressed_pages memory release? It's trivial though.

Yeah, thanks for catching! I will send v2 to fix these.

Thanks,
Gao Xiang

> 
> Anyway, feel free to add:
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
> 
>>>       z_erofs_parse_out_bvecs(be);
>>>       err2 = z_erofs_parse_in_bvecs(be, &overlapped);
