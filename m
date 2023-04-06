Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511266D9076
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjDFHbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjDFHbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:31:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6311C76BD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:31:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3224016F8;
        Thu,  6 Apr 2023 00:32:26 -0700 (PDT)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 616F83F73F;
        Thu,  6 Apr 2023 00:31:39 -0700 (PDT)
Message-ID: <43d05005-052e-dd32-cf1e-17c569ebe2d9@arm.com>
Date:   Thu, 6 Apr 2023 09:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] cacheinfo: Check cache properties are present in DT
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Ghiti <alex@ghiti.fr>
References: <20230327115953.788244-1-pierre.gondois@arm.com>
 <20230327115953.788244-3-pierre.gondois@arm.com>
 <20230404-hatred-swimmer-6fecdf33b57a@spud>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230404-hatred-swimmer-6fecdf33b57a@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Conor,

On 4/4/23 21:29, Conor Dooley wrote:
> Hey Pierre,
> 
> On Mon, Mar 27, 2023 at 01:59:50PM +0200, Pierre Gondois wrote:
>> If a Device Tree (DT) is used, the presence of cache properties is
>> assumed. Not finding any is not considered. For arm64 platforms,
>> cache information can be fetched from the clidr_el1 register.
>> Checking whether cache information is available in the DT
>> allows to switch to using clidr_el1.
>>
>> init_of_cache_level()
>> \-of_count_cache_leaves()
>> will assume there a 2 cache leaves (L1 data/instruction caches), which
>> can be different from clidr_el1 information.
>>
>> cache_setup_of_node() tries to read cache properties in the DT.
>> If there are none, this is considered a success. Knowing no
>> information was available would allow to switch to using clidr_el1.
>>
> 
> Alex reported seeing a bunch of messages in his boot log in QEMU since
> -rc1 which appears to be the fault of, as far as I can tell, e0df442ee49
> ("cacheinfo: Check 'cache-unified' property to count cache leaves")
> like:
> cacheinfo: Unable to detect cache hierarchy for CPU N
> 
> The RISC-V QEMU virt machine doesn't define any cache properties of any
> sort in the dtb, and unlike the arm64 virt machine I tried (a72) doesn't
> have some registers that cache info is discoverable from.
> When we call of_count_cache_leaves() from init_of_cache_level() and
> there are of course no reasons to increment leaves, we hit the return 2
> case you mention above, setting num_leaves to 2.
> 
> As you mention, when we hit cache_setup_of_node(), levels is not going
> to be set to one, so we trigger the condition (this_leaf->level != 1)
> and, as there are no cache nodes, break out of the loop without
> incrementing index. Index is therefore less than 2, and thus we return
> -ENOENT.
> This is of course propagated back out to detect_cache_attributes() and
> triggers the "Unable to detect..." printout :(
> 
> With this patch(set), the spurious error prints go away, but we are left
> with a "Early cacheinfo failed, ret = -22" which will need to be fixed.
> 
> So I think this also needs to be:
> Fixes: de0df442ee49 ("cacheinfo: Check 'cache-unified' property to count cache leaves")
> 
> Probably also needs a:
> Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> since he's found an actual, rather than theoretical, problem!

Ok yes indeed, I will do this and the other comments you made,

Regards,
Pierre

> 
> Cheers,
> Conor.
> 
