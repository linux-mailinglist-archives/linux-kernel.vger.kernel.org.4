Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AD66C74D2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 02:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjCXBA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 21:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCXBA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:00:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 339441D901
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 18:00:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0C631576;
        Thu, 23 Mar 2023 18:01:37 -0700 (PDT)
Received: from [10.57.18.93] (unknown [10.57.18.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D33273F766;
        Thu, 23 Mar 2023 18:00:50 -0700 (PDT)
Message-ID: <61b0e30a-568c-d7f6-7b67-e9fc8b68de25@arm.com>
Date:   Fri, 24 Mar 2023 01:00:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 04/10] arm64: mops: document boot requirements for MOPS
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
References: <20230216160012.272345-1-kristina.martsenko@arm.com>
 <20230216160012.272345-5-kristina.martsenko@arm.com>
 <ZBSCObGmIXjyeMA6@arm.com>
From:   Kristina Martsenko <kristina.martsenko@arm.com>
In-Reply-To: <ZBSCObGmIXjyeMA6@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 15:07, Catalin Marinas wrote:
> On Thu, Feb 16, 2023 at 04:00:06PM +0000, Kristina Martsenko wrote:
>> +  For CPUs with Memory Copy and Memory Set instructions (FEAT_MOPS):
>> +
>> +  - If the kernel is entered at EL1 and EL2 is present:
>> +
>> +    - HCRX_EL2.MSCEn (bit 11) must be initialised to 0b1.
>> +
>> +    - HCRX_EL2.MCE2 (bit 10) must be initialised to 0b0.
> 
> Regarding MCE2, does EL1 actually care if EL2 wants to handle all the
> memcpy/memset exceptions? 

No, EL1 does not need to handle the exceptions itself, but I don't see any
current use case for allowing EL2 to handle it.

If it was allowed, I think booting.txt would need to specify exactly what Linux
expects EL2 to do if MCE2 is set (eg, that EL2 handles the exception by
reformatting registers, modifying single step state, etc).

> There may even be a valid case to do this at
> EL2 if you run a guest that uses these instructions but has no clue on
> how to deal with the specific exception like WrongOption.

Not sure I follow - this series adds the exception handling, so how can a Linux
guest not know how to handle the exception?

Or do you mean that there may be times when EL1 can't take the exception but
EL2 may move it to another CPU, and so EL2 would need to handle the exception?
I'm not sure if Linux ever uses mops instructions at times like that. Note that
this series does not add support for mops in guests yet. I think booting.txt
can be updated when that support is added.

Thanks,
Kristina

