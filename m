Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA5474AE5C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjGGJ4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjGGJzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:55:45 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2138.outbound.protection.outlook.com [40.107.255.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AF11737;
        Fri,  7 Jul 2023 02:55:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMBRh4W9JRb1dIKXUn1Wpe8xW+uBE9dkz4Nl7jNK/lZRS2bvwE4CvYitNxLAxTA/j+hG266u2yRJRspqIUg6af4fWhYOELO5kS9HXJNSukslfeb4vi0+4zGUqueunLGqDjIFECCfCmTJ463+JqalG1j/2w7Z9r1cypYPxWCUkY3eS3wWpCu1GNONuSyZwbJW8ISLaGPk/w7ILELs04RRL2EgcVUG+cZAuYj38BhDSI5HVHZ+RjxYWTF9x78OYS99vcPea1kfsTUpOYN3J2GqVmbG3DTh1HNgQLPOpqZlB/u8+SIs66Yh5sADd/HkIiUb1yJAyYgcuPj+icnlcjd7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7rKm46yghVwpIKxFNuMC7ELvRRDG4mgU1qxb7VStsU=;
 b=aRRGP2YUIJ9PVap8PGY3yYu/m2JNhCRTwWpZLrJEMwfRqzxhMxSAEf2aWuTyhzql53Jp5ZPM8wKtJFEcLXFMMWaB1fPESjK9wucNoIn3VarwtBLj7wfsSVtYsE3AD8h/stoLoYRUfGGipESc7WYk1xw8hSNbLqGU0EGlz8UND6huOe7Z3IUASJ7V4EzhREMCszCyRmVEbBKEIomt0KfULJ74hlkhqnMtw7KjwDNuRhgK6/KxQlkh4Hi3E7OhWeSRbhbOYNY5GrnNzGXzW7SdtsHCtfosAKYC92fZjqW/WTlOEbPoIgW5bZxhsb6iBYvXMHjZXW3e8ujYOwUFAUIuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7rKm46yghVwpIKxFNuMC7ELvRRDG4mgU1qxb7VStsU=;
 b=fWPFREtV/avYeOujq8v6Bxd4xMQuqdos29OGsfD2mNhje5ZaAGwJMhyzT6IddPXE3tIdyMoiyDbZCHkbOHByXk95LnuBb5S1Rvu0nkfVGdl/cn+/uTwr/+1AZlLbbIApg1n2ms41GWJTwGv9eB/qgGVHMBDen/p7Hh04ZTxWGyLwamr0qJsQ0b9+2TruvCdzp74BbxJ1XPSUJKZzfAjE5S3R5HdcLkhAER7YcfCjRnC5p0NGKiJ2WIoftarjyqrcXAHRVCfE/ogPHWSJzZaowhx9L6CIGhjaU2yqP2SJAHkdSKLsfnJKODbJNZX8mHNQ5+RVvR2fJEKmhlcIoLPZMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4356.apcprd06.prod.outlook.com (2603:1096:820:6d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 09:55:41 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 09:55:41 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] ata: pata_ixp4xx: Remove unnecessary return value check
Date:   Fri,  7 Jul 2023 17:55:11 +0800
Message-Id: <20230707095513.64224-9-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707095513.64224-1-frank.li@vivo.com>
References: <20230707095513.64224-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: dda7866d-2020-4390-a93d-08db7ed052b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNPexBnss4qSZyy8LtheV9mBMY+ZgVk/Sufxp0YM+OEuoQNq9BpSZ2NwEmQaSkRwt0fprObc/bfWbMqT53e6c7VxmPfSXsHxa7+DTL2jRv1os/3oAfm8AaDKsEAvefUgfdSYBaeDt1g9aBnAUhe7Q80b8ZCn4pfaziYnG9BO4jwZ8IA8CdhK5KRfGAwFOWH/I5su7AP5Pij1qFCRTZ/P9/YQiA33cm9+T4gNsFI26jDYmxq1cve1fIfAFzQctlfTQcaimWnoMpzJSXVwFHSXVAaKY7sgnoAZxDozEYGwGMn66H4QwLXmGHy0iZq7YuuVwXEKMY5G77EjZF/Dcwwac8U0t9F1iA3ID33vjpRZeN88YVThytOzHNdF/I2ZSwQ4JwLhXevcyX7ehpdJTHrQuX/fffJ9Q/4e8MetBDELxozCjQEphytgOKoAjO/RLUdqXGWXNssL/wCvLvh0BCRhHrvgwOtD57IM0KK6J6MzQptPBaPrhl1bMtX+M/+JTJY5mc8GI9XHc6s8qcDaPjJ0fAhhuVRIgOjU80g5hw0zDapQ0uarAI+9uKIWjQ+ko4H41RnBXGBpIzEvPee3qpazqyhTxtniq8uIDvO2E/7gBJXO8a2udpD+Ve/Jzqx9HxD0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(38350700002)(38100700002)(2616005)(186003)(6506007)(26005)(4744005)(41300700001)(8936002)(5660300002)(66476007)(6486002)(2906002)(52116002)(36756003)(86362001)(110136005)(316002)(66946007)(1076003)(6666004)(6512007)(478600001)(83380400001)(66556008)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nOlgNHpx6RXlzbRFogWoqtnvCRcbh7ahArk222xH4Dq5ZFwK4ezGXct1951h?=
 =?us-ascii?Q?86DzikLbAsLYTYOGuRenyQNWxbn9EuK5BwAqQ5BBkxqdSIND3IA64DWlNXq6?=
 =?us-ascii?Q?jIfgFxdd3CJ43n5CKSeQUjlSiDFuz+tIvMuuxo9jBuhkMC3ozJ1f3chPbQS7?=
 =?us-ascii?Q?rPgqlY3+v5JwdaaDtMmfKfkbD3DK18gkfdR11Gbn8f+6rD9td9X/yM/WNqun?=
 =?us-ascii?Q?3k4mNl6xPGefZEbS2uDhj6aXEbS7Wf3KM+Gi+B+7G4gcV0QZPtQdKSfLKGuY?=
 =?us-ascii?Q?p3H9KTSSWtLiNdnJY+/fzw3IIj0FdqDnmeWMmSDxEqFCukSQODQOvTGVqcVZ?=
 =?us-ascii?Q?AV3GaE7c/6ueWzv+elXxUbgaVIxShcnZGmPoR4eBrumCW0fPBRMVUD1RB3lx?=
 =?us-ascii?Q?nGUN3l90j7x+/WludYdkoxjEXT/Z01gWy2CsPS6jkskF2gBvm411pYnVsiNp?=
 =?us-ascii?Q?G2jkr8tmiScb6w3prxg57q/SCfgedwdbN3hLvg/Fmu1yfMBDk71+wWyZfIz9?=
 =?us-ascii?Q?BttXHml8Lo98LfelE4IWumXF4RmQG2c/2ShAMsrb7y/ImWl/6BrLj2/r5XAj?=
 =?us-ascii?Q?d3k1uHCEvxjlc6hs/u2jUGFRtr/jZO2EtnD/uhywKDxA0UpIj34fALX/AXZ2?=
 =?us-ascii?Q?MfczKJvVFPw/Bm7KcaxcYqgOoLxkUpNUYoxDMozm4IlugnZy3nGOLu6+poXR?=
 =?us-ascii?Q?nWvthoPpUQvZi6VCDPvQn74UYir9KRQT6kBGaCoT40U0LSP7oKLdWA/8bznj?=
 =?us-ascii?Q?LkmLpEd9su9Qpwdn1ncYoAsx9nFU4Rw1En2HLq3nDS1A48mykznqMGQjtfXJ?=
 =?us-ascii?Q?VoiDicNuJ34PUfC/aexkWyBAy+i26WuYgdyi4f62xMBUeSEyFFQ8C228y6WC?=
 =?us-ascii?Q?e6D9j3LQf8eLbseEagjVTWI9NQDMJ7lGenGl9E+uoEJhDC3r+f7ifSY7L47I?=
 =?us-ascii?Q?r2+sM1uYkcwgmIWnQSyn3VaZOebs7X5L9+IK3e+JU0NR1C+MySmN3UdBK9EJ?=
 =?us-ascii?Q?cg0zgCv9dnXlYZGXKqX2qA2EVAaTZKc1DprP60fd8agA2vDAam3NeC4bDcpF?=
 =?us-ascii?Q?n5j+H7OTpjSwP4uOD9SNimi+wE1DLLitq8xnZb+YOmsK2+USMfjGmfxzcQXZ?=
 =?us-ascii?Q?s36Abn9vmhWQRNJza0UexxhWI1PjhdJhLFERhPR9WnxvUfDjWrNDAxsOqFKg?=
 =?us-ascii?Q?rwavWY33opXLjPbGqTjAA9S8Q2JlIJcOaUtjrsoJITTol4XZc8Va8hIppk0d?=
 =?us-ascii?Q?6eX2yt5HdSAHU+lIcVyDlVxUo/Ii9VchmB+S7zpHuTzee8Zv+koBHP9f6sXK?=
 =?us-ascii?Q?h4b98saBFFt14+3iaNTHSS/trE2r8XbJ5BpVpLjwb6z/pV0frV9dBfvj97y0?=
 =?us-ascii?Q?uL+ILgdE1uMXXGZMy8B4uOq/8fVcxQscO0ZG8c2/KqUcOtb6m0KhxbPHjxsR?=
 =?us-ascii?Q?p3zTyL6yRExfqVp3QNfHfEFUNOEY1rMzDoCoyvCKjjucDXvDNUg7LHORdRjC?=
 =?us-ascii?Q?HvxfZIA579l912RwJdES/99iFrCkAJoryQigxU+KHcThr4kapWYvACZP+eDI?=
 =?us-ascii?Q?qOBAaaVmNMdxX65NPxYqTFJ6F1/Gg5E/gWuU6TXv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda7866d-2020-4390-a93d-08db7ed052b4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 09:55:41.1002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XynZJJd27PMOaMRy75RDfuEg/JHDL7D4jJm2N4QoIDNVOCzMbIrPGDVm3pNF5VzztOxZ10m5sQMEv6Y9esVQ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4356
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0
is invalid") says, there is no need to check if the platform_get_irq
return value is 0. Let's remove it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/pata_ixp4xx_cf.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 1b9f67e16864..246bb4f8f1f7 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -274,12 +274,9 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 		return PTR_ERR(ixpp->ctl);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq > 0)
-		irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
-	else if (irq < 0)
+	if (irq < 0)
 		return irq;
-	else
-		return -EINVAL;
+	irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
 
 	/* Just one port to set up */
 	ixp4xx_setup_port(ixpp->host->ports[0], ixpp, cmd->start, ctl->start);
-- 
2.39.0

