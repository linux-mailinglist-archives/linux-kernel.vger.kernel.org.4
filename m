Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCD3650DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiLSOnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiLSOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:43:19 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7471C2724;
        Mon, 19 Dec 2022 06:43:18 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJ9PqqB009699;
        Mon, 19 Dec 2022 06:43:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=bNCt+fkpc/Qu79iu7Av/HQdZvX6GNRSgI33Hmaf9tbk=;
 b=Vu6p1ayooMcf0M263SZbV6R1hn/8y5R+Dvn045OfFKdw0MzL5YnZLlaC0OAY+kae57Iv
 zxCjJDs8NNWnk/3Uc2VUEpaaKNfXZsT6Xv0FqqZeVCZsIpFWaJPf/Jd1Pi/9VO6AGjtQ
 Zo5dffi30yVch0JNXp5IRKrJMvhGuo/kl4XG46t/JdH9X9Lzg3LyiEo4nOAZgC5DeF4p
 4dNkled4SftENn6y/8dJXtpoDgyFRYUwaMd3OFaV7GgJkNIwL3IBfdcUOiP0fueJHfpz
 NZp8EuAIJvw8WTQAiPivgh1S38t21nC72EmGrjY7G1VN+hqcGT9i6JLaeEwwCEcewNy1 OA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3mjnans4hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 06:43:11 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 06:43:10 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 19 Dec 2022 06:43:10 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id D0D1B3F7054;
        Mon, 19 Dec 2022 06:43:09 -0800 (PST)
From:   Witold Sadowski <wsadowski@marvell.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <pthombar@cadence.com>, <konrad@cadence.com>,
        <wbartczak@marvell.com>, <wzmuda@marvell.com>,
        <wsadowski@marvell.com>
Subject: [PATCH 1/7] spi: cadence: Fix busy cycles calculation
Date:   Mon, 19 Dec 2022 06:42:48 -0800
Message-ID: <20221219144254.20883-2-wsadowski@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219144254.20883-1-wsadowski@marvell.com>
References: <20221219144254.20883-1-wsadowski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RJBcxMAiMp0CF9OQrHHxf7Q3lxKWlFsm
X-Proofpoint-ORIG-GUID: RJBcxMAiMp0CF9OQrHHxf7Q3lxKWlFsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If xSPI is in x2/x4/x8 mode to calculate busy
cycles, busy bits count must be divided by the number
of lanes.
If opcommand is using 8 busy bits, but SPI is
in x4 mode, there will be only 2 busy cycles.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
Reviewed-by: Chandrakala Chavva <cchavva@marvell.com>
Reviewed-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 520b4cc69cdc..91db3c973167 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -177,7 +177,10 @@
 #define CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op) ( \
 	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R3_DCNT_H, \
 		((op)->data.nbytes >> 16) & 0xffff) | \
-	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R3_NUM_OF_DUMMY, (op)->dummy.nbytes * 8))
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R3_NUM_OF_DUMMY, \
+		  (op)->dummy.buswidth != 0 ? \
+		  (((op)->dummy.nbytes * 8) / (op)->dummy.buswidth) : \
+		  0))
 
 #define CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op, chipsel) ( \
 	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_BANK, chipsel) | \
-- 
2.17.1

