Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9EB66594A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjAKKqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjAKKqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:46:11 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5326338
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:46:09 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pFYcR-00037y-10; Wed, 11 Jan 2023 11:46:07 +0100
Message-ID: <0b9f5425-08d4-8013-aa4c-e620c3b10bb2@leemhuis.info>
Date:   Wed, 11 Jan 2023 11:46:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, de-DE
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Andrew Morton <akpm"@linux-foundation.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Amanieu d'Antras <amanieu@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: =?UTF-8?Q?=5bRegression=5d_Bug=c2=a0216911_-_get=5funmapped=5farea_?=
 =?UTF-8?Q?returns_addresses_below_mmap=5fmin=5faddr?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673433969;f3859e6a;
X-HE-SMSGID: 1pFYcR-00037y-10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I noticed a regression report in bugzilla.kernel.org. As many
(most?) kernel developer don't keep an eye on it, I decided to forward
it by mail. Quoting from
https://bugzilla.kernel.org/show_bug.cgi?id=216911 :

>  Amanieu d'Antras 2023-01-11 02:10:02 UTC
> 
> Created attachment 303572 [details]
> Program which demonstrates this issue
> 
> The vm_unmapped_area function doesn't seem to respect info.low_limit and will sometimes return an address below this limit. This can result in addresses below mmap_min_addr being returned.
> 
> I bisected it down to this range of commits (I stopped since I was hitting kernel crashes):
> 3499a13168da mm/mmap: use maple tree for unmapped_area{_topdown}
> 7fdbd37da5c6 mm/mmap: use the maple tree for find_vma_prev() instead of the rbtree
> be8432e7166e mm/mmap: use the maple tree in find_vma() instead of the rbtree.
> 2e3af1db1744 mmap: use the VMA iterator in count_vma_pages_range()
> f39af05949a4 mm: add VMA iterator
> d4af56c5c7c6 mm: start tracking VMAs with maple tree

[those are all from the Maple Tree introduction series]

> I've attached a test program which attempts to allocate the entire address space. On affected kernels, this triggers one of the 2 assertions (depending on whether you are running as root):
> - NULL is returned, which means memory below mmap_min_addr was allocated.
> - EPERM is returned, which really shouldn't happen when MAP_FIXED is not used (ENOMEM should be returned instead).

See the ticket for more details.

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: d4af56c5c7c6..3499a13168da
https://bugzilla.kernel.org/show_bug.cgi?id=216911
#regzbot title: mm: get_unmapped_area returns addresses below mmap_min_addr
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
