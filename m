Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD2C64C4D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbiLNIPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiLNIPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:15:32 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40160CC;
        Wed, 14 Dec 2022 00:15:29 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p5MvC-00761O-9G; Wed, 14 Dec 2022 16:15:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 14 Dec 2022 16:15:22 +0800
Date:   Wed, 14 Dec 2022 16:15:22 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Update for 6.2
Message-ID: <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
References: <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

The following changes since commit 9f6035af06b526e678808d492fc0830aef6cfbd8:

  crypto: x86/polyval - Fix crashes when keys are not 16-byte aligned (2022-10-21 19:05:05 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.2-p1 

for you to fetch changes up to 453de3eb08c4b7e31b3019a4b0cc3ebce51a6219:

  crypto: ux500/cryp - delete driver (2022-12-09 18:45:01 +0800)

----------------------------------------------------------------
This update includes the following changes:

API:

- Optimise away self-test overhead when they are disabled.
- Support symmetric encryption via keyring keys in af_alg.
- Flip hwrng default_quality, the default is now maximum entropy.

Algorithms:

- Add library version of aesgcm.
- CFI fixes for assembly code.
- Add arm/arm64 accelerated versions of sm3/sm4.

Drivers:

- Remove assumption on arm64 that kmalloc is DMA-aligned.
- Fix selftest failures in rockchip.
- Add support for RK3328/RK3399 in rockchip.
- Add deflate support in qat.
- Merge ux500 into stm32.
- Add support for TEE for PCI ID 0x14CA in ccp.
- Add mt7986 support in mtk.
- Add MaxLinear platform support in inside-secure.
- Add NPCM8XX support in npcm.

----------------------------------------------------------------
Angel Iglesias (1):
      i2c: core: Introduce i2c_client_get_device_id helper function

Anirudh Venkataramanan (4):
      crypto: tcrypt - Use pr_cont to print test results
      crypto: tcrypt - Use pr_info/pr_err
      crypto: tcrypt - Drop module name from print string
      crypto: tcrypt - Drop leading newlines from prints

Ard Biesheuvel (7):
      crypto: move gf128mul library into lib/crypto
      crypto: lib/gf128mul - make gf128mul_lle time invariant
      crypto: lib/aesgcm - Provide minimal library implementation
      crypto: arm64/aes-neonbs - use frame_push/pop consistently
      crypto: arm64/aes-modes - use frame_push/pop macros consistently
      crypto: arm64/crct10dif - use frame_push/pop macros consistently
      crypto: arm64/ghash-ce - use frame_push/pop macros consistently

Christophe JAILLET (1):
      crypto: amlogic - Remove kcalloc without check

Colin Ian King (1):
      crypto: stm32 - Fix spelling mistake "wite" -> "write"

Corentin Labbe (32):
      crypto: sun8i-ss - use dma_addr instead u32
      crypto: n2 - add missing hash statesize
      crypto: rockchip - use dev_err for error message about interrupt
      crypto: rockchip - do not use uninitialized variable
      crypto: rockchip - do not do custom power management
      crypto: rockchip - fix privete/private typo
      crypto: rockchip - do not store mode globally
      crypto: rockchip - add fallback for cipher
      crypto: rockchip - add fallback for ahash
      crypto: rockchip - better handle cipher key
      crypto: rockchip - remove non-aligned handling
      crypto: rockchip - rework by using crypto_engine
      crypto: rockchip - rewrite type
      crypto: rockchip - add debugfs
      crypto: rockchip - introduce PM
      crypto: rockchip - handle reset also in PM
      crypto: rockchip - use clk_bulk to simplify clock management
      crypto: rockchip - add myself as maintainer
      crypto: rockchip - use read_poll_timeout
      crypto: rockchip - fix style issue
      crypto: rockchip - add support for rk3328
      crypto: rockchip - rename ablk functions to cipher
      crypto: rockchip - rework rk_handle_req function
      crypto: rockchip - use a rk_crypto_info variable instead of lot of indirection
      crypto: rockchip - use the rk_crypto_info given as parameter
      dt-bindings: crypto: convert rockchip-crypto to YAML
      dt-bindings: crypto: rockchip: add new compatible
      crypto: rockchip - store crypto_info in request context
      crypto: rockchip - Check for clocks numbers and their frequencies
      crypto: rockchip - rk_ahash_reg_init use crypto_info from parameter
      crypto: rockchip - permit to have more than one reset
      crypto: rockchip - Add support for RK3399

Daniel Jordan (2):
      padata: Always leave BHs disabled when running ->parallel()
      padata: Fix list iterator in padata_do_serial()

Eric Biggers (18):
      crypto: api - optimize algorithm registration when self-tests disabled
      crypto: algboss - optimize registration of internal algorithms
      crypto: api - compile out crypto_boot_test_finished when tests disabled
      crypto: kdf - skip self-test when tests disabled
      crypto: kdf - silence noisy self-test
      crypto: algboss - compile out test-related code when tests disabled
      crypto: x86/aegis128 - fix possible crash with CFI enabled
      crypto: x86/aria - fix crash with CFI enabled
      crypto: x86/nhpoly1305 - eliminate unnecessary CFI wrappers
      crypto: x86/sha1 - fix possible crash with CFI enabled
      crypto: x86/sha256 - fix possible crash with CFI enabled
      crypto: x86/sha512 - fix possible crash with CFI enabled
      crypto: x86/sm3 - fix possible crash with CFI enabled
      crypto: x86/sm4 - fix crash with CFI enabled
      crypto: arm64/nhpoly1305 - eliminate unnecessary CFI wrapper
      crypto: arm64/sm3 - fix possible crash with CFI enabled
      crypto: arm/nhpoly1305 - eliminate unnecessary CFI wrapper
      Revert "crypto: shash - avoid comparing pointers to exported functions under CFI"

Frederick Lawler (1):
      crypto: af_alg - Support symmetric encryption via keyring keys

Gaosheng Cui (2):
      crypto: ccree - Remove debugfs when platform_driver_register failed
      crypto: img-hash - Fix variable dereferenced before check 'hdev->req'

Giovanni Cabiddu (12):
      crypto: qat - relocate bufferlist logic
      crypto: qat - rename bufferlist functions
      crypto: qat - change bufferlist logic interface
      crypto: qat - generalize crypto request buffers
      crypto: qat - extend buffer list interface
      crypto: qat - relocate backlog related structures
      crypto: qat - relocate qat_algs_alloc_flags()
      crypto: qat - rename and relocate GEN2 config function
      crypto: qat - expose deflate through acomp api for QAT GEN2
      crypto: qat - enable deflate for QAT GEN4
      crypto: acomp - define max size for destination
      crypto: qat - add resubmit logic for decompression

Gustavo A. R. Silva (1):
      crypto: talitos - Replace zero-length arrays with DECLARE_FLEX_ARRAY() helper

Herbert Xu (34):
      crypto: ixp4xx - Fix sparse warnings
      crypto: cryptd - Use request context instead of stack for sub-request
      crypto: skcipher - Allow sync algorithms with large request contexts
      Merge branch 'i2c/client_device_id_helper-immutable' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
      crypto: rsa-pkcs1pad - Use helper to set reqsize
      crypto: kpp - Add helper to set reqsize
      crypto: hisilicon/hpre - Use helper to set reqsize
      crypto: qat - Use helper to set reqsize
      crypto: caam - Use helper to set reqsize
      crypto: virtio - Use helper to set reqsize
      crypto: akcipher - Move reqsize into tfm
      crypto: dh - Use helper to set reqsize
      crypto: kpp - Move reqsize into tfm
      crypto: Prepare to move crypto_tfm_ctx
      crypto: api - Add crypto_tfm_ctx_dma
      crypto: aead - Add ctx helpers with DMA alignment
      crypto: hash - Add ctx helpers with DMA alignment
      crypto: skcipher - Add ctx helpers with DMA alignment
      crypto: api - Increase MAX_ALGAPI_ALIGNMASK to 127
      crypto: akcipher - Add ctx helpers with DMA alignment
      crypto: kpp - Add ctx helpers with DMA alignment
      crypto: caam - Set DMA alignment explicitly
      crypto: api - Use linux/cache.h instead of asm/cache.h
      crypto: chelsio - Fix flexible struct array warning
      crypto: cavium - Set DMA alignment explicitly
      crypto: ccp - Set DMA alignment explicitly
      crypto: ccree - Set DMA alignment explicitly
      crypto: chelsio - Set DMA alignment explicitly
      crypto: hisilicon/hpre - Set DMA alignment explicitly
      crypto: safexcel - Set DMA alignment explicitly
      crypto: keembay - Set DMA alignment explicitly
      crypto: octeontx - Set DMA alignment explicitly
      crypto: octeontx2 - Set DMA alignment explicitly
      crypto: qce - Set DMA alignment explicitly

Jason A. Donenfeld (2):
      hwrng: core - treat default_quality as a maximum and default to 1024
      hwrng: u2fzero - account for high quality RNG

Joe Fradley (1):
      crypto: x86/curve25519 - disable gcov

Kai Ye (8):
      crypto: hisilicon/qm - increase the memory of local variables
      crypto: hisilicon/qm - add pci bdf number check
      crypto: hisilicon/qm - delete redundancy check
      crypto: hisilicon/qm - delete redundant null assignment operations
      crypto: hisilicon/qm - modify the process of regs dfx
      crypto: hisilicon/qm - split a debugfs.c from qm
      crypto: hisilicon/qm - the command dump process is modified
      crypto: hisilicon/sec - fix spelling mistake 'ckeck' -> 'check'

Linus Walleij (4):
      dt-bindings: crypto: Let STM32 define Ux500 CRYP
      crypto: stm32 - enable drivers to be used on Ux500
      crypto: stm32/cryp - enable for use with Ux500
      crypto: ux500/cryp - delete driver

Mario Limonciello (1):
      crypto: ccp - Add support for TEE for PCI ID 0x14CA

Mingming.Su (1):
      hwrng: mtk - add mt7986 support

Natalia Petrova (1):
      crypto: nitrox - avoid double free on error path in nitrox_sriov_init()

Nikolaus Voss (1):
      crypto: caam - warn if blob_gen key is insecure

Peter Harliman Liem (3):
      crypto: inside-secure - Expand soc data structure
      crypto: inside-secure - Add fw_little_endian option
      crypto: inside-secure - Add MaxLinear platform

Ralph Siemsen (1):
      crypto: doc - use correct function name

Robert Elliott (1):
      crypto: tcrypt - fix return value for multiple subtests

Shang XiaoJing (1):
      crypto: omap-sham - Use pm_runtime_resume_and_get() in omap_sham_probe()

Shashank Gupta (1):
      crypto: qat - remove ADF_STATUS_PF_RUNNING flag from probe

Tianjia Zhang (17):
      crypto: ccm - use local variables instead of indirect references
      crypto: scatterwalk - remove duplicate function declarations
      crypto: arm64/sm3 - raise the priority of the CE implementation
      crypto: arm64/sm3 - add NEON assembly implementation
      crypto: arm64/sm4 - refactor and simplify NEON implementation
      crypto: testmgr - add SM4 cts-cbc/xts/xcbc test vectors
      crypto: tcrypt - add SM4 cts-cbc/xts/xcbc test
      crypto: arm64/sm4 - refactor and simplify CE implementation
      crypto: arm64/sm4 - simplify sm4_ce_expand_key() of CE implementation
      crypto: arm64/sm4 - export reusable CE acceleration functions
      crypto: arm64/sm4 - add CE implementation for CTS-CBC mode
      crypto: arm64/sm4 - add CE implementation for XTS mode
      crypto: arm64/sm4 - add CE implementation for cmac/xcbc/cbcmac
      crypto: arm64/sm4 - add CE implementation for CCM mode
      crypto: arm64/sm4 - add CE implementation for GCM mode
      crypto: arm64 - Fix unused variable compilation warnings of cpu_feature
      crypto: ccree,hisilicon - Fix dependencies to correct algorithm

Tomas Marek (3):
      hwrng: stm32 - fix number of returned bytes on read
      hwrng: stm32 - fix read of the last word
      hwrng: stm32 - rename readl return value

Tomer Maimon (2):
      dt-bindings: rng: nuvoton,npcm-rng: Add npcm845 compatible string
      hwrng: npcm - Add NPCM8XX support

Uwe Kleine-König (3):
      crypto: ccree - Make cc_debugfs_global_fini() available for module init function
      crypto: atmel-ecc - Convert to i2c's .probe_new()
      crypto: atmel-sha204a - Convert to i2c's .probe_new()

Wang Yufen (1):
      crypto: qat - fix error return code in adf_probe

Weili Qian (5):
      crypto: hisilicon/qm - fix incorrect parameters usage
      crypto: hisilicon/sec - enabling clock gating of the address prefetch module
      crypto: hisilicon/qm - re-enable communicate interrupt before notifying PF
      crypto: hisilicon/qm - fix 'QM_XEQ_DEPTH_CAP' mask value
      crypto: hisilicon/qm - add device status check when start fails

Wenkai Lin (1):
      crypto: hisilicon/sec - remove continuous blank lines

Xiongfeng Wang (3):
      crypto: hisilicon/qm - add missing pci_dev_put() in q_num_set()
      hwrng: amd - Fix PCI device refcount leak
      hwrng: geode - Fix PCI device refcount leak

Yang Li (1):
      crypto: rockchip - Remove surplus dev_err() when using platform_get_irq()

Yicong Yang (1):
      crypto: hisilicon/qm - drop unnecessary IS_ENABLE(CONFIG_NUMA) check

Yuan Can (1):
      crypto: ccp - Remove unused struct ccp_crypto_cpu

Yushan Zhou (1):
      crypto: marvell/octeontx - remove redundant NULL check

Zhang Yiqun (1):
      crypto: tcrypt - Fix multibuffer skcipher speed test mem leak

Zhiqi Song (1):
      crypto: hisilicon/hpre - fix resource leak in remove process

jianchunfu (1):
      crypto: talitos - Use the defined variable to clean code

ruanjinjie (1):
      crypto: ccp - Add __init/__exit annotations to module init/exit funcs

wangjianli (1):
      crypto: octeontx - fix repeated words in comments

 Documentation/crypto/devel-algos.rst               |    2 +-
 Documentation/crypto/userspace-if.rst              |   15 +-
 .../bindings/crypto/rockchip,rk3288-crypto.yaml    |  127 ++
 .../devicetree/bindings/crypto/rockchip-crypto.txt |   28 -
 .../devicetree/bindings/crypto/st,stm32-cryp.yaml  |   19 +
 .../devicetree/bindings/rng/nuvoton,npcm-rng.yaml  |    4 +-
 MAINTAINERS                                        |    7 +
 arch/arm/crypto/Kconfig                            |    2 +-
 arch/arm/crypto/aes-cipher-glue.c                  |    2 +-
 arch/arm/crypto/nh-neon-core.S                     |    2 +-
 arch/arm/crypto/nhpoly1305-neon-glue.c             |   11 +-
 arch/arm64/crypto/Kconfig                          |   49 +-
 arch/arm64/crypto/Makefile                         |    9 +
 arch/arm64/crypto/aes-ce-glue.c                    |    2 +-
 arch/arm64/crypto/aes-cipher-glue.c                |    2 +-
 arch/arm64/crypto/aes-modes.S                      |   34 +-
 arch/arm64/crypto/aes-neonbs-core.S                |   16 +-
 arch/arm64/crypto/crct10dif-ce-core.S              |    5 +-
 arch/arm64/crypto/ghash-ce-core.S                  |    8 +-
 arch/arm64/crypto/ghash-ce-glue.c                  |    2 +-
 arch/arm64/crypto/nh-neon-core.S                   |    5 +-
 arch/arm64/crypto/nhpoly1305-neon-glue.c           |   11 +-
 arch/arm64/crypto/sm3-ce-glue.c                    |    2 +-
 arch/arm64/crypto/sm3-neon-core.S                  |  601 ++++++++
 arch/arm64/crypto/sm3-neon-glue.c                  |  103 ++
 arch/arm64/crypto/sm4-ce-asm.h                     |  209 +++
 arch/arm64/crypto/sm4-ce-ccm-core.S                |  328 ++++
 arch/arm64/crypto/sm4-ce-ccm-glue.c                |  303 ++++
 arch/arm64/crypto/sm4-ce-cipher-glue.c             |    2 +-
 arch/arm64/crypto/sm4-ce-core.S                    | 1205 ++++++++++-----
 arch/arm64/crypto/sm4-ce-gcm-core.S                |  741 +++++++++
 arch/arm64/crypto/sm4-ce-gcm-glue.c                |  286 ++++
 arch/arm64/crypto/sm4-ce-glue.c                    |  575 ++++++-
 arch/arm64/crypto/sm4-ce.h                         |   16 +
 arch/arm64/crypto/sm4-neon-core.S                  |  630 +++++---
 arch/arm64/crypto/sm4-neon-glue.c                  |  172 +--
 arch/um/drivers/random.c                           |    1 -
 arch/x86/crypto/Makefile                           |    3 +
 arch/x86/crypto/aegis128-aesni-asm.S               |    9 +-
 arch/x86/crypto/aria-aesni-avx-asm_64.S            |   13 +-
 arch/x86/crypto/nh-avx2-x86_64.S                   |    5 +-
 arch/x86/crypto/nh-sse2-x86_64.S                   |    5 +-
 arch/x86/crypto/nhpoly1305-avx2-glue.c             |   11 +-
 arch/x86/crypto/nhpoly1305-sse2-glue.c             |   11 +-
 arch/x86/crypto/sha1_ni_asm.S                      |    3 +-
 arch/x86/crypto/sha1_ssse3_asm.S                   |    3 +-
 arch/x86/crypto/sha256-avx-asm.S                   |    3 +-
 arch/x86/crypto/sha256-avx2-asm.S                  |    3 +-
 arch/x86/crypto/sha256-ssse3-asm.S                 |    3 +-
 arch/x86/crypto/sha256_ni_asm.S                    |    3 +-
 arch/x86/crypto/sha512-avx-asm.S                   |    3 +-
 arch/x86/crypto/sha512-avx2-asm.S                  |    3 +-
 arch/x86/crypto/sha512-ssse3-asm.S                 |    3 +-
 arch/x86/crypto/sm3-avx-asm_64.S                   |    3 +-
 arch/x86/crypto/sm4-aesni-avx-asm_64.S             |    7 +-
 arch/x86/crypto/sm4-aesni-avx2-asm_64.S            |    7 +-
 arch/x86/crypto/twofish_glue.c                     |    2 +-
 crypto/Kconfig                                     |    9 +-
 crypto/Makefile                                    |    1 -
 crypto/aes_generic.c                               |    2 +-
 crypto/aes_ti.c                                    |    2 +-
 crypto/af_alg.c                                    |  135 +-
 crypto/algapi.c                                    |  160 +-
 crypto/algboss.c                                   |   22 +-
 crypto/anubis.c                                    |    2 +-
 crypto/api.c                                       |   11 +-
 crypto/blowfish_common.c                           |    3 +-
 crypto/blowfish_generic.c                          |    3 +-
 crypto/camellia_generic.c                          |    2 +-
 crypto/cast5_generic.c                             |    2 +-
 crypto/cast6_generic.c                             |    2 +-
 crypto/ccm.c                                       |    2 +-
 crypto/cryptd.c                                    |   36 +-
 crypto/des_generic.c                               |    2 +-
 crypto/dh.c                                        |    4 +-
 crypto/fcrypt.c                                    |    2 +-
 crypto/internal.h                                  |   20 +-
 crypto/kdf_sp800108.c                              |   10 +-
 crypto/khazad.c                                    |    2 +-
 crypto/rsa-pkcs1pad.c                              |    5 +-
 crypto/seed.c                                      |    2 +-
 crypto/serpent_generic.c                           |    2 +-
 crypto/shash.c                                     |   27 +-
 crypto/skcipher.c                                  |    2 +-
 crypto/sm4_generic.c                               |    2 +-
 crypto/tcrypt.c                                    |  317 ++--
 crypto/tea.c                                       |    2 +-
 crypto/testmgr.c                                   |   19 +
 crypto/testmgr.h                                   |  977 ++++++++++++
 crypto/twofish_common.c                            |    2 +-
 crypto/twofish_generic.c                           |    2 +-
 drivers/char/hw_random/amd-rng.c                   |   18 +-
 drivers/char/hw_random/cavium-rng-vf.c             |    1 -
 drivers/char/hw_random/cn10k-rng.c                 |    1 -
 drivers/char/hw_random/core.c                      |    9 +-
 drivers/char/hw_random/geode-rng.c                 |   36 +-
 drivers/char/hw_random/mpfs-rng.c                  |    1 -
 drivers/char/hw_random/mtk-rng.c                   |    5 +-
 drivers/char/hw_random/npcm-rng.c                  |   15 +-
 drivers/char/hw_random/s390-trng.c                 |    1 -
 drivers/char/hw_random/stm32-rng.c                 |    8 +-
 drivers/char/hw_random/timeriomem-rng.c            |    2 -
 drivers/char/hw_random/virtio-rng.c                |    1 -
 drivers/crypto/Kconfig                             |   19 +-
 drivers/crypto/Makefile                            |    2 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c  |    1 -
 .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    |    2 +-
 drivers/crypto/amlogic/amlogic-gxl-core.c          |    1 -
 drivers/crypto/amlogic/amlogic-gxl.h               |    2 +-
 drivers/crypto/atmel-ecc.c                         |    6 +-
 drivers/crypto/atmel-sha204a.c                     |    7 +-
 drivers/crypto/caam/blob_gen.c                     |    9 +
 drivers/crypto/caam/caamalg.c                      |   72 +-
 drivers/crypto/caam/caamalg_qi.c                   |   52 +-
 drivers/crypto/caam/caamalg_qi2.c                  |  173 +--
 drivers/crypto/caam/caamhash.c                     |   87 +-
 drivers/crypto/caam/caampkc.c                      |   50 +-
 drivers/crypto/caam/caamrng.c                      |    1 -
 drivers/crypto/caam/regs.h                         |    3 +
 drivers/crypto/cavium/cpt/cptvf_algs.c             |   10 +-
 drivers/crypto/cavium/nitrox/nitrox_aead.c         |   12 +-
 drivers/crypto/cavium/nitrox/nitrox_mbx.c          |    1 +
 drivers/crypto/ccp/ccp-crypto-aes-cmac.c           |   21 +-
 drivers/crypto/ccp/ccp-crypto-aes-galois.c         |   12 +-
 drivers/crypto/ccp/ccp-crypto-aes-xts.c            |   20 +-
 drivers/crypto/ccp/ccp-crypto-aes.c                |   29 +-
 drivers/crypto/ccp/ccp-crypto-des3.c               |   17 +-
 drivers/crypto/ccp/ccp-crypto-main.c               |   15 +-
 drivers/crypto/ccp/ccp-crypto-rsa.c                |   18 +-
 drivers/crypto/ccp/ccp-crypto-sha.c                |   26 +-
 drivers/crypto/ccp/sp-pci.c                        |   11 +-
 drivers/crypto/ccree/cc_aead.c                     |   62 +-
 drivers/crypto/ccree/cc_buffer_mgr.c               |   18 +-
 drivers/crypto/ccree/cc_debugfs.c                  |    2 +-
 drivers/crypto/ccree/cc_driver.c                   |   10 +-
 drivers/crypto/ccree/cc_hash.c                     |   86 +-
 drivers/crypto/chelsio/Kconfig                     |    2 +-
 drivers/crypto/chelsio/chcr_algo.c                 |   49 +-
 drivers/crypto/chelsio/chcr_crypto.h               |    6 +-
 drivers/crypto/hisilicon/Kconfig                   |    2 +-
 drivers/crypto/hisilicon/Makefile                  |    2 +-
 drivers/crypto/hisilicon/debugfs.c                 | 1147 ++++++++++++++
 drivers/crypto/hisilicon/hpre/hpre_crypto.c        |   47 +-
 drivers/crypto/hisilicon/hpre/hpre_main.c          |   17 +-
 drivers/crypto/hisilicon/qm.c                      | 1427 ++---------------
 drivers/crypto/hisilicon/qm_common.h               |   87 ++
 drivers/crypto/hisilicon/sec2/sec_crypto.c         |    5 +-
 drivers/crypto/hisilicon/sec2/sec_main.c           |   10 +-
 drivers/crypto/hisilicon/zip/zip_main.c            |    7 +-
 drivers/crypto/img-hash.c                          |    8 +-
 drivers/crypto/inside-secure/safexcel.c            |   69 +-
 drivers/crypto/inside-secure/safexcel.h            |   10 +-
 drivers/crypto/inside-secure/safexcel_hash.c       |   99 +-
 drivers/crypto/ixp4xx_crypto.c                     |   10 +-
 drivers/crypto/keembay/keembay-ocs-hcu-core.c      |   26 +-
 drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h |    2 +-
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c  |    3 +-
 drivers/crypto/marvell/octeontx/otx_cptvf_algs.c   |   69 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c |   79 +-
 drivers/crypto/n2_core.c                           |    6 +
 drivers/crypto/nx/nx-842.h                         |    2 +-
 drivers/crypto/omap-sham.c                         |    2 +-
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c     |    4 +-
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h     |    2 +-
 drivers/crypto/qat/qat_4xxx/adf_drv.c              |  146 +-
 drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c   |    4 +
 drivers/crypto/qat/qat_c3xxx/adf_drv.c             |    2 +-
 .../crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c   |    4 +
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c           |    2 -
 drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c     |    4 +
 drivers/crypto/qat/qat_c62x/adf_drv.c              |    2 +-
 drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c |    4 +
 drivers/crypto/qat/qat_c62xvf/adf_drv.c            |    2 -
 drivers/crypto/qat/qat_common/Makefile             |    8 +-
 drivers/crypto/qat/qat_common/adf_accel_devices.h  |   14 +
 drivers/crypto/qat/qat_common/adf_cfg_strings.h    |    1 +
 drivers/crypto/qat/qat_common/adf_common_drv.h     |    9 +-
 drivers/crypto/qat/qat_common/adf_ctl_drv.c        |    6 +
 drivers/crypto/qat/qat_common/adf_gen2_config.c    |  206 +++
 drivers/crypto/qat/qat_common/adf_gen2_config.h    |   10 +
 drivers/crypto/qat/qat_common/adf_gen2_dc.c        |   70 +
 drivers/crypto/qat/qat_common/adf_gen2_dc.h        |   10 +
 drivers/crypto/qat/qat_common/adf_gen4_dc.c        |   83 +
 drivers/crypto/qat/qat_common/adf_gen4_dc.h        |   10 +
 drivers/crypto/qat/qat_common/adf_init.c           |   11 +
 drivers/crypto/qat/qat_common/adf_sriov.c          |    4 +
 drivers/crypto/qat/qat_common/icp_qat_fw.h         |   24 +
 drivers/crypto/qat/qat_common/icp_qat_fw_comp.h    |  404 +++++
 drivers/crypto/qat/qat_common/icp_qat_hw.h         |   66 +
 drivers/crypto/qat/qat_common/icp_qat_hw_20_comp.h |  164 ++
 .../qat/qat_common/icp_qat_hw_20_comp_defs.h       |  300 ++++
 drivers/crypto/qat/qat_common/qat_algs.c           |  208 +--
 drivers/crypto/qat/qat_common/qat_algs_send.h      |   16 +-
 drivers/crypto/qat/qat_common/qat_asym_algs.c      |    6 +-
 drivers/crypto/qat/qat_common/qat_bl.c             |  383 +++++
 drivers/crypto/qat/qat_common/qat_bl.h             |   67 +
 drivers/crypto/qat/qat_common/qat_comp_algs.c      |  344 +++++
 drivers/crypto/qat/qat_common/qat_comp_req.h       |  123 ++
 drivers/crypto/qat/qat_common/qat_compression.c    |  297 ++++
 drivers/crypto/qat/qat_common/qat_compression.h    |   37 +
 drivers/crypto/qat/qat_common/qat_crypto.c         |  120 +-
 drivers/crypto/qat/qat_common/qat_crypto.h         |   55 +-
 .../crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c |    4 +
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c          |    2 +-
 .../qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c    |    4 +
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c        |    2 -
 drivers/crypto/qce/aead.c                          |   22 +-
 drivers/crypto/qce/common.c                        |    5 +-
 drivers/crypto/qce/sha.c                           |   18 +-
 drivers/crypto/rockchip/rk3288_crypto.c            |  505 +++---
 drivers/crypto/rockchip/rk3288_crypto.h            |  107 +-
 drivers/crypto/rockchip/rk3288_crypto_ahash.c      |  267 ++--
 drivers/crypto/rockchip/rk3288_crypto_skcipher.c   |  543 ++++---
 drivers/crypto/stm32/Kconfig                       |    4 +-
 drivers/crypto/stm32/stm32-cryp.c                  |  417 +++--
 drivers/crypto/talitos.c                           |    6 +-
 drivers/crypto/talitos.h                           |    4 +-
 drivers/crypto/ux500/Kconfig                       |   10 -
 drivers/crypto/ux500/Makefile                      |    1 -
 drivers/crypto/ux500/cryp/Makefile                 |   10 -
 drivers/crypto/ux500/cryp/cryp.c                   |  394 -----
 drivers/crypto/ux500/cryp/cryp.h                   |  315 ----
 drivers/crypto/ux500/cryp/cryp_core.c              | 1600 --------------------
 drivers/crypto/ux500/cryp/cryp_irq.c               |   45 -
 drivers/crypto/ux500/cryp/cryp_irq.h               |   31 -
 drivers/crypto/ux500/cryp/cryp_irqp.h              |  125 --
 drivers/crypto/ux500/cryp/cryp_p.h                 |  122 --
 .../crypto/virtio/virtio_crypto_akcipher_algs.c    |    5 +-
 drivers/firmware/turris-mox-rwtm.c                 |    1 -
 drivers/hid/hid-u2fzero.c                          |    1 -
 drivers/i2c/i2c-core-base.c                        |   14 +
 drivers/s390/crypto/zcrypt_api.c                   |    6 -
 drivers/usb/misc/chaoskey.c                        |    1 -
 include/crypto/acompress.h                         |    1 +
 include/crypto/akcipher.h                          |    7 +-
 include/crypto/algapi.h                            |   43 +-
 include/crypto/aria.h                              |    2 +-
 include/crypto/gcm.h                               |   22 +
 include/crypto/internal/acompress.h                |    2 +
 include/crypto/internal/aead.h                     |   22 +
 include/crypto/internal/akcipher.h                 |   26 +-
 include/crypto/internal/hash.h                     |   30 +-
 include/crypto/internal/kpp.h                      |   30 +-
 include/crypto/internal/scompress.h                |    3 +-
 include/crypto/internal/skcipher.h                 |   30 +
 include/crypto/kpp.h                               |    9 +-
 include/crypto/scatterwalk.h                       |    1 -
 include/linux/crypto.h                             |    5 -
 include/linux/hisi_acc_qm.h                        |   14 +-
 include/linux/hw_random.h                          |    2 +-
 include/linux/i2c.h                                |    1 +
 include/uapi/linux/if_alg.h                        |    1 +
 kernel/padata.c                                    |   15 +-
 lib/crypto/Kconfig                                 |    9 +
 lib/crypto/Makefile                                |    5 +
 lib/crypto/aesgcm.c                                |  727 +++++++++
 {crypto => lib/crypto}/gf128mul.c                  |   58 +-
 257 files changed, 13380 insertions(+), 7088 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
 create mode 100644 arch/arm64/crypto/sm3-neon-core.S
 create mode 100644 arch/arm64/crypto/sm3-neon-glue.c
 create mode 100644 arch/arm64/crypto/sm4-ce-asm.h
 create mode 100644 arch/arm64/crypto/sm4-ce-ccm-core.S
 create mode 100644 arch/arm64/crypto/sm4-ce-ccm-glue.c
 create mode 100644 arch/arm64/crypto/sm4-ce-gcm-core.S
 create mode 100644 arch/arm64/crypto/sm4-ce-gcm-glue.c
 create mode 100644 arch/arm64/crypto/sm4-ce.h
 create mode 100644 drivers/crypto/hisilicon/debugfs.c
 create mode 100644 drivers/crypto/hisilicon/qm_common.h
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_config.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_config.h
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_dc.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_dc.h
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_dc.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_dc.h
 create mode 100644 drivers/crypto/qat/qat_common/icp_qat_fw_comp.h
 create mode 100644 drivers/crypto/qat/qat_common/icp_qat_hw_20_comp.h
 create mode 100644 drivers/crypto/qat/qat_common/icp_qat_hw_20_comp_defs.h
 create mode 100644 drivers/crypto/qat/qat_common/qat_bl.c
 create mode 100644 drivers/crypto/qat/qat_common/qat_bl.h
 create mode 100644 drivers/crypto/qat/qat_common/qat_comp_algs.c
 create mode 100644 drivers/crypto/qat/qat_common/qat_comp_req.h
 create mode 100644 drivers/crypto/qat/qat_common/qat_compression.c
 create mode 100644 drivers/crypto/qat/qat_common/qat_compression.h
 delete mode 100644 drivers/crypto/ux500/cryp/Makefile
 delete mode 100644 drivers/crypto/ux500/cryp/cryp.c
 delete mode 100644 drivers/crypto/ux500/cryp/cryp.h
 delete mode 100644 drivers/crypto/ux500/cryp/cryp_core.c
 delete mode 100644 drivers/crypto/ux500/cryp/cryp_irq.c
 delete mode 100644 drivers/crypto/ux500/cryp/cryp_irq.h
 delete mode 100644 drivers/crypto/ux500/cryp/cryp_irqp.h
 delete mode 100644 drivers/crypto/ux500/cryp/cryp_p.h
 create mode 100644 lib/crypto/aesgcm.c
 rename {crypto => lib/crypto}/gf128mul.c (87%)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
