Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DB76C0119
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCSLvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjCSLvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:51:52 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DE221A10;
        Sun, 19 Mar 2023 04:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIO3AXBFXw5GT9y7fLY5woB+AsfKymFQrfaS/zpB+lmE7GwDAJcRWQIpEphSntX9aw0zy+yqv/yeR26Yx5NId6kcfj5N9rN3HhY80KdcD87KNo9+GQUT7zSM6h+dBIT7TVbX59+epFj/CtIWrKlHsaNYR2III+6Zk/1iBErWSY5fZQC8IB+qhp9EKZsTrntVKvQy99CIVdysl4q0QaYpMiK6dq1F6KRhC+BDuC2qwwOt5hkwvbR/zZLdK76dgzbgfHtX//IUNWWRTTn+8+MYq5pQnD3EJmX3Te8RTIWuJvt6py/KXnO6A/CL6ZHEsu+cDVvPEcO1OlM6wD3GqgRwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDw5DpqU6K5S66RHwoUJICFaH7ygMKUR421HRre1JlE=;
 b=Dkvo0DA1afFtAYJ8vOy2y2NtmOqFh0zOKN1oyrHwUaHIveMhiQHis9dYkVUwptbuEI7opuqwbO46/Lrfo/vimGdWM9XxHeM/BW0J8Ed+NQOsJhHJ0ukwkgbqSEXPjo56HATVZ7e9U0chKLFINSDYdJOy3/lhdVfBWZhdXNyOZDoGEr3Gg2n/gq+GNYGShHgUy/t17VSqm8dCjqsQ2ArkbcN83pjYqOTtB63ZpxferMgqYhlNp3+Ogkg+I0ZZfWaAiRCfUApeVmjQjSyC5U64iHt7APOxZhC545Faxiz+S5BF355xmrzSGnbcrs7OHT/XJz4p0Gu+T0btiBvCmwKorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDw5DpqU6K5S66RHwoUJICFaH7ygMKUR421HRre1JlE=;
 b=aaqs7MJ2aOtO4DowF68eBbRPb0N8E6lm3R0Hxiey+NlJWcjeKwqQU2o2K7/VN7Dntj21OahUKdQFBj4gA2BrzZIqIs/7i4OmJSjTMraif1Jv6ELxbqfIEJtNQA+KI2lOWCm4a/vTJIrDINjP3qidwYi2jN1HfjYvCT2fciw22IM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7685.eurprd04.prod.outlook.com (2603:10a6:20b:29c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 11:50:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 11:50:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 8/9] arm64: dts: imx8-apalis-v1.1: drop ci-disable-lpm
