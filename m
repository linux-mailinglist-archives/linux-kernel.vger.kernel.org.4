Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B7E72B43E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 23:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjFKVx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 17:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFKVx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 17:53:27 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3512CD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 14:53:24 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9768fd99c0cso988573366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686520403; x=1689112403;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B0uh1ICDSHqNv0P6yk8gderJT5zJQoae361S5GrKjJ8=;
        b=g05/IY+8ssZvJLGJ1ubtndoNszPqXbEMSWi1O3wQzYGjgTMrwTR2+TItN7MEDpm5J+
         Z5vGnMfbNpGFp/lvza/tYtMS+SjNjWInDeSeg5mTZtVEWUkvTqmXPyNvbvurM0fjE2rx
         mNEU6NkZ0YixYRsqd9FWNmMKCqdVuOcrEG4hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686520403; x=1689112403;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0uh1ICDSHqNv0P6yk8gderJT5zJQoae361S5GrKjJ8=;
        b=BHiVSRTFAjDdQUgnE/PgfSIsMblp8LDTlItpUp1v6Th76N/VmBdXNgFNTA/F6nZ6WA
         7ZPpvrFQb3YwBpvrMyvLLtpwfwrIvPvoqg3UdIoGCRJNFc6aPN65fUgizjmAvg4zBFpf
         k2vDQLaukK7c5AXz54tenUbf74bEL8m0kkZogJwvOyhs0x06MJkDvsucVuOMbLsYK3uD
         vvtxJtH4mwOR1SPYLeTRCHo2eXIUTwRjIEYzMImkwCNZsJk8iXZGqpfZC/hMcKAezLxY
         uFXM6bDCK0P5riNE0dpMJdeqCqtB3WQUL0g1N2y+Q1/+01warcX5V8AvqPcZAygqHdZC
         4Efg==
X-Gm-Message-State: AC+VfDwfVYniaX12ZlXeQO5D5ofSRma0snTtrEqZ3L5wf2up8jgXKl0i
        PyNEQ1Khghkw2GuKSlQOiKoRL7wyRIvG6bALh+w=
X-Google-Smtp-Source: ACHHUZ6pIPsZ/QQ3H2I7bgYUER40IueFVlCk8yLzIUqzUOxtrBgRfC8cCIOOpf/sBg9x2nYUpSoX5w==
X-Received: by 2002:a17:907:2da1:b0:973:84b0:b077 with SMTP id gt33-20020a1709072da100b0097384b0b077mr8348217ejc.33.1686520402307;
        Sun, 11 Jun 2023 14:53:22 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id gt26-20020a170906f21a00b009600ce4fb53sm4298528ejb.37.2023.06.11.14.53.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 14:53:21 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5169f920a9dso7647329a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 14:53:21 -0700 (PDT)
X-Received: by 2002:aa7:d313:0:b0:50d:89d5:bf95 with SMTP id
 p19-20020aa7d313000000b0050d89d5bf95mr3861542edq.20.1686520399817; Sun, 11
 Jun 2023 14:53:19 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 11 Jun 2023 14:53:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmbjQu3bVSa5JJhEymeQhkr7N3cjg-CoNLVituUnfW8w@mail.gmail.com>
Message-ID: <CAHk-=wgmbjQu3bVSa5JJhEymeQhkr7N3cjg-CoNLVituUnfW8w@mail.gmail.com>
Subject: Linux 6.4-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's Sunday afternoon, and we all know what that means.

I don't think we've had anything hugely interesting happen the last
week, and the whole 6.4 release really does feel like it's going
fairly smoothly. Knock wood, famous last words, you know the drill.

The diffstat and the commit logs all looks fairly normal. We've got
perhaps a bit more filesystem changes than usual, mostly due to some
xfs fixes. But even that looks larger than it is - it's mostly due to
code movement, not because of any fundamentally big changes per se.

There's some architecture fixes too, but most of that is just arm64 dts fil=
es.

