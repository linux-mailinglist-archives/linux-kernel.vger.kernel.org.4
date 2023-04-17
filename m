Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946EF6E4339
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjDQJGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjDQJGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:06:42 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2012.outbound.protection.outlook.com [40.92.98.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67F1189;
        Mon, 17 Apr 2023 02:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kufLMrOSlA38xJt5KSvdo6+rHTTlkaqvEwSj7hwSInTJl1MTm6T3TSiKWAbN8Lp/8NLhHbBK2VBqAwdCWFOrIcN2H/163oej1eX9wMHh29CMv0YbRQsAewScerB9PoZxXy5gqx0Iv1bIyaLHKlWZYMg5SgdIVF2nDOfbDD2BJbUdif8im5we91pi5X8Nn0pU50rqcvRTI0OtJn3GW1FCbNp9M9bAuJg4ogiee3Zdd/kM9z4RMstFfxBxbFx+m/Kxamzh5hMCR3Sz6krFhx0qjHjLFsqDiwYUe6SgojkI/4R2n9hgtH6DF9lG98pHhAyMZrEerC16kCfQfm9MPqMBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq5IH0L6O6t7Fzc7Rj93GzGGyFMUXDqWQqt4QLEeTpo=;
 b=JnOYbs3c+DIMDl5ej0E2BPaWSUmdJUVDYYiRMH9AFrZ1LWbMoVGhXrG/vIfzsg7LlPw8VItlsfOlfW0RKWArzUcFLvqXZfB58n7xK9eeM1J+d/oOcDDnUotsYdGCy0+yPZdpEv9CS5J87bwzMOjz2+4VJjIOyuxdIiljT9uc5IxcQJknu5tVsi5S8gE67Rav5RDX+Cx9Hx5x/poraIh4O3njfKFM/RAqjeJcF4gO8PeiqL+Z4uGbxdzoQEpsU5AAHBm19o7Tw1DDFh9wJPNIhEvru0GaNY9a4F/LRpc37dYaSUTzlpU1w6xGXZhXkcY+tHXO9E7pvqJW4Yhb7mpW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq5IH0L6O6t7Fzc7Rj93GzGGyFMUXDqWQqt4QLEeTpo=;
 b=fTnmfdFqb2NK5Ts8pP+qPzWWfdP5zAfx4NpgR4TUCc/fwCe5ivYGeoMPXggbSsjMSxxaHePpZG5GBrBTs6sqY1ZOD8wHKgq3Gd3XgBDQupL2C9z2J7g0FJuk8zkdnBiIm+Rmm1YvS6ZFA6DmfRSl+OPpCDWNJq0VZ+WdhULwRqUJBfhL7+1vXdw+tZowQP0DnQBwLdpZtcfi96h3TzG0xkvaaua+xWQusjgWW9TEuTeu8fAqxH0x1MkILZCDNHPzIaq769239QeMHZHKpDLXiFITnV5tq+3qXJ57yd5GSekOpLP2IpdayBJXi9w5MstZ8cwfR5eI80X2VnDSAA2GCQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OSZP286MB1558.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 09:06:38 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 09:06:38 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v2 1/4] dt-bindings: mfd: x-powers,axp152: Document the AXP15060 variant
