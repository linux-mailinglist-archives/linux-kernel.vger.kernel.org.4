Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2F26DED48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjDLIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjDLIMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:12:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0745C61B8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:12:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D87CD75;
        Wed, 12 Apr 2023 01:13:20 -0700 (PDT)
Received: from [10.34.100.129] (pierre123.nice.arm.com [10.34.100.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C8D33F587;
        Wed, 12 Apr 2023 01:12:33 -0700 (PDT)
Message-ID: <3eac7e96-f3b3-ff66-d3f9-afb21fe17921@arm.com>
Date:   Wed, 12 Apr 2023 10:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/3] cacheinfo: Check cache properties are present in
 DT
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
References: <20230412071809.12670-1-pierre.gondois@arm.com>
 <20230412071809.12670-3-pierre.gondois@arm.com>
 <20230412-cone-mousiness-23326e149592@wendy>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230412-cone-mousiness-23326e149592@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Conor,

On 4/12/23 09:55, Conor Dooley wrote:
> Hey Pierre!
> 
> On Wed, Apr 12, 2023 at 09:18:05AM +0200, Pierre Gondois wrote:
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
> 
> Hmm, w/ this series I am still seeing a:
> [    0.306736] Early cacheinfo failed, ret = -22
> 
> Not finding any cacheinfo is totally valid, right?
> 
> A basic RISC-V QEMU setup is sufficient to reproduce, for instance:
> | $(qemu) \
> | 	-m 2G -smp 5 \
> | 	-M virt -nographic \
> | 	-kernel $(vmlinux_bin)

Sorry I forgot to remove the:
   pr_err("Early cacheinfo failed, ret = %d\n", ret);

I ll wait until tomorrow to send a v3 with this fixed.

Thanks for testing,
Regards,
Pierre

> 
> Cheers,
> Conor.
> 
