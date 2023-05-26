Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2AD7126C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243308AbjEZMf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbjEZMfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:35:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B7410D1;
        Fri, 26 May 2023 05:35:28 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QSPXB3F7MzTkdF;
        Fri, 26 May 2023 20:35:22 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 26 May
 2023 20:35:25 +0800
Subject: Re: [PATCH net-next 1/2] page_pool: unify frag page and non-frag page
 handling
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Eric Dumazet <edumazet@google.com>
References: <20230526092616.40355-1-linyunsheng@huawei.com>
 <20230526092616.40355-2-linyunsheng@huawei.com> <ZHCgJxTnm37qu3aY@hera>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <5640bab0-d2f9-50ee-f3e2-eb0f86b144dc@huawei.com>
Date:   Fri, 26 May 2023 20:35:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <ZHCgJxTnm37qu3aY@hera>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/26 20:03, Ilias Apalodimas wrote:
> Hi Yunsheng
> 
> Apologies for not replying to the RFC,  I was pretty busy with internal
> stuff
> 
> On Fri, May 26, 2023 at 05:26:14PM +0800, Yunsheng Lin wrote:
>> Currently page_pool_dev_alloc_pages() can not be called
>> when PP_FLAG_PAGE_FRAG is set, because it does not use
>> the frag reference counting.
>>
>> As we are already doing a optimization by not updating
>> page->pp_frag_count in page_pool_defrag_page() for the
>> last frag user, and non-frag page only have one user,
>> so we utilize that to unify frag page and non-frag page
>> handling, so that page_pool_dev_alloc_pages() can also
>> be called with PP_FLAG_PAGE_FRAG set.
> 
> What happens here is clear.  But why do we need this?  Do you have a
> specific use case in mind where a driver will call
> page_pool_dev_alloc_pages() and the PP_FLAG_PAGE_FRAG will be set?

Actually it is about calling page_pool_alloc_pages() in
page_pool_alloc_frag() in patch 2, the use case is the
veth using page frag support. see:

https://patchwork.kernel.org/project/netdevbpf/patch/d3ae6bd3537fbce379382ac6a42f67e22f27ece2.1683896626.git.lorenzo@kernel.org/

> If that's the case isn't it a better idea to unify the functions entirely?

As about, page_pool_alloc_frag() does seems to be a superset of
page_pool_alloc_pages() after this patchset as my understanding.
If the page_pool_alloc_frag() API turns out to be a good API for
the driver, maybe we can phase out *page_pool_alloc_pages() as
time goes by?


