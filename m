Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BA965BBAA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbjACINF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbjACINB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:13:01 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F35DF71;
        Tue,  3 Jan 2023 00:12:59 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30379K9x010968;
        Tue, 3 Jan 2023 09:12:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 references : in-reply-to : subject : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=selector1;
 bh=f45oBMJc844ZCXMDbesSeS3x9ZTo6pQSGJmchQpW4CE=;
 b=CntXIfyrB2Haka5FHYiT9KwrsvH98wf90+C87RvonfGhMc0tZ1iBuRqdAvEdeZAHZMXs
 lgpkifQsLrLXPkbwoSL+zpmJ/UQK0ZKT8OPYLX+IBeNHFfsip+wqyNMKT+EMK8nnqRWH
 8DwWdn6rKKgPOpW38tNE7BbwKU6Zz4fIQfC11ExKxB6j6eHlbBoNih8BDek6CkcR/OfH
 JRAfxn7eP/n98Wec+uoU9zW9FBSc7XHEBhBAeQpqglvvyxXftE9VNjU9P5Qn4CEw+3B6
 1AhOz+fEak/8hFUpYnYNvTSjU7wmCU8o8pcI0dgVfUVqQ97/BerPSyM9h0RkiiktfBwQ Gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mtb3e3q3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 09:12:33 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 340FD10002A;
        Tue,  3 Jan 2023 09:12:31 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E8DEF2132EC;
        Tue,  3 Jan 2023 09:12:31 +0100 (CET)
Received: from LMECWL1288 (10.201.28.198) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Tue, 3 Jan
 2023 09:12:30 +0100
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
References: <20221227-ux500-stm32-hash-v1-0-b637ac4cda01@linaro.org> <20221227-ux500-stm32-hash-v1-2-b637ac4cda01@linaro.org>
In-Reply-To: <20221227-ux500-stm32-hash-v1-2-b637ac4cda01@linaro.org>
Subject: RE: [PATCH 2/7] crypto: stm32/hash: Simplify code
Date:   Tue, 3 Jan 2023 09:12:24 +0100
Message-ID: <000901d91f4b$20c2dcf0$624896d0$@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQE9xJnjLNHmulQwHw6lCuUzVFT/vQHXDoT+r7RUDhA=
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true; MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2023-01-03T08:12:24Z; MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard; MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0; MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=4898ab01-b61a-4506-99cb-8cb4532979e5; MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=2
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

Hi Linus

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
Subject: [PATCH 2/7] crypto: stm32/hash: Simplify code

We are passing (rctx->flags & HASH_FLAGS_FINUP) as indicator for the =
final request but we already know this to be true since we are in the =
(final) arm of an if-statement set from the same flag. Just open-code it =
as true.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/crypto/stm32/stm32-hash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c =
b/drivers/crypto/stm32/stm32-hash.c
index d33006d43f76..0473ced7b4ea 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -399,8 +399,7 @@ static int stm32_hash_update_cpu(struct =
stm32_hash_dev *hdev)
 	if (final) {
 		bufcnt =3D rctx->bufcnt;
 		rctx->bufcnt =3D 0;
-		err =3D stm32_hash_xmit_cpu(hdev, rctx->buffer, bufcnt,
-					  (rctx->flags & HASH_FLAGS_FINUP));
+		err =3D stm32_hash_xmit_cpu(hdev, rctx->buffer, bufcnt, 1);
 	}
=20
 	return err;
--
2.38.1

