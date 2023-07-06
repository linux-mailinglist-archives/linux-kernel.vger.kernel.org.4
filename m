Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7868E7493CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 04:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjGFChQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 22:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGFChP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 22:37:15 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D75E70
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 19:37:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QxLJz4FLBz4f3knQ
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 10:37:07 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgA3LRvUKKZk4WRgMQ--.57905S2;
        Thu, 06 Jul 2023 10:37:09 +0800 (CST)
Subject: Re: [PATCH 1/2] mm: remove redundant check in page_vma_mapped_walk
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230704213932.1339204-1-shikemeng@huaweicloud.com>
 <20230704213932.1339204-2-shikemeng@huaweicloud.com>
 <20230704100548.11bce56bb79be4a7d1d8482c@linux-foundation.org>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <5e3bebd2-9144-ed51-9e57-36da0a5de3fd@huaweicloud.com>
Date:   Thu, 6 Jul 2023 10:37:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230704100548.11bce56bb79be4a7d1d8482c@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgA3LRvUKKZk4WRgMQ--.57905S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4Dur17tF45trWUKF1xXwb_yoWkWFgEvw
        4Yvwn8Zr4DWr1qq3Z0q3ZFkr15Kry8CFWDXFWUJrWqy3sYqan5ZF4Uur95CFsxAF48Kan0
        93ZYvrW2vr4UZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 7/5/2023 1:05 AM, Andrew Morton wrote:
> On Wed,  5 Jul 2023 05:39:31 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> 
>> For PVMW_SYNC case, we always take pte lock when get first pte of
>> PTE-mapped THP in map_pte and hold it until:
>> 1. scan of pmd range finished or
>> 2. scan of user input range finished or
>> 3. user stop walk with page_vma_mapped_walk_done.
>> In each case. pte lock will not be freed during middle scan of PTE-mapped
>> THP.
>>
>> ...
>>
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -275,10 +275,6 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>  				goto restart;
>>  			}
>>  			pvmw->pte++;
>> -			if ((pvmw->flags & PVMW_SYNC) && !pvmw->ptl) {
>> -				pvmw->ptl = pte_lockptr(mm, pvmw->pmd);
>> -				spin_lock(pvmw->ptl);
>> -			}
>>  		} while (pte_none(*pvmw->pte));
>>  
>>  		if (!pvmw->ptl) {
> 
> This code has changed significantly since 6.4.  Please develop against
> the mm-unstable branch at
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm, thanks.
> 
> 
Thanks for reminding me of this, I will check my changes in updated code.

-- 
Best wishes
Kemeng Shi

