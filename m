Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A9C5F2578
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 23:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJBVaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 17:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJBVaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 17:30:06 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C20205C9
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 14:30:05 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id g130so9756362oia.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 14:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=TBOaOwMZEwhQdVhsl6fv+yHT5nu7PVPvqMC8EcXnCk8=;
        b=GLBQm037Hn4pbrFqjAMlSDvJO6TignQbGvvk9zFFtp7rH08HKs3z3O1SlA06aCmdC4
         n/3ZAyNplbaiwRStUnaV5i6mtdDdhq8s4iNXAuek7SI/6EhqII3N7HhaIc+0uXY9DHcg
         Qn2E4XYPN+gfQcd5AxrCfHzKpuioGBc02vDb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TBOaOwMZEwhQdVhsl6fv+yHT5nu7PVPvqMC8EcXnCk8=;
        b=Pn+pg9E6kVwT1PEDH7H0wGMF/QnIkm7J8fs8MsTvAydHDWXC+IbkX7eHjbVr9M0AOB
         knQgcj8Jd0Lanfk5A5QF6v8OXduW1DRDnrbOZIWRMqmBoUv+gCYZbLrMDe8rIqD4qBfd
         Is6eHN7i9XhgRV03Ig8dXaw7WRFb8AzMqrC1LV3utNEPejJzdNeBTHMFB2HRkIeG5C+q
         L7qCzxmxVtZXX/X7mThoKtmS7au8SYLBFL+KSN+kr0WxqdPJmI6TiJjCgDdj+8t1ki3J
         CvyVsbTcKw2DTDkFCGgaikpJUhuaZ7kKPlc4SJbDZISh6AaNTuDx9gITzH9poZdI6zQv
         /Zxg==
X-Gm-Message-State: ACrzQf3eeiF9c/u2FQmtS+XUGUhcwy1ZLqg+84p8jy3MDLiR5tULLJNN
        xMLGVHsJJwmw/GHUEcsP23xlaufBV3JUlw==
X-Google-Smtp-Source: AMsMyM7B69E0fKDNBsC2wPk25eYjOVzedIXjtgs4B0L3zUBzza2c4/NKpLgpJE3SX+xtkYwqUyB9qg==
X-Received: by 2002:a05:6808:bd3:b0:350:e312:9abf with SMTP id o19-20020a0568080bd300b00350e3129abfmr2975650oik.78.1664746203503;
        Sun, 02 Oct 2022 14:30:03 -0700 (PDT)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id l8-20020a9d7348000000b006393ea22c1csm1977860otk.16.2022.10.02.14.30.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 14:30:02 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so5665926oop.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 14:30:02 -0700 (PDT)
X-Received: by 2002:a05:6830:11c6:b0:65f:913:ff93 with SMTP id
 v6-20020a05683011c600b0065f0913ff93mr2631869otq.69.1664746202123; Sun, 02 Oct
 2022 14:30:02 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Oct 2022 14:29:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaGf66EQOq1FwM6p9c3mGOjzm9stGeUTfC5Txx4yoxgg@mail.gmail.com>
Message-ID: <CAHk-=wiaGf66EQOq1FwM6p9c3mGOjzm9stGeUTfC5Txx4yoxgg@mail.gmail.com>
Subject: Linux 6.0
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, as is hopefully clear to everybody, the major version number
change is more about me running out of fingers and toes than it is
about any big fundamental changes.

But of course there's a lot of various changes in 6.0 - we've got over
15k non-merge commits in there in total, after all, and as such 6.0 is
one of the bigger releases at least in numbers of commits in a while.

The shortlog of changes below is only the last week since 6.0-rc7. A
little bit of everything, although the diffstat is dominated by drm
(mostly amd new chip support) and networking drivers.

And this obviously means that tomorrow I'll open the merge window for
6.1. Which - unlike 6.0 - has a number of fairly core new things lined
up. But for now, please do give this most recent kernel version a
whirl,

              Linus

---

Aidan MacDonald (1):
      clk: ingenic-tcu: Properly enable registers before accessing timers

Al Viro (1):
      [coredump] don't use __kernel_write() on kmap_local_page()

Alexander Couzens (2):
      net: mt7531: only do PLL once after the reset
      net: mt7531: ensure all MACs are powered down before reset

Alexander Wetzel (2):
      wifi: mac80211: don't start TX with fq->lock to fix deadlock
      wifi: mac80211: ensure vif queues are operational after start

