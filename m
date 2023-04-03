Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2306D4458
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjDCMZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDCMZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:25:24 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2082.outbound.protection.outlook.com [40.107.15.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A787311641;
        Mon,  3 Apr 2023 05:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8xtdFrPfzQROKO/hhPIRSoZtwGIuwvtDQvOqliX4PNnMkjEsxgYKaX3urbA07DhfoOJi1v8wa9jF4Bu5fyJiLDJwBX9Km/wpuQrORa8DxvnvH55J2Jet+NdThECf8VAgtWaeVWckRkS6ynlrG3FhAj5d235BcTXQQOyf2yQ5p1MNKeufxKWdL8At48Y1fkmrirkYrZWd+yU0Apvco7Vji0b8EBraDEsYZBaTDBFPzPbMlbqGXtBgL7QfmOTqCz4xacslZsBLSJjT2tV2AVp1T6dJKHNompmAqerjX0CTG47ZGTmmjyK6A/W+UGc9SXmYwolvdUrrdoOYcLOd+5SgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nogy5N9enRPuEwKf/rz4p+5vG/KJ3eqUbA+LL7SdPzI=;
 b=AjbIHH6IDKMfERbwudKMqCmyCvr8OkXnyILXaBxZpSLK6yjRGcT416oNTtDRjIhms/O1rmOOzAwFwj4I8GnlCiEBSPSwBun415mGekZBgDwgoR+1z8PgmztUat/KY2ZVyb2HuWEVWPTuJirsfIbi5acjygmRHV+Dyir3A7ito1Md7PFmbjGr9qYBa2h32NoYmSwyzVLruQLSlxnD2tlDVJJ5a7p88pEWlLju+P9eCQ5TcsfesPIPx4QKKQ7Rchq7esHeRFhWJaUXyrvC2+h8NFlhdSm67LokIyn/gG6EHolRJOGKPbr5ufPuXOAxfaXDeW95OMV3o05JV1rIh86k4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nogy5N9enRPuEwKf/rz4p+5vG/KJ3eqUbA+LL7SdPzI=;
 b=rtOFxf18I/PecfasdUb1DL3WxiGMduLqFONB1rVPvJHyhe0P7/L5iAVrI6EJmlJcsyDFq3P9Qn7BXZko3oKXXznwgIlB/ya+qpPiofzeHx+U/NEdcRHthuMyarBEjNfCIXluo1TRt3DIbGcVNIWJ/8eQW8AZRdQfuKYxYfHSLaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 12:25:21 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::1013:5b17:fe68:d06b]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::1013:5b17:fe68:d06b%8]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 12:25:21 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        neeraj.sanjaykale@nxp.com
