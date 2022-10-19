Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F457603B55
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJSIVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiJSIVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:21:39 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70103.outbound.protection.outlook.com [40.107.7.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EA77C312;
        Wed, 19 Oct 2022 01:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrQKAA7C34Z5l2mafIlP3tXbVcFK8sk0F0XbXvp9gfr6rxlNwnPv1HNxyLb8lBmQfzFH07CFDJt3SKtxp2s9ngn4nGWt5VfdWCCwsi0lOP4WRD5ltwx1xnk/HAoQjKvPxqQNato5AwVVGKGi+gOvqhNjvSC6keuD/rEEgOYdw2Tfvh1XOUToYU/D2GTHAW8wkYMrIr0knAQb30nOL6ukUwI0OW96lc2oF6RwX/o5N5pmqzyBwZ0xn6vxFZMQqW7ZKH1Aki6L7ivooCQ5zCa7qCKn/p/X6EscFiYGH/qc+9Jj9KI4fkDxczLorplolne1hvTAj3zpbD6/BHGwx8noYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5gcxKw6kBAuTeYhNYKLE28PJ9Ultt1mYbnBswebW0g=;
 b=mXBh1bz5m/UzHT5wyoHHwMLqVXDuRIlsn7hgmZbJ/fkMxFZdEW+/yf7hm0fpKgpDEbp6YKrVBC8UGx3Y4vjW5n1LRBUwYD08ppLA33L7F9We8DOX5IoQN5wGgQaIAIRmhaO9wBS3TDE7ySdGHxTC614UpptAt2j8wOcZF/6TOdA/wInVeT0pyEfP2G/avC+CJYZ1a1IHOCVl/HPFy2kW/24eFxgWZKV9Z0lWCTqwbkg9Rcszn57KfKufI04VaQjsld7T1EK6IBlu+dQ+VqSDKLozPr7TczZqubCP6EJzdD8w1RTR6ZDqXAle4PEyXEEcK6LpLvYfFcM5/yaed88llg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5gcxKw6kBAuTeYhNYKLE28PJ9Ultt1mYbnBswebW0g=;
 b=wjkjNkMb9BIuGMYfL+6CqJNVY2TP5FStOPFy6tTfZNmRH9CDPuTwBEZ39sGbM+1Uquw5P0Cgnu9zplWZjk3UGvXCK3xlnpCwGAF+Xwh+zE2VsEfZtONJA+jegYHB1SyfrWUkPKzBPA643YDPzaWZDyVm64q2+w9+R+cZpkjHego=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DU0P190MB1930.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 08:21:35 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 08:21:35 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Aviram Dali <aviramd@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/3] mtd: rawnand: marvell: add support for AC5 SoC
