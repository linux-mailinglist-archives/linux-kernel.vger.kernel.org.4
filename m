Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536146DF252
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjDLK4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDLK4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:56:12 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D486E80
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:56:09 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C8bJZs002789;
        Wed, 12 Apr 2023 12:55:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=fn5gTDlxJJOoidDGzjzz0yoRj+FjfSsHO8ABQBnX10g=;
 b=kdtzc6y3PvcJBlr8+RzYMR4b69aOlpFXeC1UDAYzx55jdsJJCKqgeKxDS1aCusgfiIeJ
 yxvdQQ8f6ldNPyAPP/sNb/od50K9yQmHaRWX8ZpPr1ikT24TeCyq+zyquELp2h3CoZh5
 vWeZOQZ8Fg9WuDf8Nf0CR1g70+gPBQXzt0cWHFxavuozdk4aSuT1D2dbPCl/E6ESaj6D
 XHZqt9XP9gVA+Sv99ioopKYXNdqbXc4R3cilHSHOyvhGWixfRupbQIJBtLBlU0Uk+ih3
 HOLLJ4m2joDU7EI8cn8x5cfBzM/8PsRMVsc0/cFjUAwGQdrf+sWkUDXP8xZZEM0F3xR8 /g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pws9u15ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 12:55:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9E09010002A;
        Wed, 12 Apr 2023 12:55:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 976472128D0;
        Wed, 12 Apr 2023 12:55:56 +0200 (CEST)
Received: from localhost (10.252.10.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 12 Apr
 2023 12:55:56 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [RESEND PATCH 0/2] STMFX chip init couple of fixes
Date:   Wed, 12 Apr 2023 12:55:40 +0200
Message-ID: <20230412105542.1231131-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.10.182]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_03,2023-04-12_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the behavior of stm32_chip_init function in case
of errors.

Amelie Delaunay (2):
  mfd: stmfx: Fix error path in stmfx_chip_init
  mfd: stmfx: Nullify stmfx->vdd in case of error

 drivers/mfd/stmfx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.25.1

