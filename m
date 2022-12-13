Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530DF64AD14
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiLMBef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiLMBe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:34:28 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F501D0D5;
        Mon, 12 Dec 2022 17:34:27 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NWLc871ctz15NLr;
        Tue, 13 Dec 2022 09:33:28 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 09:34:25 +0800
Message-ID: <e8dfaf60-ff35-66d3-7bc1-f11eaaef642a@huawei.com>
Date:   Tue, 13 Dec 2022 09:34:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: linux-next: build failure after merge of the mm-hotfixes tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221213093054.5211da74@canb.auug.org.au>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221213093054.5211da74@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Hi, this patch relays on Tony Luck's Patch series "Copy-on-write poison 
recovery".[1]
and tested ppc64_defconfig based on next-20221208, it's no build failure

I think it is not very hotfix, also will send v3 to address some comments
we could adjust the patch order in mm tree, thanks.

[1] 
https://lore.kernel.org/all/50506c8a-71c1-9c68-aa47-7e8dc68a3c52@huawei.com/ 



On 2022/12/13 6:30, Stephen Rothwell wrote:
> Hi all,
>
> After merging the mm-hotfixes tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> mm/ksm.c: In function 'ksm_might_need_to_copy':
> mm/ksm.c:2605:21: error: implicit declaration of function 'copy_mc_user_highpage'; did you mean 'copy_user_highpage'? [-Werror=implicit-function-declaration]
>   2605 |                 if (copy_mc_user_highpage(new_page, page, address, vma)) {
>        |                     ^~~~~~~~~~~~~~~~~~~~~
>        |                     copy_user_highpage
>
> Caused by commit
>
>    b7edf4b1cdb1 ("mm: hwpoison: support recovery from ksm_might_need_to_copy()")
>
> I have reverted that commit for today.
>
