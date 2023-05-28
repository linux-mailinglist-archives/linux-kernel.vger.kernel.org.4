Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9CB714057
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 22:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjE1UsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 16:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE1UsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 16:48:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E647B8
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 13:48:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b025d26f4fso13614895ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 13:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685306887; x=1687898887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3ro8L4Bel4MLnIw4kOiMzRj57HjJf9saldTOXIrWKs=;
        b=oLYjkEqw2Xc5h/Y28g8gcRVWd7zuEf05tb/K+dq//TpTBbE1hEIQgKZWGvroIxnM6J
         jBVDd/1JcHIt6cAgzzeerQ9Ple7BlXmMF8AAlFexU/c+z1A7la/qN1TZAdxYPpVnljm3
         SFqD9374TcGn9kUJ80xfHSaIZjDQQCVh26nqscQL14sDdRoF8hWegaHCNOkjHkyOwG8P
         OS/0ypkz/03SrL4mpDA1wQ0zW7Hqn7bIx8AAUcesQfRoPb7syngpr/QfbF8pLsP6Yg0K
         HLWlVD282kABmYx8HGIlns8uS01ey4szw2sBio+zNhxr/DoPzpHSfJz62ZhD9hr1QBRP
         MHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685306887; x=1687898887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3ro8L4Bel4MLnIw4kOiMzRj57HjJf9saldTOXIrWKs=;
        b=I1757foxOMzd1lwg1dqwR28tcQZJOyavg+DGJNJchyYUXr3KvWrjA3Awu1FxzT8LD2
         SS4QlE5+PtEYBFMEu/UTOX7Hr3mBS3aV9hS2idM5rTyFHMWS6PslchRlCXcEWTOdwDV6
         ftEAhCbS6N5LVkLfPBanqr2lqM7eywWG2QT/7Q7iicwJCyGMA0GgSxFxi1f4hK80W6gn
         X9lFimNK/CqgCXI2lBRWgVY1VhKysqUlWJNK6DH0oQ102nd9XmUlCQg9K87f3rrVuec5
         yP0lERkKPrvg3t/WJf8rPUQmbl10TehqOnIjl0PeLPulNktrYbzF4FVOz6WOjLWrZdYK
         HUJQ==
X-Gm-Message-State: AC+VfDy18QMAf/szWra4FjZO4vTxI3GZT9O0Cz3NFzUOmUGzp+LWaNE/
        6C7xWcKcZkF2CmbVvPdyDFsGbw==
X-Google-Smtp-Source: ACHHUZ6VS8D6DPMgAlTpyZj1K/KIGkCjUkbuZ23gtiLDjknepKGCrlLL4opuNO3gqqnuf7SPojJ6qw==
X-Received: by 2002:a17:902:bf4c:b0:1af:9b8a:9c75 with SMTP id u12-20020a170902bf4c00b001af9b8a9c75mr8333613pls.7.1685306887346;
        Sun, 28 May 2023 13:48:07 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:8b38:d927:dc30:943])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001afa7040a70sm6639322plf.276.2023.05.28.13.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 13:48:06 -0700 (PDT)
Date:   Sun, 28 May 2023 13:52:06 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
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
        Nicolas Pitre <npitre@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, aricciardi@baylibre.com
Subject: Re: [PATCH v3 00/19] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Message-ID: <ZHO+9mQFKxuIb80U@x1>
References: <20230320172620.18254-1-james.morse@arm.com>
 <ZGz0as//iEbRpHHs@agluck-desk3>
 <bece178a-0e4e-f73d-92e7-4f603b4211d0@arm.com>
 <ZG/MZVrWYrCHm/fr@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG/MZVrWYrCHm/fr@agluck-desk3>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 02:00:21PM -0700, Tony Luck wrote:
> On Thu, May 25, 2023 at 06:31:54PM +0100, James Morse wrote:
> > Hi Tony,
> > 
> > (CC: +Drew)

Hi Tony and James, thank you for bringing RISC-V QoS into the
converstaion.

