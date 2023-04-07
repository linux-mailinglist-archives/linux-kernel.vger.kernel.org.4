Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28A06DAEC1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbjDGOTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjDGOTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:19:09 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2055.outbound.protection.outlook.com [40.92.98.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B876E7;
        Fri,  7 Apr 2023 07:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tdsba/IP7wLFjnZt+9eP84Q9RZRxiOjmpT1PTmkQAOw9YFfGqXjhy5AAB+U/S3me5VyiHn/KpW7prvHvkxkcQlMZKsZRnRGmga8VUXcTmXPUE/75W3zJVuImzi6dPwvRbrRkItVpRwuKveBQ4PqUBdzuMCu8ikb1lBYauibOfkK494mWt4aQH3ui9OObMIbOhzOEPGRU7I1iM/Q9AALWWInKvnMgvIquSFrdXJIDSn1hqqLa/tepvxPpxUizvaqlIhf74lJ0qgz4lDCOHimAMXFcSELzuSFIfeqm6Yh/7MSODMN4NpwrxwuWBb57oYt8A92isu42WADgJyW0R/iF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQqG7RbxSW47jhVFKn/QZwZ9GUFuTehvAioXj/SsODk=;
 b=A/6WYTcBK0kufykviBBiiQ7yWcygqXwbGdKs24zmugG2eIiSiG3C2oZ4u1psWWRYNQ3GXiWIgfKcnxtzyGYJAHloeciOwu2bc887eFBvbejCgNT1iDyXLZCyd53akCVWLOAt8EmDAgjjGtxO32Esd6957QOooHGyCAhR3gIwF2bMBurEwezzTLY3u7BEJgxg6N+/IBAa4aUo6iAcMPsMAGNE56B6x8jwelmwTnnOdWvxOggnQ5UGkZKdxVAG5PsPnJ4tDhbfV//5Q4G3Z7C0bNFKp7uNLm+l4jNEj9yhMTXPslrFH1/ChetECqYb1bzfpH9dslKWJCbxmRnbQLfKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQqG7RbxSW47jhVFKn/QZwZ9GUFuTehvAioXj/SsODk=;
 b=TTYgw/eGAXrc0GLj6NkibX6LbmioY8yDrvvfcOEdh0mW5qTLKHYv5EfAy1Cn2zdSteQYupj1gscqZSZ9axgg/a2Agt7GupY0gJgjgnttf+OzpZ/j7SSLX+KpifWOW7g3AA5NOusnTf9OAdVOu/4STScpHvna2cdz8nTENgNz5zVvUI8VCg25LjzwihaYm0BgEYNDbHXpg3hGJSifBXSQ7XZC4bDjEQhHlZjND0jITyzZRRrttmj87yCBaDWySgRi4EZojStQhu0nXrJtju52rPNxNX1VYOAkelsmIKcHtcYARxgjIj6vHfgk72eKhjCCNpdkDhTckgcM/+TKTCx7Rg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYCP286MB2638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:242::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 14:18:52 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6277.033; Fri, 7 Apr 2023
 14:18:52 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 1/4] dt-bindings: mfd: x-powers,axp152: Document the AXP15060 variant
