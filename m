Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3CE68E6B8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 04:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjBHDn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 22:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBHDnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 22:43:24 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B96112C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 19:43:23 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=carlo.bai@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vb9nuL3_1675827799;
Received: from 30.97.56.150(mailfrom:carlo.bai@linux.alibaba.com fp:SMTPD_---0Vb9nuL3_1675827799)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 11:43:21 +0800
Message-ID: <ee69c345-f4eb-bb35-4825-f23b44faadbc@linux.alibaba.com>
Date:   Wed, 8 Feb 2023 11:43:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 1/1] arm64: mm: remove unnecessary multiple tlb flush
 of contiguous hugetlb
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        baolin.wang@linux.alibaba.com
References: <1675768181-41518-1-git-send-email-carlo.bai@linux.alibaba.com>
 <Y+KWoDw1ppliQ5Sg@arm.com>
Content-Language: en-US
From:   Carlo Bai <carlo.bai@linux.alibaba.com>
In-Reply-To: <Y+KWoDw1ppliQ5Sg@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/8 2:21, Catalin Marinas wrote:
> On Tue, Feb 07, 2023 at 07:09:41PM +0800, Kaihao Bai wrote:
>> In arm64, contiguous flag refers to the same TLB entry that shared by a
>> contiguous address range. If flush one entry of the address range, it
>> would cover the whole contiguous address range. Thus there's no need to
>> flush all contiguous range that CONT_PMD/PTE points to.
> 
> This doesn't work. The contiguous bit is a hint, so the CPU may not
> coalesce multiple PTEs into a single TLB entry.
>Sorry I misunderstood the underlying approach of contiguous bit. I 
re-check and find that "TLB maintenance must be performed based on the 
size of the underlying translation table entries, to avoid TLB
coherency issues.". Thanks for your clarification!