Alistair Popple (3):
      mm/migrate_device.c: flush TLB while holding PTL
      mm/migrate_device.c: add missing flush_cache_page()
      mm/migrate_device.c: copy pte dirty bit to page

Alvin Lee (1):
      drm/amd/display: Update DCN32 to use new SR latencies

Andy Moreton (1):
      sfc: correct filter_table_remove method for EF10 PFs

Angus Chen (1):
      vdpa/ifcvf: fix the calculation of queuepair

Antonio Borneo (1):
      irqchip/stm32-exti: Remove check on always false condition

Aric Cyr (1):
      drm/amd/display: Fix audio on display after unplugging another

Arnaldo Carvalho de Melo (2):
      perf tests record: Fail the test if the 'errs' counter is not zero
      perf build: Fixup disabling of -Wdeprecated-declarations for the
python scripting engine

Ashutosh Dixit (1):
      drm/i915/gt: Perf_limit_reasons are only available for Gen11+

Athira Rajeev (2):
      perf tests powerpc: Fix branch stack sampling test to include
sanity check for branch filter
      perf tests vmlinux-kallsyms: Update is_ignored_symbol function
to match the kernel ignored list

Bhupesh Sharma (1):
      arm64: dts: qcom: sm8150: Fix fastrpc iommu values

Binyi Han (1):
      mm: fix dereferencing possible ERR_PTR

Bjorn Andersson (1):
      MAINTAINERS: Update Bjorn's email address

Bokun Zhang (1):
      drm/amdgpu: Add amdgpu suspend-resume code path under SRIOV

Borislav Petkov (1):
      x86/cacheinfo: Add a cpu_llc_shared_mask() UP variant

Brian Norris (2):
      mmc: core: Terminate infinite loop in SD-UHS voltage switch
      Revert "drm: bridge: analogix/dp: add panel prepare/unprepare in
suspend/resume time"

ChenXiaoSong (1):
      ntfs: fix BUG_ON in ntfs_lookup_inode_by_name()

Chris Wilson (1):
      drm/i915/gt: Restrict forced preemption to the active context

Christoph Hellwig (1):
      frontswap: don't call ->init if no ops are registered

Conor Dooley (2):
      clk: microchip: mpfs: fix clk_cfg array bounds violation
      clk: microchip: mpfs: make the rtc's ahb clock critical

Damien Le Moal (2):
      ata: libata-scsi: Fix initialization of device queue depth
      ata: libata-sata: Fix device queue depth control

Dan Williams (4):
      xfs: quiet notify_failure EOPNOTSUPP cases
      xfs: fix SB_BORN check in xfs_dax_notify_failure()
      mm/memory-failure: fix detection of memory_failure() handlers
      mm/memory-failure: fall back to vma_address() when
->notify_failure() fails

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: fix mask of RX_DMA_GET_SPORT{,_V2}

Dave Hansen (1):
      ACPI: processor idle: Practically limit "Dummy wait" workaround
to old Intel systems

David Matlack (2):
      KVM: selftests: Skip tests that require EPT when it is not available
      KVM: selftests: Gracefully handle empty stack traces

Doug Berger (1):
      mm/hugetlb: correct demote page offset logic

Dylan Yudaken (1):
      io_uring: register single issuer task at creation

Eli Cohen (1):
      vdpa/mlx5: Fix MQ to support non power of two num queues

Emanuele Giuseppe Esposito (1):
      KVM: selftests: replace assertion with warning in
access_tracking_perf_test

Eric Bernstein (1):
      drm/amd/display: Remove assert for odm transition case

Evan Quan (3):
      drm/amdgpu: avoid gfx register accessing during gfxoff
      drm/amd/pm: enable gfxoff feature for SMU 13.0.0
      drm/amd/pm: use adverse selection for dpm features unsupported by dri=
ver

Florian Fainelli (2):
      soc: bcm: brcmstb: biuctrl: Avoid double of_node_put()
      clk: iproc: Do not rely on node name for correct PLL setup

Florian Westphal (1):
      mm: fix BUG splat with kvmalloc + GFP_ATOMIC

Francesco Dolcini (1):
      drm/bridge: lt8912b: fix corrupted image output

Frank Wunderlich (1):
      net: usb: qmi_wwan: Add new usb-id for Dell branded EM7455

Graham Sider (3):
      drm/amdkfd: fix MQD init for GFX11 in init_mqd
      drm/amdgpu: pass queue size and is_aql_queue to MES
      drm/amdkfd: fix dropped interrupt in kfd_int_process_v11

