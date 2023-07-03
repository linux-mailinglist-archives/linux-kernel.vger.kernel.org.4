Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9240E745454
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGCDze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGCDzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:55:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF60C12A;
        Sun,  2 Jul 2023 20:55:29 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QvX6z6JCPz67ydC;
        Mon,  3 Jul 2023 11:52:11 +0800 (CST)
Received: from localhost (10.34.206.101) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 3 Jul
 2023 04:55:24 +0100
Date:   Mon, 3 Jul 2023 11:55:20 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Terry Bowman <terry.bowman@amd.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v7 16/27] cxl/pci: Store the endpoint's Component
 Register mappings in struct cxl_dev_state
Message-ID: <20230703115520.00000fd8@Huawei.com>
In-Reply-To: <ZJ8zfDmw+xFvSN1G@rric.localdomain>
References: <20230622205523.85375-1-terry.bowman@amd.com>
        <20230622205523.85375-17-terry.bowman@amd.com>
        <64987b92ce13c_2ed7294f4@dwillia2-xfh.jf.intel.com.notmuch>
        <ZJ8zfDmw+xFvSN1G@rric.localdomain>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.206.101]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 21:56:44 +0200
Robert Richter <rrichter@amd.com> wrote:

> (resending without logs attached to make vger.kernel.org happy)
> 
> Dan, Jonathan,
> 
> On 25.06.23 10:38:26, Dan Williams wrote:
> > Terry Bowman wrote:  
> > > From: Robert Richter <rrichter@amd.com>
> > > 
> > > Same as for ports and dports, also store the endpoint's Component
> > > Register mappings, use struct cxl_dev_state for that.
> > > 
> > > The Component Register base address @component_reg_phys is no longer
> > > used after the rework of the Component Register setup which now uses
> > > struct member @comp_map instead. Remove the base address.
> > > 
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> I could fix the HDM initialization failure. The check in "cxl/hdm: Use
> stored Component Register mappings to map HDM decoder capability" was
> too strict and did not return -ENODEV as the previous implementation.
> 
> We will send an updated version of the remaining patches.
> 
> However, while analyzing this I found the following:
> 
> > 
> > Starting with this patch my QEMU cxl configuration fails to probe the
> > device:
> > 
> > # cxl list -Miu
> > {
> >   "memdev":"mem0",
> >   "pmem_size":"512.00 MiB (536.87 MB)",
> >   "serial":"0",
> >   "host":"0000:35:00.0",
> >   "state":"disabled"
> > }  
> 
> I have looked into this and it looks to me that the qemu model is
> wrong. I am referring esp. to those sections in the CXL 3.0 spec (Aug
> 1, 2022):

Indeed looks dodgy.  Ira recently highlighted that this was a mess
and proposed some fixes.. (going way back, I moaned about the way this
was being done being inflexible to Ben but we never cleaned it up :(
https://lore.kernel.org/linux-cxl/20230517-rfc-type2-dev-v1-2-6eb2e470981b@intel.com/

We should change that function to explicitly handle ever device type
rather than trying to shortcut certain shared combinations.

> 
>  Figure 9-14. CXL Link/Protocol Register Mapping in a CXL VH
>  Figure 9-15. CXL Link/Protocol Registers in a CXL Switch
>  Table 8-22. CXL_Capability_ID Assignment
> 
> In short, the CXL capabilities are wrongly assigned to the various
> component registers (component abbr. taken from Table 8-22):
> 
> ACPI CHBCR (RC): 
>  * includes RAS cap, misses HDM cap
>  * expected: no RAS cap, includes HDM cap

To check, do you have multiple RP under the RC? From info below
I see you only have 1.  You can override by providing pxb-cxl
with hdm_for_passthrough=true

If not default is a pass through decoder so no HDM cap should be
present (they kernel used to assume that - so we changed default in
QEMU to match - I think the kernel is now fine either way)

QEMU code indeed looks dodgy as it's initializing the host bridge
as if it were a root port. (oops) and as you've noticed then
adds HDM decoders to the RP which also makes no sense (but are
ignored).

I've just hacked in use of null capability (which was only defined
in CXL3.0 but is fine for old devices) so that we can screen
out the things that shouldn't be there by skipping initializing them.
Also added an enum entry for CXL2_RC so we can handle that one
correctly rather than combining it with CXL2_ROOT_PORT (that predates
me so no idea why it was like that).



> 
> RAS cap does not make sense here and is unused.
> 
> logs:
> 
> > [  468.239319] cxl port1: found RAS capability (0x80)
> > [  468.240186] cxl port1: Unknown CM cap ID: 4 (0xd8)
> > [  468.241083] cxl port1: Unknown CM cap ID: 0 (0x110)
> > [  468.241974] cxl port1: Unknown CM cap ID: 6 (0x260)
> > [  468.242876] cxl port1: Unknown CM cap ID: 8 (0xa84)  
> 
> CXL root port (R):
>  * includes RAS and HDM cap
>  * expected: includes RAS cap, misses HDM cap
> 
> This causes the HDM for the root ports being not properly initialized,
> kernel switching to fallback mode.

This confuses me a bit.  Why is it trying to initialize something
that shouldn't be there in the root ports? (which whilst a bug 'might'
occur on real hardware if that was also buggy ;)