> 
> James: Thanks for all the comments below, and pulling in Drew for eyes
> from another architecture.
> 
> > 
> > On 23/05/2023 18:14, Tony Luck wrote:
> > > Looking at the changes already applied, and those planned to support
> > > new architectures, new features, and quirks in specific implementations,
> > > it is clear to me that the original resctrl file system implementation
> > > did not provide enough flexibility for all the additions that are
> > > needed.
> > > 
> > > So I've begun musing with 20-20 hindsight on how resctrl could have
> > > provided better abstract building blocks.
> > 
> > Heh, hindsight is 20:20!
> > 
> > My responses below are pretty much entirely about how this looks to user-space, that is
> > the bit we can't change.
> > 
> > 
> > > The concept of a "resource" structure with a list of domains for
> > > specific instances of that structure on a platform still seems like
> > > a good building block.
> > 
> > True, but having platform specific resource types does reduce the effectiveness of a
> > shared interface. User-space just has to have platform specific knowledge for these.
> > 
> > I think defining resources in terms of other things that are visible to user-space through
> > sysfs is the best approach. The CAT L3 schema does this.
> > 
> > 
> > In terms of the values used, I'd much prefer 'weights' or some other abstraction had been
> > used, to allow the kernel to pick the hardware configuration itself.
> > Similarly, properties like isolation between groups should be made explicit, instead of
> > asking "did user-space mean to set shared bits in those bitmaps?"
> > 
> > This stuff is the reason why resctrl can't support MPAM's 'CMAX', that gives a maximum
> > capacity limit for a cache, but doesn't implicitly isolate groups.
> 
> User interface is the trickiest problem when looking to make changes.
> But doubly so here because of the underlying different capabilities
> for resource monitoring and control in different architectures.
> 
> For CAT L3 I picked a direct pass through of the x86 bitmasks, partly
> because I was going first and didn't have to worry about compatability
> with existing implementations, but mostly because there really isn't any
> way to hide the sharp edges of this h/w implementation. It would be much
> easier, and nicer, for users if they could specify a whole list of
> tuneables:
> 
> * minimum viable amount of cache
> * maximum permitted under contention with higher priority processes
> * maximum when system lightly loaded
> 
> and especially not have these limits bound directly to specific cache
> ways. But those aren't the cards that I was dealt.
> 
> So now we appear to be stuck with something that is quite specific to
> the initial x86 implementation, and prevents taking advantage of more
> flexible features on other architectures (or future x86 if Intel does
> something better in the future). Which is why I'd like to make it easy
> to provide options (in ways other than new boot command line or mount
> options togther with crammimg more code into an already somewhat
> cluttered codebase).
> 
> > > But sharing those structures across increasingly different implementations
> > > of the underlying resource is resulting in extra gymnastic efforts to
> > > make all the new uses co-exist with the old. E.g. the domain structure
> > > has elements for every type of resource even though each instance is
> > > linked to just one resource type.
> > 
> > > I had begun this journey with a plan to just allow new features to
> > > hook into the existing resctrl filesystem with a "driver" registration
> > > mechanism:
> > > 
> > > https://lore.kernel.org/all/20230420220636.53527-1-tony.luck@intel.com/
> > > 
> > > But feedback from Reinette that this would be cleaner if drivers created
> > > new resources, rather than adding a patchwork of callback functions with
> > > special case "if (type == DRIVER)" sprinkled around made me look into
> > > a more radical redesign instead of joining in the trend of making the
> > > smallest set of changes to meet my goals.
> > > 
> > > 
> > > Goals:
> > > 1) User interfaces for existing resource control features should be
> > > unchanged.
> > > 
> > > 2) Admin interface should have the same capabilities, but interfaces
> > > may change. E.g. kernel command line and mount options may be replaced
> > > by choosing which resource modules to load.
> > > 
> > > 3) Should be easy to create new modules to handle big differences
> > > between implementations, or to handle model specific features that
> > > may not exist in the same form across multiple CPU generations.
> > 
> > The difficulty is knowing some behaviour is going to be platform specific, its not until
> > the next generation is different that you know there was something wrong with the first.
> > 
> > The difficulty is user-space expecting a resource that turned out to be platform-specific,
> > or was 'enhanced' in a subsequent version and doesn't behave in the same way.
> > 
> > I suspect we need two sets of resources, those that are abstracted to work in a portable
> > way between platforms and architectures - and the wild west.
> > The next trick is moving things between the two!
> 
> This seems to be akin to the perfmon model. There are a small number of
> architectural events and counters. All the rest is a very wild west with
> no guarantees from one model to the next, or even from one core to the
> next inside a hybrid CPU model.
> 
> Side note: Hybrid is already an issue for resctrl. On hybrid cpu models
> that support CAT L2, there are different numbers of ways in the P-core
> L2 cache from the E-core L2 cache. Other asymmetries are already in
> the pipeline.
> 
> > > Initial notes:
> > > 
> > > Core resctrl filesystem functionality will just be:
> > > 
> > > 1) Mount/unmount of filesystem. Architecture hook to allocate monitor
> > > and control IDs for the default group.
> > > 
> > > 2) Creation/removal/rename of control and monitor directories (with
> > > call to architecture specific code to allocate/free the control and monitor
> > > IDs to attach to the directory.
> > > 
> > > 3) Maintaining the "tasks" file with architecture code to update the
> > > control and monitor IDs in the task structure.
> > > 
> > > 4) Maintaining the "cpus" file - similar to "tasks"
> > > 
> > > 5) Context switch code to update h/w with control/monitor IDs.
> > > 
> > > 6) CPU hotplug interface to build and maintain domain list for each
> > > registered resource.
> > > 
> > > 7) Framework for "schemata" file. Calls to resource specific functions
> > > to maintain each line in the file.
> > 
> > > 8) Resource registration interface for modules to add new resources
> > > to the list (and remove them on module unload). Modules may add files
> > > to the info/ hierarchy, and also to each mon_data/ directory and/or
> > > to each control/control_mon directory.
> > 
> > I worry that this can lead to architecture specific schema, then each architecture having
> > a subtly different version. I think it would be good to keep all the user-ABI in one place
> > so it doesn't get re-invented. I agree its hard to know what the next platfrom will look like.
> 
> I'd also like the keep the user visible schema unchanged. But we already
> have different architecture back-end code (x86 has arrays of MSRs on
> each L3/L2 domain for s/w to program the desired bitmasks ... I'm going
> to guess that ARM doen't do that with a WRMSR instruction :-)
> Even between Intel and AMD there are small differences (AMD doesn't
> require each bitmask to consist of a single block of consecutive "1" bits).
> 
> Some future x86 implementation might move away from MSRs (which are a
> pain because of the need for cross processor interrupts to execute the
> WRMSR from a CPU in each domain).
> 
> So the basic CAT L3 modules should continue to provide this legacy
> schemata interface (as best they can).
> 
> But this opens up the possibility for you to provide an alternate module
> that makes MPAM's 'CMAX' visible to knowledgeable users that have a use
> case that would benefit from it.
> 
> > One difference I can't get my head round is how to handle platforms that use relative
> > percentages and fractions - and those that take an absolute MB/s value.
> 
> Percentages were a terrible idea. I'm so, so, sorry. I just did a pass
> through, and that was a mistake. The "mba_MBps" mount option was a
> belated attempt to repair the damge by giving the user an parameter
> that makes more sense ... though the s/w feedback loop can't really
> ever run fast enough. So applications that go through phases of high
> and low memory bandwidth are often out of compliance with the bandwidth
> limits set by the user.
> > 
> > 
> > > 9) Note that the core code starts with an empty list of resources.
> > > System admins must load modules to add support for each resource they
> > > want to use.
> > 
> > I think this just moves the problem to modules. 'CAT' would get duplicated by all
> > architectures. MB is subtly different between them all, but user-space doesn't want to be
> > concerned with the differences.
> 
> The duplicated part is just the piece that parses and validates the user
> input for the CAT line in schemata. I haven't written the code yet, but
> that feels like it will be a small part of the module. If I'm wrong,
> then maybe we'd just make a "lib" directory for the shared functions
> needed by multiple modules.
> 
> > > We'd need a bunch of modules to cover existing x86 functionality. E.g.
> > > an "L3" one for standard L3 cache allocation, an "L3CDP" one to be used
> > > instead of the plain "L3" one for code/data priority mode by creating
> > > a separate resource for each of code & data.
> > 
> > CDP may have system wide side-effects. For MPAM if you enable the emulation of that, then
> > resources that resctrl doesn't believe use CDP have to double-configure and double-count
> > everything.
> 
> I don't know enough about MPAM to fully understand that. On x86 CDP is a
> weird hack that keeps one resource and makes it double up lines in
> schemata, also doubling the staging space in the domain structures
> for the potential updated bitmasks before committing them. It would seem
> cleaner to have separate resources, and a driver that knows that one
> gets the even MSRs in the array while the other gets the odd MSRs.

