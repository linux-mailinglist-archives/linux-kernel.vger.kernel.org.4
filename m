Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5422F6C6960
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjCWNVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCWNVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:21:00 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8635021961
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:20:58 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NDCEcp026092;
        Thu, 23 Mar 2023 08:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=ZnMugTZQBfuv7PKEx2U6bglozDQ+fPKidiJXoOKeApo=;
 b=LHfBuZH43pyH39pJQhu7b4+Y0nTk9GQUve0h8PQlniAFkdmv2eyAonZFTnkdMwxAtw9H
 uEDaYxwqxQ7J7W8+lpLDR26PNYxT6M/XdhTHCvHEMakkReVT/0ZiJkHaWR+bHOoJGcJn
 XdFHJb1cl2ILHxJXWf4QVcZwargFtKXEjvVH4vOKv4Km+6vN4NYscz61bssgW1OqnisA
 qh1OIok/zvhmdpGxCcfHtVC+buuWmPH9QptAegXIOTVhRSVf77k0CbtOdoBxA8YBcUjj
 h9PJB2bLnX6/BvoowNxKg9fKL7EE2yTvzkVWQXoybSKPWWx4GyCwh6CWRH7riFwQ4eqP yw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pdaq36u26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 08:20:54 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 23 Mar
 2023 08:20:47 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Thu, 23 Mar 2023 08:20:47 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9629B45;
        Thu, 23 Mar 2023 13:20:47 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <dianders@chromium.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] regulator: arizona-ldo1: Use PROBE_FORCE_SYNCHRONOUS
Date:   Thu, 23 Mar 2023 13:20:46 +0000
Message-ID: <20230323132047.833737-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hFDoQeorNtiJrS3Ufcv6zs3h-eLcbgFg
X-Proofpoint-GUID: hFDoQeorNtiJrS3Ufcv6zs3h-eLcbgFg
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore synchronous probing for Arizona regulators because otherwise
the main MFD driver will not find its core supplies.

As these regulators are built into the CODEC and typically have no DT
representation the regulator framework is unaware of their existence
until the driver probes. These means the probing of the driver needs to
be synchronous to ensure the regulators are not substitued for the dummy
later when the users request them.

Fixes: 259b93b21a9f ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in 4.14")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/regulator/arizona-ldo1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index a53d8441702a4..b465c0010665a 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -380,7 +380,7 @@ static struct platform_driver arizona_ldo1_driver = {
 	.remove = arizona_ldo1_remove,
 	.driver		= {
 		.name	= "arizona-ldo1",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	},
 };
 
@@ -389,7 +389,7 @@ static struct platform_driver madera_ldo1_driver = {
 	.remove = arizona_ldo1_remove,
 	.driver		= {
 		.name	= "madera-ldo1",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	},
 };
 
-- 
2.30.2

