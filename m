Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E44D7217A9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 16:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjFDO2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 10:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFDO2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 10:28:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66B8B6;
        Sun,  4 Jun 2023 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685888879; x=1717424879;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q+r4L7YKHO4A+c4ToLOo+OnQVFVuiFm9JBkNTxDqa4M=;
  b=VOvvWcRsesdWWbC3s4BNr70Tq6ClYyQVoKNwcYmLNOs9pxRCKZnPWDOI
   VCwK+13XdwuD4YW4DAOluUd5RSFqaNL8O9VwI/Zgysq9Qctym4+HorVYN
   a/s72+UWcZ4Vdc1dXuLduDa6hI2IHZKtJlL0pSQLSVU12CLLbTKPgoZK1
   f03YLNBh2bHvAz9/wNx01JE+u24D/Zt2kd1EhcV95Iqujk/RQ1+bDw2RE
   3j3kWMsmD5eI0L5obUJYlKWn4lCcViLaKwhk4GFks0/k4ut7kcWB+8eq7
   MYjR3JNYElQjLXdTttp4l9bKnrzsVdREfVdBZa7ZlPU38c0VLDBNRkH8P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="353683380"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="353683380"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 07:27:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="1038500979"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="1038500979"
Received: from tdhastx-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.50.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 07:27:54 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     linux-mm@kvack.org, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com, tony.luck@intel.com,
        peterz@infradead.org, tglx@linutronix.de, seanjc@google.com,
        pbonzini@redhat.com, david@redhat.com, dan.j.williams@intel.com,
        rafael.j.wysocki@intel.com, ying.huang@intel.com,
        reinette.chatre@intel.com, len.brown@intel.com, ak@linux.intel.com,
        isaku.yamahata@intel.com, chao.gao@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, bagasdotme@gmail.com,
        sagis@google.com, imammedo@redhat.com, kai.huang@intel.com
Subject: [PATCH v11 00/20] TDX host kernel support
Date:   Mon,  5 Jun 2023 02:27:13 +1200
Message-Id: <cover.1685887183.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Trusted Domain Extensions (TDX) protects guest VMs from malicious
host and certain physical attacks.  TDX specs are available in [1].

This series is the initial support to enable TDX with minimal code to
allow KVM to create and run TDX guests.  KVM support for TDX is being
developed separately[2].  A new "userspace inaccessible memfd" approach
to support TDX private memory is also being developed[3].  The KVM will
only support the new "userspace inaccessible memfd" as TDX guest memory.

This series doesn't aim to support all functionalities, and doesn't aim
to resolve all things perfectly.  All other optimizations will be posted
as follow-up once this initial TDX support is upstreamed.

Also, the patch to add the new kernel comline tdx="force" isn't included
in this initial version, as Dave suggested it isn't mandatory.  But I
will add one once this initial version gets merged.

(For memory hotplug, sorry for broadcasting widely but I cc'ed the
linux-mm@kvack.org following Kirill's suggestion so MM experts can also
help to provide comments.)

Hi Dave, Kirill, Tony, Peter, Thomas, Dan (and Intel reviewers),

The new relaxed TDX per-cpu initialization flow has been verified.  The
TDX module can be initialized when there are offline cpus, and the
TDH.SYS.LP.INIT SEAMCALL can be made successfully later after module
initialization when the offline cpu is up.

This series mainly added code to handle the new TDX "partial write
machine check" erratum (SPR113) in [4].

And I would appreciate reviewed-by or acked-by tags if the patches look
good to you.  Thanks in advance!

----- Changelog history: ------

- v10 -> v11:

 - Addressed comments in v10
 - Added patches to handle TDX "partial write machine check" erratum.
 - Added a new patch to handle running out of entropy in common code.
 - Fixed a bug in kexec() support.

 v10: https://lore.kernel.org/kvm/cover.1678111292.git.kai.huang@intel.com/

- v9 -> v10:

 - Changed the per-cpu initalization handling
   - Gave up "ensuring all online cpus are TDX-runnable when TDX module
     is initialized", but just provide two basic functions, tdx_enable()
     and tdx_cpu_enable(), to let the user of TDX to make sure the
     tdx_cpu_enable() has been done successfully when the user wants to
     use particular cpu for TDX.
   - Thus, moved per-cpu initialization out of tdx_enable().  Now
     tdx_enable() just assumes VMXON and tdx_cpu_enable() has been done
     on all online cpus before calling it.
   - Merged the tdx_enable() skeleton patch and per-cpu initialization
     patch together to tell better story.
   - Moved "SEAMCALL infrastructure" patch before the tdx_enable() patch.

 v9: https://lore.kernel.org/lkml/cover.1676286526.git.kai.huang@intel.com/

