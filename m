Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC7F6ED610
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjDXUVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjDXUVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:21:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D863526F;
        Mon, 24 Apr 2023 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=65AHpviua5cspHXN5+iQ7arJ3Iu9QRuAPcxUdo8YjaQ=; b=OB1jocotLkX6mdh7yD0gwYsrmK
        xJygD2xJNUiokfqB6k139YuEliHtxQwedqVfn+l5BW+aD4hrHo34nQhMq+pW6UonuFM7UchZcFzmR
        fsPD2xZbJSv0M6L6SyHwrVJvSYCb/PgT6yVZl0Zj3BhJ6YHBFEilZfpN4l59FFGhpbBwB1rhsGmRM
        wJFjEipk+3Yvf3nVUqAmviD87Kq5IbMc8oht3KFD3aLkWvFpGVjnLQJREFtS19zVkd+8x+WW1ktXH
        UsO/eO12c7kag3cnVq/MS5hW6klG6ZJcG5kJpOb12wtxkMdhB2JlwB4VPjdQcFH47p3f9CTXpBdUh
        Lqpkq8mw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pr2gE-00H892-1e;
        Mon, 24 Apr 2023 20:20:58 +0000
Date:   Mon, 24 Apr 2023 13:20:58 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     arnd@arndb.de, bagasdotme@gmail.com, fmdefrancesco@gmail.com,
        jbaron@akamai.com, jiapeng.chong@linux.alibaba.com,
        jim.cromie@gmail.com, linux@weissschuh.net, mcgrof@kernel.org,
        nick.alcock@oracle.com, peterz@infradead.org, p.raghav@samsung.com,
        rdunlap@infradead.org, song@kernel.org, thunder.leizhen@huawei.com,
        trix@redhat.com, yangtiezhu@loongson.cn, jpoimboe@kernel.org,
        joe.lawrence@redhat.com, tglx@linutronix.de,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] modules changes for v6.4-rc1
Message-ID: <ZEbkqq1tvm1WHVHw@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.4-rc1

for you to fetch changes up to 8660484ed1cf3261e89e0bad94c6395597e87599:

  module: add debugging auto-load duplicate module support (2023-04-19 17:26:01 -0700)

----------------------------------------------------------------
modules-6.4-rc1

The summary of the changes for this pull requests is:

 * Song Liu's new struct module_memory replacement
 * Nick Alcock's MODULE_LICENSE() removal for non-modules
 * My cleanups and enhancements to reduce the areas where we vmalloc
   module memory for duplicates, and the respective debug code which
   proves the remaining vmalloc pressure comes from userspace.

Most of the changes have been in linux-next for quite some time except
the minor fixes I made to check if a module was already loaded
prior to allocating the final module memory with vmalloc and the
respective debug code it introduces to help clarify the issue. Although
the functional change is small it is rather safe as it can only *help*
reduce vmalloc space for duplicates and is confirmed to fix a bootup
issue with over 400 CPUs with KASAN enabled. I don't expect stable
kernels to pick up that fix as the cleanups would have also had to have
been picked up. Folks on larger CPU systems with modules will want to
just upgrade if vmalloc space has been an issue on bootup.

Given the size of this request, here's some more elaborate details
on this pull request.

The functional change change in this pull request is the very first
patch from Song Liu which replaces the struct module_layout with a new
struct module memory. The old data structure tried to put together all
types of supported module memory types in one data structure, the new
one abstracts the differences in memory types in a module to allow each
one to provide their own set of details. This paves the way in the
future so we can deal with them in a cleaner way. If you look at changes
they also provide a nice cleanup of how we handle these different memory
areas in a module. This change has been in linux-next since before the
merge window opened for v6.3 so to provide more than a full kernel cycle
of testing. It's a good thing as quite a bit of fixes have been found
for it.

Jason Baron then made dynamic debug a first class citizen module user by
using module notifier callbacks to allocate / remove module specific
dynamic debug information.

