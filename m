Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D56DAE7A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbjDGN63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237677AbjDGN6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:58:10 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2105.outbound.protection.outlook.com [40.92.98.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088C79ED1;
        Fri,  7 Apr 2023 06:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1idNOF2P6tafSsofclpDtwfhP886KAOz7nYjDnexgZgniPDrSEe2NAuTaYuMStLqUaC3+GjDn1jHEijoPbaqHUPZf/C0Nf7QtBBJkzzQKCxbkGK77ls2uDYSi87zH1GSrdEpPym10anOoYxd4ZQudREc5TCJ83R8tvnTGata3zk6wCxqo/4nqkrGSG9fhMdi+zluYaK/FsgkTIw4/zVOyMUhF/fYGjqqL6SyeLKE5ffyXmLYZ3FS6d3Oxhkri5EOQrbgH7KvAb6oDunO9/IJLEymgeqOKR+d8c8o0kUmFMDvFNI9sdyOHrJUi3WFBdvDIso/1o0urswu8F7jFHh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQqG7RbxSW47jhVFKn/QZwZ9GUFuTehvAioXj/SsODk=;
 b=h9J+oYtXHf0zkagL06qlQJfCht+fkEjjfNlyrvEg2uykKv+kF3Mk9fPD09pRxlO7xQr92iVWU6s2S9ReuVw0NsW7NWCoTyX+iFQchQ3DfZWG1dUnw1xcqerSa1KdXd8SSiqrBK30NQE32d5KQdhnfrPRJCF8ghneNs0kV7uSV/WJHuanJq1IvBWsmBEm3uWVYs/CaZfwLB9EztZmShQgSy5IvKeb0B3TP+5MNlskCt5vZbFvjA86FcB5TPTHgER2IaQ713ZKqoqvCbl0unQXjxiiiFckwx4s82lhjXzIEELm2p+nEIMQpzjAvjC5bwrml2SVch8x+T8NvwKp3mzrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQqG7RbxSW47jhVFKn/QZwZ9GUFuTehvAioXj/SsODk=;
 b=bRDTMD4NV2kVcir1yZ/8vqC7ndq1aAsgc5LHhvd14+VZ2YnQHiWSD04rvVNUjt8wrqw9gWvPMSqIeVdwptAcpnxQCi+hRsPNo1jLyzhoysFCSrFtCjS+IfsCEIzXzXA6JI81FQN5L7xLpJTOnKMmph0XHDlx3sXFZryUqgVAYJ5qEs/IjFtQRCAltd6dP2oP01vwWF2LohjoFNLl4VX9Hb5/FJQesK4Q72EhFHn8c6qRAZ2ZQM2Y+DxzatVTjMNdHAayn85YIEHaeLjDmZDErL6BrDC0GKYqlXRGhBL14+D7k2VlCu44pNQ3V8+mFeLM1DUlDMVngjqA1OW2jJav2g==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OSZP286MB2208.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:18d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Fri, 7 Apr
 2023 13:58:00 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6277.033; Fri, 7 Apr 2023
 13:58:00 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 1/4] dt-bindings: mfd: x-powers,axp152: Document the AXP15060 variant
