Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA32742229
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjF2I3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjF2I3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:29:12 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26EEED;
        Thu, 29 Jun 2023 01:29:10 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qEjrG-008RSN-Ns; Thu, 29 Jun 2023 13:06:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 29 Jun 2023 13:06:18 +0800
Date:   Thu, 29 Jun 2023 13:06:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Update for 6.5
Message-ID: <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
References: <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

Please note that there is a nasty merge conflict in the directory
crypto/asymmetric because of the conflicting changes in mainline
versus what's in cryptodev.

For the resolution, please pick the code from cryptodev as the
linear interface makes the previous fix-up in mainline unnecessary.

For the time being there is still an unnecessary copy in the API
for the software case but hopefully that will go away once I
finish the conversion of the underlying algorithm code to use
linear addresses instead of SG lists.

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.5-p1 

for you to fetch changes up to 486bfb05913ac9969a3a71a4dc48f17f31cb162d:

  crypto: akcipher - Do not copy dst if it is NULL (2023-06-27 17:59:52 +0800)

----------------------------------------------------------------
This update includes the following changes:

API:

- Add linear akcipher/sig API.
- Add tfm cloning (hmac, cmac).
- Add statesize to crypto_ahash.

Algorithms:

- Allow only odd e and restrict value in FIPS mode for RSA.
- Replace LFSR with SHA3-256 in jitter.
- Add interface for gathering of raw entropy in jitter.

Drivers:

- Fix race on data_avail and actual data in hwrng/virtio.
- Add hash and HMAC support in starfive.
- Add RSA algo support in starfive.
- Add support for PCI device 0x156E in ccp.
----------------------------------------------------------------

Adam Guerin (2):
      crypto: qat - move returns to default case
      crypto: qat - extend configuration for 4xxx

Arnd Bergmann (2):
      crypto: aegis128-neon - add header for internal prototypes
      crypto: marvell/cesa - Fix type mismatch warning

Bharat Bhushan (1):
      hwrng: cn10k - Add extended trng register support

Bhupesh Sharma (2):
      dt-bindings: qcom-qce: Fix compatible combinations for SM8150 and IPQ4019 SoCs
      dt-bindings: qcom-qce: Add compatibles for SM6115 and QCM2290

Damian Muszynski (1):
      crypto: qat - move dbgfs init to separate file

Dan Carpenter (1):
      crypto: ixp4xx - silence uninitialized variable warning

David Yang (2):
      hwrng: histb - Move driver to drivers/char/hw_random/histb-rng.c
      crypto: engine - Fix struct crypto_engine_op doc

Dmitry Safonov (2):
      crypto: api - Remove crypto_init_ops()
      crypto: cipher - On clone do crypto_mod_get()

Eric Biggers (1):
      crypto: Kconfig - warn about performance overhead of CRYPTO_STATS

Franziska Naepelt (1):
      crypto: hmac - Add missing blank line

Giovanni Cabiddu (4):
      crypto: qat - add missing function declaration in adf_dbgfs.h
      crypto: qat - make fw images name constant
      crypto: qat - refactor fw config logic for 4xxx
      crypto: qat - do not export adf_init_admin_pm()

Hareshx Sankar Raj (2):
      crypto: qat - unmap buffer before free for DH
      crypto: qat - unmap buffers before free for RSA

