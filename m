Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1AC6A650F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCABx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCABxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:53:23 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47922121;
        Tue, 28 Feb 2023 17:52:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAarK76t/b7LVPjmuf5cV3cjikYDpcYwLYotK4LF6mrUexfwd4od1It+v1CzzO/SqVy4st2oolJjVk/D3UiCzgBL91fwkWlnzPzahZ1jNWHis0UeRN6hDvQfWtiuEC4Fj6TlhxbDwj+cj9s8fJ304EsDtCX+LLlObIFcru5mRQpI5yf3LGs3n2qgTXPpue39WiriwpDSRYwSjNuOcMxR238y6dtFN1/ZlsDyMLSWy0QwZUMin/Shb2NJIdnFbNMUjbvJNq2RneNyMnOl8NeNOjApoYrMY47Da8ahbYVFVmaFmwzIJJHby9uYJGuh7bNi7MCeRZupCcAhfH4F0Qsm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50QxryHxYb5DZWCvOkEATYMgMuFE3pGMHg1w+LgaAU4=;
 b=LQN6Al+Wnxg7I/0b/tneP5n2e7jiK+5YzHSIjuXGXbz9p65uqcZNQKFCfpIsE4P/QTjfv7F7YOZ8xXTOGet+LB6N3/qB2cC0FxThijBgYKrXLgzmgPex8BwuZWiB9piyBxxOvlJla3AEM/05j+S3UZUmGZpWu1ZzcsWhgepfDfMqYvFX77IQCKtsDyhEa1PxiHODcjERgc8F+HBDSiH9O0Dt5TTuxzQFKVbLpDmZHJ5tW+n4dITS8idn+P0oO5V8WVvS2lhePTixH6fm3DWaCsZy4QE8FYoYU6HcTv3fsCvauStI5aLtKSGQYXXAMioT2TkPvkOt6XNSQ3+SLDOJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50QxryHxYb5DZWCvOkEATYMgMuFE3pGMHg1w+LgaAU4=;
 b=drWp3fQm0czA0P7uvr5x0PFi+a37FmSF3hArb1JSrYt5m+7jwbQhyO6XMqrgiezkAEES7Ay5TBEysUUbHvo77+6GBljDifJzUZrtuUYr/89w4Nu/O02YRgEp4Cna37QTBy46YQDE4dTFT+307ik4C0mK57OFEHIuG3ulocgezUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7546.eurprd04.prod.outlook.com (2603:10a6:10:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 01:52:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 01:52:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/9] dt-bindings: crypto: fsl-sec4-snvs: add simple-mfd compatible
