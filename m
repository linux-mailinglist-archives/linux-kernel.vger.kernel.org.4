Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC586E1DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjDNIUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjDNIUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:20:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72AFF30EA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:20:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD03C2F4;
        Fri, 14 Apr 2023 01:20:50 -0700 (PDT)
Received: from [10.57.19.162] (unknown [10.57.19.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F19343F6C4;
        Fri, 14 Apr 2023 01:20:01 -0700 (PDT)
Message-ID: <2a05dac0-c57e-a3cd-ec4d-55cf32e6dce9@arm.com>
Date:   Fri, 14 Apr 2023 10:19:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/4] cacheinfo: Check cache properties are present in
 DT
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
References: <20230413091436.230134-1-pierre.gondois@arm.com>
 <20230413091436.230134-3-pierre.gondois@arm.com>
 <4da53918-839b-4d28-0634-66fd7f38c8bd@gmail.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <4da53918-839b-4d28-0634-66fd7f38c8bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Florian,

On 4/13/23 20:16, Florian Fainelli wrote:
> On 4/13/23 02:14, Pierre Gondois wrote:
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
>> Fixes: de0df442ee49 ("cacheinfo: Check 'cache-unified' property to count cache leaves")
>> Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> 
> Humm, it would appear that the cache levels and topology is still
> provided, despite the lack of cache properties in the Device Tree which
> is intended by this patch set however we lost the size/ways/sets
> information, could we not complement the missing properties here?
> 
> If this is out of the scope of what you are doing:
> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>

I submitted a v4 at:
https://lore.kernel.org/all/20230414081453.244787-1-pierre.gondois@arm.com/

I haven't included your Tested-by as there were some small changes.
If you consider these changes are small enough to include your tag,
please let know,

Regards,
Pierre
