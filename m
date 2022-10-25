Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F01D60D110
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiJYP4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiJYPz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:55:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8B8517650D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:55:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B363FD6E;
        Tue, 25 Oct 2022 08:56:01 -0700 (PDT)
Received: from [10.1.197.78] (unknown [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 542F13F71A;
        Tue, 25 Oct 2022 08:55:54 -0700 (PDT)
Message-ID: <715e4123-fdb3-a71e-4069-91d16a56a308@arm.com>
Date:   Tue, 25 Oct 2022 16:55:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
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
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
 <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
 <CALPaoCgiwtvxZMJ6f-BOTNMPXDbMB8QM42HyCAvYRi4grPiphQ@mail.gmail.com>
 <CALPaoCg2-9ARbK+MEgdvdcjJtSy_2H6YeRkLrT97zgy8Aro3Vg@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCg2-9ARbK+MEgdvdcjJtSy_2H6YeRkLrT97zgy8Aro3Vg@mail.gmail.com>
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

On 21/10/2022 13:42, Peter Newman wrote:
> On Thu, Oct 20, 2022 at 12:39 PM Peter Newman <peternewman@google.com> wrote:
>>
>> On Wed, Oct 19, 2022 at 3:58 PM James Morse <james.morse@arm.com> wrote:
>>> The devil is in the detail, I'm not sure how it serialises with a fork()ing process, I'd
>>> hope to do better than relying on the kernel walking the list of processes a lot quicker
>>> than user-space can.
>>
>> I wasn't planning to do it any more optimally than the rmdir
>> implementation today when looking for all tasks impacted by a
>> CLOSID/RMID deletion.
> 
> This is probably a separate topic, but I noticed this when looking at how rmdir
> moves tasks to a new closid/rmid...
> 
> In rdt_move_group_tasks(), how do we know that a task switching in on another
> CPU will observe the updated closid and rmid values soon enough?
> 
> Even on x86, without an smp_mb(), the stores to t->closid and t->rmid could be
> reordered with the task_curr(t) and task_cpu(t) reads which follow. The original
> description of this scenario seemed to assume that accesses below would happen
> in program order:
> 
>     WRITE_ONCE(t->closid, to->closid);
>     WRITE_ONCE(t->rmid, to->mon.rmid);
> 
>     /*
>      * If the task is on a CPU, set the CPU in the mask.
>      * The detection is inaccurate as tasks might move or
>      * schedule before the smp function call takes place.
>      * In such a case the function call is pointless, but
>      * there is no other side effect.
>      */
>     if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
>          cpumask_set_cpu(task_cpu(t), mask);
> 
> If the task concurrently switches in on another CPU, the code above may not
> observed that it's running, and the CPU running the task may not have observed
> the updated rmid and closid yet, so it could continue with the old rmid/closid
> and not get interrupted.

Makes sense to me - do you want to send a patch to fix it?


Thanks,

James
