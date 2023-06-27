Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6497073F5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjF0HiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjF0Hh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:37:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FDD196
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:37:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8D9A01F8C2;
        Tue, 27 Jun 2023 07:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687851475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qyb6eGX+kWo/2KlAT9Otl5qMd3NG37t3julQmTVAVFg=;
        b=xKtK+I5bgDfyHGMlKJguXS5bmsKDd5hTEH1SPqYLmj//J9UMB5/sViDLQx/QDCSW34sz6s
        81dOCKwKbGt6xz2Uo7FwxsxlJ0IOYWFRHJRO7n/B3F5/YrGdo2O87xg6qBJxwOC9KnfiiU
        rJai7LCPIKpo+GK96QNnlcSDP+RH5ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687851475;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qyb6eGX+kWo/2KlAT9Otl5qMd3NG37t3julQmTVAVFg=;
        b=dUzA23sedc4C6mg6ITAfvbNNQU/vFGqGOsFqFJ7DHHvaiAAMqF+sMSHuqQ7EmXswDNMTXN
        HCxaNrhFCnXNyrCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54BD413462;
        Tue, 27 Jun 2023 07:37:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9PRKE9ORmmTKIAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 27 Jun 2023 07:37:55 +0000
Message-ID: <1c39c9b0-ec37-f910-2b09-cedf7acf6e91@suse.cz>
Date:   Tue, 27 Jun 2023 09:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab updates for 6.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Sterba <dsterba@suse.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest slab updates from:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.5

the changes are summarized below. There will be a (not completely trivial) conflict
with the mm tree. Stephen's resolution [1] is ok; I would personally move the flags
SLAB_NO_MERGE modification hunk above the minalign hunk for better logical separation,
but correctness wise there's no difference.

[1] https://lore.kernel.org/all/20230619140330.28437ac3@canb.auug.org.au/T/#u

======================================

* SLAB deprecation

  Following the discussion at LSF/MM 2023 [1] and no objections, the SLAB
  allocator is deprecated by renaming the config option (to make its users
  notice) to CONFIG_SLAB_DEPRECATED with updated help text. SLUB should be
  used instead. Existing defconfigs with CONFIG_SLAB are also updated.

* SLAB_NO_MERGE kmem_cache flag, by Jesper Dangaard Brouer

  There are (very limited) cases where kmem_cache merging is undesirable, and
  existing ways to prevent it are hacky. Introduce a new flag to do that
  cleanly and convert the existing hacky users. Btrfs plans to use this for
  debug kernel builds (that use case is always fine), networking for
  performance reasons (that should be very rare).

* Replace the usage of weak PRNGs, by David Keisar Schmidt

  In addition to using stronger RNGs for the security related features, the
  code is a bit cleaner.

* Misc code cleanups, by SeongJae Parki, Xiongwei Song, Zhen Lei, and
  zhaoxinchao.

[1] https://lwn.net/Articles/932201/

----------------------------------------------------------------
David Keisar Schmidt (2):
      mm/slab: Replace invocation of weak PRNG
      mm/slab_common: Replace invocation of weak PRNG

Jesper Dangaard Brouer (1):
      mm/slab: introduce kmem_cache flag SLAB_NO_MERGE

SeongJae Park (2):
      mm/slab: add a missing semicolon on SLAB_TYPESAFE_BY_RCU example code
      mm/slab: break up RCU readers on SLAB_TYPESAFE_BY_RCU example code

Vlastimil Babka (4):
      mm/slab: remove HAVE_HARDENED_USERCOPY_ALLOCATOR
      mm/slab: rename CONFIG_SLAB to CONFIG_SLAB_DEPRECATED
      mm/slab_common: use SLAB_NO_MERGE instead of negative refcount
      Merge branches 'slab/for-6.5/prandom', 'slab/for-6.5/slab_no_merge' and 'slab/for-6.5/slab-deprecate' into slab/for-next

Xiongwei Song (5):
      slub: Correct the error code when slab_kset is NULL
      slub: Put objects_show() into CONFIG_SLUB_DEBUG enabled block
      slub: Remove CONFIG_SMP defined check
      slub: Remove slabs_node() function
      slub: Don't read nr_slabs and total_objects directly

Zhen Lei (1):
      mm/slab_common: reduce an if statement in create_cache()