Subject: [PATCH v1] Bluetooth: btnxpuart: No need to check the received bootloader signature
Date:   Mon,  3 Apr 2023 17:54:30 +0530
Message-Id: <20230403122430.1024235-4-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403122430.1024235-1-neeraj.sanjaykale@nxp.com>
References: <20230403122430.1024235-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::20) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 09da9dfc-9523-44c7-6f0e-08db343e7e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRGYUsB5OQ4YfpdZlkWzMvlh3iQdMYdgSV3C1PggIWAb7Ltwra208tkKGKdbtcBcqyDsE6WO/nmTBjEP+tRjFU2ox/RIOlsS5grVYSoBnUbjtlW6Gk4JAhgv0fJdUFBIiECHNEEUgrGX4onNh3PpoXi2KkjIQk47NtC6AfGslrekGhGkOPjCFFEk4SWjDSIYDbvowF+omQf4Xcpg9cGiJ3qvgXlSNXtkR5oL0LK5xt3i/H/xvI3hMf1X6j4jpz/IJtA41RqMj10aq5QOpu/7+DyAa/IO8xlF+5VvUMDUODC8JO9DIYqGVCM/5iovczQadzXeQkU/NBp9US+Ip0sxtaCVsftf8F/A51LRc0FojNZP7aM3NHwilcUbUgvkXE9VAcSc4todH4l2t53mpwHiv0WNc4bgD1XFgrPZGBKOVc3BsZ0VxFhRVl+R5MqpwdCQrY9BHGuL2JQgkY7gB5pEyeszSG3D2tbZqKxG3zvsnBdgE10NYp9XNx2CQMlgYjEu0QOn0ZVAJGgMGl3HRhDAHamsLgc+3wCb2bVehk9vLZNjRTz9+otS5xh8FAlnJ/JjvpwGuGDl3VpgIv+ETmrJBmmEFhoclFMRBI2Wsx/4cE+KSfhdUc3qPwRt957jVbYN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199021)(86362001)(36756003)(2906002)(52116002)(2616005)(83380400001)(186003)(1076003)(26005)(6506007)(6486002)(6666004)(6512007)(4326008)(8676002)(66476007)(478600001)(66556008)(66946007)(41300700001)(38100700002)(38350700002)(5660300002)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lXaGjIo3LHRaikrSFbAP0J61szrWwON2478o1enH+mBknXlTKRVLmYor4+uX?=
 =?us-ascii?Q?l/IWKxjxxh3vN9pl48DFAGDOrjB5ll/o9NIpGgFRWSHnDQzHplS/ojISpga5?=
 =?us-ascii?Q?pvKPSvMsMFcP0mYVHdU4x6/XIuWFbESqsUqUKQAjx5wNJKxeou9c9pAmS86a?=
 =?us-ascii?Q?4inYndY+nVfa0ykszlJUZtekruIWKdzMIhHkObyvlj1o8OQWZR1M8oteCAdA?=
 =?us-ascii?Q?H7PyjztxdViYbqdkugibXwss3WoD1SDD0P677KhiytW0ePXOgGppjkwxUGLI?=
 =?us-ascii?Q?fLSs++0oXsuWq++2eMoh08kae+Sczojh3Qkt70lPQ8mNNpSIIsM50TdeSjRa?=
 =?us-ascii?Q?hmN0U9ejmJUbrAGeeaFAaZgCrjalYXauYmof2X8w6aMmYTUfXlBoRbJtZgTH?=
 =?us-ascii?Q?F3WEhI7M8sSbG8MrkWPWI0LlyjJlpBy3Mzdt5X2kWZn7JiEv+HAqQWSHS2L+?=
 =?us-ascii?Q?FuyIp8lgNb3iw3RWwo6g1G5/5gvuuO/hh/V7h4JUU32fk1RV/4FgiqnhHbuT?=
 =?us-ascii?Q?PEBmdVoAyQH3f9nIyOm/FHYwQIXNp16GRD5T6EEMXu275b3orcualYVmWYn5?=
 =?us-ascii?Q?UeaLc80UDY+q5IAj2E1Wsns06UmQxJjJH+pEVEcJOR4nLOAB3kP6+yEELSG/?=
 =?us-ascii?Q?zlbkVQcMSRpwuvpbHBRsBPdMppQUTE5ZvuVH8tbnZ2U3Dn3V2l55g+z0+ssx?=
 =?us-ascii?Q?HjbxRC0l/oisxapJ5sP5pe3f6TRPhN51P+tHW58zksiSN2IHhBOabr3BFfE7?=
 =?us-ascii?Q?5b6F/o7Rqmd+X4PDYd7nEkaCb3QCcNbQEaGz7mVlZXuN7w5RGZycbq+dQcK8?=
 =?us-ascii?Q?tWMHK2+crvZvFpvs0qxMNO0E8E+/HXb5zw0RczG2ICw+JPadlXkfe99NnaQw?=
 =?us-ascii?Q?g8hSgUCg/iNOa56nrlupC/BgYL463//Kh3xr3TThETD+tsHJ5TWkCO3P5Rxh?=
 =?us-ascii?Q?s9yVeVewoyoEto+cCVP16Ght5mCk7HwkJXC9h+yXMH48x3s4AQfKK1KID6Ag?=
 =?us-ascii?Q?2sl6cDhnnmxB9TGzukvbPUQNFNcZrIq44mh0V6JGskU7oMARhof6h1TXAxcY?=
 =?us-ascii?Q?S8W6yA93tQYcG/9njhPyjoRR6ExjHJ6FQqQq6msN4QXEH67K1Xp8oB+wjnyZ?=
 =?us-ascii?Q?2JcQX9cNMo1QGzk1UVmoV+txTMoc9I3ZZwHI9mhcoXBJgXLI56F4mXPbT/Hv?=
 =?us-ascii?Q?ylEJcu3cDpulv3iNBAgksj2vdgnI2FItUmE4qCY5zu9z/m3iQbkDWZI9i+Iw?=
 =?us-ascii?Q?mLuefdu7m7r2e0aQV7PG7lHqfJhDJtd51jVnN/pKF5UOBxnZug2b7NBzPKIL?=
 =?us-ascii?Q?kN7fy62Co1OFGBqVR/ZUZ6EZHh0+VO0SJ9pC6MtJGMIst+8KEmTU18RxR+dz?=
 =?us-ascii?Q?M5klgsYPkhlGbbZj1jUV05NstOohboMGIh51FjCHCKxPlxyj9aqeSq4AfxZm?=
 =?us-ascii?Q?p2WkMxVo18U1+Eocb41kEUyLk3z0ucKxhAF3miKVA3N4OhrKufDc2Zc4q7HJ?=
 =?us-ascii?Q?NXdDVJTG9dECObKuFkOjkznLyRj/p64Ig4z7F4vLl0d/urLGqBbc2sbc4BsZ?=
 =?us-ascii?Q?9j+xuSuALfkHydhzx9Yl/cP91RxS2Pb44rG+pFsGMbxgaTPlmGTmk9JF2Uoq?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09da9dfc-9523-44c7-6f0e-08db343e7e0e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 12:25:21.3407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7OmDySCdFR8p8sXI3DinmvYEF9zG0FG51Gpdb0Y0pibMi4fjIFpqvF3LxF5bsR9fpHWw8hrsAoTja4P6qpPdbpKIqOiy860MRMojoRCdBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can never assume the uart will deliver a complete packet to the BT