Date:   Wed, 19 Oct 2022 11:20:37 +0300
Message-Id: <20221019082046.30160-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::7) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|DU0P190MB1930:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c8d59a-0afc-4cb3-f805-08dab1aaefa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KeIneszRI9n76lYuTXYN4V0DtPP9DKDDWASTb1ws0x4UtNDXKC5EnfCruDKPx/+UHQeOKTm9Vk4g0bO+E58GL0yk0/UX/Xc1NKlwvCB/jc27n+obrlLS1A/+ynF8jN00SAyen8bMHqAqmw9nAHtAeK4Xv2kXAn4ic8eAeRnznpdtH34F1ZEj7YCIavE+rDEVpZSBarLCoRFIJHUqavoDgNyx9cT62QXIbSRjpkkhPPARwwpG6q28tgIzvOjHgU4s780f1J73Tnj805bevuvF2Z/fp0pz54ymjAR/81OYycSeUyN76R+o5PobPrlqC6HBlaKYUF35BHxhrwRk74CDzrBLU4H1t1FvIcxSar60EyFFz0ediRVTRaUfguWRRBthUQFVmIkgLQbM3pD1Hw9d24TenPdPqVE1bpMlgbxtk/CxnzRSMmMcngapUZ9uK/dfBjl2LGqejXgD6D7G7o0S9b/BYoSTgQuC+n/HCoSDu3ud12yAN7B8cS83w0U9/6hQqAXyZKHKtg1K03ul8gvSxK1GowKKQkih1bvAc/evT+XQg2cJ8ZtZYK5sfxOCLXsJNM5P4LHwFro7DtXtaIJbF8SynTVWFU7EbhSlc8qhk7C8oG8botb97N37P3mATJ7w1SagB6X70YY3+0ico5F4UWrphfRzPWM24mnd9wXf6ILEhzZS5lN1hAy1QT48Ln+Dm7Q22CVl8Jy3j1iffrbkOyF1g8EWdoPLI1PUtRWQkPF/5yXpjOenbiGUKpEbC3F/jl34MDK8h16yUh/P6HbT/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39830400003)(366004)(136003)(346002)(34036004)(451199015)(186003)(2616005)(26005)(6512007)(6506007)(1076003)(52116002)(83380400001)(7416002)(2906002)(5660300002)(44832011)(41320700001)(41300700001)(110136005)(6486002)(316002)(508600001)(8936002)(66556008)(54906003)(4326008)(66476007)(66946007)(8676002)(36756003)(86362001)(921005)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LOMD+suXqI6TtLUAfK52LV3JJgZRzPgftoNHgfGp9+6nDeI2u0O2p/n21mZf?=
 =?us-ascii?Q?hLvEbg5Q8gF/tJ2vMBp+ROqSWGvWId6jI7MJNxQWn+qn/P5gpm6z5V5COGsg?=
 =?us-ascii?Q?XSjFBFQqn50eNvHTPDm75iNpMpi8R8r2hoOv89DIa8HChW+j/HH+DhmvBUWk?=
 =?us-ascii?Q?cXDhrkDSdBgiaYAdO9iatEL9ErIFnJ0v1U95/dhbmb2BWe2PZnXeQYGnba9S?=
 =?us-ascii?Q?4Iv13HLCnMUgep6FEjDDusHA4rR31tdr+ETLvzaZ2hQZfUHnLc6uS3yHo/z6?=
 =?us-ascii?Q?e+3/u/OcF9iNpbuGF5zM7lHgM/6VmSBpaDdYZfZHPiSvglWVqibxf7cS+31t?=
 =?us-ascii?Q?NO0+LnCtlVsm6oR8x12y307a9NR6FiqZdECiTJl8x7lEvKRkvPAxuIt61AxJ?=
 =?us-ascii?Q?bVB9pYhTjun01O7zP3cyV94ZXcSMZ4DgiFijAa24bG0+xHgCHn6O2ZMNBzmQ?=
 =?us-ascii?Q?aZ/ar8sLw5fdwgCsFYdrY5CG/SlXxYTt9J6NKkyy7gqxBshOLwVtV9/R0fOV?=
 =?us-ascii?Q?6O2103+fq0GwAEMPaOKzSEVDokEkjf2DXVxkRa6rZYeJyWQ/RlOzQAhgt9Oa?=
 =?us-ascii?Q?OPdOXHX4IrFSspN2c71R3FKx5gRjHG8qNOAmDTDPbE6cvh4KFxLqByqxrQdQ?=
 =?us-ascii?Q?8PKLMv7i3nLUYOs/8hNyr5rZkFlsaTueJo1Mxvlm2RP/S5nmqK/DJOWsPslQ?=
 =?us-ascii?Q?HxHDJ4yNIAJ0azLJH79zCp3XvasFRfKSE5B2jBF/hsD/7/hPKFF3sxgQCXjw?=
 =?us-ascii?Q?9rUEZ3gsUqi91YG4oOyyyl7aSYEfPO9OaDc3gLVskaIQC8gXBOvfMceEn2Xr?=
 =?us-ascii?Q?c4IxSF7ORX2CaW14a+4Ay7gqS1mj7mi/SHEtUEcK5dl0dJpTxEP4Us5XwhjO?=
 =?us-ascii?Q?V5Zclu1XRJBJhD581CMs5/2NxWRsvsELTOqbh9lSq3hXEjU1yIE10pZYaGgT?=
 =?us-ascii?Q?iod+bmAkWcfGCe4u0JsWqNrtsNgXn4K9d/QP9SWFs87eEJ9LN9lF0QzMkDUF?=
 =?us-ascii?Q?wpsiJ0aDsNYkmBrFRUsOAQWIHoFLGyIvfsnLgj38c4CmBUx+eLTda2poNrqm?=
 =?us-ascii?Q?caabz7MXug/O1l2tVZSP3M8jieJoQ6yM5XT8TefPW9a5PZlSodeuERvhTdao?=
 =?us-ascii?Q?aa0QejzR8TY/trCyd7/6xRLUYcW1RIjVrbbgc+mW3tIOrXH3SCPGpLQ2wCBt?=
 =?us-ascii?Q?4t9ViLmlQBLDc0vZmrX3vgHZvKWzpYrF71078iWgi6kec7K7/kAJE3GuH0g4?=
 =?us-ascii?Q?oUcisunYjpmDBuwdHqbWsmUEoSgUotgOr2Cw0ler6GPYWhMx3BTyH93mcjhs?=
 =?us-ascii?Q?6NH9MoTrdycmUAC+qEUqC8gZzwV4agtdjTDEWKfZ8SpqaBUFujjI0WtmrwYd?=
 =?us-ascii?Q?8QJ0nSR/tHdEC5Ml332gy4y856Wq7ADtAXyi+3ADfeNRqEMMyYnZQQ67jEDg?=
 =?us-ascii?Q?LLcJ5Ra+OzMyn2fHiDGnWw79IHuM9wAdIGWHdTA9CRFAg7psYaXJGOa1RBiP?=
 =?us-ascii?Q?fG2NULAzA3hDhslfPfpxAAVIne7LmkL3hoDWzeQwIKyuk+WUj/rRcwSLX4pk?=
 =?us-ascii?Q?KNK9Wwt1+FqfYnMy7ZIwQFwfDJ5+YwMCDgL81PlfQRg5c/aL7SU7h0E03+X2?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c8d59a-0afc-4cb3-f805-08dab1aaefa6
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 08:21:35.1475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3TbRP2OcriTYVfBRr+YHtT3bD2dWN+ZT8Danjhsd7+uo8Y+c60MJ90lSFB9vYvXrsPrvw0Dx17SGlqHx3vqyVfIVtQfe7GtEiEC7JfSmuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1930
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for AC5 SoC.

