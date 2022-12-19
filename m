Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C92651542
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiLSWEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiLSWDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:03:33 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC6A140A3;
        Mon, 19 Dec 2022 14:03:20 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJIMHe3023000;
        Mon, 19 Dec 2022 22:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pps0720;
 bh=U+9LmSfJrmifDkd3o4tFytf2ekYsVzZwu3pQwojmLRE=;
 b=SFdOTnJIMTYUvvchDBj9ZCD7J3Ae8sEq4gtrhXnK+lJEQ5Ty4GGbBvwDTfZbh1pSouz2
 C4ugwCN3LIPv5RiGeuuWv/oQiqqw/JFPutX1t1xwYkQc9KmsA9eDGyb+24vw0AjelvZq
 lrLxsqHCu6So5HH0ZAgF3nfN5c57Z+thEda77XeHz/1DR+CUUB3931txIuUEpLS3GKQ6
 8naTWQr5ScUkPfnDX1oP4+M+fYYdGbj75wb4TUGRvKpUlZTHAhutRLi8weUxaiIokznB
 6CJLt2S1eoYnzlZT1wCfJzCqakk0P6izmJLte0ary5SCXZZe3qvMovWLorA9F12egVT1 4A== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mjw61156n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 22:02:41 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id B1D62807136;
        Mon, 19 Dec 2022 22:02:39 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id A77C18061BF;
        Mon, 19 Dec 2022 22:02:36 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
        ardb@kernel.org, ap420073@gmail.com, David.Laight@ACULAB.COM,
        ebiggers@kernel.org, tim.c.chen@linux.intel.com, peter@n8pjl.ca,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 00/13] crypto: x86 - yield FPU context during long loops
Date:   Mon, 19 Dec 2022 16:02:10 -0600
Message-Id: <20221219220223.3982176-1-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
X-Proofpoint-ORIG-GUID: m8Kjghu9v1hYc81v8j9rSnx9vWeKV35N
X-Proofpoint-GUID: m8Kjghu9v1hYc81v8j9rSnx9vWeKV35N
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1011 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190194
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an offshoot of the previous patch series at:
  https://lore.kernel.org/linux-crypto/20221219202910.3063036-1-elliott@hpe.com

Add a kernel_fpu_yield() function for x86 crypto drivers to call
periodically during long loops.

Test results
============
I created 28 tcrypt modules so modprobe can run concurrent tests,
added 1 MiB functional and speed tests to tcrypt, and ran three processes
spawning 28 subprocesses (one per physical CPU core) each looping forever
through all the tcrypt test modes. This keeps the system quite busy,
generating RCU stalls and soft lockups during both generic and x86
crypto function processing.

In conjunction with these patch series:
* [PATCH 0/8] crypto: kernel-doc for assembly language
  https://lore.kernel.org/linux-crypto/20221219185555.433233-1-elliott@hpe.com
* [PATCH 0/3] crypto/rcu: suppress unnecessary CPU stall warnings
  https://lore.kernel.org/linux-crypto/20221219202910.3063036-1-elliott@hpe.com
* [PATCH 0/3] crypto: yield at end of operations
  https://lore.kernel.org/linux-crypto/20221219203733.3063192-1-elliott@hpe.com

while using the default RCU values (60 s stalls, 21 s expedited stalls),
several nights of testing did not result in any RCU stall warnings or soft
lockups in any of these preemption modes:
   preempt=none
   preempt=voluntary
   preempt=full

Setting the shortest possible RCU timeouts (3 s, 20 ms) did still result
in RCU stalls, but only about one every 2 hours, and not occurring
on particular modules like sha512_ssse3 and sm4-generic.

systemd usually crashes and restarts when its journal becomes full from
all the tcrypt printk messages. Without the patches, that triggered more
RCU stall reports and soft lockups; with the patches, only userspace
seems perturbed.


Robert Elliott (13):
  x86:  protect simd.h header file
  x86: add yield FPU context utility function
  crypto: x86/sha - yield FPU context during long loops
  crypto: x86/crc - yield FPU context during long loops
  crypto: x86/sm3 - yield FPU context during long loops
  crypto: x86/ghash - use u8 rather than char
  crypto: x86/ghash - restructure FPU context saving
  crypto: x86/ghash - yield FPU context during long loops
  crypto: x86/poly - yield FPU context only when needed
  crypto: x86/aegis - yield FPU context during long loops
  crypto: x86/blake - yield FPU context only when needed
  crypto: x86/chacha - yield FPU context only when needed
  crypto: x86/aria - yield FPU context only when needed

 arch/x86/crypto/aegis128-aesni-glue.c      |  49 ++++++---
 arch/x86/crypto/aria_aesni_avx_glue.c      |   7 +-
 arch/x86/crypto/blake2s-glue.c             |  41 +++----
 arch/x86/crypto/chacha_glue.c              |  22 ++--
 arch/x86/crypto/crc32-pclmul_glue.c        |  49 +++++----
 arch/x86/crypto/crc32c-intel_glue.c        | 118 ++++++++++++++------
 arch/x86/crypto/crct10dif-pclmul_glue.c    |  65 ++++++++---
 arch/x86/crypto/ghash-clmulni-intel_asm.S  |   6 +-
 arch/x86/crypto/ghash-clmulni-intel_glue.c |  37 +++++--
 arch/x86/crypto/nhpoly1305-avx2-glue.c     |  22 ++--
 arch/x86/crypto/nhpoly1305-sse2-glue.c     |  22 ++--
 arch/x86/crypto/poly1305_glue.c            |  47 ++++----
 arch/x86/crypto/polyval-clmulni_glue.c     |  46 +++++---
 arch/x86/crypto/sha1_avx2_x86_64_asm.S     |   6 +-
 arch/x86/crypto/sha1_ni_asm.S              |   8 +-
 arch/x86/crypto/sha1_ssse3_glue.c          | 120 +++++++++++++++++----
 arch/x86/crypto/sha256_ni_asm.S            |   8 +-
 arch/x86/crypto/sha256_ssse3_glue.c        | 115 ++++++++++++++++----
 arch/x86/crypto/sha512_ssse3_glue.c        |  89 ++++++++++++---
 arch/x86/crypto/sm3_avx_glue.c             |  34 +++++-
 arch/x86/include/asm/simd.h                |  23 ++++
 include/crypto/internal/blake2s.h          |   8 +-
 lib/crypto/blake2s-generic.c               |  12 +--
 23 files changed, 687 insertions(+), 267 deletions(-)

-- 
2.38.1