> 
> logs:
> 
> > [  468.250182] pcieport 0000:34:00.0: Mapped CXL Memory Device resource 0x00000000fea00000
> > [  468.250258] pcieport 0000:34:00.0: found RAS capability (0x80)
> > [  468.250371] pcieport 0000:34:00.0: Unknown CM cap ID: 4 (0xd8)
> > [  468.250413] pcieport 0000:34:00.0: found HDM decoder capability (0x110)
> > [  468.256022] pcieport 0000:34:00.0: Unknown CM cap ID: 6 (0x260)
> > [  468.256058] pcieport 0000:34:00.0: Unknown CM cap ID: 8 (0xa84)  
> 
> CXL 2.0 device (D2)
>  * includes RAS and HDM cap
>  * works as expected
> 
> logs:
> 
> > [ 1396.813184] cxl_pci 0000:35:00.0: found RAS capability (0x80)
> > [ 1396.814133] cxl_pci 0000:35:00.0: Unknown CM cap ID: 4 (0xd8)
> > [ 1396.815081] cxl_pci 0000:35:00.0: found HDM decoder capability (0x110)  
> 
> No issues here.
> 
> Details below.
> 
> Kernel:
> 
> version: 0c0df63177e3 Merge branch 'for-6.5/cxl-rch-eh' into for-6.5/cxl
> cmdline: 
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.4.0-rc6-rric-00055-g0c0df63177e3 root=UUID=8b447531-798d-41cb-a3df-ae1d9bb1eaf9 ro debug ignore_loglevel "dyndbg=file drivers/cxl/* +p" systemd.log_target=journal
> 
> Qemu:
> 
> version: QEMU emulator version 8.0.50 (v6.2.0-12087-g62c0c95799)
> cmdline:
> /usr/local/bin/qemu-system-x86_64 -smp 6 -machine type=q35,accel=kvm,nvdimm=on,cxl=on -hda debian.img -m 4096 -enable-kvm -object memory-backend-file,id=cxl-mem1,share=on,mem-path=cxl-window1,size=512M -object memory-backend-file,id=cxl-label1,share=on,mem-path=cxl-label1,size=512M -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 -device cxl-rp,id=rp0,bus=cxl.0,addr=0.0,chassis=0,slot=0,port=0 -device cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,lsa=cxl-label1 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G -vnc :0 -nic none
> 
> Annotated qemu kernel boot log after loading the cxl_acpi module
> (including deps):
> 
> > [  468.229977] cxl_acpi ACPI0017:00: root0 added (root port)  
> 
> root0 added.
> 
> > [  468.231055] acpi ACPI0016:00: UID found: 52
> > [  468.231959]  pci0000:34: dport added to root0  
> 
> add_host_bridge_dport() found the CXL host bridge and added it as
> dport to root0..
> 
> > [  468.232867] Unknown target node for memory at 0x190000000, assuming node 0
> > [  468.233901] cxl_acpi ACPI0017:00: add: decoder0.0 node: 0 range [0x190000000 - 0x28fffffff]
> > [  468.235394] acpi ACPI0016:00: UID found: 52
> > [  468.236171] acpi ACPI0016:00: CHBCR found for UID 52: 0x0000000180000000
> > [  468.237193]  pci0000:34: host-bridge: pci0000:34
> > [  468.238132] cxl port1: Mapped CXL Memory Device resource 0x0000000180000000  
> 
> CHBCR for the host bridge was found at 0x0000000180000000.
> 
> In this kernel version it is bound to port1 (not the dport), some
> comments on this later.
> 
> Component registers and capabilities are extracted from the CHBCR:
> 
> > [  468.239319] cxl port1: found RAS capability (0x80)
> > [  468.240186] cxl port1: Unknown CM cap ID: 4 (0xd8)
> > [  468.241083] cxl port1: Unknown CM cap ID: 0 (0x110)
> > [  468.241974] cxl port1: Unknown CM cap ID: 6 (0x260)
> > [  468.242876] cxl port1: Unknown CM cap ID: 8 (0xa84)  
> 
> The CHBCR does not contain the HDM registers for the root ports.
> 
> It (wrongly) contains the RAS caps.
> 
> I would expect HDM here instead.

