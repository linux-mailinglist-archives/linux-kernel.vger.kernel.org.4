Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2548463D593
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiK3M20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiK3M2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:28:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75AE04C25F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:28:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 847D6D6E;
        Wed, 30 Nov 2022 04:28:29 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBB8E3F73D;
        Wed, 30 Nov 2022 04:28:21 -0800 (PST)
Message-ID: <c7acc1af-b97e-f9f7-4891-64bc9380a12e@arm.com>
Date:   Wed, 30 Nov 2022 12:28:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] perf/arm-cmn: Add shutdown routine
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>, Geoff Blake <blakgeof@amazon.com>,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>
References: <20221125230153.49468-1-blakgeof@amazon.com>
 <166973320082.112522.10687339610259452670.b4-ty@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <166973320082.112522.10687339610259452670.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-29 19:52, Will Deacon wrote:
> On Fri, 25 Nov 2022 17:01:53 -0600, Geoff Blake wrote:
>> The CMN driver does not gracefully handle all
>> restart cases, such as kexec.  On a kexec if the
>> arm-cmn driver is in use it can be left in a state
>> with still active  events that can cause spurious and/or
>> unhandled interrupts that appear as non-fatal kernel errors
>> like below, that can be confusing and misleading:
>>
>> [...]
> 
> Applied to will (for-next/perf), thanks!
> 
> [1/1] perf/arm-cmn: Add shutdown routine
>        https://git.kernel.org/will/c/316f862a787c

Oh, if I'd seen this I'd have said the same thing as when asked about it 
off-list, that it's needlessly overcomplicated and doesn't really solve 
the problem anyway. If there's a need to be robust against spurious 
interrupts then that needs to be done in the interrupt handler.

Even if we do think it's worth stopping the PMU on shutdown, as we do on 
remove, that still only needs a single register write (per the current 
remove implementation).

Thanks,
Robin.
