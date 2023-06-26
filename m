Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF673D591
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 03:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjFZBky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 21:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFZBkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 21:40:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEA7194
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 18:40:50 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qq9Sy4pb4zMpZD;
        Mon, 26 Jun 2023 09:37:38 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 09:40:48 +0800
Subject: Re: [PATCH] mm: memory-failure: remove unneeded page state check in
 shake_page()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230625113430.2310385-1-linmiaohe@huawei.com>
 <ZJiacZIkvIv1P3AK@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8f8f7622-9bea-c344-4e54-ef902129de67@huawei.com>
Date:   Mon, 26 Jun 2023 09:40:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ZJiacZIkvIv1P3AK@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/26 3:50, Matthew Wilcox wrote:
> On Sun, Jun 25, 2023 at 07:34:30PM +0800, Miaohe Lin wrote:
>> Remove unneeded PageLRU(p) and is_free_buddy_page(p) check as slab caches
>> are not shrunk now. This check can be added back when a lightweight range
>> based shrinker is available.
> 
> On further review, I think you've misunderstood the entire situation
> here and no patch should be applied.

Thanks for your review. I think you might misunderstood the patch. What I want
to do here is remove the unneeded if block:

 if (PageLRU(p) || is_free_buddy_page(p))
     return;

Because nothing is done after the check. So this check is useless and should be removed.
Thanks.
