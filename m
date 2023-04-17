Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4A86E4068
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDQHMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjDQHMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:12:39 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501ED40E3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:12:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VgFMACV_1681715551;
Received: from 30.97.49.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VgFMACV_1681715551)
          by smtp.aliyun-inc.com;
          Mon, 17 Apr 2023 15:12:32 +0800
Message-ID: <a8b9a758-d469-b9a6-f5e8-8f3768e2ea81@linux.alibaba.com>
Date:   Mon, 17 Apr 2023 15:12:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] erofs: remove unneeded icur field from struct
 z_erofs_decompress_frontend
To:     Yue Hu <zbestahu@gmail.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        jefflexu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        huyue2@coolpad.com, zhangwen@coolpad.com
References: <20230417064136.5890-1-zbestahu@gmail.com>
 <26cdf7b0-5d7d-68ba-da76-1ad800708946@linux.alibaba.com>
 <dd1d75a6-38c3-771c-c1ed-2f5dca523c03@linux.alibaba.com>
 <20230417151506.00006565.zbestahu@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230417151506.00006565.zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/17 15:15, Yue Hu wrote:
> On Mon, 17 Apr 2023 15:00:25 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 

..

>>
>> Although please help refine the comment below:
>>
>> 	/* scan & fill inplace I/O pages in the reverse order */
> 
> Ok, will refine it in v2.

I rethink this, I don't want to go far in this way, and this makes a
O(n) scan into O(n^2) when a single inplace I/O page is added.

So sorry, I don't think it's a good way, although I also don't think
`icur` is a good name and we might need to find a better name.

Thanks,
Gao Xiang

> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>> +    unsigned int icur = pcl->pclusterpages;
>>>> -    while (fe->icur > 0) {
>>>> -        if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
>>>> +    while (icur > 0) {
>>>> +        if (!cmpxchg(&pcl->compressed_bvecs[--icur].page,
>>>>                     NULL, bvec->page)) {
>>>> -            pcl->compressed_bvecs[fe->icur] = *bvec;
>>>> +            pcl->compressed_bvecs[icur] = *bvec;
>>>>                return true;
>>>>            }
>>>>        }
>>>> @@ -877,8 +876,6 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
>>>>        }
>>>>        z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
>>>>                    Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
>>>> -    /* since file-backed online pages are traversed in reverse order */
>>>> -    fe->icur = z_erofs_pclusterpages(fe->pcl);
>>>>        return 0;
>>>>    }
