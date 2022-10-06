Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066DB5F6220
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiJFHyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiJFHyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:54:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 021B0915D3;
        Thu,  6 Oct 2022 00:54:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86C271BB2;
        Thu,  6 Oct 2022 00:54:29 -0700 (PDT)
Received: from [10.57.35.228] (unknown [10.57.35.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1E4E3F792;
        Thu,  6 Oct 2022 00:54:21 -0700 (PDT)
Message-ID: <1094d467-797b-f795-a486-6d2bae1edcd6@arm.com>
Date:   Thu, 6 Oct 2022 09:54:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] Save cpuhp dynamic state
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220914162815.1954866-1-pierre.gondois@arm.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20220914162815.1954866-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Just a ping in case this was forgotten,

Regards,
Pierre

On 9/14/22 18:28, Pierre Gondois wrote:
> Requesting a CPUHP_AP_ONLINE_DYN cpuhp state reserves a state
> among the range [CPUHP_AP_ONLINE_DYN:CPUHP_AP_ONLINE_DYN_END].
> The reserved state must be saved in order to remove it later.
> 
> Cf. __cpuhp_setup_state_cpuslocked() documentation:
> Return:
>    On success:
>      Positive state number if @state is CPUHP_AP_ONLINE_DYN;
>      0 for all other states
> 
> Indeed, the following:
>    cpuhp_remove_state(CPUHP_AP_ONLINE_DYN);
> removes the first dynamic states added to the cpuhp state machine.
> 
> Patches were tested as:
> - powercap/drivers/dtpm: on a Juno-r2, using a late_initcall()
>    to init and exit the dtpm framework.
> - driver: soc: xilinx: the patch was only compile tested
>    due to missing hardware.
> 
> Pierre Gondois (2):
>    driver: soc: xilinx: Save cpuhp dynamic state
>    powercap/drivers/dtpm: Save cpuhp dynamic state
> 
>   drivers/powercap/dtpm_cpu.c             |  7 ++++++-
>   drivers/soc/xilinx/xlnx_event_manager.c | 12 ++++++++++--
>   2 files changed, 16 insertions(+), 3 deletions(-)
> 