Date:   Wed,  1 Mar 2023 09:56:58 +0800
Message-Id: <20230301015702.3388458-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbe2e6f-265f-4ae9-fcd7-08db19f798a9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1jUSI1qIYzkz+9Hf6h0eldZTntvHs9rIO614WDjITim7gpTtWm3XTVqc/3FUEWxyrnGMO3cXePwOsK/SpvZFowrzizQ8ofOWoSOrA0I244g4UGr8HpWxjXg8TtltrMlFIylHQEqs7dtkwPu0ef1ByrVWbVBF8wt5CG83zbnsFjblrZLyQmV3OR1BRNWAHc56kTtJ64ABrjrG8ffDOKomWdi92mBwgSb5aCv1W9VEYi030AJV1LxMVIvxkkskANxzKydKqfC5ohrGkeGo2b/C5UCXRyLV47/2T3BEFGinCbehef9RtHUxspZcJCPtxArXvzkC/gwueCtMJMAZVDrvCHiufUnN2W+cdUhtNuuLM75IW0MBADc4nlCdu9r0+IkazB21i7eu2ksH91zltE1WY4v977OINGoAEceIS1SIUIAY6d1SRnOST8x4cdI9cm6DH+fa0Z47LwOgrc2hVhZC2yPuWMVQu+ZYQH6sWTt08hEE0gJxeEtvVjyFECkaV/oP46DWGITgGEXuiA0dgxMcCTi7ZX9e1lMLd0ZcW3jEmuucP2Ck2Lga+uSKrtBwAuXEBVTHmagH6Il4jVtZpMXQGZsxgBVQO11jN1gpxt6cvY1nm74qseckXCtJLFpgKbN/OJQgWZEvtBCP8t4J35iVu3V++5RLruDPfRdIqNmSh5P3kM9rBGRdHeuAdpGYXLo/KD71nEMqHZDIMEs+5U4lFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(316002)(6666004)(2906002)(6486002)(6506007)(478600001)(1076003)(2616005)(52116002)(26005)(186003)(6512007)(86362001)(8936002)(7416002)(41300700001)(66556008)(5660300002)(4744005)(66946007)(66476007)(8676002)(38100700002)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oM5BLNtdWXpbDQWV+1xlQRdO1NGJ6200w5IxBeZFwgN64apeBzGiJAOv8EbS?=
 =?us-ascii?Q?YRGWGDXd+lYYXooRt+E7L+pivuFwPlIWZcYgOEVV9Kmm6USuk7fQWbRC+pJc?=
 =?us-ascii?Q?vb2uhTzmelL5tfLh7iD+nvZT5BmTXADqjnIN9IXeILhCt+7C1iJ+EmknoVgG?=
 =?us-ascii?Q?bj2nA8UkRlc2QfQGFJvmXA9ykxBDjm8dTjFNvaKMk5nkMerHvjFAByTgkQge?=
 =?us-ascii?Q?OUt+ZuLS97eR2B6wCA9ex024aegctDoONSQpbH6CrRxF+6GnKZscCQW7nZ24?=
 =?us-ascii?Q?D8ogydYDAViEztDdiPRdOOY3wvmQOpqZtpIYY2SkXl4bAR5nz/83Vv6dI4S+?=
 =?us-ascii?Q?Gd2FKEf1Ua5EdhOgkzn7lnzmEkRVHFDjOma0v8GvOXmu3K5rA3H4juVLxU0l?=
 =?us-ascii?Q?VnCsD9oJVafcZuiCBgldiYOtR7U+PXPg6Py2WIh2ZWG0BdFN0+bW4k8O4J9/?=
 =?us-ascii?Q?zDZbs2OUPl+cJiQejUepRRpTTGmzjFHizQyyy4QgHQFh44bj/bT5W0HIKjSd?=
 =?us-ascii?Q?jxfejdm0DmqfJSnw9mjoPYHP9sD861y3PajTcT2CiZOiQcRURCJw3Zjbr+Bf?=
 =?us-ascii?Q?OVO+xBHqQyxL+XTyDvvVzVOPLR/OBNz7TxlzC7VwpAPh/6vLMGb5c44g134s?=
 =?us-ascii?Q?6qhMrj2X9c2uPUgB8fD9JVzAf1+IEZzvTzmGNjk2FfFf7cYfCcIUcY9Ua8xq?=
 =?us-ascii?Q?NRydvOWCByq3buUCDCncLOe6b2+WvllIybfGi+RLWhzx04XZCBf2J+nnxTDZ?=
 =?us-ascii?Q?JI8Zzjjnekc3TgixZFxxm8JYpaKAEW5wl26NeA+vzMUtfB8539oZn6M6QY3o?=
 =?us-ascii?Q?nPIExhs0glhFgyKqV4mMMTcfLz1kz8Ba7hJCC/FTZI3HN7MC68Z0X7rjdEvc?=
 =?us-ascii?Q?T6vUZnH2LFtEzkKOQJ34oIETEIirQa08mL2N9uV1oTpNaKSIzYRY8BSQK9pH?=
 =?us-ascii?Q?RA+fJPac3xSsuFKO2HCXMrJJN3DH7nmzU01YxisRuGcxxYFR0F0pJGMo1HvQ?=
 =?us-ascii?Q?FfeZR7eoWgIz3VYkSkn9WagYtRkDB/sf5OL7U6NOLFbSeNvMBHDQDUw5b3dR?=
 =?us-ascii?Q?CD7Brdciq/OW2yUNqRoGgzVSqbwDHPK3o/jZPUkoGpNOi9ByQv0w9/DD4z9j?=
 =?us-ascii?Q?y6xY9Ve7JMtmLFHEGyUrnV/11TaLEXByvotQrCfKfnJSgGZl/ehAf0YPpCuU?=
 =?us-ascii?Q?M9gS+vxImu9z++PApYW5+kqf6ffticxME1YjpGdXXBlEmjp3Hi93h5T0WFHe?=
 =?us-ascii?Q?unegrpqTSjuO+9cLvFUf6IsmDJUN9HEuNxzZA8qHJqcchB6MPKJxIO9WWyDz?=
 =?us-ascii?Q?c54vsJhW9QKqMq2z8zYEy6Mbe73KheK/wLl65KQV03mwGZjIVz/z6Mi4OZs/?=
 =?us-ascii?Q?sCxG2Mwn/po1Y4GJ1OemLzvJizswrHPQk/UJ+6N/sk4q+g1Y9UIsE7X7kOoV?=
 =?us-ascii?Q?Xqrw9aVQo/dV4vslLFsO+A0DixsSsgTRotKz/uRW5EomIpd0bCz3MCNCczgj?=
 =?us-ascii?Q?HeoVJfz/kp3a/tQpYlDCO7jZircavIfOF2ff6822oVH40xmSyqyL9CS1V23L?=
 =?us-ascii?Q?qrEEv6lEWF9+3e6D4QLy7HMeEUc6yQC1HhhDgcWw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbe2e6f-265f-4ae9-fcd7-08db19f798a9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 01:52:21.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPUT4IF1kyZwL8lIbsAtdlo7hUMZ8JCDQJlcBpjMEnkFLDgaC9gf3HGikiToSFfrxroDcKoEhWnPoWxEaspvUg==
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

All the current vfxxx and i.MX device tree has simple-mfd as compatible,
and it indeed supports RTC and ON/OFF key multi function, so add the
compatible.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
index 633e70f9b303..6878ae8127ec 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
@@ -27,6 +27,7 @@ properties:
       - items:
           - const: fsl,sec-v4.0-mon
           - const: syscon
+          - const: simple-mfd
 
   reg:
     maxItems: 1
-- 
2.37.1