zhaoxinchao (1):
      mm/slab: correct return values in comment for _kmem_cache_create()

 arch/arc/configs/axs103_smp_defconfig           |  1 -
 arch/arc/configs/haps_hs_defconfig              |  1 -
 arch/arc/configs/haps_hs_smp_defconfig          |  1 -
 arch/arc/configs/hsdk_defconfig                 |  1 -
 arch/arc/configs/tb10x_defconfig                |  1 -
 arch/arm/configs/am200epdkit_defconfig          |  1 -
 arch/arm/configs/at91_dt_defconfig              |  1 -
 arch/arm/configs/dove_defconfig                 |  1 -
 arch/arm/configs/ep93xx_defconfig               |  1 -
 arch/arm/configs/imx_v4_v5_defconfig            |  1 -
 arch/arm/configs/lpc32xx_defconfig              |  1 -
 arch/arm/configs/mmp2_defconfig                 |  1 -
 arch/arm/configs/mvebu_v7_defconfig             |  1 -
 arch/arm/configs/nhk8815_defconfig              |  1 -
 arch/arm/configs/omap2plus_defconfig            |  1 -
 arch/arm/configs/pxa168_defconfig               |  1 -
 arch/arm/configs/pxa3xx_defconfig               |  1 -
 arch/arm/configs/pxa910_defconfig               |  1 -
 arch/arm/configs/realview_defconfig             |  1 -
 arch/arm/configs/rpc_defconfig                  |  1 -
 arch/arm/configs/sama5_defconfig                |  1 -
 arch/arm/configs/sama7_defconfig                |  1 -
 arch/arm/configs/shmobile_defconfig             |  1 -
 arch/arm/configs/sp7021_defconfig               |  1 -
 arch/arm/configs/tegra_defconfig                |  1 -
 arch/arm/configs/versatile_defconfig            |  1 -
 arch/m68k/configs/amiga_defconfig               |  1 -
 arch/m68k/configs/apollo_defconfig              |  1 -
 arch/m68k/configs/atari_defconfig               |  1 -
 arch/m68k/configs/bvme6000_defconfig            |  1 -
 arch/m68k/configs/hp300_defconfig               |  1 -
 arch/m68k/configs/mac_defconfig                 |  1 -
 arch/m68k/configs/multi_defconfig               |  1 -
 arch/m68k/configs/mvme147_defconfig             |  1 -
 arch/m68k/configs/mvme16x_defconfig             |  1 -
 arch/m68k/configs/q40_defconfig                 |  1 -
 arch/m68k/configs/sun3_defconfig                |  1 -
 arch/m68k/configs/sun3x_defconfig               |  1 -
 arch/microblaze/configs/mmu_defconfig           |  1 -
 arch/mips/configs/ar7_defconfig                 |  1 -
 arch/mips/configs/bcm47xx_defconfig             |  1 -
 arch/mips/configs/bigsur_defconfig              |  1 -
 arch/mips/configs/cavium_octeon_defconfig       |  1 -
 arch/mips/configs/ci20_defconfig                |  1 -
 arch/mips/configs/cu1000-neo_defconfig          |  1 -
 arch/mips/configs/cu1830-neo_defconfig          |  1 -
 arch/mips/configs/db1xxx_defconfig              |  1 -
 arch/mips/configs/decstation_64_defconfig       |  1 -
 arch/mips/configs/decstation_defconfig          |  1 -
 arch/mips/configs/decstation_r4k_defconfig      |  1 -
 arch/mips/configs/fuloong2e_defconfig           |  1 -
 arch/mips/configs/gpr_defconfig                 |  1 -
 arch/mips/configs/ip22_defconfig                |  1 -
 arch/mips/configs/ip27_defconfig                |  1 -
 arch/mips/configs/ip28_defconfig                |  1 -
 arch/mips/configs/ip32_defconfig                |  1 -
 arch/mips/configs/jazz_defconfig                |  1 -
 arch/mips/configs/malta_defconfig               |  1 -
 arch/mips/configs/malta_kvm_defconfig           |  1 -
 arch/mips/configs/malta_qemu_32r6_defconfig     |  1 -
 arch/mips/configs/maltaaprp_defconfig           |  1 -
 arch/mips/configs/maltasmvp_defconfig           |  1 -
 arch/mips/configs/maltasmvp_eva_defconfig       |  1 -
 arch/mips/configs/maltaup_defconfig             |  1 -
 arch/mips/configs/maltaup_xpa_defconfig         |  1 -
 arch/mips/configs/mtx1_defconfig                |  1 -
 arch/mips/configs/pic32mzda_defconfig           |  1 -
 arch/mips/configs/qi_lb60_defconfig             |  1 -
 arch/mips/configs/rb532_defconfig               |  1 -
 arch/mips/configs/rbtx49xx_defconfig            |  1 -
 arch/mips/configs/rm200_defconfig               |  1 -
 arch/mips/configs/rs90_defconfig                |  1 -
 arch/mips/configs/sb1250_swarm_defconfig        |  1 -
 arch/nios2/configs/10m50_defconfig              |  1 -
 arch/nios2/configs/3c120_defconfig              |  1 -
 arch/parisc/configs/generic-32bit_defconfig     |  1 -
 arch/powerpc/configs/40x/klondike_defconfig     |  1 -
 arch/powerpc/configs/52xx/pcm030_defconfig      |  1 -
 arch/powerpc/configs/83xx/kmeter1_defconfig     |  1 -
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig |  1 -
 arch/powerpc/configs/85xx/ge_imp3a_defconfig    |  1 -
 arch/powerpc/configs/ep8248e_defconfig          |  1 -
 arch/powerpc/configs/gamecube_defconfig         |  1 -
 arch/powerpc/configs/mgcoge_defconfig           |  1 -
 arch/powerpc/configs/mpc512x_defconfig          |  1 -
 arch/powerpc/configs/mpc83xx_defconfig          |  1 -
 arch/powerpc/configs/ps3_defconfig              |  1 -
 arch/powerpc/configs/wii_defconfig              |  1 -
 arch/sh/configs/ap325rxa_defconfig              |  1 -
 arch/sh/configs/apsh4a3a_defconfig              |  1 -
 arch/sh/configs/apsh4ad0a_defconfig             |  1 -
 arch/sh/configs/dreamcast_defconfig             |  1 -
 arch/sh/configs/ecovec24-romimage_defconfig     |  1 -
 arch/sh/configs/ecovec24_defconfig              |  1 -
 arch/sh/configs/espt_defconfig                  |  1 -
 arch/sh/configs/hp6xx_defconfig                 |  1 -
 arch/sh/configs/kfr2r09-romimage_defconfig      |  1 -
 arch/sh/configs/kfr2r09_defconfig               |  1 -
 arch/sh/configs/landisk_defconfig               |  1 -
 arch/sh/configs/lboxre2_defconfig               |  1 -
 arch/sh/configs/magicpanelr2_defconfig          |  1 -
 arch/sh/configs/microdev_defconfig              |  1 -
 arch/sh/configs/migor_defconfig                 |  1 -
 arch/sh/configs/polaris_defconfig               |  1 -
 arch/sh/configs/r7780mp_defconfig               |  1 -
 arch/sh/configs/r7785rp_defconfig               |  1 -
 arch/sh/configs/rsk7264_defconfig               |  1 -
 arch/sh/configs/rsk7269_defconfig               |  1 -
 arch/sh/configs/rts7751r2d1_defconfig           |  1 -
 arch/sh/configs/rts7751r2dplus_defconfig        |  1 -
 arch/sh/configs/sdk7786_defconfig               |  1 -
 arch/sh/configs/se7343_defconfig                |  1 -
 arch/sh/configs/se7619_defconfig                |  1 -
 arch/sh/configs/se7705_defconfig                |  1 -
 arch/sh/configs/se7712_defconfig                |  1 -
 arch/sh/configs/se7721_defconfig                |  1 -
 arch/sh/configs/se7724_defconfig                |  1 -
 arch/sh/configs/se7750_defconfig                |  1 -
 arch/sh/configs/se7751_defconfig                |  1 -
 arch/sh/configs/se7780_defconfig                |  1 -
 arch/sh/configs/secureedge5410_defconfig        |  1 -
 arch/sh/configs/sh03_defconfig                  |  1 -
 arch/sh/configs/sh2007_defconfig                |  1 -
 arch/sh/configs/sh7710voipgw_defconfig          |  1 -
 arch/sh/configs/sh7757lcr_defconfig             |  1 -
 arch/sh/configs/sh7763rdp_defconfig             |  1 -
 arch/sh/configs/sh7785lcr_32bit_defconfig       |  1 -
 arch/sh/configs/sh7785lcr_defconfig             |  1 -
 arch/sh/configs/titan_defconfig                 |  1 -
 arch/sh/configs/urquell_defconfig               |  1 -
 arch/sparc/configs/sparc32_defconfig            |  1 -
 arch/sparc/configs/sparc64_defconfig            |  1 -
 arch/um/configs/i386_defconfig                  |  1 -
 arch/um/configs/x86_64_defconfig                |  1 -
 include/linux/slab.h                            | 22 +++++++++---
 kernel/configs/tiny.config                      |  1 -
 mm/Kconfig                                      | 18 +++++++---
 mm/kfence/kfence_test.c                         |  7 ++--
 mm/slab.c                                       | 37 ++++++-------------
 mm/slab.h                                       | 13 ++-----
 mm/slab_common.c                                | 31 +++++++---------
 mm/slub.c                                       | 47 ++++++++++---------------
 security/Kconfig                                |  8 -----
 143 files changed, 79 insertions(+), 239 deletions(-)