- v8 -> v9:

 - Added patches to handle TDH.SYS.INIT and TDH.SYS.LP.INIT back.
 - Other changes please refer to changelog histroy in individual patches.

 v8: https://lore.kernel.org/lkml/cover.1670566861.git.kai.huang@intel.com/

- v7 -> v8:

 - 200+ LOC removed (from 1800+ -> 1600+).
 - Removed patches to do TDH.SYS.INIT and TDH.SYS.LP.INIT
   (Dave/Peter/Thomas).
 - Removed patch to shut down TDX module (Sean).
 - For memory hotplug, changed to reject non-TDX memory from
   arch_add_memory() to memory_notifier (Dan/David).
 - Simplified the "skeletion patch" as a result of removing
   TDH.SYS.LP.INIT patch.
 - Refined changelog/comments for most of the patches (to tell better
   story, remove silly comments, etc) (Dave).
 - Added new 'struct tdmr_info_list' struct, and changed all TDMR related
   patches to use it (Dave).
 - Effectively merged patch "Reserve TDX module global KeyID" and
   "Configure TDX module with TDMRs and global KeyID", and removed the
   static variable 'tdx_global_keyid', following Dave's suggestion on
   making tdx_sysinfo local variable.
 - For detailed changes please see individual patch changelog history.

 v7: https://lore.kernel.org/lkml/529a22d05e21b9218dc3f29c17ac5a176334cac1.camel@intel.com/T/

- v6 -> v7:
  - Added memory hotplug support.
  - Changed how to choose the list of "TDX-usable" memory regions from at
    kernel boot time to TDX module initialization time.
  - Addressed comments received in previous versions. (Andi/Dave).
  - Improved the commit message and the comments of kexec() support patch,
    and the patch handles returnning PAMTs back to the kernel when TDX
    module initialization fails. Please also see "kexec()" section below.
  - Changed the documentation patch accordingly.
  - For all others please see individual patch changelog history.

 v6: https://lore.kernel.org/lkml/529a22d05e21b9218dc3f29c17ac5a176334cac1.camel@intel.com/T/

- v5 -> v6:

  - Removed ACPI CPU/memory hotplug patches. (Intel internal discussion)
  - Removed patch to disable driver-managed memory hotplug (Intel
    internal discussion).
  - Added one patch to introduce enum type for TDX supported page size
    level to replace the hard-coded values in TDX guest code (Dave).
  - Added one patch to make TDX depends on X2APIC being enabled (Dave).
  - Added one patch to build all boot-time present memory regions as TDX
    memory during kernel boot.
  - Added Reviewed-by from others to some patches.
  - For all others please see individual patch changelog history.

 v5: https://lore.kernel.org/lkml/529a22d05e21b9218dc3f29c17ac5a176334cac1.camel@intel.com/T/

