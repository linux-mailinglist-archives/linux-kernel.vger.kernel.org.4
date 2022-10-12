Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656D75FCDAC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJLWAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJLV76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:59:58 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CB613EBF;
        Wed, 12 Oct 2022 14:59:54 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CL20nT026157;
        Wed, 12 Oct 2022 21:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=FCzW/PT/uw77uOxhpTpAM/DZaKzIjK1qAD6ve+3PUXo=;
 b=jD4dhw0G8Jm/MzrIYZbHJwdSd0/pu5AywUacfF7IQw1XAGbkb6AAoSTniHXiMTO18ho6
 5S4UWPIzbZSW08sj62rhmKYVzUK7GcPuOaoRKsJ+AAnjvvQqqYGwRVXhViYmTXiEzP1v
 3idh5/P3f0lLVTUfWfODgZVZsQwjIZdhCW9Tq6sbmd9HuY4nHQF2XeYS0ogrAaRRFkX3
 BIr6GHOGC50Ur4QTDBzulFLVNmOgeAOupMYHhg6dROYEq74I2Yfvyuw1DrP5nUFL+8vL
 ijUWl6ortABOPk1YWKt8ypAwa5vcizkEuEedn3k1GTJLr+s6N2SLyAh08dbhbNRZX4GV hQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k654srdm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 21:59:42 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 522992958F;
        Wed, 12 Oct 2022 21:59:41 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 83E4E8036BF;
        Wed, 12 Oct 2022 21:59:40 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 00/19] crypto: x86 - fix RCU stalls
Date:   Wed, 12 Oct 2022 16:59:12 -0500
Message-Id: <20221012215931.3896-1-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221006223151.22159-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
X-Proofpoint-GUID: mTjC9aFKPckWnf_-2zIGq7zQhfC7dkQg
X-Proofpoint-ORIG-GUID: mTjC9aFKPckWnf_-2zIGq7zQhfC7dkQg
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120138
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

Testing
=======
The most effective testing was by enabling
  CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y

which creates random test vectors and compares the results
of the CPU-optimized function to the generic function,
and running two threads of repeated modprobe commands
to exercise those tests:
  watch -n 0 modprobe tcrypt mode=200
  watch -n 0 ./tcrypt_sweep

where tcrypt_sweep walks through all the test modes:
#!/usr/bin/perl
use strict;

my @modes;

open SOURCE, "<", "/home/me/linux/crypto/tcrypt.c" or die $!;
while (<SOURCE>) {
        if (/^\s+case ([0-9]+):$/) {
                push @modes, $1;
        }
}
close SOURCE;

foreach (@modes) {
        print "$_ ";

        # don't run mode 300, which runs 301-399
        # don't run mode 400, which runs 401-499
        if (($_ eq "0") || ($_ eq "300") || ($_ eq "400")) {
                system "echo \"===== Skipping special modprobe tcrypt mode=$_\" > /dev/kmsg";
        } else {
                system "echo \"Running modprobe tcrypt mode=$_\" > /dev/kmsg";
                system "modprobe tcrypt mode=$_";
        }
}



Robert Elliott (19):
  crypto: tcrypt - test crc32
  crypto: tcrypt - test nhpoly1305
  crypto: tcrypt - reschedule during cycles speed tests
  crypto: x86/sha - limit FPU preemption
  crypto: x86/crc - limit FPU preemption
  crypto: x86/sm3 - limit FPU preemption
  crypto: x86/ghash - restructure FPU context saving
  crypto: x86/ghash - limit FPU preemption
  crypto: x86 - use common macro for FPU limit
  crypto: x86/sha1, sha256 - load based on CPU features
  crypto: x86/crc - load based on CPU features
  crypto: x86/sm3 - load based on CPU features
  crypto: x86/ghash - load based on CPU features
  crypto: x86 - load based on CPU features
  crypto: x86 - add pr_fmt to all modules
  crypto: x86 - print CPU optimized loaded messages
  crypto: x86 - standardize suboptimal prints
  crypto: x86 - standardize not loaded prints
  crypto: x86/sha - register only the best function

 arch/x86/crypto/aegis128-aesni-glue.c      |  21 ++-
 arch/x86/crypto/aesni-intel_glue.c         |  31 ++--
 arch/x86/crypto/aria_aesni_avx_glue.c      |  19 +-
 arch/x86/crypto/blake2s-glue.c             |  34 +++-
 arch/x86/crypto/blowfish_glue.c            |  19 +-
 arch/x86/crypto/camellia_aesni_avx2_glue.c |  25 ++-
 arch/x86/crypto/camellia_aesni_avx_glue.c  |  24 ++-
 arch/x86/crypto/camellia_glue.c            |  20 ++-
 arch/x86/crypto/cast5_avx_glue.c           |  21 ++-
 arch/x86/crypto/cast6_avx_glue.c           |  21 ++-
 arch/x86/crypto/chacha_glue.c              |  35 +++-
 arch/x86/crypto/crc32-pclmul_asm.S         |   6 +-
 arch/x86/crypto/crc32-pclmul_glue.c        |  37 ++--
 arch/x86/crypto/crc32c-intel_glue.c        |  51 ++++--
 arch/x86/crypto/crct10dif-pclmul_glue.c    |  54 ++++--
 arch/x86/crypto/curve25519-x86_64.c        |  27 ++-
 arch/x86/crypto/des3_ede_glue.c            |  16 +-
 arch/x86/crypto/ghash-clmulni-intel_glue.c |  40 +++--
 arch/x86/crypto/nhpoly1305-avx2-glue.c     |  27 ++-
 arch/x86/crypto/nhpoly1305-sse2-glue.c     |  23 ++-
 arch/x86/crypto/poly1305_glue.c            |  64 +++++--
 arch/x86/crypto/polyval-clmulni_glue.c     |  14 +-
 arch/x86/crypto/serpent_avx2_glue.c        |  25 ++-
 arch/x86/crypto/serpent_avx_glue.c         |  21 ++-
 arch/x86/crypto/serpent_sse2_glue.c        |  19 +-
 arch/x86/crypto/sha1_ssse3_glue.c          | 188 +++++++++++--------
 arch/x86/crypto/sha256_ssse3_glue.c        | 198 ++++++++++++---------
 arch/x86/crypto/sha512_ssse3_glue.c        | 154 +++++++++-------
 arch/x86/crypto/sm3_avx_glue.c             |  52 +++++-
 arch/x86/crypto/sm4_aesni_avx2_glue.c      |  25 ++-
 arch/x86/crypto/sm4_aesni_avx_glue.c       |  23 ++-
 arch/x86/crypto/twofish_avx_glue.c         |  25 ++-
 arch/x86/crypto/twofish_glue.c             |  19 +-
 arch/x86/crypto/twofish_glue_3way.c        |  26 ++-
 crypto/tcrypt.c                            |  56 +++---
 35 files changed, 1060 insertions(+), 400 deletions(-)

-- 
2.37.3

