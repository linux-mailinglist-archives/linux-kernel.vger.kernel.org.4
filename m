Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1872563321D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiKVBZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiKVBZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:25:01 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA36BC21
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:25:00 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NGRLJ0LYgzFqRT;
        Tue, 22 Nov 2022 09:21:44 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 09:24:58 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 09:24:58 +0800
Subject: Re: [PATCH v2 2/2] arm64/mm: fix incorrect file_map_count for invalid
 pmd/pud
To:     Will Deacon <will@kernel.org>
References: <20221117075602.2904324-1-liushixin2@huawei.com>
 <20221117075602.2904324-3-liushixin2@huawei.com>
 <20221118143414.GG4046@willie-the-truck>
 <10cecbdf-eb06-873d-6b79-bfdb3197d2ec@huawei.com>
 <20221121181636.GD7645@willie-the-truck>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        David Hildenbrand <dhildenb@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <1f4ef941-6b45-8562-1723-21048a639c18@huawei.com>
Date:   Tue, 22 Nov 2022 09:24:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20221121181636.GD7645@willie-the-truck>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/22 2:16, Will Deacon wrote:
> On Mon, Nov 21, 2022 at 11:15:49AM +0800, Liu Shixin wrote:
>> On 2022/11/18 22:34, Will Deacon wrote:
>>> On Thu, Nov 17, 2022 at 03:56:02PM +0800, Liu Shixin wrote:
>>>>  static inline bool pud_user_accessible_page(pud_t pud)
>>>>  {
>>>> -	return pud_leaf(pud) && pud_user(pud);
>>>> +	return pud_valid(pud) && pud_leaf(pud) && pud_user(pud);
>>> Not caused by this patch, but why don't we have something like a
>>> pud_user_exec() check here like we do for the pte and pmd levels?
>> As far as I know, there is no user use the user executable pud on arm64, so didn't define pud_user_exec().
> I can believe they don't get exposed to userspace at all, but exposing only
> as non-executable doesn't sound right. So I would have thought that either
> pud_user_accessible_page() would always return false or it would need to
> check for the executable case too.
Thanks for your advice, I will add the check for the executable case too.

>
> Will
> .
>

