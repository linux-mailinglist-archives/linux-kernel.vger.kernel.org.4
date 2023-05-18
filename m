Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C75E707A66
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjERGw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjERGw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:52:27 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDEC1FF5;
        Wed, 17 May 2023 23:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iL0z2+zfROOOxFSb60Y22o6uq51hRIYFfxKj6qoY/px5k+QhubGPiqyAXEURUUqR2c8zTvciI2YUBijUSq6tM23Sspdd/ITV5sHrxJCPidK50RxFjBbxZRD9kJO3m3DkeUAGFPWufxaV9TmT+ae/mZd5iA+L7SqhWXPvtUqsIpa5yGMDZMu0XoX4W+N2hkV6ohWHmaL7v/tHwLSi5+Ivd3lsJhajPKUTADYMAwNsGDEKilbZtoAMkx3lfqVhv4vEi2mrXAuOuj3y/IWx/jlJRVK75NWoCgB/pDRooNGMbt2RL8iyFjWH6aH0ISOkwxJPlgE/Bj+UB3un+oqgeermSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kem9h64Sme2ycG45r1NMYpw4ZBYSVhAtcHFTtty8Fpg=;
 b=f5rCVFfc9TukVMEWtsV1Fu0ZvxXgnsUl5nt/sylXd2rJvtW9dNhkNcPvNZmen2EIvA8cwCUR/G+1Jg/rB+UAZrtZt6N8mYTTyrh9Xkm4dkuc3+rhWAbgSAGjQphbWfTZk9Kzfic1I0vKKEfBOfQqp/HTdP1s9Drv59/l+5Zsl+1oMuS1HXJh7PCLufkIrjc939LdQYWlqVdAYgD65a8cVFeIlGExiyQj7GZDzR27mEEKKOIR21Uc4BSr+QtN+JGfVd+atAI9PGHyZixSxYZXFcUbjLxCLtq3CMD2mWRSMxwLy9rRxq/gLa3elMVUJd09coQQ92/Y9g7SLnNDOiIxBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kem9h64Sme2ycG45r1NMYpw4ZBYSVhAtcHFTtty8Fpg=;
 b=YPzIQPNdzKQtaR392pp+NqfUMB31YSgxSzxvo+olDtj+EmHh4LCPispPpbWj28OHXI0I7O3TtOetHf5BanmX8Jg2EQhxRMhjaWJJRFs+wJS/nkJG3GweZJsQQDWNXSrQeW8U3a5lN2w9W7HT7I93weD/CxgybiJkT0UObu0eDjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AM9PR04MB8860.eurprd04.prod.outlook.com (2603:10a6:20b:40b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 06:52:24 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::9dc3:f8ac:24c4:9f49]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::9dc3:f8ac:24c4:9f49%6]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 06:52:24 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        neeraj.sanjaykale@nxp.com
