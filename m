Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2835EEDDF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiI2GZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiI2GZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:25:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025761007A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:25:20 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MdNXk4m9lzWgx3;
        Thu, 29 Sep 2022 14:21:10 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 14:25:17 +0800
Subject: Re: [PATCH v2 9/9] hugetlb: clean up code checking for
 fault/truncation races
To:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
 <20220914221810.95771-10-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <cb068983-70d1-53a2-4175-e8ca7818126c@huawei.com>
Date:   Thu, 29 Sep 2022 14:25:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220914221810.95771-10-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/15 6:18, Mike Kravetz wrote:
> With the new hugetlb vma lock in place, it can also be used to handle
> page fault races with file truncation.  The lock is taken at the
> beginning of the code fault path in read mode.  During truncation, it
> is taken in write mode for each vma which has the file mapped.  The
> file's size (i_size) is modified before taking the vma lock to unmap.
> 
> How are races handled?
> 
> The page fault code checks i_size early in processing after taking the
> vma lock.  If the fault is beyond i_size, the fault is aborted.  If the
> fault is not beyond i_size the fault will continue and a new page will
> be added to the file.  It could be that truncation code modifies i_size
> after the check in fault code.  That is OK, as truncation code will soon
> remove the page.  The truncation code will wait until the fault is
> finished, as it must obtain the vma lock in write mode.

As previous thread [1] points out, if vma->vm_private_data is NULL, there won't be any synchronization
which provides the same type of synchronization around i_size as provided by the fault mutex as in [2].
([2] will take the fault mutex for EVERY index in the truncated range)

[1] https://lore.kernel.org/lkml/YyOKIhygl66cG8Yr@monkey/T/#m6b69af9e8cdba01246c2b210bd044bf895b815ee
[2] https://lore.kernel.org/lkml/20220824175757.20590-5-mike.kravetz@oracle.com/

Except from that, this patch looks good to me. Thanks Mike.

Thanks,
Miaohe Lin


