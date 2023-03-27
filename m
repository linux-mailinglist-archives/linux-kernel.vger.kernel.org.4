Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8404E6CA06D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjC0Js5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjC0Jsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:48:54 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6974226
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:48:52 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R8IUGE005717;
        Mon, 27 Mar 2023 11:48:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=n2P31621B4pGT+Lt7Ca5JfRVeo9zygUKZhQAgYzXy6g=;
 b=ZA1zK6mkYTHpnfEP1/i5e32mxax1kkkZeKRdMU7VkhqjiG9QqTo6sB1byonCCjLlmHao
 dQsJTYji69ZGTFawFxleIBYfY1O+TsoXu7ZvHfQjxjB4UmbV4vOlpRvDnK9J9vajaw8x
 E9MYa0A3BdtfmudSmhVBv8U4VDQ5bO4IZJZhNR4EQhRH2WDXGb1tDE0c1/GFbQld90ok
 WtknUV7mOzA8dBz6mX4POR36BxXLgxAtxZV5zDsSbPkhZEPH662hZ9ZPREoUten0RjQv
 04XF07fK9/uj7YzjJ557rbIfqdSh21673H5DcjkmymBgUkElz6Pv5zk5dO1MusZXw2JZ xQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3phsr59ygh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 11:48:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 83D8210002A;
        Mon, 27 Mar 2023 11:48:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 79450212FAA;
        Mon, 27 Mar 2023 11:48:33 +0200 (CEST)
Received: from localhost (10.48.0.175) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 27 Mar
 2023 11:48:33 +0200
From:   Christophe Kerello <christophe.kerello@foss.st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH v2 0/2] mtd: rawnand: stm32_fmc2: do not support EDO mode
Date:   Mon, 27 Mar 2023 11:47:40 +0200
Message-ID: <20230327094742.38856-1-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.175]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch removes EDO mode support from FMC2 driver as the controller
does not support the feature and has to be applied on Kernel LTS. The second
patch uses timings.mode instead of checking tRC_min timing for Kernel next.

Changes in v2:
 - second patch added for Kernel next

Christophe Kerello (2):
  mtd: rawnand: stm32_fmc2: do not support EDO mode
  mtd: rawnand: stm32_fmc2: use timings.mode instead of checking tRC_min

 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.25.1