Nick Alcock has done quite a bit of work cross-tree to remove module
license tags from things which cannot possibly be module at my request
so to:

  a) help him with his longer term tooling goals which require a
     deterministic evaluation if a piece a symbol code could ever be
     part of a module or not. But quite recently it is has been made
     clear that tooling is not the only one that would benefit.
     Disambiguating symbols also helps efforts such as live patching,
     kprobes and BPF, but for other reasons and R&D on this area
     is active with no clear solution in sight.

  b) help us inch closer to the now generally accepted long term goal
     of automating all the MODULE_LICENSE() tags from SPDX license tags

In so far as a) is concerned, although module license tags are a no-op
for non-modules, tools which would want create a mapping of possible
modules can only rely on the module license tag after the commit
8b41fc4454e ("kbuild: create modules.builtin without Makefile.modbuiltin
or tristate.conf").  Nick has been working on this *for years* and
AFAICT I was the only one to suggest two alternatives to this approach
for tooling. The complexity in one of my suggested approaches lies in
that we'd need a possible-obj-m and a could-be-module which would check
if the object being built is part of any kconfig build which could ever
lead to it being part of a module, and if so define a new define
-DPOSSIBLE_MODULE [0]. A more obvious yet theoretical approach I've
suggested would be to have a tristate in kconfig imply the same new
-DPOSSIBLE_MODULE as well but that means getting kconfig symbol names
mapping to modules always, and I don't think that's the case today. I am
not aware of Nick or anyone exploring either of these options. Quite
recently Josh Poimboeuf has pointed out that live patching, kprobes and
BPF would benefit from resolving some part of the disambiguation as
well but for other reasons. The function granularity KASLR (fgkaslr)
patches were mentioned but Joe Lawrence has clarified this effort has
been dropped with no clear solution in sight [1].

In the meantime removing module license tags from code which could never
be modules is welcomed for both objectives mentioned above. Some
developers have also welcomed these changes as it has helped clarify
when a module was never possible and they forgot to clean this up,
and so you'll see quite a bit of Nick's patches in other pull
requests for this merge window. I just picked up the stragglers after
rc3. LWN has good coverage on the motivation behind this work [2] and
the typical cross-tree issues he ran into along the way. The only
concrete blocker issue he ran into was that we should not remove the
MODULE_LICENSE() tags from files which have no SPDX tags yet, even if
they can never be modules. Nick ended up giving up on his efforts due
to having to do this vetting and backlash he ran into from folks who
really did *not understand* the core of the issue nor were providing
any alternative / guidance. I've gone through his changes and dropped
the patches which dropped the module license tags where an SPDX
license tag was missing, it only consisted of 11 drivers.  To see
if a pull request deals with a file which lacks SPDX tags you
can just use:

  ./scripts/spdxcheck.py -f \
	$(git diff --name-only commid-id | xargs echo)

You'll see a core module file in this pull request for the above,
but that's not related to his changes. WE just need to add the SPDX
license tag for the kernel/module/kmod.c file in the future but
it demonstrates the effectiveness of the script.

Most of Nick's changes were spread out through different trees,
and I just picked up the slack after rc3 for the last kernel was out.
Those changes have been in linux-next for over two weeks.

The cleanups, debug code I added and final fix I added for modules
were motivated by David Hildenbrand's report of boot failing on
a systems with over 400 CPUs when KASAN was enabled due to running
out of virtual memory space. Although the functional change only
consists of 3 lines in the patch "module: avoid allocation if module is
already present and ready", proving that this was the best we can
do on the modules side took quite a bit of effort and new debug code.

The initial cleanups I did on the modules side of things has been
in linux-next since around rc3 of the last kernel, the actual final
fix for and debug code however have only been in linux-next for about a
week or so but I think it is worth getting that code in for this merge
window as it does help fix / prove / evaluate the issues reported
with larger number of CPUs. Userspace is not yet fixed as it is taking
a bit of time for folks to understand the crux of the issue and find a
proper resolution. Worst come to worst, I have a kludge-of-concept [3]
of how to make kernel_read*() calls for modules unique / converge them,
but I'm currently inclined to just see if userspace can fix this
instead.

[0] https://lore.kernel.org/all/Y/kXDqW+7d71C4wz@bombadil.infradead.org/
[1] https://lkml.kernel.org/r/025f2151-ce7c-5630-9b90-98742c97ac65@redhat.com
[2] https://lwn.net/Articles/927569/
[3] https://lkml.kernel.org/r/20230414052840.1994456-3-mcgrof@kernel.org

----------------------------------------------------------------
Arnd Bergmann (4):
      ARM: dyndbg: allow including dyndbg.h in decompressor
      module: stats: include uapi/linux/module.h
      module: fix building stats for 32-bit targets
      module: stats: fix invalid_mod_bytes typo

Bagas Sanjaya (1):
      Documentation: core-api: update kernel-doc reference to kmod.c

Fabio M. De Francesco (1):
      module/decompress: Never use kunmap() for local un-mappings

Jason Baron (3):
      dyndbg: remove unused 'base' arg from __ddebug_add_module()
      dyndbg: use the module notifier callbacks
      dyndbg: cleanup dynamic usage in ib_srp.c

Jiapeng Chong (1):
      module: Remove the unused function within

Jim Cromie (4):
      module: in layout_sections, move_module: add the modname
      module: add symbol-name to pr_debug Absolute symbol
      module: add section-size to move_module pr_debug
      module: already_uses() - reduce pr_debug output volume

Luis Chamberlain (24):
      kernel/module: add documentation for try_module_get()
      module: move get_modinfo() helpers all above
      module: rename next_string() to module_next_tag_pair()
      module: add a for_each_modinfo_entry()
      module: move early sanity checks into a helper
      module: move check_modinfo() early to early_mod_check()
      module: rename set_license() to module_license_taint_check()
      module: split taint work out of check_modinfo_livepatch()
      module: split taint adding with info checking
      module: move tainting until after a module hits our linked list
      module: move signature taint to module_augment_kernel_taints()
      module: converge taint work together
      module: rename check_module_license_and_versions() to check_export_symbol_versions()
      module: add sanity check for ELF module section
      module: add stop-grap sanity check on module memcpy()
      module: move more elf validity checks to elf_validity_check()
      module: merge remnants of setup_load_info() to elf validation
      module: fold usermode helper kmod into modules directory
      module: fix kmemleak annotations for non init ELF sections
      modules/kmod: replace implementation with a semaphore
      module: extract patient module check into helper
      module: add debug stats to help identify memory pressure
      module: avoid allocation if module is already present and ready
      module: add debugging auto-load duplicate module support

Nick Alcock (73):
      soc: fujitsu: remove MODULE_LICENSE in non-modules
      mfd: altera-sysmgr: remove MODULE_LICENSE in non-modules
      irqchip/al-fic: remove MODULE_LICENSE in non-modules
      bus: arm-integrator-lm: remove MODULE_LICENSE in non-modules
      drivers/perf: remove MODULE_LICENSE in non-modules
      ARM: tegra: remove MODULE_LICENSE in non-modules
      pinctrl: actions: remove MODULE_LICENSE in non-modules
      soc: apple: apple-pmgr-pwrstate: remove MODULE_LICENSE in non-modules
      clk: bm1880: remove MODULE_LICENSE in non-modules
      bus: ixp4xx: remove MODULE_LICENSE in non-modules
      pinctrl: nuvoton: npcm7xx: remove MODULE_LICENSE in non-modules
      bus: qcom: remove MODULE_LICENSE in non-modules
      bus: remove MODULE_LICENSE in non-modules
      EDAC, altera: remove MODULE_LICENSE in non-modules
      power: reset: keystone-reset: remove MODULE_LICENSE in non-modules
      video: fbdev: remove MODULE_LICENSE in non-modules
      KEYS: remove MODULE_LICENSE in non-modules
      pinctrl: bcm: ns: remove MODULE_LICENSE in non-modules
      MIPS: BCM47XX: remove MODULE_LICENSE in non-modules
      clocksource: remove MODULE_LICENSE in non-modules
      clocksource/drivers/timer-tegra186: remove MODULE_LICENSE in non-modules
      clocksource: remove MODULE_LICENSE in non-modules
      crypto: remove MODULE_LICENSE in non-modules
      crypto: blake2s: remove module-related code
      crypto: remove MODULE_LICENSE in non-modules
      crypto: blake2s: remove module_init and module.h inclusion
      dmaengine: stm32-mdma: remove MODULE_LICENSE in non-modules
      dmaengine: remove MODULE_LICENSE in non-modules
      dma-mapping: benchmark: remove MODULE_LICENSE in non-modules
      dma-buf: heaps: remove MODULE_LICENSE in non-modules
      binfmt_elf: remove MODULE_LICENSE in non-modules
      phy: intel: remove MODULE_LICENSE in non-modules
      hwspinlock: remove MODULE_LICENSE in non-modules
      iommu/sun50i: remove MODULE_LICENSE in non-modules
      irqchip: remove MODULE_LICENSE in non-modules
      irqchip: remove MODULE_LICENSE in non-modules
      mailbox: rockchip: remove MODULE_LICENSE in non-modules
      mailbox: zynq: make modular
      power: reset: mt6397: remove MODULE_LICENSE in non-modules
      irqchip/mchp-eic: remove MODULE_LICENSE in non-modules
      NFSv4.2: remove MODULE_LICENSE in non-modules
      nvmem: core: remove MODULE_LICENSE in non-modules
      perf/hw_breakpoint: remove MODULE_LICENSE in non-modules
      pinctrl: amd: remove MODULE_LICENSE in non-modules
      pinctrl: mediatek: remove MODULE_LICENSE in non-modules
      pinctrl: renesas: remove MODULE_LICENSE in non-modules
      lib: remove MODULE_LICENSE in non-modules
      power: supply: remove MODULE_LICENSE in non-modules
      remoteproc: remove MODULE_LICENSE in non-modules
      clk: renesas: remove MODULE_LICENSE in non-modules
      reset: mchp: sparx5: remove MODULE_LICENSE in non-modules
      reset: lantiq: remove MODULE_LICENSE in non-modules
      clk: microchip: mpfs: remove MODULE_LICENSE in non-modules
      reset: mpfs: remove MODULE_LICENSE in non-modules
      rv/reactor: remove MODULE_LICENSE in non-modules
      irqchip/irq-sl28cpld: remove MODULE_LICENSE in non-modules
      power: reset: remove MODULE_LICENSE in non-modules
      soc/tegra: cbb: remove MODULE_LICENSE in non-modules
      irqchip: remove MODULE_LICENSE in non-modules
      bus: remove MODULE_LICENSE in non-modules
      braille_console: remove MODULE_LICENSE in non-modules
      drivers: bus: simple-pm-bus: remove MODULE_LICENSE in non-modules
      watch_queue: remove MODULE_LICENSE in non-modules
      btree: remove MODULE_LICENSE in non-modules
      treewide: remove MODULE_LICENSE in non-modules
      unicode: remove MODULE_LICENSE in non-modules
      udmabuf: remove MODULE_LICENSE in non-modules
      regulator: stm32-pwr: remove MODULE_LICENSE in non-modules
      x86/mm/dump_pagetables: remove MODULE_LICENSE in non-modules
      zpool: remove MODULE_LICENSE in non-modules
      zswap: remove MODULE_LICENSE in non-modules
      interconnect: remove MODULE_LICENSE in non-modules
      interconnect: remove module-related code

Pankaj Raghav (1):
      scripts/gdb: use mem instead of core_layout to get the module address

Peter Zijlstra (1):
      Change DEFINE_SEMAPHORE() to take a number argument

Randy Dunlap (1):
      module: fix MIPS module_layout -> module_memory

Song Liu (1):
      module: replace module_layout with module_memory

Thomas Weißschuh (1):
      module: make module_ktype structure constant

Tiezhu Yang (3):
      module: Sync code of is_arm_mapping_symbol()
      module: Move is_arm_mapping_symbol() to module_symbol.h
      module: Ignore L0 and rename is_arm_mapping_symbol()

Tom Rix (1):
      module: remove use of uninitialized variable len

Zhen Lei (1):
      kallsyms: Delete an unused parameter related to {module_}kallsyms_on_each_symbol()

 Documentation/admin-guide/kernel-parameters.txt    |    6 +
 Documentation/core-api/kernel-api.rst              |   24 +-
 .../translations/zh_CN/core-api/kernel-api.rst     |    2 +-
 MAINTAINERS                                        |   13 +-
 arch/arc/kernel/unwind.c                           |   12 +-
 arch/arm/boot/compressed/decompress.c              |    1 +
 arch/arm/kernel/module-plts.c                      |    9 +-
 arch/arm64/kernel/module-plts.c                    |   13 +-
 arch/ia64/kernel/module.c                          |   24 +-
 arch/mips/cavium-octeon/setup.c                    |    2 +-
 arch/mips/kernel/vpe.c                             |   11 +-
 arch/parisc/kernel/module.c                        |   51 +-
 arch/powerpc/kernel/module_32.c                    |    7 +-
 arch/s390/kernel/module.c                          |   26 +-
 arch/x86/crypto/blake2s-glue.c                     |    5 +-
 arch/x86/kernel/callthunks.c                       |    4 +-
 arch/x86/kernel/cpu/intel.c                        |    2 +-
 arch/x86/kernel/module.c                           |    4 +-
 arch/x86/mm/debug_pagetables.c                     |    1 -
 crypto/asymmetric_keys/asymmetric_type.c           |    1 -
 drivers/accessibility/braille/braille_console.c    |    1 -
 drivers/amba/tegra-ahb.c                           |    1 -
 drivers/bus/arm-integrator-lm.c                    |    1 -
 drivers/bus/bt1-apb.c                              |    1 -
 drivers/bus/bt1-axi.c                              |    1 -
 drivers/bus/intel-ixp4xx-eb.c                      |    1 -
 drivers/bus/qcom-ebi2.c                            |    1 -
 drivers/bus/qcom-ssc-block-bus.c                   |    1 -
 drivers/bus/simple-pm-bus.c                        |    2 +-
 drivers/clk/clk-bm1880.c                           |    1 -
 drivers/clk/microchip/clk-mpfs.c                   |    1 -
 drivers/clk/renesas/renesas-cpg-mssr.c             |    1 -
 drivers/clk/renesas/rzg2l-cpg.c                    |    1 -
 drivers/clocksource/em_sti.c                       |    1 -
 drivers/clocksource/sh_cmt.c                       |    1 -
 drivers/clocksource/sh_mtu2.c                      |    1 -
 drivers/clocksource/sh_tmu.c                       |    1 -
 drivers/clocksource/timer-stm32-lp.c               |    1 -
 drivers/clocksource/timer-tegra186.c               |    1 -
 drivers/clocksource/timer-ti-dm.c                  |    1 -
 drivers/dma-buf/heaps/cma_heap.c                   |    1 -
 drivers/dma-buf/heaps/system_heap.c                |    1 -
 drivers/dma-buf/udmabuf.c                          |    1 -
 drivers/dma/ep93xx_dma.c                           |    1 -
 drivers/dma/ipu/ipu_idmac.c                        |    1 -
 drivers/dma/mv_xor_v2.c                            |    1 -
 drivers/dma/sh/shdma-base.c                        |    1 -
 drivers/dma/stm32-dmamux.c                         |    1 -
 drivers/dma/stm32-mdma.c                           |    1 -
 drivers/edac/altera_edac.c                         |    1 -
 drivers/firmware/broadcom/bcm47xx_nvram.c          |    1 -
 drivers/firmware/efi/runtime-wrappers.c            |    2 +-
 drivers/firmware/efi/vars.c                        |    2 +-
 drivers/hwspinlock/hwspinlock_core.c               |    1 -
 drivers/infiniband/ulp/srp/ib_srp.c                |    5 -
 drivers/interconnect/core.c                        |    5 -
 drivers/iommu/sun50i-iommu.c                       |    1 -
 drivers/irqchip/irq-al-fic.c                       |    1 -
 drivers/irqchip/irq-ls-scfg-msi.c                  |    1 -
 drivers/irqchip/irq-mbigen.c                       |    1 -
 drivers/irqchip/irq-mchp-eic.c                     |    1 -
 drivers/irqchip/irq-renesas-intc-irqpin.c          |    1 -
 drivers/irqchip/irq-renesas-irqc.c                 |    1 -
 drivers/irqchip/irq-renesas-rza1.c                 |    1 -
 drivers/irqchip/irq-renesas-rzg2l.c                |    1 -
 drivers/irqchip/irq-sl28cpld.c                     |    1 -
 drivers/irqchip/irq-ti-sci-inta.c                  |    1 -
 drivers/irqchip/irq-ti-sci-intr.c                  |    1 -
 drivers/macintosh/adb.c                            |    2 +-
 drivers/mailbox/Kconfig                            |    2 +-
 drivers/mailbox/rockchip-mailbox.c                 |    1 -
 drivers/mfd/altera-sysmgr.c                        |    1 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |    2 +-
 drivers/nvmem/core.c                               |    1 -
 drivers/perf/apple_m1_cpu_pmu.c                    |    1 -
 drivers/phy/intel/phy-intel-lgm-combo.c            |    1 -
 drivers/pinctrl/actions/pinctrl-s500.c             |    1 -
 drivers/pinctrl/actions/pinctrl-s700.c             |    1 -
 drivers/pinctrl/actions/pinctrl-s900.c             |    1 -
 drivers/pinctrl/bcm/pinctrl-ns.c                   |    1 -
 drivers/pinctrl/mediatek/pinctrl-mt8188.c          |    1 -
 drivers/pinctrl/mediatek/pinctrl-mt8192.c          |    1 -
 drivers/pinctrl/mediatek/pinctrl-mt8365.c          |    1 -
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |    1 -
 drivers/pinctrl/pinctrl-amd.c                      |    1 -
 drivers/pinctrl/renesas/pinctrl-rza1.c             |    1 -
 drivers/pinctrl/renesas/pinctrl-rza2.c             |    1 -
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |    1 -
 drivers/pinctrl/renesas/pinctrl-rzn1.c             |    1 -
 drivers/pinctrl/renesas/pinctrl-rzv2m.c            |    1 -
 drivers/platform/x86/intel/ifs/sysfs.c             |    2 +-
 drivers/power/reset/as3722-poweroff.c              |    1 -
 drivers/power/reset/gpio-poweroff.c                |    1 -
 drivers/power/reset/gpio-restart.c                 |    1 -
 drivers/power/reset/keystone-reset.c               |    1 -
 drivers/power/reset/ltc2952-poweroff.c             |    1 -
 drivers/power/reset/mt6323-poweroff.c              |    1 -
 drivers/power/reset/regulator-poweroff.c           |    1 -
 drivers/power/reset/restart-poweroff.c             |    1 -
 drivers/power/reset/tps65086-restart.c             |    1 -
 drivers/power/supply/power_supply_core.c           |    1 -
 drivers/power/supply/wm97xx_battery.c              |    1 -
 drivers/regulator/stm32-pwr.c                      |    1 -
 drivers/remoteproc/remoteproc_core.c               |    1 -
 drivers/reset/reset-lantiq.c                       |    1 -
 drivers/reset/reset-microchip-sparx5.c             |    1 -
 drivers/reset/reset-mpfs.c                         |    1 -
 drivers/scsi/esas2r/esas2r_ioctl.c                 |    2 +-
 drivers/soc/apple/apple-pmgr-pwrstate.c            |    1 -
 drivers/soc/fujitsu/a64fx-diag.c                   |    1 -
 drivers/soc/tegra/cbb/tegra194-cbb.c               |    1 -
 drivers/soc/tegra/cbb/tegra234-cbb.c               |    1 -
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |    2 +-
 drivers/video/fbdev/wm8505fb.c                     |    1 -
 drivers/video/fbdev/wmt_ge_rops.c                  |    1 -
 fs/binfmt_elf.c                                    |    1 -
 fs/nfs_common/nfs_ssc.c                            |    1 -
 fs/unicode/utf8-core.c                             |    1 -
 include/linux/dynamic_debug.h                      |   68 +-
 include/linux/kallsyms.h                           |    7 +-
 include/linux/module.h                             |  141 ++-
 include/linux/module_symbol.h                      |   17 +
 include/linux/semaphore.h                          |   10 +-
 kernel/Makefile                                    |    1 -
 kernel/dma/map_benchmark.c                         |    1 -
 kernel/events/hw_breakpoint_test.c                 |    1 -
 kernel/kallsyms.c                                  |    5 +-
 kernel/kallsyms_selftest.c                         |    6 +-
 kernel/livepatch/core.c                            |    3 +-
 kernel/module/Kconfig                              |  100 +-
 kernel/module/Makefile                             |    6 +-
 kernel/module/decompress.c                         |    6 +-
 kernel/module/dups.c                               |  246 +++++
 kernel/module/internal.h                           |  140 ++-
 kernel/module/kallsyms.c                           |   78 +-
 kernel/module/kdb.c                                |   17 +-
 kernel/{ => module}/kmod.c                         |   49 +-
 kernel/module/main.c                               | 1091 +++++++++++---------
 kernel/module/procfs.c                             |   16 +-
 kernel/module/stats.c                              |  430 ++++++++
 kernel/module/strict_rwx.c                         |   99 +-
 kernel/module/tracking.c                           |    7 +-
 kernel/module/tree_lookup.c                        |   39 +-
 kernel/params.c                                    |    2 +-
 kernel/printk/printk.c                             |    2 +-
 kernel/trace/ftrace.c                              |    3 +-
 kernel/trace/rv/reactor_panic.c                    |    1 -
 kernel/trace/rv/reactor_printk.c                   |    1 -
 kernel/watch_queue.c                               |    1 -
 lib/Makefile                                       |    3 +
 lib/btree.c                                        |    1 -
 lib/crypto/blake2s-generic.c                       |    5 -
 lib/crypto/blake2s.c                               |    1 -
 lib/dynamic_debug.c                                |   51 +-
 lib/pldmfw/pldmfw.c                                |    1 -
 lib/test_fprobe.c                                  |    1 -
 mm/zpool.c                                         |    1 -
 mm/zswap.c                                         |    1 -
 net/rxrpc/call_object.c                            |    6 +-
 scripts/gdb/linux/constants.py.in                  |    3 +
 scripts/gdb/linux/modules.py                       |    4 +-
 scripts/gdb/linux/symbols.py                       |    4 +-
 scripts/mod/modpost.c                              |   12 +-
 163 files changed, 1982 insertions(+), 1039 deletions(-)
 create mode 100644 include/linux/module_symbol.h
 create mode 100644 kernel/module/dups.c
 rename kernel/{ => module}/kmod.c (77%)
 create mode 100644 kernel/module/stats.c
