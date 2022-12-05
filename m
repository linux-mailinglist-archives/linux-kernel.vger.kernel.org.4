Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930DF642AE4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiLEPAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiLEPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:00:29 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF140FCE9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:00:27 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B53dX10030342
        for <linux-kernel@vger.kernel.org>; Mon, 5 Dec 2022 07:00:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=O8qc/bFe9w/fCN/thcn9te7Vf2qgtrHRPgqkuMvStjc=;
 b=M7Gk9IXC0ki83SDHANSpfmKOmD0842hUs4eai3Zi5w2rfls72Tk3F6YNn4EFyWTfEip6
 OIcV677DzxjkTFN6/eWvwY+mDvXtiD1rbtsMpZAqOc61WcmLU9CuT9ITuhYXLpI/ixPQ
 CWVihn/9QqsNDr7AfzyfSr+3/dCy5HwsNQ/zKaZ8/9iYQcIy5u95kaVWv5LCZJbBho+F
 dpKQtS1Pz51BzHmlZjkPy9vUH9HDX3WHTIuuzNc0hkfxdOYy3W24Z/mo/nAOnCf/ltmB
 UPY9gTKar8VNXaNF8YMOarTXGbFx/aram2W2+QK/Vvr6Um2nqPq83Jb+cgwRZKuuExh8 3A== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m84eyucgq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 07:00:27 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 07:00:25 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 9A551C6156DA; Mon,  5 Dec 2022 07:00:09 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 00/11] dmapool enhancements
Date:   Mon, 5 Dec 2022 06:59:26 -0800
Message-ID: <20221205145937.54367-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Xrcd1udeGDHEIOytm5-pX3rW1y3l_vxO
X-Proofpoint-GUID: Xrcd1udeGDHEIOytm5-pX3rW1y3l_vxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>



Keith Busch (7):
  dmapool: add alloc/free performance test
  dmapool: move debug code to own functions
  dmapool: rearrange page alloc failure handling
  dmapool: consolidate page initialization
  dmapool: simplify freeing
  dmapool: don't memset on free twice
  dmapool: link blocks across pages

Tony Battersby (4):
  dmapool: remove checks for dev =3D=3D NULL
  dmapool: use sysfs_emit() instead of scnprintf()
  dmapool: cleanup integer types
  dmapool: speedup DMAPOOL_DEBUG with init_on_alloc

 mm/Kconfig        |   9 ++
 mm/Makefile       |   1 +
 mm/dmapool.c      | 354 ++++++++++++++++++++++------------------------
 mm/dmapool_test.c | 138 ++++++++++++++++++
 4 files changed, 315 insertions(+), 187 deletions(-)
 create mode 100644 mm/dmapool_test.c

--=20
2.30.2

