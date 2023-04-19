Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF276E7E39
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjDSP0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjDSP0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:26:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106154C22;
        Wed, 19 Apr 2023 08:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2zYRhoFsSYoqXkGhQRSZeIwqUs3xzddlRzwjl2hz+JS/jApQu+G7a/11tbQvYK9VhtGDm1oBMBPSuhetvP3OpSOVd6OGZulEaRS5Tqw5A+UZ19yGKBSEcGw3oGn7YQJ27OwMJGyvK3ZjedLPfkcVrMDrMsgeYN6b5t8raAzGa5ZBPge0XvMH/zJEvdSWSO0tzdrxRo2weVV5EmB4VgTIQ527ZB1uIHkwGx0y3QIp7Fz4RcVPWXEFxOjfe/RoM0EyKWiwHlHwTkUiq4tVtp8qukB826tzcCcujP1dGdCrlHXodbqCucadf6OTtIR13Ugj+k4hk4TTntkECf4Ef0IRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEtcpK9d99ueWSq0grAMGLoBOSva0XVwiHkKuA3m4yw=;
 b=DGXH/S4FSRXSupAELzMNTGVZNHtTDgfEbG09SDGlO/xOpY4btaWADrpmzrUMICD0+kL8EQB/4qwy3yFdmCNGB31gS5FqK+zB42pNfgMhR+xxDXTIQsXXep2X3V+uH/S3+q57Sw5llsBe08p5eXjNYZ4SaJ2rDuJFu+oOd6FnDixT1ke3CmdJlV+7bsoayyWWGKyYP4q1k4b3vGFyj5BP9BcRHRVOY0zf72fnlYaePjhbCSzfcBRRu0MoNiV4MXme7UnDBQr4xhZTT37fEiP3J4bDAOQNiHqw6/hay6H7NhP5SdlkNs0ZkBgekPOS5Qbm/PAyMQPbVdS/7qB++c65IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEtcpK9d99ueWSq0grAMGLoBOSva0XVwiHkKuA3m4yw=;
 b=Ld0TjlYn8xhTDdtfkRVY4yR0x/eD2FJt5tByvuLsvxR07v1sW67ORa3pn6r3qSH6d6oBimUQoreXeUPTwL1f5HZ0aqhGVptsKyEgAANq82FeYTe5WwpluWPRY8kAaC4ZrElBMzBVHNAajQVZMKCvs/3huGUBQgzpOqrp0Xg+zW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8600.eurprd04.prod.outlook.com (2603:10a6:10:2db::12)
 by PAWPR04MB9814.eurprd04.prod.outlook.com (2603:10a6:102:37f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 15:24:27 +0000
Received: from DU2PR04MB8600.eurprd04.prod.outlook.com
 ([fe80::8169:61f4:ab53:26f6]) by DU2PR04MB8600.eurprd04.prod.outlook.com
 ([fe80::8169:61f4:ab53:26f6%3]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 15:24:26 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        pmenzel@molgen.mpg.de
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        neeraj.sanjaykale@nxp.com
Subject: [PATCH v2] Bluetooth: btnxpuart: Enable flow control before checking boot signature
Date:   Wed, 19 Apr 2023 20:54:13 +0530
Message-Id: <20230419152413.1688840-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To DU2PR04MB8600.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8600:EE_|PAWPR04MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8e6efb-8b72-43a8-13ba-08db40ea2984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afK2BQQ0JHdrCHPCXaA6yJt3zddgIOtIW4REOTHKu9xqD3dIl3EXoRFvWvjV3zoq9PyDrNuLTm4IsoVnITQN6iYu6hIhddJkHc0b5ZD1HzZFf96PC9dEpjEjg+QWZXqtJrwxxXBMwQVVquBtmgI/KgIDfjmeypqX/ygGio5BRw7IKTHz2Y/TYepHoioTBUDK2ItiWCcddY84Hm0AxUi8e+QfCYmOSMUadyrsR5USOR3W9nfIPg9SbwupwFEezluQTCPM3rPWe76198VngQ+6aogyIulHEooIZ0baSCvNbfI2Dmfw5KMRu5joil9SiZHMohKXLZHwm8dc5gtCJE/34XV1sLq86HmDtljpin4EksQLXbjKNurO+WnHqTO6pj8Di93IQWlyLbp37JvRN8xtunrNC4yutikUs0JxrOJyPneHuglFf99nrtxHEOGNOSZKkqvOciGC/ttznX1RFBC3+eI7Y6UVfmTZOFU3A/8tN8RsrrxdTw9fWR4s/6QvDr/PzDGitIcGUnIV9Q6M0IZ/Gq4kRxrmYVxPAtIetdOcBDdCep46PvqwMJdziqiNXKJiZ6enxOOpSG77lz04F06R5idDINSDtt0BKt0GRiIhV5sh5fNscjeIV89CANApAs72
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(36756003)(186003)(4326008)(316002)(66556008)(66946007)(66476007)(478600001)(52116002)(6486002)(8936002)(6666004)(41300700001)(8676002)(5660300002)(2906002)(86362001)(38100700002)(38350700002)(2616005)(6512007)(26005)(1076003)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/iL1gaI/JUtRxuwx2SCIXgbCzYYDqHUvWmOVIN29zcDJgG+xYQ/V/mONhls7?=
 =?us-ascii?Q?g4xUHSPji3BFAw/RJwtV837ejyKl+WGGUJHnBIi7XhrQC6G1fbRc4PkX27rm?=
 =?us-ascii?Q?ibAZkf8JbQcMZveEb4hyO64PNTV4AWd6///OnsnCCXror1hUn9wii35LcGIJ?=
 =?us-ascii?Q?prV7XiPn1/yK9Oxtv2zgkIhFMQKeCo2uaxeKFlS/0h8fMPNu2Jyb4YHVFd+r?=
 =?us-ascii?Q?fV6shvDkTCdAnl2ToOhr8WpwK9K5pfX0IputRuhsHTrJnROv4oMe3LUXtOAP?=
 =?us-ascii?Q?Av29bLIcmQVGKhRQLEph2rPekoQ9ofqG3JRrbZ3xodfnv3qhN6RY0gsDlZE0?=
 =?us-ascii?Q?3Fui+Kb7/lwwtyrZONDjeGgwkTVjCCd1NrKIBFe6CILezEWpu5IKj+GKjC3c?=
 =?us-ascii?Q?9H/aAgT9UjmsdM6Kz9D23hf5y2Tp5xFGUOj4eT6leSRAdaX+gfIiuVS9RyB3?=
 =?us-ascii?Q?zhfI4E2/CNLTofCFKqc+5LaS+E2pCatkmXcAg2JXuhFoGaVDqpd/aCf7/vmC?=
 =?us-ascii?Q?yhfZ9kz6WYpJfy//Zmxvz811ELXPC0DGfAsqeWbmVdVMfqOGPA10G4DwovSz?=
 =?us-ascii?Q?yi3AYhK2NbsLlGrVVe6ZBUXfnM2tWuaiEQUDdEgIG3d/J3WpgSYtLXjoT99I?=
 =?us-ascii?Q?SiNg9wXW01FN8FCKnbZTypxO3jLoO+nu7AvCSg9WraYZsjBLHaURSd9CAi0i?=
 =?us-ascii?Q?lopJ7MpcdsNvMwhQMUaz9w62+sDDfASLQzbZy426WOtQK3glSxxv3vmFcllf?=
 =?us-ascii?Q?DDC8HV2KoUpyh9pREaDtKat/prCpsqbd4D+nCZaG/4ZFmzC7XW+qxFP7RhxY?=
 =?us-ascii?Q?VkU6UoSri/0ldVwqWwbdMMNm8REGSmYU0Tds9+QpoaC2UwYBcTCvbKFcj+3q?=
 =?us-ascii?Q?YAAsDIvKQboATyeFCTDUtnNScSQZTnc2b7jkbA457lkxpVIhNL0/qI5iZYGp?=
 =?us-ascii?Q?QFAeJS2lgR21uJ/ytUNXtcadapmEF/dIeOtxCihNSLpFFlPt2YGON9AmcTV1?=
 =?us-ascii?Q?uEdU7avUk7dtbRigPSVKYVF7kXmAnd3Vx79G/LXTz2cUgRHxlySmuYLUtME7?=
 =?us-ascii?Q?EQr5g9R6QY3BODb5W9B8RoQZem0EX1+ruJr1n7zx6LZKayPrWAJew0cyjD0N?=
 =?us-ascii?Q?5s2orzfSFVPtRWI928BM62sUfbEHpdLdtzOU/xS8x4dqZhUjNGyQ8MkHCUMu?=
 =?us-ascii?Q?o5XfHvSGT+utUrXKUVeRVAXINtvJp0z0RmfoULjlXB2zGQqme96B4JcACQ7j?=
 =?us-ascii?Q?hN/VPUTK/P03eaxmiNOGoakFLHB6dti7yO2dYdnhcHkhU382m5yOXv/B08/v?=
 =?us-ascii?Q?oGWNPsoF6CYhcNpgCDl3pNwP6aKul2loI841Nw5fWD6aaJdjq+DmZ642fy4O?=
 =?us-ascii?Q?8OsQ1VSQYuD8tCwu2CGXfG8BB+PzGb83l75tjneTZPqdFbBisG8PJSal91TT?=
 =?us-ascii?Q?2X0nM3uQ4WKMuH4nFXWcsIxQNbEK1kqRz1LUh6BbL8wehFOcohhWf4u1IXpI?=
 =?us-ascii?Q?C7wR19xVj5QnwGDFBJvtcH5/ZS8jN4UQGIkTxCKRkLNCWmES3zlutkdfIuIj?=
 =?us-ascii?Q?uEx1i19pfzhdmxXierzQSjjCMXuIgCuf+sPOMeJX5frODWHxswWRR0YhisDv?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8e6efb-8b72-43a8-13ba-08db40ea2984
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 15:24:26.8338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijs2yN7v//mV5GXjWETPti3rMXgR1s3cF81AWa4NFKKcvAckUleU3Hh+2/0F2Jqo2LU+Z/8/u3SeJ7uDs922hBxeEIFOKzR2aXzScY1duRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9814
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
emitted by the BT core when the chip is put to sleep. As a result, the
driver skips FW download and subsequent HCI commands get timeout errors
in dmesg as shown below:

[  112.898867] Bluetooth: hci0: Opcode 0x c03 failed: -110
[  114.914865] Bluetooth: hci0: Setting baudrate failed (-110)
[  116.930856] Bluetooth: hci0: Setting wake-up method failed (-110)

By enabling the flow control, the host enables its RTS pin, and an
interrupt in chip's UART peripheral causes the bootloader to wake up,
enabling the bootloader signatures, which then helps in downloading
the bluetooth FW file.

This changes all instances of 0/1 for serdev_device_set_flow_control()
to false/true.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Add error log in commit message, replace 0/1 with false/true (Paul Menzel)
---
 drivers/bluetooth/btnxpuart.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 31046f26e712..3a34d7c1475b 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -535,7 +535,7 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 	nxpdev->helper_downloaded = false;
 
 	serdev_device_set_baudrate(nxpdev->serdev, HCI_NXP_PRI_BAUDRATE);
-	serdev_device_set_flow_control(nxpdev->serdev, 0);
+	serdev_device_set_flow_control(nxpdev->serdev, false);
 	nxpdev->current_baudrate = HCI_NXP_PRI_BAUDRATE;
 
 	/* Wait till FW is downloaded and CTS becomes low */
@@ -548,7 +548,7 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 		return -ETIMEDOUT;
 	}
 
-	serdev_device_set_flow_control(nxpdev->serdev, 1);
+	serdev_device_set_flow_control(nxpdev->serdev, true);
 	err = serdev_device_wait_for_cts(nxpdev->serdev, 1, 60000);
 	if (err < 0) {
 		bt_dev_err(hdev, "CTS is still high. FW Download failed.");
@@ -740,7 +740,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			if (nxpdev->baudrate_changed) {
 				serdev_device_set_baudrate(nxpdev->serdev,
 							   HCI_NXP_SEC_BAUDRATE);
-				serdev_device_set_flow_control(nxpdev->serdev, 1);
+				serdev_device_set_flow_control(nxpdev->serdev, true);
 				nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
 			}
 			goto free_skb;
@@ -763,7 +763,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			serdev_device_wait_until_sent(nxpdev->serdev, 0);
 			serdev_device_set_baudrate(nxpdev->serdev,
 						   HCI_NXP_SEC_BAUDRATE);
-			serdev_device_set_flow_control(nxpdev->serdev, 1);
+			serdev_device_set_flow_control(nxpdev->serdev, true);
 		} else {
 			clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 			wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
@@ -880,7 +880,7 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 		if (nxpdev->baudrate_changed) {
 			serdev_device_set_baudrate(nxpdev->serdev,
 						   HCI_NXP_SEC_BAUDRATE);
-			serdev_device_set_flow_control(nxpdev->serdev, 1);
+			serdev_device_set_flow_control(nxpdev->serdev, true);
 			nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
 		}
 		goto free_skb;
@@ -984,7 +984,7 @@ static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
 static int nxp_check_boot_sign(struct btnxpuart_dev *nxpdev)
 {
 	serdev_device_set_baudrate(nxpdev->serdev, HCI_NXP_PRI_BAUDRATE);
-	serdev_device_set_flow_control(nxpdev->serdev, 0);
+	serdev_device_set_flow_control(nxpdev->serdev, true);
 	set_bit(BTNXPUART_CHECK_BOOT_SIGNATURE, &nxpdev->tx_state);
 
 	return wait_event_interruptible_timeout(nxpdev->check_boot_sign_wait_q,
@@ -1012,7 +1012,6 @@ static int nxp_setup(struct hci_dev *hdev)
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 	}
 
-	serdev_device_set_flow_control(nxpdev->serdev, 1);
 	device_property_read_u32(&nxpdev->serdev->dev, "fw-init-baudrate",
 				 &nxpdev->fw_init_baudrate);
 	if (!nxpdev->fw_init_baudrate)
-- 
2.34.1