The following changes were made to add AC5 support:

   1) Modify Marvell nand NFC timing set for mode 0

   2) fix validation in AC5 Nand driver for ONFI timings values modes 1 and 3

   3) remove unnecessary nand timing-mode in device tree of ac5.dtsi

   4) add nand missing AC5X layouts , add option to use ndtr predefined values

   5) Zero steps and total fields of ecc in ecc controller initialization so
      nand_scan_tail() will calculate these two fields, otherwise
      NAND initialization will fail with kernel 5.15 and above.

Aviram Dali (2):
  dt-bindings: mtd: Add AC5 specific binding
  mtd: rawnand: marvell: add support for AC5 SoC

Vadym Kochan (1):
  mtd: rawnand: Partially revert 4114f97c41cd ("mtd: rawnand: Get rid of
    a few unused definitions")

 .../devicetree/bindings/mtd/marvell-nand.txt  |   1 +
 drivers/mtd/nand/raw/Kconfig                  |   2 +-
 drivers/mtd/nand/raw/marvell_nand.c           | 277 ++++++++++++++++--
 drivers/mtd/nand/raw/nand_timings.c           |  14 +
 include/linux/mtd/rawnand.h                   |   3 +
 5 files changed, 264 insertions(+), 33 deletions(-)

-- 
2.17.1

