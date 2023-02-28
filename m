Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0206A53FD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjB1H7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjB1H7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:59:08 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2491D925
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:59:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5xhZRYjZFEK4A+Y9QicLLgqQ2FdedIcTMpLeaYLcMb61N2onjMtA0bR2z5wg1P9EbT3IhR90Slpy4TK7Vub1kNNDMJ5SycBJNTG/x+9yaYsYTqdWfzZLeVVmbCHrmI+81y1Ml2uYhSXGW4vJPhaDPhhlD25vbb5wgi14lotYNZLiqo0C0puSvIh2ufvAEllc5bZLtbLCQ47QmdgQSXGpgYxlGA7NPQyUCH6jtyTn9K01XM0a9MlWk7O4cPgLp4b6t93Ktxqbr+JR6l6V7PhOtS7OlYmUecLPf7wwNqoz7vkcwVC2Q0uUXNJXVT5hEkxFdRyjyvD9T2w14BqRIM/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrRKWYVZrkoVT02mvTILRC4R+wYTaf80PEDmwEM9UMc=;
 b=RwYCY9z/hNxdXRtNBMdrJU0MJCW74D0QZ1Wi21/yyhlEA30SEJnjhGc984IE1bHKR7jWeLZpzX2FVLv11gLHLQBdMR9YrQPY/cuRiy60vaLn3EHuGbMjP+BtEAvLEVtUvkL7nKfoJt9bKPREv3wI6krG2PVUcXZeTsIkAqJXRpSK3Nqw1/g9/RUCcEUxTSMoBzYi+QcThpwBaJcxT+/JZAdGdMTo34pyYTflQauR41K0EM7pZpQVUdHneAunTy9H7EJB/+4vWpxDbfkppi1fl5Png6VpkzM7IrMBeGeK7dmBbvE0+O3Vbg1NGZRH4g4xP2wpCZ1118fVmUp9Y64JJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrRKWYVZrkoVT02mvTILRC4R+wYTaf80PEDmwEM9UMc=;
 b=hwxh4D+MEIfH1cKf6ZH13cdhEb0jS7RuKfPzA5yPPHR8SRFglBttz2bEVKXMRxKDjRVTqaDgtTFej87LFuxhCLEpaPvS5x4KxSVuDorHeW1yRY+2vqIsaGbqyXxh4fwqj3f0OWZWiVIKtVdPp0rLeJD2l6WaOESvn5VJ6ozglz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AS8PR04MB7685.eurprd04.prod.outlook.com (2603:10a6:20b:29c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 07:59:05 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 07:59:05 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jindong.yue@nxp.com
Subject: [PATCH 1/6] soc: imx: imx8mp-blk-ctrl: Fix typo of imx8m_blk_ctrl_of_match
Date:   Tue, 28 Feb 2023 16:05:27 +0800
Message-Id: <20230228080529.412669-2-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230228080529.412669-1-jindong.yue@nxp.com>
References: <20230228080529.412669-1-jindong.yue@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AS8PR04MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f0706c-2fc5-495a-0257-08db1961a951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Jfmtc/6R2lWFKJzeX1MzILixQMpp+sUke7lz9Whmjra7TCRYEZeSyMDI5U8MPySGv9W91onfZQNkzRE58/k9Ec4SL8+eeaVgHUYR7KIsfEoy37WNNxQAaDjRnoGARJV8QVYk0uwOwqBWtRyQrkAPda080NhKM/0PxHYBD7fPBcLDDGrCbw8/PQErh5LSNLIyYjwj141GAWjxCuyojmMTdLOsMrW7qHq9r1mCcTGpbIyfs0WKkfvbqIMax5EwVm2OSb8yNS2ws3uKsGmicT3DpIxRNI/fxTQK0OT/iJYclq1kRGIk3TEXgcbVwhwYAL4kOsU0fgWFpCNWOjSKGvbTNY3aOjXR7wn/S6TfppNmtyxlqD1q9ZJDAqDEGX4dU3zB5W5+dGPalPdVtSi1ZcUznsfIEtZnsNJPL3qJ169nktQp08uxZjpfHnTS7CJYQjrZSmeTrX64aXfzatFIxRCRZxebOilmEZXKjEe3oAyLWmRtZxQobp4fyDPybavq+R7/ZorxPPcHFIB0RH5Lq+9oBEvuVPYLDSS/8teL0YzOr0Rz/RRFlTVlDBTBu7Pk2mIFgtJrqx2oL9as7G6b2xemGpcreKYWRAv9yqqVhUOFq0HVPIsYXW/Xa6S3GtUQaw1p3dlE9BJr/n+7WgmbIvAkkqP44U2FRP+fKuxBxx0n6cGd5OjanH/iiW4ZI2vgV8uzGvh2eR+fZ/6CMxajpGiRQNVyT+jXLXQeunr7SupPwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199018)(83380400001)(316002)(36756003)(4326008)(8676002)(38100700002)(38350700002)(2906002)(6512007)(6506007)(1076003)(2616005)(478600001)(186003)(26005)(52116002)(6486002)(6666004)(5660300002)(66476007)(44832011)(66946007)(66556008)(8936002)(86362001)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDM3SG4rRVYyVDM5S0VlNTdteEc0NEVHWG5vUzhPUGdYSUpydHRkejBIOUpa?=
 =?utf-8?B?QXNuMG8ydnlRK3JPcXFMSjVmZ2xubEd2QThBWVNhZEpTZWZmN2VBcTBmSkZp?=
 =?utf-8?B?VFI2cnlmcmRmSFA5V1lUb1pRK3lQNzFXWlkzOUxsNVRoNzZiaisvTWNubitW?=
 =?utf-8?B?V0tEVnZjZ1huTXRQME0vajVaQzhYL3N4YlBoRjJFYzVnRGk3YnJ3MlBYeUl5?=
 =?utf-8?B?QVphdmFxQUFOSEkyRy9JcjZ5WnQ1cURWNzcyY3dlU0VGd09JQTU3T01BSE1z?=
 =?utf-8?B?MTNEOFoxS3RwcHhOVno4OFFmelZ0bDFaRGhWQnNOUklES2F1ZVdLQ2kyVFBl?=
 =?utf-8?B?UGtWRmdXenNhQzZWUGFnSmwvQ2R6ODRFK0ZXMDMybmZxNVhOVWlTamZFQkF4?=
 =?utf-8?B?YlVGS3FFREJLTUdHTXZydHlnVTQ4SXBTZTNXZkhURFhRKzF5ZThyUTNVdXJN?=
 =?utf-8?B?U0JvY2N3NFdtK2JlOGltRkdaTFIvY1gwRm1qckdBTjRRRVBKd29Cc2dQbGpE?=
 =?utf-8?B?bHJJTSs3bHc4UU9nV1VqNXNtMnNoTjMxN3lvdjM4bnVzd1dHbUE4L28wVTRp?=
 =?utf-8?B?TEVFYUJBRlV0NGRucUxsOGc1S1FWKzFJV3RBUEw3eU4wTmNWUmp0b1BBL2xy?=
 =?utf-8?B?cVdDRjhKZ0JOeVBtQnduZlAyWEwyT3dWWTNZQTN5KzgzamtZUnVuekhEWDN0?=
 =?utf-8?B?KzBiOUV4Zy82SEZDcGpudUJHaFRlMENDbEtNckM0MWdhdXN1L0ZQZTQ5SUhi?=
 =?utf-8?B?VmZJN3V2N2RIKy9SejBQOTVJejlEN1A5UjlPcmNBaUlCdVZRMXYvSFd3NjRu?=
 =?utf-8?B?M1EvZ2UwL2RISUVya1VmT3ByYjRFSVliWmZQSU1TQTNJS2dhdWtlampFa1du?=
 =?utf-8?B?UHVZUDdzUkhPTFhjMmtwcTgwZjJCeVcyMy9JSSt5bFFBckE3L0dhYmc0L1VY?=
 =?utf-8?B?TnRPelhadFgzRFlOU1YxS0dlQ2NaOFBVSGdFdncvNkx0S2MySWJZOU5KM0xx?=
 =?utf-8?B?NjBXV3QyRVhPQWk2Rm5DK2Y1SThtV1lZS0FFdEI0emJFWDFneDVON0YrcUpP?=
 =?utf-8?B?bk90dC9WTVNwU3g4ay9Fcm9MNVdKVFJJWWNIRmttZjluRllZY3hDcHlHNm5x?=
 =?utf-8?B?M2hqdGFoUXY5M2ZiYnpza29TT1MrQUlVMStTYnpqZjMyWmFKZFF2WDFaZVUv?=
 =?utf-8?B?Q25UZkxLVmt5MktUaXFLSXFiS1VOWFhVZ0JZbXFVUmh1WUh1cGVlTVI0T1ps?=
 =?utf-8?B?dzUzN3hPbEFFcThZdVUva1dSN3l0eENXRzRGWFVDUE1aNFh0enNDY295dVdh?=
 =?utf-8?B?ajlRYlBEZWcvam1ZUitrOUNkYzlPZ1FUYTFaTlk3amZRdnhLUDdHdWpIcUgw?=
 =?utf-8?B?aTFQVW51dmVWalFYTU5uUDhzOCsyeWgyODdldVY5T2lGYks3WE1wbFhpWlUx?=
 =?utf-8?B?cVZtRHVaWFFhSlRrbU1BeWdicXFkcVNtQUtEeEpsazM0b0ZSSnJSZFBUOEl6?=
 =?utf-8?B?KzIyTUlaRVlscU05UmJCMm1DVDNSZ25uUUdlMzZQL1VtdjFwVCtCM045NXNS?=
 =?utf-8?B?L1dTTUprZkZaSzRGNVdaZFE4ZWxmRTlHTHVhY01Vb3QyQ0JLdUswZStpOXdh?=
 =?utf-8?B?OGovN1M4ZXlTcVJXWWU4TWo4ZjYranhBN2YwQi9kc2tqWTVDQ3NoenlWQ2VE?=
 =?utf-8?B?b3lKdytyNDh3UldNR1htTzZFM2Z2WjRnUk8rcTFWY2NJZ1ZMOGQ5cTZFbDBI?=
 =?utf-8?B?MUR0VnF0UHgwU2ZtN05OeWROUStUckRQMUFQb3M4L05SOGhIcEkveUdYaXBG?=
 =?utf-8?B?c2d1Sk9JY0tyd0FOOTdReURtSVM1NzNTbU9IR0JyZk8wZG0weTg5VWQxdElt?=
 =?utf-8?B?YTRKb3NIWlpSNExsbmJCT2xiU0NRWFliMnJpbC9OVUZTTzJieHQ0akFGelZO?=
 =?utf-8?B?V3NBeWNCOVZMTVpNNmg4cWthb3VEK0JXcHNVZkQyWVNIbU5neU5HL2FkeTg0?=
 =?utf-8?B?VTREaDVKZEZ1Vi9hRTBWMmt3YysxRXBkTkovdncwc2gxS1l4TWYzTmkveG55?=
 =?utf-8?B?WERPaXE0bS9pcDhrQWtjbFRMUWJXN2dNaWJpa0Z3b2FiV2EzVVVQZ0dlREFs?=
 =?utf-8?Q?Nupd5/vXg0LrQgEcZNNKxT4fS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f0706c-2fc5-495a-0257-08db1961a951
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 07:59:04.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxBuLVfjn1n8HPhDXWFjCGRNW0eDMkZjTzvSOdZ1g4sWPrD+Aw7vleQO2atGSdummS1XLcqjbEIJ+uzosNmJkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7685
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once set CONFIG_SOC_IMX8M as m, following error occurs:

drivers/soc/imx/imx8mp-blk-ctrl.c:747:25: error: ‘imx8m_blk_ctrl_of_match’
undeclared here (not in a function); did you mean ‘imx8mp_blk_ctrl_of_match’?
  747 | MODULE_DEVICE_TABLE(of, imx8m_blk_ctrl_of_match);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~

Fix the typo.

Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 0f13853901df..33fdf5dfe62b 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -744,7 +744,7 @@ static const struct of_device_id imx8mp_blk_ctrl_of_match[] = {
 		/* Sentinel */
 	}
 };
-MODULE_DEVICE_TABLE(of, imx8m_blk_ctrl_of_match);
+MODULE_DEVICE_TABLE(of, imx8mp_blk_ctrl_of_match);
 
 static struct platform_driver imx8mp_blk_ctrl_driver = {
 	.probe = imx8mp_blk_ctrl_probe,
-- 
2.36.0

