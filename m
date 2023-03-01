Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462A36A6500
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjCABwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCABwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:52:07 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4511732E7B;
        Tue, 28 Feb 2023 17:52:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5ZIp4nnxYMAHl/qE+kyhZZnCQvpSVg46fbVrNn6Qv12iL1Ou7bgkllRyCRPwIhX9ulfxZ+tTTSBSPIECyIoVtfr54Jj3HReRFyi1W8fGv9LtSEj9zv2h2qgg/GWXF0Wp95HOJaV1DgiHWNj4HRdeCUbBW8xF9/UhNrXc/0A99D6DmL51bJcCs8fgbLIG/v4gT0ooIWcgMJMj/VsHFLceXOqWXpzVmdYBz2D1XQccitzy3lXUVBRHalJ2Uykn0Nf6VXbXiN2xkK1caSWep4OfNg1zCK1V5FfSf7DDs9aOfH1YwlNN1/xqZcjbsD8dnMnkPR8eYZAonRSeRbwVA2tNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adALO7DNK1OaO24+/T91RzwtSj3QpcRjUVKieiXwzyo=;
 b=JTwXj9f4wv+XA7nu5iB9JzLQRs7v4k14AnGQf1EMyhnCvPl3H9zrbSLUgyANZwzUsNmWhjGZfL72lS7U9TxseCs9yaMIDPtuIX/eskOfi1eogIxdLgVQeHIS/LWRLd6Q83+oUJk7fnbjCt61SFzMbfU7dJABblQW29pxqPQcKnf8qq3K553xmS7K9yEgNl18tVY57G4rCwLv/muRqIaEy0QpvqSBHA0bERBtQtyZI9K2gSJ9GUVTPjSX1tY2mH35U59YvEUdo45va+qK7kW373/1B/OAC8NDrQqChM2x4a2ECljoyxlCyKqPvDzyCRyhsEkqcfu+5MrpWvyeOiVMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adALO7DNK1OaO24+/T91RzwtSj3QpcRjUVKieiXwzyo=;
 b=KX8vap08LyLxSc49nVcaDbluApMotfXwPEjRIQHU/3sOYwc3NX/TntqInC/iENvwNT+sjWJOTA1yUWq75EVJhg0xgYnuzPEyRdQMaW2XdVOG7ZBbJzyh/CZfWpB3d0r+Bf3vQoIIgYW3Yflq1yUeLvD28qOhzOY6diChun9cYog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7546.eurprd04.prod.outlook.com (2603:10a6:10:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 01:51:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 01:51:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/9] dt-bindings: crypto: convert fsl-sec4 to DT schema