And the bulk of things is driver updates, with gpu and networking
being most noticeable. As is tradition. We have some other networking
changes outside of drivers too.

For people interested in the nitty-gritty details, the shortlog is
appended, but nothing there looks all that interesting. Which is
obviously just how I like it. The interesting stuff should happen
during the merge window, and the later release candidates should be as
boring as possible.

                  Linus

---

Abel Vesa (1):
      soc: qcom: Rename ice to qcom_ice to avoid module name conflict

Abhinav Kumar (1):
      drm/msm/dp: add module parameter for PSR

Adam Ford (1):
      arm64: dts: imx8mn-beacon: Fix SPI CS pinmux

Aditya Kumar Singh (1):
      wifi: mac80211: fix switch count in EMA beacons

Ai Chao (1):
      ALSA: hda/realtek: Add a quirk for HP Slim Desktop S01

Akihiro Suda (1):
      net/ipv4: ping_group_range: allow GID from 2147483648 to 4294967294

Alex Deucher (3):
      Revert "drm/amdgpu: change the reference clock for raven/raven2"
      Revert "drm/amdgpu: Differentiate between Raven2 and
Raven/Picasso according to revision id"
      Revert "drm/amdgpu: switch to golden tsc registers for raven/raven2"

Alexander Gordeev (1):
      s390/purgatory: disable branch profiling

Alexander Sverdlin (1):
      net: dsa: lan9303: allow vid !=3D 0 in port_fdb_{add|del} methods

Alexandre Ghiti (2):
      riscv: Fix kfence now that the linear mapping can be backed by PUD/P4=
D/PGD
      riscv: Check the virtual alignment before choosing a map size

Alvin Lee (1):
      drm/amd/display: Reduce sdp bw after urgent to 90%

Andi Shyti (2):
      MAINTAINERS: Add myself as I2C host drivers maintainer
      drm/i915/gt: Use the correct error value when kernel_context() fails

Andreas Gruenbacher (1):
      gfs2: Don't get stuck writing page onto itself under direct I/O

Andrey Smetanin (1):
      vhost_net: revert upend_idx only on retriable error

Andrzej Kacprowski (2):
      accel/ivpu: Do not trigger extra VPU reset if the VPU is idle
      accel/ivpu: Fix sporadic VPU boot failure

Arnd Bergmann (1):
      net: dsa: qca8k: add CONFIG_LEDS_TRIGGERS dependency

Balint Dobszay (1):
      firmware: arm_ffa: Set handle field to zero in memory descriptor

Bartosz Golaszewski (2):
      net: stmmac: dwmac-qcom-ethqos: fix a regression on EMAC < 3
      MAINTAINERS: add Andy Shevchenko as reviewer for the GPIO subsystem

Ben Hutchings (1):
      lib: cpu_rmap: Fix potential use-after-free in irq_cpu_rmap_release()

Benjamin Tissoires (1):
      HID: hidpp: terminate retry loop on success

Biju Das (1):
      MAINTAINERS: Add entries for Renesas RZ/V2M I2C driver

Bjorn Andersson (1):
      arm64: dts: qcom: sc8280xp: Flush RSC sleep & wake votes

Brett Creeley (2):
      pds_core: Fix FW recovery detection
      virtio_net: use control_buf for coalesce params

Catalin Marinas (1):
      arm64: Remove the ARCH_FORCE_MAX_ORDER config input prompt

Chaitanya Kumar Borah (1):
      drm/i915/display: Set correct voltage level for 480MHz CDCLK

Chancel Liu (1):
      ASoC: fsl_sai: Enable BCI bit if SAI works on synchronous mode
with BYP asserted

Charles Keepax (1):
      soundwire: stream: Add missing clear of alloc_slave_rt

Chia-I Wu (1):
      drm/amdgpu: fix xclk freq on CHIP_STONEY

Chris Chiu (1):
      ALSA: hda/realtek: Enable 4 amplifiers instead of 2 on a HP platform