Date:   Fri,  7 Apr 2023 22:18:10 +0800
Message-ID: <TY3P286MB26117891DFB2DD615A7C54EF98969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407141813.89-1-wiagn233@outlook.com>
References: <20230407141813.89-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [4a6dlBAROa5BDpNhFLrtC3TVVUZvGCa1]
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230407141813.89-2-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB2638:EE_
X-MS-Office365-Filtering-Correlation-Id: 231f97d5-0005-40e6-3a24-08db3773039d
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmovywdyt6JbrF6Sw9xOtJae8eAFX/kUmKP9XvYLfMaYa4M6jti39yG6IUFcMndpiHIcXkEwMMcJxnf0FBHYSkyLLrKNZhQUqVhC2wCOmTYYiuPuTquv0SBOvPkSiXVlpjF8L5oAaZ3rWbJNrDVcL2qLo9SkwsFzVIasPuIupqxqFgduX6/EiUiiDUZw/Cp/LIoNoArcLiWsS96nN56YCCcbUEeFxVbvLqBcyOXhOYK3f8UyDEsfVJbdgQYG4l8N1gPS1qBOqdU3fBcqVnLNVSpd1ktPP+RDBAIYiNiBzXqaUvtEQSDYR6yssMhKpIGAi2ZyN2eZy8e2ty8rrCI36RLPJAyIPKrgCAHf1UV8U+Sew8ud2QpcQw21TdD1tER3DmF0oqohlGga6CtnjwzYCWx3XR+udwRTKSWyS2q08/k7kjAhBEGgcnbiiQ3JdHKHKvREoOZlTo+EOjZplwzHD07aDCqPFffwPg6GRWswp5vRx7Ji/K/iSySLZxLcAzFc2AcYM9fTbFvDU8Zu8uzrrX0USo1PBDEtfzetIrpAWMYDhuLMHUTsNZdEKoQxOH4o2dxqvBsUk4iWEcTQQsI6ot6BGHQtzx7RA6b42bMmpZSGYuw3EZhfu9kQpFWdchxtyIe7ijJhQxA57C4XUwlatYUZidUmc/3RWBKpuZC2tKhFAcanwdSfXBBJZMSavXkFPwv4FDXf9G//r8syqtaNOVm1Wht/+sIuBG7YvSZp3BvDj10evelWRc1ilG+nUnIXOtQ=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 421IwCcFM5Ja8Lg3Bu5Nz//pqnALSIXUV+f/KzFNLkA+td2Ud6jZW/YhMclxEW8G29z+i1hC3BQ36kuuqyqo7zbhJgF7MF7R7fVjCtWRcygVbiw6aLFcn4Oxs9/6+sasjXGVQaa9jgMxl0x3L+s5G3jwE+mZDfePf97V4L7kn/MBwOTDS4RgFnhbjfbJ4DG1vXfLIQqpXBqbQfHHS3klvjmXmGX5hhWJAZLxjLa0OknDzh2ZyzQYXfiAwYBvZw55q1H6YdzcRdg5C7PeMEbxbAGYhukEQ44qhOTElA4FN7BkSSK7drFf/omZc/heEvAt0U/a2zFzxKFo04AGLOV5HJY3pUCKacYdyINeLFsUDKZmezCkdJ8m/3RYQf2uvH199U5QCdTBLexEA+KJp8onkl35wOUWMZQfGBGdZp2XZMi3Ee+TA3xAyfXkLuLrbbEcS+Im8w8ihoSayG99rQBU9fpnVIbGoYy+4oX01rzBTeknRjRtowIADhWlYXws8ZFVtBYypRu3yVHRNhCb10yOVspZPk+R1VkjFNxkYNF5eG8aqW+5ltI/esnivZjx4i5Q7OzBw0Cyd2BWoNJg0ge+KewrLi8QOk0FBhPPN3GcLsOlHsakQHuJIEVtOzb4vx/m
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+jxXmM+fHQGklzGuzjJmOM4iIZLvCgTQzn6iS2+anju+Mvn3RnbU6ctMhDzr?=
 =?us-ascii?Q?y/mLECXFSye/KeAmaEbQLgJfPsqhg4SVsaVdnqag5rfNBC0zUa0BLl/JKiDI?=
 =?us-ascii?Q?NgbMqck71Y206RrrRFknrHRwm7D8pIvKoTQpJNxslm1jxzSm9G0EP0S+Y63x?=
 =?us-ascii?Q?uPmbHLs3R135MaM6wDTo7zIFFjbBiQOowfepedSjdwgBGcFIeYjLP1U25SUl?=
 =?us-ascii?Q?JTi6UIPUqTJeUrwUH5scjpw3Z9fyvdsO0tDZO40Bt2TjiVNJHYsXh7Ysn40r?=
 =?us-ascii?Q?97xvSHUYGACS3fuzYQp5ZcaLtsYoKKHS/gX6xa6KnLWj/ssWtlEtxZi9Q+Gc?=
 =?us-ascii?Q?uU1Mq0pjgAoeePoFLA6RAzJKB8e75oLkapl4i4mDjXN6ph7a+AjNdtoEjkwQ?=
 =?us-ascii?Q?i6CYU1Es/utTE6k3vr8s5RRr64wd275Kle9UoV7xubx21gr/1gJRTSPZ4y8P?=
 =?us-ascii?Q?gNkr/5E5lemz9BArWqABVRCUx/nao5ZbKahPBOISYBgrdyLj1uzQ9z9YMMQt?=
 =?us-ascii?Q?D1vfamA8UuASHUq/2utox/M7NW5yJTslxGWlfOEpzgjg9IYbTI7ianOR/Jzl?=
 =?us-ascii?Q?DLkBPbVuqF7sdOUQTYLzV6JnBxk0RAsiLwy3ODdHyEVwcM72Z8k0ZGceBvp0?=
 =?us-ascii?Q?Uk8ZSbnR0eEsdqZJTJEBcC6Z1JJjqHhsN0E7ikt8sv1az0PXTfTAahzY1xR2?=
 =?us-ascii?Q?JMe/8dOzFr00UE2zRuhFvWFRnaBhe21rHBog7pZUXCE7kJP+AYx5wrVmxmTu?=
 =?us-ascii?Q?+JzHxfwUls+uMoZD3by1D9D2AmC+mc/vgaaZ0rTgq/yzPkPmNodKQmA3FnPf?=
 =?us-ascii?Q?N67cDAta+MEtAJY6YE26C+/i/PUcaORmc21LI2Q3VZMlJwrRQQDKG7VkUlQt?=
 =?us-ascii?Q?kc9OU+56E6pToNA4Z50fMuQDhK+6Im5uc+UYNjzm+H5s+jORmWGow/WgDDF7?=
 =?us-ascii?Q?5ZbBftQHtFqq7D9SFPQhk4uk/oT8oj9TvheFuw4OVYGdeGmqxTAJye1jw4hM?=
 =?us-ascii?Q?PwJ1xnwgz+ZvPmAdGTohL+2+PpnQ36IJs02l4+X3DW2TRUU1jyuBhUBCtFRX?=
 =?us-ascii?Q?uKwykfL/5HP8WZ3/Ii9MhZtZ8aatK573dQQemQffTvKUov9myuQWSc/eikV6?=
 =?us-ascii?Q?CLsF94K4ozdaPVyrzA160X3x+lK7xOluOvg0I5kzt+vjb0//9gAFOBByfdT8?=
 =?us-ascii?Q?DK9xLMSBq16o5/lhwArhtavYbLEwEUMPZ+JP8g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231f97d5-0005-40e6-3a24-08db3773039d
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 14:18:52.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2638
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X-Powers AXP15060 is a PMIC seen on Starfive Visionfive 2 board. Add
relative compatible item and CPUSLDO support for it.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index b7a8747d5fa0..e150a8bf040a 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -92,6 +92,7 @@ properties:
           - x-powers,axp806
           - x-powers,axp809
           - x-powers,axp813
+          - x-powers,axp15060
       - items:
           - const: x-powers,axp228
           - const: x-powers,axp221
@@ -260,7 +261,7 @@ properties:
           Defines the work frequency of DC-DC in kHz.
 
     patternProperties:
-      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|drivevbus|dc5ldo)$":
+      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|cpusldo|(dc1)?sw|rtc(_|-)ldo|drivevbus|dc5ldo)$":
         $ref: /schemas/regulator/regulator.yaml#
         type: object
         unevaluatedProperties: false
-- 
2.25.1

