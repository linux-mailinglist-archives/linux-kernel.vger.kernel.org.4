Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FB062B214
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiKPEOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiKPEOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:12 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EA81E3D2;
        Tue, 15 Nov 2022 20:14:11 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG3dW60009594;
        Wed, 16 Nov 2022 04:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=Qj7j8pjop4erRoPwUhbMI2fTBopxdbJ9Z+dRh60Lpqg=;
 b=fmQ0uzAffrN3vKxRGzwxxQdF4OQCG6GmrXubruKlImK33SFeLG3Wk91NAckXRwIWgUhA
 OH4pElOQmM6DxpFtUCyz2ublf5VncVHKIx9rLeIroqDKcB7doQng7asAN6jRBXkYwiqm
 +5HW0lEVT9PYPI132IN1ViuXrqKy1/BmTAUwWK6QrICc3pZna4x8SGEAD4cULdoermLX
 SrAloAtvkbTjCn7Y8W5rhZdRf4Nul4EwVIe1OHC4TXKY8S5WHd3ecbfNFIi2cqsxOMpr
 Sv5XRQslnbp0DX7eHh9BZCMizLXMNT+JDIz7aJHR0THbaFkNxnSXzy0/8GPucdtPGmtc tA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kvr5486s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:13:54 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id A2E184B5C7;
        Wed, 16 Nov 2022 04:13:52 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id C91D6808B9A;
        Wed, 16 Nov 2022 04:13:50 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 00/24] crypto: fix RCU stalls
Date:   Tue, 15 Nov 2022 22:13:18 -0600
Message-Id: <20221116041342.3841-1-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103042740.6556-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
X-Proofpoint-ORIG-GUID: k2vNFqgcAFtLJIgVDuly1wSfrl6F68bQ
X-Proofpoint-GUID: k2vNFqgcAFtLJIgVDuly1wSfrl6F68bQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the RCU stalls triggered by the x86 crypto
modules discussed in
https://lore.kernel.org/all/MW5PR84MB18426EBBA3303770A8BC0BDFAB759@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM/

Two root causes were:
- too much data processed between kernel_fpu_begin and
  kernel_fpu_end calls (which are heavily used by the x86
  optimized drivers)
- tcrypt not calling cond_resched during speed test loops

These problems have always been lurking, but improving the
loading of the x86/sha512 module led to it happening a lot
during boot when using SHA-512 for module signature checking.

Fixing these problems makes it safer to improve loading
the rest of the x86 modules like the sha512 module.

This series only handles the x86 modules.

Version 4 tackles lingering comments from version 2.

1. Unlike the hash functions, skcipher and aead functions
accept pointers to scatter-gather lists, and the helper
functions that walk through those lists limit processing
to a page size at a time.

The aegis module did everything inside one pair of
kernel_fpu_begin() and kernel_fpu_end() calls including
walking through the sglist, so it could preempt the CPU
without constraint.

The aesni aead functions for gcm process the additional
data (data that is included in the authentication tag
calculation but not encrypted) in one FPU context, so
that can be a problem. This will require some asm changes
to fix. However, I don't think that is a typical use case,
so this series defers fixing that.

The series adds device table matching for all the x86
crypto modules.

2. I replaced all the positive and negative prints with
module parameters, including enough clues in modinfo
descriptions that a user can determine what is
working and not working.