Christian Heusel (1):
      i2c: img-scb: Fix spelling mistake "innacurate" -> "inaccurate"

Christophe JAILLET (1):
      soc: qcom: ramp_controller: Fix an error handling path in
qcom_ramp_controller_probe()

Clark Wang (1):
      spi: lpspi: disable lpspi module irq in DMA mode

Claudiu Beznea (2):
      ARM: at91: pm: fix imbalanced reference counter for ethernet devices
      ARM: dts: at91: sama7g5ek: fix debounce delay property for shdwc

Dan Carpenter (1):
      soc: qcom: rmtfs: Fix error code in probe()

Dan Schatzberg (1):
      cgroup: Documentation: Clarify usage of memory limits

Daniel Golle (1):
      spi: mt65xx: make sure operations completed before unloading

Darrick J. Wong (1):
      xfs: fix broken logic when detecting mergeable bmap records

Dave Chinner (9):
      xfs: buffer pins need to hold a buffer reference
      xfs: restore allocation trylock iteration
      xfs: defered work could create precommits
      xfs: fix AGF vs inode cluster buffer deadlock
      xfs: fix double xfs_perag_rele() in xfs_filestream_pick_ag()
      xfs: fix agf/agfl verification on v4 filesystems
      xfs: validity check agbnos on the AGFL
      xfs: validate block number being freed before adding to xefi
      xfs: collect errors from inodegc for unlinked inode recovery

David Howells (1):
      afs: Fix setting of mtime when creating a file/dir/symlink

David Zheng (1):
      i2c: designware: fix idx_write_cnt in read loop

Dmitry Baryshkov (1):
      drm/msm/a6xx: initialize GMU mutex earlier

Dmitry Torokhov (2):
      Input: fix open count when closing inhibited device
      Input: psmouse - fix OOB access in Elantech protocol

Douglas Anderson (1):
      arm64: dts: qcom: sc7180-lite: Fix SDRAM freq for misidentified
sc7180-lite boards

Dragos Tatulea (1):
      vdpa/mlx5: Fix hang when cvq commands are triggered during
device unregister

Edson Juliano Drosdeck (1):
      ASoC: nau8824: Add quirk to active-high jack-detect

Eelco Chaudron (1):
      net: openvswitch: fix upcall counter access before allocation

Eric Dumazet (10):
      bpf, sockmap: Avoid potential NULL dereference in
sk_psock_verdict_data_ready()
      net/ipv6: fix bool/int mismatch for skip_notify_on_dev_down
      net/ipv6: convert skip_notify_on_dev_down sysctl to u8
      net/sched: fq_pie: ensure reasonable TCA_FQ_PIE_QUANTUM values
      tcp: gso: really support BIG TCP
      rfs: annotate lockless accesses to sk->sk_rxhash
      rfs: annotate lockless accesses to RFS sock flow table
      net: sched: add rcu annotations around qdisc->qdisc_sleeping
      net: sched: move rtm_tca_policy declaration to include file
      net: sched: act_police: fix sparse errors in tcf_police_dump()

Erico Nunes (1):
      drm/lima: fix sched context destroy

Evan Quan (1):
      drm/amd/pm: conditionally disable pcie lane switching for some
sienna_cichlid SKUs

Fedor Pchelkin (2):
      can: j1939: change j1939_netdev_lock type to mutex
      can: j1939: avoid possible use-after-free when j1939_can_rx_register =
fails

Florian Fainelli (1):
      net: bcmgenet: Fix EEE implementation

Florian Westphal (1):
      bpf: netfilter: Add BPF_NETFILTER bpf_attach_type

Gavrilov Ilia (1):
      netfilter: nf_tables: Add null check for nla_nest_start_noflag()
in nft_dump_basechain_hook()

Geert Uytterhoeven (2):
      drm/fb-helper: Fix height, width, and accel_flags in fb_var
      xfs: Fix undefined behavior of shift into sign bit

