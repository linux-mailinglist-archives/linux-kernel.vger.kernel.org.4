Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA704747D78
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjGEGur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjGEGu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:50:28 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2112.outbound.protection.outlook.com [40.107.255.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4885F19A8;
        Tue,  4 Jul 2023 23:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCNPrWJ40aYDOJMD9npyNN0AZ6vzAq9BtRe0ws+7pcSVrqLuLvcRYLgLFDMipQF6TfGDMg6WPHLwraM9SDnpsYCpLgQu5djOxWvrJ5E0GmjPUd/VulTgPgQl1o/EFCFXdN57iqp7jwz6WJ3TzcYXqvfhD0zwdOq/v3s/Eg4VCHm8o5Og/nBKmmf7YD8p5stDHxhAWLpgLpjx+DOnv2hRnGPNNew8bvoaUqv+Nm7CfkGVumjdqZyzIC9W90FYIT+nNyYKyPjQeQCtgD5V1Bg61Ut12Y/cHDmOEUhlO41L8p0W8KaTsuQ5RhjxbDARKaRmohBxLnKgJVWu8UK3oRe1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXDH/6DTTLo+zICPLM6Nl+bZVNQETElZNZDf8Bxr/Dw=;
 b=gODN2CbTRhB710sTjGrEnPfjTZeXfeeA0hO/FicRbbFcrRE4rDz2wzyRjK6fpwDczHBgddJD8Db5h3rgHYH5/zMiTbkNZGAflQbYkiJ10R87mMGf849NtxJmRn/TAuMGX4jbuxEhi4kdzQHL7yPK2N/iYgkkPTJaCzngVw4MnFLyYjgYVmLGjXKcttVe3xIU1DFJwpHzm8jBfVGqhWSvmQajMZC3dyzCsLa9rsHaevtEycdpL5VhZhtGZEfPPlHJ4R21UhDBAeQX0Z41i3dL7r5IRgi586yPIFvqD7sPGqNkvnVzxC2rI0fO2o3ldBda/9DVqDB6yuVIKXNHGHhJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXDH/6DTTLo+zICPLM6Nl+bZVNQETElZNZDf8Bxr/Dw=;
 b=oW11tY4c5teWA0DKK835G+jRTHcVGydJipibsXwLdMMi/zu+cGd3b4Gkmc4S41yBnG7FmzDLSj2j+hIMoMQnxSTw+oOYeoSnfU3/RFMxgChNPB1LlLiR/rFUdIRwZWpATDO4Vi4m1uU6mE0i/KtrdED3105xHgAMtwjafpstVjCWP6gBNj84jVgBpeRjsXxlDWabvnEZjwQ8lrj3UbaDd2q5dLD01PuJpd5Wo78ubkM97ATp7zTT5BsQhUqnyZA9IYWo0ku03YSJ/raliAbX6+Eg6rL/EP1MGp1nZ+kplLSEPWUqqafbgWRBbo2C2VTJE10DyBCOwuy0KCTzyWAw4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4140.apcprd06.prod.outlook.com (2603:1096:4:f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:49:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:49:32 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     hverkuil@xs4all.nl, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Minjie Du <duminjie@vivo.com>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] drivers: saa7164: remove duplicate assignments
Date:   Wed,  5 Jul 2023 14:49:22 +0800
Message-Id: <20230705064922.10165-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0004.jpnprd01.prod.outlook.com (2603:1096:405::16)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bde4747-ba8e-4b48-0f30-08db7d23fceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+3XbwQAPe8BDdFzMqGjsx6/ID/EWmC5f+9xMyuigyAUkRmQCrcuuwTEZ6xRY4aNOOINIp3yqcZhA1CmNyl7QzfVwBM3B6jONYsohT/9apV+KyF0pHezk5lg0ngGt5tLeSj0gW7P0LGJdExn6YX1KC7bu+todAzQiYbUzUAty2yOGN1pFS52Mw4qSydSKzqwhUlYjw3x8VMDOgCuwpFrI+PJM83efDEBan3Pd6O3vYXobNiOiVIam1ZeHIzyoEQ7c/CMdDppynB/Y/SULJqLt3bElFj+xXJ5n7j3JWM1lC377f9uWHrUiiHKA4PP6b60GYTpp1cs0ecuLUUQ3oU6f/5i/BsTXmo0BPZQVyB4HtNs5zl0ZSkhsecn/a5JDQaNt/Eh3c7nLgeU8s6jvcJEDFciQ9GKD8Q7+feBmfizDMwJDL2X1cc30qs+IF4IpNRzgmwWhLIjhdgqkqOgetlayD35DhA6aoGe+2NzEsX1AyMxzto767lBsmL9dK0ksniFLM43Vxw9ufUfLRyDz1PiRe0u8FJhszfHIzPIKkiRg2IP+PNF1BgGJ+IYX3k3Q+7xeL0qxGlhpjo0qlcmmbNsjG3KkQK0LNruNEFI4yG5e1LqoJAc4MxwADXnCaBbXnp5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(41300700001)(8936002)(8676002)(110136005)(36756003)(6486002)(4744005)(316002)(5660300002)(2906002)(66476007)(4326008)(66556008)(52116002)(6666004)(478600001)(6512007)(38100700002)(107886003)(38350700002)(186003)(86362001)(66946007)(2616005)(83380400001)(6506007)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qpjr65LW1rnFAdw6dQzbhM1/WDWT8QVkz99NBXPwzEqHSsZvf5UZEvHBoyD5?=
 =?us-ascii?Q?PJlml9aqJF5Jr1yLNwctRhCq42rudkgW7pRxx1zTCPI3QSYTCNgcKQHVYLWQ?=
 =?us-ascii?Q?HJo3wK0b6iE0sFYt3DM8sF4VWAbJWKplHUxet6ZfZSvsdJ2QsUK0RPs20RS/?=
 =?us-ascii?Q?AEnK/FRX9kBDjLfoQ6zRj7zdRdG/fLXfCHgHFbdOH/3hmI7NthDBIQ3vUlp4?=
 =?us-ascii?Q?SefnotHf+0IL8QlZJSdAVrbXng8N2UN66l+TSH0ti2IvZrMP8AfZ7JtN/haO?=
 =?us-ascii?Q?sQ97MK3Qv+GdLkdQuT2yAWlA3Q+DS1JI0wn2ysVmfbvKuhE2dzCb5JcDtWdy?=
 =?us-ascii?Q?byABhs3U/jtqvFVKolBGEw2eChforlCoUL1VmCKWMDc9NSr2XEFy/B0ZhHJ3?=
 =?us-ascii?Q?oeuI1wLKEuME4scbI4mZr5qoxTMS3BqnGnsANf6oogZv+zIvGEuj0QLUbFbp?=
 =?us-ascii?Q?ABYFnAajj3QL/FreT8klByR7yfjQ7q0s1sMVytZjeDhARZ24OuhEiGeLPPYM?=
 =?us-ascii?Q?+PouCwRjEQVo9s54dIIrA/aZu/9YMf52s5w4ZsZXZgaamEdFzrlSV9/hrd+9?=
 =?us-ascii?Q?89mmz3UIQRhZnqZN8CYhRB7stPIOSbYic91al2O9Kl1xcI1WWiQVLdHpTY/T?=
 =?us-ascii?Q?MdFicb8Hle77DkNAWEjzb7zi1nIrjjDPSj9qiZXjkI71eA5ddL5rmjCkndSF?=
 =?us-ascii?Q?dbw1K+fA3KiJ7Ro/oMO09O0Qj/012aMG8AKOYD/KnfLqZkli6x3V6x2TLYX4?=
 =?us-ascii?Q?QPKaB9bjRm2Wl4H5mINel21FI4Vd4e6gxlTv8YbzvfRKscKMW0Ra/kI1FB7x?=
 =?us-ascii?Q?kiG3FHmJGJLlFl6yhai49w4FOW/NnBHbTL7URXjnMTOCdoOjGisFjEOmc3D/?=
 =?us-ascii?Q?Zj5g9SVZ11sREhnR/GJRhOUpuQ14frKErwc14/R0IVYwZMj8jP679tN5wh0f?=
 =?us-ascii?Q?Ir7Cn8Ka/bQOf4qIgZF0jHY5sjwuyQBr9bMYbKHIv13DT3LxDQ3gHUr9uURC?=
 =?us-ascii?Q?ENUf0QOhZ/L+Vpb5gmmqwOdf0289v1Ny8Cbg44lYxLu8Aif+YvOl5TEcqTmb?=
 =?us-ascii?Q?VrNJdC1xO3hKRXgXRtSNg7XKOtpzj5oBjzGufdA7O00NhjoxPMZPpVyTb3CL?=
 =?us-ascii?Q?5QoqWnf2csO27d1BEr5ZxJ3vapHm4SMXZJe22WoI+j0ut+dUWtVVuHzT6jEl?=
 =?us-ascii?Q?E9MrsXQ2iu8/mNf9874H9v31rDvltbfNfqZBVHteh7F+BZDaGGrSBMN+mO6x?=
 =?us-ascii?Q?r1joI6W0RhAz3TTMo7P/6OPO5s+SZw9+o5r9muSKaZsVcBR807TN9eZMLU0y?=
 =?us-ascii?Q?7h5pwgzsakDWkzI7AIYC72EDfDcw+/ifHwAEQspSDodKCQRmT6OXzTz1zOdh?=
 =?us-ascii?Q?oS/loYQ/FjSUpidHybcWzs5SZcH32OiMWoqRL+vD482wppAeLYd266V91ZLD?=
 =?us-ascii?Q?YTZzToYUIQCjajX/9cOFusY2BX67aLUb4cCPUtySQU/Z44WQtx8SafnO0TPE?=
 =?us-ascii?Q?PlZwylKgc8o2VkN1krx68dG/iodqqMm40d3DERZU1M/feAvaWpgNHbUesAlF?=
 =?us-ascii?Q?uxnyBszW/Pttzsw1MJb5aLLza/O1DhHs+JWh586R?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bde4747-ba8e-4b48-0f30-08db7d23fceb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:49:32.5946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCfEBaZRR7yJOOK+6xp+ELSRtn8D70zhVin0CGPJftrhKGMFEZkitu4YyQZC7LRosED/ELBEr6WbVWhNtpcVyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make second_timeout avoid double assignment.
Thank you for your reply.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/media/pci/saa7164/saa7164-fw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/pci/saa7164/saa7164-fw.c b/drivers/media/pci/saa7164/saa7164-fw.c
index 363689484..cc9f384f7 100644
--- a/drivers/media/pci/saa7164/saa7164-fw.c
+++ b/drivers/media/pci/saa7164/saa7164-fw.c
@@ -271,7 +271,6 @@ int saa7164_downloadfirmware(struct saa7164_dev *dev)
 			dprintk(DBGLVL_FW, "%s() Loader 1 has loaded.\n",
 				__func__);
 			first_timeout = SAA_DEVICE_TIMEOUT;
-			second_timeout = 60 * SAA_DEVICE_TIMEOUT;
 			second_timeout = 100;
 
 			err_flags = saa7164_readl(SAA_SECONDSTAGEERROR_FLAGS);
-- 
2.39.0

