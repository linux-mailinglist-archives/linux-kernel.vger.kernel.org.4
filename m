Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E2D6E7C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjDSOYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjDSOYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:24:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3F6269D;
        Wed, 19 Apr 2023 07:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHBXjAf5zIjYg1GM2NA9k0GgAbEEVtly5+ewjkznbJGT+S+f6bkXSQDtaTfUxIgKNqQZaqyVB+SfXUxgoc7Yqozt6dBOfVSkVOmzgL6vXjS/xgCEH2yek1lyxK6NBRpw510tFjjCcaISY8/fjfkY8NVYx4t/NnjZzxthYGL4/8BfGT/mjgyuVJtk5152A+uxyFgmoT0cJu7yJxBaqL3lpbG/sxUxr8rITf43y7DXk80dqoy361WIa9a8xaN9qZB1VrXUCrFBK3oCNLjg9i1ttCULnBrrSXuS9k/7HBhC7Lj7knixTUE8F43cGueQ4041tPi09i7l5OrTcVFVSN2fLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctvbOKqAshjV4CyYmMS4cQgvnFURxitAVGbnBhokHm0=;
 b=E4eb4CZ+Ac2JwI7F0BtPknI6Zqplc44/QffpT+91fR56rYIPHx5xyVlCikbEaay2oqGc0CcYdfSzfRUg0kDBaFoXqSClYkxvKDOj6ZiKS6khl0pxrHbRKhpaiyD77guaW2wmvVFCH3kFjUCIJSfCAhEe0mzgVqvrhrdMFLzTRPkvrWbLeBjGHaEhKY8ru8rPmjyG58U+tyRKongsjxyS8CsxPFwIP6Ob0FtlpMb74wAMHzFKQTJVeW41QCr/H+KEHMH3Fr+kSvSmUGptzRZVZ3qUalTqVDkQA1UxdLielbRTgLp/piivkq3YQ0+NvVIRC42S37whr3mjvaBvq4DB8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctvbOKqAshjV4CyYmMS4cQgvnFURxitAVGbnBhokHm0=;
 b=lFjq3afWwLNIR9EYSEZKGezgc0qjxbu8D9Xe5v6/NCOA1eOa99FY/pzfThmaIYQV/HFSV6sT1ti4TzHBH6f+ftO35esLMEgOwKybZ4A6654Du0CLWE/VLXvgr1vyCKzkb4mpBzjY/1RsKZmkVsReir7WBoWS8O9cdtRkq6ZoKLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8600.eurprd04.prod.outlook.com (2603:10a6:10:2db::12)
 by AS8PR04MB9109.eurprd04.prod.outlook.com (2603:10a6:20b:448::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Wed, 19 Apr
 2023 14:23:42 +0000
Received: from DU2PR04MB8600.eurprd04.prod.outlook.com
 ([fe80::8169:61f4:ab53:26f6]) by DU2PR04MB8600.eurprd04.prod.outlook.com
 ([fe80::8169:61f4:ab53:26f6%3]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 14:23:42 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        pmenzel@molgen.mpg.de
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        neeraj.sanjaykale@nxp.com
Subject: [PATCH v2] Bluetooth: btnxpuart: Enable flow control before checking boot signature
Date:   Wed, 19 Apr 2023 19:53:33 +0530
Message-Id: <20230419142333.1687267-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To DU2PR04MB8600.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8600:EE_|AS8PR04MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: fd444da8-5fee-4cd4-1c16-08db40e1ad43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCpiDKkLlOcSdhLZ35AbA3v8ufQuHNVs4gSNSwj2ZJn+7/mkFai5WOg/CVnvOP20OBwdSDZ/7xUlBQc/KZNgFndFlT9uMtxDpcLFhFTWSystRlV4vJ3Z+y+6RKl6+x2LfQ9o56wstNQl3gqehuBjVDfV59U+DLaSZ1E56lejwJn+XUfNKfiCic+yFwYYWClMdfFeHqQyg3+wnKAe44LT8nxFxijQzAvPZyDI+SuzjdJyuudVvL+RLN+2Ck4NanLiiIkeISf/pyTGht6azSKb6L1VcfVsYFBmWjCxvfSqMBuHQYEjaBDme6v5ajQb6WOR09NfLjdVoni0ddPacYqoib/lcEtodsnyeO+cXk5O2y06cnvHBEV/FFIFugS3evv8WH72RW0t2TLLztlTpdA5AlXWpqu5sYTks7D5lbYsY+c6lNy5hvHFVOAZgi+MIQ+VxyVnWYaIZfB47SZjb3tX47jqGnmck+34TjHl5sVoMUt9nEJDc9pbnxw+6G4564uG/9L2zutzaLNP6tzbj5ByXM5zFtqOm1+6knV95mp+ig+P0SUjHVqMncyp3+aO1nEDFTFpKe82MTVfpACfA/Jw0K8PfH9TATuiQuQLs5NHn+VU67TtvxyEQI0DdV0EGm71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(1076003)(26005)(6512007)(186003)(4326008)(6506007)(316002)(8676002)(8936002)(36756003)(86362001)(2906002)(5660300002)(478600001)(6666004)(41300700001)(83380400001)(2616005)(38350700002)(38100700002)(52116002)(66556008)(66476007)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h+UpfdVlm9iHlb2++Wy75Hj7QvVpe7Y3dSVZmou7zjli95Vb+/SuIg5rIAIK?=
 =?us-ascii?Q?k2DjBnA6hKToUp7fY9h5F3JLJ4xW8QF+KQqQ2/YcTL4WAtEG/wuCh4NbAMTK?=
 =?us-ascii?Q?sBLtHW3nFCpqQkRKZtnfuN61ggGu3ELTN4v+RJLq+RW6F7jfmLtJEHm2iKK+?=
 =?us-ascii?Q?M85QkmJbfI5TyKjqxFGGe6qyxftIqvm+PDAjz6v477TUUwSPOVF1+G1MChIW?=
 =?us-ascii?Q?WuM9+GAIln7QLvT3V6QbOl3mFHLxF3vAOX+ZvGBTbFP8F4UpeGmJh/kt78Su?=
 =?us-ascii?Q?Sw/ePiXNXYkX802NIdWQ17ERTJGPMCalWXMB0tHKIaPvhrSetASdrczCFWGg?=
 =?us-ascii?Q?yPE/aYBJata1gFGGdEjiVhqpuYT6TO1lOY9ls/r7neAMtIrfFUEhZzhjSnii?=
 =?us-ascii?Q?aCZZp73xDG8G4exEUmtILQFqxM4xsW+zlkC5qrcg1J0+2muSe/8hdHQ7ugGL?=
 =?us-ascii?Q?mAJBBgOV8+7z3uVEfAKxF7C8jPIAGmmnkfm/H10Sch0qStgxWpqtU3kUAcoL?=
 =?us-ascii?Q?od3Ybiq31FwOox7UHKTpm5ZKdfjcA0nHLCARANLoLHu7bi4qvsADDO8w8L2L?=
 =?us-ascii?Q?Fps27+NlvNEgd4FmwTyFfjwCNTvDhpxC1PdKPHnSEJdts7lJ4rUTK+SK/aDq?=
 =?us-ascii?Q?NYtJ9VQxG8RqyTLMAPnxMFCSOcrzGLAmgvbWHvE0r65EkyXNLomqk4d+EN8S?=
 =?us-ascii?Q?xEMZ1IPJZWL4qJ0Paz+wDTOzB2/fMfUJT9+xcd7CA4w/tKxqHRTXY3u08CtX?=
 =?us-ascii?Q?axeuAiiQD3uNHStP5346iSlwjdWOYJrsTIanQ8gPr7DBJUb1hiDxmH0E/U1L?=
 =?us-ascii?Q?DljOu2tjS2SImyYV3zLkG4spRIg4S+x+RIxbJh3FJsha7Bi8Mgq5+oqK/cXG?=
 =?us-ascii?Q?tgJFqKn3qR2/Qo7z6Rbsm2GfeaCNye9MPJM6XnZzYSlGJ9zqllGFSJ9Vnw1Q?=
 =?us-ascii?Q?tXmQ4Drvc/q0PeYgg0f1I++Yiy4uWYuto3MKY0brA9FK55GuMf3zpxXYs64E?=
 =?us-ascii?Q?fD/ZBLexhT26OShVy7sL2kcWXrBpAPnjUGLLumHKS5YLsbq1eZ6Y50dE+k1t?=
 =?us-ascii?Q?nSMlohh2zuaPKyW0gH/5C5M+FW+oPysLHr9h/T2suTsfSDwqzoYVmBwKZT5Q?=
 =?us-ascii?Q?hbmPqonmTbCFbAWiCrPv2FSMosvUdufIP5cvSwABVgSHUxVWHphmW03vZ93X?=
 =?us-ascii?Q?ExvezcMjxwXAW+BeS1+FxMgHHL/7Mcv6azs5ZokuH0c/XO0K51eSh4cuJuG1?=
 =?us-ascii?Q?zQPIUzHtZN2oBAOD8JTcUrV4oUhlrsFrrEI0GKpqJ8ob7nH5CAlA3RPODo86?=
 =?us-ascii?Q?u82zcguSqqYDcXcEfopUflv1/yWfVkW/lWVR9ySjCCRzaTcU2V47hIl5HeFR?=
 =?us-ascii?Q?vYvbzhRiah46O8vSaEvRP4vA71nwbb32Pq50OUORD5LM1HayItRDFFFkMLXT?=
 =?us-ascii?Q?ETxp8NwogCAA7gS6a89/88CzPvVZ5vEeVNIuetRqE9ghnEbdN5BJDTJlnHMd?=
 =?us-ascii?Q?PN6J7sRMa2uy8zrrOIGe05QM808u0oUzS54rXBafrScvTqimi7vjYBArbPsE?=
 =?us-ascii?Q?xin69T2QISJzMATGeAt16tKKvBu9NTYyYNqm7uGQo4IgA91UutF/bHH1DXFB?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd444da8-5fee-4cd4-1c16-08db40e1ad43
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 14:23:42.4432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3mMJevD3vx6K+esObfKq57/erDO2UthM5w9U+YI8VSz0IZA4qTYzp8ZM13a1QkhFrPQ4NW03tnXN3NeWBarFXjRQQ516QuX5OVwL8RP77U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9109
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
v2: Add error log in commit message, replace 0/1 with false/true
(Paul Menzel)
---
 drivers/bluetooth/btnxpuart.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 93f3afc0c0c8..3c15f9399779 100644
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
@@ -733,7 +733,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			if (nxpdev->baudrate_changed) {
 				serdev_device_set_baudrate(nxpdev->serdev,
 							   HCI_NXP_SEC_BAUDRATE);
-				serdev_device_set_flow_control(nxpdev->serdev, 1);
+				serdev_device_set_flow_control(nxpdev->serdev, true);
 				nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
 			}
 			goto free_skb;
@@ -755,7 +755,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			nxpdev->helper_downloaded = true;
 			serdev_device_wait_until_sent(nxpdev->serdev, 0);
 			serdev_device_set_baudrate(nxpdev->serdev, HCI_NXP_SEC_BAUDRATE);
-			serdev_device_set_flow_control(nxpdev->serdev, 1);
+			serdev_device_set_flow_control(nxpdev->serdev, true);
 		} else {
 			clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 			wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
@@ -866,7 +866,7 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 		if (nxpdev->baudrate_changed) {
 			serdev_device_set_baudrate(nxpdev->serdev,
 						   HCI_NXP_SEC_BAUDRATE);
-			serdev_device_set_flow_control(nxpdev->serdev, 1);
+			serdev_device_set_flow_control(nxpdev->serdev, true);
 			nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
 		}
 		goto free_skb;
@@ -967,7 +967,7 @@ static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
 static int nxp_check_boot_sign(struct btnxpuart_dev *nxpdev)
 {
 	serdev_device_set_baudrate(nxpdev->serdev, HCI_NXP_PRI_BAUDRATE);
-	serdev_device_set_flow_control(nxpdev->serdev, 0);
+	serdev_device_set_flow_control(nxpdev->serdev, true);
 	set_bit(BTNXPUART_CHECK_BOOT_SIGNATURE, &nxpdev->tx_state);
 
 	return wait_event_interruptible_timeout(nxpdev->check_boot_sign_wait_q,
@@ -995,7 +995,6 @@ static int nxp_setup(struct hci_dev *hdev)
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 	}
 
-	serdev_device_set_flow_control(nxpdev->serdev, 1);
 	device_property_read_u32(&nxpdev->serdev->dev, "fw-init-baudrate",
 				 &nxpdev->fw_init_baudrate);
 	if (!nxpdev->fw_init_baudrate)
-- 
2.34.1

