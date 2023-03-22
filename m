Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039236C420D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCVFUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjCVFUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:20:31 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C67D4D630;
        Tue, 21 Mar 2023 22:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiLwhxLg1ylIuGO2QFPfUnlO8SYKAxnNZMStmszLBM0y4vsMhDe4xB9f1nfC7RmdU+NcFTj0XxUiFXvDnKMm4aC97ffrAolLHY8N4WrjFhi79/5KnvvX+6agZo/jkUteQuRZfohTkKkpkCIzqr0mZn79KqvHEZjZ4cafT5KlI175zYCtKj70GieS6kIQcpg/sT/U9HrRrF0HVsOocbFhMpUFArWRChwMqbRk4usRJhZB+F83Qj3uq/6QrYnonYE4lXR58EqnLoBSPKhOfs0Z/fkDl1h5/wa037gq3qUMM/vMAk823DEBWQwJCykC5+bhckbcc1ZGbvzAC4W6yH+tXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Fy2pN1g1M1oJNPstkmDXn6kyCILSwdUxugTz3Lonpk=;
 b=ZU6JiyXzCxnRpUh9QfGGOJVZEHi+Fqo9T/qy3vBrq+eDxiEOHaDS8EytlnaS2YIQQQjjxw6lfrS73ln+IXfzJZGOayFbCee1TvuiL3Ph6qlpCjN+gZcSlPc9EWuAns6e2MzQh0SWVi3kqaAsHc1N7RMaqW7XfxEvixg+5/87Sgkzd2OOgYt338knxqhvgrfAbsI7H5QahOTLn3z3Rsor/CemJVRhqAeMbIfiZu1hUmOiVKNnmp9NYPllOdUPuwVVllPDz5244mpQpW7l5X4FKkCP+1xh0g+dhSMo3Xs3L1alr1TazIgT89gPJI65QL2qLQnhXDllV0qPJx265lxdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Fy2pN1g1M1oJNPstkmDXn6kyCILSwdUxugTz3Lonpk=;
 b=Ntha1A1xAriJ3g8cctMr7LGxeaLnHBo8Z8kXi4Q/vECuoIwUELdyafUdLaudFdlVzniEmqbiRJUyFDzwurYGa8Nbv3FErJM2OxBUDpos8zSKCNUgYxcnJlNX0zHyYW/wV3TAvawttH4YrTcnWQA8UOU5R0GSTRKOOaqeLqGBSvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8301.eurprd04.prod.outlook.com (2603:10a6:102:1c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:20:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:20:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V7 03/10] dt-bindings: usb: usb-nop-xceiv: add power-domains property
