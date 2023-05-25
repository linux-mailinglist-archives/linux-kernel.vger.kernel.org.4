Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62AE71126A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239995AbjEYRcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjEYRcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:32:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 832B3139
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:31:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 580541042;
        Thu, 25 May 2023 10:32:43 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C3C73F6C4;
        Thu, 25 May 2023 10:31:55 -0700 (PDT)
Message-ID: <bece178a-0e4e-f73d-92e7-4f603b4211d0@arm.com>
Date:   Thu, 25 May 2023 18:31:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 00/19] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Content-Language: en-GB
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        Drew Fustini <dfustini@baylibre.com>
References: <20230320172620.18254-1-james.morse@arm.com>
 <ZGz0as//iEbRpHHs@agluck-desk3>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <ZGz0as//iEbRpHHs@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

(CC: +Drew)

On 23/05/2023 18:14, Tony Luck wrote:
> Looking at the changes already applied, and those planned to support
> new architectures, new features, and quirks in specific implementations,
> it is clear to me that the original resctrl file system implementation
> did not provide enough flexibility for all the additions that are
> needed.
> 
> So I've begun musing with 20-20 hindsight on how resctrl could have
> provided better abstract building blocks.

Heh, hindsight is 20:20!

My responses below are pretty much entirely about how this looks to user-space, that is
the bit we can't change.


> The concept of a "resource" structure with a list of domains for
> specific instances of that structure on a platform still seems like
> a good building block.

True, but having platform specific resource types does reduce the effectiveness of a
shared interface. User-space just has to have platform specific knowledge for these.

I think defining resources in terms of other things that are visible to user-space through
sysfs is the best approach. The CAT L3 schema does this.


In terms of the values used, I'd much prefer 'weights' or some other abstraction had been
used, to allow the kernel to pick the hardware configuration itself.
Similarly, properties like isolation between groups should be made explicit, instead of
asking "did user-space mean to set shared bits in those bitmaps?"

This stuff is the reason why resctrl can't support MPAM's 'CMAX', that gives a maximum
capacity limit for a cache, but doesn't implicitly isolate groups.


> But sharing those structures across increasingly different implementations
> of the underlying resource is resulting in extra gymnastic efforts to
> make all the new uses co-exist with the old. E.g. the domain structure
> has elements for every type of resource even though each instance is
> linked to just one resource type.

> I had begun this journey with a plan to just allow new features to
> hook into the existing resctrl filesystem with a "driver" registration
> mechanism:
> 
> https://lore.kernel.org/all/20230420220636.53527-1-tony.luck@intel.com/
> 
> But feedback from Reinette that this would be cleaner if drivers created
> new resources, rather than adding a patchwork of callback functions with
> special case "if (type == DRIVER)" sprinkled around made me look into
> a more radical redesign instead of joining in the trend of making the
> smallest set of changes to meet my goals.
> 
> 
> Goals:
> 1) User interfaces for existing resource control features should be
> unchanged.
> 
> 2) Admin interface should have the same capabilities, but interfaces
> may change. E.g. kernel command line and mount options may be replaced
> by choosing which resource modules to load.
> 
> 3) Should be easy to create new modules to handle big differences
> between implementations, or to handle model specific features that
> may not exist in the same form across multiple CPU generations.

The difficulty is knowing some behaviour is going to be platform specific, its not until
the next generation is different that you know there was something wrong with the first.

The difficulty is user-space expecting a resource that turned out to be platform-specific,
or was 'enhanced' in a subsequent version and doesn't behave in the same way.

I suspect we need two sets of resources, those that are abstracted to work in a portable
way between platforms and architectures - and the wild west.
The next trick is moving things between the two!


> Initial notes:
> 
> Core resctrl filesystem functionality will just be:
> 
> 1) Mount/unmount of filesystem. Architecture hook to allocate monitor
> and control IDs for the default group.
> 
> 2) Creation/removal/rename of control and monitor directories (with
> call to architecture specific code to allocate/free the control and monitor
> IDs to attach to the directory.
> 
> 3) Maintaining the "tasks" file with architecture code to update the
> control and monitor IDs in the task structure.
> 
> 4) Maintaining the "cpus" file - similar to "tasks"
> 
> 5) Context switch code to update h/w with control/monitor IDs.
> 
> 6) CPU hotplug interface to build and maintain domain list for each
> registered resource.
> 
> 7) Framework for "schemata" file. Calls to resource specific functions
> to maintain each line in the file.

