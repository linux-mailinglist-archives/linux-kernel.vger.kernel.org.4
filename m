Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549907228DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjFEOc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjFEOcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:32:54 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8792683
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:32:53 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3558e8mf010267;
        Mon, 5 Jun 2023 09:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=BUg/70VlLSF5CVdl4IkVb4amOpOKudh8xy6hs1SyEI8=;
 b=E0A7Z1dTyhJOn3BxfODvSXLAgR1BU0UwsmtqSmdM12D+s2MVPQl9FaJWx9Hx88K9kTd7
 NsFAYsYM2P9DxKvetl4/rSfcm34Vx+OQadx9B18wJwYMpTYeF+zeILOrwWSikRK+9Q4P
 IFrWcUQStX7w02pqsQPjcXK3OvEoGUZD9AhDfL7b81kUj1zfI+9NPDi9D6Cem1uq2pgn
 x+ho3xgWdiO8zoubvQFGJ0BFKyxpkZUSeeXJC2WaIzQjuw8yf8ZGMQid12Q20boaO8Mj
 mTH+rTKlTBiJnCsQJ56dfM+akTYWqlagOiSObMx52c8+k6n12hvtJ9TIrdnSAro5g3xC wQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3r01xn9y0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 09:32:40 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 5 Jun
 2023 15:32:38 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Jun 2023 15:32:38 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8E557458;
        Mon,  5 Jun 2023 14:32:38 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] firmware: cs_dsp: Log correct region name in bin error messages
Date:   Mon, 5 Jun 2023 15:32:38 +0100
Message-ID: <20230605143238.4001982-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1UcXCkDZowLuqpgA1f1A0IgzBBonALag
X-Proofpoint-GUID: 1UcXCkDZowLuqpgA1f1A0IgzBBonALag
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cs_dsp_load_coeff() region_name should be set in the XM/YM/ZM
cases otherwise any errors will log the region as "Unknown".

While doing this also change one error message that logged the
region type ID to log the region_name instead. This makes it
consistent with other messages in the same function.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index d7e46a57ecf9..6a9aa97373d3 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -2124,6 +2124,7 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 				   file, blocks, le32_to_cpu(blk->len),
 				   type, le32_to_cpu(blk->id));
 
+			region_name = cs_dsp_mem_region_name(type);
 			mem = cs_dsp_find_region(dsp, type);
 			if (!mem) {
 				cs_dsp_err(dsp, "No base for region %x\n", type);
@@ -2147,8 +2148,8 @@ static int cs_dsp_load_coeff(struct cs_dsp *dsp, const struct firmware *firmware
 				reg = dsp->ops->region_to_reg(mem, reg);
 				reg += offset;
 			} else {
-				cs_dsp_err(dsp, "No %x for algorithm %x\n",
-					   type, le32_to_cpu(blk->id));
+				cs_dsp_err(dsp, "No %s for algorithm %x\n",
+					   region_name, le32_to_cpu(blk->id));
 			}
 			break;
 
-- 
2.30.2

