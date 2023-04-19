Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6331B6E80A2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjDSRuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjDSRui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:50:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0017210CC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 10:50:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 583351424;
        Wed, 19 Apr 2023 10:51:20 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C2BB3F5A1;
        Wed, 19 Apr 2023 10:50:35 -0700 (PDT)
Message-ID: <ee7095b4-0bab-d98e-0f7e-633672458b50@arm.com>
Date:   Wed, 19 Apr 2023 18:50:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: SMP enablement on Cortex-R52 (using PSCI ?)
Content-Language: en-GB
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Ayan Kumar Halder <ayankuma@amd.com>
Cc:     mark.rutland@arm.com, lpieralisi@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <1cb7d428-c047-1485-e39d-465806f6ef0b@amd.com>
 <20230419084756.3gypfyuuezjj7tyd@bogus>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230419084756.3gypfyuuezjj7tyd@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 9:47 am, Sudeep Holla wrote:
> Hi Ayan,
> 
> On Fri, Apr 14, 2023 at 12:24:38PM +0100, Ayan Kumar Halder wrote:
>> Hi PSCI developers,
>>
>> We have a SoC where there are 4 Cortex-R52 which is distributed in two
>> clusters. So we have 2 Cortex-R52 in one cluster and 2 Cortex-R52 in another
>> cluster.
>>
>> We wish to enable SMP on the 2 R52 within a cluster with Xen hypervisor (EL2
>> software) running on them.
>>
>> We are trying to explore if we can use PSCI for booting the secondary cores.
>>
>> Refer Cortex-R52 TRM
>> (https://developer.arm.com/documentation/100026/0101/?lang=en ), it
>> specifies the following :-
>>
>> Page 24 - Section 1.4.1
>>
>> "Support for Exception levels, EL0, EL1, and EL2."
>>
>> Page 30 - Section 2.1.6
>>
>> "The Cortex-R52 processor does not implement TrustZone® technology. It does
>> not support the ability to distinguish between secure and non-secure
>> physical memories."
>>
>> Thus, there is no EL3 and secure world in Cortex-R52. It implements
>> AArch32-V8R architecture.
>>
> 
> KVM hypervisor use PSCI to bring up secondaries in the VMs. So I am sure we
> must be able to use the interface on Cortex-R52 without EL3.
> 
>>
>> Refer PSCI design document,
>> https://developer.arm.com/documentation/den0022/e/?lang=en
>>
>> Page 18 -
>> "The PSCI specification focuses on the interface between Security states for
>> power management. It provides a method for issuing power management
>> requests. To deal with the requests, the PPF must include a PSCI
>> implementation. A PSCI implementation might require communication between
>> the PPF and a Trusted OS or SP."
>>
>> Page 17 - Privileged Platform Firmware (PPF)
>>
>> "For Armv7 systems, or Armv8 systems using AArch32 at EL3, PPF executes in
>> EL3."
>>
>>  From the above two statements, I infer that PSCI requires a PPF (running at
>> EL3) and a Trusted OS (running at secure EL2). If this is correct, then R52
>> cannot support PSCI. Please correct me if I am mistaken.
>>
>> I wish to know how do we wake up the secondary core if PSCI is not
>> supported.
>>
> 
> I will check with the authors if EL3 is a must for PSCI implementation, but
> IMO it must not be though every aspects described in the spec may not apply
> when used across EL2/EL1 boundaries especially when EL3 is not implemented
> in the hardware.

Xen could provide PSCI to EL1 guests using the HVC conduit. However if 
EL2 is the highest implemented EL, then Xen is the most privileged 
software in the system - it would have to own the EL2 exception vectors, 
and it would have to own the low-level CPU bringup code. At that point 
it just wouldn't make much sense to HVC *itself* via the PSCI protocol 
when it could simply call the function directly.

Robin.
