Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA466BAAAE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjCOIWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjCOIWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:22:00 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361732A990;
        Wed, 15 Mar 2023 01:21:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bb9RXKA++OBwhfxekUUo8+DQASl9OuxXv9hlM/nl8M66BR3rOcYnx+2/MqB/pw7oqAhLu8KPoEm/Ef9T2dYQQ2OqKNINsFsjmoEu7NpUidOA60c9IQcsSGqQ/bnXW8eAPLkVO8gh1Wsm9x5821GUzm4tTmxJkpwLySUDZts4jMAMS0iZ5gOsgPxcsM9Fo1jKNDDzYVsuKhLmBzOY1/23c41ynwAipklw0QqiS29xsMRCPnww680XwEZBuiSWLhHfJYycEAzNLkNmflu476zqn+IRSh7H4n04OSklXoWaVeT8I5NCtnKpEYsOXU603fkBUiiMa+WNh9SesLVDQa+EYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH0+jYwmkjUSTp0If1c7KiVGidEhl4NXXDW+tbGIb5o=;
 b=FQ8tPaTRkqktDbTQyVRJcBxMbOEEY4BRS8v3a2PsMrFgcv/Mu5BLCngrWbGVUIXUz4XShtuThqj1dBuRr/PdgwRtsmq8W7M+dRZ0YobKzrKiEbd5xP5Nt6zFNg4krbeeVrjQAIEJGJVC8TGiWlSVKtLIAzeCndDnbfMLfp6+bZqHC+PquEBbaOLToznKY/ArH8QXbsFyVufELzRyxFm46p98mD/oWtJP3XMtPHWaWeC3V7OMybwETX0S+iHTwh1UhQJAcgASScWzYIsnUL2Gc0Nb9+P1s48yH6VDOnyb7JD9Zvu76tBdyZh6/xUAF8tI3HcE4Y+OaN7U26n9W9jTKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH0+jYwmkjUSTp0If1c7KiVGidEhl4NXXDW+tbGIb5o=;
 b=zof6Bh7RdKNOz7pcgBD3XNx3vU8JVoQ6m+Kej1krA+BXTEGAD/ciQGzdcVL8Y8pmzJghULHSq4i5v7sRL6YvHKayIpOblggnm4CFNPlICj0ZtpBjuQ+V1ome6umywzf5QqR7UkvmMTPftBuhnz/UfIRnFhU6keGP29uuKTVG0Co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB8779.eurprd08.prod.outlook.com (2603:10a6:20b:5be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 08:21:10 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c445:c8e:be5d:d40e]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c445:c8e:be5d:d40e%7]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 08:21:10 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 2/2] rtc: pcf8523: remove unnecessary OR operation
