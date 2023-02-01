Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50DC685D12
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjBACI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBACIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:08:55 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF98511169
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 18:08:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guorui.yu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VaYfUcJ_1675217329;
Received: from 30.221.130.17(mailfrom:GuoRui.Yu@linux.alibaba.com fp:SMTPD_---0VaYfUcJ_1675217329)
          by smtp.aliyun-inc.com;
          Wed, 01 Feb 2023 10:08:51 +0800
Message-ID: <bdeef865-a326-75ce-a1d0-b5d0c5a44e14@linux.alibaba.com>
Date:   Wed, 1 Feb 2023 10:08:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/4] swiotlb: Add a new cc-swiotlb implementation for
 Confidential VMs
To:     Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com,
        linux-coco@lists.linux.dev
Cc:     robin.murphy@arm.com
References: <20230128083254.86012-1-GuoRui.Yu@linux.alibaba.com>
 <20230128083254.86012-3-GuoRui.Yu@linux.alibaba.com>
 <9b167caf-1b10-f97a-d96a-b7ead8e785e8@linux.intel.com>
 <2ec59355-c8d5-c794-16e8-7d646b43c455@linux.alibaba.com>
 <09a56915-7ce2-b70c-33ec-3a8767269637@linux.intel.com>
 <ccc21265-07aa-cd82-f679-4fee9c51df47@linux.alibaba.com>
 <ee5d8c26-a453-678c-be48-d586271573d6@linux.intel.com>
From:   Guorui Yu <GuoRui.Yu@linux.alibaba.com>
In-Reply-To: <ee5d8c26-a453-678c-be48-d586271573d6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/2/1 01:16, Andi Kleen 写道:
>  >No, this cannot guarantee we always have sufficient TLB caches, so we 
> can also have a "No memory for cc-swiotlb buffer" warning.
> 
> It's not just a warning, it will be IO errors, right?
> 

Yes, they are IO errors, but unsustainable such IO errors are not fatal 
in my limited testing so far, and the system can survive after through 
them. Again, legacy swiotlb occasionally suffers from TLB starvation.

However, if dynamic allocation of TLB is not allowed at all, the system 
will be more likely to be overwhelmed by a large of bursting IOs and 
unable to respond. Such problems are generally transient, so it is 
difficult to reproduce and debug in a production environment. Users can 
only set an unreasonably large fixed size and REBOOT to mitigate this 
problem as much as possible.

>>
>> But I want to emphasize that in this case, the current implementation 
>> is no worse than the legacy implementation. Moreover, dynamic TLB 
>> allocation is more suitable for situations where more disks/network 
>> devices will be hotplugged, in which case you cannot pre-set a 
>> reasonable value.
> 
> That's a reasonable stand point, but have to emphasize that is 
> "probabilistic" in all the descriptions and comments.
>

Agreed, but one point to add is that the user can adjust the water level 
setting to reduce the possibility of interrupt context allocation TLB 
failure.

According to the current design, the kthread will be awaken to allocate 
new TLBs when it is lower than half of the water level, so more flexible 
room can be left by increasing the water level.

> I assume you did some stress testing (E.g. all cores submitting at full 
> bandwidth) to validate that it works for you?
>
> -Andi
> 

Yes, I tested by fio with different block sizes, iodepths and job 
numbers on my testbed.

And I have noticed that there are some "IO errors" of `No memory for 
cc-swiotlb buffer` in the beginning of the test, but it will be 
eventually disappeared as long as there are enough free memory.

Thanks for your time,
Guorui