- v4 -> v5:

  This is essentially a resent of v4.  Sorry I forgot to consult
  get_maintainer.pl when sending out v4, so I forgot to add linux-acpi
  and linux-mm mailing list and the relevant people for 4 new patches.

  There are also very minor code and commit message update from v4:

  - Rebased to latest tip/x86/tdx.
  - Fixed a checkpatch issue that I missed in v4.
  - Removed an obsoleted comment that I missed in patch 6.
  - Very minor update to the commit message of patch 12.

  For other changes to individual patches since v3, please refer to the
  changelog histroy of individual patches (I just used v3 -> v5 since
  there's basically no code change to v4).

 v4: https://lore.kernel.org/lkml/98c84c31d8f062a0b50a69ef4d3188bc259f2af2.1654025431.git.kai.huang@intel.com/T/

- v3 -> v4 (addressed Dave's comments, and other comments from others):

 - Simplified SEAMRR and TDX keyID detection.
 - Added patches to handle ACPI CPU hotplug.
 - Added patches to handle ACPI memory hotplug and driver managed memory
   hotplug.
 - Removed tdx_detect() but only use single tdx_init().
 - Removed detecting TDX module via P-SEAMLDR.
 - Changed from using e820 to using memblock to convert system RAM to TDX
   memory.
 - Excluded legacy PMEM from TDX memory.
 - Removed the boot-time command line to disable TDX patch.
 - Addressed comments for other individual patches (please see individual
   patches).
 - Improved the documentation patch based on the new implementation.

 v3: https://lore.kernel.org/lkml/529a22d05e21b9218dc3f29c17ac5a176334cac1.camel@intel.com/T/

- V2 -> v3:

 - Addressed comments from Isaku.
  - Fixed memory leak and unnecessary function argument in the patch to
    configure the key for the global keyid (patch 17).
  - Enhanced a little bit to the patch to get TDX module and CMR
    information (patch 09).
  - Fixed an unintended change in the patch to allocate PAMT (patch 13).
 - Addressed comments from Kevin:
  - Slightly improvement on commit message to patch 03.
 - Removed WARN_ON_ONCE() in the check of cpus_booted_once_mask in
   seamrr_enabled() (patch 04).
 - Changed documentation patch to add TDX host kernel support materials
   to Documentation/x86/tdx.rst together with TDX guest staff, instead
   of a standalone file (patch 21)
 - Very minor improvement in commit messages.

 v2: https://lore.kernel.org/lkml/529a22d05e21b9218dc3f29c17ac5a176334cac1.camel@intel.com/T/

- RFC (v1) -> v2:
  - Rebased to Kirill's latest TDX guest code.
  - Fixed two issues that are related to finding all RAM memory regions
    based on e820.
  - Minor improvement on comments and commit messages.

 v1: https://lore.kernel.org/lkml/529a22d05e21b9218dc3f29c17ac5a176334cac1.camel@intel.com/T/

== Background ==

TDX introduces a new CPU mode called Secure Arbitration Mode (SEAM)
and a new isolated range pointed by the SEAM Ranger Register (SEAMRR).
A CPU-attested software module called 'the TDX module' runs in the new
isolated region as a trusted hypervisor to create/run protected VMs.

TDX also leverages Intel Multi-Key Total Memory Encryption (MKTME) to
provide crypto-protection to the VMs.  TDX reserves part of MKTME KeyIDs
as TDX private KeyIDs, which are only accessible within the SEAM mode.

TDX is different from AMD SEV/SEV-ES/SEV-SNP, which uses a dedicated
secure processor to provide crypto-protection.  The firmware runs on the
secure processor acts a similar role as the TDX module.

The host kernel communicates with SEAM software via a new SEAMCALL
instruction.  This is conceptually similar to a guest->host hypercall,
except it is made from the host to SEAM software instead.

Before being able to manage TD guests, the TDX module must be loaded
and properly initialized.  This series assumes the TDX module is loaded
by BIOS before the kernel boots.

How to initialize the TDX module is described at TDX module 1.0
specification, chapter "13.Intel TDX Module Lifecycle: Enumeration,
Initialization and Shutdown".

== Design Considerations ==

1. Initialize the TDX module at runtime

There are basically two ways the TDX module could be initialized: either
in early boot, or at runtime before the first TDX guest is run.  This
series implements the runtime initialization.

Also, TDX requires a per-cpu initialization SEAMCALL to be done before
making any SEAMCALL on that cpu.

This series adds two functions: tdx_cpu_enable() and tdx_enable() to do
per-cpu initialization and module initialization respectively.

2. CPU hotplug

DX doesn't support physical (ACPI) CPU hotplug.  A non-buggy BIOS should
never support hotpluggable CPU devicee and/or deliver ACPI CPU hotplug
event to the kernel.  This series doesn't handle physical (ACPI) CPU
hotplug at all but depends on the BIOS to behave correctly.

Also, tdx_cpu_enable() will simply return error for any hot-added cpu if
something insane happened.

Note TDX works with CPU logical online/offline, thus this series still
allows to do logical CPU online/offline.

3. Kernel policy on TDX memory

The TDX module reports a list of "Convertible Memory Region" (CMR) to
indicate which memory regions are TDX-capable.  The TDX architecture
allows the VMM to designate specific convertible memory regions as usable
for TDX private memory.

The initial support of TDX guests will only allocate TDX private memory
from the global page allocator.  This series chooses to designate _all_
system RAM in the core-mm at the time of initializing TDX module as TDX
memory to guarantee all pages in the page allocator are TDX pages.

4. Memory Hotplug

After the kernel passes all "TDX-usable" memory regions to the TDX
module, the set of "TDX-usable" memory regions are fixed during module's
runtime.  No more "TDX-usable" memory can be added to the TDX module
after that.

To achieve above "to guarantee all pages in the page allocator are TDX
pages", this series simply choose to reject any non-TDX-usable memory in
memory hotplug.

5. Physical Memory Hotplug

Note TDX assumes convertible memory is always physically present during
machine's runtime.  A non-buggy BIOS should never support hot-removal of
any convertible memory.  This implementation doesn't handle ACPI memory
removal but depends on the BIOS to behave correctly.

Also, if something insane really happened, 4) makes sure either TDX
cannot be enabled or hot-added memory will be rejected after TDX gets
enabled.

6. Kexec()

Similar to AMD's SME, in kexec() kernel needs to flush dirty cachelines
of TDX private memory otherwise they may silently corrupt the new kernel.

7. TDX erratum

The first few generations of TDX hardware have an erratum.  A partial
write to a TDX private memory cacheline will silently "poison" the
line.  Subsequent reads will consume the poison and generate a machine
check.

The fast warm reset reboot doesn't reset TDX private memory.  With this
erratum, all TDX private pages needs to be converted back to normal
before a fast warm reset reboot or booting to the new kernel in kexec().
Otherwise, the new kernel may get unexpected machine check.

In normal condition, triggering the erratum in Linux requires some kind
of kernel bug involving relatively exotic memory writes to TDX private
memory and will manifest via spurious-looking machine checks when
reading the affected memory.  Machine check handler is improved to deal
with such machine check.


[1]: TDX specs
https://software.intel.com/content/www/us/en/develop/articles/intel-trust-domain-extensions.html

[2]: KVM TDX basic feature support
https://lore.kernel.org/kvm/cover.1685333727.git.isaku.yamahata@intel.com/T/#t

[3]: KVM: mm: fd-based approach for supporting KVM
https://lore.kernel.org/kvm/20221202061347.1070246-1-chao.p.peng@linux.intel.com/

[4]: TDX erratum
https://cdrdv2.intel.com/v1/dl/getContent/772415?explicitVersion=true



Kai Huang (20):
  x86/tdx: Define TDX supported page sizes as macros
  x86/virt/tdx: Detect TDX during kernel boot
  x86/virt/tdx: Make INTEL_TDX_HOST depend on X86_X2APIC
  x86/cpu: Detect TDX partial write machine check erratum
  x86/virt/tdx: Add SEAMCALL infrastructure
  x86/virt/tdx: Handle SEAMCALL running out of entropy error
  x86/virt/tdx: Add skeleton to enable TDX on demand
  x86/virt/tdx: Get information about TDX module and TDX-capable memory
  x86/virt/tdx: Use all system memory when initializing TDX module as
    TDX memory
  x86/virt/tdx: Add placeholder to construct TDMRs to cover all TDX
    memory regions
  x86/virt/tdx: Fill out TDMRs to cover all TDX memory regions
  x86/virt/tdx: Allocate and set up PAMTs for TDMRs
  x86/virt/tdx: Designate reserved areas for all TDMRs
  x86/virt/tdx: Configure TDX module with the TDMRs and global KeyID
  x86/virt/tdx: Configure global KeyID on all packages
  x86/virt/tdx: Initialize all TDMRs
  x86/kexec: Flush cache of TDX private memory
  x86: Handle TDX erratum to reset TDX private memory during kexec() and
    reboot
  x86/mce: Improve error log of kernel space TDX #MC due to erratum
  Documentation/x86: Add documentation for TDX host support

 Documentation/arch/x86/tdx.rst     |  186 +++-
 arch/x86/Kconfig                   |   15 +
 arch/x86/Makefile                  |    2 +
 arch/x86/coco/tdx/tdx.c            |    6 +-
 arch/x86/include/asm/cpufeatures.h |    1 +
 arch/x86/include/asm/msr-index.h   |    3 +
 arch/x86/include/asm/tdx.h         |   23 +
 arch/x86/include/asm/x86_init.h    |    1 +
 arch/x86/kernel/cpu/intel.c        |   21 +
 arch/x86/kernel/cpu/mce/core.c     |   33 +
 arch/x86/kernel/process.c          |    7 +-
 arch/x86/kernel/reboot.c           |   16 +
 arch/x86/kernel/setup.c            |    2 +
 arch/x86/kernel/x86_init.c         |    2 +
 arch/x86/virt/Makefile             |    2 +
 arch/x86/virt/vmx/Makefile         |    2 +
 arch/x86/virt/vmx/tdx/Makefile     |    2 +
 arch/x86/virt/vmx/tdx/seamcall.S   |   52 +
 arch/x86/virt/vmx/tdx/tdx.c        | 1526 ++++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h        |  161 +++
 arch/x86/virt/vmx/tdx/tdxcall.S    |   19 +-
 21 files changed, 2065 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/virt/Makefile
 create mode 100644 arch/x86/virt/vmx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/seamcall.S
 create mode 100644 arch/x86/virt/vmx/tdx/tdx.c
 create mode 100644 arch/x86/virt/vmx/tdx/tdx.h


base-commit: 122333d6bd229af279cdb35d1b874b71b3b9ccfb
-- 
2.40.1

