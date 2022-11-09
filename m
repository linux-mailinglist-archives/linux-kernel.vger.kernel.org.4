Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E646231F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiKISCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiKISCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:02:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C41F41FF8D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:58:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B568F1FB;
        Wed,  9 Nov 2022 09:59:01 -0800 (PST)
Received: from [10.1.197.38] (eglon.cambridge.arm.com [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D7393F703;
        Wed,  9 Nov 2022 09:58:54 -0800 (PST)
Message-ID: <edf29379-5979-5f5a-238c-bcc489cb66ac@arm.com>
Date:   Wed, 9 Nov 2022 17:58:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-GB
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Peter Newman <peternewman@google.com>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
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
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
 <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
 <09029c7a-489a-7054-1ab5-01fa879fb42f@intel.com>
 <f80299a4-7eaf-46a0-89e6-b9f5385f183c@arm.com>
 <c227a0df-7ac8-91f3-cada-0ca5ec047579@intel.com>
 <SJ1PR11MB6083CEB7E30E44F31EC3CA6EFC3F9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ae4d280c-99e1-88ce-db2d-3ff7a845433d@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <ae4d280c-99e1-88ce-db2d-3ff7a845433d@intel.com>
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

Hi Reinette, Tony,

On 08/11/2022 23:18, Reinette Chatre wrote:
> On 11/8/2022 1:56 PM, Luck, Tony wrote:
>>> Looking at some history there even seems to have been some work surrounding
>>> "rotating" of RMIDs that seem related to what you mention above:
>>>
>>> commit bff671dba7981195a644a5dc210d65de8ae2d251
>>> Author: Matt Fleming <matt.fleming@intel.com>
>>> Date:   Fri Jan 23 18:45:47 2015 +0000
>>>
>>>     perf/x86/intel: Perform rotation on Intel CQM RMIDs
>>>
>>>     There are many use cases where people will want to monitor more tasks
>>>     than there exist RMIDs in the hardware, meaning that we have to perform
>>>     some kind of multiplexing.
>>
>> That would work for monitoring memory bandwidth. But not for LLC occupancy
>> as there's no way to set an occupancy counter to the value of what the new set of
>> processes are using. So you'd have to live with nonsense values for a potentially
>> long time until natural LLC evictions and re-fills sorted things out.  Either that or
>> flush the entire LLC when reassigning an RMID so you can count up from zero
>> as the cache is re-filled.
> 
> Tony helped me to find some more history here. Please see the commit message
> of the patch below for some information on why the perf support was removed.
> This is not all specific to monitoring of cache occupancy.

Thanks!

I'll be sure to cite this in the future perf support, and check I've covered all the
issues described here.


James


> commit c39a0e2c8850f08249383f2425dbd8dbe4baad69
> Author: Vikas Shivappa <vikas.shivappa@linux.intel.com>
> Date:   Tue Jul 25 14:14:20 2017 -0700
> 
>     x86/perf/cqm: Wipe out perf based cqm
