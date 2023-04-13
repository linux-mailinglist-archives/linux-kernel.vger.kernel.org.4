Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720026E03D6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 03:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDMBtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 21:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDMBtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 21:49:36 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291785599
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 18:49:34 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pxj8j21Qkz17SGR;
        Thu, 13 Apr 2023 09:45:57 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 09:49:31 +0800
Subject: Re: [PATCH -next] mm: hwpoison: support recovery from HugePage
 copy-on-write faults
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20230411092741.780679-1-liushixin2@huawei.com>
 <20230412181350.GA22818@monkey>
 <20230412145718.0bcb7dd98112a3010711ad0b@linux-foundation.org>
CC:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Tony Luck <tony.luck@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <muchun.song@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <28bf1701-d2c6-ee2a-d92d-a603e1a1b3dd@huawei.com>
Date:   Thu, 13 Apr 2023 09:49:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20230412145718.0bcb7dd98112a3010711ad0b@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/13 5:57, Andrew Morton wrote:
> On Wed, 12 Apr 2023 11:13:50 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
>> On 04/11/23 17:27, Liu Shixin wrote:
>>> Patch a873dfe1032a ("mm, hwpoison: try to recover from copy-on write faults")
>>> introduced a new copy_user_highpage_mc() function, and fix the kernel crash
>>> when the kernel is copying a normal page as the result of a copy-on-write
>>> fault and runs into an uncorrectable error. But it doesn't work for HugeTLB.
>> Andrew asked about user-visible effects.  Perhaps, a better way of
>> stating this in the commit message might be:
>>
>> Commit a873dfe1032a ("mm, hwpoison: try to recover from copy-on write
>> faults") introduced the routine copy_user_highpage_mc() to gracefully
>> handle copying of user pages with uncorrectable errors.  Previously,
>> such copies would result in a kernel crash.  hugetlb has separate code
>> paths for copy-on-write and does not benefit from the changes made in
>> commit a873dfe1032a.
>>
>> Modify hugetlb copy-on-write code paths to use copy_mc_user_highpage()
>> so that they can also gracefully handle uncorrectable errors in user
>> pages.  This involves changing the hugetlb specific routine
>> ?copy_user_folio()? from type void to int so that it can return an error.
>> Modify the hugetlb userfaultfd code in the same way so that it can return
>> -EHWPOISON if it encounters an uncorrectable error.
> Thanks, but...  what are the runtime effects?  What does hugetlb
> presently do when encountering these uncorrectable error?
I have tested the HugeTLB case by using tony's testcase[1](need add a MAP_HUGETLB).
Before this patch, the kernel will crash due to the uncorrectable errors. After this patch,
if the error occurs in copy-on-write, the process will be killed, if the errors occurs in
userfaultfd, it will return -EHWPOISON.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/aegl/ras-tools.git [1]
>
>
> .
>

