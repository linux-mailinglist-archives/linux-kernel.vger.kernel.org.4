Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38135BBFF8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 22:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIRU4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 16:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIRU4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 16:56:40 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB76C12763
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 13:56:38 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id l9so5184887lji.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 13:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=R2sduhjjuAljUZpX2Hp+/jZ5v2asrMr6KJHy77qkcrk=;
        b=ZMBAKPKRQHgoFaHdnIKn75xcfjbTpAGCAiwJw58GAUjsGlX5eMSHNpyVIdFUfpX1IB
         BJuFveqaBOqL/QWzLuPpqeWESvdC1do9A/RZUbLMzPN+RAER5eEP2gtO4rf+cN83+xSh
         YQ0ZP9a4817FFoE5QO1ePKy3n9k5nMyLHkoOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=R2sduhjjuAljUZpX2Hp+/jZ5v2asrMr6KJHy77qkcrk=;
        b=ekQp2FOBsAA3ZZ7Ft+3hwGVcBeLsH6zT273On3L/N8WVC8Z3lxQKc3MESSqgaxjSIj
         HtbnFya4u1pHyMx8n72/CjYxhpixxAYXLIrOUq4jYuKsH9MJDjGicBZTwtmj5he/Klvi
         mWWnVEEBrxQBgjdlKt7A8UYVAUwacz7JoHRGag14tEslwuObkviQliAycaViY1x/9CDO
         ie/51HGoWXnx+7WwNTHUspcnXin9EdId9X6hYQWwDXkR27zDdJ1N9yOquONRh7JeJ2qU
         bc/vry4tlC4DP4nCRJ4ulX1+TTLuzu3lu9TSyNyxlorPnqS+M1VLijxbVUEorYYlnTiD
         3vBA==
X-Gm-Message-State: ACrzQf3oLZhfnNzPbHvIvRMfyBlmnfjhDxEJuBljY6/4913zxZSFXQ/g
        Pv9Can8kjhsHpDvTvshW4LmU5FEu1BsbgGbl
X-Google-Smtp-Source: AMsMyM56UQTxRKzEsRNYTvq7BM69mIKR4c7VoGCQVPtDTRlqc287tuL2GN9Rg7iu7etYKAEhl2iqCA==
X-Received: by 2002:a2e:a7ca:0:b0:26c:51d6:55ed with SMTP id x10-20020a2ea7ca000000b0026c51d655edmr160244ljp.426.1663534596299;
        Sun, 18 Sep 2022 13:56:36 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id y26-20020a05651c221a00b0026ad1da0dc3sm4632270ljq.122.2022.09.18.13.56.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 13:56:35 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id a14so29610796ljj.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 13:56:35 -0700 (PDT)
X-Received: by 2002:a2e:7817:0:b0:26c:3e9c:3465 with SMTP id
 t23-20020a2e7817000000b0026c3e9c3465mr2931904ljc.145.1663534594676; Sun, 18
 Sep 2022 13:56:34 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 18 Sep 2022 13:56:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=gtuSO8Yz8LDubkMk7TiMsZxpypt9S10jeZRkyaBFnA@mail.gmail.com>
Message-ID: <CAHk-=wi=gtuSO8Yz8LDubkMk7TiMsZxpypt9S10jeZRkyaBFnA@mail.gmail.com>
Subject: Linux 6.0-rc6
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

So this is an artificially small -rc release, because this past week
we had the Maintainers' Summit in Dublin (along with OSS EU and LPC
2022), so we've had a lot of maintainers traveling.

Or - putting my ridiculously optimistic hat on - maybe things are just
so nice and stable that there just weren't all that many fixes?

Yeah, I know which scenario I'm betting on, but hope springs eternal.

Regardless, things look fine. I am expecting rc7 to be larger than
usual due to pull requests having shifted one week later, and in the
worst case that might mean that I might feel like we need an extra
rc8, but for now I'm going to assume it's not going to be _that_
noticeable and hope we'll just keep to the regular schedule.

But it would be lovely if everybody gave this some extra tender loving
care in the form of extra testing...

             Linus

---

Al Viro (1):
      nfsd_splice_actor(): handle compound pages

