Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2041A617579
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKCE2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCE2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:28:19 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8951145A;
        Wed,  2 Nov 2022 21:28:18 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2Nwbwb002090;
        Thu, 3 Nov 2022 04:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=XeN/4wER7fFq9GlvNmmcNVF6WYp9tt4z3vT6ZEwf73A=;
 b=T/DUBZeXj8hoXEgXOMMm2pC9Vj0+xYtszAss0BLtuSRYUf4XQRkcf+bXEeEwl31jKF79
 b7L2sGJcHuTdJU+KpVXRelbvWOZhldSyH5KU6lr82kuWodAOPOrDCJBWuqdyWb68/JfM
 UrRnIek5iTomdKRWPfelrwE73XueVWhdqMK3XX8Xt3IHbSTnQrZG2Pr3YTykElpEHXtC
 W3tIOuDc9HRHzaQ4B8jca1aqg7+1dJxAHB5zML4duSgV2RM+xFnb/vLIwsYezMhm5KRq
 pKpcuWFzSYpM9G1qsmJi/V17wOe3v038ZbCH0GhV0CRMOEQerIken+4f1GmeK4DyeYqq DA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3km2pfhde7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:28:02 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id C645A80471E;
        Thu,  3 Nov 2022 04:28:00 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 26D22808EAF;
        Thu,  3 Nov 2022 04:27:58 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 00/17] crypt: x86 - fix RCU stalls
Date:   Wed,  2 Nov 2022 23:27:23 -0500
Message-Id: <20221103042740.6556-1-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221012215931.3896-1-elliott@hpe.com>
X-Proofpoint-GUID: ZyV7Jr8igUs92aGBz19CidkwNwE5JiH7
X-Proofpoint-ORIG-GUID: ZyV7Jr8igUs92aGBz19CidkwNwE5JiH7
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030031
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Except for the tcrypt change, v3 only tackles the hash functions
as discussed in
https://lore.kernel.org/lkml/MW5PR84MB184284FBED63E2D043C93A6FAB369@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM/

The limits are implemented as static const unsigned ints at the
module level, which makes them easy to expose as module parameters
for testing like this:
   -static const unsigned int bytes_per_fpu = 655 * 1024;
   +static unsigned int bytes_per_fpu = 655 * 1024;
   +module_param(bytes_per_fpu, uint, 0644);
   +MODULE_PARM_DESC(bytes_per_fpu, "Bytes per FPU context");


Robert Elliott (17):
  crypto: tcrypt - test crc32
  crypto: tcrypt - test nhpoly1305
  crypto: tcrypt - reschedule during cycles speed tests
  crypto: x86/sha - limit FPU preemption
  crypto: x86/crc - limit FPU preemption
  crypto: x86/sm3 - limit FPU preemption
  crypto: x86/ghash - use u8 rather than char
  crypto: x86/ghash - restructure FPU context saving
  crypto: x86/ghash - limit FPU preemption
  crypto: x86/*poly* - limit FPU preemption
  crypto: x86/sha - register all variations
  crypto: x86/sha - minimize time in FPU context
  crypto: x86/sha1, sha256 - load based on CPU features
  crypto: x86/crc - load based on CPU features
  crypto: x86/sm3 - load based on CPU features
  crypto: x86/ghash,polyval - load based on CPU features
  crypto: x86/nhpoly1305, poly1305 - load based on CPU features

 arch/x86/crypto/crc32-pclmul_asm.S         |   6 +-
 arch/x86/crypto/crc32-pclmul_glue.c        |  36 ++-
 arch/x86/crypto/crc32c-intel_glue.c        |  58 +++--
 arch/x86/crypto/crct10dif-pclmul_glue.c    |  54 ++--
 arch/x86/crypto/ghash-clmulni-intel_asm.S  |   4 +-
 arch/x86/crypto/ghash-clmulni-intel_glue.c |  43 ++--
 arch/x86/crypto/nhpoly1305-avx2-glue.c     |  21 +-
 arch/x86/crypto/nhpoly1305-sse2-glue.c     |  21 +-
 arch/x86/crypto/poly1305_glue.c            |  49 +++-
 arch/x86/crypto/polyval-clmulni_glue.c     |  14 +-
 arch/x86/crypto/sha1_ssse3_glue.c          | 276 +++++++++++++--------
 arch/x86/crypto/sha256_ssse3_glue.c        | 268 +++++++++++++-------
 arch/x86/crypto/sha512_ssse3_glue.c        | 191 ++++++++------
 arch/x86/crypto/sm3_avx_glue.c             |  45 +++-
 crypto/tcrypt.c                            |  56 +++--
 15 files changed, 764 insertions(+), 378 deletions(-)

-- 
2.37.3

