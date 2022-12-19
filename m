Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0849651411
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiLSUhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiLSUhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:37:46 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35938D2CB;
        Mon, 19 Dec 2022 12:37:45 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJIc1Q0007886;
        Mon, 19 Dec 2022 20:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=70k3juKirfiKMBjmRb4RoHADGmYmwh4j9vx0aI8spnw=;
 b=Cto/aAIGnoFNo8pz0SG4Afl2j0qnQAomleFOxJ0UQpudjOvTO5W9kRgclqyClOCjjtsG
 TeKiBtBuZbUxbTb3gdZ1FiKpi/bVTG/KyagM/ORAvRuWqKC7k9KNlBHMO+eb9Mnj7jOv
 vyy4oYucJ7A/i2yebGF/XWHPk63VLTaZh2g68PpqtjK0ZqolRT739sQZwAhwUkZnMPKn
 rXBHc0ya90O4dgJeWaRrcBze7b+hhkb+soXmZpofsK4Nj1LbIdc1FO19CgRuxmEW0vas
 c5IKQWhnU3hCnEkLl/PEGM4Ys+KCQ5AG6XZPMcke9n1IlTS94VjMVh/m/qYkRNcFniY5 hQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mjwd4rmkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 20:37:40 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 1D5F031099;
        Mon, 19 Dec 2022 20:37:40 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id A7640808E99;
        Mon, 19 Dec 2022 20:37:39 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Elliott <elliott@hpe.com>
Subject: [PATCH 0/3] crypto: yield at end of operations
Date:   Mon, 19 Dec 2022 14:37:30 -0600
Message-Id: <20221219203733.3063192-1-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Mf7BUsbibPlVkFYFgvesmn4-5sJ6gF3n
X-Proofpoint-ORIG-GUID: Mf7BUsbibPlVkFYFgvesmn4-5sJ6gF3n
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=616
 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190181
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call crypto_yield() consistently in the skcipher, aead, and shash
helper functions so even generic drivers don't hog the CPU and
cause RCU stall warnings and soft lockups.

Add cond_yield() in tcrypt's do_test so back-to-back tests yield
as well.

Robert Elliott (3):
  crypto: skcipher - always yield at end of walk
  crypto: aead/shash - yield at end of operations
  crypto: tcrypt - yield at end of test

 crypto/aead.c     |  4 ++++
 crypto/shash.c    | 32 ++++++++++++++++++++++++--------
 crypto/skcipher.c | 15 +++++++++++----
 crypto/tcrypt.c   |  1 +
 4 files changed, 40 insertions(+), 12 deletions(-)

-- 
2.38.1

