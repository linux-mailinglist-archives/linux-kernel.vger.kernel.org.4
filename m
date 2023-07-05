Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769D8747C65
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGEFYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjGEFYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:24:39 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A8D19AA;
        Tue,  4 Jul 2023 22:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAKPNzvMthhuSahyzvHCSeJJvq0xK6NdRZ2enW6dtGVTor3C6QOClEEZmVqWeiDaBKFo/OGTdcvfvWA/5wBi3VGQ8I07uBvA0orQcXawkd7+JlamBNEJzh7IJqS5Y4kTH2BhwLDmQRJ4TuysLOaA+x8JwtL2x7cT6QlZRSM6h59QiH8TF8P8AEuzevai+pK+EMoKYnGZ7duiqsQjw5LWHkPIQz4N2hugsF7Ay6ZfzP7/gfvXENp2TIRQLVvXEF5Jao2b8+GL3f2oAImI2Xpt5vutlSS8/WX6WYDg3JQDOwbo53CftTmpq1WN2RnuFnF79jlnmhAO4a5yiiMSRnsxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFL76hn98dkt6v0e+RSeiY/wMPeWmcC9jIertAZ77bU=;
 b=JJTRKrd9TI4AQoQdUDUJrdtMPlAvSLgZH0H72Sp8zOGrCfyDgrnP9w505dhSASR8GYNXqELNiaOlq5PquShoo9dHjOZf9fKPiGUCHhqCYrECsUxHRgbGFzxgvbkAnFd+kcx3m/gBEDU62qzABBqJrtgRf2+3sIZfpCEJXVdJwbclsByb+x5mvpWpfn0PeSnJfuVYZLs9NGfwPEg3uy3JFkssIrzm6o8/Ma37CxfGpYjZq6hjDf8MRZG2vMCSIVuiZKRNtIziHxBbmuZJfL8YcgcthR+cpvnZSUqkvh61WH6m6ULlevTOr8t1jRj5vZEgnX6nTGB/WyZm7KZTMif8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFL76hn98dkt6v0e+RSeiY/wMPeWmcC9jIertAZ77bU=;
 b=a1gBeTotJRqWPN4bwQMFUptFjEhlcu6F1UV5iO38iTkRDlNZUuEF+4SO3wx8R8H8wO4qTiLfebMHnMGiddIWJBRiX5FDBkvhs0bRiDbE/fk4tubagM4XLa4iLLBloe7mMVM4vQgD6HFDkdSx4nz6j5EWgD5rCTrTUIgAdJHoN8GtSTss+/sxO3H0xGugOCkwisL/72Pc/LehfFt8PBzNA9NDUlfeAMmCMEGbc60b+PI9JQW5j3RRKKnfgZOy6mEgmsiex7ElM9qYdjrWiT9BxmoilivDgjvImRcJvmgIxkaTWaOwsp2l1AIL9OvkDHzKj64WtA3mOLjtxyV+fMoUIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4069.apcprd06.prod.outlook.com (2603:1096:301:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 05:24:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 05:24:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kevin Wells <wellsk40@gmail.com>,
        Durgesh Pattamatta <durgesh.pattamatta@nxp.com>
Cc:     Yangtao Li <frank.li@vivo.com>, Dmitry Torokhov <dtor@mail.ru>,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] Input: lpc32xx_ts - stop_tsc when driver remove
Date:   Wed,  5 Jul 2023 13:23:45 +0800
Message-Id: <20230705052346.39337-9-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705052346.39337-1-frank.li@vivo.com>
References: <20230705052346.39337-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: a28b9efc-6846-48c5-b3b2-08db7d18118a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTjlDvBpP3Y+rULRkot0Q9z+3LezZVQexdi8pns/urPY9g2o1Me4fIA1uBvS/vCTdPPUAu0HwbbMljvkWVktWA8q3h1CKpVtp20LslPtMxcJquRXn76YJEACjN8Q1PA9nJLQqIX/5MG0fAjt1OQJzEBzMCHX6TwaJCNI+9XKjV4c+/WCPig+956lWz31EDRpuAzURvAPw4m9zNjVc+I37bE94yQc53No3d+aERfRZLoLsaXXJaMnAW30DDdaoq3bvZ71W8/khMRW546DdT2gf8gudCpVv84UDUXew3nb3tS4RNERpMM4lguhjHnpxBdo/eCgUb0ladEMgW0PGSR5cYtPUJ7wBsc0xysY/NbWX5rbf5914jo/eCYc5+ZsUlfYFC5YnBxMjKIJGV7Bt2OtwdwmJnLHhEU2S3s6OwE4LXsdrURJSnUFlXf9Wl2ZQMzbxuGEOCdB/rGypr35XrhiB9rryhqzzB5xt8aJR5hdtFXF/h77a2D++S/VruqDUuLo101A3fRctt/hnCrfht5iGf9b0Oh/GlfiPl19jWclIghXcwr3Ja2gJCsh5TZ81caXRyitrnwlfNk4n6vPStiU0SBgNx6tNrMefHhn0TtfYWRdnlP92tc+SYLn6FsNiUKQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(136003)(376002)(346002)(366004)(451199021)(41300700001)(8936002)(8676002)(110136005)(36756003)(6486002)(54906003)(4744005)(316002)(5660300002)(2906002)(66476007)(4326008)(66556008)(52116002)(6666004)(478600001)(6512007)(38100700002)(38350700002)(186003)(86362001)(66946007)(2616005)(83380400001)(6506007)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j9OBB+iTORszanCCcAbAGgv0hLsKmDgNqZ+gXO2H3ZtEgdHoc9haUBopY4GO?=
 =?us-ascii?Q?FdLTkMgFpDAzrS4po3jxmxNpB/p76ZCTRYjh9WRXdhth/L04E3Lg4huq1opr?=
 =?us-ascii?Q?4LnvNRQ+HDA1FnUAulkOnd2s3nzi1joVi5xBnOWea0bEO3Xf0feSFiLzbkfN?=
 =?us-ascii?Q?MxUHY2i5huFdYU8UsdqoOKM7u7TFqT4hSak9hw4Dy7Qc3GKNlBfLxbjAvm0N?=
 =?us-ascii?Q?Mu/7MwUFSfnGeOfOtfvKq9G5z2JeYFkBwcVxOZ0QwAOykDIMYS0PEA2Er8w7?=
 =?us-ascii?Q?M+2VMe0BSZZUND+nx0Jm+JOi+4eHs0FafmUgImOiBKgGrux9a3AXoiR7Rri7?=
 =?us-ascii?Q?AOVRkNynt+3f0CMVUTyqaTUVejYNdEUGEkhn9vjzj5wyAGioNNDrTDzK06FJ?=
 =?us-ascii?Q?hjZfozgUmvqOLmVMLCrTgq0dAajwWXW8nme939zf36A6e7Sle/eNifwbwuFE?=
 =?us-ascii?Q?xoGqYmndORi2D7vTeiA8+labh+N9EFQrk3gcVejh99Q1eQkxQZsxQT4wDo9v?=
 =?us-ascii?Q?W/7rKDFaoep1EY9TkMk93nMA/jQs+lAxcQ82HqNnt3L93PlGF0pfZPdBQMZr?=
 =?us-ascii?Q?XHv0ruFMajJWUN6wPmmENz7MuNfkfo50cmqBaXyr+nEh/jOhUsx2/Xr7sKAy?=
 =?us-ascii?Q?87lnCl+dB9pI7aCsGvqLVV5mbqi3nN0Rjz/PwAdNLEJcWLbQK/29mPAxyntn?=
 =?us-ascii?Q?tZNtYHc0ifHB6NVsffh9MdQS/TPvhFlj2gC86/aXJMZC1i0HMBIzrg6QXI6f?=
 =?us-ascii?Q?i4WWCgfYdmkKE0YihqWbfHuV6FFL2qEMpRUFlDVLbNosjeiaLr/1SG7wsl+q?=
 =?us-ascii?Q?ASUyRJK/PEOakAuxVc0iHFiE/l9oc9SsAEC3AJ5dnxt9PZoHtDNER+UnkB6w?=
 =?us-ascii?Q?kQZNuHMCHNbBOfX36Td34BFJQyWEGVv9MZCnsn/Iac4KCO5GChYe9hJ+sA/8?=
 =?us-ascii?Q?InlkVPqp5CVfh0cxdFQhjNdv00lx2kjZ56gSyIqY20ks9NHSrVXA35+jKV1x?=
 =?us-ascii?Q?SCq/XMXSpZdOTNWsHF1uL/3EZ8AjnS6sOBrAS2gX2jVZc3syVRQmx1Wpz+sv?=
 =?us-ascii?Q?6UHh/gvrFQxX0JKm8UaB//4I0SOUbilgWCqqIEJrAVz7pYIYC2uIaC9pwS0K?=
 =?us-ascii?Q?Cp1wxtXelmmTTeoENSNyjj6seR2SSE2u2ZIz4vJy2UlJwoqkqR1yaeWDJlaL?=
 =?us-ascii?Q?gdKc8Jps2DbsrRsUTFsmgVwa7RY93HLbv4oqVmSiAYzPNZFof7JZ47J9P1d+?=
 =?us-ascii?Q?tpdWYvvXW95AnhGs002APMEgHBXwedssulRF3uyeSj406IFKzX/L3AmeI2cy?=
 =?us-ascii?Q?iQCbXN6UGlSkTtCsj79jHqYmlit3sbRaXLDyL54bmFvsJ12qAytoOu+8xNr0?=
 =?us-ascii?Q?TLS+MQ+hcGbjsEEY6Si/+F62JyryJVVH8Z/cKAyA7xPdXTPelGlS/7KrkBGZ?=
 =?us-ascii?Q?T7w9PVbimvmGtGRjYyDcH+Jv/snWKSukaUE43uI6sU+e6fANhQ0y04d9Gl8C?=
 =?us-ascii?Q?EKLAv0DiwyL+PogmcLH56WOOpSbNKFBQirw2AvZ9vQWNgPaTKrVwZ3OMaMzy?=
 =?us-ascii?Q?vXOq7g9ty54X4crmGv5sSCB4ZALpNrawYIpduACS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28b9efc-6846-48c5-b3b2-08db7d18118a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 05:24:13.2056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNTrSr4KgtYB2VOJxg+SEauntF0gBhIhg9isHKG7gRTpn1GteKzap5N3dvtAwQSoC1uhu4UDwkoICtQy5Wxxhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver is removed, we need to close the device.

Fixes: 3045a5f5202a ("Input: add LPC32xx touchscreen controller driver")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/input/touchscreen/lpc32xx_ts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
index 15b5cb763526..ffdd748a9992 100644
--- a/drivers/input/touchscreen/lpc32xx_ts.c
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -305,6 +305,8 @@ static int lpc32xx_ts_remove(struct platform_device *pdev)
 	struct lpc32xx_tsc *tsc = platform_get_drvdata(pdev);
 	struct resource *res;
 
+	lpc32xx_stop_tsc(tsc);
+
 	free_irq(tsc->irq, tsc);
 
 	input_unregister_device(tsc->dev);
-- 
2.39.0