Greg Kroah-Hartman (1):
      mm/damon/dbgfs: fix memory leak when using debugfs_lookup()

Guilherme G. Piccoli (1):
      Revert "pstore: migrate to crypto acomp interface"

Haitao Huang (1):
      x86/sgx: Handle VA page allocation failure for EAUG on PF.

Han Xu (1):
      clk: imx: imx6sx: remove the SET_RATE_PARENT flag for QSPI clocks

Hangyu Hua (2):
      net: sched: act_ct: fix possible refcount leak in tcf_ct_init()
      media: dvb_vb2: fix possible out of bound access

Hans Verkuil (2):
      media: v4l2-compat-ioctl32.c: zero buffer passed to
v4l2_compat_get_array_args()
      media: v4l2-ioctl.c: fix incorrect error path

Hans de Goede (1):
      wifi: mac80211: fix regression with non-QoS drivers

Hawking Zhang (8):
      drm/amdgpu: save rlcv/rlcp ucode version in amdgpu_gfx
      drm/amdgpu: add helper to init rlc fw in header v2_0
      drm/amdgpu: add helper to init rlc fw in header v2_1
      drm/amdgpu: add helper to init rlc fw in header v2_2
      drm/amdgpu: add helper to init rlc fw in header v2_3
      drm/amdgpu: add helper to init rlc fw in header v2_4
      drm/amdgpu: add helper to init rlc firmware
      drm/amdgpu/gfx11: switch to amdgpu_gfx_rlc_init_microcode

Heikki Krogerus (1):
      usb: typec: ucsi: Remove incorrect warning

Hongling Zeng (3):
      uas: add no-uas quirk for Hiksemi usb_disk
      usb-storage: Add Hiksemi USB3-FW to IGNORE_UAS
      uas: ignore UAS for Thinkplus chips

Huacai Chen (3):
      irqchip: Select downstream irqchip drivers for LoongArch CPU
      LoongArch: Align the address of kernel_entry to 4KB
      LoongArch: Fix and cleanup csr_era handling in do_ri()

Jan Kara (1):
      ext4: fixup possible uninitialized variable access in
ext4_mb_choose_next_group_cr1()

Jarkko Sakkinen (1):
      x86/sgx: Do not fail on incomplete sanitization on premature stop of =
ksgxd

Jeff LaBundy (1):
      Input: iqs62x-keys - drop unused device node references

Jens Axboe (1):
      io_uring/poll: disable level triggered poll

Jernej Skrabec (1):
      clk: sunxi-ng: h6: Fix default PLL GPU rate

Jiadong.Zhu (2):
      drm/amdgpu: Correct the position in patch_cond_exec
      drm/amdgpu: Remove fence_process in count_emitted

Jianmin Lv (1):
      irqchip/loongson-pch-lpc: Add dependence on LoongArch

Jim Mattson (1):
      KVM: x86: Hide IA32_PLATFORM_DCA_CAP[31:0] from the guest

Jing Zhang (1):
      perf arm-spe: augment the data source type with neoverse_spe list

Jiri Olsa (2):
      perf parse-events: Ignore clang 15 warning about variable set
but unused in bison produced code
      perf tests mmap-basic: Remove unused variable to address clang 15 war=
ning

Johan Hovold (2):
      arm64: dts: qcom: sc7280: move USB wakeup-source property
      arm64: dts: qcom: sm8350: fix UFS PHY serdes size

Junxiao Chang (1):
      net: stmmac: power up/down serdes in stmmac_open/release

Kan Liang (1):
      perf/x86/intel: Fix unchecked MSR access error for Alder Lake N

Kees Cook (1):
      x86/uaccess: avoid check_object_size() in copy_from_user_nmi()

Leo Li (1):
      drm/amd/display: Prevent OTG shutdown during PSR SU

Levi Yun (1):
      damon/sysfs: fix possible memleak on damon_sysfs_add_target

Like Xu (1):
      perf/x86/core: Completely disable guest PEBS via guest's global_ctrl

Linus Torvalds (1):
      Linux 6.0

Linus Walleij (2):
      ARM: dts: integrator: Tag PCI host with device_type
      ARM: dts: integrator: Fix DMA ranges

Lukas Bulwahn (2):
      MAINTAINERS: rectify file entry in TEAM DRIVER
      MAINTAINERS: drop entry to removed file in ARM/RISCPC ARCHITECTURE

