Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5E35B6C51
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiIMLXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiIMLXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:23:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46A515B07B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:23:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CB961063;
        Tue, 13 Sep 2022 04:23:36 -0700 (PDT)
Received: from [10.163.58.193] (unknown [10.163.58.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A89F93F71A;
        Tue, 13 Sep 2022 04:23:27 -0700 (PDT)
Message-ID: <7dccfd5d-7fa1-440e-91a2-8aa35b9d968b@arm.com>
Date:   Tue, 13 Sep 2022 16:53:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/16] mm/page_alloc: ensure kswapd doesn't accidentally
 go to sleep
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        david@redhat.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-2-linmiaohe@huawei.com>
 <ea96d35e-46ae-c168-3186-ddf58ad6806c@arm.com>
 <YyA4Pz8hnnTsomUh@casper.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <YyA4Pz8hnnTsomUh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/22 13:28, Matthew Wilcox wrote:
> On Tue, Sep 13, 2022 at 12:32:50PM +0530, Anshuman Khandual wrote:
>>
>> On 9/9/22 14:54, Miaohe Lin wrote:
>>> If ALLOC_KSWAPD is set, wake_all_kswapds() will be called to ensure
>>> kswapd doesn't accidentally go to sleep. But when reserve_flags is
>>> set, alloc_flags will be overwritten and ALLOC_KSWAPD is thus lost.
>>> Preserve the ALLOC_KSWAPD flag in alloc_flags to ensure kswapd won't
>>> go to sleep accidentally.
>> Currently wake_all_kswapds() gets skipped subsequently if ALLOC_KSWAPD
>> is lost, but this only happens when the 'retry:' loops is taken ?
> Right, but see the comment:
> 
>         /* Ensure kswapd doesn't accidentally go to sleep as long as we loop */
> 
> and that is not currently true.  I think that was an inadvertent change.
> Particularly since the changelog for 0a79cdad5eb2 says "No functional
> change".

Got it, thanks for the explanation.