Geliang Tang (5):
      mptcp: only send RM_ADDR in nl_cmd_remove
      selftests: mptcp: update userspace pm addr tests
      mptcp: add address into userspace pm list
      selftests: mptcp: update userspace pm subflow tests
      mptcp: update userspace pm infos

Gustavo A. R. Silva (1):
      wifi: iwlwifi: mvm: Fix -Warray-bounds bug in iwl_mvm_wait_d3_notif()

Hangyu Hua (1):
      net: sched: fix possible refcount leak in tc_chain_tmplt_add()

Hans de Goede (1):
      Input: soc_button_array - add invalid acpi_index DMI quirk handling

Hao Yao (1):
      platform/x86: int3472: Avoid crash in unregistering regulator gpio

Herve Codina (1):
      ASoC: simple-card: Add missing of_node_put() in case of error

Horatio Zhang (1):
      drm/amdgpu: fix Null pointer dereference error in
amdgpu_device_recover_vram

Hsieh-Tseng Shen (1):
      riscv: mm: Ensure prot of VM_WRITE and VM_EXEC must be readable

Ilya Dryomov (2):
      rbd: move RBD_OBJ_FLAG_COPYUP_ENABLED flag setting
      rbd: get snapshot context after exclusive lock is ensured to be held

Inki Dae (1):
      drm/exynos: vidi: fix a wrong error return

Ismael Ferreras Morezuelas (1):
      Input: xpad - delete a Razer DeathAdder mouse VID/PID entry

Jakub Kicinski (3):
      netlink: specs: ethtool: fix random typos
      eth: bnxt: fix the wake condition
      eth: ixgbe: fix the wake condition

Jammy Huang (2):
      drm/ast: Fix long time waiting on s3/s4 resume
      drm/ast: Fix modeset failed on DisplayPort

Jan H=C3=B6ppner (1):
      s390/dasd: Use correct lock while counting channel queue length

Jaroslav Kysela (1):
      ALSA: ice1712,ice1724: fix the kcontrol->id initialization

Jeremy Sowden (1):
      netfilter: nft_bitwise: fix register tracking

Jiasheng Jiang (1):
      net: systemport: Replace platform_get_irq with platform_get_irq_optio=
nal

Jiri Olsa (1):
      bpf: Add extra path pointer check to d_path helper

Jisheng Zhang (1):
      arm64: mm: pass original fault address to handle_mm_fault() in
PER_VMA_LOCK block

Johan Hovold (2):
      Bluetooth: fix debugfs registration
      Bluetooth: hci_qca: fix debugfs registration

Johannes Berg (6):
      wifi: mac80211: use correct iftype HE cap
      wifi: cfg80211: reject bad AP MLD address
      wifi: mac80211: mlme: fix non-inheritence element
      wifi: mac80211: don't translate beacon/presp addrs
      wifi: cfg80211: fix locking in sched scan stop work
      wifi: cfg80211: fix locking in regulatory disconnect

John Sperbeck (1):
      cgroup: always put cset in cgroup_css_set_put_fork

Jouni H=C3=B6gander (1):
      drm/i915: Use 18 fast wake AUX sync len

KP Singh (1):
      bpf: Fix UAF in task local storage

Kent Gibson (2):
      gpio: sim: fix memory corruption when adding named lines and unnamed =
hogs
      gpio: sim: quietly ignore configured lines outside the bank

Konrad Dybcio (6):
      arm64: dts: qcom: sm6375-pdx225: Fix remoteproc firmware paths
      dt-bindings: power: qcom,rpmpd: Add SA8155P
      arm64: dts: qcom: Split out SA8155P and use correct RPMh power domain=
s
      soc: qcom: rpmhpd: Add SA8155P power domains
      dt-bindings: cache: qcom,llcc: Fix SM8550 description
      arm64: dts: qcom: sm8550: Use the correct LLCC register scheme

Krzysztof Kozlowski (16):
      soc: qcom: icc-bwmon: fix incorrect error code passed to dev_err_prob=
