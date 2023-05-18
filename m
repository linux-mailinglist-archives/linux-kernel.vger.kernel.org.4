Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68503707B16
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjERHgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjERHgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:36:03 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0608.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E757ED;
        Thu, 18 May 2023 00:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kegWUeNPS+HXNDNGYD5+YPwNEuKMPRd4k2Ns1A0KvkFRW8z6uCtVx4QGP7t1+dA2t8pYtWGD4Ms3BPBWUzgV2r9B2pYiofFGwrLZ1qOhwpXJR4IP0uM4nnit6sl0CutqkbEUOTUSfLZO3EtwDLNZt6mW7EEa3Nx6w4peUlu6NQx0110eeLhGw1kTaE7xw4KNq2WvuJix7nXYva2sjXdT79hYf+dTBmOgKLgOG2rhJVst5sD5ArgE+iVeZA+wdekTfPX+TCFXXZKo/Tju22krWzeFFpgVDbJLnscfXrMX/WdeDA6iyf5ZQ6Fk0qBbvyLOCdOqsHUIk/O9wACMwQq1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bS50jy+6G8Uh542JhoewOgeV0UOOmnlryHQvEDD+l6E=;
 b=Kc6n7lvn5vxZ0EXKwmD4DwObsFnxamsC/x1sBjiC0gsmn86j15n3tV1nsOpfFJyV+spplKK5agwv37liMmqRNX+qANUxuRzuBTzVmNuIzB2xLvr6QbOeCyTKilRg5Enfs0EwTfHWR+MmkQ1U46gzSRZe8H+W20nkkRvA1iaFhiBdfT6biA0AvWiIWVs4gyxfO5t3VAZguKx6lWriZvWi7aUkA9BU/OtYSu7+NMQgNoQxX60KDaDu2FFMN4x2Nscf4h5BvCAIGTtMJVYC1fXQar6N2pJQOsUkpu9nOLShWQVHulce122k7lmOSVwfHzj4U//qVxGLhHPJEXoglmXz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bS50jy+6G8Uh542JhoewOgeV0UOOmnlryHQvEDD+l6E=;
 b=i7VD8MxuA3rMUwWNEeReNnpOU+225ZyITt8uMvxZB5QYKonowMOFJwFlsM0673VNbRIsSA122MaS1LGpd/2OzP0QSbb+pzPMaswRdcV8i5sIhoSUc9v3ohCuntyqeH9OBh9X1gSRjPsq1S9V6iL6UjmahmbvhdPW4C0KX//0+N0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 07:35:58 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::9dc3:f8ac:24c4:9f49]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::9dc3:f8ac:24c4:9f49%6]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 07:35:58 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        neeraj.sanjaykale@nxp.com
