Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D269167D7ED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjAZVvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjAZVvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:51:38 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5CDFF2F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:51:36 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QKqvb7000849
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:51:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=YSju8h3IcFoXJFagXVV/kEgcC/pDir68RdkcrZYyLwI=;
 b=RK0eODc0AYW8MNOFDP/1dkUB/QQe5YtJVLFOk/cTZAPUxYdkCpZ1BVnCIbdPDHoAHKI/
 /C4426KZe/tMOI+1oaXVo+ggjof+LkZopPTc7bJ5AOs1zllEgCxljCOm/YNOoMVqEIS6
 GvWzQiV47VFQHkUQJgRqL7MN78bFLgAf/dfAWs/SflUF9yt1rQdwojOy6s3e27map76/
 rLBLhV9BtGFR7BaW6GgtdlD3Ix1zccpf6OAqzFZkR7qpJegbXszkvssICmTGVKZuapX2
 XYG9B4fFAH144s94n15CG+uNBRkUA9Av97PiCi4e+ovfyTx6R9kJzcPOxXzFNRHdQ2TS Yw== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nb7mbshbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:51:36 -0800
Received: from twshared24547.08.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 26 Jan 2023 13:51:35 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id D3B55FE80A8B; Thu, 26 Jan 2023 13:51:25 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <hch@lst.de>, <tonyb@cybernetics.com>,
        <akpm@linux-foundation.org>
CC:     <kernel-team@meta.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 00/12] dmapool enhancements
Date:   Thu, 26 Jan 2023 13:51:13 -0800
Message-ID: <20230126215125.4069751-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FSyEvlbM0WilvJQ0pokZi1BmNVetNOe-
X-Proofpoint-ORIG-GUID: FSyEvlbM0WilvJQ0pokZi1BmNVetNOe-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
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

Changes since v4:

  Added received reviews

  Applied comments from Christoph:
    Combined all debug code in one #ifdef block
    Fixed some whitespace
   =20
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
 mm/dmapool.c      | 402 ++++++++++++++++++++++------------------------
 mm/dmapool_test.c | 147 +++++++++++++++++
 4 files changed, 350 insertions(+), 209 deletions(-)
 create mode 100644 mm/dmapool_test.c

--=20
2.30.2