e()
      soc: qcom: rpmh-rsc: drop redundant unsigned >=3D0 comparision
      arm64: dts: qcom: sc8280xp: Revert "arm64: dts: qcom: sc8280xp:
remove superfluous "input-enable""
      arm64: dts: qcom: sc7280-idp: drop incorrect dai-cells from WCD938x S=
DW
      arm64: dts: qcom: sc7280-qcard: drop incorrect dai-cells from WCD938x=
 SDW
      arm64: dts: qcom: sm8250-xiaomi-elish-boe: fix panel compatible
      arm64: dts: qcom: sm8250-xiaomi-elish-csot: fix panel compatible
      ARM: dts: qcom: apq8026: remove superfluous "input-enable"
      ARM: dts: qcom: mdm9615: remove superfluous "input-enable"
      ARM: dts: qcom: msm8974: remove superfluous "input-enable"
      arm64: dts: qcom: fix indentation
      arm64: dts: qcom: use decimal for cache level
      arm64: dts: qcom: add missing cache properties
      ARM: dts: qcom: add missing cache properties
      arm64: dts: qcom: sm8550: use uint16 for Soundwire interval
      soundwire: qcom: add proper error paths in qcom_swrm_startup()

Kuniyuki Iwashima (2):
      netfilter: ipset: Add schedule point in call_ad().
      ipv6: rpl: Fix Route of Death.

Kuogee Hsieh (1):
      drm/msm/dp: enable HDP plugin/unplugged interrupts at hpd_enable/disa=
ble

Lijo Lazar (1):
      drm/amd/pm: Fix power context allocation in SMU13

Linus Torvalds (1):
      Linux 6.4-rc6

Linus Walleij (1):
      ARM: dts: Fix erroneous ADS touchscreen polarities

Lorenzo Bianconi (2):
      wifi: mt76: mt7615: fix possible race in mt7615_mac_sta_poll
      wifi: mt76: mt7996: fix possible NULL pointer dereference in
mt7996_mac_write_txwi()

Luiz Augusto von Dentz (1):
      Bluetooth: Fix use-after-free in hci_remove_ltk/hci_remove_irk

Manish Chopra (1):
      qed/qede: Fix scheduling while atomic

Manivannan Sadhasivam (2):
      EDAC/qcom: Remove superfluous return variable assignment in
qcom_llcc_core_setup()
      EDAC/qcom: Get rid of hardcoded register offsets

Marek Beh=C3=BAn (1):
      i2c: mv64xxx: Fix reading invalid status value in atomic mode

Mario Limonciello (2):
      drm/amd: Disallow s0ix without BIOS support again
      drm/amd: Make lack of `ACPI_FADT_LOW_POWER_S0` or
`CONFIG_AMD_PMC` louder during suspend path

Martin Hundeb=C3=B8ll (1):
      pinctrl: meson-axg: add missing GPIOA_18 gpio group

Maximilian Luz (4):
      platform/surface: aggregator: Make to_ssam_device_driver()
respect constness
      platform/surface: aggregator: Allow completion work-items to be
executed in parallel
      platform/surface: aggregator_tabletsw: Add support for book mode
in KIP subsystem
      platform/surface: aggregator_tabletsw: Add support for book mode
in POS subsystem

Maximilian Weigand (1):
      Input: cyttsp5 - fix array length

Michal Schmidt (1):
      ice: make writes to /dev/gnssX synchronous

Mike Christie (2):
      vhost: Fix crash during early vhost_transport_send_pkt calls
      vhost: Fix worker hangs due to missed wake up calls

Min Li (2):
      drm/exynos: fix race condition UAF in exynos_g2d_exec_ioctl
      drm/radeon: fix race condition UAF in radeon_gem_set_domain_ioctl

Min-Hua Chen (1):
      net: sched: wrap tc_skip_wrapper with CONFIG_RETPOLINE

Mirsad Goran Todorovac (1):
      selftests: alsa: pcm-test: Fix compiler warnings about the format