Herbert Xu (28):
      hwrng: Kconfig - Add HAS_IOMEM dependencies for exynos/meson/mtk/npcm
      crypto: arm/sha1-neon - Fix clang function cast warnings
      crypto: arm/sha256-neon - Fix clang function cast warnings
      crypto: arm/sha512-neon - Fix clang function cast warnings
      crypto: hash - Add statesize to crypto_ahash
      crypto: hash - Make crypto_ahash_alg helper available
      hwrng: virtio - Fix race on data_avail and actual data
      crypto: lib/sha256 - Remove redundant and unused sha224_update
      crypto: lib/sha256 - Use generic code from sha256_base
      crypto: arm64/sha256-glue - Include module.h
      crypto: starfive - Depend on AMBA_PL08X instead of selecting it
      crypto: cmac - Use modern init_tfm/exit_tfm
      crypto: cipher - Add crypto_clone_cipher
      crypto: cmac - Add support for cloning
      crypto: shash - Allow cloning on algorithms with no init_tfm
      dm crypt: Avoid using MAX_CIPHER_BLOCKSIZE
      crypto: algboss - Add missing dependency on RNG2
      crypto: geniv - Split geniv out of AEAD Kconfig option
      crypto: api - Add __crypto_alloc_tfmgfp
      crypto: akcipher - Add sync interface without SG lists
      crypto: sig - Add interface for sign/verify
      KEYS: Add forward declaration in asymmetric-parser.h
      KEYS: asymmetric: Move sm2 code into x509_public_key
      KEYS: asymmetric: Use new crypto interface without scatterlists
      crypto: sm2 - Provide sm2_compute_z_digest when sm2 is disabled
      crypto: akcipher - Set request tfm on sync path
      crypto: sig - Fix verify call
      crypto: akcipher - Do not copy dst if it is NULL

Horia GeantA (1):
      crypto: caam - refactor RNG initialization

Jia Jie Ho (6):
      dt-bindings: crypto: Add StarFive crypto module
      crypto: starfive - Add crypto engine support
      crypto: starfive - Add hash and HMAC support
      crypto: starfive - Fix driver dependencies
      crypto: starfive - Update hash module irq handling
      crypto: starfive - Add RSA algo support

John Allen (1):
      crypto: ccp - Add support for PCI device 0x156E

Karthikeyan Gopal (2):
      crypto: qat - set deprecated capabilities as reserved
      crypto: qat - update slice mask for 4xxx devices

Lucas Segarra Fernandez (1):
      crypto: qat - expose pm_idle_enabled through sysfs

Mahmoud Adam (1):
      crypto: rsa - allow only odd e and restrict value in FIPS mode

Mario Limonciello (2):
      crypto: ccp - Validate that platform access mailbox registers are declared
      crypto: ccp - Add support for PCI device 0x17E0

Martin Kaiser (9):
      hwrng: imx-rngc - simpler check for available random bytes
      hwrng: imx-rngc - use bitfield macros to read rng type
      hwrng: imx-rngc - use BIT(x) for register bit defines
      hwrng: imx-rngc - mark the probe function as __init
      hwrng: imx-rngc - don't init of_device_id's data
      hwrng: imx-rngc - fix the timeout for init and self check
      hwrng: st - support compile-testing
      hwrng: st - keep clock enabled while hwrng is registered
      hwrng: imx-rngc - switch to DEFINE_SIMPLE_DEV_PM_OPS

Meenakshi Aggarwal (1):
      crypto: caam - optimize RNG sample size

Pankaj Gupta (1):
      crypto: caam - Fix soc_id matching

Randy Dunlap (1):
      crypto: nx - fix build warnings when DEBUG_FS is not enabled

Rob Herring (1):
      crypto: n2 - Use of_property_read_reg() to parse "reg"

Srujana Challa (2):
      crypto: octeontx2 - add support for AF to CPT PF uplink mbox
      crypto: octeontx2 - hardware configuration for inline IPsec

Stephan Müller (3):
      crypto: jitter - replace LFSR with SHA3-256
      crypto: jitter - add interface for gathering of raw entropy
      crypto: jitter - correct health test during initialization

Tero Kristo (1):
      crypto: sa2ul - change unsafe data size limit to 255 bytes

Uwe Kleine-König (1):
      crypto: atmel - Switch i2c drivers back to use .probe()

Victoria Milhoan (1):
      crypto: caam - adjust RNG timing to support more devices

