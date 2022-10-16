Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B101600215
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJPRUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJPRT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:19:59 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CFF27913
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:19:55 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 29GHJFkB021043;
        Sun, 16 Oct 2022 17:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PPS06212021;
 bh=0oquvqOLgUg+VJQHiajJ6QdIvz2deOkOJUQc81tgIUs=;
 b=Eevu7pWloLPqp5oZn3mo9LBeBaLg82CsmX9CZK3XOA55EgLJECAA5WoW9BXeaKpHHFPu
 9FbH8r9r9Js9ZO1raiW6CVofwNmMdjciRsltTvx0FnyZ/0B3+gm1DKiLk5xFNEI/yPSK
 HRRSgewfBoAtcnCsioOmlA2eX5sUFrZZjZWZvtsaPRywi9sVHWpz/DvnwrCfH+pREwK/
 msttfG/y6mRjKbNLmrrWPhMK/L2cTRdbMuHZVaxb/NU7NUSwysOGIF5ZP8aV31aJEuxp
 eNwoi5n0+TwnFr+6JMTdUZJxn2K4sV2T3tfpUNRQLCN74VHx6hzr60moncQ2+IU0KSui xg== 
Received: from ala-exchng01.corp.ad.wrs.com (unknown-82-252.windriver.com [147.11.82.252])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3k7ku990xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 16 Oct 2022 17:19:15 +0000
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 16 Oct 2022 10:19:07 -0700
Received: from pek-ywang12-d1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Sun, 16 Oct 2022 10:19:05 -0700
From:   <yaliang.wang@windriver.com>
To:     <tudor.ambarus@microchip.com>, <pratyush@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <andy.yan@rock-chips.com>,
        <cyrille.pitchen@wedev4u.fr>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/1] mtd: spi-nor: gigadevice: gd25q256: replace gd25q256_default_init with gd25q256_post_bfpt
Date:   Mon, 17 Oct 2022 01:19:00 +0800
Message-ID: <20221016171901.1483542-1-yaliang.wang@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1dddc60f-44fd-df65-f491-be8379fe2380@microchip.com>
References: <1dddc60f-44fd-df65-f491-be8379fe2380@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pxAS3buvNuYBdn8smUk4Vp5_CjbYhNAI
X-Proofpoint-ORIG-GUID: pxAS3buvNuYBdn8smUk4Vp5_CjbYhNAI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_13,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxlogscore=756 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210160106
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GD25Q256 'C' generation 'GD25Q256C' implements the JESD216 standards,
JESD216 doesn't define the QER field in BFPT, but the 'GD25Q256C'
does define QE bit in status register 1 bit 6, so we need to tweak
quad_enable to properly set the function.

'D' and 'E' generations implement the JESD216B standards, so parsing
the SFDP to set quad_enable function is enough for them.

As the default_init is deprecated, so the post_bfpt hook will be the
right place to do this tweak.

Changes since v1 [1]
 - Just tweak the quad_enable function when needed.

Yaliang Wang (1):
  mtd: spi-nor: gigadevice: gd25q256: replace gd25q256_default_init with gd25q256_post_bfpt

 drivers/mtd/spi-nor/gigadevice.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

