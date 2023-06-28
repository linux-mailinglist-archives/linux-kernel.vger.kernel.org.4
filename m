Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD64F74073B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 02:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjF1AfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 20:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjF1AfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 20:35:01 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7432941
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 17:34:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b7e6512973so20264205ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 17:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687912498; x=1690504498;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMEwP+DBRTx45HkAh4tlcX5PRgmMIRSwGpPQt8tKYGY=;
        b=grfGmSJ0XpnmjeAhRAzk/BLyjuOtPi0H5etr5q3MQyO9dfSmzPVQBGvUbOtHxUR1vy
         SppWSbQvklTdKmsSd6kEoe8pDOVeZJ9S3EBzLSWcvUFt9UPRvQkvEjJ3RMc1xiB3pUgB
         hEXz5BRay/k5sCHmcamQRmfqxs6f6MClXZ+To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687912498; x=1690504498;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMEwP+DBRTx45HkAh4tlcX5PRgmMIRSwGpPQt8tKYGY=;
        b=fEcpI1sUNCYMUSmh8XHMwDWCSsStELCXfGMAFo1YvcVMMlJip8swhzBJ20qHFbi4jE
         8BucmzxdYnogj4RMd2AKN2qEZzujHFxNl67ZDnADdJII7vLZOF1FSN/gL2VWQ18CUaR1
         Q9GgMvMvR4vEd4JmTEU/p+r+N1LGv/5MfkglRW6MJ/JA12o+73K15nUSRDqKHCXoDxkW
         /iRJWOg5dp54ihJkds/7EE4yx65Rr3rxAFHxXeIHF4DTj8BUtWLwB7hVIRodEkf68dxv
         DMvVg90ilyniRiAU1/e2A8pwIJYPUVEL1isb9hpNmunJCxYQnCSBW/vVEyP7pC6aRQGD
         jMxw==
X-Gm-Message-State: AC+VfDzXoEKPchEZYsL0Bz1oAq6ntEEe7xQTo193hQKMOvwUSZR1H/zr
        uRal78ozcSgCMcoge0/H9g0DIA==
X-Google-Smtp-Source: ACHHUZ5EbazLrSTHEZIWkL4caQ0aZdDSvL12FC3So8Q8BTH+wEGwntwNdDQG5Wwi/R0TtthKEIEObQ==
X-Received: by 2002:a17:902:b608:b0:1b5:fb8:a821 with SMTP id b8-20020a170902b60800b001b50fb8a821mr6799152pls.13.1687912498577;
        Tue, 27 Jun 2023 17:34:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001b69303db65sm6530446plh.26.2023.06.27.17.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 17:34:57 -0700 (PDT)
Date:   Tue, 27 Jun 2023 17:34:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arne Welzel <arne.welzel@corelight.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fangrui Song <maskray@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        John Stultz <jstultz@google.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Simon Horman <simon.horman@corigine.com>,
        Song Liu <song@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [GIT PULL] hardening updates for v6.5-rc1
Message-ID: <202306271729.813C8788@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these hardening updates for v6.5-rc1. There are 3 areas of
note:

- A bunch of strlcpy()->strscpy() conversions ended up living in my tree
  since they were either Acked by maintainers for me to carry, or got
  ignored for multiple weeks (and were trivial changes).

- The compiler option -fstrict-flex-arrays=3 has been enabled globally,
  and has been in -next for the entire devel cycle. This changes compiler
  diagnostics (though mainly just -Warray-bounds which is disabled) and
  potential UBSAN_BOUNDS and FORTIFY _warning_ coverage. In other words,
  there are no new restrictions, just potentially new warnings. Any new
  FORTIFY warnings we've seen have been fixed (usually in their
  respective subsystem trees). For more details, see commit
  df8fc4e934c12b906d08050d7779f292b9c5c6b5.

- The under-development compiler attribute __counted_by has been added
  so that we can start annotating flexible array members with their
  associated structure member that tracks the count of flexible array
  elements at run-time. It is possible (likely?) that the exact syntax
  of the attribute will change before it is finalized, but GCC and Clang
  are working together to sort it out. Any changes can be made to the
  macro while we continue to add annotations. As an example, I have a
  treewide commit waiting with such annotations found via Coccinelle:
  https://git.kernel.org/linus/adc5b3cb48a049563dc673f348eab7b6beba8a9b
  See commit dd06e72e68bcb4070ef211be100d2896e236c8fb for more details.

These and the other updates and fixes are noted below.

Thanks!

-Kees

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.5-rc1

for you to fetch changes up to acf15e07eb06507c69f92394c36052677029b0a8:

  netfilter: ipset: Replace strlcpy with strscpy (2023-06-20 13:35:37 -0700)

----------------------------------------------------------------
hardening updates for v6.5-rc1

- Fix KMSAN vs FORTIFY in strlcpy/strlcat (Alexander Potapenko)