layer at once, the expected packet may be divided into several parts by
uart as uart doesn't know the received packet size, the received data
count may mismatch with the expected packet size, so here
is_valid_bootloader_signature() check may always return false.

Even we remove the count check in is_valid_bootloader_signature(), then
the first part of the data which includes the packet type can pass the
is_valid_bootloader_signature() check, but the remaining parts don't
have the packet type data still cannot pass the check, here return
directly will cause the data loss.

So need to remove the received bootloader signature check here, the
h4_recv_buf() can help us combine the different data received into one
packet. If any out-of-sync or incomplete bootloader signature is received,
it is safe to ignore and discard it, and process the next bootloader
signature.

Co-developed-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 5f641466d695..7c22c1ac087a 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1147,33 +1147,20 @@ static const struct h4_recv_pkt nxp_recv_pkts[] = {
 	{ NXP_RECV_FW_REQ_V3,   .recv = nxp_recv_fw_req_v3 },
 };
 
-static bool is_valid_bootloader_signature(const u8 *data, size_t count)
-{
-	if ((*data == NXP_V1_FW_REQ_PKT && count == sizeof(struct v1_data_req) + 1) ||
-	    (*data == NXP_V3_FW_REQ_PKT && count == sizeof(struct v3_data_req) + 1) ||
-	    (*data == NXP_V3_CHIP_VER_PKT && count == sizeof(struct v3_start_ind) + 1))
-		return true;
-	else
-		return false;
-}
-
 static int btnxpuart_receive_buf(struct serdev_device *serdev, const u8 *data,
 				 size_t count)
 {
 	struct btnxpuart_dev *nxpdev = serdev_device_get_drvdata(serdev);
 
-	if (is_fw_downloading(nxpdev) && !is_valid_bootloader_signature(data, count)) {
-		/* Unknown bootloader signature, skip without returning error */
-		return count;
-	}
-
 	ps_start_timer(nxpdev);
 
 	nxpdev->rx_skb = h4_recv_buf(nxpdev->hdev, nxpdev->rx_skb, data, count,
 				     nxp_recv_pkts, ARRAY_SIZE(nxp_recv_pkts));
 	if (IS_ERR(nxpdev->rx_skb)) {
 		int err = PTR_ERR(nxpdev->rx_skb);
-
+		/* Safe to ignore out-of-sync bootloader signatures */
+		if (is_fw_downloading(nxpdev))
+			return count;
 		bt_dev_err(nxpdev->hdev, "Frame reassembly failed (%d)", err);
 		nxpdev->rx_skb = NULL;
 		return err;
-- 
2.34.1

