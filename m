Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CA3686B6B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjBAQUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjBAQUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:20:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CBB966EEF;
        Wed,  1 Feb 2023 08:20:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43286C14;
        Wed,  1 Feb 2023 08:21:00 -0800 (PST)
Received: from [10.34.100.128] (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF6593F64C;
        Wed,  1 Feb 2023 08:20:16 -0800 (PST)
Message-ID: <fb5b9767-f676-1098-de9b-b0dc78cda268@arm.com>
Date:   Wed, 1 Feb 2023 17:20:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] Save cpuhp dynamic state
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220914162815.1954866-1-pierre.gondois@arm.com>
 <1094d467-797b-f795-a486-6d2bae1edcd6@arm.com>
In-Reply-To: <1094d467-797b-f795-a486-6d2bae1edcd6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel, Abhyuday,
Another ping just in case,

Regards,
Pierre

On 10/6/22 09:54, Pierre Gondois wrote:
> Hello,
> Just a ping in case this was forgotten,
> 
> Regards,
> Pierre
> 
> On 9/14/22 18:28, Pierre Gondois wrote:
>> Requesting a CPUHP_AP_ONLINE_DYN cpuhp state reserves a state
>> among the range [CPUHP_AP_ONLINE_DYN:CPUHP_AP_ONLINE_DYN_END].
>> The reserved state must be saved in order to remove it later.
>>
>> Cf. __cpuhp_setup_state_cpuslocked() documentation:
>> Return:
>>     On success:
>>       Positive state number if @state is CPUHP_AP_ONLINE_DYN;
>>       0 for all other states
>>
>> Indeed, the following:
>>     cpuhp_remove_state(CPUHP_AP_ONLINE_DYN);
>> removes the first dynamic states added to the cpuhp state machine.
>>
>> Patches were tested as:
>> - powercap/drivers/dtpm: on a Juno-r2, using a late_initcall()
>>     to init and exit the dtpm framework.
>> - driver: soc: xilinx: the patch was only compile tested
>>     due to missing hardware.
>>
>> Pierre Gondois (2):
>>     driver: soc: xilinx: Save cpuhp dynamic state
>>     powercap/drivers/dtpm: Save cpuhp dynamic state
>>
>>    drivers/powercap/dtpm_cpu.c             |  7 ++++++-
>>    drivers/soc/xilinx/xlnx_event_manager.c | 12 ++++++++++--
>>    2 files changed, 16 insertions(+), 3 deletions(-)
>>