Alex Deucher (4):
      drm/amdgpu: add HDP remap functionality to nbio 7.7
      drm/amdgpu: move nbio ih_doorbell_range() into ih code for vega
      drm/amdgpu: move nbio sdma_doorbell_range() into sdma code for vega
      drm/amdgpu: make sure to init common IP before gmc

Alvin Lee (3):
      drm/amd/display: Update MBLK calculation for SubVP
      drm/amd/display: SW cursor fallback for SubVP
      drm/amd/display: Refactor SubVP calculation to remove FPU

Ankit Nautiyal (1):
      drm/i915/vdsc: Set VDSC PIC_HEIGHT before using for DP DSC

Anna Schumaker (1):
      NFSv4.2: Update mode bits after ALLOCATE and DEALLOCATE

Aric Cyr (1):
      drm/amd/display: Fix divide by zero in DML

Ashutosh Dixit (1):
      drm/i915/gt: Fix perf limit reasons bit positions

Aurabindo Pillai (2):
      drm/amd/display: Revert "Fallback to SW cursor if SubVP + cursor too =
big"
      drm/amd/display: add workaround for subvp cursor corruption for DCN32=
/321

Ben Hutchings (1):
      tools/include/uapi: Fix <asm/errno.h> for parisc and xtensa

Candice Li (2):
      drm/amdgpu: Enable full reset when RAS is supported on gc v11_0_0
      drm/amdgpu: Skip reset error status for psp v13_0_0

Chen-Yu Tsai (1):
      drm/panel-edp: Fix delays for Innolux N116BCA-EA1

Christophe JAILLET (1):
      drm/hyperv: Fix an error handling path in hyperv_vmbus_probe()

Dan Aloni (1):
      Revert "SUNRPC: Remove unreachable error condition"

Duncan Ma (1):
      drm/amd/display: Correct dram channel width for dcn314

Guchun Chen (1):
      drm/amd/pm: disable BACO entry/exit completely on several sienna
cichlid cards

Hamza Mahfooz (1):
      drm/amdgpu: use dirty framebuffer helper

Hans de Goede (3):
      drm/gma500: Fix BUG: sleeping function called from invalid context er=
rors
      drm/gma500: Fix WARN_ON(lock->magic !=3D lock) error
      drm/gma500: Fix (vblank) IRQs not working after suspend/resume

Helge Deller (1):
      parisc: Allow CONFIG_64BIT with ARCH=3Dparisc

Horatiu Vultur (1):
      pinctrl: ocelot: Fix interrupt controller

Janne Grunau (1):
      dt-bindings: apple,aic: Fix required item "apple,fiq-index" in
affinity description

Jason Wang (1):
      tools: hv: Remove an extraneous "the"

Jay Fang (1):
      MAINTAINERS: Update HiSilicon GPIO Driver maintainer

Jens Axboe (1):
      io_uring/msg_ring: check file type before putting

Jiangshan Yi (1):
      Input: hp_sdc: fix spelling typo in comment

Jo=C3=A3o H. Spies (1):
      pinctrl: rockchip: Enhance support for IRQ_TYPE_EDGE_BOTH

Krzysztof Kozlowski (3):
      dt-bindings: interconnect: fsl,imx8m-noc: drop Leonard Crestez
      dt-bindings: power: qcom,rpmpd: drop non-working codeaurora.org email=
s
      dt-bindings: pinctrl: qcom: drop non-working codeaurora.org emails

Leo Chen (1):
      drm/amd/display: Fixing DIG FIFO Error

Lijo Lazar (1):
      drm/amdgpu: Don't enable LTR if not supported

Linus Torvalds (1):
      Linux 6.0-rc6

Linus Walleij (1):
      gpio: ixp4xx: Make irqchip immutable

Michael Wu (1):
      pinctrl: sunxi: Fix name for A100 R_PIO

Mikulas Patocka (1):
      blk-lib: fix blkdev_issue_secure_erase

Molly Sophia (2):
      pinctrl: qcom: sc8180x: Fix gpio_wakeirq_map
      pinctrl: qcom: sc8180x: Fix wrong pin numbers

