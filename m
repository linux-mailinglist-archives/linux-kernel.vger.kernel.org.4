Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B447861FA4F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiKGQrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiKGQrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:47:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DBB01F2C9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:47:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0A191FB;
        Mon,  7 Nov 2022 08:47:22 -0800 (PST)
Received: from [10.57.36.248] (unknown [10.57.36.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 132AA3F534;
        Mon,  7 Nov 2022 08:47:15 -0800 (PST)
Message-ID: <e1d857df-7b6b-113f-1bed-2b5274d887c1@arm.com>
Date:   Mon, 7 Nov 2022 16:47:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] mte: Initialize tag storage to KASAN_TAG_INVALID
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20220907110015.11489-1-vincenzo.frascino@arm.com>
 <20221107151929.GB21002@willie-the-truck>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20221107151929.GB21002@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 11/7/22 15:19, Will Deacon wrote:
> On Wed, Sep 07, 2022 at 12:00:15PM +0100, Vincenzo Frascino wrote:
>> When the kernel is entered on aarch64, the MTE allocation tags are in an
>> UNKNOWN state.
>>
>> With MTE enabled, the tags are initialized:
>>  - When a page is allocated and the user maps it with PROT_MTE.
>>  - On allocation, with in-kernel MTE enabled (HW_TAGS KASAN).
>>
>> If the tag pool is zeroed by the hardware at reset, it makes it
>> difficult to track potential places where the initialization of the
>> tags was missed.
>>
>> This can be observed under QEMU for aarch64, which initializes the MTE
>> allocation tags to zero.
>>
>> Initialize to tag storage to KASAN_TAG_INVALID to catch potential
>> places where the initialization of the tags was missed.
>>
>> This is done introducing a new kernel command line parameter
>> "mte.tags_init" that enables the debug option.
>>
>> Note: The proposed solution should be considered a debug option because
>> it might have performance impact on large machines at boot.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/arm64/kernel/mte.c | 47 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 47 insertions(+)
> 
> I don't really see the point in this change -- who is going to use this
> option?
> 

I think this option can be useful to someone who is trying to debug a problem
that is related to a missed tag initialization and it is doing it on QEMU.

QEMU by default would mask this class of problems because it initializes to zero
the tags at "reset" (which is a valid UNKNOWN STATE according to the architecture).

I noticed this behavior because I was trying to debug a similar issue which I
was able to reproduce only on FVP.

Said that, I originally posted this patch as RFC back in April this year to find
out if someone else would find it useful, in fact my idea was to keep it locally.

Please let me know what do you want to do.

> Will

-- 
Regards,
Vincenzo