As above. No on HDM but agreed RAS is 'novel' and should go away.
In a root bridge with just one RP the HDM is optional.

> 
> > [  468.243767] cxl port1: Set up component registers
> > [  468.244959]  pci0000:34: port1 added to root0  
> 
> port1 added to root0 with the component regs from the CHBCR bound.

I think that's reasonable as the port1 is the Host bridge in this case.

> 
> > [  468.245807]  pci0000:34: host supports CXL
> > [  468.246711] cxl_acpi ACPI0017:00: root0: add: nvdimm-bridge0
> > [  468.247792] CXL bus rescan result: 0  
> 
> port 1 added to the cxl bus which triggers cxl_port_probe:
> 
> Running cxl_switch_port_probe() for port1 here:
> 
> > [  468.250149] pcieport 0000:34:00.0: Component Registers found for dport: 0x00000000fea00000  
> 
> The CXL root port was found by devm_cxl_port_enumerate_dports().
> 
> Its component regs are extracted:
> 
> > [  468.250182] pcieport 0000:34:00.0: Mapped CXL Memory Device resource 0x00000000fea00000
> > [  468.250258] pcieport 0000:34:00.0: found RAS capability (0x80)
> > [  468.250371] pcieport 0000:34:00.0: Unknown CM cap ID: 4 (0xd8)
> > [  468.250413] pcieport 0000:34:00.0: found HDM decoder capability (0x110)
> > [  468.256022] pcieport 0000:34:00.0: Unknown CM cap ID: 6 (0x260)
> > [  468.256058] pcieport 0000:34:00.0: Unknown CM cap ID: 8 (0xa84)  
> 
> The CXL root port's comp regs contain the RAS caps but also (wrongly)
> the HDM caps.

Agreed - that's garbage though kernel should probably just moan about it.

> 
> > [  468.256065] pcieport 0000:34:00.0: Set up component registers
> > [  468.256089] pcieport 0000:34:00.0: dport added to port1  
> 
> CXL root port added as dport to port1.
> 
> devm_cxl_setup_hdm() is run for port1:
> 
> > [  468.256157] cxl_port port1: found RAS capability (0x80)
> > [  468.260800] cxl_port port1: Unknown CM cap ID: 4 (0xd8)
> > [  468.260833] cxl_port port1: Unknown CM cap ID: 0 (0x110)
> > [  468.260865] cxl_port port1: Unknown CM cap ID: 6 (0x260)
> > [  468.260898] cxl_port port1: Unknown CM cap ID: 8 (0xa84)  
> 
> port1's comp regs from above extracted again for HDM setup, but...
> 
> > [  468.260904] cxl_port port1: HDM decoder registers not implemented  
> 
> ... the HDM decoder could not be found. map_hdm_decoder_regs() returns
> a -ENODEV.
> 
> > [  468.260915] cxl_port port1: Fallback to passthrough decoder  
> 
> cxl_switch_port_probe() continues with
> devm_cxl_add_passthrough_decoder() as there was only one dport found.

That's what I'd expect for the RC.

> 
> > [  468.261024] cxl decoder1.0: Added to port port1
> > [  468.267186] cxl_port port1: probe: 0  
> 
> Probe success.
> 
> > [  468.298485] nd_bus ndbus0: START: nd_bus.probe(ndbus0)
> > [  468.299859] nd_bus ndbus0: END: nd_bus.probe(ndbus0) = 0
> > [  468.300840] cxl_nvdimm_bridge nvdimm-bridge0: probe: 0  
> 
> End of log. Full log attached.
> 
> Loading the cxl_pci driver later succeeds, cxl list shows:
> 
> [
>   {
>     "memdev":"mem0",
>     "pmem_size":536870912,
>     "serial":0,
>     "host":"0000:35:00.0"
>   }
> ]
> 
> I am not sure if the issue is a qemu config or implementation issue.
> 
> Please take a look. Am I missing something here?

The RAS registers case is definitely a bug (and I expect there are similar
cases) so we should fix that in QEMU, but impact should be small (some
warnings at most) if we are providing registers the kernel doesn't
recognize.  In theory the spec could change in future to make them defined
for additional CXL components (unlikely though!)

Jonathan


> 
> Thanks,
> 
> -Robert