Date:   Sun, 19 Mar 2023 19:54:55 +0800
Message-Id: <20230319115456.716969-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230319115456.716969-1-peng.fan@oss.nxp.com>
References: <20230319115456.716969-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 0add6dae-a37d-429f-2220-08db2870215a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HkEdMHtf+7vZWSoPhFb5IDVzMNqOcZIHLXtIjPvyAdDQBbGVFV5W9C7VXs1Pk7Yhvmf0RSOlgNbV+aRiCC0hGhFxg5eSFJkoq3LMfecxbCk7meB92Mjui/Pgsnph5VziAZBRtJqyZmqyy3qNPPVDUUiDE0bga6mh/phhe+vtNDrUiaYhnc/sq7O6zlOy3M40yqpR/HgR/1pKUGUTj1SqgvAppib3ETl2S251/Z54F1E/J20xoRrpiZy5zS5I511E8d4HcaYFE1TO2qk80jzap5ytJicSsHfMIMwtB2IGVVj2Ac2jdVjKxRHxvK/dRnSNkKOAQFSnmAr6XvMF9tqORRDDm5Oonj47U9vipxzk1DCdRbk/EfF4Yo2KwATuViVjD+bH1LB7cb/5cTIjCf0pSRqVm3Nor3rtOiNWtmXZKaeeptN/06Ag1XKVouDXnEZ6uUO2Mvx2s3NMTwx9qTsYt1kNmtcAUKRcJoja8UHQbiIMx2a94EgiKWlqTZNePprUuBqJrRz3WN4W0QEXZ2R84tj8Z42QP0ftczPXsyiv5SLz4I33Pomyk93e47q/YTk3A03zUPVAIzlTxrn3u+oorddOryfM+tYhubCPOkl8pcdw490xEBP3gglWfcEjKioNGuMoZaIfk6S0U4MxpRUQQdLURHJAN1zPZGtqd2kW21J3mh+9R8uphMxXn/+az1DEG9XS2Iw2opgQNzsQ+O9tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199018)(8936002)(5660300002)(7416002)(4744005)(41300700001)(86362001)(38100700002)(38350700002)(2906002)(4326008)(6486002)(83380400001)(478600001)(52116002)(2616005)(186003)(6666004)(6506007)(1076003)(26005)(6512007)(316002)(66476007)(8676002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wwq/8sNeXcEEEwJaz2mSOUEO0lBiofjAIDTiMk9LmGjf6AI+MtLoG9UkL/6N?=
 =?us-ascii?Q?zBVNWmXOv0W6+u/DRVkoot9BISNOZhyjWqVET0aGkZaSFanqk7EQKykrBDiT?=
 =?us-ascii?Q?g7IsXOhOW3HwCUPS3uVPbL3H5wBY/dPpdEoXJkm83xQ0YovjJq6/ndIceVxc?=
 =?us-ascii?Q?bOqK8d7VMjpKgxUDsg7euCsH6oSTcNUidBcydfZQRph/CAOzQsz+JBhMqunf?=
 =?us-ascii?Q?DwUK6EmcC2orUS0OkV4aqYWnopdnbAMWVrP/A/s+0tJHpzyk9F7HesV+3wO3?=
 =?us-ascii?Q?3iYV1U1yXzl8oEv/1V96762f4ADhhNKKcCzICR7d2ZXV9swiLQnKiQ6EinfL?=
 =?us-ascii?Q?LavaQYH+UxZ8qi8PizpHIaQpY8U2zozewHa3KhPNkWo2mamuyZpbOZQ9i5QE?=
 =?us-ascii?Q?kBTWbW3KA5xPko177d9TrnK2Mjp+fmhNjh3OttjqJyTYGx/PzEv07Er1NEH/?=
 =?us-ascii?Q?5jDrfArQDs1ZiA7pua7rlmWOKgMPaFv9FnOISI9qOxh1VhaL3JfM78fkLaxp?=
 =?us-ascii?Q?xylBu8IiUwkSMc8F7KDIfwxXVzFm4Ja3IGklgU8r52UivJYSFgpf0VaInURA?=
 =?us-ascii?Q?KuoupfuP975NcDFnsQHi1qETXmb3YRXsy79v8LhW8pMSXZKO20KwdTsbJPPg?=
 =?us-ascii?Q?L/RLR8mFKChvEnESsAufA6YVz5NXMjzj2a7rbyADZEOCHqEU9Ywo+3EH/hgO?=
 =?us-ascii?Q?YmxI9H/+CljrUNEDNHGwcXX4n9kMio2H1bQ8RtRzLtxlbPEH/KpuWBxve4u2?=
 =?us-ascii?Q?kIDbIr9gNEC7Ln3IqCIoepgoWH0ZaYHN5yORkM6cJT00t85RGdskzjlCWbju?=
 =?us-ascii?Q?CHKAEnSE0Jsh4z+p5+2LT6+3Cup7DMQgh3IX03PraByWyHOmltS0G4k/hMLI?=
 =?us-ascii?Q?UvSS3rZ/Nms6AaeGHEuoxpkrgXHziABmtIW42XI6+qQPQgsGQln7+71BkFll?=
 =?us-ascii?Q?YrAZHVlK2dauyTe1fexea2+m9wNaH/45VyraFIDgzJS/w0Qg+Azam2w+1h4U?=
 =?us-ascii?Q?T4kLER/hfvHCHK+6nTuiMji/KIEWhMiLtj38j96Gy83jsLQxKXv0ya8mSgMd?=
 =?us-ascii?Q?myLlHSVA7CJmlauL+98WSp+uF2wDQcWsn6i1wU7+vEiDb3IBAz7LdscUX8U5?=
 =?us-ascii?Q?yU0Aya6TPhJ52v4ZYtZdmsPN+GZr+6wiPuCktRLjyyonRogzc8/yH+Kb8LDo?=
 =?us-ascii?Q?vSj+NRZsL0CL/TflDlhJNVouyJp857BpmQXXi6Dja9kALVR/kd4IB2LoCXLQ?=
 =?us-ascii?Q?f65Nrr4GO0lkO2VytI/hJJzusO8I6gDulA9xt9lG9Vo/niaOkniekm+1/Fvz?=
 =?us-ascii?Q?T34s5KIfjpzldFI37KnJlzWS25+u+WtV+7fV9ES8hhIpAoXKJHf3lSETwt0Y?=
 =?us-ascii?Q?qv+0oVCbFfYWrlItZFbS4sTPtFssnBh2kASrXC2J39ZHmIjq6fAFBECqmvkM?=
 =?us-ascii?Q?XffDoMe0e1iPBvgxRFmnkqmPelvSqbr7KwmG1XQFXoV2MB5LfVZn6Os1pPIU?=
 =?us-ascii?Q?egUb6nlbpR6gZ/4qyWlUCeqDzADqAPMzgOn9i7qj2EP0GPqlR9JxA3TpIwUY?=
 =?us-ascii?Q?+Pb6HqInqMNJbVUlQ9NOUO9+kDG0YWLWOjcO6lcb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0add6dae-a37d-429f-2220-08db2870215a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 11:50:26.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhvgyitymgHprxRCK8MY9Z/d3CTipGyKcG5+RXhNb5iENCKbPauub/MbrjkQLFVCf7COplORcTwOFqOeNINvGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7685
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This is an NXP downstream property. And no binding doc, and no
driver use this property. So drop it

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 486adf849452..bd5d771637ca 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -726,7 +726,6 @@ &usbotg1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbotg1>;
 	adp-disable;
-	ci-disable-lpm;
 	hnp-disable;
 	over-current-active-low;
 	power-active-high;
-- 
2.37.1