Namjae Jeon (5):
      ksmbd: fix out-of-bound read in deassemble_neg_contexts()
      ksmbd: fix out-of-bound read in parse_lease_state()
      ksmbd: fix posix_acls and acls dereferencing possible ERR_PTR()
      ksmbd: check the validation of pdu_size in ksmbd_conn_handler_loop
      ksmbd: validate smb request protocol id

Nitesh Shetty (1):
      null_blk: Fix: memory release when memory_backed=3D1

Oleksij Rempel (1):
      can: j1939: j1939_sk_send_loop_abort(): improved error queue
handling in J1939 Socket

Pablo Neira Ayuso (1):
      netfilter: nf_tables: out-of-bound check in chain blob

Pauli Virtanen (4):
      Bluetooth: ISO: consider right CIS when removing CIG at cleanup
      Bluetooth: ISO: Fix CIG auto-allocation to select configurable CIG
      Bluetooth: ISO: don't try to remove CIG if there are bound CIS left
      Bluetooth: ISO: use correct CIS order in Set CIG Parameters event

Pavan Chebbi (2):
      bnxt_en: Fix bnxt_hwrm_update_rss_hash_cfg()
      bnxt_en: Prevent kernel panic when receiving unexpected PHC_UPDATE ev=
ent

Pierre-Louis Bossart (1):
      soundwire: dmi-quirks: add new mapping for HP Spectre x360

Ping-Ke Shih (3):
      wifi: rtw88: correct PS calculation for SUPPORTS_DYNAMIC_PS
      wifi: rtw89: correct PS calculation for SUPPORTS_DYNAMIC_PS
      wifi: rtw89: remove redundant check of entering LPS

Prathu Baronia (1):
      vhost: use kzalloc() instead of kmalloc() followed by memset()

Qi Zheng (1):
      cgroup: fix missing cpus_read_{lock,unlock}() in cgroup_transfer_task=
s()

Qingfang DENG (1):
      neighbour: fix unaligned access to pneigh_entry

Randy Dunlap (2):
      accel/ivpu: ivpu_ipc needs GENERIC_ALLOCATOR
      eeprom: at24: also select REGMAP

RenHai (1):
      ALSA: hda/realtek: Add Lenovo P3 Tower platform

Rhys Rustad-Elliott (2):
      bpf: Fix elem_size not being set for inner maps
      selftests/bpf: Add access_inner_map selftest

Richard Fitzgerald (1):
      ASoC: cs35l56: Remove NULL check from cs35l56_sdw_dai_set_stream()

Rijo Thomas (1):
      tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'

Rob Clark (1):
      drm/msm: Set max segment size earlier

Robert Hancock (1):
      ASoC: simple-card-utils: fix PCM constraint error check

Roberto Sassu (1):
      KEYS: asymmetric: Copy sig and digest in public_key_verify_signature(=
)

Rong Tao (2):
      tools/virtio: Fix arm64 ringtest compilation error
      tools/virtio: Add .gitignore for ringtest

Ross Zwisler (1):
      tools/virtio: use canonical ftrace path

Ruan Jinjie (1):
      riscv: fix kprobe __user string arg print fault issue

Russell King (Oracle) (1):
      net: phylink: actually fix ksettings_set() ethtool call

Ryan Lee (2):
      ASoC: max98363: Removed 32bit support
      ASoC: max98363: limit the number of channel to 1

Samson Tam (1):
      drm/amd/display: add ODM case when looking for first split pipe

Sayed, Karimuddin (1):
      ALSA: hda/realtek: Add "Intel Reference board" and "NUC 13" SSID
in the ALC256

Shannon Nelson (3):
      vhost_vdpa: tell vqs about the negotiated
      vhost: support PACKED when setting-getting vring_base
      vhost_vdpa: support PACKED when setting-getting vring_base

Sheng Zhao (1):
      vduse: avoid empty string for dev name

Shenwei Wang (2):
      arm64: dts: imx8qm-mek: correct GPIOs for USDHC2 CD and WP signals
      arm64: dts: imx8-ss-dma: assign default clock rate for lpuarts

