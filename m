Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DFF60D113
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiJYP4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiJYP4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:56:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB62217A94A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:56:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81F6DD6E;
        Tue, 25 Oct 2022 08:56:27 -0700 (PDT)
Received: from [10.1.197.78] (unknown [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5C0F3F71A;
        Tue, 25 Oct 2022 08:56:19 -0700 (PDT)
Message-ID: <c1ed6c5d-c3fa-fa76-686a-033fe803a74d@arm.com>
Date:   Tue, 25 Oct 2022 16:56:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-GB
To:     Peter Newman <peternewman@google.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Babu Moger <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com>
 <CALPaoCg4zrODVoXF2y2b+LRYq_+jnV8yv5qB+T_3Z264cV82GQ@mail.gmail.com>
 <b931062a-1a70-2331-03cc-6bfa69a51bee@intel.com>
 <CALPaoCj8ps2YRH5T1eCRY-8MLwGi25cfbd0KNtjYXTq5baAXOQ@mail.gmail.com>
 <da89ea90-8453-f848-38d1-a14195faa95e@intel.com>
 <CALPaoChgi9Z8J7sca_YRHveBW9NzB=PPC1Yp01S=TGiJLBxkQw@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoChgi9Z8J7sca_YRHveBW9NzB=PPC1Yp01S=TGiJLBxkQw@mail.gmail.com>
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

Hi Peter,

On 21/10/2022 11:09, Peter Newman wrote:
> On Thu, Oct 20, 2022 at 9:08 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> If the expectation is that PARTID counts are very high then how about
>> a solution where multiple PARTIDs are associated with the same CTRL_MON group?
>> A CTRL_MON group presents a resource allocation to user space, CLOSIDs/PARTIDs
>> are not exposed. So using multiple PARTIDs for a resource group (all with the
>> same allocation) seems conceptually ok to me. (Please note, I did not do an
>> audit to see if there are any hidden assumption or look into lifting required
>> to support his.)

> I did propose using PARTIDs to back additional mon_groups a few days ago
> on the other sub-thread with James. My understanding was that it would
> be less trouble if the user opted to do this on their own rather than
> the kernel somehow doing this automatically.
> 
> https://lore.kernel.org/all/835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com/

> So perhaps we can just arrive at some way to inform the user of the
> difference in resources. We may not even need to be able to precisely
> calculate the number of groups we can create, as the logic for us could
> be a simple as:
> 
> 1) If num_closids >= desired job count, just use CTRL_MON groups

> 2) Otherwise, fall back to the proposed mon_group-move approach if
> num_rmids is large enough for the desired job count

> To address the glitchy behavior of moving a PMG to a new PARTID, I found
> that the MPAM spec says explicitly that a PMG is subordinate to a
> PARTID, so I would be fine with James finding a way for the MPAM driver
> to block the rename operation, because it's unable to mix and match
> RMIDs and CLOSIDs the way that RDT can.

I'd like to support moving groups of tasks in a sensible way on MPAM too.

I don't think we should conflate it with 'old counters keep counting' - that should be
exposed as a separate property that influences how user-space sets this stuff up.


Thanks,

James
