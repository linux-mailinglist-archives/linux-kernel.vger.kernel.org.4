Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DE95B6123
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiILSjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiILSip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:38:45 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2121.outbound.protection.outlook.com [40.107.113.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37714165AC;
        Mon, 12 Sep 2022 11:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyXotb2XrwD8zqxFCpor4xRjCxIIftOaiWSQEKy+QQKxeTlarVEcvTEz9qNnc18PLqxVOS0e5pXA4LBjWd3Udrf/eOYUffrNOemKFaN8p8ygu36W5X0HKsssbmUOL1dEqz7+qdGgWm6Xytk5yZ9mwkyxivD+Y3hgOW1rkPPTAxGWPVkLfHYVfJ1mUGQ3gJthE+rOj5Te4CUmkk0PUEUWTh3TwbqvLyUouNjSDUd5xCTAXznYhpDKORsHZ/+tX0c+Q9T8NF6/9tt08etKBhQrKmxG/YNVqdaruJBjSKmN+V8OAr4lw4A3ihczoV94i6YbSL2Tbmj+O46CeYfO0ByEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCZrYjQnx74F01uRoriT3J7Imwx+plwxG5ScezFgMLg=;
 b=na/UBVwUOMSvHpp5vg+4dc7knFgGuGrdp/tL0RiEU864g1mkJSH0rBTzrR6Tm/PaDjH1pHfxMy1GG2B2fP/Xzp0b54RU67PMnF9smZY1MaSALPiT+VGrDj4HQyWQGjzhN0MDkxZAsVVPKhZ3EYCfndsGKyOvtTA/8k9e8i2evgju3YFgzr9K/1fZNOjfyrOwiYjL0/Lmd1a6I+l8WHyvAXXDI9ZeB3HIvUJT6JYKKbRqZXEHfGNtMfMUh9aIY5+sdMySOhWDLrI617XIqxYHziH2ZcNvgrKA51A+7YNPxquZNlGeeV6is7FUP3q0lpF1irJRtb209/FENkp/7GPRiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCZrYjQnx74F01uRoriT3J7Imwx+plwxG5ScezFgMLg=;
 b=GvmDvrapUDSpaF+8D0EF+zP2fTquoD2KAb71Lz6Ta1NcBdzrmEfd5SAf3xwtWuJfGU8nDTkYICoh7egzP7WE6VjoPN29aoN78k5NshV2XT6T3GrfH3vJZeMkUlQ2HO8/u01irO8sHN68NTMQecLrF/lirqF4uZIyhT3mhizQvIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by TYWPR01MB8379.jpnprd01.prod.outlook.com (2603:1096:400:160::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 18:36:31 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::7097:ae11:b1c0:94a]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::7097:ae11:b1c0:94a%4]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 18:36:29 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        alexander.helms.jy@renesas.com, michal.simek@xilinx.com,
        saeed.nowshadi@amd.com