- Convert strreplace() to return string start (Andy Shevchenko)

- Flexible array conversions (Arnd Bergmann, Wyes Karny, Kees Cook)

- Add missing function prototypes seen with W=1 (Arnd Bergmann)

- Fix strscpy() kerndoc typo (Arne Welzel)

- Replace strlcpy() with strscpy() across many subsystems which were
  either Acked by respective maintainers or were trivial changes that
  went ignored for multiple weeks (Azeem Shaikh)

- Remove unneeded cc-option test for UBSAN_TRAP (Nick Desaulniers)

- Add KUnit tests for strcat()-family

- Enable KUnit tests of FORTIFY wrappers under UML

- Add more complete FORTIFY protections for strlcat()

- Add missed disabling of FORTIFY for all arch purgatories.

- Enable -fstrict-flex-arrays=3 globally

- Tightening UBSAN_BOUNDS when using GCC

- Improve checkpatch to check for strcpy, strncpy, and fake flex arrays

- Improve use of const variables in FORTIFY

- Add requested struct_size_t() helper for types not pointers

- Add __counted_by macro for annotating flexible array size members

----------------------------------------------------------------
Alexander Potapenko (1):
      string: use __builtin_memcpy() in strlcpy/strlcat

Andy Shevchenko (3):
      jbd2: Avoid printing outside the boundary of the buffer
      lib/string_helpers: Change returned value of the strreplace()
      kobject: Use return value of strreplace()

Arnd Bergmann (2):
      autofs: use flexible array in ioctl structure
      ubsan: add prototypes for internal functions

Arne Welzel (1):
      fortify: strscpy: Fix flipped q and p docstring typo

Azeem Shaikh (27):
      dlm: Replace all non-returning strlcpy with strscpy
      NFS: Prefer strscpy over strlcpy calls
      vboxsf: Replace all non-returning strlcpy with strscpy
      scsi: ibmvscsi: Replace all non-returning strlcpy with strscpy
      scsi: qedi: Replace all non-returning strlcpy with strscpy
      scsi: bnx2i: Replace all non-returning strlcpy with strscpy
      scsi: aacraid: Replace all non-returning strlcpy with strscpy
      scsi: 3w-9xxx: Replace all non-returning strlcpy with strscpy
      tracing: Replace all non-returning strlcpy with strscpy
      drm/radeon: Replace all non-returning strlcpy with strscpy
      drm/amd/pm: Replace all non-returning strlcpy with strscpy
      befs: Replace all non-returning strlcpy with strscpy
      ftrace: Replace all non-returning strlcpy with strscpy
      drm/display/dp_mst: Replace all non-returning strlcpy with strscpy
      drm/rockchip: Replace all non-returning strlcpy with strscpy
      drm/mediatek: Replace all non-returning strlcpy with strscpy
      drm/sun4i: hdmi: Replace all non-returning strlcpy with strscpy
      drm/i2c: tda998x: Replace all non-returning strlcpy with strscpy
      staging: most: Replace all non-returning strlcpy with strscpy
      clocksource: Replace all non-returning strlcpy with strscpy
      Hexagon: Replace all non-returning strlcpy with strscpy
      sparc64: Replace all non-returning strlcpy with strscpy
      of/flattree: Replace all non-returning strlcpy with strscpy
      sh: Replace all non-returning strlcpy with strscpy
      kallsyms: Replace all non-returning strlcpy with strscpy
      uml: Replace strlcpy with strscpy
      netfilter: ipset: Replace strlcpy with strscpy

Kees Cook (18):
      ubsan: Tighten UBSAN_BOUNDS on GCC
      kunit: tool: Enable CONFIG_FORTIFY_SOURCE under UML
      fortify: Allow KUnit test to build without FORTIFY
      string: Add Kunit tests for strcat() family
      fortify: Use const variables for __member_size tracking
      fortify: Add protection for strlcat()
      fortify: strcat: Move definition to use fortified strlcat()
      kbuild: Enable -fstrict-flex-arrays=3
      overflow: Add struct_size_t() helper
      md/raid5: Convert stripe_head's "dev" to flexible array member
      lkdtm/bugs: Switch from 1-element array to flexible array
      Compiler Attributes: Add __counted_by macro
      checkpatch: Check for strcpy and strncpy too
      x86/purgatory: Do not use fortified string functions
      s390/purgatory: Do not use fortified string functions
      riscv/purgatory: Do not use fortified string functions
      checkpatch: Check for 0-length and 1-element arrays
      um: Use HOST_DIR for mrproper

Nick Desaulniers (1):
      ubsan: remove cc-option test for UBSAN_TRAP

