Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C32B6DAEBF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbjDGOTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDGOTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:19:06 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2055.outbound.protection.outlook.com [40.92.98.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE2E49CA;
        Fri,  7 Apr 2023 07:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMIVcJd/c2ekdDIbKxKLLQJl4KIupNw5hG1y6HP+doKlcEvdUQl+pUHp+bteDBnjr73yL9B/qt7Byd92aPS5fdXlbmIeQNc+NKnEtBn/A2mGzDjtGJwpRvNDs9roNlAuIWSsBxHlwlCjYdyK+ff5vmbGfjaBbGrzh7kioWCM30bhtfCfyqu6pbBIpFFpPszDJErY26EbDkXQ4Mprg+b/VZa7e42WmD4LYtJES/ZUnX3Nl7EIotzCQ1sRQ80qWyrNKH0mzs/S/r+DU+pgzBswsb3vmRmqNnG43BXo858Nz8FC+W8wqLC9hvWkuTcIqMwgrmAKXdR/ljbleo9Qesvpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vrcbQ/ynOqDu243PYl+5tLXL9TrXYsqacXoIBU0f7E=;
 b=OsaWMjuQOw+HjqL7IJru8U75qkTvZGiOLhKlww/1uxJEFBcjiUM+LjrBEAHsx93KySztTAGEsbHp+xbI7rsJyynvAxAtN9f8Kb2PGokhTdN9YvYhvJYZQUTlgsXDBc8PJLmf8CK3IWzOHj8NNuW15sdcYWjUYITKehJCPWXnpHRnGdDIbo7FbotDaJLm3evNvTaNA5mESjXnXVf+TyXW/oBHAjcxYLaNbam4FoYgZ+vxAFkdpNW0DXQIrHJX/vszj8PeMbeZCmzzbgpnft05kvczzIAIgskYEbA+lTi03ovSz0906kF1LEhr7hKEwrjO8KTVF3Lp0KQXaB/ws5Nqjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vrcbQ/ynOqDu243PYl+5tLXL9TrXYsqacXoIBU0f7E=;
 b=OAEfQI4VShovj9hADcepQOztdv3xZZaEvdrbszJ6isGP07qNvOb7DB+TDMOhCxKlsP8vMMURN6m11nBOHPotN7ElG6ataksZ3UhQQU8GyUJf3WWM4a+9MReUscn527TbPZwEscp1/s7bzboLrbPWvQyJMnXZH71m01OseQMbnwxZ5o7kqVIxehgmMiDybDSZKUcacmnByPFf8IpYJWdOdaRVqWMhe3BXn7FWmTQNu3ylOe22x9XVHWn50WeVmucYBYmPfnrvXP/q9+81zJTG9PqDye8danHQ+HdfmXpftC6CbGeJxx+3Xcoukw+YqoFHDHgO3Ivx7GM7f41h9sd0ag==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYCP286MB2638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:242::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 14:18:48 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6277.033; Fri, 7 Apr 2023
 14:18:48 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 0/4] Add X-Powers AXP15060 PMIC support
