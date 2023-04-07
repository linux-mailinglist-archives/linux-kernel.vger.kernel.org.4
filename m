Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7126DAE78
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjDGN6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbjDGN6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:58:07 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2097.outbound.protection.outlook.com [40.92.98.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE50B8A42;
        Fri,  7 Apr 2023 06:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQgV13uEtcjwWuwhqPubZA7bkR+H308Onts/gI/OINX2OFWhtK8afn89cP52fnGSEBHp/5ah/P/EB9zYs1SThRXZBZVRoSRRPTz16u1D59JYY/GSHOWfkMu2va9UCZ81Fp+8SOMuSkzF8X8QZv2ot4GBx7LLYBdjf33njUIc/B3tH8soHv7KtsfVU9BJqOyJhsHA2sKSOFo+tWUXchriNyUnU6AuKxC1nD2SaQrG580BLD2XygTXo3rt55HWY/FqA1+Hf0djhAcxsgE1XsN2bJHp9Y+QJtT8rsI21vHBiCI9uKS2xsvMrBzPXxmhs1VX1SOyvDoCGEmsVkuUCT9iVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vrcbQ/ynOqDu243PYl+5tLXL9TrXYsqacXoIBU0f7E=;
 b=MTw/bmfveoyrkMjB/LVj9x+KEvvgQk/3PmXYZ0emG/3gjJiDE0miw7MVEWgW2H7OwDl50OCZ25obGZm9oPDN3kGXoJVidIGj9OrRw3qOe6RU8uS4ZuTcip/XMRO8fAst4eRzG3jWeK1HN2gB6oFForfakkqWIHiofVFacGxV9V4j9dUniszCFncDtZC0G2dZxTBMkcwaISI1m9pAtRG3gIiEWBqJ+NJgss54ILvmCLq/7GuMvsZ3vJqzJmmE+UgQjjAyzYIhZswPhGx0O594ZLWENIl+I6ATcdtnpCbp0ldX6otNBGbxmXysTQxacBrJbZ9Ar7mLA+IEh6gDzzk7rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vrcbQ/ynOqDu243PYl+5tLXL9TrXYsqacXoIBU0f7E=;
 b=INUaHCYCi0xqdt1Da5gGzrSldD8xwi96ehaHHRimMhKTvRfqaY2lhSSTtNbKUBv9zvmINzWjXJG+v5prTI5iG7K6LMM6tccU0ChvXodajaC5sACfp6gVXjA1IKz7ums+jEmj3MAIfKoTSQqyAoiaGK4cUmZeXgBV3pQUDTRepxTj6j4vTDcDd2I6Y4ftd7BJ9x+UuK4hkxoSZiNh8dE0UJJoQViQ+EXXxQPuW9KyUkjr9Qq6fxi3lxs0xzsix46Z3ksxNRy/5mZlide9O/D0WZmfUUKyNgQwLnqpS9xoAq7EkoTANUNSnY5JSOSGVEVcCfTMMiKZbu1stJaUuZvlmQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OSZP286MB2208.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:18d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Fri, 7 Apr
 2023 13:57:49 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6277.033; Fri, 7 Apr 2023
 13:57:49 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 0/4] Add X-Powers AXP15060 PMIC support
