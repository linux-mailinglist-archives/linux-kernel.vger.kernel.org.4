Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7207861A0F5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiKDT1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKDT1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:27:14 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70055F39;
        Fri,  4 Nov 2022 12:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9/TLJ/b00ORc8G3XQEJP849nMr4qT1VD9RF33w9p96X8KogYG3ZhkzGdfwIA4M9hFRVW5ekaaqHvG/hzPoueGp0eoGRhnFjMfCI3w1gXy8iaB9oTxfedChtwzy3kgGWd2NTCVmHijxiAX3V2PbAfUH12bbTyNvVKSlCne12tVXv3eKmedsf7zrS3KmtHqkSXVIb7ijn+Il6CuBBpZZM1Ut1idpZl1hnh0MUb7qBbWbIUyRXU7vZXfV8aQTv3Uz/ZgfqTxaWgrsXjBlCxCnoz8cFXmZ9T61WavD8d5NyxktCvlhlBhZOk2lY9Ty8AtWNyhkqLGCKhmcJ2at//zPgkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piF7hnOxrB8+5TeYFyGERmInGGiIugoxuFzkPnNEm1w=;
 b=Ig8GD9HKUuLSrFlFNpGUndRC0Hqzm82wQv51d9oLcnXtGLHkJNgJF6YC5YVHQ8ZBkdeaZa/aokcpdWVtnuiAWCA/0AbJy1NyFXDG89wksVKz0UwwwsdIpn9ma3zBWp6myYhrfUxpAkd8F4TY+ZeRukLE4Nz6xU2F2cTgcCyioTB3BvKR43UeaTuHTZ4rtneFb3T5D9FbDZSIQgkFA31DvQ1G9T31lcSH8U/DBQaOLGConlWxUMkZTbKiG6zxdHCMILj1AUBDsoXSRjtfTgqlcaOD3OimGEh1UGWzilPjN2EAv++dF4PC6n5rhcX8Y5PCJAVTbTJKT3PzwZcB2ZpciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piF7hnOxrB8+5TeYFyGERmInGGiIugoxuFzkPnNEm1w=;
 b=OLAIf9ok5okvJJOOf6KmCf//LbLbj0kCEvAGhzdZlMzHkC5dyDIrV2l4SzyVy6USsJm5k/MyTba1lYksBW45UZutyLv8ZiuVYngT7JX0nPkZf7gVc03B2h4JUiSDnVrkijcN3oIZo220r6SGWNgMeqpMQUxQ9+q1WQn24SR6MD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Fri, 4 Nov
 2022 19:25:58 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%11]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 19:25:58 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        festevam@gmail.com, han.xu@nxp.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH 0/3] add adc0 flexspi lpspi to 8dxl evk board dts