Date:   Fri,  7 Apr 2023 22:18:09 +0800
Message-ID: <TY3P286MB2611B2CE8CA1E14D08DDD8B698969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [0BkcRII9H08K7q+0Dd7/YjqPN7ZOFDq9]
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230407141813.89-1-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB2638:EE_
X-MS-Office365-Filtering-Correlation-Id: be5ebee8-68e9-4a9f-6105-08db37730119
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3k6jt5nbgZNLlaeV4OzujJ1x7vrjZMmp5wTDcnMu8GOEZ6LBqJce4axidI4hFfZUQkVrMoy12oeGwsih9FiiBD3i+eojuZOHuOxWYmFyP5tHuCb8+GLfniY1uAqkq959/CKmo2rENMrmY6xXX6mSFsg6nyBXPWjyt9jj6t5AmnXlbiQXFRW343boASKJAbJzhtLNC+tk5hRZQOrKO3kxUvkfct8jS4m1FXNWZtw+2L5n+Z/hDCr2A5POcvEuPnb/0y8rTbphkVIzWLKl6OleupCf1nH9D6EqgJjoVkuL4K2cVAUXmRIaylg4Dg2PJYKIe3k0Nn83CYhfdsOlgaL2G+J0lgwJhP9QIKqQb/wSLhwAbhmAn8MB5noRajWYHqLn19UGE5dQzs/mVFbDRgQccRDyS6Fu8uXnpWyUx8/SgrtLlUU4VadIWfXP+l5OSw+5OZ1e21QHoExkO12Ux8XlzVd+O+WVP5XrLy9wxvJEzKTeNEn835c9bP+pXS4B2eiy5vgzENsBLB7axjHRg3lVeDGIfcfPwkSWLXbLlifQtZoo6mmoiipbFFI/FUlwy25F5Bb9oFkkkWmQsASOg5F7Etcdq9JUOrV8Qiv5kxzC9upZIp2LnOW25fIuzn36+rdrO5bJ55L0HBVxpsl0T4E1Q8OWoYp9wXZso1pjNTmmwsU6XAkj/OMKlhTDejNOxqVvhnH51W44iZTKKsjuZUjqwHt+42rhqhNQwUJBU4pmDF/Dokry6FN1hlyDr2792t+jETXOEtOxpCanjulm5tUO5+v
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/a+haENCCDBMuTraF4ogMy2J/ajO/Bnlz7ylWOPG05FHyQ4RC/Gmhk7EgPl2sYZphxM8spjhqDbPTeWcnf39LSoG066ZF1NOsddSZ3+TkDAxlrm//cqvg75EuAYsomedSheXOAcvqYPNjNruif9nirTe7vOBVvKqv0D0rUbdeJfF/rfZbYseJKmct/iLsl4BYSD6Ud+5ZRkFKsNTA14C66iGgIZAwuOpxTUCrzQV0MTa2uof8BfjFFWYzxRTiya2lzxE5SBrb4I4B+JDM/8JCtGHSPG+/HuPG0QUit0lICdjxQffFolgRVHQsmcPQIovO6irocOpH0c1C/kt5VIO0xmjBuAWBju7jwpmkzYvtVzzdk9EEFpD3nW9measkl+utKLIg1Tkgu5MzaNfrdWb4Rz/6Z/9ZVKXngGtZ0YV3a1smUzaBN4qQAIhf4EyxPlgeYJ7dXtZRKleWgWPl78oL1bjPQoDcL9BDtrN80nJxVApyw5iFd87+wMdNMqn8ysIgu42DsidqAf9Tf6Achd+OakJWi+3eakywBXiNZk1NSAgODY+Hs5erxRLHQga4W3UL4esabmGqBamZeE6olaNIuJ/EUWPFu/MBmFiJ3Uu0MnX2RCf1IhhEVxefvU4WJg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ql/9/ExiOnJi/rHIwQzugviptjvFLT12OQVINEi9/ZB1VvKzlN3VkOCA3RB?=
 =?us-ascii?Q?OLVSN1w7v0u5owHSO/BOew8njwcOto6vVBfrrnhkoclWyPolScCHYWo48K3u?=
 =?us-ascii?Q?eO07S9X9KZVD0FKXMnk/N28FGxCLNLGrLavP1Gh3b3bNli9piDtMID5d3oFo?=
 =?us-ascii?Q?z1ddnNY9khNIfg4t49hgbNwdnEqZUEQqivjRsXbdmdlQrR7fp2yLZfAisNnA?=
 =?us-ascii?Q?GpuPb7KZkrmgm/H2B+9u8pHJScgr6tYalmz0s8ydUqwIcA4rLR/PUgimLJPX?=
 =?us-ascii?Q?W9X2nbgEZ1+6ai5ALk/4RTzDmZPECaHbcn4QIsGkpkdIQrI7TQAkGjMJ5Djz?=
 =?us-ascii?Q?LSxlwo+aj83ntRx33b1LJbzjX5698fKe82O5r0bvsaallnNrKgxlEWPiLco8?=
 =?us-ascii?Q?79Wz48a9q6qSIfQaJtl5i7LX+42pW8wvjm/KKKThCLk2A80KQJaRKgN5h4Z9?=
 =?us-ascii?Q?TnOvjXPu9SNAw4jz6KOkOQx+BRt2bGroPlcD48nA/OyMEAMdD23PbuRJx1j1?=
 =?us-ascii?Q?K7pMlynvMXGsLcB9nlL7pwmhqc48OE/ZWuLFaJvIA5yrgaHGVHy5HznQfbsF?=
 =?us-ascii?Q?0klfGiBpYnpV0gmElwg1uONM98kAw18X4UO5yfn2TZMWAL5tZ7ObG3zEML8L?=
 =?us-ascii?Q?xWsnFP3acvS1cd2vkbylw5/tfyTgrEX2C0jwDmJnQ2sktuNOgemd1lzT6gJy?=
 =?us-ascii?Q?ZEe2JVVkp7+66/wMgvlSzeS+LxRL+hdp62MrP5yumNV6hzCVC7/BMlcYCSpQ?=
 =?us-ascii?Q?M2BhNoezTmpG7yvspvmETlrLEZw6dMXl9KCD9XaNpsSYAkmLTko8tlgstFu+?=
 =?us-ascii?Q?CP9XZHHj0IVeu7xygopB/Qeq45dbRtD+qP5a4CCR6wjZAvjWTtp6+ky1xE/y?=
 =?us-ascii?Q?kPBFoZ4Cbm25LJEfX/Lgks6oHVt0A1nXKcp4EozpQUzvRA26ETy7Veh8TAWC?=
 =?us-ascii?Q?YJ0P24tezV6iAOVINeMOyultxJs8eOcQ5W9dDPg2proOdjqZ/QD+w8tZO1hQ?=
 =?us-ascii?Q?hOI9Va0I+gLvUBKCiGqbpSkKp1+z7Mwn8sWudV9DgIjMkHEnu54GUxWTh9iR?=
 =?us-ascii?Q?PmGJDNe4URfRmEXoRHxlRXpn5QGPuUAxKBLAKNd6xX+by9hYqOl4XMjyYc64?=
 =?us-ascii?Q?eaN9toCchoGA+u6lbxed0rxM9Zl3yF20SbhmE5xxHGI1eOXmczkbQAbNjBJ+?=
 =?us-ascii?Q?DNROjrhX2wz83wAy3Mvm6v5fgqp6VM5SXAuOAQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5ebee8-68e9-4a9f-6105-08db37730119
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 14:18:48.5444
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

