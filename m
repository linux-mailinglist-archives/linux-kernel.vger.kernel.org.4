Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BF5662351
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjAIKl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbjAIKkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:40:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA98186DD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:34:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D37DFB80D67
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45178C433D2;
        Mon,  9 Jan 2023 10:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673260444;
        bh=4+41/x4EC6NqU/+mehLq4YWojS5p6S0n539ic8Dxjzw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KLPEab//TbD4tEXztACY7jbMKY+V1PEisPOaSjv53K9s1ByZnszapjf+hp8j8dmhi
         leIHi11Gd8rl48LQZ8vil32FY7RbME1aNmOmiBluphjCExSZsRigCOrCe5je6n1/p7
         4T2w42Rt/WZEcBi43oaGadZGQdo6NdFHoXlyg9Bm7iKPptP/fEsS5UeTRNA4k2S+VJ
         8ipXpJIAz9S6AMtWHo7xrZ50LDuI2+VbTVYTAwzZPUxevZXffjzMRR/VnOtmm2rchD
         1o38xyqI+HesP2tnGi0fm2nmZOpQWv7Qz1ti5s8qutSR9sZ6TDdcqnQNTSMdxX2ERY
         cTsMFikSbH74A==
Message-ID: <c949dfe9-572f-61ee-a587-1f71be2f13d7@kernel.org>
Date:   Mon, 9 Jan 2023 18:34:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: fix kvcalloc() misuse with __GFP_NOFAIL
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com
References: <20230106031937.113318-1-hsiangkao@linux.alibaba.com>
 <cbd4bc97-4ffb-45c5-8c3c-b9b81b20d813@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <cbd4bc97-4ffb-45c5-8c3c-b9b81b20d813@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/6 13:06, Gao Xiang wrote:
> 
> 
> On 2023/1/6 11:19, Gao Xiang wrote:
>> As reported by syzbot [1], kvcalloc() cannot work with  __GFP_NOFAIL.
>> Let's use kcalloc() instead.
>>
>> [1] https://lore.kernel.org/r/0000000000007796bd05f1852ec2@google.com
>> Reported-by: syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com
> 
> Fixes: fe3e5914e6dc ("erofs: try to leave (de)compressed_pages on stack if possible")
> Fixes: 4f05687fd703 ("erofs: introduce struct z_erofs_decompress_backend")
> 
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/zdata.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index ccf7c55d477f..08e982c77985 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -1032,12 +1032,12 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>>       if (!be->decompressed_pages)
>>           be->decompressed_pages =
>> -            kvcalloc(be->nr_pages, sizeof(struct page *),
>> -                 GFP_KERNEL | __GFP_NOFAIL);
>> +            kcalloc(be->nr_pages, sizeof(struct page *),
>> +                GFP_KERNEL | __GFP_NOFAIL);
>>       if (!be->compressed_pages)
>>           be->compressed_pages =
>> -            kvcalloc(pclusterpages, sizeof(struct page *),
>> -                 GFP_KERNEL | __GFP_NOFAIL);
>> +            kcalloc(pclusterpages, sizeof(struct page *),
>> +                GFP_KERNEL | __GFP_NOFAIL);

How about using kfree instead of kvfree for .decompressed_pages and
.compressed_pages memory release? It's trivial though.

Anyway, feel free to add:

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

>>       z_erofs_parse_out_bvecs(be);
>>       err2 = z_erofs_parse_in_bvecs(be, &overlapped);
