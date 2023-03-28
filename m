Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D8E6CC750
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjC1QAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjC1QAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:00:49 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92429109
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:00:48 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SE2FCt000530;
        Tue, 28 Mar 2023 18:00:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=oAuLL9E3dQSv/RZG+St8bKflmCvKwKf/3xQCNXsAZbI=;
 b=Ukug8FncPywnBZmTJ36/VVF+KiXJnnhqe7usSKdjgtPS/rZYQksFYAfjWaeEpYKYK2FL
 5xvW7hrwzAzBo/ZiSwfHgogjv0Q3pCtRrlagDBoYguU8ArpcwZ8Ser5IAnYyvitNygkg
 Hfq38ppX2PKo7fJ4G2OY2vADMLHIRwVI7JI3ViFF5P1MRev6QPlSd6kv77ii1F3MgP2k
 G0oBvyjZ/1sn3ACCiapHZsDCBtvSvq++Xg5zCUZIjlSdSt1Kiv+lB15pbUGvwVgdGxd9
 F4tChvKeaus7CjDWQpLoSLqFFdx4VQZWOQF6LFIknkgGCuSf+ZslbXtKRuossHOb+I+c Og== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pkvs4u1wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 18:00:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9CCEF100034;
        Tue, 28 Mar 2023 18:00:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 59A2221A20D;
        Tue, 28 Mar 2023 18:00:29 +0200 (CEST)
Received: from localhost (10.48.0.175) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 28 Mar
 2023 18:00:29 +0200
From:   Christophe Kerello <christophe.kerello@foss.st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH v3 0/2] mtd: rawnand: stm32_fmc2: do not support EDO mode
Date:   Tue, 28 Mar 2023 17:58:17 +0200
Message-ID: <20230328155819.225521-1-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.175]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first fix removes EDO mode support from FMC2 driver as the controller
does not support the feature (first fix is needed for v5.4+).
The second fix uses timings.mode instead of checking tRC_min timing
(second fix is needed for v5.10+).

Changes in v3:
 - The commit message of first patch has been reworked
 - Cc to stable added in each patch
 - Tudor Reviewed-by added in each patch

Changes in v2:
 - second patch added

Christophe Kerello (2):
  mtd: rawnand: stm32_fmc2: remove unsupported EDO mode
  mtd: rawnand: stm32_fmc2: use timings.mode instead of checking tRC_min

 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.25.1