Date:   Fri,  4 Nov 2022 15:25:40 -0400
Message-Id: <20221104192540.1661833-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104192135.1661541-1-Frank.Li@nxp.com>
References: <20221104192135.1661541-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::6) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 6853e0ba-e7c2-46d2-80d5-08dabe9a6696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNMLh526VljAMdFQu9NqMpij/i6lNJwcK/F2ghmTc+dTsuhqfiMBCxMf+MjZTzSvwkzV8CrgcvSq1cg5zYum9qGi9D+mQ7uvKAW+h8P5ahrUiAQjpnknn62qpZQoHuLOPL+Lrw8BWjTwvabGvS5NckaGf+ESsIWk2ySFvLXkmrU6z6KxDP+HG3LE1MXg3YoKefeYmgCJ9YaUjlF955BrmVDQ93KuJqms9OulnFblbSAlkKDPh3hB+jpArDFw/awByLf1bQ3kusug8XBYXDuV/bW+y5ISOxw0gLR6YN6nPYS5/Hqz+7q1JL1xJfp6s7mfqON7rKPnJ+Pb/rFgF0drT0fVFIHWOz/HtycqgJ3AJOgsDo+KkEHN1SWY0kw/DwqyUfp/EpujvDuK3+J6//W99CJ9LQq1236N5EsBXp1+afWkA3JTNTGuGhYZZ+mApyhELbYRfVzqvsdjnvrq/fPkFLFenCpomVt+BXYy2jqGJLdTgKrDHbZnUAZ0J1Zm3NXkTfJN3ArnuklxN2zu79z+qMLcjS/ojf0kGRduWFQWaZ6EXRou7VgraFj2ldN6uaDNa177+BJvkAbYdp90ol7GCW6nohEhfDdYNOOFZ5e3O6h5ECu+9IaxGaLE6C8njp4BiC47G5SoBO73BgVQe7XdklNmfXEfXaCcZOv+QdRPDfSUdgyr7Gs5Do+7HQxCWouZrU3toaafElLrUq0ePgaMp6asfIoQ3of3j7isNE7nS84/5eCJ/3Z7fXTaCikoMnsf9r0b5qHNBbhBvpaeOT0rqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(36756003)(478600001)(2906002)(4744005)(83380400001)(7416002)(5660300002)(86362001)(38350700002)(6512007)(8676002)(38100700002)(316002)(2616005)(186003)(6486002)(1076003)(37006003)(26005)(34206002)(66556008)(66476007)(41300700001)(66946007)(8936002)(6666004)(4326008)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RPKm+a+VZ3aXlBoQ5TFonqF8HC6aigJTmdww4HIori5EZEYbl7UofuzYh9QV?=
 =?us-ascii?Q?+IFnwfzJ0zcJMI8gKtcVbqlRurQQKwv78lJbapF9gLVsZ3Vtba4knjGGsW2o?=
 =?us-ascii?Q?eiFYPNYaghthS4DznyNtcOsGimPU1RIRUah7mPtDyZIOc/74BGGwUBp7o5oV?=
 =?us-ascii?Q?2ftwUz4iXDuPkEiiBVf10x2JUmRNhaJoO4/cKM1LOaSDhQJa7mei1t3fNq9S?=
 =?us-ascii?Q?+7k6LdncXMiFvqnfp5DEx7HzzdMqeXLDdyQ02548SHKNJtD+eL/IuR0KFUDe?=
 =?us-ascii?Q?Z2CVRIweX5/OOg4JiggUgHYmhm5gg2ssPFji1c9HNMrD/YFA7Mj8Lzc+FVJR?=
 =?us-ascii?Q?hrR3yDRCiGSDBTkH9/DijwSNf961Ez1MBn3hlr0fsPTzVeVX9Kr7C3HVGcTM?=
 =?us-ascii?Q?ANnkEdfNdEeZTehBKBrOOU4555YH4yBvl59/JAGNUxAaArJY5LuHct7nynkA?=
 =?us-ascii?Q?p6WQANpjvJR7yePLaL4UA61/EOrSMKio2n4s9tCX537v7PBiaOTKwV/KfAnC?=
 =?us-ascii?Q?ZywmDNEMktaZ/23bbhwNthTUUwoX4iBf2YXZLdKtlzr9R9Oo8IDkuBfS2z3k?=
 =?us-ascii?Q?k34vGEiaiaRzo8PJBKijOyLz3LLz4gENQLz7Oi8aMEULlgDw5K1dOVkrz35U?=
 =?us-ascii?Q?UYC+11jP13o0KT9aYSnGc5DZiCAJVYqOzDZtfanqgsaAAJIxpWdKYLZwNlf9?=
 =?us-ascii?Q?xb4zXPef9Bq2AzaJu8uzllTKw2erTfOXnD/WOaTI1E9YiuaTV1TIncfvutJl?=
 =?us-ascii?Q?5t/Ve3vdcrBN5sDVb59KbA7ntuFv0TaAAVY/Z18PrfELrqgwwe0hIykpdjwu?=
 =?us-ascii?Q?Y0Ig8CcS6XJbXtnn2NSXsqn6Y2/NqN5QC0n8OIT0l2ElOdNBoHWZPHCQqk/k?=
 =?us-ascii?Q?5TEHF7+jkmRtm2bsESEL5+iQ8mrXwNzAoHG06Jtr34y3Cm6fR9wRMTRR2DeN?=
 =?us-ascii?Q?UIkr00nUAKBKurAvcctC3/d5UmqHVNP5c0Xo9K2Ta0hPzINmuwPfe1cZLM7Y?=
 =?us-ascii?Q?JG7mMJPRskwKcCc+xjT4VrXZoEqjfhAlTNoTDdu7spg4JRzguhcDcYoB7Ffa?=
 =?us-ascii?Q?/JAEn34HfvyHP6E0g+r4OG1Sn2DKBlQz/IxF3uZBSvfW6F32lR7S7XFSxmnv?=
 =?us-ascii?Q?cgJkDsdjNO6F4IAM6dpBVWTHsN71iZKhpW3Jo4rrH0CjwF+8l/QFsivLpbN5?=
 =?us-ascii?Q?EsqAZ22QoGpl7j6GZiIMRVU2733XBzTpNNkOTDpcgR3701LGZGlnXBp9niVs?=
 =?us-ascii?Q?fOlTUCJOQvduk0WUc0EN8e062Lbp4R6JP2hpS5L/qnqOnn7i2gFjTZXwjrtA?=
 =?us-ascii?Q?ECttD/zyFy6AQKFV0k3oDnmcbSKs4T/4HQjx0KF1cW55rAjHNtYxqcRakv/0?=
 =?us-ascii?Q?GrF/avx7xKaqQ2ysnCBnKFo72+pKU1awxDWN9rqKCkrxbsj62q12288YEiZZ?=
 =?us-ascii?Q?MxZQi1WD+/otEDRbcXtgi3SJ/c8XPcpxn0neMZPoG7J5wyLi0IJPiH+TCr2h?=
 =?us-ascii?Q?O+FCBeeKbaTnHCPkIaLDM1ipycSl7PZE8KlzjnOBxw2QUiSsIYBrBEuozYNl?=
 =?us-ascii?Q?vsJHmgTIx0u/zady0mS3rnbKKfUtLXuQJ0I7YdqK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6853e0ba-e7c2-46d2-80d5-08dabe9a6696
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 19:25:58.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZqmMi4C3eizYvWn1WaeqvwiEFC4Y5ds6ulwTvGUGCeb3gQ7eULrN9CNUg7QqpNVy7BrTg8gcZVG4MTOCSq+wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add adc0 flexspi lpspi and adc to 8dxl evk board dts

Frank Li (3):
  arm64: dts: imx8dxl: add adc0 and adc1 support
  arm64: dts: imx8dxl: add flexspi support
  arm64: dts: imx8dxl: add lpspi support

 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 164 ++++++++++++++++++
 .../boot/dts/freescale/imx8-ss-lsio.dtsi      |  17 +-
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  63 +++++++
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   |   4 +
 .../boot/dts/freescale/imx8dxl-ss-lsio.dtsi   |   5 +
 5 files changed, 252 insertions(+), 1 deletion(-)

-- 
2.34.1

