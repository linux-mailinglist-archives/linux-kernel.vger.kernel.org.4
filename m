Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE926DEABD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjDLEvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDLEu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:50:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B3A3C11;
        Tue, 11 Apr 2023 21:50:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Px9JW17bYz4xDH;
        Wed, 12 Apr 2023 14:50:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681275051;
        bh=aLG7hJi7FCq/2uHBbPEPGYeYI3WEPwpBvnlD6PfrpwA=;
        h=Date:From:To:Cc:Subject:From;
        b=o1QkwLeIWRFofJovp4WfjQ2/bWImSAZEnkwKuTqLfUuH2jAwP41I0M2Msq6zPH2Uu
         l50iQUj19Uw5YQvOwgSK+HodR+1QJa/L2AvWoXvilwzwsrLs/xS+cbGrD9XmAWfbO/
         YibaZBNfvhcoigQwnSwwsajMIpSNKSdt66s1PmoHK2JnXEeXRZECHMUUiM6gLTzInG
         RBMxvK59HlKm0ICXyW2OqTWSG3SHKwAMTAHhCD0+zkhdK+PO9A9YB9OMtUg9rP4NQl
         AWBjk+gQjVhL7J7xHKYyFTNioZKnmbNqUhxRte0O1jKncoH6CUTXojv4lcdb/lrL+m
         mIKjobi5mN7Kw==
Date:   Wed, 12 Apr 2023 14:50:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 12
Message-ID: <20230412145050.68021e9b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yQPol=8pPfS0jSyZTti3XtJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yQPol=8pPfS0jSyZTti3XtJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20230411:

New trees: wpan, wpan-next

The mediatek tree lost its build failures.

The erofs tree gained a conflict against the vfs-idmapping tree.

The crypto tree lost its build failure.

The drm tree gained a conflict against the powerpc tree and still has its
build failure for which I reverted a commit.

The devicetree tree still had its a build failure for which I applied
a patch.