Date:   Mon, 17 Apr 2023 17:05:35 +0800
Message-ID: <TY3P286MB2611439E0FA49C224D639062989C9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417090537.6052-1-wiagn233@outlook.com>
References: <20230417090537.6052-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [4Zr5+VtCy4mR8S3SIHVQ7nNC/gr5wZYM]
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230417090537.6052-2-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB1558:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba33339-ef3e-42ee-be30-08db3f230d56
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmofvZvLhntBlNaxIR7rLBom+ZDotAUPTQyLAVM6CFQSeaSxJVdncxn//FhMS9wRjTJVKCDkMK7yGCZySgUFuKKQtLvunoPaOxZj1dYlEHZKHpcsXt1RJkGLOmsTOwAOYiIh6XwAWWGn3A6VuzSigANwlQfdwRbFmjVqmsuof3lv1pw3lOW0twNDGsd6QNnAvHFDOYe2RoRCmLQE+PkuvDOJ3mKr2YLmQJJd0wrrn74EDAwaOV+NMKBcarK3ynjDIjRjJ5pvrB74vZxu7hN0cKKjnlQARzzweT4TVtMmXvvA9mChtTNnffGG4Ew5oBJwkabgFl/D42Jmy3E8GZqmMpnrn1bmfxFvVGjMOyXeNNbSW0OmU3fZjP7HOR8uwUCG32bwFLXH0sjmay5c+ZbYsu9zfqfgAMRFBe6orpgcvSIl94aWSYbwDfTf0Fs1hXZzcBvi76qjRCv1/MQP73EvRVezEco37RjeJUflR4GsB+k04oq3bDPHfiZG0DyQ8bR+eha+8VlP2OBF7Ldwex2+2cI3je/q3k2U5ezdsrV30CYP0ecJQJ/8C0P+NdhhE+oLbjX9uzq43rtq5sSnzRZT3f1ths58bQ0dmymTQcJDBm8oxvWgB31gH2Dkowkvsll6bI7GRRduXoCh2ZhQcf5DL/R1zSDcRMg9J1VUdCficOz2kU7NoaSh+PgwwKXPdUDkdAx7Bz3oYQ0Qmr0wXqEzIec9Zll79QJ3xyHlvgmhy1nVjNEspfYmK9HZ9btEKS/M9oU=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ETnpRTKHzRLzHhaLj3eVztgxaUTPq5tS1FJhZYl/YrjpP6Sx+p/ou4Byc0/xCX7yTQABkyu0aTzhYd6VF/keR8nO7vCKD9i9RgxVWi/26vbYdRYdRx/ne8P7rCMfekIBvTamVAtRFcLGzNXnCe1EFXXCdkJy5GYBbX2XrtvfzMVgUcs1SLUhlHmnCfIb3xz13nVTrcN1JcW8m4XjG9sfpqW5k9/w6B1c3xd0rIPMe3BNGXESVH3ZjUSQvTIHVZ2j85XF4w6Wc0IMKhnUexSKUhxA0LHx2zxu1wYNLp1wGkIHYHmf0Pualc5bzTberuDWjQLrHgozSvD8epmY9ffeoXUuLT0aXPN2RVU3xSqbeyKxl1wET8oa2700u/mZLLxmieJ4qOEbId1FQmskwSH2ls/sC+xgFRvM27fU6qtAIpY9iogHLGwyxMZ+OXI9nIMMhP44FvMBNBek7xzmfo4ERE3xYGdA+H2aRSDBvCi6/sYSXVQX+5YueM0XRBPZ9Y7P2hqpeht96AA1S7uSXVkzlb5Rz6A8eR9FTV5+nzfpMNY4CUnIM4qH9Ud4Sxq4IfTgVq71C5T712h/Co1YsIS0MCAm5g63DwVzUhlNQLPiU/ZHImgmWOh/mPAkvs+PcnNm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y/l0s78U29MzxlISuYpovsfAzSzM+SrwmC1IWCk2uOpQprVoUKvR4qLktIyl?=
 =?us-ascii?Q?ZbzBhHmx3yjdTa5wEDMU1imB/SZPhD5qwVZ/LADCfNQXT1t52dMc7YbtB7dw?=
 =?us-ascii?Q?v5WEK9sk2QcyUsqxBv1ibes11otYBm9YUECUV6KrjXB0VA8dU3dEvza+W0KB?=
 =?us-ascii?Q?a1FYnYN3Jghc3QE7MKcPd6WWSgBVxdVlvfQF8bq4QY0l07MW+d4QN1SKgllS?=
 =?us-ascii?Q?2lg5xR5Vd1tWFQT6Oubs8gZaTHXkrLi//OTCPz7/XhZZHi9oKLsowDRHaJXd?=
 =?us-ascii?Q?AIaPAyOxahb8pRcH7KTfqxo/xKz+bbPi1smudaZEagnguu5AauXfIb5NLg/7?=
 =?us-ascii?Q?zTACVxKXQPBcZ59dq58Xbr18aZpyCJH/T0XxPAOAnNOl4NZHaqYJjgIEAAfC?=
 =?us-ascii?Q?2VdWtubAkrMdVOqTookN/NBFG61f3oZEOi0mRTyTY5Qm6PSDyu1zhRYNscGQ?=
 =?us-ascii?Q?lC/Jj/dhuxjfh2U/RRJHrY/LzZJArFJonrzvcE+Zv0f4Z3CcBQamWpmr2csT?=
 =?us-ascii?Q?rIP+mnFbOdXpW004DCLeuBEybrBeWKE/wEFsPg+vunfR8JjUwLvMjCKYNjI3?=
 =?us-ascii?Q?tJKFMZOzfct9dE04uplfqtDU1NC9LBh519WfvWcydMs5EC3N6iDN9r4rUH+O?=
 =?us-ascii?Q?Z70kDzZiaQKQpMhyYlaPaOVENPtTBAFCMhup6G/hqjQuUozxFUs8EpOgp/aC?=
 =?us-ascii?Q?9GJ+78gf7S/pExkhlpIklltdxuyN+PK4Vh9IAiVF/jcd152Kgx1ZYW5kNWzZ?=
 =?us-ascii?Q?qKa3TkPDgkraeac/34R7CB0i2gfIitxONPwFUUi3+fld0olkIKCRc5E3NleI?=
 =?us-ascii?Q?0jeDZJk/7/VGGsUx1mdfBadejnzfZqzooFnZNv32y8mi3/St0uQohJnkuDgd?=
 =?us-ascii?Q?org3tYCeDygHZfL4a4phH4OMfxBU52N6vepn5yh2RNHwImTa0vOSlWMJJ937?=
 =?us-ascii?Q?JgHOt/D9NwBwg/Anl//JMB0udUwHO0Q2d+JO+LToedAjliT5jSYnjWDNViSX?=
 =?us-ascii?Q?IXLPv7QcPnTthHkfODDfz/67JE+9rwE7t7r2PRwFOmcRRO9bVnWMOfr8Hnmc?=
 =?us-ascii?Q?BCNGXu/7CqyZNz/+za/DliNeYr6sY5wH+IWHvqlMEz9C65zYND1HpjgcAniQ?=
 =?us-ascii?Q?IiO1WuNXcybihAy5rJEURUR2V3AZcz+hsqDnvwpNx/kRG6KOdTWSIOyewkxX?=
 =?us-ascii?Q?T33r5y9vGL3NYz2wXE98eISQlAh+hEhTlka6Gg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba33339-ef3e-42ee-be30-08db3f230d56
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 09:06:38.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1558
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X-Powers AXP15060 is a PMIC seen on Starfive Visionfive 2 board. Add
relative compatible item and CPUSLDO support for it.

Changes since v1:
- Move cpusldo before drivevbus (Krzysztof Kozlowski)

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index 8eeb5b387430..33c1a7020fac 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -86,6 +86,7 @@ properties:
           - x-powers,axp806
           - x-powers,axp809
           - x-powers,axp813
+          - x-powers,axp15060
       - items:
           - const: x-powers,axp228
           - const: x-powers,axp221
@@ -254,7 +255,7 @@ properties:
           Defines the work frequency of DC-DC in kHz.
 
     patternProperties:
-      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|drivevbus|dc5ldo)$":
+      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|cpusldo|drivevbus|dc5ldo)$":
         $ref: /schemas/regulator/regulator.yaml#
         type: object
         unevaluatedProperties: false
-- 
2.25.1