Subject: [PATCH v1] Bluetooth: btnxpuart: Fix compiler warnings
Date:   Thu, 18 May 2023 12:22:19 +0530
Message-Id: <20230518065219.2472678-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|AM9PR04MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7bfad8-a0b9-4242-de24-08db576c6f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXhq0poUJ+SXLUQg+0YeibcKVBqoXKNaugiKz8nW693dJ0KR3jg7TxSfXOPUFPE8Kon31vYZMvwJ4XvJ6kywBDIk18eAKCFjwsn1X8N2NzIh+5eFL2SHvqSFSbX4FhoXdFP6GZ2f1FcL4FUI2mz9YcOAq/GTvQYQrYU/RZNWcT85E+2euxmy6+sHrILw3Lhxx8eV9fA1Abod6wOsorQPCMLut9DIen94e3v5GhsptskjcWtUeAHlfQSRh5ucXk2I5haZ+1B1P0lZ+exdrsdjMAoT9oYY9a935KIW9XZ6VOmrA6B/8tAb0qatwiqOayjCp03/YCrNQBS7tNWU4t8xJ4kdQEtzgY1OSPOuPzjKdk8JXqNYoAxszRhZQkhqRQj2onf47MWqfqcIUsO4tOUgszokNKITGIv2sy5BF1M1Y4/2JgbZKnucsTKDeSS71nbec0xmcCP7mCZRW6xFEgolPEQqm+Uzk43mkPnPExWFbFKjnJ8YRZLQtdJRtJeSxxCPHqcow3VfgQ4bE15MdH8YnVC90svixCaj6ciVraFQEYi7vZhCstLkrKyHmrxo04hBq1ZOL6Tc11TNPcAQT3/pYbz+178Rgs9DbNlZEiFgZAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(5660300002)(41300700001)(4744005)(2906002)(36756003)(83380400001)(2616005)(38350700002)(86362001)(38100700002)(186003)(1076003)(6512007)(6506007)(8676002)(26005)(8936002)(6486002)(966005)(52116002)(6666004)(66556008)(66946007)(66476007)(478600001)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yT/JWOoCn/cT4h5Qke61UsoxKXQ2UVX+e0e0R0edleV08hNoNGAsS9jSzs/m?=
 =?us-ascii?Q?OOkRukQSoNtWHk3Xr4O/FG45EJ3PyVZxs1MlqjDdylLiGrHVKQheXXWbzp2F?=
 =?us-ascii?Q?/fbD2/tGJyPyVHiUk0tnpAzpSFn+KIBhWTtMDodvAWPpglEBrJr5rT/T5cup?=
 =?us-ascii?Q?taixusRULauTetG6uT6OR/wA9bH6LZrs5KpPQ5L9kHDeGFaex/DctuNG5cJo?=
 =?us-ascii?Q?njDl5C0XTkmGBvnWgsGLJccWEwxywe7reQnkwnrFKUjFjGIUzCgerzQ1R5JU?=
 =?us-ascii?Q?zdB44k6YjwpIYUB7ANRSJqhXhq/JB+6vESzMPJjR+x4Nx8H1irTzccciOKlQ?=
 =?us-ascii?Q?URoT02uaHalTOVlhggQbU6q7z83oNWgQRXFHuheOEEEUUARxOm3c+0IG4m52?=
 =?us-ascii?Q?HP4frZ2ilPTZExTlM2MxRIcdI29uEqPRi9HWJ3ZQWKt8BxU5oixOuIhR2PLZ?=
 =?us-ascii?Q?BtaUn56A1RFfPs70hT8JI3afy28okJxXcfl0/hhcFnMJmgELur/qHrwofj2z?=
 =?us-ascii?Q?Sp7L63RK+Ug1EJAmDyias4ZOPyiPEF0SH97BvncuGulcCKwDX6BVH3ThyHGF?=
 =?us-ascii?Q?ZRifoUUrG3pk+aYe38s17EUuFNU1eO9lliEZtloFHiTtYvJ3k2yJr/bVEEGv?=
 =?us-ascii?Q?JAU9vZ9UU0wyVO6JKgo8UXJJeWAdimPuOw2pVt8yZwHaUAUU7GnDeABomKse?=
 =?us-ascii?Q?zsM/d881bwClWrRH15oQEqkHWxAKSbbwpBXQQk1BBsJ3EMX5KsPL7+EiWFj7?=
 =?us-ascii?Q?1lX5yl19bUyuAn2E6Ovt84rObL7W1ADTgRs+cQedc/pMJokiEkUAUcdX+uRu?=
 =?us-ascii?Q?c7XicdQ55/i9/BsA/oPaxIqj86bo8aFlsCeNHVeE8I/E9bcEzzZJgzcyaZKM?=
 =?us-ascii?Q?xp6aANNfXL3wl++y9QSKf7UYjIbDEMfk0DKj+MNjrX4oXIjSOmLfUuhX5N6c?=
 =?us-ascii?Q?ra/WsjGvjRTFkLBqtYQZbmXym3hnREX8RKYwWey8I5i0A81S6Olcz1MkPKHF?=
 =?us-ascii?Q?nuSxRhUegLgpw1YsmgPiyX8iZBPvvZZFUemd9XdytkNlHxZf5V7kJ6tt5mDS?=
 =?us-ascii?Q?EDwNt2B5doDJTM7B7Y6j/sTMnqwvUIIewnxfGNnK8aJ9NV/tOcnFMtyqkVrC?=
 =?us-ascii?Q?UNwPRHblSqC8x6WnmgGYtuTT2jZPYI5t5ZEw2KOXLv4phZBghtkbDwBUSwCZ?=
 =?us-ascii?Q?g96htFNDDv8+KJyyZmifyCPWzRGPIhq8iKPZx6G9DdNNgsGcYEtGo/L0rjqg?=
 =?us-ascii?Q?dtqbqmeUKww1I0U1+qd/ibz4RUJIn/q7yNXVkNd1vnpsxu/1/U8p891JPmCi?=
 =?us-ascii?Q?ZzskB1rr0QGLB8D7obIGK5s5qE6a5AgOogHvk5fLn5L6QDHR96JftLzn7Tat?=
 =?us-ascii?Q?MuJS8aAPGECpoAhxX90J6+kpu85ff6Eb0Gv1dE92XYK8k5VeSFGiXdfXew0e?=
 =?us-ascii?Q?IXrYafIOYRgqHMfpUzhPKZbQl+MwkD0piz1Zj1MjaJRBWkoi7oLLSuueoeLQ?=
 =?us-ascii?Q?1cuuFzsHNmplkXx9ls87yGMM2OmUIrotQ9JFpriibf+vDz1PIvGSQjC/COSH?=
 =?us-ascii?Q?+EkbqGuuWh4auQxXacWRmhbSS4JfHNoEN0DeTsUSsdSlG3EC5aRizQSOj7UN?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7bfad8-a0b9-4242-de24-08db576c6f4b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 06:52:24.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /M66EqgJ+dgVNbmuYdfDpiyir7tDO8sMBeOiBNFt2eNSwISimdLIB11xeDUlOKPb/DNXiuGzmzpyQLIghqAhMyymIRdmy181TWhyqcItwIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8860
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 5f641466d695..fa6ac4dacd1d 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1264,6 +1264,7 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	hci_free_dev(hdev);
 }
 
+#ifdef CONFIG_OF
 static struct btnxpuart_data w8987_data = {
 	.fw_download_3M_baudrate = true,
 	.fw_name = FIRMWARE_W8987,
@@ -1280,6 +1281,7 @@ static const struct of_device_id nxpuart_of_match_table[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, nxpuart_of_match_table);
+#endif
 
 static struct serdev_device_driver nxp_serdev_driver = {
 	.probe = nxp_serdev_probe,
-- 
2.34.1