Subject: [PATCH v2] Bluetooth: btnxpuart: Fix compiler warnings
Date:   Thu, 18 May 2023 13:05:40 +0530
Message-Id: <20230518073540.2473673-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|AS1PR04MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: b71a3dba-8f00-4ad4-de82-08db5772853b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwuMQ2z/L2vpiLOqNIPCiBOgviHILEH3Ebr0WIJVrwRd+DAMXsZKXWlkLDMOriDb1WhRBBnHo6IjUvNml3JnUE6oznk/UfP1RX5VTnAXO8PGcCORfe0KyUuNErEsAz8vyFRE8eaQb59TJz6CczJN+SC92CeLNib5ztozYunhSnLyqy6w4cvB2Ex7oDimNuiNSXxgBOEPvnBqPGThcTeMQFd+EhsdeVffQanTHV2PEXMWD9WcmVlFVPCTvkBSnZV5PSQiNCeqC8H84NEcRlRMkjNmsZ02fKzG/L9PelrSrLKEVngBLIhqsCoRqA1jmgNchJO1y14hjoSilTZdknuVqx01p9mPUae7Vc1oQECrK+zZfo3eYsWojg7TVuwtTgIrteNLS02r8j0zTFA7aFSXxD9Ir6tUo37FoBJqTh7dvTZJT8RNQOUKPdGNENPitrc8bS0kUc+KsEgcpyIPYNc7SCSemk/gRUZf57hu9JoLrphBL4mdurbC5XlulZ9eUEg2wZoGDqA1nlMdfBzP7jfUkxAbx84oTw4/50CRcNTryBLeMtiVyKqpQDOZcC7L64xOlI4bPQyyplRdsuRU12nEpzdyE42sexD4avGestROme8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(52116002)(316002)(66946007)(478600001)(66476007)(66556008)(966005)(4326008)(86362001)(6486002)(36756003)(83380400001)(26005)(6506007)(6512007)(2616005)(186003)(1076003)(2906002)(5660300002)(6666004)(8936002)(4744005)(8676002)(38100700002)(38350700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JKaDF4ztM50DlSqeEUoAgqikzHdjWjxKWz8oF8mvP2t3WLXqAnOQxYwf63ew?=
 =?us-ascii?Q?Ukp9ZJsnFPJBM1HzuOwqhNnTbczbnNSakv1uRRtY05O50BLFSU9WWS4Gba+z?=
 =?us-ascii?Q?tXnX8lL0woKN1YsL85dsQN+2dpJCOHNZMaOz32rFN7dU/xQR9uBEQ6U56g4b?=
 =?us-ascii?Q?gQD2Zlr2ZnYwP0VYXSfqYCGHN6TAg/n4ETiDGkT9NolkO2H0vkVghucUjnwW?=
 =?us-ascii?Q?qV23ysoo8VDVWRNKcoZNNxBsfvDBQcGkOER0DlHk+naPgiGR4e9alNsmiXS6?=
 =?us-ascii?Q?QV5PLcLitGakjBKgSS/t5ovNuElF94DhbMULjc7bkTJqP3sgo8IWoHpb/nzS?=
 =?us-ascii?Q?sIzdYG8npgTiQ/SFowIb5L1xv9LZrT5EiyPpTpzzpgsd5sgR7iv4LiSzBQR/?=
 =?us-ascii?Q?85wIgzSmhjUmVeVIxYlqY8kU04oY/iHvFCKxUmqhBGGUNVay+jKNRzu4PKNg?=
 =?us-ascii?Q?/OiqGfgfZAHal1BO93shquf+8I+6tAVLw/c7zRF2uUUK8RyApD3maYbtO9De?=
 =?us-ascii?Q?WRjykAmUx2dKPG0bkAy4wvJpB63U7X2athzxYlC582R5muIvDcq4IAMP3KY8?=
 =?us-ascii?Q?oXYNUkgpd9SGZog1Qr+/RJ4GukqOFCKBrAHXK6tKqpPOBSmw/L1QfXo1yAVZ?=
 =?us-ascii?Q?l2AS0mvadWb9gi45GCR46qq/U0LiNqOBpmPTloozUa+Grm7JcSN7RT4lvvmV?=
 =?us-ascii?Q?vfbYYyJ/fLEKZsyQG16s9P4Krp8PAJlT5SfSS5IVezBl1I6S/yxgN9C3yxm7?=
 =?us-ascii?Q?FhtxL9riE55iN8Uw7jXSYNjzYXsebjpfX4jmSps4ALwZDplU4rQx8r4qEmdv?=
 =?us-ascii?Q?nuJvL3P4hx+1ut15kPP9VdoLjJKl3rTRubEHCiLBQ1HEl/PZIo/Nzu0+51fD?=
 =?us-ascii?Q?9IJ9V4lv9grOP/tRoXaJw4GCulWrHaZuwc98SC2Ay+5+lkAZm4SLfApScnse?=
 =?us-ascii?Q?OJZaKhoU17BECfy0aPDeVXLpiEL8pzIRe7Zk3D8clrVJTqgszQr0CJLMp0Q2?=
 =?us-ascii?Q?lsIqeRqfzDuR8SPOGlI+feWhKDJMHa+ujnwDMRC5kmzh8mdOjkxnaPTYlSDA?=
 =?us-ascii?Q?JZEhAJGaUtCxoR6aXuBZKU40VOHNPnk9ICV7H3wsDE1mtgi1zE88oGN6xvL7?=
 =?us-ascii?Q?IQpbviwdYy7L7WCvjr87Ac9K+ugji0UEECnSxHDG6YjhdvwYYtAdpSHzHfJK?=
 =?us-ascii?Q?kwY7Zf228XFQ3lHB/Cpmty4aL2ONUJx+Fv1X8GiWJj0UM0AoiU0xJb8va/tq?=
 =?us-ascii?Q?U5nj0yrrUSRlbfblbef1wnXZFz4rCE+hEI5RWOZPbAUHeGlE8rY4sIcwdZwi?=
 =?us-ascii?Q?vhWRXbckWZq8mVK5NGSeuI9E9RLJQpUBvRahwa8YYRcHz96IyEq7X186CYN9?=
 =?us-ascii?Q?A4YVFRUQqPcyuBJtFzJNHOomg5xy3UvopwS0WEYSuDQwRyqiXh4htgPQJ4Dn?=
 =?us-ascii?Q?WX9WzT3Ia3ZLY/dmHKuu26+12Yde4rLKWWiozudDRDcIkqmzF6A9dbridSjv?=
 =?us-ascii?Q?syw6udnoE+gB13iU0XosyfcgimzsqO/AdMZjlo2+AbqrD0s4bee3xmc2eAbi?=
 =?us-ascii?Q?Al1tGcnswRAInfbAa9bE20ZqWyOVvvJdxCfpVhhsxtjPvw2RD57TJdguBQGg?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71a3dba-8f00-4ad4-de82-08db5772853b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 07:35:57.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Fr/zb/uJ/HHFTezDnP3lsaPLYR+AWbpZ8PivHwfceFNAOgV7DTGHTY3damKI38GhXAPum4hoSuLiaCWTj6zdnFqXVo9ej8gZ7g+6T1oHqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a compiler warning reported by kernel test robot.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305161345.eClvTYQ9-lkp@intel.com/
---
 drivers/bluetooth/btnxpuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 3a34d7c1475b..ba8093367f9a 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1319,6 +1319,7 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	hci_free_dev(hdev);
 }
 
+#ifdef CONFIG_OF
 static struct btnxpuart_data w8987_data = {
 	.helper_fw_name = NULL,
 	.fw_name = FIRMWARE_W8987,
@@ -1335,6 +1336,7 @@ static const struct of_device_id nxpuart_of_match_table[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, nxpuart_of_match_table);
+#endif
 
 static struct serdev_device_driver nxp_serdev_driver = {
 	.probe = nxp_serdev_probe,
-- 
2.34.1

