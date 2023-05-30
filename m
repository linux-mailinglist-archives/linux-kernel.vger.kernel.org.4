Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D735371543E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 05:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjE3Dr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 23:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjE3DrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 23:47:25 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD71D9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 20:47:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vjryb0a_1685418440;
Received: from 30.221.134.6(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vjryb0a_1685418440)
          by smtp.aliyun-inc.com;
          Tue, 30 May 2023 11:47:21 +0800
Message-ID: <77ed16d5-4e75-0d9d-5a11-0d26573f8b9c@linux.alibaba.com>
Date:   Tue, 30 May 2023 11:47:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/5] erofs: introduce erofs_xattr_iter_fixup_aligned()
 helper
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230518024551.123990-1-jefflexu@linux.alibaba.com>
 <20230518024551.123990-2-jefflexu@linux.alibaba.com>
 <9d928aa7-31cf-e4c1-8694-0aa63e55b382@linux.alibaba.com>
 <6e7b2c58-0bb4-e008-a157-3d83ac33bf81@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <6e7b2c58-0bb4-e008-a157-3d83ac33bf81@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/30 11:42, Jingbo Xu wrote:
> 
> 
> On 5/29/23 3:41 PM, Gao Xiang wrote:
>> Hi,
>>
>> On 2023/5/18 10:45, Jingbo Xu wrote:
>>> Introduce erofs_xattr_iter_fixup_aligned() helper where
>>> it.ofs <= EROFS_BLKSIZ is mandatory.
>>>
>>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>> ---
>>>    fs/erofs/xattr.c | 79 +++++++++++++++++++++---------------------------
>>>    1 file changed, 35 insertions(+), 44 deletions(-)
>>>
>>> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
>>> index bbfe7ce170d2..b79be2a556ba 100644
>>> --- a/fs/erofs/xattr.c
>>> +++ b/fs/erofs/xattr.c
>>> @@ -29,6 +29,28 @@ struct xattr_iter {
>>>        unsigned int ofs;
>>>    };
>>>    +static inline int erofs_xattr_iter_fixup(struct xattr_iter *it)
>>> +{
>>> +    if (it->ofs < it->sb->s_blocksize)
>>> +        return 0;
>>> +
>>> +    it->blkaddr += erofs_blknr(it->sb, it->ofs);
>>> +    it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr,
>>> EROFS_KMAP);
>>
>> could we use a new buf interface to init_metabuf at once?
> 
> As discussed offline, I think the following unified API is preferred:
> 
> ```
> int erofs_xattr_iter_fixup(struct xattr_iter *it, bool nospan)
> 
> {
>      if (it->ofs < it->sb->s_blocksize)
>          return 0;
> 
>      if (nospan && it->ofs != it->sb->s_blocksize) {
> 	DBG_BUGON(1);
> 	return -EFSCORRUPTED;
>      }
> 
>      ...
> }
> ```

Yeah, could you send the next version for this?

Thanks,
Gao Xiang

> 