Date:   Fri,  7 Apr 2023 21:57:14 +0800
Message-ID: <TY3P286MB2611B68C280120B9F4E29BC398969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407135717.17381-1-wiagn233@outlook.com>
References: <20230407135717.17381-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [nNTPEQTo0Bhv5r1cvL4/uFupfPtdtKHv]
X-ClientProxiedBy: SJ0PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::25) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230407135717.17381-2-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB2208:EE_
X-MS-Office365-Filtering-Correlation-Id: 06502207-85d5-4d3a-6c2c-08db37701912
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmovywdyt6JbrF6Sw9xOtJae8eAFX/kUmKMBqm+sVascIKU2uWF3XKRikHKwdka+SBO8uxvhewXfSyGZmOPhQbXYiwjKRVACNi0R//MBuUwkmy7kyefyyAvL6lk15aYwyGwNCvYrScfvMrw5rQeOD9O66JRvWCEOIwwsp35x6pZf/WE39CdWv586DPibk5hFnACgGDslYl/U0VbKcojktCtQCietmQZx8HUjVGVyozaWPKBDG9rjmvltBvwm9e0uUbOye1Wp5hKuAw2Xtu9P0ifxt8xLozr14niIrhC7mUkmSTgBWJOK+X9g908VWgkoZ6Pu7H3na8HRFDzcpJ3uBwlN9GcrWq0mvXd+g4YytSo7qqozDFOLMfMOFflGEdAZv02eW5hDPWy0t1q3p9VrBWnuJ/CwuJ22D8PfXqMCZeKZFze/uaC9WpfpW/XPWriLMRq6LD3GE8Pn5MLsH/n3mXUeGrBzL1OTNwYhDxywHrJ8t+sYz3mEsc1KYqIsbgfETh8GO8ovtnQlrBrTlzSYyw5yeAWQ1S1UHayYaErBzTS0YpvgZOZo3VwQbqfC6GJGLuD8HjZstlR3cYakpMcHg1VTZwZs7v1xtNOKdhsoeqLQ8fhfdqPLh6+3QfO2dFz+aM33+kui/VgANDtkamq7sbwF1husbLw9lav3tc3XvOVYXM65zHp+cIVtYkmUOGlxtHC4hY7SNOPm8j6xRzWYvYDbMHs3voeB7Imnbs6Lzm7q/hjZIV0iX6VO1ap58bzFF4k=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUdwcPyEkkkHEZe2DaR3MuRkpzrOvOJaG3SdjDRCud6SGrVihJTdYAmtkCUsNNDmyotDzeB3hJKoIJSTpP+nxU7+6FevfmNH8mK/EosaKBzuABuwHzylleAXw9g2f4/BcwXlCY7eAz5vAYlriog4U1GvbtNMGrc0MxHkweujisY0oX9XRVY0G9BNUecC0MUTmAPldMFQtw/S8w3MNGHXXp5ChQVJpJt92FBjB3cv8WhZCGVi1UUOBC+0FKgpuBDG+LXE7uOFmkkYXizHajZVCnGqwl1l2ilZh8vqV2xFO8NHb7htJZfcoY51oSgZKtfCnhe5YAoarFvVe7RrUDTFlFdItWRa/VEM2brd/kSgZLsa7Jv1CIb6jOOpaeNOhmZ/Gm5nTWKnaPXfUVltheIXjONCoajES05m5775zV4mi6uaVwegzsief8Tn87aP3XAR+Ak19SZA5Ljk+6cCQcS1fmM99XDtwmw7B69FhqfiNzpsWxMsgO2wbIgeNZqbUyl1WWxWR6Ucjd6hlEytmWXCl0ZSXcHwjsyOP7Bp1cE0L0dM1MIn+cPdNQUqP9dc7pRzh+WAZcjXNw9jjZPdVBCzHFxw2LRAoxSC60rIl2gSVhmx6bNmgaYVsmzwgosVFvIg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H0S63I4sV1BIOnit698YPm22dQqVpfXk2D9N3zfQ7ZUbpdnmudxrf1Vtf+Bi?=
 =?us-ascii?Q?uAnTis3wEtJ3jTCPivCiIrZqsl/mVRT3cqi/41oZ2sj22efaciM/cAsTU9nh?=
 =?us-ascii?Q?jlONGha8fauBFd9Of1qc1jZb+Hp/OandWpdWcj3l8MWUh04sy09v2l8ZU2rC?=
 =?us-ascii?Q?6DIWWaltB96m3B2/YnE44tbd1s7/Dr0kUd3zEfDKpvrovQKsfpyMzHzbv382?=
 =?us-ascii?Q?4WP1MFTDBooGxmCaBGOjH4BNnhzNxIgoi/LI8P8sbcJtYMe60v+PxnZE56Vg?=
 =?us-ascii?Q?hX8ATOy3lWjzgJ+JGEefOAWjZ4/drYLZ0ilwqzBqkQDb0mXrr4O2ItWEIlXw?=
 =?us-ascii?Q?JzNHUGXVjPQdH3H+EdInvqcRMSAJ1Ufre0AuDN40jUzMmGCFz7CiAfEuN59S?=
 =?us-ascii?Q?OwJ/KGiJvtxIVWr6xe19aAUT7sBDudYDWnUvHoE30i0Uly1ZMdNQe+B2kD6t?=
 =?us-ascii?Q?8vEUbuN4nWUNlLIV2LeG+ke9UODOWPUH9TEQErhorQR6gZkwMXBZnCNXGcly?=
 =?us-ascii?Q?96dnIpVQFreg1+l47cjw6vfEINSYxhx6MLNIWhTCwLgMZ9FsWWYbtXlCxfhD?=
 =?us-ascii?Q?lZfZBOXutCbcQOIHth66Gn/K1re9deCfCzMbSiGmpFnTCfCTEP3Fq7JigaS5?=
 =?us-ascii?Q?/eWc6BU7qayPxlWdX/IAcOc6n+gKzkprh96VkIrbGl4WacNW3ITjKB3StUDD?=
 =?us-ascii?Q?iTRDqMlfbrcaMCyM9pKfcKCVZRm75+3vAMcuJtipQlpc9YUK+80MomaNWxhY?=
 =?us-ascii?Q?SbLixmOKMn2hNEp1mOTsSXCkDt9WhoA8Rbb+K7PTLd9PmmDROTppsNQWACql?=
 =?us-ascii?Q?3FUoMj26z6neSvuxtycZckuT65ihkjoWY0jplJ36nP+WmbCokTgVxd6Z99as?=
 =?us-ascii?Q?S63kZYX6xtpO8KN5QbyTvgg7cx4p359SyNnwiz+TYU4adMUTGpLkVaPvkkLr?=
 =?us-ascii?Q?1lBhxh6VOCCKzd30ZqK4QDdw+RVmqMPX473YwSBzlHI3OU/dD6sBtiOFl2CT?=
 =?us-ascii?Q?NR1VNOfnyGg2t0PhshN3ZB1/+47cC3T+lX1mYKbvpZajUAGnUTODIrRj+kii?=
 =?us-ascii?Q?iPFgyytIoMalUHgIiKc7Wqapw/A1XPK8SKdCzKhiBZqQmm9oiAzbhjFmohex?=
 =?us-ascii?Q?S+OwVkwoZgEHFbDI7mQolnKIfbzvKd0wz4pftzDedeHPeK/bjQ2dVWBqTGui?=
 =?us-ascii?Q?CXiD44+Y5wD93+Y8tbR/zoiXQk5r0lZ3VCzR3g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06502207-85d5-4d3a-6c2c-08db37701912
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 13:58:00.3296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2208
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