Subject: [PATCH v2 0/2] Renesas Versaclock7 Bindings and Clock Driver
Date:   Mon, 12 Sep 2022 11:36:11 -0700
Message-Id: <20220912183613.22213-1-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::44) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|TYWPR01MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: e675c173-53d8-45eb-dd6a-08da94edb551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oh6Tbqr538rbSq8eiOlzyd/ZCkRT/kqDc0XXhV91uXdXt2jtOQR2cdA8iV93D5g+amnG3TPXRSSG56RrKV5lypw7cyyY5CngaNy6HtW24CkmrhAvIO9cfNudEL4kLRACkwNDbcBdMkPOEE6kDyLa1+iGG4n+7k+LRQPqXDjqmhl0YVrc9p92TAlTIN+ijo5SNIDv1U1qqzF1dSS0PUGEpdCse+Gi+Bwq76S2ph9IzyKx3XlvSQQXjgieX8FXeMJMHY7Aja0nj1xduSXfVgGmR/J33oTP11x2ThtARSVVGsB9bpIKJ5MGdMBc1SDBnxWnqZbeq7ZKEf8fBOuwTJ4alErxqyyqxDU2jvkC6+tc/zD8ja6799ixCX/3aKYj42dYI8x3qzju3WxuR2onDVN0fOctO+VcqY0Od437MByTkzgIQCad/OiaKAPUm8pxDbzDz+BbHoBFKCI1YNDdIjBqU5+qUFYrUr+m4TrLjwe7uwa93qxyBTG7uBz8gYuVtJGo680RJQC0fZasSxoHwQ3Q+mI5iHGLUzc6VVls/AEcrcq4OaOz8RnvlbgSFXRdqSwTzXPFZx8GKPcks4y+jjUY+WpFYBYpYa98aQjSI0K1YZ0nez4jpqM3WFOpefUFl3RtIYzELmDaSBTIHx7yWif5q3MLA4kMbz3Qq/dWFChlTtC8WZYtNjJXag5Xm4otXYn4gSH0n2xrZ5DM/F7i0WJ49up1xTMGlZD0amP9USE0F147GZHhAI97x8fpu54sw4Wj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(1076003)(6512007)(36756003)(8676002)(38100700002)(52116002)(2906002)(4744005)(83380400001)(38350700002)(186003)(66476007)(4326008)(66556008)(5660300002)(478600001)(316002)(8936002)(86362001)(103116003)(6486002)(6506007)(26005)(6666004)(66946007)(41300700001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MWtTRIZeJg6uywoWojGp7Gc9dA7+Q4ew85LE2KfUfO9Jmsy3CDC0s6W8FS/F?=
 =?us-ascii?Q?VK+vq7QPCnz8KGRl9dC6jOKK/s1dAzVqmimDAmsdd7PGVSxexjVAQi4U+3U5?=
 =?us-ascii?Q?RYpzvnwxRklaYm1+G7ENN370AsnCZROw9ckUSyqE3hGpS/UqdTl4wceHgYWJ?=
 =?us-ascii?Q?QDnowlpzxwzsVcL+tU8D50nWsUtDKi+fouXCEPIeuOSVOQfAcQdY7lvGxSL5?=
 =?us-ascii?Q?dG5JCcZ6mjZFBIp1GvkmVhTZuyuhqnchtMowM2rx93TpIesfhDqxoZk3d3n5?=
 =?us-ascii?Q?oYKFeWRNvNoBdIBbzDGv5b/lu+ykuL/CxeORKoG2iHyV+8556nz1hydv9Faa?=
 =?us-ascii?Q?ZVR+tmYjLJUw93WeJFVX0ENfVf7zUg6XmpHZMli8x7LYJjkDaHyolh9QvFOp?=
 =?us-ascii?Q?+VWhmqWU3xuw2R23BMLghwsXdLRtoTmm12sNb+L+mEhJh3KEv5f5IVjTWG69?=
 =?us-ascii?Q?wSoLI7M0vyvuFIUF88CFcSyjzBa9CnbS42AIxvOo9wxr+Qa1WKe5cfnME8XO?=
 =?us-ascii?Q?KNUSXwKnBHtvJ0eB22SwOIqKMOD3D8cac56n4fexuvH0fXJRVIoUZHvYgDLa?=
 =?us-ascii?Q?4AZ68v1WCjaJ8Xl89kyj4JqxRcAq/2hNqTErHF10uL2TgliSjYosN5c9HfoI?=
 =?us-ascii?Q?bVUJvWHVYgKVw7uQAQQmydj1IylyE3Ak/9griJMVm5OTPM2V/fOWFnNTgcTz?=
 =?us-ascii?Q?LxOVfeHGDyq63XEN2HcOKSdRLjz9cDwkn1y5Jl0TTP1B4KQK3QowIAr1kkLK?=
 =?us-ascii?Q?/4TwN/7mkv+hHpA0/9KTA/IYLkGxT12w99b1Gr1Gp7jWZCLUkh4OJIdy7Mu5?=
 =?us-ascii?Q?p9bD6A48Ku7IK72ZA6kAR5yoVfvHdfSzAgtTaPL3kMGNUaMmqnJQ/pLZDrip?=
 =?us-ascii?Q?zw/QnpL+uv3NwLvSXbdxa6yFuNEQO86ClElLdx2aBJ/KvmPyTZLosaH9ebAp?=
 =?us-ascii?Q?oG5cIa3QcpZscxt+gvzjT86/P9YrDx5xNE7UIFlxam3jo9R0crfzk8gHImVf?=
 =?us-ascii?Q?IuaRq8wVxK/fb4P1iOFaXLr/EXmsvPRym0ARZhbBj2FOtvRL07FUt5npXcAo?=
 =?us-ascii?Q?3Ly6rI9EAtyCMClmPLTjf8NV9gpEz/q6Khi6efKEzU1V6w2f2j96YhZOoOHn?=
 =?us-ascii?Q?/jeIEviedM1M8TfWv3PBXdOb1aaGmE/maO//PC6R2Gfuus0tXkSo5+PO74WH?=
 =?us-ascii?Q?JNZ36xso9iw3+YcBQO/q5qfI45S9QMP4NFG7qSPrg6T8BAfHHbFjOSZZG8Mb?=
 =?us-ascii?Q?Z8FgKsS8DknDk3YOi5SrxaGaUkMRYJuK+f1xq0wOUVcwYO2vvq5RLA6CCadm?=
 =?us-ascii?Q?x04Jm5phSbgfew4bjoPvnnpOFhtoIG+XchLQidK3x88JehVnFXKI/sUbHujr?=
 =?us-ascii?Q?Oi2saF8qSQ3jBhHwOxu9pEHUIop4w+JaM2I1y7ieiofNR/evRj7KpqRU3Pl2?=
 =?us-ascii?Q?1idVXNSY6FUuEyxoks5zcrGYBb2UPY0HdTtUkfMAZLx88lQwQNPVgIMe5xsf?=
 =?us-ascii?Q?iv6erPqoe3AScx+xM/ZgBzR/+dXbDQjS01sCiCMlmo4NfNwWekJLnm5VkvbN?=
 =?us-ascii?Q?OCtaJ0FY1e58/5etYPyXW/5FcoOW9COjYxFbGlp1Abed/vkheB7Es5SPJj/t?=
 =?us-ascii?Q?WopYmdoNsUoD/jVIMQQ/Ig8=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e675c173-53d8-45eb-dd6a-08da94edb551
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 18:36:29.9047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Brt5iUQcFE5I+0zoFqprvjFrM1nSKBEVLyNmUdEss4rzmGt9t3CoRH9hD8/evz9y2VYJNXzSfN9GGZCOdUrWhAmbfd1cGZBkbemPBkKR9UQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8379
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree bindings and a common clock framework device driver
for the Renesas VersaClock7 clock generator family.
---
Changelog v2:
- Index to output number varies based on which VC7 chip model is used.
  Correct bank to output reference requires converting index to output number
  based on chip model.
- Differentiate between multiple instance of clock nodes by using
  the value of 'clock-output-names' property.

Alex Helms (2):
  dt-bindings: Renesas versaclock7 device tree bindings
  clk: Renesas versaclock7 ccf device driver

 .../bindings/clock/renesas,versaclock7.yaml   |   64 +
 MAINTAINERS                                   |    6 +
 drivers/clk/Kconfig                           |    9 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-versaclock7.c                 | 1292 +++++++++++++++++
 5 files changed, 1372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml
 create mode 100755 drivers/clk/clk-versaclock7.c


base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.30.2