Victoria Milhoan (b42089) (1):
      crypto: caam - add a test for the RNG

 Documentation/ABI/testing/sysfs-driver-qat         |  46 ++
 .../devicetree/bindings/crypto/qcom-qce.yaml       |  52 +-
 .../bindings/crypto/starfive,jh7110-crypto.yaml    |  70 ++
 MAINTAINERS                                        |   7 +
 arch/arm/crypto/sha1_neon_glue.c                   |  12 +-
 arch/arm/crypto/sha256_neon_glue.c                 |  12 +-
 arch/arm/crypto/sha512-neon-glue.c                 |  12 +-
 arch/arm64/crypto/sha256-glue.c                    |   3 +-
 crypto/Kconfig                                     |  66 +-
 crypto/Makefile                                    |   4 +-
 crypto/aegis-neon.h                                |  17 +
 crypto/aegis128-neon-inner.c                       |   1 +
 crypto/aegis128-neon.c                             |  12 +-
 crypto/ahash.c                                     |   9 +-
 crypto/akcipher.c                                  | 124 ++-
 crypto/api.c                                       |  27 +-
 crypto/asymmetric_keys/public_key.c                | 303 ++++---
 crypto/asymmetric_keys/x509_public_key.c           |  29 +-
 crypto/cipher.c                                    |  28 +
 crypto/cmac.c                                      |  36 +-
 crypto/hmac.c                                      |   1 +
 crypto/internal.h                                  |  22 +
 crypto/jitterentropy-kcapi.c                       | 192 ++++-
 crypto/jitterentropy-testing.c                     | 294 +++++++
 crypto/jitterentropy.c                             | 152 ++--
 crypto/jitterentropy.h                             |  20 +-
 crypto/rsa.c                                       |  36 +
 crypto/shash.c                                     |  12 +-
 crypto/sig.c                                       | 157 ++++
 crypto/sm2.c                                       | 104 ++-
 drivers/char/hw_random/Kconfig                     |  27 +-
 drivers/char/hw_random/Makefile                    |   1 +
 drivers/char/hw_random/cn10k-rng.c                 |  63 +-
 .../trng/trng-stb.c => char/hw_random/histb-rng.c} |  83 +-
 drivers/char/hw_random/imx-rngc.c                  |  53 +-
 drivers/char/hw_random/st-rng.c                    |  21 +-
 drivers/char/hw_random/virtio-rng.c                |  10 +-
 drivers/crypto/Kconfig                             |   1 +
 drivers/crypto/Makefile                            |   1 +
 drivers/crypto/atmel-ecc.c                         |   2 +-
 drivers/crypto/atmel-sha204a.c                     |   2 +-
 drivers/crypto/caam/Kconfig                        |   9 +
 drivers/crypto/caam/caamrng.c                      |  48 ++
 drivers/crypto/caam/ctrl.c                         | 272 ++++---
 drivers/crypto/caam/intern.h                       |   1 +
 drivers/crypto/caam/regs.h                         |  14 +-
 drivers/crypto/ccp/platform-access.c               |   5 +
 drivers/crypto/ccp/sp-pci.c                        |  43 +
 drivers/crypto/hisilicon/Kconfig                   |   7 -
 drivers/crypto/hisilicon/Makefile                  |   2 +-
 drivers/crypto/hisilicon/trng/Makefile             |   3 -
 drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c        |   2 +-
 .../crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c   | 229 ++++--
 .../crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.h   |   2 +-
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c        |  45 +-
 drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c       |  12 +-
 drivers/crypto/intel/qat/qat_c3xxxvf/adf_drv.c     |  12 +-
 drivers/crypto/intel/qat/qat_c62x/adf_drv.c        |  12 +-
 drivers/crypto/intel/qat/qat_c62xvf/adf_drv.c      |  12 +-
 drivers/crypto/intel/qat/qat_common/Makefile       |   4 +-
 .../intel/qat/qat_common/adf_accel_devices.h       |   2 +-
 .../crypto/intel/qat/qat_common/adf_accel_engine.c |   2 +-
 drivers/crypto/intel/qat/qat_common/adf_admin.c    |   1 -
 drivers/crypto/intel/qat/qat_common/adf_cfg.c      |  28 +-
 drivers/crypto/intel/qat/qat_common/adf_cfg.h      |   2 +
 .../crypto/intel/qat/qat_common/adf_cfg_strings.h  |   8 +
 .../crypto/intel/qat/qat_common/adf_common_drv.h   |   2 +-
 drivers/crypto/intel/qat/qat_common/adf_dbgfs.c    |  69 ++
 drivers/crypto/intel/qat/qat_common/adf_dbgfs.h    |  29 +
 drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c  |  12 +-
 drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h  |   1 +
 drivers/crypto/intel/qat/qat_common/adf_init.c     |   6 +
 drivers/crypto/intel/qat/qat_common/adf_sysfs.c    |  60 ++
 drivers/crypto/intel/qat/qat_common/icp_qat_hw.h   |   3 +-
 drivers/crypto/intel/qat/qat_common/qat_algs.c     |   1 -
 .../crypto/intel/qat/qat_common/qat_asym_algs.c    |  14 +-
 drivers/crypto/intel/qat/qat_common/qat_uclo.c     |   8 +-
 drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c    |  12 +-
 drivers/crypto/intel/qat/qat_dh895xccvf/adf_drv.c  |  12 +-
 drivers/crypto/marvell/cesa/cipher.c               |   2 +-
 drivers/crypto/marvell/octeontx2/otx2_cpt_common.h |  15 +
 .../marvell/octeontx2/otx2_cpt_mbox_common.c       |   3 +
 drivers/crypto/marvell/octeontx2/otx2_cptlf.c      |  34 +-
 drivers/crypto/marvell/octeontx2/otx2_cptlf.h      |  33 +-
 drivers/crypto/marvell/octeontx2/otx2_cptpf.h      |   7 +
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c |  41 +
 drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c | 247 +++++-
 .../crypto/marvell/octeontx2/otx2_cptpf_ucode.c    |  10 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf.h      |   1 +
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c |   8 +-
 drivers/crypto/n2_core.c                           |   9 +-
 drivers/crypto/nx/Makefile                         |   2 +-
 drivers/crypto/nx/nx.h                             |   4 +-
 drivers/crypto/sa2ul.h                             |   2 +-
 drivers/crypto/starfive/Kconfig                    |  20 +
 drivers/crypto/starfive/Makefile                   |   4 +
 drivers/crypto/starfive/jh7110-cryp.c              | 258 ++++++
 drivers/crypto/starfive/jh7110-cryp.h              | 172 ++++
 drivers/crypto/starfive/jh7110-hash.c              | 899 +++++++++++++++++++++
 drivers/crypto/starfive/jh7110-rsa.c               | 617 ++++++++++++++
 drivers/md/dm-crypt.c                              |  15 +-
 include/crypto/akcipher.h                          |  36 +
 include/crypto/algapi.h                            |   1 -
 include/crypto/engine.h                            |   2 +-
 include/crypto/hash.h                              |   3 +-
 include/crypto/internal/cipher.h                   |   2 +
 include/crypto/internal/hash.h                     |  12 +
 include/crypto/internal/sig.h                      |  17 +
 include/crypto/public_key.h                        |   2 -
 include/crypto/sha2.h                              |   2 +-
 include/crypto/sha256_base.h                       |  50 +-
 include/crypto/sig.h                               | 140 ++++
 include/crypto/sm2.h                               |  21 +-
 include/keys/asymmetric-parser.h                   |   2 +
 include/linux/crypto.h                             |   3 +-
 lib/crypto/sha256.c                                |  79 +-
 116 files changed, 4940 insertions(+), 965 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
 create mode 100644 crypto/aegis-neon.h
 create mode 100644 crypto/jitterentropy-testing.c
 create mode 100644 crypto/sig.c
 rename drivers/{crypto/hisilicon/trng/trng-stb.c => char/hw_random/histb-rng.c} (53%)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_dbgfs.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_dbgfs.h
 create mode 100644 drivers/crypto/starfive/Kconfig
 create mode 100644 drivers/crypto/starfive/Makefile
 create mode 100644 drivers/crypto/starfive/jh7110-cryp.c
 create mode 100644 drivers/crypto/starfive/jh7110-cryp.h
 create mode 100644 drivers/crypto/starfive/jh7110-hash.c
 create mode 100644 drivers/crypto/starfive/jh7110-rsa.c
 create mode 100644 include/crypto/internal/sig.h
 create mode 100644 include/crypto/sig.h

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
