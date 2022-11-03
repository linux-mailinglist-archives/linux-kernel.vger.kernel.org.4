Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF746185C9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiKCRIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiKCRHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EF9111C09
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:06:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64B9F1FB;
        Thu,  3 Nov 2022 10:06:44 -0700 (PDT)
Received: from [10.1.197.38] (eglon.cambridge.arm.com [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A2AE3F5A1;
        Thu,  3 Nov 2022 10:06:36 -0700 (PDT)
Message-ID: <0c6fdf46-284c-6ed1-db44-a1e93037afe3@arm.com>
Date:   Thu, 3 Nov 2022 17:06:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-GB
To:     Peter Newman <peternewman@google.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
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
 <a4def722-aa98-6bf9-6e77-65a9fd9bd8ca@arm.com>
 <CALPaoCgdk_Yaw_EQ1ca9-h5L+sHBEkm3TpT-o84TC4AxWDSsbg@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCgdk_Yaw_EQ1ca9-h5L+sHBEkm3TpT-o84TC4AxWDSsbg@mail.gmail.com>
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

On 26/10/2022 10:36, Peter Newman wrote:
> On Tue, Oct 25, 2022 at 5:56 PM James Morse <james.morse@arm.com> wrote:
>> This would work when systems are built to look like RDT, but MPAM has other control types
>> where this would have interesting behaviours.
>>
>> 'CPOR' is equivalent to CBM as they are both a bitmap of portions. MPAM also has 'CMAX'
>> where a fraction of the cache is specified. If you create two control groups with
>> different PARTIDs but the same configuration, their two 50%s of the cache could become
>> 100%. CPOR can be used like this, CMAX can't.

> I thought we only allocated caches with CBMs and memory bandwidth with
> percentages.

Those are the existing schema, yes.


> I don't see how CMAX could be used when implementing resctrl's CAT
> resources. Percentage
> configurations are only used for MBA in resctrl today.

The problem is if you say "CLOSID/PARTID are random, its the configuration that matters",
you've broken all the control types where the regulation is happening based on the PARTID
and the configuration, not the configuration alone.

If you do this, you can't ever have schema that use those configuration schemes.
There is hardware out there that supports these schemes.


>> Even when the controls behave in the same way, a different PARTID with the same control
>> values could be regulated differently, resulting in weirdness.
> 
> Can you provide further examples?

CMAX, MBW_MIN and MBW_MAX: You can have 50%, and I can have 50%. Your secret clones which
have different PARTID and a copy of your configuration also get 50%. As far as the
hardware is concerned, we're trying to play with more than 100% of the resource.

I don't know what the memory controller people are building, but naively I think the MBW
MIN/MAX stuff is a more natural fit that a bandwidth bitmap.


You couldn't ever add new configuration schemes that are based on a fraction or percentage
of the resource.



Thanks,

James
