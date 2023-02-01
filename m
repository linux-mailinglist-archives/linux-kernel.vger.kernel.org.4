Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C11686C75
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjBARK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBARKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:10:53 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2108.outbound.protection.outlook.com [40.107.20.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBCD359B;
        Wed,  1 Feb 2023 09:10:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTex56OCEZua8ZRjGutLAK+HRz2oYp38phxaYj3t9dUkVP76DyM2VSuEkFEXDfMTLlcCKmQ+GziFK3L6uEc92OLRFI6jk7mw/VtnLrFf6cT1JvYc55oDwqbHJF2oCNQW5tHMhKGGY8997ctcWGYcrZ4F5y6JDaT3PV864rFWQN9gVNQjhOoyJFGiOHTWbimW2XtvxSHrxX2JGuqeJC00PQmLvYDl6OV/CvquZJ8IlqBFQ7vg4s9ax9vahW8J86Opy4VoQOFXXozdAwX6gR47lGGKsptJdiICgiopvmZfYG5IkscbYRbDGDZTnpLMoyexLOQM9U4V53XhZXvXQScLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RNrd8L4F83Tadnb/Q2zTf0zmJoI21F27ETdPoSvrn4=;
 b=TReLRS2UWXB4xHazQxEEVAjGX8y7Yz1RkU8HOU+jDgk0drq7p4vqWhblKwGpsBPRn9alQUczlOncMDuK52DWJ5WHhetJLr3imQ7xKK+thHVJMQrz5x0FCW0EedVAhgdKeh5OY4+0p95/vKmSO+XKgOszMqnhSlOewqKcct7ZA+1//GG+j+aw07TQrB5/Tg4h/QLd1SnYsLOQwm6E1TzzTbCjelP4LKTQlaWJbej5zKXNUBT9As4eVJkcAnwTzoY/YQ5FjFwTsK9oOxs386o5iCEG2AyZLdd/1+NAHknKxWelqtM/d3OVHk5j27iU8Xmir+AhicTh6kQhr0SSYuK+og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RNrd8L4F83Tadnb/Q2zTf0zmJoI21F27ETdPoSvrn4=;
 b=CDsJ9RWJaILoob7UK9vegTkpzg7CcENZ3eWh5ZvOZA5OqE8gsb+w0btOXcevetgZZCHptnFQ3YQNnctL3uG1SNgTgOVZ6gHD1CN1U6ZQWSpKqezT2wtZKfYprtS0cy53ZbomHZpSuSC86YDbUyFXXxJcnV7cuW2C2tlTH9n8YdRK31+slftda2FTRKbKpx+78fBRM7qvosV038LfQAbC5o3deQwJ+lvYgu5mQPp9+7IYf2xA2jvabuOA/0fnEIB7vywV6Bxb4mHetoxIdTaoq09CzP6MbZTS+c5LjWvq8VT3VdyfQrmqCIOLXGFsxmw7vNIUPVantQatzWQKLOq+OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from PAXPR03MB7617.eurprd03.prod.outlook.com (2603:10a6:102:1d8::15)
 by GVXPR03MB8380.eurprd03.prod.outlook.com (2603:10a6:150:6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 17:10:48 +0000
Received: from PAXPR03MB7617.eurprd03.prod.outlook.com
 ([fe80::e071:305e:9102:6d89]) by PAXPR03MB7617.eurprd03.prod.outlook.com
 ([fe80::e071:305e:9102:6d89%8]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 17:10:46 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Manuel Traut <manuel.traut@mt.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: input: pwm-beeper: add volume
Date:   Wed,  1 Feb 2023 18:10:25 +0100
Message-Id: <20230201171025.965276-1-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <d4c1da7b-5b49-6bbf-4470-b3f2eef7f745@linaro.org>
References: <d4c1da7b-5b49-6bbf-4470-b3f2eef7f745@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To PAXPR03MB7617.eurprd03.prod.outlook.com
 (2603:10a6:102:1d8::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR03MB7617:EE_|GVXPR03MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: 485be0dc-a0c2-4048-002b-08db04773c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8oUgHuFjakiwKVOyL8iftLp1mdYQtWr/bA1Lk9yQlUu71G/d/zVrdumikTlpA/TqrSEx87Bbwky+is7Vd7EUlbejIip/hRcHxXiHyrdgbIhFVTE5satr8la5qIzX+4Wizi0Wv9yYsZm/5TlN+qWZqmiF9nKILZWBdMBaO4At7fB4wUsuor6h42IOMIS+j7CWa+emZx3dqxoLlQrFUkiWgkWECkQd6xDTcNvHuyV28d8OpS5oWpfJBGC6YlkmT0s4RQaAOrhXlosRLV/cBcHJj0YiWvhtAdwrMzdYgYqUk2pXPZWLGZUYTRT13xtg2tdV5rucyP+05iE1+utZopR/3J471Rb4ttkQlSl9mYXOR5ZnaQxofa2N9frTex9hN9riAySeJzh+9FKFutZXQN7cNnvYIy8zJReiLVBHL344mJ40DUGRbInndCgic8FdCe7RJMeVjIdPnGiGMogEvTVGjhK2OJhSmoLK30/08nLfJv6t5/NozujtbEePwWlbYQfwk1SuIEC3ugkdj+gwDG2n7HZuVrpMPb4HyNnDp//EmdJ48mtb6G62rlXBx6WHHqvsE0a88NUsgHlW3UhGiqzIPeA2DuP8ByEPdKjbVlNaglnAhn+ITJjQPmBw6oq4GaUw+M6I/OHfvQn+4Hj4djHNA1IbDab/o9ZghX+8pzXXQq3iwZTvf4p1P7MEYSmfIyWVxw3iXXo4+G8gulL/zSZfyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR03MB7617.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199018)(36756003)(6486002)(2906002)(52116002)(54906003)(40140700001)(6666004)(86362001)(478600001)(38100700002)(38350700002)(2616005)(6506007)(1076003)(8676002)(6916009)(316002)(4326008)(5660300002)(8936002)(44832011)(41300700001)(66946007)(6512007)(26005)(66556008)(186003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xtZD18KGbQzGTIVi33e0H8merAugOwrmUZRERdq2ZRS52drnqbhO7zdMGFNf?=
 =?us-ascii?Q?10EoZeXMRni/ap+DW8a9SMueb6fxqxOr5hfpRzxRXLnh74NPfpM7Di0zC0Wn?=
 =?us-ascii?Q?2Fj/HajilVj6hiEQU4RgN1Fd3q1iBGCqJjA+OpkJemZe3sOkM/m82SRRZKzh?=
 =?us-ascii?Q?c9hC4kYtA/YvgyyisGS3rLOzTt5/evACJ8AZ/0PStYXNn2XcFBKLsCVWSeNv?=
 =?us-ascii?Q?rpBJGajQSoLvh7BxotkI+GxteeJokE94cLUSotOvs8ZUJMrg70HNFFb8gXMO?=
 =?us-ascii?Q?xU/TwkIHk+goroz/lOLE1aaGwFU4HgnLTufI+pfAOAx6m3htW/hB/yDiaWTR?=
 =?us-ascii?Q?DbvJU3gwkIgGexLeuzvbscS8gQUr5RLzvAYMKcAUSOLjn9IcHsknqMZ6T2tf?=
 =?us-ascii?Q?SFzGZyQ5TpxC2DWjA7KnY0BFT902K4TmRyWzDA9K1QE7O1qrTcWnovD7qNNw?=
 =?us-ascii?Q?dI32R8Ir0GV60TseQ1EMbynJccNzJTDOKwmziqe8s4peRa90ccNmANtAWqT7?=
 =?us-ascii?Q?JeMm9PpX1f9KxSS73q4AH563XIB5AvGZrb/h6sImd60Ab5OJUl85hj/yq1uG?=
 =?us-ascii?Q?ecg4Hmv4+EX88lpG/FbG8F4AP371Sy59tiki9D56M9rgqFqLdJTuXJx+nwum?=
 =?us-ascii?Q?SQILM8x+Phxy6PxJNnPKBU7HYXlzlDNiyGXrJxkFYVlokv9DY/9P/MypPwwo?=
 =?us-ascii?Q?Jy7ANqfAMxBzebqb17DXnFQ5jEtM5/LJBEo0zYVrV5G0CkWPrm2YyXoJD5rC?=
 =?us-ascii?Q?CwhhdG54pF+46guGJD51kSxKZBHhRIzOfuh3UUfAauV3NM4u8m5DxvpKUxUs?=
 =?us-ascii?Q?/1BD3x8Df8rrMkqtE12QOw7Hxy75DrQeuT4AGbO7lhiYxxth87GoAVrysBF8?=
 =?us-ascii?Q?cAfqlqF6cxPkY+pHRPIKZA3Br/DRw5pwLo+SculTgJKCfcRJkFVUwp+YERJZ?=
 =?us-ascii?Q?GMlvd4iGaggdsAt8veov0186E3h6tIR9YRQRqmDVmgHbYpLgvljKr1uJoq6s?=
 =?us-ascii?Q?lrt/vPw6J21Nz4azY8hc4lq4nu7lDAaV+v9khTBRBfU6tdmco4LL3vJace2y?=
 =?us-ascii?Q?NWE7oHM/+s5NLMm+nfwofTcHa5WAZFfiO4Fa/EyMFA2qhV/YhbcZwpnb+i4w?=
 =?us-ascii?Q?6argcy7zP54kah8tbXqFWYN95nv/x+AnVFCM8kuos4xFIaE31D+V/juxohI5?=
 =?us-ascii?Q?BQdQSouQr5HQyZ+idGP00DvqHALwlWxfwOU9QyDVj4E1x4ii5q/I9eSCqpnU?=
 =?us-ascii?Q?T8W9wUasRXsrTVoeFK1ZfSACNtkrDeB+gIVsk5pxvwGe8MdWXAqhoTiUb6Iy?=
 =?us-ascii?Q?P6Crhu3NNcpX1V3YUFIPvWwAJ7bCjs4MrZFOp98xNniRfJxMjsLHkZ/Lu8NI?=
 =?us-ascii?Q?xpAE+srFwMJ+/OxieGJ+qigT4VBufDMG2z/PyywUkzGaQv2ZkcnUl84Q7R88?=
 =?us-ascii?Q?lLOeIN+4YyriJUwASOYr+XVYmTlobxssWMFL7+u0WuExDXg9RoBC6COe5Hrq?=
 =?us-ascii?Q?K93TVBGWM1pHg6mBVevl2yzI4Yxcf2V9d6bJdIIT+1zqM2citL3OOE8q1HIj?=
 =?us-ascii?Q?ttzzsqoRK2S79mf8Gp5T/Tji7nffzyMBYVbQWbPL?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485be0dc-a0c2-4048-002b-08db04773c19
X-MS-Exchange-CrossTenant-AuthSource: PAXPR03MB7617.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 17:10:46.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sw3v3kDizIzgbMWrqtDWBpsJ+mMexdz+zZBVQknpAeskpxKHmBIyhJChKHZxbJNJreIezf7IqNS8ApWmxt9aeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB8380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an array of supported volume levels and a default volume level.

Signed-off-by: Manuel Traut <manuel.traut@mt.com>
---
 .../devicetree/bindings/input/pwm-beeper.yaml      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
index 1ebc3a46d934..7ea2954cdd6a 100644
--- a/Documentation/devicetree/bindings/input/pwm-beeper.yaml
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
@@ -25,6 +25,18 @@ properties:
   beeper-hz:
     description: bell frequency in Hz
 
+  volume-levels-bp:
+    description: >
+      Please note that the actual volume of most beepers is
+      highly non-linear, which means that low volume levels
+      are probably somewhere in the range of 10 to 300 (0.1-3%
+      duty cycle).
+    maximum: 5000
+
+  default-volume-level-bp:
+    description: >
+      The default volume level.
+
 required:
   - compatible
   - pwms
@@ -36,4 +48,6 @@ examples:
     beeper {
       compatible = "pwm-beeper";
       pwms = <&pwm0>;
+      volume-levels-bp = <0 80 200 400 5000>;
+      default-volume-level-bp = <80>;
     };
-- 
2.39.1

