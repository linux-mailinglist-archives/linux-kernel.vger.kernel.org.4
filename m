Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4865A628140
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiKNN1G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Nov 2022 08:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbiKNN07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:26:59 -0500
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D732183BD;
        Mon, 14 Nov 2022 05:26:58 -0800 (PST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 410E546276B;
        Mon, 14 Nov 2022 14:26:56 +0100 (CET)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 31338460D69;
        Mon, 14 Nov 2022 14:26:56 +0100 (CET)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Mon, 14 Nov 2022 14:26:56 +0100 (CET)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Mon, 14 Nov
 2022 14:26:55 +0100
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Mon, 14 Nov 2022 14:26:55 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Do not require secure trim for discard
Thread-Topic: [PATCH] mmc: core: Do not require secure trim for discard
Thread-Index: Adj4LIgVOpRmRBFwTaCe3El9cMIWVQ==
Date:   Mon, 14 Nov 2022 13:26:55 +0000
Message-ID: <8a17ed3e0eea4aaa82afd0af3b45bcaf@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.46]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27262.007
X-TMASE-Result: 10--0.573600-10.000000
X-TMASE-MatchedRID: Pcf9tAO75fBRwtmwuQ5dzvgWrMZvbmeHBGvINcfHqhfkwMCV+cVEaj3v
        MQJZlrWjIvrftAIhWmLy9zcRSkKatcjCU69DpYLpngIgpj8eDcCEYGTT/umyEtmzcdRxL+xwKra
        uXd3MZDX4MO0bTOAtKBaUydMlh6GObMc5a0vSadwUWclmpgd+aDrGjyLONApp
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 34a5a68c-7831-4420-8b3d-899f1a779185-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Discard feature is independent of security features.
The support check for all trims and discard falsely checked
for secure trim/discard, but in the discard case this is not
mandated by the spec.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 95fa8fb1d45f..507005211529 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1761,7 +1761,8 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 		return -EOPNOTSUPP;
 
 	if (mmc_card_mmc(card) && (arg & MMC_TRIM_ARGS) &&
-	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN))
+	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN) &&
+	    arg != MMC_DISCARD_ARG)
 		return -EOPNOTSUPP;
 
 	if (arg == MMC_SECURE_ERASE_ARG) {
-- 
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

