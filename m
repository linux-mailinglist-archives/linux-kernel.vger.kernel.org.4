Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D738F65C752
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbjACTTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbjACTSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:18:34 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DCA65F8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:15:59 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303IGJhY000907
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jan 2023 11:15:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=Q3J5QgpjIfcAednQEWV/FrCvTjaD0fSbWej/hAzXw9k=;
 b=Q+suXye2CDOVXEchdnagYlWSSuS2h7pWHObGdl+zFA31A/QMnoVnJC8/vhNp3tgpXo45
 MLhAHx/ck8FtBVr2JbQzKd5Dys1c2XhUhAmMmy7Yl0bUuqXc62vIlIIUkAqQ0GPB0ZCP
 wGi4vQ40jsCBD3cmz0YZ4/+m0kbh7iVCu5JM51FyuW47InUYsmo9DxBw4LDqBgFhtq9l
 d6SHZrLeG7/7m3WlD3FRKsetSRBwO+MckzWznRp5khQ3EPIIJKuvHMREcSTPZxiKw0Jf
 wn4XK0T9ZLV3fUt5fxANukc2VIeLqAyBgu8Y6MccKJ7itLvkrDITDzaxORAbqeuW0guZ Ow== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mtk356u36-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:15:59 -0800
Received: from twshared7043.05.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 3 Jan 2023 11:15:58 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 8501CE1F5DFE; Tue,  3 Jan 2023 11:15:53 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 00/12] dmapool enhancements
Date:   Tue, 3 Jan 2023 11:15:39 -0800
Message-ID: <20230103191551.3254778-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3DfxsX3Yni69DQ6ekiBk7sj8PsSz4b2H
X-Proofpoint-GUID: 3DfxsX3Yni69DQ6ekiBk7sj8PsSz4b2H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
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

Time spent in dma_pool alloc/free increases linearly with the number of
pages backing the pool. We can reduce this to constant time with minor
changes to how free pages are tracked.

Changes since v2:

  Added received reviews

  Applied suggestions from Christoph (removed inlines, use preferred
  conditional compiling style, minor changes in patch sequence, use
  kzalloc)

  Fixed printf formats caught by kernel test robot=20

  Added one extra cleanup patch at the end

Keith Busch (8):
  dmapool: add alloc/free performance test
  dmapool: move debug code to own functions
  dmapool: rearrange page alloc failure handling
  dmapool: consolidate page initialization
  dmapool: simplify freeing
  dmapool: don't memset on free twice
  dmapool: link blocks across pages
  dmapool: create/destroy cleanup

Tony Battersby (4):
  dmapool: remove checks for dev =3D=3D NULL
  dmapool: use sysfs_emit() instead of scnprintf()
  dmapool: cleanup integer types
  dmapool: speedup DMAPOOL_DEBUG with init_on_alloc

 mm/Kconfig        |   9 ++
 mm/Makefile       |   1 +
 mm/dmapool.c      | 371 ++++++++++++++++++++++------------------------
 mm/dmapool_test.c | 147 ++++++++++++++++++
 4 files changed, 331 insertions(+), 197 deletions(-)
 create mode 100644 mm/dmapool_test.c

--=20
2.30.2

