Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB4651413
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiLSUhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiLSUhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:37:46 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFDAD2FC;
        Mon, 19 Dec 2022 12:37:44 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJKVxbp001379;
        Mon, 19 Dec 2022 20:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=hxDUwTsXgf/F0pCYDtIB+NfpqhGa9UxYzYrva7hoWO4=;
 b=bdwGlHDmJVGNT9TxaBzhIRCsCpWGGZL9J3HKrwKqG0UgBVE4QKsX5bKKsTGLb805qo/r
 SU48jqI/CfQ3icUgybiUw96ANFbgN80lonJ3WlOvJ7tjzlE+Yt8XcI+S7ccI5h9aHee5
 WwlMMq2/BtpG4FOCbbxs+37klzwgV4oUBVgi5qQnqmTfRWcL4/E8JNvLKrjY/2EiVC+h
 glYj/o8abVUUVYloNY34Hyv7lZdkV09+GZs0RnG+8ljgv3cfTcYKOPUJd2mP5lpkq0Ls
 3iUzsEozcTMHjES7krXLZOI7M4OhGVQzZ+eeUjbl8IUM9W/+wUVPBhlpaqglTgJ4KubG dA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3mjx3mrg6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 20:37:41 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 52F46801723;
        Mon, 19 Dec 2022 20:37:41 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 0A8F0807B0B;
        Mon, 19 Dec 2022 20:37:41 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Elliott <elliott@hpe.com>
Subject: [PATCH 1/3] crypto: skcipher - always yield at end of walk
Date:   Mon, 19 Dec 2022 14:37:31 -0600
Message-Id: <20221219203733.3063192-2-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219203733.3063192-1-elliott@hpe.com>
References: <20221219203733.3063192-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8tTJD82xn1hsm32dpy-VUM8DmsXSWayU
X-Proofpoint-ORIG-GUID: 8tTJD82xn1hsm32dpy-VUM8DmsXSWayU
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190181
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always yield to the scheduler at the end of skcipher_walk_done(),
not just if additional bytes are left to be processed.

This avoids soft lockups if drivers are invoked back-to-back
to process data that is an integer multiple of their block
size.

Example: while processing 1 MiB buffers, multiple skciphers run
from 192 s to 218 s without ever yielding to the scheduler,
causing three soft lockup complaints.

The kernel is configured for CONFIG_PREEMPT_NONE=y (or
preempt=none on the kernel command line), so only explicit
cond_resched() calls trigger scheduling - might_resched() and
preempt_enable() do not (see kernel/sched/core.c).