Date:   Wed,  1 Mar 2023 09:56:53 +0800
Message-Id: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 6199e52d-1590-4a44-85e7-08db19f789e6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stgl95KnZlbpdpfWOsqA6MuxoAOFxJc7rNOgee2sgjtGIzsCxd7dakfnqu5e6dcWaKIf70TaEgFpPEgI30X+UoXqz7q6k93taBUXDehIL+o39yvkldfS20Kn1LN2EKu7EQOlVq18bMMCw2j2pVgD4Ii2uq4sMEc8xyEGdCDzQVEdDmHhiYErfrdZMgxbm80xSUFBCP7T0LFocLUvUn+NLMLGysm81wD2rzh/HqqH4uXc8ElEuVHNy8e1m2UHX/CBeU4NU9xqQcsSUt0ZpgwLz3R6PfBhLqpOj2VNE0L3OWDHPjokp9rZ468dfyOGbn+r8ZbA8wZlywpea0/3kbdKSgBlK/W8EVO/b/fEzaSqSfh+B50nJ1nXq/Vqt5Lys+Q6Lt/qfcvX3HAvLUFz/uWIYo1f0so5CDyACjmgjlG8ScQGihTaBtAll6Snfq2QKlWqA1VksAR9uhu6FsGDVT07xSsYkVezS3J+n74FVzKkIBKCnEbn4H/4MlUNOR0dtiPvsRNAU39zYV9/cgf9JEhahvRc4YAgvQTUy/mc91QMR+TeTrGug238yC1LrvD5Zw+xrrybjYjrAHGx4jGu4XhZuHbZAznTwAaJdpgyJu5VUQxB4J7ZUdj1FtCL+BzsuWyyzV7YVZ0sBxxEImCRQva0gI0jINaGdY69St67HjmDoP41B5qedJvfWhGFaPrgnWw80VNXT4Ua5yvNmQ3vmdGB6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(83380400001)(316002)(6666004)(2906002)(6486002)(6506007)(478600001)(1076003)(2616005)(52116002)(26005)(186003)(6512007)(86362001)(8936002)(7416002)(41300700001)(66556008)(5660300002)(66946007)(66476007)(8676002)(38100700002)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rL244TQVxd7iChif2r5VxOw05AYyuz7xFDwLhHmNkGJRL+mkd4T9NFHSOjIO?=
 =?us-ascii?Q?mRU6Ja4JfgNr4kWDPwbD9XsfvyWuczddCnzWoZoo1b286c4dwfWF7D2HZJmw?=
 =?us-ascii?Q?zoKcRiZAdUHF2P4/mQXvs4T/xMcXVQ5HexR3NuIPOaF1TSGZV3LFkF9LiIdG?=
 =?us-ascii?Q?7tOAOuNUop2fWF2heBiaJV45IevJNdziTOU/TbN51OHx7Uu6V6En3wlgxpxJ?=
 =?us-ascii?Q?An4M6WyugmMiGIiQXnFWwqt5wbrFDvQ3GtnTtp7dnw5jJSMVRfe6beml9VJ5?=
 =?us-ascii?Q?hJX34N9ndR+W7B6jTmnBjfmax2Mrkm6t1dorcikxt4OOHqj/U4kbAgmNY/Mn?=
 =?us-ascii?Q?3NMQBaUf+8CyIWDhAKfdhtv25Nqoc6lYyE+Y3D0S3GF2hQuyj7JMpxv+OTbA?=
 =?us-ascii?Q?vQN+Bb9MjnHtTfiemF5U2cTe1av2alayrO09bEJMTJc1wA36HCfxkEl6H2lR?=
 =?us-ascii?Q?BcCOOkLhtbDicFM5gc0uFXVr9yONRHstYA0UmJaNXSsYpYw9v1srA2USWM9b?=
 =?us-ascii?Q?+PzWUjgJP4NZ/HK4sXzAwB7rofnfXHavalBxAZAObvyW8TFTofCSFzXJ4uGG?=
 =?us-ascii?Q?x3fQ2XDQlFWIZ+ewncOLminp39M4FeXAPEzAfj/Fzf/mwjJEIqRF3CjfGO28?=
 =?us-ascii?Q?d1aAIxQ64q8sJbzMue5BtMkEYvJxg8YCaWEY76PE6bol0/AOgKaoIFMGaBih?=
 =?us-ascii?Q?BfGiQfAv7E77CMU4BIvBNhhkHI2tkvR01/X5Vo481jv8kOQxHmTrQABHw6By?=
 =?us-ascii?Q?Q3I5vIcCWXwrz/oeFZSJkQpq0pf7BqXRJHaa9LIzy9mpRv51qFhtbxXj+GnE?=
 =?us-ascii?Q?LiO7EbRySDIdIQvIY6a3jddUNoAF9NTSQv+898IYC5j0JJ80OqwtEksr+8Lb?=
 =?us-ascii?Q?faKzsP2xQq0Ok4QmWh0Y6mCfJIN8GAHX9FysjPsU16HnG5FoD9y7EE6ntR10?=
 =?us-ascii?Q?7R9z9U6k39E4cdKA1B1cztK/rRbsb79ORrVHvLAeDjP/Tj+E0A4k38xq2MmB?=
 =?us-ascii?Q?QdGqS9muvcHvq+uOnRY9Mq/+oYVXM/mYcscqXXP57u0vwtGlykmwoZ5LR4xF?=
 =?us-ascii?Q?rViy65xeZdPDnJh7sZf8Xn+m0TKsU/oMAo4c5SCdvtuXp4hZFkU+KuFGdss7?=
 =?us-ascii?Q?PO9CU0Cd1uCzs22AfT7zHrkx01h76i+gIvLtJ5rbZhroQ6rTKbRFFhH+jzn7?=
 =?us-ascii?Q?86kao+MIyiwGzYGYoSbMKlz2L3Q1VsFGBfok5ji3GoxfVTB8G+BtIsK4t8XG?=
 =?us-ascii?Q?ewssjTlhchWgTWveSOtTMA9QfN5+iaEi+fV/YwvTb6y6wjFTAs4NLz1Kxh8T?=
 =?us-ascii?Q?yvHl+uaCs/zJVf4Q4J9BBrrSP2L4CY6QPYun9XKijccFTR+MuhpLm5WT/cQ3?=
 =?us-ascii?Q?MzB3v9OzDLsRNWTwj2D1GwWRFsorefKDAkS8yLiJtXPLbmlvAFvNvHQpo7Rs?=
 =?us-ascii?Q?x3BmHQceiDvNW4zmm/VTujTnp2L8uHfOmmexKxCNxerw4R6Cyer9kARsLmHs?=
 =?us-ascii?Q?+JgAigBBPzGk9wQKxI+J7lle7tign83wn9YLEBmkVTO0FgwmUy6AbUSRvUyd?=
 =?us-ascii?Q?n5VtRfG7j5Gg4FpBNaf58XVmJ54wtKorFgwmaWBq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6199e52d-1590-4a44-85e7-08db19f789e6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 01:51:56.8300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xgHAwx+lJRDuaeNBpKpQxqkvRjpk5jjsnvO8qWdeY2Sws4xsnE7M3QRHaT+UJOCSbGf2UMiSsdKivky+jjJPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7546
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This is effort towards SystemReady IR 2.0 to convert the txt binding to DT
schema.
Patch 1 is just to drop uneeded number since following DT schema will update the name

The fsl-sec4.txt binding has two parts, one is crypto, one is snvs, so I split
into two DT schema file. patch 2,3 is for crypto, patch 4,5,6 is for snvs,
patch 7 is to drop fsl-sec4.txt binding. patch 8,9 is to add new node

Peng Fan (9):
  ARM: dts: vfxxx: drop the number after jr
  dt-bindings: crypto: fsl-sec4: convert to DT schema
  dt-bindings: crypto: fsl-sec4: support sec5.4/0 and i.MX6UL
  dt-bindings: crypto: add fsl-sec4-snvs DT schema
  dt-bindings: crypto: fsl-sec4-snvs: add simple-mfd compatible
  dt-bindings: crypto: fsl-sec4-snvs: add fsl sec 5.x compatible
  dt-bindings: crypto: drop fsl-sec4 txt binding
  dt-bindings: crypto: fsl-sec4-snvs: add snvs-lpgpr support
  dt-bindings: crypto: fsl-sec4-snvs: add poweroff support

 .../bindings/crypto/fsl-sec4-snvs.yaml        | 181 ++++++
 .../devicetree/bindings/crypto/fsl-sec4.txt   | 553 ------------------
 .../devicetree/bindings/crypto/fsl-sec4.yaml  | 366 ++++++++++++
 arch/arm/boot/dts/vfxxx.dtsi                  |   4 +-
 4 files changed, 549 insertions(+), 555 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec4.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec4.yaml

-- 
2.37.1