Lukas Wunner (1):
      net: phy: Don't WARN for PHY_UP state in mdio_bus_phy_resume()

Maciej Fijalkowski (2):
      ice: xsk: change batched Tx descriptor cleaning
      ice: xsk: drop power of 2 ring size restriction for AF_XDP

Manivannan Sadhasivam (1):
      arm64: dts: qcom: sc8280xp-x13s: Update firmware location

Marc Kleine-Budde (1):
      can: c_can: don't cache TX messages for C_CAN cores

Marek Vasut (2):
      dt-bindings: i2c: st,stm32-i2c: Document interrupt-names property
      dt-bindings: i2c: st,stm32-i2c: Document wakeup-source property

Mario Limonciello (1):
      thunderbolt: Explicitly reset plug events delay back to USB4 spec val=
ue

Mark Pearson (1):
      Input: synaptics - disable Intertouch for Lenovo T14 and P14s AMD G1

Martin Povi=C5=A1er (1):
      ASoC: tas2770: Reinit regcache on reset

Matthew Wilcox (Oracle) (3):
      tools: fix compilation after gfp_types.h split
      mm: fix VM_BUG_ON in __delete_from_swap_cache()
      vmscan: check folio_test_private(), not folio_get_private()

Maurizio Lombardi (1):
      mm: prevent page_frag_alloc() from corrupting the memory

Maxime Coquelin (1):
      vduse: prevent uninitialized memory accesses

Mel Gorman (1):
      mm/page_alloc: fix race condition between build_all_zonelists
and page allocation

Menglong Dong (2):
      mptcp: factor out __mptcp_close() without socket lock
      mptcp: fix unreleased socket in accept queue

Michael Kelley (1):
      nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for nvme devices

Michael Walle (1):
      reset: microchip-sparx5: issue a reset on startup

Minchan Kim (1):
      mm: fix madivse_pageout mishandling on non-LRU page

Nadav Amit (1):
      x86/alternative: Fix race in try_get_desc()

Namhyung Kim (1):
      perf tools: Get a perf cgroup more portably in BPF

Naohiro Aota (1):
      x86/mm: disable instrumentations of mm/pgprot.c

Naoya Horiguchi (1):
      mm/huge_memory: use pfn_to_online_page() in split_huge_pages_all()

Nicholas Kazlauskas (3):
      drm/amd/display: Do DIO FIFO enable after DP video stream enable
      drm/amd/display: Wrap OTG disable workaround with FIFO control
      drm/amd/display: Add explicit FIFO disable for DP blank

Nicolas Dufresne (1):
      media: rkvdec: Disable H.264 error detection

Niklas Cassel (1):
      libata: add ATA_HORKAGE_NOLPM for Pioneer BDR-207M and BDR-205

N=C3=ADcolas F. R. A. Prado (1):
      media: mediatek: vcodec: Drop platform_get_resource(IORESOURCE_IRQ)

Oder Chiou (1):
      ASoC: rt5640: Fix the issue of the abnormal JD2 status

Pali Roh=C3=A1r (1):
      gpio: mvebu: Fix check for pwm support on non-A8K platforms

Patrice Chotard (1):
      usb: dwc3: st: Fix node's child name

Patrick Rohr (1):
      tun: support not enabling carrier in TUNSETIFF

Pawe=C5=82 Lenkow (1):
      wifi: mac80211: fix memory corruption in minstrel_ht_update_rates()

Peilin Ye (1):
      usbnet: Fix memory leak in usbnet_disconnect()

Peng Fan (1):
      clk: imx93: drop of_match_ptr

Peng Wu (1):
      net/mlxbf_gige: Fix an IS_ERR() vs NULL bug in mlxbf_gige_mdio_probe

Philippe Schenker (2):
      drm/bridge: lt8912b: add vsync hsync
      drm/bridge: lt8912b: set hdmi or dvi mode

Pierre Gondois (1):
      irqchip/gic-v3-its: Remove cpumask_var_t allocation

Pierre-Louis Bossart (2):
      ASoC: Intel: sof_sdw: add support for Dell SKU 0AFF
      ALSA: hda: intel-dsp-config: add missing RaptorLake PCI IDs

Radhey Shyam Pandey (1):
      net: macb: Fix ZynqMP SGMII non-wakeup source resume failure

Rafael Mendonca (3):
      cxgb4: fix missing unlock on ETHOFLD desc collect fail path
      wifi: mac80211: mlme: Fix missing unlock on beacon RX
      wifi: mac80211: mlme: Fix double unlock on assoc success handling

