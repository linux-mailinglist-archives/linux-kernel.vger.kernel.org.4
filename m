Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC8F6C695F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjCWNUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCWNUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:20:54 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F3211E1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:20:53 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N7a5UG009487;
        Thu, 23 Mar 2023 08:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Rjr0/PkiGJgZ0ewLLrVUNFvNKSEl8YbvL/H2O3u1swk=;
 b=D3BeQPYtufLyE1I+/2iLxMJskYpV0HniquOUyq1CgsDOWnaIcCdbTfUlY77fOXVC4AQu
 3vTztJxHu7VGlxzGOyAx/1FFs421XgLD1v3dtG6cVrbn/IkBoQvDxm9Yde2VSZRgtox4
 lwL6fyF2RAS+KopwAS9EuWvz+YqpaxX74EwCXV7CKhj35uxKMPAI0zei9o0jntmGcRQk
 n2ddWUaBNntFnJAOwUe3AOuD4R14m4hnBbFv6/5rIZOstQXPTt2ybrUH7CYnpqSjtWmR
 9EbwEWX3Z0sxaeMeHGGSs+3XakY7kCDtLFB34oL1ZiEs/S5sY7WiJNH/KgWQQd1DSC3y Hw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pf7tj4sr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 08:20:49 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 23 Mar
 2023 08:20:47 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 23 Mar 2023 08:20:47 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AD495B06;
        Thu, 23 Mar 2023 13:20:47 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <dianders@chromium.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] regulator: arizona-micsupp: Use PROBE_FORCE_SYNCHRONOUS
Date:   Thu, 23 Mar 2023 13:20:47 +0000
Message-ID: <20230323132047.833737-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230323132047.833737-1-ckeepax@opensource.cirrus.com>
References: <20230323132047.833737-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BJvf09bhuNAK9CRNnK36cllxOmraR5WT
X-Proofpoint-GUID: BJvf09bhuNAK9CRNnK36cllxOmraR5WT
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore synchronous probing for Arizona regulators as the main MFD
relies on the ordering of the devices probing.

As these regulators are built into the CODEC and typically have no DT
representation the regulator framework is unaware of their existence
until the driver probes. These means the probing of the driver needs to
be synchronous to ensure the regulators are not substitued for the dummy
later when the users request them.

Fixes: 259b93b21a9f ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in 4.14")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/regulator/arizona-micsupp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index ffd8416487eb9..e250e5f3fcbcb 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -365,7 +365,7 @@ static struct platform_driver arizona_micsupp_driver = {
 	.probe = arizona_micsupp_probe,
 	.driver		= {
 		.name	= "arizona-micsupp",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	},
 };
 
@@ -373,7 +373,7 @@ static struct platform_driver madera_micsupp_driver = {
 	.probe = madera_micsupp_probe,
 	.driver		= {
 		.name	= "madera-micsupp",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	},
 };
 
-- 
2.30.2

