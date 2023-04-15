Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15506E32F6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 19:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjDORmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 13:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjDORmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 13:42:54 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A34E35AB
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1681580567;
        bh=ft7n3pSsyVF2OSVjBeFR7VFYeidiVFTD3Reo30zy8Ac=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To;
        b=HGtgO6zKJAtUxFOoUCsA4+U7wUpOyHDH6QahQQKpyzvGMmd6nStrDfvv22CtIKS8s
         poOkbGkVuDwyJuj0tXeFjwHZIrG3otWrvIE3fwFEH9ahUjn+mslPSbBcitNecgEx03
         u5Q2zxI5K5ieT7QtUgQ4A8PObSyqQjWgGlhdLK2w=
Received: from [192.168.31.3] ([106.92.97.36])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id AAC39AF2; Sun, 16 Apr 2023 01:42:44 +0800
X-QQ-mid: xmsmtpt1681580564t4yz4x0k0
Message-ID: <tencent_100BD2639951FD669FA1AA40A89983202709@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/yOxekswrVuNLfRHbcNl5ulLlhk/GDW8D5F7N+3a2uZT3ECAwNZ
         BOFiQx4+AggGxfIVOs6z5mwX67N1xVo2nMFUtYaB8KBRJW2Yal67NWwybKe16BVqVhoQcu2/N4NS
         v6H7FfEbykAKmriGOgh2aSoeKkEB4cE9epj6Bjx00V7WVHp6fqQJgemrEHa/aT5njBPVebcVGO9R
         MfSgZQuxQU64RrCDQrowMYC3o6DMw5l/hg/CUKYDqPcSk4lBc0tNHthPI67nJjY0QP0i2VEVfYTA
         RUJfJ3Jy4ee296fMoDM+ZaWaSwXAlPZMkLF1b39SLeDpqa1VQQRhBY84eU0HyGDGcaZ1FQTPVosh
         euE/EOLdjQP2akBb5twEUFtcr+i+HrIfQFsFPwwpnhumSrvpsEIoqi/e3jm9iUg6azPrMThZi4RE
         +9UP+hQ3YofIHHSvEJRs+aA7nas2IFg8oftdD4593jPj7hvtDHctXeaxzOEQQIMlhdv5TKdrpdYm
         8oq2HgbBf+zVMKsj8dHtkVU18eESFLHExhNxDoQ7JCLxiyEMeBUlr7FzwxEMrc1GIeLJUS7xKG+M
         Hg5Pcaevks2do6klSHnGCBu5vyYxu+WMWkM0HittMxoxejH20Uyspp0LnXFFQS9jiL5XKE5YdH5s
         1mHVKe3+XF7ljvH+EQByymhLnyfrJVE1/cfpmUqDhXeapO08Vh+x7ajPLzwUZAiad9r3monjtNk/
         hYLPgRiwUAtCcHpNW8rtNPj5i+hR2kt/oy0P1TETed34rose1TIm/29UZw7wNOgvG2Kx6OtwhsIs
         4jm57qegxANQroWJ9oOfDOdmIyK4yz/z2hYeVg6/WfUOQ9JNmZXsrcqNPQznBIZnkiMDGCUPHpE6
         R5oguv5sb0lXo9UXl3oEwaap2hPOzzgnYOYrC/XpkLwZnPBswK6JZm1uzfVw0Qq6FPeTsVB3v3E6
         sZKxY4E4oq9c7et4FSeJ363gs3vpaNUfNpTLN+yAZ1isQp8gc9ow==
X-OQ-MSGID: <1a0154ae-abed-7480-762e-358d7627ca66@foxmail.com>
Date:   Sun, 16 Apr 2023 01:42:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] mm: compaction: optimize compact_memory to comply with
 the admin-guide
From:   Wen Yang <wenyang.linux@foxmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        William Lam <william.lam@bytedance.com>,
        Fu Wei <wefu@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <tencent_FD958236269FD3A7996FFCF29E9BAA4EA809@qq.com>
 <20230411134801.a4aadef5aba0f51e0d44bb7a@linux-foundation.org>
 <tencent_C3E900CCD37EF2CF49553BD4AC4120932B08@qq.com>
In-Reply-To: <tencent_C3E900CCD37EF2CF49553BD4AC4120932B08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/13 00:54, Wen Yang 写道:
>
> 在 2023/4/12 04:48, Andrew Morton 写道:
>> On Wed, 12 Apr 2023 02:24:26 +0800 wenyang.linux@foxmail.com wrote:
>>
>>> For the /proc/sys/vm/compact_memory file, the admin-guide states:
>>> When 1 is written to the file, all zones are compacted such that free
>>> memory is available in contiguous blocks where possible. This can be
>>> important for example in the allocation of huge pages although 
>>> processes
>>> will also directly compact memory as required
>>>
>>> But it was not strictly followed, writing any value would cause all
>>> zones to be compacted. In some critical scenarios, some applications
>>> operating it, such as echo 0, have caused serious problems.
>> Really?  You mean someone actually did this and didn't observe the
>> effect during their testing?
>
> Thanks for your reply.
>
> Since /proc/sys/vm/compact_memory has been well documented for over a 
> decade:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/admin-guide/sysctl/vm.rst#n109 
>
>
> it is believed that only writing 1 will trigger trigger all zones to 
> be compacted.
>
> Especially for those who write applications, they may only focus on 
> documentation and generally do not read kernel code.  Moreover, such 
> problems are not easily detected through testing on low pressure 
> machines.
>
> Writing any meaningful or meaningless values will trigger it and 
> affect the entire server:
>
> # echo 1 > /proc/sys/vm/compact_memory
> # echo 0 > /proc/sys/vm/compact_memory
> # echo dead > /proc/sys/vm/compact_memory
> # echo "hello world" > /proc/sys/vm/compact_memory
>
> The implementation of this high-risk operation may require following 
> the admin-guides.
>
> -- 
>
> Best wishes,
>
> Wen
>
>
Hello, do you think it's better to optimize the 
sysctl_compaction_handler code or update the admin-guide document?

--

Best wishes,

Wen

>>> It has been slightly optimized to comply with the admin-guide.
>

