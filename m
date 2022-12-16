Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8479D64F246
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiLPURh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiLPURV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:17:21 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B4C6A748
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:17:20 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGJxSYO015449
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:17:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=thktE/bo2HltCwBKROxOHKReAsv2PUYhaxcs9QYKzYQ=;
 b=G3AN1gIivSwV/TRPXYIlFwTOIcT5PsbterRO2tbkUlUT2QzjrAaCeQUN8vDcB1PzMNBQ
 Vy7njlDwdOF7zkQsDawR1Dkvo162pr8bG7Ig/wlEr+89QGG8YJXC7xYVsnxCT5DR1hk1
 C8bjWldNnhVckpX8IdGeB0VhzuqN3fSeLT8s6w3+F9tmPO3BXw84aqhyIU8/h7f4A5Sh
 9Cl5YhTvsQzcBIwbwD8jYipexWG1FpCPz850cS/xTyOFWrc1QDRIjuUKtgK/JccaU/tM
 qn3vUlJNqNjDCf0r43qSMkDOil4gT63qwmeUCo/6VvE2H0xg3wanAUpGtFEOGjcPSK14 Aw== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mg3hj2det-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:17:19 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 12:17:18 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id DE0B3D042AAF; Fri, 16 Dec 2022 12:17:09 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 00/11] dmapool enhancements
Date:   Fri, 16 Dec 2022 12:16:14 -0800
Message-ID: <20221216201625.2362737-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vLq88CMB5qsir95h0gMWeKKE1kblfR6J
X-Proofpoint-ORIG-GUID: vLq88CMB5qsir95h0gMWeKKE1kblfR6J
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
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

The time spent in dma_pool alloc/free goes up linearly as the number of
pages backing the pool increases. We can reduce this to constant time
with some minor changes to how free pages are tracked.

Changes since previous version:

  Fixed dmapool_test to use appropriate dma_op accessors

  Fixed up comment in dmapool about the data structures

  Fixed dma pool boundary checks when initializing the pool

  And since I mess up the boundary checks for odd alignment, I updated
  dmapool_test allow setting arbitrary alignment and boundary to catch
  the same case that failed in the previous version, reported here:

   https://lore.kernel.org/oe-lkp/202212112301.ad0819f7-oliver.sang@intel.c=
om/

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
 mm/dmapool.c      | 356 ++++++++++++++++++++++------------------------
 mm/dmapool_test.c | 146 +++++++++++++++++++
 4 files changed, 324 insertions(+), 188 deletions(-)
 create mode 100644 mm/dmapool_test.c

--=20
2.30.2