[  190.865601] tcrypt: PERL my %speeds_skcipher = (
[  192.041157] tcrypt: PERL "cbc-aes-aesni" => 2396490,
[  192.373934] tcrypt: PERL "ctr-aes-aesni" => 574888,
[  193.548967] tcrypt: PERL "cts-cbc-aes-aesni" => 2396018,
[  193.909077] tcrypt: PERL "ecb-aes-aesni" => 631824,
[  194.223801] tcrypt: PERL "xctr-aes-aesni" => 535778,
[  194.608548] tcrypt: PERL "xts-aes-aesni" => 676518,
[  196.440247] tcrypt: PERL "ctr-aria-avx" => 3804224,
[  196.675788] tcrypt: PERL "xchacha12-simd" => 368668,
[  196.988868] tcrypt: PERL "xchacha20-simd" => 535314,
[  197.301510] tcrypt: PERL "chacha20-simd" => 535142,
[  198.590113] tcrypt: PERL "ctr-sm4-aesni-avx2" => 2642930,
[  208.975253] tcrypt: PERL "cfb-sm4-aesni-avx2" => 22499840,
[  218.187217] watchdog: BUG: soft lockup - CPU#1 stuck for 26s!  [modprobe:3433]
[  246.181238] Modules linked in: tcrypt(+) hctr2 essiv adiantum
...
[  246.185048] RIP: 0010:measure_skcipher_bigbuf.constprop.0.isra.0+0x282/0x393 [tcrypt]
[  246.185304] Code: 00 0f 31 ...
...
[  218.197313] Call Trace:
[  218.197567]  <TASK>
[  218.197822]  ? 0xffffffffc052a000
[  218.198079]  do_test.cold+0x989/0xc7a [tcrypt]
[  218.198340]  ? 0xffffffffc052a000
[  218.198595]  tcrypt_mod_init+0x50/0x1000 [tcrypt]
[  218.198857]  ? 0xffffffffc052a000
[  218.199112]  do_one_initcall+0x41/0x200
...
[  219.391776] tcrypt: PERL "cbc-sm4-aesni-avx2" => 22528138,
[  221.560847] tcrypt: PERL "ctr-sm4-aesni-avx" => 4560732,
[  231.960414] tcrypt: PERL "cfb-sm4-aesni-avx" => 22498380,
[  242.350070] tcrypt: PERL "cbc-sm4-aesni-avx" => 22527668,
[  244.471181] tcrypt: PERL "ecb-sm4-aesni-avx" => 4469626,
...
[  246.181064] watchdog: BUG: soft lockup - CPU#1 stuck for 52s!  [modprobe:3433]
...
[  250.168239] tcrypt: PERL "cbc-camellia-aesni-avx2" => 12202738,
[  255.840094] tcrypt: PERL "cbc-camellia-aesni" => 12203096,
[  264.047440] tcrypt: PERL "cbc-cast5-avx" => 17744280,
[  273.091258] tcrypt: PERL "cbc-cast6-avx" => 19375400,
[  274.183249] watchdog: BUG: soft lockup - CPU#1 stuck for 78s!  [modprobe:3433]
...
[  283.066260] tcrypt: PERL "cbc-serpent-avx2" => 21454930,
[  292.983848] tcrypt: PERL "cbc-serpent-avx" => 21452996,
...

By adding a unilateral call to crypto_yield(), which calls
cond_resched() and lets the scheduler use the CPU for another
thread, that no longer happens.

Starting at 2218 s, there is no soft lockup reported at 2244 s:
[ 2217.202692] tcrypt: PERL my %speeds_skcipher = (
[ 2218.450215] tcrypt: PERL            "cbc-aes-aesni" =>  2179138,
[ 2218.950960] tcrypt: PERL            "cbc-aes-aesni" =>   538738,
[ 2219.460618] tcrypt: PERL            "ctr-aes-aesni" =>   575212,
[ 2219.983006] tcrypt: PERL            "ctr-aes-aesni" =>   574402,
[ 2221.329550] tcrypt: PERL        "cts-cbc-aes-aesni" =>  2182864,
[ 2221.840599] tcrypt: PERL        "cts-cbc-aes-aesni" =>   539064,
[ 2222.344290] tcrypt: PERL            "ecb-aes-aesni" =>   537402,
[ 2222.869201] tcrypt: PERL            "ecb-aes-aesni" =>   537730,
[ 2223.400315] tcrypt: PERL           "xctr-aes-aesni" =>   534824,
[ 2223.897915] tcrypt: PERL           "xctr-aes-aesni" =>   534782,
[ 2224.414956] tcrypt: PERL            "xts-aes-aesni" =>   539592,
[ 2224.923715] tcrypt: PERL            "xts-aes-aesni" =>   539356,
[ 2226.740211] tcrypt: PERL             "ctr-aria-avx" =>  3392444,
[ 2228.545624] tcrypt: PERL             "ctr-aria-avx" =>  3392068,
[ 2228.869883] tcrypt: PERL           "xchacha12-simd" =>   368932,
[ 2229.204980] tcrypt: PERL           "xchacha12-simd" =>   374122,
[ 2229.609975] tcrypt: PERL           "xchacha20-simd" =>   535596,
[ 2230.022425] tcrypt: PERL           "xchacha20-simd" =>   537500,
[ 2230.429674] tcrypt: PERL            "chacha20-simd" =>   535474,
[ 2230.831041] tcrypt: PERL            "chacha20-simd" =>   534264,
[ 2232.278150] tcrypt: PERL       "ctr-sm4-aesni-avx2" =>  2640770,
[ 2233.744781] tcrypt: PERL       "ctr-sm4-aesni-avx2" =>  2642520,
[ 2244.290542] tcrypt: PERL       "cfb-sm4-aesni-avx2" => 22497308,
[ 2245.725044] tcrypt: PERL       "cfb-sm4-aesni-avx2" =>  2604468,
[ 2256.279228] tcrypt: PERL       "cbc-sm4-aesni-avx2" => 22526084,
[ 2257.729868] tcrypt: PERL       "cbc-sm4-aesni-avx2" =>  2600460,
[ 2260.068782] tcrypt: PERL        "ctr-sm4-aesni-avx" =>  4560650,
[ 2262.414663] tcrypt: PERL        "ctr-sm4-aesni-avx" =>  4561468,
[ 2272.943000] tcrypt: PERL        "cfb-sm4-aesni-avx" => 22496026,
[ 2275.233755] tcrypt: PERL        "cfb-sm4-aesni-avx" =>  4456984,
[ 2285.779516] tcrypt: PERL        "cbc-sm4-aesni-avx" => 22525908,
[ 2288.081160] tcrypt: PERL        "cbc-sm4-aesni-avx" =>  4457036,
[ 2290.374086] tcrypt: PERL        "ecb-sm4-aesni-avx" =>  4465790,
[ 2292.677381] tcrypt: PERL        "ecb-sm4-aesni-avx" =>  4466014,
[ 2298.544718] tcrypt: PERL  "cbc-camellia-aesni-avx2" => 12246268,
[ 2299.869611] tcrypt: PERL  "cbc-camellia-aesni-avx2" =>  2349440,
[ 2305.734078] tcrypt: PERL       "cbc-camellia-aesni" => 12246930,
[ 2307.746065] tcrypt: PERL       "cbc-camellia-aesni" =>  3832992,
[ 2316.127414] tcrypt: PERL            "cbc-cast5-avx" => 17737348,
[ 2318.703437] tcrypt: PERL            "cbc-cast5-avx" =>  5061014,
[ 2327.694881] tcrypt: PERL            "cbc-cast6-avx" => 19065488,
[ 2331.672188] tcrypt: PERL            "cbc-cast6-avx" =>  8145590,
[ 2341.750274] tcrypt: PERL         "cbc-serpent-avx2" => 21453172,
[ 2343.209420] tcrypt: PERL         "cbc-serpent-avx2" =>  2611702,

Fixes: b286d8b1a690 ("crypto: skcipher - Add skcipher walk interface")
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/skcipher.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/crypto/skcipher.c b/crypto/skcipher.c
index 0ecab31cfe79..cdead632117a 100644
--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -153,13 +153,20 @@ int skcipher_walk_done(struct skcipher_walk *walk, int err)
 	scatterwalk_done(&walk->in, 0, nbytes);
 	scatterwalk_done(&walk->out, 1, nbytes);
 
-	if (nbytes) {
-		crypto_yield(walk->flags & SKCIPHER_WALK_SLEEP ?
-			     CRYPTO_TFM_REQ_MAY_SLEEP : 0);
+	/*
+	 * Allow scheduler to use the CPU since it has been busy,
+	 * regardless of whether another loop pass is due
+	 */
+	crypto_yield(walk->flags & SKCIPHER_WALK_SLEEP ?
+		     CRYPTO_TFM_REQ_MAY_SLEEP : 0);
+
+	if (nbytes)
 		return skcipher_walk_next(walk);
-	}
 
 finish:
+	crypto_yield(walk->flags & SKCIPHER_WALK_SLEEP ?
+		     CRYPTO_TFM_REQ_MAY_SLEEP : 0);
+
 	/* Short-circuit for the common/fast path. */
 	if (!((unsigned long)walk->buffer | (unsigned long)walk->page))
 		goto out;
-- 
2.38.1