Robert Elliott (24):
  crypto: tcrypt - test crc32
  crypto: tcrypt - test nhpoly1305
  crypto: tcrypt - reschedule during cycles speed tests
  crypto: x86/sha - limit FPU preemption
  crypto: x86/crc - limit FPU preemption
  crypto: x86/sm3 - limit FPU preemption
  crypto: x86/ghash - use u8 rather than char
  crypto: x86/ghash - restructure FPU context saving
  crypto: x86/ghash - limit FPU preemption
  crypto: x86/poly - limit FPU preemption
  crypto: x86/aegis - limit FPU preemption
  crypto: x86/sha - register all variations
  crypto: x86/sha - minimize time in FPU context
  crypto: x86/sha - load based on CPU features
  crypto: x86/crc - load based on CPU features
  crypto: x86/sm3 - load based on CPU features
  crypto: x86/poly - load based on CPU features
  crypto: x86/ghash - load based on CPU features
  crypto: x86/aesni - avoid type conversions
  crypto: x86/ciphers - load based on CPU features
  crypto: x86 - report used CPU features via module parameters
  crypto: x86 - report missing CPU features via module parameters
  crypto: x86 - report suboptimal CPUs via module parameters
  crypto: x86 - standarize module descriptions

 arch/x86/crypto/aegis128-aesni-glue.c      |  66 +++--
 arch/x86/crypto/aesni-intel_glue.c         |  45 ++--
 arch/x86/crypto/aria_aesni_avx_glue.c      |  43 ++-
 arch/x86/crypto/blake2s-glue.c             |  18 +-
 arch/x86/crypto/blowfish_glue.c            |  39 ++-
 arch/x86/crypto/camellia_aesni_avx2_glue.c |  40 ++-
 arch/x86/crypto/camellia_aesni_avx_glue.c  |  38 ++-
 arch/x86/crypto/camellia_glue.c            |  37 ++-
 arch/x86/crypto/cast5_avx_glue.c           |  30 ++-
 arch/x86/crypto/cast6_avx_glue.c           |  30 ++-
 arch/x86/crypto/chacha_glue.c              |  18 +-
 arch/x86/crypto/crc32-pclmul_asm.S         |   6 +-
 arch/x86/crypto/crc32-pclmul_glue.c        |  39 ++-
 arch/x86/crypto/crc32c-intel_glue.c        |  66 +++--
 arch/x86/crypto/crct10dif-pclmul_glue.c    |  56 ++--
 arch/x86/crypto/curve25519-x86_64.c        |  29 +-
 arch/x86/crypto/des3_ede_glue.c            |  36 ++-
 arch/x86/crypto/ghash-clmulni-intel_asm.S  |   4 +-
 arch/x86/crypto/ghash-clmulni-intel_glue.c |  45 ++--
 arch/x86/crypto/nhpoly1305-avx2-glue.c     |  36 ++-
 arch/x86/crypto/nhpoly1305-sse2-glue.c     |  22 +-
 arch/x86/crypto/poly1305_glue.c            |  56 +++-
 arch/x86/crypto/polyval-clmulni_glue.c     |  31 ++-
 arch/x86/crypto/serpent_avx2_glue.c        |  36 ++-
 arch/x86/crypto/serpent_avx_glue.c         |  31 ++-
 arch/x86/crypto/serpent_sse2_glue.c        |  13 +-
 arch/x86/crypto/sha1_ssse3_glue.c          | 298 ++++++++++++++-------
 arch/x86/crypto/sha256_ssse3_glue.c        | 294 +++++++++++++-------
 arch/x86/crypto/sha512_ssse3_glue.c        | 205 +++++++++-----
 arch/x86/crypto/sm3_avx_glue.c             |  70 +++--
 arch/x86/crypto/sm4_aesni_avx2_glue.c      |  37 ++-
 arch/x86/crypto/sm4_aesni_avx_glue.c       |  39 ++-
 arch/x86/crypto/twofish_avx_glue.c         |  29 +-
 arch/x86/crypto/twofish_glue.c             |  12 +-
 arch/x86/crypto/twofish_glue_3way.c        |  36 ++-
 crypto/aes_ti.c                            |   2 +-
 crypto/blake2b_generic.c                   |   2 +-
 crypto/blowfish_common.c                   |   2 +-
 crypto/crct10dif_generic.c                 |   2 +-
 crypto/curve25519-generic.c                |   1 +
 crypto/sha256_generic.c                    |   2 +-
 crypto/sha512_generic.c                    |   2 +-
 crypto/sm3.c                               |   2 +-
 crypto/sm4.c                               |   2 +-
 crypto/tcrypt.c                            |  56 ++--
 crypto/twofish_common.c                    |   2 +-
 crypto/twofish_generic.c                   |   2 +-
 47 files changed, 1377 insertions(+), 630 deletions(-)

-- 
2.38.1

