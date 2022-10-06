Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B3B5F712E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiJFWeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiJFWdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:33:42 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6E9142C81;
        Thu,  6 Oct 2022 15:33:20 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296Lo39p028827;
        Thu, 6 Oct 2022 22:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pps0720;
 bh=ALp7LmIWGW7Bht35fN1OZyKCGIqYAb60omVCfx808sA=;
 b=S+X3xmLKYTe+bXrn5g7YBbkr8y9RX8Ahjw09NPL0VkELfW7TjYdP4FyN0j1VQ5u6QhL/
 F8sxT4slDEV+bu3A9IXgyLT0/CFihNwG+ZgLbwrj/5I7MJidmnGDHmCgbGfINrq7t1qO
 asemx/oYhIDQKn1AFjzTCUFCD3gBc/O6gmK5fXpPOTzGicX6EwFGzabbPPKNrll/KwRY
 SWX27W8O1JqmEBeCD6WAcM6TtGZjtIR/a0Bb1sg0uTSIJ5uSxxVjhZyNmQ0a13EZ8/lp
 8+t0O2Ar1l8FK8DYuu3zCM+tKXU5omliumnpun9cZ3zgIJaWSrcVxiiC96owfuvahcfZ KA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k279509yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 22:32:13 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 11B3D8020A3;
        Thu,  6 Oct 2022 22:32:12 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 65345803AB6;
        Thu,  6 Oct 2022 22:32:12 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [RFC PATCH 0/7] crypto: x86 - fix RCU stalls 
Date:   Thu,  6 Oct 2022 17:31:44 -0500
Message-Id: <20221006223151.22159-1-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
X-Proofpoint-ORIG-GUID: y6-FMbCqX5jRgl5GEcPQKU4VViQzC1kR
X-Proofpoint-GUID: y6-FMbCqX5jRgl5GEcPQKU4VViQzC1kR
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to fix the RCU stalls triggered
by the x86 crypto drivers discussed in
https://lore.kernel.org/all/MW5PR84MB18426EBBA3303770A8BC0BDFAB759@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM/

The following x86 drivers are enforcing a 4 KiB limit today,
using either the SZ_4K macro or a direct reference to 4096 bytes:
    blake-2s, chacha, nhpoly1305, poly1305, polyval
I've included a patch to make them use the same macro name.

These are not currently limited, so I've included patches for
them:
   sha*, crc*, sm3, ghash

I originally encountered some RCU stalls with tcrypt in aesni:
    tcrypt: testing encryption speed of sync skcipher cts(cbc(aes)) using cts(cbc(aes-aesni))
    tcrypt: testing encryption speed of sync skcipher cfb(aes) using cfb(aes-aesni)
    tcrypt: testing decryption speed of sync skcipher cfb(aes) using cfb(aes-aesni)
but I don't see any problems in the source code. So, no patch
is proposed for that driver yet.

With various errors inserted, all the drivers failed self-tests or
hung boot, so the changes seem functionally correct. I haven't done
comprehensive tests of different data sizes and alignments, so
please consider this an RFC.

I added some counters (not posted) to the drivers to observe
their behavior. During boot, the finup function is actually
called much more often than update - 1500 calls for 2 GiB via
finup vs. 23 KiB via update. The patch breaks that into half
a million 4 KiB chunks.

/sys/module/sha512_ssse3/parameters/rob_call_finup:1541
/sys/module/sha512_ssse3/parameters/rob_call_finup_fpu:469325
/sys/module/sha512_ssse3/parameters/rob_call_update:174
/sys/module/sha512_ssse3/parameters/rob_call_update_fpu:32
/sys/module/sha512_ssse3/parameters/rob_len_finup:2123048456
/sys/module/sha512_ssse3/parameters/rob_len_update:24120


Robert Elliott (7):
  rcu: correct CONFIG_EXT_RCU_CPU_STALL_TIMEOUT descriptions
  crypto: x86/sha - limit FPU preemption
  crypto: x86/crc - limit FPU preemption
  crypto: x86/sm3 - limit FPU preemption
  crypto: x86/ghash - restructure FPU context saving
  crypto: x86/ghash - limit FPU preemption
  crypto: x86 - use common macro for FPU limit

 Documentation/RCU/stallwarn.rst            |  9 +++---
 arch/x86/crypto/blake2s-glue.c             |  7 +++--
 arch/x86/crypto/chacha_glue.c              |  4 ++-
 arch/x86/crypto/crc32-pclmul_glue.c        | 18 ++++++++---
 arch/x86/crypto/crc32c-intel_glue.c        | 32 ++++++++++++++++----
 arch/x86/crypto/crct10dif-pclmul_glue.c    | 32 ++++++++++++++++----
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 32 +++++++++++++++-----
 arch/x86/crypto/nhpoly1305-avx2-glue.c     |  3 +-
 arch/x86/crypto/nhpoly1305-sse2-glue.c     |  4 ++-
 arch/x86/crypto/poly1305_glue.c            | 25 +++++++++-------
 arch/x86/crypto/polyval-clmulni_glue.c     |  5 ++--
 arch/x86/crypto/sha1_ssse3_glue.c          | 34 +++++++++++++++++----
 arch/x86/crypto/sha256_ssse3_glue.c        | 35 ++++++++++++++++++----
 arch/x86/crypto/sha512_ssse3_glue.c        | 35 ++++++++++++++++++----
 arch/x86/crypto/sm3_avx_glue.c             | 28 +++++++++++++----
 kernel/rcu/Kconfig.debug                   |  2 +-
 16 files changed, 237 insertions(+), 68 deletions(-)

-- 
2.37.3

