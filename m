Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D4865BBB1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbjACIOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACIOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:14:09 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF5AD2F6;
        Tue,  3 Jan 2023 00:14:08 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3033HGpg003144;
        Tue, 3 Jan 2023 09:13:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 references : in-reply-to : subject : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=selector1;
 bh=0fNLTPCVMxlTbstLKSuvIRzgSXB7ZKfAUBpmvsQjllc=;
 b=aA6vCUX0QJX+AiVDpVgMXc2JMrmXDOunfH2ukpzOWB+fKhI4tMBOfSMHNgo5mqGr1rDz
 VWVWFx0rruIH7iUYrpiha9Jqh76G1P9bKK3am8ssE6kDSKbNTZt9MMGGYtIT0nXlYKE3
 Y0dje3xi6bTYMJ3TnGc76+3z/BnZi4ubZ7icgPsWK1at3C/D39FlDEC+WH0/fS2Zk1En
 Ro52fEq/0Eif6DqNcn4kysRsQWpweH2pyNKIOjcGAhqWCkaVOEYlVFwQchu2E7PemkDq
 bMBnx5och0ka8/hyFUCGF6gM7zt4EculpgZ7uS2i0ntvSVko1PNwrcdYts4Lf2kmsEy3 fQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mtcupkgk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 09:13:52 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4118F10002A;
        Tue,  3 Jan 2023 09:13:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 37AD52132F3;
        Tue,  3 Jan 2023 09:13:52 +0100 (CET)
Received: from LMECWL1288 (10.201.28.198) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Tue, 3 Jan
 2023 09:13:50 +0100
From:   <lionel.debieve@foss.st.com>
To:     'Linus Walleij' <linus.walleij@linaro.org>,
        'Herbert Xu' <herbert@gondor.apana.org.au>,
        "'David S. Miller'" <davem@davemloft.net>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Krzysztof Kozlowski' <krzysztof.kozlowski+dt@linaro.org>,
        'Maxime Coquelin' <mcoquelin.stm32@gmail.com>,
        'Alexandre Torgue' <alexandre.torgue@foss.st.com>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221227-ux500-stm32-hash-v1-0-b637ac4cda01@linaro.org> <20221227-ux500-stm32-hash-v1-3-b637ac4cda01@linaro.org>
In-Reply-To: <20221227-ux500-stm32-hash-v1-3-b637ac4cda01@linaro.org>
Subject: RE: [PATCH 3/7] crypto: stm32/hash: Use existing busy poll function
Date:   Tue, 3 Jan 2023 09:13:44 +0100
Message-ID: <000b01d91f4b$509b3ee0$f1d1bca0$@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQE9xJnjLNHmulQwHw6lCuUzVFT/vQLW0/48r6xWuRA=
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true; MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2023-01-03T08:13:44Z; MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard; MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0; MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=d270d5a5-e33e-46b8-bd19-8468824ddf5e; MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=2
X-Originating-IP: [10.201.28.198]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_14,2022-12-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Lionel Debieve <lionel.debieve@foss.st.com>


ST Restricted

-----Original Message-----
From: Linus Walleij <linus.walleij@linaro.org>=20
Sent: Wednesday, December 28, 2022 12:04 AM
To: Herbert Xu <herbert@gondor.apana.org.au>; David S. Miller =
<davem@davemloft.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof =
Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Maxime Coquelin =
<mcoquelin.stm32@gmail.com>; Alexandre Torgue =
<alexandre.torgue@foss.st.com>; Lionel Debieve =
<lionel.debieve@foss.st.com>
Cc: linux-crypto@vger.kernel.org; devicetree@vger.kernel.org; =
linux-stm32@st-md-mailman.stormreply.com; =
linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; =
Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/7] crypto: stm32/hash: Use existing busy poll function

When exporting state we are waiting indefinitely in the same was as the =
ordinary stm32_hash_wait_busy() poll-for-completion function but without =
a timeout, which means we could hang in an eternal loop. Fix this by =
waiting for completion like the rest of the code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/crypto/stm32/stm32-hash.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c =
b/drivers/crypto/stm32/stm32-hash.c
index 0473ced7b4ea..cc0a4e413a82 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -960,11 +960,13 @@ static int stm32_hash_export(struct ahash_request =
*req, void *out)
 	struct stm32_hash_dev *hdev =3D stm32_hash_find_dev(ctx);
 	u32 *preg;
 	unsigned int i;
+	int ret;
=20
 	pm_runtime_get_sync(hdev->dev);
=20
-	while ((stm32_hash_read(hdev, HASH_SR) & HASH_SR_BUSY))
-		cpu_relax();
+	ret =3D stm32_hash_wait_busy(hdev);
+	if (ret)
+		return ret;
=20
 	rctx->hw_context =3D kmalloc_array(3 + HASH_CSR_REGISTER_NUMBER,
 					 sizeof(u32),

--
2.38.1

