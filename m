Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB3C6E75F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjDSJEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjDSJEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:04:09 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2087.outbound.protection.outlook.com [40.107.15.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0856830E0;
        Wed, 19 Apr 2023 02:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vo9OfxBM6SWdyyn99sQu27cvwN6vLyzxu6yaO9pfQ18ZnVD+guA6HL7GbQ1E9pmONZ+Gw+v9cKtbJ48Kf0/MAPKg/cQohvIEP63KFtJ/bppcf7YA6Nycep9+mKIdEl4k/hadri/Zzhk+0II9hwLtoAkDGvok1Cim2+lgVluAopX5os5I2dNZNDiaYZYqODnPFpAg0qNZVwNUHBXYlkEONk2h9cNhZUBPBweksqg5GUf5iJSeE+3h0FVr9Jy6GKjsmZBv8yem60LcMGZQiOKIoGwcUOUKbE7ozzIMsoJrimDgg0/Hvb4fDGjRQKwNrY6BJXvurN0vS2PamGau2mJfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZa0NQk68CUmyTcfmH9bBYqJIMQ3aSjzzBv9ANsHoAc=;
 b=ago3/galiYMZLNvTJ6hW6H7qvIXl70RuhpkKdx5fzXXwCWXUwFDj/tEMbwSc3sMDts93HjC+kI1+dbppUY+++ks9L0mRiNLpd/lxv4g5/aQqwPp9umJ6sk/Laf/ejoN5tRxfLVRwRCH6PLGlnAFrLKHJQrljCFQGeAhW+KShrT+aSNNdyY0aTpcKm9laipRYhRB2FFKIkA0oRsuzE9MflK7NkzqYLYF944rF6U5n8xddnRR3fnV/uBN3Yqt+Yb5cx2IVQJQuMFjr/PFXS1nJUg7iSaEXnmv9GLKRUEf84X4MURbZxqw+s5SDlfTbcAW+d2XlM47FdDJ0V3BOvM2HZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZa0NQk68CUmyTcfmH9bBYqJIMQ3aSjzzBv9ANsHoAc=;
 b=SevCbngDh1Z1GAUohefwcw+BjcmrZMC0Z+VODmH54fKQoUP7u8tAi/C5GtvD3Qes3uMrNE2X/MsIOpJF6XN0L8gDLFR57/9Lv89rjuJ9qa9NgJqdZ+Z6Y/2RuIekFw1FIK5fqcX5dWyoJ6m707MDVT9Q/+/re9xeEEzr/8VbdJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8600.eurprd04.prod.outlook.com (2603:10a6:10:2db::12)
 by PAWPR04MB9987.eurprd04.prod.outlook.com (2603:10a6:102:387::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 09:04:05 +0000
Received: from DU2PR04MB8600.eurprd04.prod.outlook.com
 ([fe80::8169:61f4:ab53:26f6]) by DU2PR04MB8600.eurprd04.prod.outlook.com
 ([fe80::8169:61f4:ab53:26f6%3]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 09:04:05 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        neeraj.sanjaykale@nxp.com
Subject: [PATCH v1] Bluetooth: btnxpuart: Enable flow control before checking boot signature
Date:   Wed, 19 Apr 2023 14:33:46 +0530
Message-Id: <20230419090346.1671130-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To DU2PR04MB8600.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8600:EE_|PAWPR04MB9987:EE_
X-MS-Office365-Filtering-Correlation-Id: f18687b8-cfd2-42b6-5ec4-08db40b506af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /H35UUddXUPcW53kPRoRMqiMPG5HlLYCCuBOThosl4GKEJQhjLVzysCZ/bdAtumR7r4syrIDme7t37IYepsokfEziH3G+PrvXAcWIdURJfGubsqYFL5X9NOVcK7XJ57/FjyeT8wGCxqVvJzYTNYVa6Y6k0byXe2o8gogbWeaO/Q7pzZsXerkRdTAY5dFPO3xPZ5sYdg/mNZAbYjknZRPc4GW+/5j2t9uY/y7yjBpPD8NAEr0DgTu806yS93X4+gULJ/h7efxyCArTwWGYAjSBtlYpgbw4ehMEOGouECV1z6QZmeT4Guc1dLwEi35f3a/0PY8FZMfHb7qDDIwEjrnRBYDynq3MBA6ifqG7dZTPFkJ8Awnn6eaR84/7ZJE8sO3fjaIwPpm6UYo0IF1J6JMyqFB4CGrnaV2jvlVHmNvc8eH8uXh8lQ8gN7GiiIV6g63ktQLK89IzwlOI65WWkjrAwi7k7QEE8/TAnEDsLpqIk9//XspozbxvhcIbsH7/2lebdQpDA+CNTD9H83Icl+3nSX5Q39Mv3aY09m+dcm276At0KrJMWZSlA3zMWn+mPP3+a5+GgSJwpXrNKyCkoLlRJH8J6ISKitPG3AzTqI39cXmlxod3sF2kxEf7IwM1HDB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(316002)(8676002)(41300700001)(4326008)(66556008)(66946007)(66476007)(5660300002)(2906002)(8936002)(83380400001)(1076003)(26005)(6506007)(2616005)(6512007)(186003)(6666004)(52116002)(478600001)(6486002)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UhmTHLozNEsCuZoXl+5w1irflA+0P74Y6UDtG9e4Sb9QGlqWFycp9DctkguB?=
 =?us-ascii?Q?DbOx5WN3VRtl0lAimdfrdcNEWHMGoduHvNPQ2j8086pKw/kMuWrEhMpg2cJD?=
 =?us-ascii?Q?NZTx+vBb2U9a1PRMbN+RKByLYUk36dX+3eGOZr5dgNB/9mvmQMoHmYSvlwFK?=
 =?us-ascii?Q?2roN78tO4elKfixibRqVbzVV9RP8aXByT+jb9d55DQO630HT1zIgk52wkDMC?=
 =?us-ascii?Q?sCFiDaAZJfYoPqPIqZRERLDYp4+DWEULSdFJyogdZTNQ9HoL2U4S0aaQJzLs?=
 =?us-ascii?Q?oc0/2o6Rr0oszl4tW+wLF+DmeCFGKE8c4gqFE49AxCAow7y5FyKdXNKHQVDv?=
 =?us-ascii?Q?AlhDd8+bzYXrfU/MAbj1Pok46isx/h10IyPj8d5nDk/WDzIO3DAbIr0U0Oqo?=
 =?us-ascii?Q?ZgvISf4R+TnT0LhQyFMjSFhj3T3B6Yss2CKH0Dm2U8K1iGnP2R6D+Kka3mAP?=
 =?us-ascii?Q?8dbW+3IKg3UibN0DqYwmVHwDsvMg1t3085HFoqAY3lhGoV1u4tmSZCPXH/uI?=
 =?us-ascii?Q?sR3LZGU/uzu8dQqD07mdgiLESWku+goeDfpqoaUAX/dZ30sZfV8UT3PtjVl1?=
 =?us-ascii?Q?aIJuBawXQ7pOlaNswf017B4+2MWMTevO4Hs5dk2TN64mXpwIi/5DKEB79IUe?=
 =?us-ascii?Q?fPpIWKXvvN0MiQTLCwZBE0QaeFXdmZiU0NZBS+hy1at/WiqtPbi9zi1Mt+Gl?=
 =?us-ascii?Q?czQbJkDyeHBHZafHM8l0UQedapJxk7qRx+q834rW/H4j+wgStq5AzHY0Z9dd?=
 =?us-ascii?Q?rSa/yDHfjQd+JqkWzSE7efraIuSjUtYJepVSnKRZGcqoTSh3UM5oJG9jEyWt?=
 =?us-ascii?Q?wkC+KPzKNXS0VFpk8ELBZ+Sth6yGan8bCzU7wnXvF/U/U4daz+6sP7RmicY6?=
 =?us-ascii?Q?MD1TFDqgWBOfbpjnc8R0wKBoEcI9jRfsV9Ppd2Gpei7633/lbeaelkMUDJF3?=
 =?us-ascii?Q?+rAwJFHcEvDMXYqCAjNILb53ZWEmvX1gWQm8gkDEArNpWRF6yvyupQMM+uhW?=
 =?us-ascii?Q?uheNX90wF2XS/5yPvPr58be9yT+ttL7gu/PTjAO2CnJC8d1k5hoNjWrE28U6?=
 =?us-ascii?Q?/SIKBloaBXH2dcRUTaPyfnO0Wn4dZi5t0ASawSUDtEeJgEDof0HSoHuVk/dI?=
 =?us-ascii?Q?j+123Qh5Ky3QFX3eB3TuCQgbjrdEC81YUJ9SQNB3JPZRUEIyZjdYzR5Y/BoB?=
 =?us-ascii?Q?QhXalZf2tN3NNaZxyDXPRSbeXXJPjirttKEVr+yezOXm4nsV35SHRvKngSga?=
 =?us-ascii?Q?LqcyDg/gab/F0110EquH85ilRasgwzXqubdQckbLlWd7fAdxS+xzgoXxrKsX?=
 =?us-ascii?Q?UHM6vHGmeTSW+NcHY+Hlbu/DavXFCHC2XuCr6ZT4xB0G0z1olNeKQBikyysP?=
 =?us-ascii?Q?qpOCIKXeh5uWryPRdMkzlAI7jTh5CwIx5pUT6PeHxPWn8Feou4YzYtci9bSq?=
 =?us-ascii?Q?RjPIS81FOQKzZ806KwnUQ8Ifc9Lcd+Wevr2Xy24BbcTjA/CsOhQAvs1IAcnc?=
 =?us-ascii?Q?0GG99biZdIfsJvLL/60ZgQ4f3QOVcA3JbmX2ng3R9UWPrLfULsOB160j1efY?=
 =?us-ascii?Q?wohxBuf8h3/gMHNbAjXkRDWJZE3CQoSAsEusfPRo0koP83tqxGWJJHWrhDcq?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18687b8-cfd2-42b6-5ec4-08db40b506af
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 09:04:05.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onds1504p/IEUko9mRRCAkLbFKzHb4DaeLMgA/p5veezFGD9s2Q5jjXR1f+3C/yBai3NVUtcIbwaE5sQIj9tYd/sqWmgUOcCPJ6PcueOITM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9987
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables flow control before checking for bootloader signature and
deciding whether FW download is needed or not. In case of V1 bootloader
chips w8987 and w8997, it is observed that if WLAN FW is downloaded first
and power save is enabled in wlan core, bootloader signatures are not
emitted by the BT core when the chip is put to sleep. This results in BT
FW download timeout error. By enabling the flow control, the host enables
its RTS pin, and an interrupt in chip's UART peripheral causes the
bootloader to wakeup, enabling the bootloader signatures, which then helps
in downloading the bluetooth FW file.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 93f3afc0c0c8..3ee41a0d45e7 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -967,7 +967,7 @@ static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
 static int nxp_check_boot_sign(struct btnxpuart_dev *nxpdev)
 {
 	serdev_device_set_baudrate(nxpdev->serdev, HCI_NXP_PRI_BAUDRATE);
-	serdev_device_set_flow_control(nxpdev->serdev, 0);
+	serdev_device_set_flow_control(nxpdev->serdev, 1);
 	set_bit(BTNXPUART_CHECK_BOOT_SIGNATURE, &nxpdev->tx_state);
 
 	return wait_event_interruptible_timeout(nxpdev->check_boot_sign_wait_q,
-- 
2.34.1