Randy Dunlap (1):
      ARM: sunplus: fix serial console kconfig and build problems

Ricardo Ribalda (1):
      media: uvcvideo: Fix InterfaceProtocol for Quanta camera

Richard Zhu (1):
      reset: imx7: Fix the iMX8MP PCIe PHY PERST support

Romain Naour (1):
      ARM: dts: am5748: keep usb4_tm disabled

SJLIN0 (1):
      ASoC: nau8824: Fix semaphore is released unexpectedly

Samson Tam (1):
      drm/amd/display: fill in clock values when DPM is not enabled

Samuel Holland (4):
      soc: sunxi: sram: Actually claim SRAM regions
      soc: sunxi: sram: Prevent the driver from being unbound
      soc: sunxi: sram: Fix probe function ordering issues
      soc: sunxi: sram: Fix debugfs info for A64 SRAM C

Sasha Levin (1):
      Revert "net: mvpp2: debugfs: fix memory leak when using debugfs_looku=
p()"

Sean Christopherson (2):
      KVM: selftests: Implement memcmp(), memcpy(), and memset() for guest =
use
      KVM: selftests: Compare insn opcodes directly in fix_hypercall_test

Sebastian Krzyszkowiak (1):
      Input: snvs_pwrkey - fix SNVS_HPVIDR1 register address

Sergei Antonov (2):
      mmc: moxart: fix 4-bit bus width and remove 8-bit bus width
      mm: bring back update_mmu_cache() to finish_fault()

Shakeel Butt (1):
      Revert "net: set proper memcg for net_init hooks allocations"

Shengjiu Wang (1):
      ASoC: imx-card: Fix refcount issue with of_node_put

Shuai Xue (1):
      mm,hwpoison: check mm when killing accessing process

Sonny Jiang (2):
      drm/amdgpu: Enable VCN DPG for GC11_0_1
      drm/amdgpu: Enable sram on vcn_4_0_2

Steev Klimaszewski (1):
      arm64: dts: qcom: thinkpad-x13s: Fix firmware location

Suwan Kim (1):
      virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()

Taimur Hassan (3):
      drm/amd/display: Avoid avoid unnecessary pixel rate divider programmi=
ng
      drm/amd/display: Fix typo in get_pixel_rate_div
      drm/amd/display: Avoid unnecessary pixel rate divider programming

Tamizh Chelvam Raja (1):
      wifi: cfg80211: fix MCS divisor value

Tina Hsu (1):
      nvme-pci: disable Write Zeroes on Phison E3C/E4C

Tomer Maimon (1):
      reset: npcm: fix iprst2 and iprst4 setting

Tony Luck (1):
      x86/cpu: Add CPU model numbers for Meteor Lake

Ulf Hansson (1):
      Revert "firmware: arm_scmi: Add clock management to the SCMI power do=
main"

Vladimir Oltean (1):
      net: mscc: ocelot: fix tagged VLAN refusal while under a
VLAN-unaware bridge

Wang Yufen (1):
      selftests: Fix the if conditions of in test_extra_filter()

Wenchao Chen (2):
      mmc: sdhci: Fix host->cmd is null
      mmc: hsq: Fix data stomping during mmc recovery

Xuan Zhuo (1):
      virtio_test: fixup for vq reset

Yang Jihong (1):
      perf/core: Fix reentry problem in perf_output_read_group()

Yang Shi (2):
      mm: gup: fix the fast GUP race against THP collapse
      powerpc/64s/radix: don't need to broadcast IPI for radix pmd
collapse flush

Yang Yingliang (1):
      Input: melfas_mip4 - fix return value check in mip4_probe()

Yanteng Si (1):
      LoongArch: Clean up loongson3_smp_ops declaration

YuTong Chang (1):
      ARM: dts: am33xx: Fix MMCHS0 dma properties

Zhang Qilong (1):
      i2c: davinci: fix PM disable depth imbalance in davinci_i2c_probe

Zhengjun Xing (3):
      perf print-events: Fix "perf list" can not display the PMU
prefix for some hybrid cache events
      perf parse-events: Remove "not supported" hybrid cache events
      perf test: Fix test case 87 ("perf record tests") for hybrid systems

Zi Yan (1):
      mm/page_isolation: fix isolate_single_pageblock() isolation behavior

lei he (1):
      virtio-crypto: fix memory-leak

ruanjinjie (1):
      net: hippi: Add missing pci_disable_device() in rr_init_one()
