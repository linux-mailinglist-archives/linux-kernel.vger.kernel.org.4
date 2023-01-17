Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC46166DE24
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbjAQMwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbjAQMvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:51:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 048B738EB2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:51:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0875C14;
        Tue, 17 Jan 2023 04:51:53 -0800 (PST)
Received: from [10.57.75.222] (unknown [10.57.75.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D9763F67D;
        Tue, 17 Jan 2023 04:51:10 -0800 (PST)
Message-ID: <b366355b-1f63-ee5d-28d7-9269cb699d0e@arm.com>
Date:   Tue, 17 Jan 2023 12:51:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/4] iommu: Introduce IOMMU call-back for processing
 struct KVM assigned to VFIO
Content-Language: en-GB
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     joro@8bytes.org, ashish.kalra@amd.com, thomas.lendacky@amd.com,
        vasant.hegde@amd.com, jon.grimm@amd.com
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-4-suravee.suthikulpanit@amd.com>
 <e4d5db37-a7b9-9b33-4ecf-c168b6d41a9a@arm.com>
 <04dc1bc9-05ed-f6ed-f01f-7d28600fc0ce@amd.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <04dc1bc9-05ed-f6ed-f01f-7d28600fc0ce@amd.com>
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

On 2023-01-17 04:20, Suthikulpanit, Suravee wrote:
> Hi Robin,
> 
> On 1/10/2023 10:11 PM, Robin Murphy wrote:
>> On 2023-01-10 14:31, Suravee Suthikulpanit wrote:
>>> Currently, VFIO provide an kvm_vfio_file_set_kvm() interface for 
>>> assigning
>>> a KVM structure to a VFIO group. The information in struct KVM is also
>>> useful for IOMMU drivers when setting up VFIO domain.
>>>
>>> Introduce struct iommu_domain_ops.set_kvm call-back function to allow
>>> IOMMU drivers to provide call-back to process the struct KVM assigned.
>>
>> Hmm, it sounds like this has quite some overlap of intent with the 
>> existing "enable_nesting" op, and my gut feeling is that it's not 
>> great to have two completely different "this is a VFIO domain" 
>> mechanisms... :/
>>
>> Robin.
> 
> Actually, the intention is to communicate KVM information, which is 
> already available to the VFIO down to the AMD IOMMU driver layer. I am 
> not sure if the enable_nesting() has enough information or the same 
> intention since that only communicates VFIO domain information.

Sure, but from the high level view, we have on the one hand an API for 
"I want to use this domain in a VM (with nested paging)" and on other an 
API for "I want to use nested paging in this domain (for a VM)", so 
clearly it would be most sensible to converge on a single API for what 
is ultimately one single overarching use-case.

I'm not claiming that the existing enable_nesting op is anywhere near 
the right design either; in fact I'm pretty sure it isn't, if the Arm 
SMMU drivers ever want to contemplate sharing stage 2 pagetables with 
KVM also.

Cheers,
Robin.