Date:   Wed, 22 Mar 2023 13:24:57 +0800
Message-Id: <20230322052504.2629429-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
References: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 18455a8f-1709-4e5d-33c3-08db2a951e00
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQUhcH4FKNfryOiM8X1Pbwp67Q14WnJuNQz90j71gzwH1BZ/1+glhIrKj/h8EmcAg/d9pY42j2Gy0IGcd2pMpQK+DEhx3zZiZJk8kYf7TAiLphRYogJ747DivDd37EqUchShj7GYqNYb+mlEd7kUhgQ46PRTsOGREkwaDn9QhgouRNpFWIcwmSSMSbvMIIfrwuFknVZYQ/mHVTYTuo8kWZU5wuBbWCcl52OAMeQfmIV28eXM+0uZz1NdrXFS4ikwveb611wpNtOncTuvVBVLnRZThYP2JpHExyIcUSL7ZUEsiBxsHqZAWWSHufbN1yCLK5jnA0b0p3+KVPMrt/DESv9bIN5SvZTpIIZZeGMwFF7VkCxj9MSd0pmac/DxLZfpef5tPmwog4wywpkjSo0shvckbWBeZ+OppbQKnA2xl7JsCVnpy3L0Sfn2+PNUm/eODbXk5NQGMCbVKDkEApvY+4LgMrfFZibaEINjDut5RlqDkxCyDkZoa6Lvgi+XUrj0rYm6DCxNwzcE+g8SLpk/IpVPumvUPwYDEmKBvpEXO2K3tX/785Cmem46fdNTFDeVXHAYrWxTDUR4bSCYqXIt4hK4WMVHKlnxAqDgA/pikN8jhdhOhdZDviJ80pA/z71CIIGiEy6TibFuzFt7tWpW16sSnwA2Z0EEpLUebzMBDCBWkuEVMWdDXLrEQ+osri1JnBP4iPo9f0SQHEh2eqxENA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199018)(7416002)(8936002)(4744005)(41300700001)(5660300002)(4326008)(86362001)(38100700002)(38350700002)(2906002)(66476007)(6486002)(6666004)(52116002)(2616005)(478600001)(6506007)(26005)(6512007)(186003)(316002)(1076003)(66946007)(54906003)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wpuy0EJDFTdkCc6J8J+xeGkHFRFNNqjLgkKzuHmJoN4MiluRIEnS/e+A3FVe?=
 =?us-ascii?Q?rwTSW0E47yaw8Ac25Ytfl3HbHcWKeQbQUhKXEsu+IVGmJy55qbpOXe/zVyEY?=
 =?us-ascii?Q?AX6UNUu6sdObUh8WTnpj8zNylWU8v2xO/EGvnSjrZne3vHLBrW+hdGscjkqA?=
 =?us-ascii?Q?rN+nV23MCVEU8vFL70oQ+nr5YVMQaG8+Bk4cC8vG13dd3N8kJ76kTgK6SsAE?=
 =?us-ascii?Q?F+GOsuQrF4Vo/+fo6t9ONiWO7HY+AMMna5CAm8O1aVDsdZGFhGaxl8R+rwek?=
 =?us-ascii?Q?UBiyeglWbXpcx3cVPK4SO9ZBAQ2rx3p136P49/4yAAB6P9BoAoWNC4rMJMo2?=
 =?us-ascii?Q?iaZzeUkCyaBVJx/pxwi40iLVEwBKQKBf7KBkvih0sc4lQZLshllGxNqCEDX9?=
 =?us-ascii?Q?sQlz60BHSJ6+HtvRC5r4Ztx4vDQm4llBwuEoMlePffiFsU8aSkofP94TopPv?=
 =?us-ascii?Q?cRrTscPmw5bZ/4WmKSlQjApzFHUYVKKdsmNrQCajBaYKG2W3Rx0biPKAv4Oh?=
 =?us-ascii?Q?P4CwBb/RcPhjjQV/8JFLoj1FfE2rfaxj/5MeN3JcOQJjUmHXfajO+V/UgBIB?=
 =?us-ascii?Q?+bm6GsWNWnTGorBm1wRmfppqgk9aCL5oSGer8UTILcU1aNo2sSrYVLRJO37+?=
 =?us-ascii?Q?UB6Rx6ggjw1YY1Y4tSE4qAU2S3I9e/o9+4/TJOSssjAYyRxKfaMONYMJ6WZ0?=
 =?us-ascii?Q?slG2Nm4cNKY+TSN12zb481XgJJK3Ko9+5UDfXwZy8JcKrq3yqtR18lHLjAAz?=
 =?us-ascii?Q?mMrgp07uaPxH33T/XO7Y9f+qxlqMHmjf95NU+QmOK2VTG4BkSfm81j2hLdFG?=
 =?us-ascii?Q?oxUy0HehP9qZyzbD8nEmArfY/nPUqwlKF6E6+ZXjPqmmjnfzOtok1y9ZqR6r?=
 =?us-ascii?Q?S35hn7YxSX5BLe+/FXrQkLQ7HitVgbnZzXwn523kJJ7s7L75uUw+fXudzLxU?=
 =?us-ascii?Q?joCz/y3e4gdV50pD7rDgZuvYdxrFBvZS9hxaP281I5U4i82dyxyfd2w/A+Ar?=
 =?us-ascii?Q?e/ptXK61nl6770A5MJclc4gzH3LoxfsIA5fPVEWZWvDtDa8lKgLeX/eyP2gJ?=
 =?us-ascii?Q?sWKjOQgoB5ZslnSrCs/x6lmctnYDtSvhTI86tsFLb/ttP+avNRv+i/JEJqJi?=
 =?us-ascii?Q?2dFpFSN2slQ2KKy4iGvjVrQUcRxG54vGcq2DwviuozvunFJyBMgnlRPflq1t?=
 =?us-ascii?Q?SPnW6JRucYyHCEoN1nM283o7rm7OeU1SLdvOEni8d27RBKcuNB5Xj8VJHMs3?=
 =?us-ascii?Q?aqYvqRM5A0mGMpCgs8UTcvq/uh1J/Ss4KGJhuuad3I66itJM9hnzxHgfDDc/?=
 =?us-ascii?Q?nwyoDmTlHZNuuW7dxHjVGgH68T/fplgN9DzE4ntiMv35mTnWgEjE+8sC88ai?=
 =?us-ascii?Q?5IYIhwxhGnmeqIQocRMuWNnQTsYfmFcxx8uIoLHmnPtgOaLOveqtTjCTtGtq?=
 =?us-ascii?Q?jQMNTrHROxT5RmNGvE3q/0NK+YgiFZrj/IpST+83EbdPU+hiEFFl/roGWkZZ?=
 =?us-ascii?Q?oXLz4Zum4KbGZP7/Cp63U3u8sj4iZl15PIt5ogpro8d0ijHSn+ANK+sjsfeE?=
 =?us-ascii?Q?NDYovMgZD6DxwAbXto4e5icRsEdb1QeCF6rhzjzV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18455a8f-1709-4e5d-33c3-08db2a951e00
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:20:14.8922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XJ2gXAx521i4F9n/Xn9bBNNGJu/U3ImMIU2Bm1IlMWg/V5R0qVwp1hdJRRMFz+/wCkDGoXLtzOCScr2oJn3ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8301
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add power-domains optional property

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
index 921b986adc47..6734f4d3aa78 100644
--- a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
@@ -27,6 +27,9 @@ properties:
   vcc-supply:
     description: phandle to the regulator that provides power to the PHY.
 
+  power-domains:
+    maxItems: 1
+
   reset-gpios:
     maxItems: 1
 
-- 
2.37.1