Sicong Jiang (1):
      ASoC: amd: yc: Add Thinkpad Neo14 to quirks list for acp6x

Simon Horman (1):
      i2c: mchp-pci1xxxx: Avoid cast to incompatible function type

Somnath Kotur (2):
      bnxt_en: Query default VLAN before VNIC setup on a VF
      bnxt_en: Implement .set_port / .unset_port UDP tunnel callbacks

Sreekanth Reddy (1):
      bnxt_en: Don't issue AP reset during ethtool's reset operation

Srinivas Kandagatla (3):
      ASoC: codecs: wsa883x: do not set can_multi_write flag
      ASoC: codecs: wsa881x: do not set can_multi_write flag
      ASoC: codecs: wcd938x-sdw: do not set can_multi_write flag

Stanislaw Gruszka (2):
      accel/ivpu: Reserve all non-command bo's using DMA_RESV_USAGE_BOOKKEE=
P
      accel/ivpu: Do not use mutex_lock_interruptible

Stefan Binding (1):
      ALSA: hda/realtek: Add quirks for Asus ROG 2024 laptops using CS35L41

Stephan Gerhold (1):
      spi: qup: Request DMA before enabling clocks

Sungwoo Kim (1):
      Bluetooth: L2CAP: Add missing checks for invalid DCID

Takashi Iwai (4):
      ALSA: ymfpci: Fix kctl->id initialization
      ALSA: cmipci: Fix kctl->id initialization
      ALSA: gus: Fix kctl->id initialization
      ALSA: hda: Fix kctl->id initialization

Theodore Ts'o (2):
      Revert "ext4: don't clear SB_RDONLY when remounting r/w until
quota is re-enabled"
      ext4: only check dquot_initialize_needed() when debugging

Thomas Gleixner (1):
      MAINTAINERS: Add entry for debug objects

Tian Lan (1):
      blk-mq: fix blk_mq_hw_ctx active request accounting

Tijs Van Buggenhout (1):
      netfilter: conntrack: fix NULL pointer dereference in nf_confirm_cthe=
lper

Tim Crawford (1):
      ALSA: hda/realtek: Add quirk for Clevo NS50AU

Tom Lendacky (1):
      x86/head/64: Switch to KERNEL_CS as soon as new GDT is installed

Trevor Wu (2):
      ASoC: mediatek: mt8188: fix use-after-free in driver remove path
      ASoC: mediatek: mt8195: fix use-after-free in driver remove path

Tvrtko Ursulin (1):
      drm/i915/selftests: Add some missing error propagation

Uwe Kleine-K=C3=B6nig (1):
      i2c: sprd: Delete i2c adapter in .remove's error path

Vijendar Mukunda (1):
      ASoC: amd: ps: fix for acp_lock access in pdm driver

Vikas Gupta (1):
      bnxt_en: Skip firmware fatal error recovery if chip is not accessible

Vineeth Vijayan (1):
      s390/cio: unregister device when the only path is gone

Vladislav Efanov (1):
      batman-adv: Broken sync while rescheduling delayed work

Wei Fang (2):
      net: enetc: correct the statistics of rx bytes
      net: enetc: correct rx_bytes statistics of XDP

Weihao Gao (1):
      Fix gitignore for recently added usptream self tests

Wen Gu (1):
      net/smc: Avoid to access invalid RMBs' MRs in SMCRv1 ADD LINK CONT

Xiubo Li (1):
      ceph: fix use-after-free bug for inodes when flushing capsnaps

YiPeng Chai (1):
      drm/amdgpu: change reserved vram info print

Ying Hsu (1):
      Bluetooth: Fix l2cap_disconnect_req deadlock

Yonghong Song (1):
      selftests/bpf: Fix sockopt_sk selftest

Zhengping Jiang (1):
      Bluetooth: hci_sync: add lock to protect HCI_UNREGISTER
