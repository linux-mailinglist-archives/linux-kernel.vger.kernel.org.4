Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D36651CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiLTJCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiLTJCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:02:22 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2050.outbound.protection.outlook.com [40.107.247.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356C2113B;
        Tue, 20 Dec 2022 01:02:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpuNj8XW83vhhlU+mHa8kZWGQzssUx4/Mmz+GvP7E/C7fWoRCDeErIrCWl3iufPEtZ2WwjarZxqzt/GvsYAnymi8BgOoDF0DU8b4d5Vx8UEvljPgqLhaZw5iOHZCJBhcXUz8q7SH5vEeAzFThd/ZZruQaRpi2F698yPRxhcaM+TGVlV64OMjqv831l/uMG9P9YhJ2WxX0cE3ngAudaUgCrMOxZI6EoNCPwADJWIgp/vpIpwAkVdfNbV1MVy4J8sR2BwqEmabVNBU6F4mIRc8oVmvkbfwYEYm12oQQQ3xErpMXqbINaAItCMOIgXrwtRaZouFJI/L4210wRjyXZfSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8QNEk/mx+b2del/+/BMrjhvBKlOjzNe77S6SnRpG4E=;
 b=QOeG1swpPkEDZ2u+s8dAMORbzNJ+aJB+GrSI8WjTWYWyLstNofO9k4HZ4IyGbSXsexdlqhQ93GUH/tm1oweolQ9KGruNlva0Hx+h/SnK9/QZ2fRKwgkKhQ7TRIUh6fxDxLsw1CDLZwBzfuAjc3OosDD/dLJZDmc5+jMlGVWsniA03x2OZpHu1IGS5BCgvDUvKxI91vc2IUCR1E47MzsqhViD7AV/GwQLXXlhyUtezhflV6TFGJ8ZxHtuQh/mPFWODDZ7RRswgkEyHGoEwlxXmt1Vh9ldsUGmyyFjAvT9LDCdmm8MfRMZrKhKMkHQ6qYxS8S1CJ6SdCQo62rsGf+tuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8QNEk/mx+b2del/+/BMrjhvBKlOjzNe77S6SnRpG4E=;
 b=DsRt6c16P9kBWw2s05nAEtFYaH6ZedjPeM/gxq6XURh9f0X5FQmWe+P8fy+NEILRfyeLFi/WPPHvJNWWkkcsveb6POJ/JL/rnwdGEuAQBcwcxGrsaE51PqjbLNqrJC4tIR1HTguFfVhQIzvFjxVSkvKsKaHqbo/SFS7ZnYhrmiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PA4PR04MB9221.eurprd04.prod.outlook.com (2603:10a6:102:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 09:02:18 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 09:02:18 +0000
From:   haibo.chen@nxp.com
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     stefan@agner.ch, linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        haibo.chen@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] gpio: vf610: connect GPIO label to dev name
Date:   Tue, 20 Dec 2022 17:02:47 +0800
Message-Id: <20221220090248.1134214-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|PA4PR04MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: a26874cc-8d00-4cc2-1c61-08dae268e533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RIt4nosJ57tAVBP56oB+qMsB5L6LMq1PSms0xlg2s0ZIeVjBdJ1EfZsYn35gl+NjTg/AhG/eG42u0lvFNlcUu7sHuYocwKNieOxNFcIgmG75RJlj11dUSZoOOeHtQMI6D5iQ4Tr0lxnk9j0rnb8G9HL2LEximf6JO3ONU65z1r9iYZu6W1nmoxjjlANW1KVAkwRZuIt35FfMlpES9AvocazZFeRXbKK+tWo8cHSYVmOYAddSba7ffAa8rtEaXrhO2dAKOzH3nMqphqf2X7Id/61pedcenNhIsYMA3hHo3yE0HDPnsmCazRX6PkhQlVCtSNrcIFAC/xrZYwiPSwm+a9pSfVcC5aCDHsrmaHrt/mZI/kWB+VsBpplznbx3JFnpKvxVn+ze3gt/anKkZGR6If0JFqWSaM3ZpC2gBohi8na+TieVmUXFjUoO8oaz0lFTfmZi1NB0tmu6PYuTz/1+CgAuUSzUwgBPegbmrv3uhaA0YDjanlwhpshCu2+kchvX6m7UEiucLWK6FkKHLB/fqqE+lxldcrb4ZWSbPcUSqNGh80xuX015gF5ywEu9lt06ggrsSRj6X5PBe2AbPWqXAj8sGt5XZZTaMED0bx/ypEbQS0OkvbM/Ro6FyuUoZpnrBIM4IGOaWW+cqqqf89paxk3l606SQb43D4NlMQzThGrQMC3UpeHL3SWrXofMI6oZPXMxH8+T6O0+MXRixeATjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(38350700002)(38100700002)(36756003)(86362001)(9686003)(316002)(6512007)(478600001)(6486002)(6666004)(6506007)(26005)(186003)(2906002)(41300700001)(83380400001)(5660300002)(4744005)(8676002)(8936002)(52116002)(2616005)(4326008)(1076003)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lYC0BjeP59g8t8fRH496tRJWtlsvYV8hF6Kbco9KhSEX8F61GzFpBuPLDhQw?=
 =?us-ascii?Q?v5M5TFMT4VbltX1TsK4EqwLKBUGYTrBuf33ExkTyvqw1mTEDHdMnkgT0T60D?=
 =?us-ascii?Q?omyN8o2TVaqYPuJx1SYU+exZvAt28ztdczuSTFhVPahOuMrBhH1wArXmRCxQ?=
 =?us-ascii?Q?ZjTG/TRpBhqpd8CmT/iIVCvLpOlMoqBp1+xcQDQTX2mNP3REYPA3ys0BXfWW?=
 =?us-ascii?Q?3d7vFuD2LCoJVt808Q0jOiWl292is+XMfRmIGstJWXWV1B9Wqqxuhx3LIuyd?=
 =?us-ascii?Q?88Eccs1fqSyMStUtEBXcNkGb65wA2RW1+grAlRclkYkZy/DYrT8hxv3mblvS?=
 =?us-ascii?Q?hfrcAxeDQ2tzLghS2DmqbbcBtgGD+fDuLuTuHqpTUJmVC34jYVm/5UPFUPrF?=
 =?us-ascii?Q?RtFLfFOL/itieU4p6nQsLf+SoxiqXdU7IaE+cjKYx8ZoqJN13gsn2C0/3/3q?=
 =?us-ascii?Q?sIy6mq/HkKxkMRC/WepzOIU8tn8TunJfT9BKjmAYTMGvs/HnhFbU1QL4l1st?=
 =?us-ascii?Q?oG8Cb5CSPmbRQLVyBCMbqulK4WQLHb8kuT0X/4IatUHKPh/ynmEhKPdfnrE9?=
 =?us-ascii?Q?JsGaJKANf/7rIPt/TWkf6uT1/cRgWrkIsicSJY9J0jdsnP7gEyKYjwnbNRB0?=
 =?us-ascii?Q?0YeS3FucSA5GtjclxWDWqbSxk2a4IxmPl/XXMuwyrcI9E8zJqVWjoNI3TnJ2?=
 =?us-ascii?Q?M6WoLLWCN8r0DhsLUjniNiHdKB6f+sK2ITMvxIxCmUOiFlApC6HNjbqMrtZE?=
 =?us-ascii?Q?QXOrQMNjamq9rAiLZ7qNv2849VSd3df9JLH3n9K1jRfB/kxxABmO8mybpoQH?=
 =?us-ascii?Q?RiqRbaHnKt5GF+troLrXEXZFelT5i0QdujIYNc0t8mxPVcPsUcHl2FuW6Mnk?=
 =?us-ascii?Q?ej2LjFOpcvmleLuvA8zhueIDxi7KeOevOB4HIxTaWw0cyhUAlRnCeJXMi8Dl?=
 =?us-ascii?Q?F/xge3hzAIrozvC8hiQRzRRigfaSywXJFIWAeh6uciljX8K+54yoA1vjd3cD?=
 =?us-ascii?Q?VYsFh8QXRX4uxoINjRaZboezRhSGaUXtwONHaSpK9zeP54DEtZBfAhOCO0dQ?=
 =?us-ascii?Q?XZq/j4mUlg3zpyX7BwfXoYbnqhxQ66pQLNDZkOZrUyU/Unb+iigE8kIGcqSQ?=
 =?us-ascii?Q?Nz2sorvhqbtLM+tiPnwnGKqg4P1iHxkh8DaNX3rsK8QwoDXVXoMIds+fsvqk?=
 =?us-ascii?Q?wjWWhMHbSdwRsVhkFiSUT+aC7Liwoa7BKUSsC+Udz5jNHb3bZBLRlNqfyzrn?=
 =?us-ascii?Q?6hbMqkxAZuz8qtG3wlzas08vNlFTU9b1c3F2dGy5a2zaQbUfFnredqodQJDX?=
 =?us-ascii?Q?Jlx1BtmRndo0weYjH4FnzKkMl2+48yM3NpWEphDeRdZBpPSyY8d10bebXNX/?=
 =?us-ascii?Q?0vd5hrCVmAOuijSP+OlHqxi7I+9A1RA3aE03KTt698AtLRayDfkrYQwqVH+c?=
 =?us-ascii?Q?ktijYDAj0msKXMuAOh1heUhoSbqtfb68NzS54/pUiFoMLNCiRiubseFMupLC?=
 =?us-ascii?Q?3pW6Z7WEBkVC0mQ0wugq6rzXyQ2WrwRKNcWEZPVbvbGtz7kOXqCInAg8GU5h?=
 =?us-ascii?Q?GRYmx4FEbDMYtm9WMxDqofIi7xkpjX6fIp722qeQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26874cc-8d00-4cc2-1c61-08dae268e533
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 09:02:17.9591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luZ60Nvrat0jsdDMvqRNBa7ewLhzBDXZFvTXE1yWmk+N1w5ari5MryqNKiivnNepC9sp7+uM4urUvdb096btTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9221
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Current GPIO label is fixed, so can't distinguish different GPIO
controllers through labels. Use dev name instead.

Fixes: 7f2691a19627 ("gpio: vf610: add gpiolib/IRQ chip driver for Vybrid")
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/gpio/gpio-vf610.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 9db42f6a2043..a429176673e7 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -304,7 +304,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 
 	gc = &port->gc;
 	gc->parent = dev;
-	gc->label = "vf610-gpio";
+	gc->label = dev_name(dev);
 	gc->ngpio = VF610_GPIO_PER_PORT;
 	gc->base = of_alias_get_id(np, "gpio") * VF610_GPIO_PER_PORT;
 
-- 
2.34.1