Nathan Chancellor (5):
      drm/amd/display: Reduce number of arguments of
dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport()
      drm/amd/display: Reduce number of arguments of
dml32_CalculatePrefetchSchedule()
      drm/amd/display: Reduce number of arguments of dml31's
CalculateWatermarksAndDRAMSpeedChangeSupport()
      drm/amd/display: Reduce number of arguments of dml31's
CalculateFlipSchedule()
      drm/amd/display: Mark dml30's UseMinimumDCFCLK() as noinline for
stack usage

Nathan Huckleberry (1):
      drm/rockchip: Fix return type of cdn_dp_connector_mode_valid

Neil Armstrong (1):
      MAINTAINERS: Update email of Neil Armstrong

NeilBrown (1):
      NFSD: fix regression with setting ACLs.

Nicholas Kazlauskas (2):
      drm/amd/display: Hook up DCN314 specific dml implementation
      drm/amd/display: Relax swizzle checks for video non-RGB formats on DC=
N314

Nirmoy Das (1):
      drm/i915: Set correct domains values at _i915_vma_move_to_active

Pali Roh=C3=A1r (1):
      gpio: mpc8xxx: Fix support for IRQ_TYPE_LEVEL_LOW flow_type in mpc85x=
x

Paulo Alcantara (1):
      cifs: add missing spinlock around tcon refcount

Pavel Begunkov (2):
      io_uring/rw: fix error'ed retry return values
      io_uring/net: fix zc fixed buf lifetime

Rodrigo Siqueira (2):
      drm/amd/display: Fix compilation errors on DCN314
      drm/amd/display: Enable dlg and vba compilation for dcn314

Rolf Eike Beer (1):
      parisc: remove obsolete manual allocation aligning in iosapic

Ronnie Sahlberg (1):
      cifs: revalidate mapping when doing direct writes

Sascha Hauer (1):
      drm/rockchip: vop2: Fix eDP/HDMI sync polarities

Sergey Shtylyov (1):
      of: fdt: fix off-by-one error in unflatten_dt_nodes()

Sergio Paracuellos (1):
      gpio: mt7621: Make the irqchip immutable

Shaomin Deng (1):
      Drivers: hv: remove duplicate word in a comment

Stefan Metzmacher (3):
      cifs: don't send down the destination address to sendmsg for a SOCK_S=
TREAM
      cifs: always initialize struct msghdr smb_msg completely
      io_uring/opdef: rename SENDZC_NOTIF to SEND_ZC

Stefan Roesch (1):
      block: blk_queue_enter() / __bio_queue_enter() must return
-EAGAIN for nowait

Steve French (1):
      cifs: update internal module number

Stuart Menefy (2):
      drm/meson: Correct OSD1 global alpha value
      drm/meson: Fix OSD1 RGB to YCbCr coefficient

Taimur Hassan (1):
      drm/amd/display: Round cursor width up for MALL allocation

Thierry Reding (1):
      of/device: Fix up of_dma_configure_id() stub

Trond Myklebust (2):
      SUNRPC: Fix call completion races with call_decode()
      NFSv4: Turn off open-by-filehandle and NFS re-export for NFSv4.0

Umesh Nerlige Ramappa (1):
      drm/i915/guc: Cancel GuC engine busyness worker synchronously

Ville Syrj=C3=A4l=C3=A4 (1):
      Revert "drm/i915/display: Re-add check for low voltage sku for
max dp source rate"

Vitaly Kuznetsov (3):
      PCI: Move PCI_VENDOR_ID_MICROSOFT/PCI_DEVICE_ID_HYPERV_VIDEO
definitions to pci_ids.h
      Drivers: hv: Always reserve framebuffer region for Gen1 VMs
      Drivers: hv: Never allocate anything besides framebuffer from
framebuffer memory region

Yang Wang (1):
      drm/amdgpu: change the alignment size of TMR BO to 1M

Yang Yingliang (1):
      parisc: ccio-dma: Add missing iounmap in error path in ccio_probe()

Yao Wang1 (1):
      drm/amd/display: Limit user regamma to a valid value

Zhou jie (1):
      tools: hv: kvp: remove unnecessary (void*) conversions