In the RISC-V CBQRI spec [1], there is the concept of Access Type (AT
field) for capacity or bandwidth resources. The current encoding for the
field has code and data types (similar to CDP), but additional types are
possible in the future. I don't believe resctrl has the ability to apply
the CDP concept to bandwidth so that is a gap for CBQRI.

> 
> > > Logically separate mbm_local, mbm_total, and llc_cache_occupancy modules
> > > (though could combine the mbm ones because they both need a periodic
> > > counter read to avoid wraparound). "MB" for memory bandwidth allocation.
> > 
> > llc_cache_occupancy isn't a counter, but I'd prefer to bundle the others through perf.
> > That already has an interface for discovering and configuring events. I understand it was
> > tried and removed, but I think I've got a handle on making this work.
> 
> perf and llc_occupancy really were a bad match. But there are glitches
> for memory bandwidth monitoring too. You'd really want the memory
> traffic for cache evictions to be added to the counter for the tasks
> that read that data into the cache. But if you do perf style monitoring
> only while the task is running, then all those evictions are going to be
> billed to the "wrong" process. Though perhaps you can handwave and say
> that because a process is causing the evictions by bringing new data
> into the cache, it really is responsible for those evictions.
> 
> > > The "mba_MBps" mount option would be replaced with a module that does
> > > both memory bandwidth allocation and monitoring, with a s/w feedback loop.
> > 
> > Keeping purely software features self contained is a great idea.
> > 
> > 
> > > Peter's workaround for the quirks of AMD monitoring could become a
> > > separate AMD specific module. But minor differences (e.g. contiguous
> > > cache bitmask Intel requirements) could be handled within a module
> > > if desired.
> > > 
> > > Pseudo-locking would be another case to load a different module to
> > > set up pseudo-locking and enforce the cache bitmask rules between resctrl
> > > groups instead of the basic cache allocation one.
> > > 
> > > Core resctrl code could handle overlaps between modules that want to
> > > control the same resource with a "first to load reserves that feature"
> > > policy.
> > 
> > > Are there additional ARM specific architectural requirements that this
> > > approach isn't addressing? Could the core functionality be extended to
> > > make life easier for ARM?
> > 
> > (We've got RISC-V to consider too - hence adding Drew Fustini [0])
> > 
> > My known issues list is:
> > * RMIDs.
> >    These are an independent number space for RDT. For MPAM they are an
> >    extension of the partid/closid space. There is no value that can be
> >    exposed to user-space as num_rmid as it depends on how they will be
> >    used.
> 
> Is the answer to avoid exposing this in the info/ directory and just
> letting the user know they hit the limit when a "mkdir" fails?
> 
> > * Monitors.
> >    RDT has one counter per RMID, they run continuously. MPAM advertises
> >    how many monitors it has, which is very likely to be fewer than we
> >    want. This means MPAM can't expose the free-runing MBM_* counters
> >    via the filesystem. These would need exposing via perf.
> 
> So you don't create the "mon_data" directory. Do you still have
> "mon_groups" to allow user to get subtotal counts for subsets of tasks
> with the same allocation (CLOS) id?
> 
> >  * Bitmaps.
> >    MPAM has some bitmaps, but it has other stuff too. Forcing the bitmaps
> >    to be the user-space interface requires the underlying control to be
> >    capable of isolation. Ideally user-space would set a priority/cost for
> >    each rdtgroup, and indicate whether they should be isolated from other
> >    rdtgroup at the same level.
> 
> Reinette tackled this with the limited set of tools available to
> implement pseudo-locking ... but that's really for a very specific set
> of use cases.  Intel doesn't have a "priority" h/w knob, but I agree it
> would be good to have and expose.
> 
> >  * Memory bandwidth.
> >    For MB resources that control bandwidth, X86 provides user-space with
> >    the cache-id of the cache that implements that bandwidth controls. For
> >    MPAM there is no expectation that this is being done by a cache, it could
> >    equally be a memory controller.
> 
> Intel will have something besides the L3-tied control at some point. In
> fact two very different somethings. Another reason that I want the
> option to pull all these competing controls out into modules and leave
> it to the user to pick which ones to load to meet their application
> requirements.

That is good to hear Intel is moving beyond just L3 bandwidth. Similar
to MPAM, the RISC-V CBQRI spec defines a bandwidth controller interface
that can monitor and allocate, but there is no concerte cache level
defined. It could be a DDR memory controller or an SoC interconnect.

> 
> > 
> > I'd really like to have these solved as part of a cross-architecture user-space ABI. I'm
> > not sure platform-specific modules solve the user-space problem.
> 
> Where architectures can converge on a user interface, we should indeed
> try to do so. But this might be difficult if the companies that produce
> new resource control features want to keep the details under wraps for
> as long as possible.
> 
> So we might see a re-run of "Here's some resctrl code to implement a new
> control feature on Intel" ... and have the user interface set in stone
> before other architectures have time to comment about whether the API is
> flexible enough to handle different h/w implementations.
> 
> > Otherwise MPAM has additional types of control, which could be applied to any kind of
> > resource. The oddest is 'PRI' which is just a priority. I've not yet heard of a system
> > using it, but this could appear at any choke point in the SoC, it may not be on a cache or
> > memory controller.
> 
> Could you handle that in schemata. A line that specifies priority from
> 0..N that translates to adding some field to the tasks in that group
> that gets loaded into h/w during context switch.
> 
> > The 'types of control' and 'resource' distinction may help in places where Intel/AMD take
> > wildly different values to configure the same resource. (*cough* MB)
> 
> MB is the poster child for how NOT to do a resource control.
> 
> > [0] lore.kernel.org/r/20230430-riscv-cbqri-rfc-v2-v2-0-8e3725c4a473@baylibre.com
> 
> A quick glance looks like some of this is s/CLOSID/RCID/ s/RMID/RCID/
> and then load into a CSR instead of an MSR. But that's just the "how
> does s/w tell h/w which controls/counters to use". I'm sure that RISC-V
> will diverge in ways to keep OS implementation interesting.

That 2 patch series linked above is just to add support for the Ssqosid
extension (supervisor mode QoS ID). The extension adds the sqoscfg CSR
(QoS configuration register) which contains RCID (Resource Control ID)
and MCID (Monitoring Counter ID). RCID and MCID are independent of each
other. RCID can be used like CLOSID and MCID can be used like RMID.

The sqoscfg CSR is just the ISA part of the RISC-V QoS solution. The
majority of the functionality is contained in a non-ISA specification
called CBQRI (Capacity and Bandwidth Qos Register Interface). I sent an
RFC [2] back in April to allow an CBQRI capable controller to interface
with resctrl. That RFC series depended on the MPAM snapshot by James [3]
which allows other architectures to interface with the resctrl fs code.

The CBQRI spec tries very hard to be generic enough to allow for a
variety of implementations. The register interface describes two types
of shared resource controllers: a capacity controller and a bandwidth
controller. Both controller interfaces provide the ability to monitor
usage and control allocation, although implementations are free to just
implement monitoring or allocation.

The capacity controller register interface will often be used by cache
controllers but it is also possible for the interface to be used for
other shared resources like a TLB. Resource usage is monitored and
allocated in the form of capacity blocks which have no unit of measure
in the spec. resctrl currently can only support a CBQRI capacity
controller if if it is described in the device tree as L2 or L3 cache.

Similarly, the bandwidth controller register interface supports
monitoring and allocation in the form of bandwidth blocks which have no
unit. A memory controller or interconnect may implement this register
interface. Unfortunately, resctrl assumes that a bandwidth resource is
always L3 cache. For the CBQRI RFC, the example SoC had 3 memory
controllers which implement the CBQRI bandwidth interface. The only way
that I could find to represent this in resctrl was to create a "fake" MB
domain for each memory controller.

Thanks,
Drew

[1] https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
[2] https://lore.kernel.org/linux-riscv/20230419111111.477118-1-dfustini@baylibre.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/v6.3
