Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1375C60948B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJWPwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJWPwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:52:14 -0400
Received: from out199-11.us.a.mail.aliyun.com (out199-11.us.a.mail.aliyun.com [47.90.199.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B01E317C5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:52:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VSptVNr_1666540325;
Received: from 30.13.157.28(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VSptVNr_1666540325)
          by smtp.aliyun-inc.com;
          Sun, 23 Oct 2022 23:52:06 +0800
Message-ID: <85b1b706-c3c2-6316-6dd5-ba1b4306d772@linux.alibaba.com>
Date:   Sun, 23 Oct 2022 23:52:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v3 0/2] Copy-on-write poison recovery
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20221019170835.155381-1-tony.luck@intel.com>
 <20221021200120.175753-1-tony.luck@intel.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20221021200120.175753-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/22 AM4:01, Tony Luck 写道:
> Part 1 deals with the process that triggered the copy on write
> fault with a store to a shared read-only page. That process is
> send a SIGBUS with the usual machine check decoration to specify
> the virtual address of the lost page, together with the scope.
> 
> Part 2 sets up to asynchronously take the page with the uncorrected
> error offline to prevent additional machine check faults. H/t to
> Miaohe Lin <linmiaohe@huawei.com> and Shuai Xue <xueshuai@linux.alibaba.com>
> for pointing me to the existing function to queue a call to
> memory_failure().
> 
> On x86 there is some duplicate reporting (because the error is
> also signalled by the memory controller as well as by the core
> that triggered the machine check). Console logs look like this:
> 
> [ 1647.723403] mce: [Hardware Error]: Machine check events logged
> 	Machine check from kernel copy routine
> 
> [ 1647.723414] MCE: Killing einj_mem_uc:3600 due to hardware memory corruption fault at 7f3309503400
> 	x86 fault handler sends SIGBUS to child process
> 
> [ 1647.735183] Memory failure: 0x905b92d: recovery action for dirty LRU page: Recovered
> 	Async call to memory_failure() from copy on write path

The recovery action might also be handled asynchronously in CMCI uc_decode_notifier
handler signaled by memory controller, right?

I have a one more memory failure log than yours.

[ 3187.485742] MCE: Killing einj_mem_uc:31746 due to hardware memory corruption fault at 7fc4bf7cf400
[ 3187.740620] Memory failure: 0x1a3b80: recovery action for dirty LRU page: Recovered
	uc_decode_notifier() processes memory controller report

[ 3187.748272] Memory failure: 0x1a3b80: already hardware poisoned
	Workqueue: events memory_failure_work_func // queued by ghes_do_memory_failure

[ 3187.754194] Memory failure: 0x1a3b80: already hardware poisoned
	Workqueue: events memory_failure_work_func // queued by __wp_page_copy_user

[ 3188.615920] MCE: Killing einj_mem_uc:31745 due to hardware memory corruption fault at 7fc4bf7cf400

Best Regards,
Shuai

> 
> [ 1647.748397] Memory failure: 0x905b92d: already hardware poisoned
> 	uc_decode_notifier() processes memory controller report
> 
> [ 1647.761313] MCE: Killing einj_mem_uc:3599 due to hardware memory corruption fault at 7f3309503400
> 	Parent process tries to read poisoned page. Page has been unmapped, so
> 	#PF handler sends SIGBUS
> 
> 
> Tony Luck (2):
>   mm, hwpoison: Try to recover from copy-on write faults
>   mm, hwpoison: When copy-on-write hits poison, take page offline
> 
>  include/linux/highmem.h | 24 ++++++++++++++++++++++++
>  include/linux/mm.h      |  5 ++++-
>  mm/memory.c             | 32 ++++++++++++++++++++++----------
>  3 files changed, 50 insertions(+), 11 deletions(-)
> 
