Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D588609439
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiJWPEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJWPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:04:34 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5850213E8B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:04:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VSptLky_1666537463;
Received: from 30.13.157.28(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VSptLky_1666537463)
          by smtp.aliyun-inc.com;
          Sun, 23 Oct 2022 23:04:25 +0800
Message-ID: <13658301-6af4-9dcf-0158-d24745d49f4f@linux.alibaba.com>
Date:   Sun, 23 Oct 2022 23:04:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2] mm, hwpoison: Try to recover from copy-on write faults
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <SJ1PR11MB60838C1F65CA293188BB442DFC289@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20221019170835.155381-1-tony.luck@intel.com>
 <893b681b-726e-94e3-441e-4d68c767778a@linux.alibaba.com>
 <Y1GqGbBNk6fX/OnD@agluck-desk3.sc.intel.com>
 <359bae4e-6ce3-cc7e-33d0-252064157bc6@linux.alibaba.com>
 <Y1IbOAvpGzA8bst1@agluck-desk3.sc.intel.com>
 <1643d19d795b4a8084228eab66a7db9f@AcuMS.aculab.com>
 <SJ1PR11MB6083624E288992BFA902CC8CFC2D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dda2321d-15f4-342a-2fbe-5c535858eb34@linux.alibaba.com>
 <SJ1PR11MB6083CEDBA2719825A1AD325EFC2D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <SJ1PR11MB6083CEDBA2719825A1AD325EFC2D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/22 AM12:30, Luck, Tony 写道:
>>> But maybe it is some RMW instruction ... then, if all the above options didn't happen ... we
>>> could get another machine check from the same address. But then we just follow the usual
>>> recovery path.
> 
> 
>> Let assume the instruction that cause the COW is in the 63/64 case, aka,
>> it is writing a different cache line from the poisoned one. But the new_page
>> allocated in COW is dropped right? So might page fault again?
> 
> It can, but this should be no surprise to a user that has a signal handler for
> a h/w event (SIGBUS, SIGSEGV, SIGILL) that does nothing to address the
> problem, but simply returns to re-execute the same instruction that caused
> the original trap.
> 
> There may be badly written signal handlers that do this. But they just cause
> pain for themselves. Linux can keep taking the traps and fixing things up and
> sending a new signal over and over.
> 
> In this case that loop may involve taking the machine check again, so some
> extra pain for the kernel, but recoverable machine checks on Intel/x86 switched
> from broadcast to delivery to just the logical CPU that tried to consume the poison
> a few generations back. So only a bit more painful than a repeated page fault.
> 
> -Tony
> 
> 

I see, thanks for your patient explanation :)

Best Regards,
Shuai