Non-merge commits (relative to Linus' tree): 9996
 10674 files changed, 498639 insertions(+), 238740 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There is also the merge.log file in the Next
directory.  Between each merge, the tree was built with a ppc64_defconfig
for powerpc, an allmodconfig for x86_64, a multi_v7_defconfig for arm
and a native build of tools/perf. After the final fixups (if any), I do
an x86_64 modules_install followed by builds for x86_64 allnoconfig,
powerpc allnoconfig (32 and 64 bit), ppc44x_defconfig, allyesconfig
and pseries_le_defconfig and i386, arm64, s390, sparc and sparc64
defconfig and htmldocs. And finally, a simple boot test of the powerpc
pseries_le_defconfig kernel in qemu (with and without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 357 trees (counting Linus' and 102 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.

--=20
Cheers,
Stephen Rothwell

$ git checkout master
$ git reset --hard stable
Merging origin/master (e62252bc55b6 Merge tag 'pci-v6.3-fixes-2' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/pci/pci)
Merging fixes/fixes (9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://=
anongit.freedesktop.org/drm/drm)
Merging mm-hotfixes/mm-hotfixes-unstable (5db759204c52 maple_tree: fix a po=
tential memory leak, OOB access, or other unpredictable bug)
Merging kbuild-current/fixes (b5d07167c815 kbuild: do not create intermedia=
te *.tar for tar packages)
Merging arc-current/for-curr (30a0b95b1335 Linux 6.1-rc3)
Merging arm-current/fixes (62fa0c124d5f ARM: 9294/1: vfp: Fix broken softir=
q handling with instrumentation enabled)
Merging arm64-fixes/for-next/fixes (32d859996806 arm64: compat: Work around=
 uninitialized variable warning)
Merging arm-soc-fixes/arm/fixes (4f7e22b8b634 Merge tag 'riscv-dt-fixes-for=
-v6.3-final' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux=
 into arm/fixes)
Merging davinci-current/davinci/for-current (fe15c26ee26e Linux 6.3-rc1)
Merging drivers-memory-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging tee-fixes/fixes (ceaa837f96ad Linux 6.2-rc8)
Merging m68k-current/for-linus (e36a82bebbf7 m68k: Only force 030 bus error=
 if PC not in exception table)
Merging powerpc-fixes/fixes (b277fc793daf powerpc/papr_scm: Update the NUMA=
 distance table for the target node)
Merging s390-fixes/fixes (f9bbf25e7b2b s390/ptrace: fix PTRACE_GET_LAST_BRE=
AK error handling)
Merging sparc/master (2d2b17d08bfc sparc: Unbreak the build)
Merging fscrypt-current/for-current (4bcf6f827a79 fscrypt: check for NULL k=
eyring in fscrypt_put_master_key_activeref())
Merging fsverity-current/for-current (a075bacde257 fsverity: don't drop pag=
ecache at end of FS_IOC_ENABLE_VERITY)
Merging net/main (a4506722dc39 net: phy: nxp-c45-tja11xx: add remove callba=
ck)
Merging bpf/master (a4506722dc39 net: phy: nxp-c45-tja11xx: add remove call=
back)
Merging ipsec/master (24e3fce00c0b net: stmmac: Add queue reset into stmmac=
_xdp_open() function)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/main (5f70bcbca469 net: wwan: iosm: fixes 7560 modem crash)
Merging wireless/for-next (e6db67fa871d wifi: mt76: ignore key disable comm=
ands)
Merging wpan/master (209373537648 Merge branch 'bnxt_en-3-bug-fixes')
Merging rdma-fixes/for-rc (58e84f6b3e84 RDMA/cma: Allow UD qp_type to join =
multicast only)
Merging sound-current/for-linus (e959f2beec8e ALSA: hda: patch_realtek: add=
 quirk for Asus N7601ZM)
Merging sound-asoc-fixes/for-linus (352e1eb17eee ASoC: max98373: change pow=
er down sequence for smart amp)
Merging regmap-fixes/for-linus (eeac8ede1755 Linux 6.3-rc2)
Merging regulator-fixes/for-linus (7c7504067c70 regulator: sm5703: Fix miss=
ing n_voltages for fixed regulators)
Merging spi-fixes/for-linus (e8d018dd0257 Linux 6.3-rc3)
Merging pci-current/for-linus (fe15c26ee26e Linux 6.3-rc1)
Merging driver-core.current/driver-core-linus (7e364e56293b Linux 6.3-rc5)
Merging tty.current/tty-linus (09a9639e56c0 Linux 6.3-rc6)
Merging usb.current/usb-linus (09a9639e56c0 Linux 6.3-rc6)
Merging usb-serial-fixes/usb-linus (09a9639e56c0 Linux 6.3-rc6)
Merging phy/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging staging.current/staging-linus (eeac8ede1755 Linux 6.3-rc2)
Merging iio-fixes/fixes-togreg (c60fd3c9af8b iio: adc: imx93: fix a signedn=
ess bug in imx93_adc_read_raw())
Merging counter-current/counter-current (09a9639e56c0 Linux 6.3-rc6)
Merging char-misc.current/char-misc-linus (a042d7feae7e Merge tag 'fpga-for=
-6.3-final' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpg=
a into char-misc-next)
Merging soundwire-fixes/fixes (e6923fd863af soundwire: qcom: correct settin=
g ignore bit on v1.5.1)
Merging thunderbolt-fixes/fixes (09a9639e56c0 Linux 6.3-rc6)
Merging input-current/for-linus (b3d80fd27a3c Input: pegasus-notetaker - ch=
eck pipe type when probing)
Merging crypto-current/master (660ca9470f9c crypto: caam - Fix edesc/iv ord=
ering mixup)
Merging vfio-fixes/for-linus (4928f67bc911 vfio/mlx5: Fix the report of dir=
ty_bytes upon pre-copy)
Merging kselftest-fixes/fixes (f1594bc67657 selftests mount: Fix mount_seta=
ttr_test builds failed)
Merging modules-fixes/modules-linus (f412eef03938 Documentation: livepatch:=
 module-elf-format: Remove local klp_modinfo definition)
Merging dmaengine-fixes/fixes (d9503be5a100 dmaengine: apple-admac: Fix 'cu=
rrent_tx' not getting freed)
Merging backlight-fixes/for-backlight-fixes (88603b6dc419 Linux 6.2-rc2)
Merging mtd-fixes/mtd/fixes (93942b704615 mtd: rawnand: meson: fix bitmask =
for length in command word)
Merging mfd-fixes/for-mfd-fixes (88603b6dc419 Linux 6.2-rc2)
Merging v4l-dvb-fixes/fixes (8df08ba4a331 media: ov5670: Fix probe on ACPI)
Merging reset-fixes/reset/fixes (3a2390c6777e reset: uniphier-glue: Fix pos=
sible null-ptr-deref)
Merging mips-fixes/mips-fixes (ab327f8acdf8 mips: bmips: BCM6358: disable R=
AC flush for TP1)
Merging at91-fixes/at91-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (0bf9601f8ef0 Merge tag 'kvmarm-fixes-6.3-3' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging kvms390-fixes/master (21f27df85400 KVM: s390: pv: fix external inte=
rruption loop not always detected)
Merging hwmon-fixes/hwmon (7e364e56293b Linux 6.3-rc5)
Merging nvdimm-fixes/libnvdimm-fixes (c91d71363084 nvdimm: Support sizeof(s=
truct page) > MAX_STRUCT_PAGE_SIZE)
Merging cxl-fixes/fixes (ca712e470546 Merge branch 'for-6.3/cxl-doe-fixes' =
into for-6.3/cxl)
Merging btrfs-fixes/next-fixes (010eb030962e Merge branch 'misc-6.3' into n=
ext-fixes)
Merging vfs-fixes/fixes (609d54441493 fs: prevent out-of-bounds array specu=
lation when closing a file descriptor)
Merging dma-mapping-fixes/for-linus (bbb73a103fbb swiotlb: fix a braino in =
the alignment check fix)
Merging drivers-x86-fixes/fixes (9a469c6dfab3 platform/x86: thinkpad_acpi: =
Add missing T14s Gen1 type to s2idle quirk list)
Merging samsung-krzk-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-samsung-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging devicetree-fixes/dt/linus (1a50d9403fb9 treewide: Fix probing of de=
vices in DT overlays)
Merging dt-krzk-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging scsi-fixes/fixes (48b19b79cfa3 scsi: iscsi_tcp: Check that sock is =
valid before iscsi_set_param())
Merging drm-fixes/drm-fixes (09a9639e56c0 Linux 6.3-rc6)
Merging drm-intel-fixes/for-linux-next-fixes (6b8446859c97 drm/i915/dsi: fi=
x DSS CTL register offsets for TGL+)
Merging mmc-fixes/fixes (4b6d621c9d85 memstick: fix memory leak if card dev=
ice is never registered)
Merging rtc-fixes/rtc-fixes (08279468a294 rtc: sunplus: fix format string f=
or printing resource)
Merging gnss-fixes/gnss-linus (1b929c02afd3 Linux 6.2-rc1)
Merging hyperv-fixes/hyperv-fixes (f8acb24aaf89 x86/hyperv: Block root part=
ition functionality in a Confidential VM)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (8d736482749f riscv: add icache flush for nommu =
sigreturn trampoline)
Merging riscv-dt-fixes/riscv-dt-fixes (8056dc043d7f riscv: dts: canaan: dro=
p invalid spi-max-frequency)
Merging riscv-soc-fixes/riscv-soc-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging fpga-fixes/fixes (dc70eb868b9c fpga: bridge: properly initialize br=
idge device before populating children)
Merging spdx/spdx-linus (fe15c26ee26e Linux 6.3-rc1)
Merging gpio-brgl-fixes/gpio/for-current (2ce987d7eeb1 gpio: 104-idi-48: En=
able use_raw_spinlock for idi48_regmap_config)
Merging gpio-intel-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-intel-fixes/fixes (fe15c26ee26e Linux 6.3-rc1)
Merging erofs-fixes/fixes (3993f4f45630 erofs: use wrapper i_blocksize() in=
 erofs_file_read_iter())
Merging kunit-fixes/kunit-fixes (fe15c26ee26e Linux 6.3-rc1)
Merging ubifs-fixes/fixes (2241ab53cbb5 Linux 6.2-rc5)
Merging memblock-fixes/fixes (647037adcad0 Revert "mm: Always release pages=
 to the buddy allocator in memblock_free_late().")
Merging nfsd-fixes/nfsd-fixes (7de82c2f36fb NFSD: callback request does not=
 use correct credential for AUTH_SYS)
Merging irqchip-fixes/irq/irqchip-fixes (6c9f7434159b irqchip: IMX_MU_MSI s=
hould depend on ARCH_MXC)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (9abf2313adc1 Linux 6.1-rc1)
Merging perf-current/perf/urgent (5b201a82cd9d perf tools: Add Adrian Hunte=
r to MAINTAINERS as a reviewer)
Merging efi-fixes/urgent (0b1d9debe303 efi/libstub: randomalloc: Return EFI=
_OUT_OF_RESOURCES on failure)
Merging zstd-fixes/zstd-linus (6906598f1ce9 zstd: Fix definition of assert(=
))
Merging battery-fixes/fixes (06615d11cc78 power: supply: da9150: Fix use af=
ter free bug in da9150_charger_remove due to race condition)
Merging uml-fixes/fixes (a3046a618a28 um: Only disable SSE on clang to work=
 around old GCC bugs)
Merging asahi-soc-fixes/asahi-soc/fixes (568035b01cfb Linux 6.0-rc1)
Merging iommufd-fixes/for-rc (13a0d1ae7ee6 iommufd: Do not corrupt the pfn =
list when doing batch carry)
Merging rust-fixes/rust-fixes (8197cc33f421 rust: allow to use INIT_STACK_A=
LL_ZERO)
Merging v9fs-fixes/fixes/next (347dca97f75d Update email address and mailin=
g list for v9fs)
Merging drm-misc-fixes/for-linux-next-fixes (b89ce1177d42 drm/armada: Fix a=
 potential double free in an error handling path)
Merging mm-stable/mm-stable (d46031f40e0f sched/numa: use hash_32 to mix up=
 PIDs accessing VMA)
Merging mm-nonmm-stable/mm-nonmm-stable (ef55ef3e6400 lib/test-string_helpe=
rs: replace UNESCAPE_ANY by UNESCAPE_ALL_MASK)
Merging mm/mm-everything (89324b02d36b Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Merging kbuild/for-next (58ee5ab975ab kconfig: menuconfig: reorder function=
s to remove forward declarations)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf-tools-next (e01373361285 perf bperf: Avoid use after free=
 via unrelated 'struct evsel' anonymous union field)
Merging compiler-attributes/compiler-attributes (eeac8ede1755 Linux 6.3-rc2)
Merging dma-mapping/for-next (b31507dcaf35 dma-debug: Use %pa to format phy=
s_addr_t)
Merging asm-generic/master (5e98654e30e1 Merge branch 'asm-generic-fixes' i=
nto asm-generic)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (cf83e27d80af Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (6d0fe66e14e4 Merge branch 'for-next/mm' into f=
or-next/core)
CONFLICT (content): Merge conflict in kernel/trace/ftrace.c
Merging arm-perf/for-next/perf (a30b87e6bd7d arm64: pmuv3: dynamically map =
PERF_COUNT_HW_BRANCH_INSTRUCTIONS)
Merging arm-soc/for-next (e770a08d1404 soc: document merges)
CONFLICT (modify/delete): arch/arm/configs/oxnas_v6_defconfig deleted in ar=
m-soc/for-next and modified in HEAD.  Version HEAD of arch/arm/configs/oxna=
s_v6_defconfig left in tree.
$ git rm -f arch/arm/configs/oxnas_v6_defconfig
Merging amlogic/for-next (ae68fb187b59 Merge branch 'v6.4/drivers' into for=
-next)
Merging asahi-soc/asahi-soc/for-next (f41aba157819 Merge branch 'asahi-soc/=
dt' into asahi-soc/for-next)
Merging aspeed/for-next (bb13bd587d53 ARM: dts: aspeed: bonnell: Update eep=
rom size)
Merging at91/at91-next (ad5125686a4f Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (89ec1caa5e4a Merge branch 'soc/next' into next)
Merging davinci/davinci/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging drivers-memory/for-next (3ec0e1ea4770 memory: mtk-smi: mt8365: Add =
SMI Support)
Merging imx-mxs/for-next (03adbea9c292 Merge branch 'imx/defconfig' into fo=
r-next)
Merging mediatek/for-next (0c2286e15856 Merge branch 'v6.3-next/soc' into f=
or-next)
Merging mvebu/for-next (12845aa04754 Merge branch 'mvebu/dt' into mvebu/for=
-next)
Merging omap/for-next (c45167f4f5cf Merge branch 'omap-for-v6.4/dt' into fo=
r-next)
Merging qcom/for-next (71b1fbc389f8 Merge branches 'arm64-defconfig-for-6.4=
', 'arm64-fixes-for-6.3', 'arm64-for-6.4', 'clk-for-6.4', 'drivers-fixes-fo=
r-6.3', 'drivers-for-6.4', 'dts-fixes-for-6.3' and 'dts-for-6.4' into for-n=
ext)
Merging renesas/next (6f03a6e4e947 Merge branches 'renesas-drivers-for-v6.4=
' and 'renesas-dts-for-v6.4' into renesas-next)
Merging reset/reset/next (1b929c02afd3 Linux 6.2-rc1)
Merging rockchip/for-next (2be14da7b04e Merge branch 'v6.4-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (f5391a4705ef Merge branch 'next/dt' into for=
-next)
Merging scmi/for-linux-next (9d5d7cb33f36 Merge branch 'for-next/scmi/updat=
es' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux int=
o for-linux-next)
Merging stm32/stm32-next (49f1d0b65f87 ARM: stm32: add initial documentatio=
n for STM32MP151)
Merging sunxi/sunxi/for-next (7081db38231a Merge branch 'sunxi/dt-for-6.4' =
into sunxi/for-next)
Merging tee/next (cf1773f935d8 Merge branch 'optee_load-for-v6.4' into next)
Merging tegra/for-next (7947eeb21f00 Merge branch for-6.4/arm64/defconfig i=
nto for-next)
Merging ti/ti-next (a8fccb83f3e2 Merge branches 'ti-drivers-soc-next', 'ti-=
k3-config-next' and 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (ec1696c3440f Merge remote-tracking branch 'zynqmp/=
soc' into for-next)
Merging clk/clk-next (e69e657dff81 Merge branch 'clk-mediatek' into clk-nex=
t)
Merging clk-imx/for-next (8a05f5cccdbe clk: imx: imx8ulp: update clk flag f=
or system critical clock)
CONFLICT (content): Merge conflict in include/linux/clk-provider.h
Merging clk-renesas/renesas-clk (5e96c2e0e88d clk: renesas: r8a77980: Add I=
2C5 clock)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (b65c17eec0cd csky: mmu: Prevent spurious page faul=
ts)
Merging loongarch/loongarch-next (fc89d7fb499b Merge tag 'for_linus' of git=
://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging m68k/for-next (1ea3bb3e4b76 m68k: defconfig: Update defconfigs for =
v6.3-rc1)
Merging m68knommu/for-next (31e576abf603 m68k: Kconfig.machine: remove obso=
lete configs ROMBASE and ROMSIZE)
Merging microblaze/next (fe15c26ee26e Linux 6.3-rc1)
Merging mips/mips-next (045c340c86f8 MIPS: lantiq: remove unused function d=
eclaration)
Merging openrisc/for-next (1aff44abf68a openrisc: Use common of_get_cpu_nod=
e() instead of open-coding)
Merging parisc-hd/for-next (783394630553 parisc: Ensure page alignment in f=
lush functions)
Merging powerpc/next (8002725b9e33 powerpc/32: Include thread_info.h in hea=
d_booke.h)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (9c2598d43510 riscv: entry: Save a0 prior syscall_e=
nter_from_user_mode())
Merging riscv-dt/riscv-dt-for-next (4cd4beb98fe5 Merge branch 'riscv-jh7110=
_initial_dts' into riscv-dt-for-next)
Merging riscv-soc/riscv-soc-for-next (4dd472bdafcb soc: microchip: mpfs: ad=
d a prefix to rx_callback())
Merging s390/for-next (18589b3de230 Merge branch 'features' into for-next)
Merging sh/for-next (c2bd1e18c6f8 sh: mcount.S: fix build error when PRINTK=
 is not enabled)
CONFLICT (content): Merge conflict in Documentation/kbuild/kbuild.rst
Merging uml/next (7e364e56293b Linux 6.3-rc5)
Merging xtensa/xtensa-for-next (e313de5b5b04 MAINTAINERS: xtensa: drop linu=
x-xtensa@linux-xtensa.org mailing list)
Merging pidfd/for-next (7bcf0b65b84a Merge branch 'kernel.fork' into for-ne=
xt)
Merging vfs-idmapping/for-next (c0d709a23b30 Merge branch 'fs.misc' into fo=
r-next)
Merging fscrypt/for-next (83e57e47906c fscrypt: optimize fscrypt_initialize=
())
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (0a278bc196e7 afs: Automatically generate trace tag en=
ums)
Merging btrfs/for-next (2e2dead21a51 Merge branch 'for-next-next-v6.3-20230=
411' into for-next-20230411)
Merging ceph/master (f7c4d9b133c7 rbd: avoid use-after-free in do_rbd_add()=
 when rbd_dev_create() fails)
Merging cifs/for-next (b5384792c9ff cifs: reinstate original behavior again=
 for forceuid/forcegid)
Merging configfs/for-next (77992f896745 configfs: remove mentions of commit=
table items)
Merging ecryptfs/next (a3d78fe3e1ae fs: ecryptfs: comment typo fix)
Merging erofs/dev (491ffb74725a erofs: enable long extended attribute name =
prefixes)
CONFLICT (content): Merge conflict in fs/erofs/xattr.c
Merging exfat/dev (fe15c26ee26e Linux 6.3-rc1)
Merging ext3/for_next (74b7d42300a8 reiserfs: remove unused iter variable)
Merging ext4/dev (463f2e46bf7c ext4: convert some BUG_ON's in mballoc to us=
e WARN_RATELIMITED instead)
Merging f2fs/dev (9d07cc8e07c9 f2fs: fix to check readonly condition correc=
tly)
Merging fsverity/for-next (095936cb2638 fsverity: reject FS_IOC_ENABLE_VERI=
TY on mode 3 fds)
Merging fuse/for-next (c68ea140050e fuse: remove duplicate check for nodeid)
Merging gfs2/for-next (cfcdb5bad34f gfs2: Fix inode height consistency chec=
k)
Merging jfs/jfs-next (fad376fce0af fs/jfs: fix shift exponent db_agl2size n=
egative)
Merging ksmbd/ksmbd-for-next (4b2c6a534a48 ksmbd: remove unused compression=
 negotiate ctx packing)
Merging nfs/linux-next (e8d018dd0257 Linux 6.3-rc3)
Merging nfs-anna/linux-next (943d045a6d79 SUNRPC: fix shutdown of NFS TCP c=
lient socket)
Merging nfsd/nfsd-next (dcf700e2b6b4 SUNRPC: Ignore return value of ->xpo_s=
endto)
Merging ntfs3/master (788ee1605c2e fs/ntfs3: Fix root inode checking)
Merging orangefs/for-next (31720a2b109b orangefs: Fix kmemleak in orangefs_=
{kernel,client}_debug_init())
Merging overlayfs/overlayfs-next (4f11ada10d0a ovl: fail on invalid uid/gid=
 mapping at copy up)
Merging ubifs/next (1e020e1b96af ubi: Fix failure attaching when vid_hdr of=
fset equals to (sub)page size)
Merging v9fs/9p-next (4ec5183ec486 Linux 6.2-rc7)
Merging v9fs-ericvh/ericvh/for-next (4eb3117888a9 fs/9p: Rework cache modes=
 and add new options to Documentation)
Merging xfs/for-next (4dfb02d5cae8 xfs: fix mismerged tracepoints)
Merging zonefs/for-next (2b188a2cfc4d zonefs: make kobj_type structure cons=
tant)
Merging iomap/iomap-for-next (471859f57d42 iomap: Rename page_ops to folio_=
ops)
Merging djw-vfs/vfs-for-next (a79168a0c00d fs/remap_range: avoid spurious w=
riteback on zero length request)
Merging file-locks/locks-next (63355b9884b3 cpumask: be more careful with '=
cpumask_setall()')
Merging iversion/iversion-next (63355b9884b3 cpumask: be more careful with =
'cpumask_setall()')
Merging vfs/for-next (d291d1858419 Merge branch 'work.fd' into for-next)
Merging printk/for-next (16bff6f075a1 Merge branch 'for-6.4' into for-next)
Merging pci/next (be829256e322 Merge branch 'pci/controller/rcar')
Merging pstore/for-next/pstore (5239a89b06d6 pstore: Revert pmsg_lock back =
to a normal mutex)
Merging hid/for-next (24d68dfa10fa Merge branch 'for-6.4/logitech-hidpp' in=
to for-next)
Merging i2c/i2c/for-next (87ef28652481 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (2810f1de814a i3c: svc: Convert to platform remove cal=
lback returning void)
Merging dmi/dmi-for-next (13a0ac816d22 firmware: dmi: Fortify entry point l=
ength checks)
Merging hwmon-staging/hwmon-next (0ac457129fee hwmon: (coretemp) Delete an =
obsolete comment)
Merging jc_docs/docs-next (b645fc696bec Documentation: firmware: Clarify fi=
rmware path usage)
CONFLICT (content): Merge conflict in Documentation/admin-guide/index.rst
Merging v4l-dvb/master (eeac8ede1755 Linux 6.3-rc2)
Merging v4l-dvb-next/master (3228cec23b8b media: rkvdec: fix use after free=
 bug in rkvdec_remove)
Merging pm/linux-next (c4895dfd200d Merge branch 'acpi-resource' into linux=
-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (e2b47e585931 cpufreq: qcom-cpuf=
req-hw: Revert adding cpufreq qos)
Merging cpupower/cpupower (fe15c26ee26e Linux 6.3-rc1)
Merging devfreq/devfreq-next (376b1446153c PM / devfreq: exynos-ppmu: Use d=
evm_platform_get_and_ioremap_resource())
Merging opp/opp/linux-next (528f2d8d540a OPP: Move required opps configurat=
ion to specialized callback)
Merging thermal/thermal/linux-next (0c7d069297a0 Merge back thermal control=
 material for 6.4-rc1.)
Merging dlm/next (1361737f102d fs: dlm: switch lkb_sbflags to atomic ops)
Merging rdma/for-next (866694afd644 IB/hfi1: Place struct mmu_rb_handler on=
 cache line start)
Merging net-next/main (4de00f0acc72 gve: Unify duplicate GQ min pkt desc si=
ze constants)
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlxsw/c=
ore_thermal.c
Merging bpf-next/for-next (75dcef8d3609 selftests/bpf: Add test to access u=
32 ptr argument in tracing program)
CONFLICT (content): Merge conflict in Documentation/bpf/bpf_devel_QA.rst
Applying: bpf, test_run: fix up for "bpf, test_run: fix &xdp_frame misplace=
ment for LIVE_FRAMES"
Merging ipsec-next/master (f4796398f21b xfrm: Remove inner/outer modes from=
 output path)
Merging mlx5-next/mlx5-next (77f7eb9f3416 net/mlx5: Introduce other vport q=
uery for Q-counters)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/main (4de00f0acc72 gve: Unify duplicate GQ min pkt desc s=
ize constants)
Merging bluetooth/master (cbcb70b9beee Bluetooth: L2CAP: Fix use-after-free=
 in l2cap_disconnect_{req,rsp})
Merging wireless-next/for-next (e3e0ca32cf47 wifi: mac80211: set EHT suppor=
t flag in AP mode)
Merging wpan-next/master (1af3de62f03f ieee802154: ca8210: Flag the driver =
as being limited)
Merging mtd/mtd/next (e6026eb080fa mtd: lpddr_cmds: remove unused words var=
iable)
Merging nand/nand/next (ec185b18c223 mtd: nand: Convert to platform remove =
callback returning void)
Merging spi-nor/spi-nor/next (df6def86b9dc mtd: spi-nor: spansion: Add supp=
ort for s25hl02gt and s25hs02gt)
Merging crypto/master (8ae8a494eae4 crypto: ixp4xx - Do not check word size=
 when compile testing)
Merging drm/drm-next (55bf14961db9 Merge tag 'mediatek-drm-next-6.4' of htt=
ps://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux into drm-ne=
xt)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/Kconfig
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm_mst_types.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/icl_dsi.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_tc=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/ttm/ttm_pool.c
Applying: Revert "drm/ttm: Reduce the number of used allocation orders for =
TTM pages"
Merging drm-misc/for-linux-next (fd35174e13f9 drm/vmwgfx: remove unused vmw=
_overlay function)
Merging amdgpu/drm-next (27488686cb18 drm/amdgpu: Enable GFX11 SDMA context=
 empty interrupt)
Merging drm-intel/for-linux-next (d6fff836c0e0 drm/i915: Hook up csc into s=
tate checker)
Merging drm-tegra/for-next (2429b3c529da drm/tegra: Avoid potential 32-bit =
integer overflow)
Merging drm-msm/msm-next (ac7e7c9c65ec drm/msm/dpu: drop unused macros from=
 hw catalog)
Merging drm-msm-lumag/msm-next-lumag (ac7e7c9c65ec drm/msm/dpu: drop unused=
 macros from hw catalog)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (4c22c61e429f drm/etnaviv: show number of NN c=
ores in GPU debugfs info)
Merging fbdev/for-next (b61c2c09c5a3 video: fbdev: xilinxfb: Convert to pla=
tform remove callback returning void)
Merging regmap/for-next (4a670ac3e75e regmap: allow upshifting register add=
resses before performing operations)
Merging sound/for-next (714b2f025d76 ALSA: hda: LNL: add HD Audio PCI ID)
Merging sound-asoc/for-next (97098b7b82c5 Merge remote-tracking branch 'aso=
c/for-6.4' into asoc-next)
Merging modules/modules-next (3edf091d5c12 Documentation: core-api: update =
kernel-doc reference to kmod.c)
Merging input/next (483a14418661 Input: edt-ft5x06 - select REGMAP_I2C)
Merging block/for-next (064c5a3dc420 Merge branch 'for-6.4/io_uring' into f=
or-next)
Applying: fix up for "iov_iter: add copy_page_to_iter_nofault()"
Merging device-mapper/for-next (3664ff82dae1 dm: add helper macro for simpl=
e DM target module init and exit)
Merging libata/for-next (140b26035b2d ata: pata_parport-bpck6: Declare mode=
_map as static)
Merging pcmcia/pcmcia-next (15e74c6c1ce2 pcmcia: remove AT91RM9200 Compact =
Flash driver)
Merging mmc/next (ec49843332df mmc: Merge branch fixes into next)
Merging mfd/for-mfd-next (11e572d06c23 mfd: rsmu_i2c: Convert to i2c's .pro=
be_new() again)
Applying: fixup for "mfd: qcom-pm8008: Convert irq chip to config regs"
Merging backlight/for-backlight-next (fb200218b40b backlight: as3711: Use o=
f_property_read_bool() for boolean properties)
Merging battery/for-next (baba1315a74d power: supply: rk817: Fix low SOC bu=
gs)
Merging regulator/for-next (ba464f19a3d5 Merge remote-tracking branch 'regu=
lator/for-6.4' into regulator-next)
Merging security/next (d82dcd9e21b7 reiserfs: Add security prefix to xattr =
name in reiserfs_security_write())
Merging apparmor/apparmor-next (cb60752f0c37 apparmor: fix use of strcpy in=
 policy_unpack_test)
Merging integrity/next-integrity (644f17412f5a IMA: allow/fix UML builds)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (539813e4184a selinux: stop returning node from avc_in=
sert())
Merging smack/next (de93e515db30 Smack: Improve mount process memory use)
Merging tomoyo/master (ab8527429de6 workqueue: Emit runtime message when fl=
ush_scheduled_work() is called)
Merging tpmdd/next (5903ed4cf40e integrity: machine keyring CA configuratio=
n)
Merging watchdog/master (09a9639e56c0 Linux 6.3-rc6)
Merging iommu/next (43a31380ed6e Merge branches 'iommu/fixes', 'arm/allwinn=
er', 'arm/mediatek', 'arm/omap', 'arm/renesas', 'ppc/pamu', 'unisoc', 'x86/=
amd', 'core' and 'platform-remove_new' into next)
Merging audit/next (fe15c26ee26e Linux 6.3-rc1)
Merging devicetree/for-next (f7a365727d3f Merge branch 'dt/address-cleanups=
' into dt/next)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/ata=
/ahci-platform.yaml
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/sou=
nd/qcom,lpass-rx-macro.yaml
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/sou=
nd/qcom,lpass-tx-macro.yaml
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/sou=
nd/qcom,lpass-va-macro.yaml
Applying: devicetree: fix up for include rationalisation
Applying: of/address: fixup for "Add of_property_read_reg() helper"
Merging dt-krzk/for-next (efb75299863e Merge branch 'next/dt64' into for-ne=
xt)
Merging mailbox/mailbox-for-next (6ccbe33a3952 dt-bindings: mailbox: qcom-i=
pcc: Add compatible for QDU1000/QRU1000)
Merging spi/for-next (1c0f16b01e74 Merge remote-tracking branch 'spi/for-6.=
4' into spi-next)
Merging tip/master (f91f9332d782 Merge branch into tip/master: 'x86/tdx')
CONFLICT (file location): Documentation/x86/shstk.rst added in tip/master i=
nside a directory that was renamed in HEAD, suggesting it should perhaps be=
 moved to Documentation/arch/x86/shstk.rst.
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_rc6.c
CONFLICT (content): Merge conflict in drivers/iommu/iommu-sva.c
CONFLICT (modify/delete): include/linux/ioasid.h deleted in HEAD and modifi=
ed in tip/master.  Version tip/master of include/linux/ioasid.h left in tre=
e.
CONFLICT (content): Merge conflict in include/linux/sched/mm.h
CONFLICT (content): Merge conflict in mm/userfaultfd.c
$ git rm -f include/linux/ioasid.h
Applying: fixup for "iommu/sva: Replace pasid_valid() helper with mm_valid_=
pasid()"
Applying: extra fixup for "iommu/sva: Replace pasid_valid() helper with mm_=
valid_pasid()"
Merging clockevents/timers/drivers/next (6bc2e2a00f46 clocksource/drivers/s=
tm32-lp: Drop of_match_ptr for ID table)
Merging edac/edac-for-next (d6c5e688899b Merge branch 'edac-drivers' into e=
dac-for-next)
Merging irqchip/irq/irqchip-next (9860dac91964 Merge branch irq/loongarch-f=
ixes-6.4 into irq/irqchip-next)
Merging ftrace/for-next (88fe1ec75fcb tracing: Unbreak user events)
CONFLICT (content): Merge conflict in kernel/fork.c
Merging rcu/rcu/next (ceff5af3c8de Revert "rcu/kvfree: Eliminate k[v]free_r=
cu() single argument macro")
Applying: fixup for "RDMA/rxe: Add error messages"
Merging kvm/next (d8708b80fa0e KVM: Change return type of kvm_arch_vm_ioctl=
() to "int")
Merging kvm-arm/next (df706d5176fd Merge branch kvm-arm64/smccc-filtering i=
nto kvmarm-master/next)
CONFLICT (content): Merge conflict in arch/arm64/include/asm/kvm_host.h
CONFLICT (content): Merge conflict in arch/arm64/kvm/arm.c
Merging kvms390/next (5fc5b94a2736 s390/virtio: sort out physical vs virtua=
l pointers usage)
Merging kvm-x86/next (4d663d83a561 Merge branch 'pmu')
Applying: fixup for "KVM: x86: Rename Hyper-V remote TLB hooks to match est=
ablished scheme"
Merging xen-tip/linux-next (fb47c4966007 xen/pvcalls: don't call bind_evtch=
n_to_irqhandler() under lock)
Merging percpu/for-next (b9819165bb45 Merge branch 'for-6.2' into for-next)
Merging workqueues/for-next (704bc669e1dd workqueue: Introduce show_freezab=
le_workqueues)
Merging drivers-x86/for-next (4f59630a5ed0 platform/x86: intel-uncore-freq:=
 Add client processors)
Merging chrome-platform/for-next (419346a03810 platform/chrome: cros_ec_deb=
ugfs: fix kernel-doc warning)
Merging hsi/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds/for-next (1b929c02afd3 Linux 6.2-rc1)
Merging leds-lj/for-leds-next (22dc3789b737 leds: flash: Set variables mvfl=
ash_{3,4}ch_regs storage-class-specifier to static)
Merging ipmi/for-next (6ce7995a43fe ipmi:ssif: Add send_retries increment)
Merging driver-core/driver-core-next (862d8312eed9 tty: make tty_class a st=
atic const structure)
CONFLICT (content): Merge conflict in arch/s390/kernel/topology.c
Applying: fixup for "driver core: bus: mark the struct bus_type for sysfs c=
allbacks as constant"
Applying: fixup for "driver core: class: remove module * from class_create(=
)"
Merging usb/usb-next (8e86652e3e71 Merge 6.3-rc6 into usb-next)
Merging thunderbolt/next (1f15af76784c thunderbolt: Introduce usb4_port_sb_=
opcode_err_to_errno() helper)
Merging usb-serial/usb-next (197b6b60ae7b Linux 6.3-rc4)
Merging tty/tty-next (039535ecf18e Merge 6.3-rc6 into tty-next)
Merging char-misc/char-misc-next (5790d407daa3 Merge 6.3-rc6 into char-misc=
-next)
CONFLICT (modify/delete): drivers/char/pcmcia/cm4000_cs.c deleted in char-m=
isc/char-misc-next and modified in HEAD.  Version HEAD of drivers/char/pcmc=
ia/cm4000_cs.c left in tree.
CONFLICT (modify/delete): drivers/char/pcmcia/cm4040_cs.c deleted in char-m=
isc/char-misc-next and modified in HEAD.  Version HEAD of drivers/char/pcmc=
ia/cm4040_cs.c left in tree.
CONFLICT (modify/delete): drivers/char/pcmcia/scr24x_cs.c deleted in char-m=
isc/char-misc-next and modified in HEAD.  Version HEAD of drivers/char/pcmc=
ia/scr24x_cs.c left in tree.
CONFLICT (modify/delete): drivers/char/pcmcia/synclink_cs.c deleted in char=
-misc/char-misc-next and modified in HEAD.  Version HEAD of drivers/char/pc=
mcia/synclink_cs.c left in tree.
CONFLICT (content): Merge conflict in drivers/of/Makefile
$ git rm -f drivers/char/pcmcia/cm4000_cs.c drivers/char/pcmcia/cm4040_cs.c=
 drivers/char/pcmcia/scr24x_cs.c drivers/char/pcmcia/synclink_cs.c
Applying: cdx: change struct bus_type for sysfs rescan callback as constant
Merging accel/habanalabs-next (56499c461589 accel/habanalabs: add missing e=
rror flow in hl_sysfs_init())
Merging coresight/next (197b6b60ae7b Linux 6.3-rc4)
Merging fpga/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging icc/icc-next (b7590f3841f4 dt-bindings: interconnect: qcom,msm8998-=
bwmon: Resolve MSM8998 support)
Merging iio/togreg (c86b0e73f0be MAINTAINERS: Add ROHM BU27034)
Merging phy-next/next (868c2a6ceead phy: qcom-qmp-ufs: Add SM7150 support)
Merging soundwire/next (8f806c0f3363 soundwire: bus: Update sdw_nread/nwrit=
e_no_pm to handle page boundaries)
Merging extcon/extcon-next (22349cb0b86e extcon: Remove dup device name in =
the message and unneeded error check)
CONFLICT (content): Merge conflict in drivers/extcon/extcon.c
Merging gnss/gnss-next (1b929c02afd3 Linux 6.2-rc1)
Merging vfio/next (99aec4a01047 vfio: correct kdoc for ops structures)
Merging staging/staging-next (41500f453562 staging: rtl8192e: Add blank lin=
es after declarations)
Merging counter-next/counter-next (09a9639e56c0 Linux 6.3-rc6)
Merging mux/for-next (ea327624ae52 mux: mmio: drop obsolete dependency on C=
OMPILE_TEST)
Merging dmaengine/next (82e6051a4895 dmaengine: ti: k3-psil: Add PSI-L thre=
ad support for J784s4)
Merging cgroup/for-next (d86bd73e834f Merge branch 'for-6.4' into for-next)
Merging scsi/for-next (8e3ced132a8c Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (3c85f087faec scsi: ufs: mcq: Use pointer arithme=
tic in ufshcd_send_command())
CONFLICT (content): Merge conflict in drivers/ufs/core/ufshcd.c
Merging vhost/linux-next (72baf650a031 vdpa/snet: support the suspend vDPA =
callback)
Merging rpmsg/for-next (933d2f67afb2 Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (8a4adcf67a39 gpio: gpiolib: Simplify gpioc=
hip_add_data_with_key() fwnode)
Merging gpio-intel/for-next (782eea0c89f7 gpiolib: acpi: Add a ignore wakeu=
p quirk for Clevo NL5xNU)
Merging pinctrl/for-next (d45e84fb8351 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging pinctrl-renesas/renesas-pinctrl (45e6cc8ef1cd pinctrl: renesas: cor=
e: Drop unneeded #ifdef CONFIG_OF)
Merging pinctrl-samsung/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging pwm/for-next (9a2273a16157 pwm: xilinx: Convert to platform remove =
callback returning void)
Merging userns/for-next (05bd6e0242b4 Merge of unpriv-ipc-sysctls-for-v6.2,=
 and fix-atomic_lock_inc_below-for-v6.2 for testing in linux-next)
Merging ktest/for-next (7dc8e24f0e09 ktest: Restore stty setting at first i=
n dodie)
Merging kselftest/next (266679ffd867 kselftest/arm64: Convert za-fork to us=
e kselftest.h)
Merging kunit/test (fe15c26ee26e Linux 6.3-rc1)
Merging kunit-next/kunit (a42077b78768 kunit: add tests for using current K=
Unit test field)
Merging livepatching/for-next (5e36be5973b6 Merge branch 'for-6.4/core' int=
o for-next)
Merging rtc/rtc-next (0e6255fa3f64 rtc: meson-vrtc: Use ktime_get_real_ts64=
() to get the current time)
Merging nvdimm/libnvdimm-for-next (305a72efa791 Merge branch 'for-6.1/nvdim=
m' into libnvdimm-for-next)
Merging at24/at24/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging ntb/ntb-next (942cc9ceccb6 ntb: intel: Remove redundant pci_clear_m=
aster)
Merging seccomp/for-next/seccomp (0fb0624b15d2 seccomp: fix kernel-doc func=
tion name warning)
Merging fsi/next (35af9fb49bc5 fsi: core: Check error number after calling =
ida_simple_get)
Merging slimbus/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging nvmem/for-next (c60363be9b76 nvmem: layouts: onie-tlv: Drop wrong m=
odule alias)
CONFLICT (add/add): Merge conflict in drivers/nvmem/layouts/sl28vpd.c
CONFLICT (content): Merge conflict in drivers/of/Makefile
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (38299f300c12 Driver: VMBus: Add Devicetree supp=
ort)
Merging auxdisplay/auxdisplay (ddf75a86aba2 auxdisplay: hd44780: Fix potent=
ial memory leak in hd44780_remove())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (fe15c26ee26e Linux 6.3-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging mhi/mhi-next (1d1493bdc25f bus: mhi: host: Use mhi_tryset_pm_state(=
) for setting fw error state)
Merging memblock/for-next (34875d6fc52d Add tests for memblock_alloc_node())
Merging cxl/next (e686c32590f4 dax/kmem: Fix leak of memory-hotplug resourc=
es)
Merging zstd/zstd-next (2aa14b1ab2c4 zstd: import usptream v1.5.2)
Merging efi/next (8364f6d000ed efi/loongarch: Reintroduce efi_relocate_kern=
el() to relocate kernel)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (ed4cdfbeb873 Merge branch 'slab/for-6.4/slob-removal=
' into slab/for-next)
CONFLICT (content): Merge conflict in include/linux/slab.h
CONFLICT (modify/delete): mm/slob.c deleted in slab/for-next and modified i=
n HEAD.  Version HEAD of mm/slob.c left in tree.
$ git rm -f mm/slob.c
Merging random/master (512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging landlock/next (ed35e2f2f0de landlock: Clarify documentation for the=
 LANDLOCK_ACCESS_FS_REFER right)
Merging rust/rust-next (ffa6a7fdeb43 rust: sync: add functions for initiali=
zing `UniqueArc<MaybeUninit<T>>`)
Merging sysctl/sysctl-next (28ff831b2e2e mm: compaction: remove incorrect #=
ifdef checks)
Merging execve/for-next/execve (88603b6dc419 Linux 6.2-rc2)
Merging bitmap/bitmap-for-next (714f3af11b21 cpumask: fix function descript=
ion kernel-doc notation)
CONFLICT (content): Merge conflict in include/linux/cpumask.h
Merging hte/for-next (fe15c26ee26e Linux 6.3-rc1)
Merging kspp/for-next/kspp (78f7a3fd6dc6 randstruct: disable Clang 15 suppo=
rt)
Merging kspp-gustavo/for-next/kspp (26476022a5b2 s390/fcx: Replace zero-len=
gth array with flexible-array member)
Merging iommufd/for-next (1fb3556b418f Merge branch 'ko-iommufd/wip/for-nes=
ting' into k.o-iommufd/for-next)

--Sig_/yQPol=8pPfS0jSyZTti3XtJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ2OKoACgkQAVBC80lX
0Gz5Dgf+KsdubjAFkCxlqCqrCsNptaPNmzm/QGvAIv8bhsN7h+X3iYp0YtdGIS6Q
BOt3+H4vDmx+EbAzH+3QJhC1xGpqSDA4zkBoZWkQ62MOHOCoiZk0bYXYNzEbNpof
vgDLmfJ2+UEi26xqrZ9FEMBthBY32PPhNytARch83lnZgngd/WnPRFC3grKjebPC
5Kj6MgL3O3YgAQu1labCZHUvPi+Cok5WGea+5SfxzLNxCCYq/hMWd5N5C+mGs0Bq
1RK87dcr0Afrwn1UsrxI9Tc3pSqHzQJ5nqdhPwX4vApy/5r8qcH2phAFYi1Rm/eu
ZvzHZMV29aHxy5kPgw2UHEvc4BzlQw==
=M+Se
-----END PGP SIGNATURE-----

--Sig_/yQPol=8pPfS0jSyZTti3XtJ--