> 8) Resource registration interface for modules to add new resources
> to the list (and remove them on module unload). Modules may add files
> to the info/ hierarchy, and also to each mon_data/ directory and/or
> to each control/control_mon directory.

I worry that this can lead to architecture specific schema, then each architecture having
a subtly different version. I think it would be good to keep all the user-ABI in one place
so it doesn't get re-invented. I agree its hard to know what the next platfrom will look like.

One difference I can't get my head round is how to handle platforms that use relative
percentages and fractions - and those that take an absolute MB/s value.


> 9) Note that the core code starts with an empty list of resources.
> System admins must load modules to add support for each resource they
> want to use.

I think this just moves the problem to modules. 'CAT' would get duplicated by all
architectures. MB is subtly different between them all, but user-space doesn't want to be
concerned with the differences.


> We'd need a bunch of modules to cover existing x86 functionality. E.g.
> an "L3" one for standard L3 cache allocation, an "L3CDP" one to be used
> instead of the plain "L3" one for code/data priority mode by creating
> a separate resource for each of code & data.

CDP may have system wide side-effects. For MPAM if you enable the emulation of that, then
resources that resctrl doesn't believe use CDP have to double-configure and double-count
everything.


> Logically separate mbm_local, mbm_total, and llc_cache_occupancy modules
> (though could combine the mbm ones because they both need a periodic
> counter read to avoid wraparound). "MB" for memory bandwidth allocation.

llc_cache_occupancy isn't a counter, but I'd prefer to bundle the others through perf.
That already has an interface for discovering and configuring events. I understand it was
tried and removed, but I think I've got a handle on making this work.


> The "mba_MBps" mount option would be replaced with a module that does
> both memory bandwidth allocation and monitoring, with a s/w feedback loop.

Keeping purely software features self contained is a great idea.


> Peter's workaround for the quirks of AMD monitoring could become a
> separate AMD specific module. But minor differences (e.g. contiguous
> cache bitmask Intel requirements) could be handled within a module
> if desired.
> 
> Pseudo-locking would be another case to load a different module to
> set up pseudo-locking and enforce the cache bitmask rules between resctrl
> groups instead of the basic cache allocation one.
> 
> Core resctrl code could handle overlaps between modules that want to
> control the same resource with a "first to load reserves that feature"
> policy.

> Are there additional ARM specific architectural requirements that this
> approach isn't addressing? Could the core functionality be extended to
> make life easier for ARM?

(We've got RISC-V to consider too - hence adding Drew Fustini [0])

My known issues list is:
* RMIDs.
   These are an independent number space for RDT. For MPAM they are an
   extension of the partid/closid space. There is no value that can be
   exposed to user-space as num_rmid as it depends on how they will be
   used.

* Monitors.
   RDT has one counter per RMID, they run continuously. MPAM advertises
   how many monitors it has, which is very likely to be fewer than we
   want. This means MPAM can't expose the free-runing MBM_* counters
   via the filesystem. These would need exposing via perf.

 * Bitmaps.
   MPAM has some bitmaps, but it has other stuff too. Forcing the bitmaps
   to be the user-space interface requires the underlying control to be
   capable of isolation. Ideally user-space would set a priority/cost for
   each rdtgroup, and indicate whether they should be isolated from other
   rdtgroup at the same level.

 * Memory bandwidth.
   For MB resources that control bandwidth, X86 provides user-space with
   the cache-id of the cache that implements that bandwidth controls. For
   MPAM there is no expectation that this is being done by a cache, it could
   equally be a memory controller.


I'd really like to have these solved as part of a cross-architecture user-space ABI. I'm
not sure platform-specific modules solve the user-space problem.


Otherwise MPAM has additional types of control, which could be applied to any kind of
resource. The oddest is 'PRI' which is just a priority. I've not yet heard of a system
using it, but this could appear at any choke point in the SoC, it may not be on a cache or
memory controller.

The 'types of control' and 'resource' distinction may help in places where Intel/AMD take
wildly different values to configure the same resource. (*cough* MB)


Thanks,

James


[0] lore.kernel.org/r/20230430-riscv-cbqri-rfc-v2-v2-0-8e3725c4a473@baylibre.com
