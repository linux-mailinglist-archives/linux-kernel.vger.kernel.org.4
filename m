Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5048F5FAAC1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJKCwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJKCwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:52:12 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2162.outbound.protection.outlook.com [40.92.62.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDA486816
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMJ2s/yhz6oSALnilpTD+H1togVRUNrMbZnxdG9sI/M43SisNiO9pz03SN63R/ML8CpKTeFC/S+fNQJcGoYJN9y8yfExub313PvIepUicJ81LF86DOYAbx65mI5pjs2uyT1Aj2t/Wl0Jvb/KWlVx/MjI9flkN9s2xEpWVC1M5GN05ibkKR5PjGL/Ge4tQcFV4gKHNlffHh7hS7UAy0KVb1jPIdgNezZ7WgIHTeeHmvGOfRWTMtDad1sVRArWRWog/1kSXCqkCrHM54WMpuxWuV1jW2HPCV7t3PEMnHDnyFBL47/V6sV8o08lLN+aon6TYK+oi1Tj0IOaZ8umZ0n1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuQmm+OXEYn2kVLPXO6NxpUZe9Co3PIMBY+yds95fSo=;
 b=jHu8o/D7REPYcmfhV4Uopu9LyZ1jVCXVFk9yJEt2ieSmnnqY/is6h8Au1TlOmKqjFk0n4QfvdMhBcNmooW643OBqE9zKhVNHWDkJq4lstYoGsZjx1Twkp8CI/S/8OpglIY8gK/GX9ElvTV6CTPANIi55XUhPhoDSa6Q9HMQHfYijQlm9minKP4YMWA9oAF/g1eEje3gIXzWM5uLiJM2dhebLhtpbv8lNZznU3ow4K+62Ae7exQzG6Wk7HGSpiDQdO6yo4v2tjQzEbuXbIgWudbfNJQbAsOzM4/VUVz+dpeKnRg7AfXGUWZPR/K5U+GOmX/+bcj5Tw8MLOANjg+VtkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuQmm+OXEYn2kVLPXO6NxpUZe9Co3PIMBY+yds95fSo=;
 b=VjTvBiUau3+25ZSuLntXZaR2gpSrEZj8R9+xxLugm5Q5rWh1mZiK/m+ReP51RpH8uxSgi59eHxhZA2VL7tsbgGtTXSrqdK/fZvPz8ghA1Z4kFg219xF4KVbck1JhOS0E/jwVWucQEiPN/CmvfzJErzHPzqDVje/LA6W5sqeZnl07GY6tXiYJVx6q8yNBWXQu2aZIp0IBeVFZbXtS+UNLeePsQ/2OvB0DSRPMKNzT/6vjkqU+HH377Uf0Gn8oLxvsMMUTWR6rynmEbIPms638+OgoOqx92bD0SvM2X+Ng85RImHnvGgLWqXbxMoUCJIISQ05+iVDdPNykL+jhpDXs/Q==
Received: from MEYPR01MB8397.ausprd01.prod.outlook.com (2603:10c6:220:173::8)
 by SY3PR01MB0956.ausprd01.prod.outlook.com (2603:10c6:0:1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Tue, 11 Oct 2022 02:52:05 +0000
Received: from MEYPR01MB8397.ausprd01.prod.outlook.com
 ([fe80::5eb:9121:920e:abd0]) by MEYPR01MB8397.ausprd01.prod.outlook.com
 ([fe80::5eb:9121:920e:abd0%3]) with mapi id 15.20.5676.040; Tue, 11 Oct 2022
 02:52:05 +0000
From:   linkt <xazrael@hotmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, mario.limonciello@amd.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linkt <xazrael@hotmail.com>
Subject: [PATCH -next] ASoC: amd: yc: Adding Lenovo ThinkBook 14 Gen 4+ ARA and Lenovo ThinkBook 16 Gen 4+ ARA to the Quirks List
Date:   Tue, 11 Oct 2022 10:51:36 +0800
Message-ID: <MEYPR01MB8397A3C27DE6206FA3EF834DB6239@MEYPR01MB8397.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [d5ZK3ZWlzHN7VeNO+8LVd6T91MaFG2WAyXVVIJcMjzx5KxP68C09qfQr9bUlMeUI]
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To MEYPR01MB8397.ausprd01.prod.outlook.com
 (2603:10c6:220:173::8)
X-Microsoft-Original-Message-ID: <20221011025136.24341-1-xazrael@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYPR01MB8397:EE_|SY3PR01MB0956:EE_
X-MS-Office365-Filtering-Correlation-Id: 0468c8c5-2d8b-4aab-11c7-08daab339477
X-MS-Exchange-SLBlob-MailProps: 0wLWl8rLpvurtECvkfOV+HemtfmyI2LDXu1Y9uUj8RHScVHHn9aBcnVVHpvtUNC11NoAXaBxASt725s5ugXai9GClV3qeqYM+6iK2N9v5xhgDzUmRYJccdO8AXaZDr66PmKzA7XWWwmw+z3ukOoV+5QKkawE9QrRz8gxYaVjTlATMHHjrRKyAoq1AsVoSQ891CYRUnHNCTJ98UlRYHR2qmAgFiLbykGaCoSj3zURDkWyXXv1eBkqhGh/xBFAaVkZ/Jg1SqS/DiY1PSZbDPhov8dn1qcQSWVBqUxcaBpXFl37W3UBmFBpAAdMZtambIegavj6aWeW3ZGI691ooYwI5Hg7QruAcjnEw43TCGB7EyfHKmv1o8TkE45V1LlGnO2O3qDRgBcp+Q88pCL+wvtP9JvM9bhdmtzaxFEYve0yydwkAjBGipn1vV94CwzlQNXprAagkvq/tb0L7ismeIYQG7xzzolLZSjTk4SH80JUisAFMQpNy9mP8m5ZfosHqRcop7f7Ajn72tmuOkWM+fZL3td2cA3mQRvju8thHAJ6i+42Jd1R9Zy1Y+j162LE+Suw0p+GDu5i8ZQ1ZlffrXpvIDhEixcWiM3Ay4e1l6K3B7NwDniuhRRh+iIWcX5+B4m416gyD26081lfD5DElXl7YyvVXAnyQJ7p4yAIyQu86M/DETm2CLe+L8W2YO4l2uQmZY5IK5HluVT4gFveFwbXY5P5IsfjZMhfVoRX0dmvzwFE+5ncXj51ySeVke+ZCKOtu/eOkW6wN3s=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1kobIN2a+0UOKqJ6MH8U1GBxWE7MJMOfkMjCczWGoptpL3FnzvaYXiQYw2GoJZe4+XgVSbSLwyxMRSI6KbHAjU0hCkcWkqypA3+xOBrjohKMNO6N/FY6JIp1kYQuRZtG6sr5x/1EwY4x/QcLQ6Ldm1lI99k/jYlJtyPDT78hMNNRg6zdkw6nuTmpU0nuuwJIzCaX832bCDLAqwXVxdk5ABO9AfeVfIxxqCSJBOYlh0gDJnHSFO8J3hlduqxjmH3WD/dl5equRSJU5oZ36P1okdai8I/PyIoeOy3NIRFskBYbIND+ScigzMuM/6Ndvj55BTh0gYSrnE9BtMTDOTsGSBeU9HdMYek0ripVIL1pOOAQK7KU9cuMA4AgqAM3XE6W8sXxKs5DPFy9CTi+7ZcQYPI9WVrrKjnqLOC6Vn3PCRHE6h8z3w7RaojHFTtvO43xMAXAaiS5uXvsqAalaGhlkz4wNCIDz3FwhXFsw+YR8OByRQ28ldYGE5jSz02Wz190CvgJp8xpwBzv0dxv+qnKJdLS3upg4ruYUIDn2WkKkSsWxfIlqH/SR4PGskB4PbYyBZU7wkLaACgN4gAxXmZzPKGGfWC8Js5yItROud185P0gtopCAqpZ5dWBpHXnrav37nEo+POqOTpn0lN+QZRX0X8oI2TvCl4U4WbJ5A8yk17xCD4BJ/ekomRek9sLLVX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A9Q73KpeF/VqsbE5aQXgQ7XqJeqfAUHPfg6cg7o4fvWf0nUudtQdSEg4acsO?=
 =?us-ascii?Q?sEh1v7/Nha7bC1fN3u3BVcXwDD5sHoon+oJXUcyFkDLhuBT1OMJXvNbptFj8?=
 =?us-ascii?Q?SKbFBuy/hZZj8yyupcJeTfIDZTcZzXcA6sG44pPLpAo6/6Rerb8AnBMyTWqk?=
 =?us-ascii?Q?yVNE+O4UcvPkHSUAL2gQMgKP3RCpO+7cm0/qHVYVFSGqKq4K/3z7ipmSkfCM?=
 =?us-ascii?Q?gth9GQoPsGxZo5d50o1DRenqmJHdIF7DcyRB0aLFbl8pF3yARgdflbMuQ9JP?=
 =?us-ascii?Q?6DknAMvvIl3hNJ3+soQc3S6GzgIfqY2litg/VFZnBVizrrtWvoSfe+jdyLfS?=
 =?us-ascii?Q?sgL39Q3VunenpLk688leTpanKT5/AFdRPd6WtAiBs+OYHWtKSWD5fK/KIoY/?=
 =?us-ascii?Q?k4WzIC9ceVPRNADAt8FMDZclOtivHj0ls24BfZsusuRE+k4zLFAC9ruKNa1f?=
 =?us-ascii?Q?o3Vrf5fQzu1poGcT1gBgRleWcTftS4Sv9VfDBoVp/xtDDkeem9F++6CSOY8w?=
 =?us-ascii?Q?dh1Psne/BN+b9H47j5w+6gCX+ICP5dRC/QUjTXM1JrUONjZQk4tcFzlX+JBi?=
 =?us-ascii?Q?f/GrqCD2b6xCqiMl8Oz/IwQ2XElWrl32DdnIVLmg/iUYOAu8R+kGb21AvyLO?=
 =?us-ascii?Q?Cj1EU9zDLEkINVeIg7FXXKgEHo3a0ngFbOTXXVnM5oTGR/S5tTi3xhBX0BH9?=
 =?us-ascii?Q?p1ccCsA6nuaUUVx6Wnet4GUm65MQuWkvNblFy5CK4AMrW4ugA1MzBYrSKShB?=
 =?us-ascii?Q?Izy/8SQKXaxbZPIP3Po/6Y7GYhr+geRjSBQqDdWiTxNubIcWJmmzCRpn6t9E?=
 =?us-ascii?Q?VZUfUDAw8Mgsps0tkKSVMKwhfhG3F3dkC6dEi8r1iOQPJz74V1Uakld6rd9O?=
 =?us-ascii?Q?E7NQUtF8an+OeZA5VP6QQYiGb16w5pVmJakzBa3Xhz5LWtYlia3SxJWOy8rj?=
 =?us-ascii?Q?AdiOCmQ8teKbl5RZvP3dl5eBkAtIODFDdmCLZ4uaWf00RsLApsmFfr6c1CQu?=
 =?us-ascii?Q?7DHsrxZPcEI8Y/hMmBUhc6bs2m8DfjiKE0IZQamePftqhgOcSjBfAZNTiGv+?=
 =?us-ascii?Q?4S34uqgEyAErr6yqiqwkweh3ojDMPnzz1ygeArnqeB3OfyNOnGUEy0sR+HBv?=
 =?us-ascii?Q?l1j3K+S9ITDuJOK0F9BjGcSjY9ebl1225RuRvekDYLAfcQPX4deGbxzy5ch9?=
 =?us-ascii?Q?vF8FWc3AsGRuzQ8xc8OVgabN4zP44MZ/BzUmgChYe85B1pFtKU+Dhxl+ajVx?=
 =?us-ascii?Q?fFwEo7NblvUKXmJUohOyOLQr2pZhQcbDFJkFd6zlzkvpty6p+3aU8vM74hR7?=
 =?us-ascii?Q?PATgKWMOGrFDMxUv884qvFxXSBqy6htyA8g+NEwiomhAFQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-f49ba.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0468c8c5-2d8b-4aab-11c7-08daab339477
X-MS-Exchange-CrossTenant-AuthSource: MEYPR01MB8397.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 02:52:05.2308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PR01MB0956
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo ThinkBook 14 Gen 4+ ARA and ThinkBook 16 Gen 4+ ARA
need to be added to the list of quirks for the microphone to work properly.

Signed-off-by: linkt <xazrael@hotmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 2cb50d5cf1a9..09a8aceff22f 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -45,6 +45,20 @@ static struct snd_soc_card acp6x_card = {
 };
 
 static const struct dmi_system_id yc_acp_quirk_table[] = {
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D0"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D1"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.37.3