Date:   Wed, 15 Mar 2023 09:20:21 +0100
Message-Id: <20230315082021.2104452-3-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230315082021.2104452-1-javier.carrasco@wolfvision.net>
References: <20230315082021.2104452-1-javier.carrasco@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0132.eurprd07.prod.outlook.com
 (2603:10a6:802:16::19) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eebb214-4d50-4673-0d38-08db252e3bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yGZJ23qAvY/GjQp6W1jv3PrJL2QqiuJdPdkr0RsnVNrxT6kUUzTAxZ42bnNIB8Rd4wjZmw3tuyKzDCIu2js9K/MuYMfdIetQ09VS57z/jp0Bk9/N5+Aqek0kMvPYqA5Lh3WLWXZvulU8zwNuMR2iA4U44mgXyRNgC+q//jSWDS84T9yrhHZbJ8cMQUvEEu/kttMsqY0+DKTtdLEABmEvJOIy7kz2LBlpgeZRECswGPXwaHzhgPKUkViDP+Vg+ssF7aAj6i64iFxPecJgPf5VLd9ZwfSOMHAH6n4f1uzhm+5d7k6JZ7ueeadbQoHPQpx3mpAgW5kEs28B9ST1sUsct1/6udsT6RtPArFkl37U3PTOKh4yxkYdetSOrdb9upWD+8fI1BnBWgC10z07431L/jF6khAfqLCfy0myH6ovyHcHmXvbDIDYh4FEBCv0Z14i/PygQLhEIwXA+zU6f7d6gQxCxsVBtkSc0966p/pdmvWM7N63Lt96c8PCfaaPnRde5Q+ES0yNHsMnDnRxLw95914H3yU7s4g+Vja71X0vjKJ5Lg4C4UbQGxUs/T0e9m+WaJnDgmZOogvXVWBtfVwBARUg6q8APyRO4IEgktDtyGS2lJuXegE8LFd6pjcwBbJurqkfEHpIJdIaOnuC3DaakCdhMJ2Vo33X7ik4ap91mRol4/SUVYWlSX3702/DPV8lgdZ91zJT+yEO48Ex8A+KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(396003)(39850400004)(376002)(451199018)(38100700002)(4326008)(38350700002)(316002)(54906003)(86362001)(8936002)(41300700001)(8676002)(66946007)(66556008)(66476007)(83380400001)(36756003)(44832011)(2616005)(478600001)(5660300002)(4744005)(2906002)(6666004)(107886003)(52116002)(6486002)(6506007)(186003)(6512007)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pzTqILLBwMqdtpUXBvWSJYOZ/pMH5FG7PMWixWO0LQp67oF1mGYTmsbkYuFs?=
 =?us-ascii?Q?PKJ6+chbBj/f9siN7b3BdDYgdWCu9l4PSVXm6eNECmOWonLVRkrly1PJVnCJ?=
 =?us-ascii?Q?0LGs0q8YJzKqgJI2gUN8D6vW3BdeNSNVBEI5OPfzD6AVt502o6L8DL80DZg1?=
 =?us-ascii?Q?dqyGvXpmYaYxxRHI9meuYp9hdPJkV/hJXyQsTsggsnqa2QO9OKmnRF+ptMtv?=
 =?us-ascii?Q?wmHOZTH1X2oBo5E72AvWysMF8dkgfHGlVfAJ55scyqII1/odJCsQbhljbOx6?=
 =?us-ascii?Q?Ft0mnbo2dCSH1xXwYEoiz1hd3dgs+yG2v2y9WRuqedOBUE2ewTIvEa4F5GOo?=
 =?us-ascii?Q?RAMbfVkBoAkkxePIx0QtCS9Cc7TkWBJk82WiOo5Kk9kdQK36m9otTIqPOQSE?=
 =?us-ascii?Q?kWkI/ZDzUK5OEsJyAgKZCvdwm2C7HP0iE4i4DSzlmecGzTmjlezwqQNgUiyS?=
 =?us-ascii?Q?kuKgzKWQJfSZ8H6RfoujchJgCkGZgOHUWsMkVdBSmcC+M0C2v4W1150hiFkl?=
 =?us-ascii?Q?JyJbPY1eyxX4rPltORTjVkcPfQWBV3gY6KTfLSJDKyDSR5PkgrvYb0Hgbrlx?=
 =?us-ascii?Q?9sfj2as6R/Nt3DEepGqgpeMBXjw2Y/Y7TEX86skJ2ddwgv+YkUntEjiC6fFU?=
 =?us-ascii?Q?o25ebP5QM2jHmQBBjZlCtG8GneO/exeuRZFuftNG1QEsnys4S5KUyUlr8BsQ?=
 =?us-ascii?Q?+Fh2yTW2tHwAPQ45juAHM02Yq4JjQcl/BResLmZ3Zik7IA/bCINL0frw5PSk?=
 =?us-ascii?Q?a3YTxlVE2FVwDf9uOXogKr2Rn/YOHt5Z1AwVR1m9BMQDlbp4tbZmpq421Tam?=
 =?us-ascii?Q?sH8RzV+hO2Z/aqP1DsMujpC3OoPaGt8artcotIRdtqvNAyh9jiQe3u7TDz9W?=
 =?us-ascii?Q?u0dmJK1Dw1Moy9DvgVH+IatcNusHfs/Ohh4N313Z1qNmz0J5yquDq/I+RB/C?=
 =?us-ascii?Q?IXpxidv/QdsZCcSh+viR3XNen285i7esKyd9rZXwRcRc9g70BULXYYGbuKIF?=
 =?us-ascii?Q?82U/K+J8JQWbedeDztoJbk1X/dR9NdJiHzCelfLyk/IqP6K2duV73e/pna74?=
 =?us-ascii?Q?OgJuWLpISn1puAyThfRmhKSUQ+1cRXjzXhZUw7cP4cQb11hz2zn6mgiUHjXD?=
 =?us-ascii?Q?trB9NR5KNDCPBbMKlzN6GMXndknHbrUbwtwqR7ax5M9E6MyAloZzB3Jw0Ex4?=
 =?us-ascii?Q?AocMQL3U/fcKzW0XROEyN0dRWipTgMz/3U1KaqNbKliPEaHxIObJc8EAyo/t?=
 =?us-ascii?Q?h9mhv3+57F8wZCBGrjdlFnbwPHyuNUJoLRgKpaPtTG5eB9ok8RprY7n+Xd4j?=
 =?us-ascii?Q?riHVGhhRmc+mMy969ryTVvH/lwBLoHV4jxPR0fxXUgpu2QsDaXS1xu0uT+Uw?=
 =?us-ascii?Q?mAbddP5KKgd72YjYLt9ly/399HzIQGSI44U7BeTLOhU2SjxFruQp2kMuNuRA?=
 =?us-ascii?Q?YjP3vgUULkC8CF/Ar2ErVKNxUNRMzE/fTZ+C6NKprSit6FIp1Fs+TlsvSwVg?=
 =?us-ascii?Q?1s0X6KtLyABST69ghmXCSi1Tj/OHqdsdVnsL9jyYbAvzRLbl1qDZ8N27ArRm?=
 =?us-ascii?Q?tf21uBKFnOUFTej1DT9xSgjjiRF/9hmjLZMmD57dI4W5MuDmyv2RX8WpjRZS?=
 =?us-ascii?Q?MQzB9DZ0hdus8KDKCG7wfhA=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eebb214-4d50-4673-0d38-08db252e3bba
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 08:21:10.7422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xw97F8B8O5jIYMl05hOYD6lfxPLgXGoJzG3F8BXEgreV5UTabSeBY0B5urDBFGTsFM5ZoAmcU5g1vBWXQ/qZ5vOrOBYs9IV2GbkiRCDfauk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8779
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value variable is initialized to 0 and it is not used to set any
other bits rather than the one that defines the capacitor value. Setting
this capacitor value is the only purpose of the function where the
variable is defined and therefore the OR operation does not apply as a
way to foresee functionality extensions either.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/rtc/rtc-pcf8523.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index ccb5aa690433..e7115ebef707 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -65,7 +65,7 @@ static int pcf8523_load_capacitance(struct pcf8523 *pcf8523, struct device_node
 			 load);
 		fallthrough;
 	case 12500:
-		value |= PCF8523_CONTROL1_CAP_SEL;
+		value = PCF8523_CONTROL1_CAP_SEL;
 		break;
 	case 7000:
 		break;
-- 
2.37.2

