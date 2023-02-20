Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C2869C4EA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 06:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBTFWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 00:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTFWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 00:22:46 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A053BBB90;
        Sun, 19 Feb 2023 21:22:43 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pTydE-00DF1P-Rz; Mon, 20 Feb 2023 13:22:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 20 Feb 2023 13:22:32 +0800
Date:   Mon, 20 Feb 2023 13:22:32 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Update for 6.3
Message-ID: <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
References: <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

The following changes since commit 736f88689c6912f05d0116917910603a7ba97de7:

  crypto: arm64/sm4 - fix possible crash with CFI enabled (2022-12-30 17:57:42 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.3-p1 

for you to fetch changes up to 8b84475318641c2b89320859332544cf187e1cbd:

  crypto: x86/aria-avx - Do not use avx2 instructions (2023-02-14 13:39:33 +0800)

----------------------------------------------------------------
This update includes the following changes:

API:

- Use kmap_local instead of kmap_atomic.
- Change request callback to take void pointer.
- Print FIPS status in /proc/crypto (when enabled).

Algorithms:

- Add rfc4106/gcm support on arm64.
- Add ARIA AVX2/512 support on x86.

Drivers:

- Add TRNG driver for StarFive SoC.
- Delete ux500/hash driver (subsumed by stm32/hash).
- Add zlib support in qat.
- Add RSA support in aspeed.

----------------------------------------------------------------
Alexander Lobakin (1):
      crypto: octeontx2 - Fix objects shared between several modules

Ard Biesheuvel (5):
      crypto: scatterwalk - use kmap_local() not kmap_atomic()
      crypto: skcipher - Use scatterwalk (un)map interface for dst and src buffers
      crypto: arm64/gcm - add RFC4106 support
      crypto: tcrypt - include larger key sizes in RFC4106 benchmark
      crypto: aead - fix inaccurate documentation

Arnd Bergmann (1):
      crypto: wp512 - disable kmsan checks in wp512_process_buffer()

Christophe JAILLET (1):
      crypto: virtio/akcipher - Do not use GFP_ATOMIC when not needed

Danny Tsen (6):
      crypto: p10-aes-gcm - Update Kconfig and Makefile
      crypto: p10-aes-gcm - Glue code for AES/GCM stitched implementation
      crypto: p10-aes-gcm - An accelerated AES/GCM stitched implementation
      crypto: p10-aes-gcm - Supporting functions for AES
      crypto: p10-aes-gcm - Supporting functions for ghash
      crypto: p10-aes-gcm - A perl script to process PowerPC assembler source

David Rientjes (1):
      crypto: ccp - Avoid page allocation failure warning for SEV_GET_ID2

Eric Biggers (3):
      crypto: x86/ghash - fix unaligned access in ghash_setkey()
      crypto: x86/ghash - use le128 instead of u128
      crypto: x86/ghash - add comment and fix broken link

Giovanni Cabiddu (2):
      crypto: qat - fix out-of-bounds read
      crypto: qat - drop log level of msg in get_instance_node()

Gustavo A. R. Silva (1):
      crypto: aspeed - Replace zero-length array with flexible-array member

Herbert Xu (77):
      crypto: arm/sha1 - Fix clang function cast warnings
      crypto: lib/blake2s - Split up test function to halve stack usage
      lib/mpi: Fix buffer overrun when SG is too long
      crypto: caam - Avoid GCC memset bug warning
      crypto: sun8i-ss - Remove GFP_DMA and add DMA alignment padding
      crypto: caam - Remove GFP_DMA and add DMA alignment padding
      crypto: talitos - Remove GFP_DMA and add DMA alignment padding
      crypto: p10-aes-gcm - Revert implementation
      crypto: essiv - Handle EBUSY correctly
      crypto: seqiv - Handle EBUSY correctly
      crypto: cryptd - Remove unnecessary skcipher_request_zero
      crypto: bcm - Use subrequest for fallback
      crypto: caam - Use ahash_request_complete
      crypto: xts - Handle EBUSY correctly
      crypto: engine - Fix excess parameter doc warning
      Revert "crypto: rsa-pkcs1pad - Replace GFP_ATOMIC with GFP_KERNEL in pkcs1pad_encrypt_sign_complete"
      crypto: img-hash - Fix sparse endianness warning
      crypto: marvell/cesa - Use crypto_wait_req
      hwrng: starfive - Enable compile testing
      crypto: arm64/aes-ccm - Rewrite skcipher walker loop
      crypto: safexcel - Use crypto_wait_req
      crypto: arm64/sm4-gcm - Fix possible crash in GCM cryption
      crypto: api - Add scaffolding to change completion function signature
      dm: Add scaffolding to change completion function signature
      net: macsec: Add scaffolding to change completion function signature
      fs: ecryptfs: Use crypto_wait_req
      Bluetooth: Use crypto_wait_req
      net: ipv4: Add scaffolding to change completion function signature
      net: ipv6: Add scaffolding to change completion function signature
      tipc: Add scaffolding to change completion function signature
      tls: Only use data field in crypto completion function
      KEYS: DH: Use crypto_wait_req
      crypto: cryptd - Use subreq for AEAD
      crypto: acompress - Use crypto_request_complete
      crypto: aead - Use crypto_request_complete
      crypto: akcipher - Use crypto_request_complete
      crypto: hash - Use crypto_request_complete
      crypto: kpp - Use crypto_request_complete
      crypto: skcipher - Use crypto_request_complete
      crypto: engine - Use crypto_request_complete
      crypto: rsa-pkcs1pad - Use akcipher_request_complete
      crypto: cryptd - Use request_complete helpers
      crypto: atmel - Use request_complete helpers
      crypto: artpec6 - Use request_complete helpers
      crypto: bcm - Use request_complete helpers
      crypto: cpt - Use request_complete helpers
      crypto: nitrox - Use request_complete helpers
      crypto: ccp - Use request_complete helpers
      crypto: chelsio - Use request_complete helpers
      crypto: hifn_795x - Use request_complete helpers
      crypto: hisilicon - Use request_complete helpers
      crypto: img-hash - Use request_complete helpers
      crypto: safexcel - Use request_complete helpers
      crypto: ixp4xx - Use request_complete helpers
      crypto: marvell/cesa - Use request_complete helpers
      crypto: octeontx - Use request_complete helpers
      crypto: octeontx2 - Use request_complete helpers
      crypto: mxs-dcp - Use request_complete helpers
      crypto: qat - Use request_complete helpers
      crypto: qce - Use request_complete helpers
      crypto: s5p-sss - Use request_complete helpers
      crypto: sahara - Use request_complete helpers
      crypto: talitos - Use request_complete helpers
      crypto: api - Use data directly in completion function
      dm: Remove completion function scaffolding
      net: macsec: Remove completion function scaffolding
      net: ipv4: Remove completion function scaffolding
      net: ipv6: Remove completion function scaffolding
      tipc: Remove completion function scaffolding
      tls: Remove completion function scaffolding
      crypto: api - Remove completion function scaffolding
      tls: Pass rec instead of aead_req into tls_encrypt_done
      crypto: ecc - Silence sparse warning
      crypto: nx - Fix sparse warnings
      crypto: crypto4xx - Call dma_unmap_page when done
      crypto: proc - Print fips status
      crypto: aspeed - Fix modular aspeed-acry

Jia Jie Ho (2):
      dt-bindings: rng: Add StarFive TRNG module
      hwrng: starfive - Add TRNG driver for StarFive SoC

Koba Ko (1):
      crypto: ccp - Failure on re-initialization due to duplicate sysfs filename

Linus Walleij (7):
      crypto: stm32 - Use accelerated readsl/writesl
      dt-bindings: crypto: Let STM32 define Ux500 HASH
      crypto: stm32/hash - Simplify code
      crypto: stm32/hash - Use existing busy poll function
      crypto: stm32/hash - Wait for idle before final CPU xmit
      crypto: stm32/hash - Support Ux500 hash
      crypto: ux500/hash - delete driver

Lucas Segarra Fernandez (2):
      crypto: qat - extend buffer list logic interface
      crypto: qat - add qat_zlib_deflate

Lukas Bulwahn (4):
      crypto: ux500 - update debug config after ux500 cryp driver removal
      crypto: hisilicon - remove redundant config PCI dependency for some CRYPTO_DEV_HISI configs
      crypto: atmel-i2c - avoid defines prefixed with CONFIG
      MAINTAINERS: repair file entry for STARFIVE TRNG DRIVER

Meadhbh (1):
      Documentation: qat: change kernel version

Meadhbh Fitzpatrick (1):
      crypto: qat - fix spelling mistakes from 'bufer' to 'buffer'

Neal Liu (5):
      crypto: aspeed - Add ACRY RSA driver
      ARM: dts: aspeed: Add ACRY/AHBC device controller node
      dt-bindings: crypto: add documentation for Aspeed ACRY
      dt-bindings: bus: add documentation for Aspeed AHBC
      crypto: aspeed - fix type warnings

Nicolai Stange (4):
      crypto: xts - restrict key lengths to approved values in FIPS mode
      crypto: testmgr - disallow plain cbcmac(aes) in FIPS mode
      crypto: testmgr - disallow plain ghash in FIPS mode
      crypto: testmgr - allow ecdsa-nist-p256 and -p384 in FIPS mode

Peter Lafreniere (4):
      crypto: x86 - exit fpu context earlier in ECB/CBC macros
      crypto: x86/blowfish - Remove unused encode parameter
      crypto: x86/blowfish - Convert to use ECB/CBC helpers
      crypto: x86/blowfish - Eliminate use of SYM_TYPED_FUNC_START in asm

Samuel Holland (2):
      dt-bindings: crypto: sun8i-ce: Add compatible for D1
      crypto: sun8i-ce - Add TRNG clock to the D1 variant

Sergiu Moga (1):
      crypto: atmel - Add capability case for the 0x600 SHA and AES IP versions

Taehee Yoo (8):
      crypto: x86/aria - add keystream array into request ctx
      crypto: x86/aria - do not use magic number offsets of aria_ctx
      crypto: x86/aria - implement aria-avx2
      crypto: x86/aria - implement aria-avx512
      crypto: x86/aria-avx - fix build failure with old binutils
      crypto: x86/aria-avx2 - fix build failure with old binutils
      crypto: x86/aria-avx512 - fix build failure with old binutils
      crypto: x86/aria-avx - Do not use avx2 instructions

Tianjia Zhang (1):
      crypto: arm64/sm4-ccm - Rewrite skcipher walker loop

Tom Lendacky (3):
      crypto: ccp - Provide MMIO register naming for documenation
      crypto: ccp - Add a firmware definition for EPYC gen 4 processors
      crypto: ccp - Flush the SEV-ES TMR memory before giving it to firmware

Uwe Kleine-König (1):
      crypto: atmel - Drop unused id parameter from atmel_i2c_probe()

Vladis Dronov (3):
      crypto: xts - drop xts_check_key()
      crypto: s390/aes - drop redundant xts key check
      crypto: testmgr - disallow certain DRBG hash functions in FIPS mode

Weili Qian (5):
      crypto: hisilicon/qm - remove some unused defines
      crypto: hisilicon/qm - use min() instead of min_t()
      crypto: hisilicon/qm - change function names
      crypto: hisilicon/qm - update comments to match function
      crypto: hisilicon/qm - fix coding style issues

Yang Yingliang (1):
      crypto: aspeed - change aspeed_acry_akcipher_algs to static

Zhang Yiqun (1):
      crypto: testmgr - add diff-splits of src/dst into default cipher config

ye xingchen (1):
      crypto: aspeed - Use devm_platform_get_and_ioremap_resource()

 Documentation/ABI/testing/sysfs-driver-qat         |    4 +-
 .../bindings/bus/aspeed,ast2600-ahbc.yaml          |   37 +
 .../bindings/crypto/allwinner,sun8i-ce.yaml        |   33 +-
 .../bindings/crypto/aspeed,ast2600-acry.yaml       |   49 +
 .../devicetree/bindings/crypto/st,stm32-hash.yaml  |   23 +-
 .../bindings/rng/starfive,jh7110-trng.yaml         |   55 +
 MAINTAINERS                                        |    8 +-
 arch/arm/boot/dts/aspeed-g6.dtsi                   |   13 +
 arch/arm/crypto/sha1_glue.c                        |   14 +-
 arch/arm64/crypto/aes-ce-ccm-glue.c                |   57 +-
 arch/arm64/crypto/ghash-ce-glue.c                  |  145 +-
 arch/arm64/crypto/sm4-ce-ccm-glue.c                |   44 +-
 arch/arm64/crypto/sm4-ce-gcm-glue.c                |   51 +-
 arch/s390/crypto/aes_s390.c                        |    4 -
 arch/s390/crypto/paes_s390.c                       |    2 +-
 arch/x86/Kconfig.assembler                         |    5 +
 arch/x86/crypto/Kconfig                            |   38 +
 arch/x86/crypto/Makefile                           |    6 +
 arch/x86/crypto/aria-aesni-avx-asm_64.S            |  172 +-
 arch/x86/crypto/aria-aesni-avx2-asm_64.S           | 1441 ++++++++++++++
 arch/x86/crypto/aria-avx.h                         |   48 +-
 arch/x86/crypto/aria-gfni-avx512-asm_64.S          |  971 ++++++++++
 arch/x86/crypto/aria_aesni_avx2_glue.c             |  254 +++
 arch/x86/crypto/aria_aesni_avx_glue.c              |   49 +-
 arch/x86/crypto/aria_gfni_avx512_glue.c            |  250 +++
 arch/x86/crypto/blowfish-x86_64-asm_64.S           |   71 +-
 arch/x86/crypto/blowfish_glue.c                    |  200 +-
 arch/x86/crypto/ecb_cbc_helpers.h                  |   19 +-
 arch/x86/crypto/ghash-clmulni-intel_asm.S          |    6 +-
 arch/x86/crypto/ghash-clmulni-intel_glue.c         |   45 +-
 arch/x86/kernel/asm-offsets.c                      |    8 +
 crypto/adiantum.c                                  |    5 +-
 crypto/af_alg.c                                    |    6 +-
 crypto/ahash.c                                     |  195 +-
 crypto/api.c                                       |    4 +-
 crypto/aria_generic.c                              |    4 +
 crypto/authenc.c                                   |   14 +-
 crypto/authencesn.c                                |   15 +-
 crypto/ccm.c                                       |    9 +-
 crypto/chacha20poly1305.c                          |   40 +-
 crypto/cryptd.c                                    |  290 +--
 crypto/crypto_engine.c                             |    8 +-
 crypto/cts.c                                       |   12 +-
 crypto/dh.c                                        |    5 +-
 crypto/ecc.c                                       |    6 +-
 crypto/essiv.c                                     |   15 +-
 crypto/gcm.c                                       |   36 +-
 crypto/hctr2.c                                     |    5 +-
 crypto/lrw.c                                       |    4 +-
 crypto/pcrypt.c                                    |    4 +-
 crypto/proc.c                                      |    6 +
 crypto/rsa-pkcs1pad.c                              |   51 +-
 crypto/seqiv.c                                     |    7 +-
 crypto/shash.c                                     |    4 +-
 crypto/skcipher.c                                  |   22 +-
 crypto/tcrypt.c                                    |    8 +-
 crypto/tcrypt.h                                    |    2 +-
 crypto/testmgr.c                                   |   16 +-
 crypto/wp512.c                                     |    2 +-
 crypto/xts.c                                       |   20 +-
 drivers/char/hw_random/Kconfig                     |   10 +
 drivers/char/hw_random/Makefile                    |    1 +
 drivers/char/hw_random/jh7110-trng.c               |  393 ++++
 drivers/crypto/Kconfig                             |   10 -
 drivers/crypto/Makefile                            |    1 -
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  |    1 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       |    2 +-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    |    4 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c  |   13 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c  |    4 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c  |   11 +-
 drivers/crypto/amcc/crypto4xx_core.c               |   10 +-
 drivers/crypto/aspeed/Kconfig                      |   11 +
 drivers/crypto/aspeed/Makefile                     |    4 +
 drivers/crypto/aspeed/aspeed-acry.c                |  828 +++++++++
 drivers/crypto/aspeed/aspeed-hace.c                |    5 +-
 drivers/crypto/aspeed/aspeed-hace.h                |    2 +-
 drivers/crypto/atmel-aes.c                         |    7 +-
 drivers/crypto/atmel-ecc.c                         |    3 +-
 drivers/crypto/atmel-i2c.c                         |    4 +-
 drivers/crypto/atmel-i2c.h                         |    4 +-
 drivers/crypto/atmel-sha.c                         |   10 +-
 drivers/crypto/atmel-sha204a.c                     |    3 +-
 drivers/crypto/atmel-tdes.c                        |    4 +-
 drivers/crypto/axis/artpec6_crypto.c               |   14 +-
 drivers/crypto/bcm/cipher.c                        |  102 +-
 drivers/crypto/bcm/cipher.h                        |    7 +-
 drivers/crypto/caam/blob_gen.c                     |    2 +-
 drivers/crypto/caam/caamalg.c                      |   16 +-
 drivers/crypto/caam/caamalg_qi.c                   |   16 +-
 drivers/crypto/caam/caamalg_qi2.c                  |   56 +-
 drivers/crypto/caam/caamalg_qi2.h                  |   10 +-
 drivers/crypto/caam/caamhash.c                     |   18 +-
 drivers/crypto/caam/caampkc.c                      |   31 +-
 drivers/crypto/caam/caamprng.c                     |   12 +-
 drivers/crypto/caam/caamrng.c                      |   11 +-
 drivers/crypto/caam/ctrl.c                         |    4 +-
 drivers/crypto/caam/desc_constr.h                  |    3 +-
 drivers/crypto/caam/key_gen.c                      |    2 +-
 drivers/crypto/caam/qi.c                           |    4 +-
 drivers/crypto/caam/qi.h                           |   12 +-
 drivers/crypto/cavium/cpt/cptvf_algs.c             |   10 +-
 drivers/crypto/cavium/nitrox/nitrox_aead.c         |    4 +-
 drivers/crypto/cavium/nitrox/nitrox_skcipher.c     |    8 +-
 drivers/crypto/ccp/ccp-crypto-main.c               |   12 +-
 drivers/crypto/ccp/ccp-dmaengine.c                 |   21 +-
 drivers/crypto/ccp/sev-dev.c                       |   16 +-
 drivers/crypto/ccp/sp-pci.c                        |   46 +-
 drivers/crypto/ccree/cc_cipher.c                   |    2 +-
 drivers/crypto/chelsio/chcr_algo.c                 |    6 +-
 drivers/crypto/hifn_795x.c                         |    4 +-
 drivers/crypto/hisilicon/Kconfig                   |    8 +-
 drivers/crypto/hisilicon/qm.c                      |   54 +-
 drivers/crypto/hisilicon/sec/sec_algs.c            |    6 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c         |   10 +-
 drivers/crypto/hisilicon/sgl.c                     |    1 -
 drivers/crypto/img-hash.c                          |   12 +-
 drivers/crypto/inside-secure/safexcel.c            |   15 +-
 drivers/crypto/inside-secure/safexcel.h            |    6 -
 drivers/crypto/inside-secure/safexcel_cipher.c     |   21 +-
 drivers/crypto/inside-secure/safexcel_hash.c       |   54 +-
 drivers/crypto/ixp4xx_crypto.c                     |    4 +-
 drivers/crypto/marvell/cesa/cesa.c                 |    4 +-
 drivers/crypto/marvell/cesa/hash.c                 |   41 +-
 drivers/crypto/marvell/cesa/tdma.c                 |    2 +-
 drivers/crypto/marvell/octeontx/otx_cptvf_algs.c   |    6 +-
 drivers/crypto/marvell/octeontx2/Makefile          |   11 +-
 drivers/crypto/marvell/octeontx2/cn10k_cpt.c       |    9 +-
 drivers/crypto/marvell/octeontx2/cn10k_cpt.h       |    2 -
 drivers/crypto/marvell/octeontx2/otx2_cpt_common.h |    2 -
 .../marvell/octeontx2/otx2_cpt_mbox_common.c       |   14 +-
 drivers/crypto/marvell/octeontx2/otx2_cptlf.c      |   11 +
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c |    2 +
 drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c |    6 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c |    2 +
 drivers/crypto/mxs-dcp.c                           |    8 +-
 drivers/crypto/nx/nx-common-powernv.c              |   13 +-
 drivers/crypto/nx/nx-common-pseries.c              |    6 +-
 .../qat/qat_common/adf_transport_access_macros.h   |    2 +-
 drivers/crypto/qat/qat_common/qat_algs.c           |    6 +-
 drivers/crypto/qat/qat_common/qat_algs_send.c      |    3 +-
 drivers/crypto/qat/qat_common/qat_bl.c             |  115 +-
 drivers/crypto/qat/qat_common/qat_bl.h             |    4 +-
 drivers/crypto/qat/qat_common/qat_comp_algs.c      |  169 +-
 drivers/crypto/qat/qat_common/qat_compression.c    |    2 +-
 drivers/crypto/qat/qat_common/qat_crypto.c         |    2 +-
 drivers/crypto/qce/core.c                          |    4 +-
 drivers/crypto/s5p-sss.c                           |    8 +-
 drivers/crypto/sahara.c                            |    4 +-
 drivers/crypto/stm32/stm32-cryp.c                  |   37 +-
 drivers/crypto/stm32/stm32-hash.c                  |  266 ++-
 drivers/crypto/talitos.c                           |    6 +-
 drivers/crypto/ux500/Kconfig                       |   22 -
 drivers/crypto/ux500/Makefile                      |    7 -
 drivers/crypto/ux500/hash/Makefile                 |   11 -
 drivers/crypto/ux500/hash/hash_alg.h               |  398 ----
 drivers/crypto/ux500/hash/hash_core.c              | 1966 --------------------
 .../crypto/virtio/virtio_crypto_akcipher_algs.c    |    2 +-
 drivers/md/dm-crypt.c                              |    8 +-
 drivers/md/dm-integrity.c                          |    4 +-
 drivers/net/macsec.c                               |    8 +-
 fs/ecryptfs/crypto.c                               |   30 +-
 include/crypto/aead.h                              |   20 +-
 include/crypto/algapi.h                            |    6 +
 include/crypto/if_alg.h                            |    4 +-
 include/crypto/internal/acompress.h                |    2 +-
 include/crypto/internal/aead.h                     |    2 +-
 include/crypto/internal/akcipher.h                 |    2 +-
 include/crypto/internal/hash.h                     |    2 +-
 include/crypto/internal/kpp.h                      |    2 +-
 include/crypto/internal/skcipher.h                 |    2 +-
 include/crypto/scatterwalk.h                       |    4 +-
 include/crypto/xts.h                               |   25 +-
 include/linux/crypto.h                             |    4 +-
 include/linux/hisi_acc_qm.h                        |    5 +-
 lib/crypto/blake2s-selftest.c                      |   25 +-
 lib/mpi/mpicoder.c                                 |    3 +-
 net/bluetooth/ecdh_helper.c                        |   37 +-
 net/ipv4/ah4.c                                     |    8 +-
 net/ipv4/esp4.c                                    |   20 +-
 net/ipv6/ah6.c                                     |    8 +-
 net/ipv6/esp6.c                                    |   20 +-
 net/tipc/crypto.c                                  |   12 +-
 net/tls/tls.h                                      |    2 +
 net/tls/tls_sw.c                                   |   42 +-
 security/keys/dh.c                                 |   30 +-
 186 files changed, 6379 insertions(+), 4053 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
 create mode 100644 Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml
 create mode 100644 arch/x86/crypto/aria-aesni-avx2-asm_64.S
 create mode 100644 arch/x86/crypto/aria-gfni-avx512-asm_64.S
 create mode 100644 arch/x86/crypto/aria_aesni_avx2_glue.c
 create mode 100644 arch/x86/crypto/aria_gfni_avx512_glue.c
 create mode 100644 drivers/char/hw_random/jh7110-trng.c
 create mode 100644 drivers/crypto/aspeed/aspeed-acry.c
 delete mode 100644 drivers/crypto/ux500/Kconfig
 delete mode 100644 drivers/crypto/ux500/Makefile
 delete mode 100644 drivers/crypto/ux500/hash/Makefile
 delete mode 100644 drivers/crypto/ux500/hash/hash_alg.h
 delete mode 100644 drivers/crypto/ux500/hash/hash_core.c

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
