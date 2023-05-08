Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C4B6F9D70
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjEHBh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 21:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjEHBh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:37:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE69F46A8
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 18:37:25 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QF3h13jszzTkD6;
        Mon,  8 May 2023 09:32:49 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 09:37:23 +0800
Subject: Re: [PATCH -next v9 0/3] Delay the initialization of zswap
To:     Chris Li <chrisl@kernel.org>
References: <20230411093632.822290-1-liushixin2@huawei.com>
 <ZFL4Tvm8KKrCfjRr@google.com>
 <9b2b6dac-9a3d-efcb-9706-44f6df1fe2bf@huawei.com>
 <ZFPG3swMcHW/qxID@google.com>
CC:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <6ed055cb-e705-3993-6285-3a30bba15c0d@huawei.com>
Date:   Mon, 8 May 2023 09:37:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <ZFPG3swMcHW/qxID@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/4 22:53, Chris Li wrote:
> On Thu, May 04, 2023 at 03:11:05PM +0800, Liu Shixin wrote:
>>> If it is the zswap_pool alone, it means that we can have a smaller patch
>>> to get most of your 18M back.
>> You're right, the most came from zswap_pool.
> Thanks for the confirmation.
>
>>> I also notice you move a lot of __init function back to normal functions.
>>> That would mean those functions wouldn't be able to drop after the
>>> initialization phase. That is another reason to move less of the initialization
>>> function.
>> Thanks for your advice. I've thought about it before, but I thought there is less impact
>> for the size of kernel, so I didn't do it.
> Let's first agree on the hypothetical patch that only delaying zswap_pool would
> have the benefit over V9 on:
> - smaller patch, less invasive.
> - less kernel text area due to more __init function got free after initialization.
>
> If we can reach that agreement, then we can discuss how we can get there.
>
> I think there is a possibility that the delay initialization of zswap_pool
> can fall into the "zswap_has_pool = false" case, so you don't need to have
> the initialization mutex.  Simpler.
>
> I have my selfish reason as well. I have a much larger pending patch against
> the zswap code so the smaller patch would mean less conflict for me.
>
> I am guilty of giving this feedback late. If you come up with a V10, I will be glad
> to review it. Or, if you prefer, I can come up with the smaller patch for you
> to review as well. What do you say?
You can add a pre-patch to modify it before your patch. Thanks.
>
> Chris
>
> .
>