Wyes Karny (1):
      acpi: Replace struct acpi_table_slit 1-element array with flex-array

 Documentation/filesystems/autofs-mount-control.rst |   2 +-
 Documentation/filesystems/autofs.rst               |   2 +-
 MAINTAINERS                                        |   1 +
 Makefile                                           |   6 +
 arch/hexagon/kernel/setup.c                        |   6 +-
 arch/microblaze/kernel/prom.c                      |   2 +-
 arch/riscv/purgatory/Makefile                      |   2 +-
 arch/s390/purgatory/Makefile                       |   2 +-
 arch/sh/drivers/dma/dma-api.c                      |   2 +-
 arch/sh/kernel/setup.c                             |   4 +-
 arch/sparc/kernel/ioport.c                         |   2 +-
 arch/sparc/kernel/setup_32.c                       |   2 +-
 arch/sparc/kernel/setup_64.c                       |   2 +-
 arch/sparc/prom/bootstr_32.c                       |   2 +-
 arch/um/Makefile                                   |   2 +-
 arch/um/include/shared/user.h                      |   1 +
 arch/um/os-Linux/drivers/tuntap_user.c             |   2 +-
 arch/x86/purgatory/Makefile                        |   2 +-
 drivers/gpu/drm/amd/amdgpu/atom.c                  |   2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c     |   2 +-
 drivers/gpu/drm/display/drm_dp_helper.c            |   2 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |   2 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |   2 +-
 drivers/gpu/drm/i2c/tda998x_drv.c                  |   2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c            |   2 +-
 drivers/gpu/drm/radeon/radeon_atombios.c           |   4 +-
 drivers/gpu/drm/radeon/radeon_combios.c            |   4 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c               |   2 +-
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             |   2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c             |   2 +-
 drivers/md/raid5.c                                 |   4 +-
 drivers/md/raid5.h                                 |   2 +-
 drivers/misc/lkdtm/bugs.c                          |   4 +-
 drivers/most/configfs.c                            |   8 +-
 drivers/net/ethernet/intel/ice/ice_ddp.h           |   9 +-
 drivers/nvme/host/fc.c                             |   8 +-
 drivers/scsi/3w-9xxx.c                             |   2 +-
 drivers/scsi/aacraid/aachba.c                      |   2 +-
 drivers/scsi/bnx2i/bnx2i_init.c                    |   2 +-
 drivers/scsi/hptiop.c                              |   4 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c                   |   6 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |  12 +-
 drivers/scsi/megaraid/megaraid_sas_fp.c            |   6 +-
 drivers/scsi/qedi/qedi_main.c                      |   2 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |   2 +-
 fs/befs/btree.c                                    |   2 +-
 fs/befs/linuxvfs.c                                 |   2 +-
 fs/dlm/config.c                                    |   4 +-
 fs/jbd2/journal.c                                  |   6 +-
 fs/nfs/nfsroot.c                                   |   2 +-
 fs/vboxsf/super.c                                  |   2 +-
 fs/xfs/libxfs/xfs_btree.h                          |   2 +-
 fs/xfs/scrub/btree.h                               |   2 +-
 include/acpi/actbl3.h                              |   2 +-
 include/linux/compiler_attributes.h                |  13 ++
 include/linux/fortify-string.h                     | 161 ++++++++++++++-------
 include/linux/overflow.h                           |  18 ++-
 include/linux/string.h                             |   2 +-
 include/uapi/linux/auto_dev-ioctl.h                |   2 +-
 kernel/kallsyms.c                                  |   4 +-
 kernel/params.c                                    |   2 +-
 kernel/time/clocksource.c                          |   2 +-
 kernel/trace/ftrace.c                              |  18 +--
 kernel/trace/trace.c                               |   8 +-
 kernel/trace/trace_events.c                        |   4 +-
 kernel/trace/trace_events_inject.c                 |   4 +-
 kernel/trace/trace_kprobe.c                        |   2 +-
 kernel/trace/trace_probe.c                         |   2 +-
 lib/Kconfig.debug                                  |   7 +-
 lib/Kconfig.ubsan                                  |  57 ++++----
 lib/Makefile                                       |   1 +
 lib/fortify_kunit.c                                |  14 ++
 lib/kobject.c                                      |   3 +-
 lib/overflow_kunit.c                               |   2 +-
 lib/strcat_kunit.c                                 | 104 +++++++++++++
 lib/string.c                                       |   4 +-
 lib/string_helpers.c                               |  12 +-
 lib/ubsan.c                                        |   3 -
 lib/ubsan.h                                        |  11 ++
 net/netfilter/ipset/ip_set_hash_netiface.c         |  10 +-
 scripts/Makefile.ubsan                             |   2 +-
 scripts/checkpatch.pl                              |  24 ++-
 tools/testing/kunit/configs/all_tests.config       |   2 +
 tools/testing/kunit/configs/arch_uml.config        |   3 +
 84 files changed, 467 insertions(+), 203 deletions(-)
 create mode 100644 lib/strcat_kunit.c

-- 
Kees Cook