Date:   Fri,  7 Apr 2023 21:57:13 +0800
Message-ID: <TY3P286MB2611A814E580C96DC6F187B798969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [dSkGuS4AOxlLuF9I7D5pbNVqhPeryzkl]
X-ClientProxiedBy: SJ0PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::25) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230407135717.17381-1-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB2208:EE_
X-MS-Office365-Filtering-Correlation-Id: 47267626-8010-4c14-ee87-08db377012c3
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3k6jt5nbgZNLlaeV4OzujJ1x7vrjZMmp5xX5eGR+Eyz9R51GLSUaN7PZtxnjG6o1QaL54qZjL0obI8dJvQOWXnEd7cSu+j14fsHgt2jQQe0Y2FPgjWMqhhzQO/gE1W24d7KKtuuV2MCE3uNOTE1D+iecBN9OVjzocrTvc42vQvzKdDgMFwGXPrzeAdMGPjl5sGzvpEMIoM8ABF5by9u9Fl/1Fchen3pDFy/0UA3XSAnOx+0xvPOxjFuG+ALWHSsYelxpu4YK2SFsbxKrONKweZ8tjp9WGPl0NdVDvgvrli+pq6nrhJH7HAuddoUanSfwfx9PS+3B5L7W90CGY5zSIIYkKyq5MCJy2gg3qIdkygF3I1fcu3Vls8et1gHJvJEtJKkcVar3nbPkq/kzp7Qg6qE7ek/3llcuQao3NqcqCaOFmqD17Gpl+iKNfUBiEhWa2JRNPAutxbPGT3z3h8C1XqoKU6wweLP5A3ZfNHwmg71W9MAwh2rP6hpcnxtD71kRmiG2N6YZFl5z0INpWhW9TwXTv3nJafABsqG1pA6SBZspF9Jr7inhjjKTia+fljOJAjiDEgLfanH5FmmNy5icS5PJPhM5XJ7cdzJki6i1+iGkvB6lxoJZoaq+lUqIocamXhmNbkE3GMVs+eYB1iMCkHzgC6J2+zVqJ7zRFY/VqZWxArtqHgCbh9B3LaLJ/RYbHzK1dLvQ4xCsje/DzBYisoLljibmU7Z4fZmBgKwMnIV6CgJCUrFS++NHrtlUKSd+qmlYuR8/7ELEGNpB9jB/Z++
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8IieyLWPFOt+/f08NgPTZL2Pr+XWrAQwygbLecnnNh3qAoXMHJiQzqGQjYMkk72xFr7MXhtmkUKo5kjo0Eybkn973d+rSNCiRMip/0+OgOxdHQiuBa3f84yI0IgBzQ1z/9gmZafhOMBTTaMCGB1sN1pP0m4qTemllcjJ2M665DBBjnTLEJUyS+PdVJCzU0jQepM7VRogKZQmiNj3HsjaK3NtLI4bf8fLcowNtsEE4vurpTIv+5ckGGtAW47R01GmUgjxQ974+m62eWG5QCaBFxqAKPVKYEn1r60XIzB74E2CXwZkbuN2eczNZ+U95BpYaroE1vKlfIZc3b2kBvyPYMne/k/6CtMXBk59ABV/3jkQbPDt30cb8TfPEYnwelvYDInDCuvkQEEi+fZPy37Kv4TKmwMWC8WQRbHtkv41e3gVIq0uLr1D8hv8HF2HP70yRtWD4IcCs50oXe42P2IzYwWpMLeiSPAhfibu/0YgJb5qBSaz4DYUL2zM2+vL2wCAxeIUeFkqSgY0zWWbXTqLOaFzKMuHfJ50/bew9Tar07ksg+t0uC4QzS24vJyPZJ5oe9j63KOH1W4vhAfGE5km8hO9V75SPTcGN/Tsb6tNHeJ69bI7mJ4AzLKWUOF/RxM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+n5uY2svGKB2JVE2pWfYew9S1OAIhPi5HQ0SmuManGYLDSItY71GkcI4Okl3?=
 =?us-ascii?Q?gA9xZYQGrfBOK9yCCYaU50b0IvRngloTYWogefdg9ubkg2jmDegTPRv6IugE?=
 =?us-ascii?Q?L9yKnaeBHDEihncmhELIcw+rMa/zSJ013fRNLtrSwovA3Us4LY0ucPPY6w7F?=
 =?us-ascii?Q?aETO3PYbom/e9YKexiYuccgSPzyesINCwDtJ0eAjsoMckKNPfYuuDSq3/eSc?=
 =?us-ascii?Q?eNHSlCF1aFLt06dvl9oUw5Ul4Uv2T9HTnxCXmqb5INfJSxDYVXV8ZpVsgTfk?=
 =?us-ascii?Q?HFCiQtg+5yHAyC0f58bLvUr6hxcoewlLRk+GgYUEtQKiyIwAWlK2DCtNR/sl?=
 =?us-ascii?Q?/dUnQaDLUJjbpxsX8K7C/PrDLyS3IJuIkXgxeZsZbKZEx0Bt3NopjcNYVCTS?=
 =?us-ascii?Q?hiQFJf7oYBVRvvR36RPbzcUO9ukdW2g7p/sKCB2pRnVvILQ75XV0TvupkZqI?=
 =?us-ascii?Q?B3GfncceiTkk1Q1LkxhdwIIsI3c5JF5vrNGiRzpx7ZcLtYXqeI5QE64KlX2e?=
 =?us-ascii?Q?kYlzjZUZzDFueXgTbxgkx9uxd25Lj4GOraDEQxg/cmG9oUTjidUJxxnPfT7w?=
 =?us-ascii?Q?11YIYnND2a8ocJjac2f//owLWRFQAoK1EDHIIlqLmckUI2gSGV9LFFSy3X1m?=
 =?us-ascii?Q?tgky24Ifxai5V3SH6XARi5PnD4gSA51b243G9zk3HQ4JKXkj5D2aUOKhtINo?=
 =?us-ascii?Q?vosDk7PoOt4DVTSGdDUDxGRQVapFTPR05K1HjGpynW1IBXuJWcDBNqdCdzks?=
 =?us-ascii?Q?kvHpVijYdFVehjSvu3xvJ5zlcYh0N23LpzU0bhEcw6Z0lYn8FveW0lNPxeOH?=
 =?us-ascii?Q?dkP13rNeV6ZT7CPD6WlQ+1DhEpehJNQql33nsBlb7p620bHBKSQEbKdvNohf?=
 =?us-ascii?Q?vWB0YXFhiVUWCRgd9ZW2dRJcEByZ8qgSrY3KVIqK7NWhRGOvFz96Qxkp3Bse?=
 =?us-ascii?Q?kQkdyDlJbSypaH0Im1ENTPjUQa3+Xf3l8fFVyCt3CMOt8B8LWAvVv/fpQzX4?=
 =?us-ascii?Q?2Jrdc5si6+J0x+I0xvOBs2uIwl2/fxve5Gb9hIQso3TWSV1T7/9qTS8aDZAd?=
 =?us-ascii?Q?nVAsPvcsh716jgqAVyAYmOVkFycJr9NvT5nr1rdI0SlaA0f1cbLBmut72zLl?=
 =?us-ascii?Q?kq17zlM0Eg59IUcF09CoqJAKvD3N/P5+XBYm6MMppzXCmV7s+xqeKXo59VnS?=
 =?us-ascii?Q?3X0uzJXVizB1j877zFYLG0OUnTicaPx6f5zZeA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47267626-8010-4c14-ee87-08db377012c3
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 13:57:49.8369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2208
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the X-Powers AXP15060 PMIC, which is
a general purpose PMIC seen on different boards with different SOC.
This series were tested on Starfive Visionfive 2 board.

On this board, IRQ line from PMIC isn't connected so PEK function is
completely unable to use, so IRQ existence detection is added to patch 2
to avoid initialization failure.

Besides, its GPIO/LDO control logic is quite different from other chips
and is not easy to add support for it basing on existing axp20x GPIO
driver, so I didn't add support for it in this series. Maybe others
could do this.

Shengyu Qu (4):
  dt-bindings: mfd: x-powers,axp152: Document the AXP15060 variant
  mfd: axp20x: Add support for AXP15060 PMIC
  regulator: axp20x: Add AXP15060 support
  regulator: axp20x: Set DCDC frequency only when property exists

 .../bindings/mfd/x-powers,axp152.yaml         |   3 +-
 drivers/mfd/axp20x-i2c.c                      |   2 +
 drivers/mfd/axp20x.c                          |  90 +++++++
 drivers/regulator/axp20x-regulator.c          | 237 +++++++++++++++++-
 include/linux/mfd/axp20x.h                    |  85 +++++++
 5 files changed, 404 insertions(+), 13 deletions(-)

-- 
2.25.1

