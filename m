Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4369E750090
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGLH7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjGLH7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:59:08 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263AD1990;
        Wed, 12 Jul 2023 00:59:06 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C50ZAK015254;
        Wed, 12 Jul 2023 09:58:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Um1B9av/YquzKvNJu7FsuOTP/FgdzsJGIJWDhEQJ774=;
 b=6dBxyx5S7+VNmvzTQOD8oDl0fwA6nWSebqi37ymuLJGuAv5KKl3hJ41fzx6ECqwKH+gI
 SFxaNFLdtF4T7334wrmMgWNvAV3f33y4EerRKOkDsIuMBrBsT1bsHGRsefu5DcgvkuHN
 MZqFiX80vqtP/9g3r5leiM1IVtPp0QQpWicLG1aMofP79v2ikBT+shUirt6eZOLj4rXS
 cnhvyUKswk24bzgKnYD8Sji7/7MurhEkczKHwvf0hoKob8U//n1fzjD8YFvnvn/Oya9g
 NeMAfcql5D05IxSDm4BtUln6BN1EyinD2GkTseuP36Wby//dNY13IkGwenI8EGFGSG+F nA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rs6u6dr4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 09:58:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 24765100058;
        Wed, 12 Jul 2023 09:58:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E4E9A2115E0;
        Wed, 12 Jul 2023 09:58:37 +0200 (CEST)
Received: from [10.201.22.9] (10.201.22.9) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 12 Jul
 2023 09:58:37 +0200
Message-ID: <a584c152-329e-9c79-ec62-795485302a55@foss.st.com>
Date:   Wed, 12 Jul 2023 09:58:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/7] crypto: stm32 - add new algorithms support
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230706073719.1156288-1-thomas.bourgoin@foss.st.com>
 <20230706073719.1156288-3-thomas.bourgoin@foss.st.com>
 <CACRpkdaHn8fhZtuhU4sXHK1xoxO3-xYg_Xb=3=bX8i-uJM9KDA@mail.gmail.com>
From:   Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
In-Reply-To: <CACRpkdaHn8fhZtuhU4sXHK1xoxO3-xYg_Xb=3=bX8i-uJM9KDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.9]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_04,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Did you run your test only with the patch adding the support for 
STM32MP13 or did you try the whole patch set ?

The error is on the test vector number 4, which is an HASH of 64 bytes 
which is exactly the size of a blcok for SHA1.

Did you try to run the test for SHA256 ? (I guess you will see the same 
error on test vector 4)

I have two hypothesis :
	- it could be related to the padding of the data. (I don't think, the 
patch does not modify these lines)
	- it could come from the way the first block of data is handle. To 
start the first pre computation, we have to write 1 block + 1 word. The 
test only write one block so maybe the issue is here.

On 7/6/23 09:37, Thomas BOURGOIN wrote:
 > +		/*
 > +		 * After first block + 1 words are fill up,
 > +		 * we only need to fill 1 block to start partial computation
 > +		 */
 > +		rctx->state.blocklen -= sizeof(u32);
 > +

I found a typo in the number of CSR to save/restore for the SHA1 and 
SHA256 algorithm. It should be 38 instead of 22.
Tell me if it fixes the regression.

It could be possible to divide the patch in 2 (one patch rework 
preparing MP13 and one patch with the new algorithm) but for the 
upstream I do not know if it is relevant to have 2 patches instead of one.

Best regards,

Thomas

---
  drivers/crypto/stm32/stm32-hash.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c 
b/drivers/crypto/stm32/stm32-hash.c
index a50d73c18d5c..88a186c3dd78 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -74,7 +74,7 @@

  /* Context swap register */
  #define HASH_CSR_NB_SHA256_HMAC		54
-#define HASH_CSR_NB_SHA256		22
+#define HASH_CSR_NB_SHA256		38
  #define HASH_CSR_NB_SHA512_HMAC		103
  #define HASH_CSR_NB_SHA512		91
  #define HASH_CSR_NB_SHA3_HMAC		88
-- 
2.25.1


