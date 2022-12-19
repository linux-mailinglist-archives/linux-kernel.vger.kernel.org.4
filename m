Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78C765140E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiLSUiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiLSUhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:37:48 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790CBD2E6;
        Mon, 19 Dec 2022 12:37:47 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJIMMT8023118;
        Mon, 19 Dec 2022 20:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=2dYGUGoiYlGjuRM5PMmfeHA1r1xQ9XcKfQBofK1Sca0=;
 b=BAOJknJIXqnDhbu1T2hlzXUdF5Z27k1OfU8oKQ0IFbkS9kcnCOLxDWk1DxcsbMOkRRe2
 CJ+yYbgIrPuQnm2VHekNfEVCdRfrXJpOZs21I91WO9Qz14b8U+kqSOrlvHEKs60OE/6o
 PIOwOPsju6KnrB9bPd5uMhvpA6EV1iuoE3ur4sGJSQNZBsyCiRsWeqhqi8MhxJCu6xKj
 2hLYu2oW0BETFDkivD0DS4Nxnl7uEsyZW3Cm+CGotUK+ujgcKdCYJ2g+Ewb/J5YBLOFl
 sm4Pd299WAkjgfZ9IUdl81Xefje8eAhHNivdMbSzrIOvnq47/B+qPOpRkdG1BB8oYMPi Iw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mjw610qpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 20:37:43 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 3065D807131;
        Mon, 19 Dec 2022 20:37:43 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id D3E3D809224;
        Mon, 19 Dec 2022 20:37:42 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Elliott <elliott@hpe.com>
Subject: [PATCH 3/3] crypto: tcrypt - yield at end of test
Date:   Mon, 19 Dec 2022 14:37:33 -0600
Message-Id: <20221219203733.3063192-4-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219203733.3063192-1-elliott@hpe.com>
References: <20221219203733.3063192-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SXAnjrNOQ-cAN-_GH4MGD5ESQQ-mfTh3
X-Proofpoint-GUID: SXAnjrNOQ-cAN-_GH4MGD5ESQQ-mfTh3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190181
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call cond_resched() to let the scheduler reschedule the
CPU at the end of each test pass.

If the kernel is configured with CONFIG_PREEMPT_NONE=y (or
preempt=none is used on the kernel command line), the only
time the scheduler will intervene is when cond_resched()
is called. So, repeated calls to
	modprobe tcrypt mode=<something>

hold the CPU for a long time.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/tcrypt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index 3e9e4adeef02..916bddbf4e75 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -3027,6 +3027,7 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 
 	}
 
+	cond_resched();
 	return ret;
 }
 
-- 
2.38.1

