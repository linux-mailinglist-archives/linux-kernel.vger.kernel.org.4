Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FA35EC23A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiI0MPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiI0MPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:15:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1828175A8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:15:04 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R6OnaL022026;
        Tue, 27 Sep 2022 07:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=vInO/r8CP2irGLFP0WnlEE++JH/IImoDg4aYw3XeL10=;
 b=OIdSAPLnjjRog17GK3egdqPZNTTbZhKup92L5/COtwgah0zqGujp9CROHP05XTRtIimQ
 S9fuxfQ8s2YOWsyCFl42EEif1UyQntOYoVCK36140Kt3BVUtcvUWD94vesVi2FBpv9Mc
 Jgc6PJcFENagW57PGul3c+TBinDinzB/a0Al0KX7R42qkgJUfB3OpP6OpgqGNc2PWpV9
 MOYFj8Cq2kVWOUmPFQv7JA06+4oSmyT1SmMrv5uo/emt+lenb23fm7/1fTDrUuHrFbSp
 o6WapEwSTRsFrIqP0nNkhlZ0RZrGOBzUiuGufUjhkjUO7nmdGG5hUdgbylfILAav2DSL GA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jsya2bb7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 07:14:51 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Tue, 27 Sep
 2022 07:14:49 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Tue, 27 Sep 2022 07:14:49 -0500
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7867D15A3;
        Tue, 27 Sep 2022 12:14:49 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1] ASoC: cs42l42: Fallback to headphones for type detect
Date:   Tue, 27 Sep 2022 13:14:40 +0100
Message-ID: <20220927121440.2506632-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: t5qUL_Y7G8WnIHC7TnrHLA_52lnw49Yy
X-Proofpoint-GUID: t5qUL_Y7G8WnIHC7TnrHLA_52lnw49Yy
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After tip sense detects a jack insertion, if automatic
type detection, and manual type detection fails, then
fall back to assume the jack connected belongs to
headphones.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index bdc7e6bed6ac..2fefbcf7bd13 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1199,14 +1199,11 @@ static void cs42l42_manual_hs_type_detect(struct cs42l42_private *cs42l42)
 			cs42l42->hs_type = CS42L42_PLUG_OMTP;
 			hs_det_sw = CS42L42_HSDET_SW_TYPE2;
 			break;
-		case CS42L42_HSDET_COMP_TYPE3:
+		/* Detect Type 3 and Type 4 Headsets as Headphones */
+		default:
 			cs42l42->hs_type = CS42L42_PLUG_HEADPHONE;
 			hs_det_sw = CS42L42_HSDET_SW_TYPE3;
 			break;
-		default:
-			cs42l42->hs_type = CS42L42_PLUG_INVALID;
-			hs_det_sw = CS42L42_HSDET_SW_TYPE4;
-			break;
 		}
 	}
 
-- 
2.34.1

