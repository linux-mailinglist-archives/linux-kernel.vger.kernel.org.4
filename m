Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8526EDBF2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 08:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjDYG5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 02:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjDYG5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 02:57:52 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2118.outbound.protection.outlook.com [40.107.237.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF5C5FF0;
        Mon, 24 Apr 2023 23:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSUASM5b6xMYiyQa3a1GyIs+JCgiE1VGtOor1Nexcfio8wKogvY4IvAdppwNdZSKLbO+Iyb4RbUeH6GPasaMwkJRwuYW2jRV1W5iNcyy+Sxi2961F9M4w1KrC373WFPf23azCjp9vengH/R+EBsGy1s0oxOFU/dLf2m1s3FyM5kW9T7WhQGhRtrrthegsBioIVs67cl6lJWEDQb48TVkWDnIovuTG7/YhdwHJjHKEb00JWCecq8TzC4hbRaMMypOhhPy9FsMNPsO/PQAxcczHHeEF7xWPzZ2sROqREo+LAW9Es9s/tfgmMjVScDdanzYJTR47TvY2Uj070fTeIrPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keUbAcwF29f4HAM3DmTCmtzHaeTx2dlgEj668aY+vP0=;
 b=LcFNTF27R0RCXl67SgUt2ViEj+vHw7i9wzO7QDaBvStLybcs8zOjM3dm24Ia7qrmf2xJuIpsg3nyfOl8hAMW2EE1ksrjcgQZjXlyKaqjg/mEICP8qXgkkzMYY8yLVKwrG0AttylZeTS8bq0QkLfGGL8VVZD48tm28bQs7qPTeNsUv/o7ezG314mLc4qCTWQXlRcmYrIaFsI33KOtq1Z+sjUcUjpyQsIJWfNA81VtkmnxglvIVR6NM/JdU6IqbRpsdK3wiMXR5cnn7a1B/5zTkxewd+FVLb95PsyB3WRDv/vNKCAsz8G1TC3RBLzdSfH75oouMG6jL8daD61kbve3vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keUbAcwF29f4HAM3DmTCmtzHaeTx2dlgEj668aY+vP0=;
 b=hzMiCP0MuDRHAfqBRNBQmE8VJpRawBDewjAgrvtHBdeFxhk1A0XVoFK3YEqzFESDrxn820bo8PdQlBJI+8qyqT5FAX8HSaB+JSe3VUkd3YWFEIDYrE1gJcq46HBNbcwUJCQz6IWC93hqZvmkHg168M6Q9DUUH//nzbk460fc6M8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB4966.prod.exchangelabs.com (2603:10b6:a03:7e::28) by
 PH0PR01MB6504.prod.exchangelabs.com (2603:10b6:510:b::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.19; Tue, 25 Apr 2023 06:57:46 +0000
Received: from BYAPR01MB4966.prod.exchangelabs.com
 ([fe80::46c3:3b44:d2f8:4c3]) by BYAPR01MB4966.prod.exchangelabs.com
 ([fe80::46c3:3b44:d2f8:4c3%4]) with mapi id 15.20.6340.019; Tue, 25 Apr 2023
 06:57:46 +0000
From:   Chanh Nguyen <chanh@os.amperecomputing.com>
To:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Chanh Nguyen <chanh@os.amperecomputing.com>
Subject: [PATCH 0/4] Update the device tree for Ampere's Mt.Mitchell BMC
Date:   Tue, 25 Apr 2023 13:57:11 +0700
Message-Id: <20230425065715.21871-1-chanh@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:54::15) To BYAPR01MB4966.prod.exchangelabs.com
 (2603:10b6:a03:7e::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB4966:EE_|PH0PR01MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 11081635-8318-4473-5bd4-08db455a5f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeIe8V+EEgXfrLR4/TcyvUm5HjQWgdfTkwQm2sfn8BVYKkjDLX2TA2tUEvyYHPm420I08nH63s6sFNabOBSa+gAzsGIN3WbI+UNmeQV8h/rTJrvhebkAeqaV1hP4foNcI/H9iK3nC9hujC+gYaRcfR4kiIe3iibm3dY0tO9J1heYMk+oUtVRNtUgVvqcdG1h2gma37wO4j/EMAHwUONGJXVxAXjTH0MZWnLPUP96EvJqho0bJzn/i/DL/GbvFH58MyygBei4eZfEYoXCKd1To946n0XUn9q4M3bbEEGR3r204Btpth8yOCi+WWpfV4S2r0Fn6YjdS7kzc/qsmByo82u2knA+e7sQfjR1YH0nbdpLCEoLKHsgK9iAUSnYD1DTuw1/imDBulX9IgGT7ZxC1MMFZuyCvoBIbvM2N+oRCvWs4glmKkAtjNyk1qezRtGyaoTBUJO93BJjvnDo+YwvYewx5Lsn8mD+gT3U1cOVDl+O+GItOTRrY3k/JbomxU+e+TZyUydvOHAhi3YfbZQupGdaHKmk6OK+NPqam0IGKX5cB8fc1DOiZl/yEUrmzxePO6Rt+1kbvIDMoGL2YUeTATUE7DCssmozO/sNe0I2zLaqPM077OdA2LRrUdG0z2fS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4966.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39850400004)(376002)(136003)(451199021)(107886003)(6506007)(1076003)(26005)(6512007)(2616005)(83380400001)(186003)(38350700002)(38100700002)(66946007)(478600001)(86362001)(15650500001)(66556008)(66476007)(8676002)(8936002)(110136005)(5660300002)(52116002)(6486002)(41300700001)(2906002)(4744005)(4326008)(6666004)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BT4ZOk9KAGSI5nhtaopByzhDjPqS2dedREmoF9o556mLYtp9DGhxOXkRNjjZ?=
 =?us-ascii?Q?CunRb/WfPDL4IBMQI0rqzoI4lxhVFfEiFoPhbUhmV8Dv180+Qo8HZCmZLOZ1?=
 =?us-ascii?Q?T6+QH7P7WAzClUxFjeKMW3yLEFMDM29o6ybqYSA329QHc67XEXPktcb41p1j?=
 =?us-ascii?Q?pAqjUUN9lDsRvTqpfI6ROcPk2TwmtUZX7kwKDmMZTZn1/wPNGS3zxzcExl8P?=
 =?us-ascii?Q?uIrDoJ8CdweqRYKD3rmYqtolfeuMnygIJNK6MACUx5EoIz8Y9kdJaV0vE3tt?=
 =?us-ascii?Q?gjBoxITDR0t3g/NKz8ITkQdjfpqSlRzgx9SOOB8LZ/7dbsfDkTFYy/Z6eo6j?=
 =?us-ascii?Q?VrXoivgYViTieqKhGilPulBscRnj8DuRdhNqKCljA2EjnNxF3puy77EQ05iq?=
 =?us-ascii?Q?G9ULMXbs8xj/6D8wj7Q3Nas4CAvjfWYrLvgzcN7NTykObqvocaJj0LxoTwEM?=
 =?us-ascii?Q?LCcpaJPB1UCnBVnz0TQwDomf1rkto3dKUu0LW6oWsGR4oiKbDztQ+ClB2Fa8?=
 =?us-ascii?Q?Na5ouZPRfJfNIG3cxDciHHJUwkfbakRIKqpGZ4gSXA0paJf2Jd7H8LrYI2Fn?=
 =?us-ascii?Q?TFiFrUex9/FwMY8+MoVUipNC0udrWW4GYt+czP/LeGedeITPloShq8wm5J89?=
 =?us-ascii?Q?V2LU1770UjtCt2GZjzyDyb96H4y2gpWTrKY86wTpvuWQPx/ZzbTPVSV08mSn?=
 =?us-ascii?Q?FvK7N85ZqVg94Bp3cr68gWlwqnIqTnuebHerfw4d/TOHYxYjJRXhI9EDdELQ?=
 =?us-ascii?Q?+GdqMYpeBrTyt2hmZ0YAzCkZjYS8ZDkb8rTqANCGEmXx4cMkdP/+qKVZcyxw?=
 =?us-ascii?Q?Fi4pydfeTVgd6LBTEApLhbr6Rl/Lm8Nf2dJQMeG1rC3Mlh2Z/mikq+16r3PY?=
 =?us-ascii?Q?ZuoSyjmHoHCjZ21+d88kQ7Qv3d789K8csDYcU0WynIB34w81tibXPFZfXhB9?=
 =?us-ascii?Q?pSiuainxdNAq57JYYTI44/sASxwxX8Cf5jhXY76b3e5gv4CFhXWaTh1V9eQG?=
 =?us-ascii?Q?0sH7CKomEpJ77WIrCv0MDupK8bYVm9upy3nliQJFLhZKP1IqVZPqL3bPB8Sq?=
 =?us-ascii?Q?acwrXRpBwlGoP4+OCHgt97LuZ+XbK7BdeVOcdjdN33SpxbFOy9VdPR5NEnkN?=
 =?us-ascii?Q?OYE0smiF0cGIxLYpomVzehFiVGVKsDaYAVA7Ep+eicwuH+6EYIikk0DBMPXv?=
 =?us-ascii?Q?0F3br8OnftN62wUhzgpHEu5cO8tgTocBMx83pGWtjFAfiHwaYwBPTgr/XQF1?=
 =?us-ascii?Q?hN7UrnoIoiMkKh43hC34hfyL9DI92Zu6HHYBP1R6gz3MY8rsJn7pnkELzpVc?=
 =?us-ascii?Q?sANRcOMAXTG1QExEnWxkx6yojqjoi6yzN28T5LSxoHQ2Q+aA5FPRiv/Kq15j?=
 =?us-ascii?Q?LwPnkIJ1JVazxm3roNiPz5xB54bikH0eij2W9oFr7ienItISLLsL2+vvpgST?=
 =?us-ascii?Q?wOv/NLQUOjpJyTD3JQDPjdwGzj8yf+kGnX9zUqTiNIOEVQ1Bb3K5B0ZF/GNU?=
 =?us-ascii?Q?PA9yf7Oc1QAmfstSy4F6PIQGKmjfoniFPOM7eL6gd9wvHUNVqJlNNrjKVOKI?=
 =?us-ascii?Q?CR4acpFtu22DCS+4ZPElsEjUz1ShGxAyQ4X/B1Fr/qhHv7ArgFxpjZ00Dx46?=
 =?us-ascii?Q?6D6cyZHaA1WddEY6FDAHaJk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11081635-8318-4473-5bd4-08db455a5f76
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4966.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 06:57:45.8380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6Fy91Sy6PHKKCRkiOFznjDOQl7yyvOdzgQX0tCY8PuDmtjB97gfzOof3n4O18GpTTC+oL9XmDEDIU53HpmMUKWRiNMbv9kDEJ02lI6EgAxQNyvQ6GJpdkHAxv/Ie1pc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6504
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the device tree to support some features on Ampere's
Mt.Mitchell BMC.

Chanh Nguyen (4):
  ARM: dts: aspeed: mtmitchell: Enable the BMC UART8 and UART9
  ARM: dts: aspeed: mtmitchell: Add I2C Fan
  ARM: dts: aspeed: mtmitchell: Update ADC sensors for Mt.Mitchell DVT
    systems
  ARM: dts: aspeed: mtmitchell: Add MCTP

 .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 138 ++++++++++++------
 1 file changed, 97 insertions(+), 41 deletions(-)

-- 
2.17.1

