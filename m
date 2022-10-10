Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BAF5F9D12
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJJKv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiJJKvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:51:23 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150070.outbound.protection.outlook.com [40.107.15.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCE26CD39
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAKhHeYc8AxG2jxkjeuG9PS3I19PBjUkTrXuw3G/hFQck1mD2693XzFoanuBM905saEpaihr5bZQ6bcbjYgh6EIw4eByXgAbOrds+Jl11A5v5lvV5BfAZIfdaJ39U4sw9xLiYUoucFWnPHA+pMgGAe5MP43WQquNe+iaenrH28UR64VDx2ifUvLFzpkkKBbb3YRtCS63hLCx2SZUTxv3OBwnNxerEmER8/06mCOjNU+oT5npdlcm40cBKktmznLA7bNueYrBZOxEDieyugctVSrf4QQiM9NoABmEKq7UUo5W+frLBxFCu0AsfF6ytczHv61qIsOi2Q/pE/JkF/DxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w2wsR8YAxzRtF2q+Ct4+YYFtFleWgM4fnyK/YaNEIs=;
 b=aOwQrnSNb23Zf4vdUax7SuNj7qCfvkfoeuxiN2vOcbAtfJeKIL3339lOVH2BpsENLUZ2GZ4LaFYG7nYf+ToEspQ0b/ozGfeh9Aaf/6O5591RQaGgyF59idLkRL2V1lRpoCQeDkEgtnJP/HUjQosSKiLru2HatgBQgYkRxx0/l1sd1Vbs/Z51bpmal1qy1evycZfoCITN6HQPeTTaNzDSbJi9RzoE7XrC7NzIqipHU3+kPc6uAuRZiM78VLHWsVaoGO3Dj4m3liY+W8r3LeQuGdVN8sudSDFNXDhKujBuN+4A/SIMo26BfFcG7UM5fiR91rZ1fE6DrSG/WcFk+vhTrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3w2wsR8YAxzRtF2q+Ct4+YYFtFleWgM4fnyK/YaNEIs=;
 b=LwQAybg+2f/82Zq2h6vh/c66e0JhsI8m3RZFPFIWPOjhuMFINLYtX/rM//ZIhwpvvUhn1/dOCEjG/hxIuoaejRO7jU1ZYMZP7Kv6Jf8HZLAjlIneHauuoQe/X5juh84CfEK1npD9dtmiJEPkQ+ty/H14T9z27W163ZflEFe3mP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from PAXPR08MB6494.eurprd08.prod.outlook.com (2603:10a6:102:154::16)
 by DBAPR08MB5751.eurprd08.prod.outlook.com (2603:10a6:10:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 10:51:18 +0000
Received: from PAXPR08MB6494.eurprd08.prod.outlook.com
 ([fe80::3c25:b934:e13d:d6bd]) by PAXPR08MB6494.eurprd08.prod.outlook.com
 ([fe80::3c25:b934:e13d:d6bd%5]) with mapi id 15.20.5676.040; Mon, 10 Oct 2022
 10:51:18 +0000
From:   mikhail.kshevetskiy@iopsys.eu
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH v3 1/2] mtd: spinand: winbond: fix flash identification
Date:   Mon, 10 Oct 2022 13:51:09 +0300
Message-Id: <20221010105110.446674-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0118.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::31) To PAXPR08MB6494.eurprd08.prod.outlook.com
 (2603:10a6:102:154::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6494:EE_|DBAPR08MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: d72ebe77-45e1-4d36-f0fe-08daaaad5c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lt48biilAVxzBbDfxHTADZo5G9KcC8Ke+tzehI0O5BSYAN+c3soibGGqon3Emu9d8ou6hXTQOlKh2QopLwMCpuQw/YKQQFx+2HupyrBWHb6YpZeRk85mMzGiA7dA9gqWlWJ4yki/1KfOSZj5IxVEHG14H8kBldyS0HAATjfdVSVxkD6aulvctNd5fsW3lzMyF9WRBZUKQcy01a5i//FbA2/HdU9uR13NxZcz8gy0s3J0FHYX5xwdyTtIhj9Nm1MabpzeuS44WKDhN1HnjNrqtCvjQ16j7hEbZmu9ik99Ft7qnhLVZvQLLrLlAX5bNeOaOdyZWHXExwD0DRiOxjFh3Gb1vNmmyTl0xgcBc4RZ6sUWFXhisHnF+PaQ+Hmwy71opowT2cqZ+Gj+W4QOXitdP0HCiCi5jV60wFiRtgRNTLgd6BUnYw0IY3WCroVRQjY6AsFRECUzyxH571FuQW44RfrHZ29tBd9gkWKLjujLqIgS+RgKObSYv/JmCRFIZLvrcnDi1ET4Z/0cwXmrggxFYzIClub5muJ80CjIqMNaRo+olnVQx/wRIq0A//smiQ2M3bsrrUUTL61g4xVJSRohpwdkHzTkiAQSsTQC0KF6UHjBiiOwAF4wSBsjQytyVHeU+dKDWdXstU4Z7hDfdguuYP/UmSvDr2w0ChSnhertjpH+pIuLlYR0vmk0oBG8PQ+K5UmjSO/j8aIkUZie63EE8iBI/829w/ZXOQbv4k/ugmE87gSGH+fG8OZkacbWy53hsS3cCf0WLaRnc8HCCUYVOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6494.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(39830400003)(376002)(451199015)(52116002)(6506007)(86362001)(66946007)(66556008)(316002)(4326008)(54906003)(8676002)(38100700002)(38350700002)(478600001)(36756003)(1076003)(186003)(66476007)(6666004)(8936002)(6512007)(9686003)(6486002)(83380400001)(26005)(41300700001)(2906002)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pK0T+fDwhAkWYCyijoK4aG2cRheJElsg1Xq27E/6VC25Dj3Ms4sDVNgV6CIL?=
 =?us-ascii?Q?oorJEzcOJUyYCvQKri9pRfmlUesH36xrDTxf7vlNUlo94+dzE+WJj3Wa84lb?=
 =?us-ascii?Q?Ne3KnNjen+p3IxDVW4csB+3gTz+xBYL3pQdoDbmzTuCdP6IyDegGXxT6vXPl?=
 =?us-ascii?Q?zCeCa2Y9dD1kIsUY/WjF9GpRvf1tue9LtLQ1MMAl3ZyVHAVTJi5L4YOM4Cau?=
 =?us-ascii?Q?TVL18G4RHYW1H2b5bPGqQVyryZxeFyOIYiwg/CHd12ZhnfU2HPpESfEWYxvG?=
 =?us-ascii?Q?mkma2Ml3nHccRUgJcfUepr/KQiQy6gF/i67myznCVPIGyfUk7DVhXLE4NZ2X?=
 =?us-ascii?Q?bM+5XDYPfWfu6wQ8fr4tkiGvSN17MGlXNR/Y5S7YF89sLWsJ2GaWzbG7/GgO?=
 =?us-ascii?Q?c+2ip4eJD4B24sxgje4fwY7IjLsodyuI7HU+JuzHOmpdYDHvoVCysHhy/xhc?=
 =?us-ascii?Q?XA0kWkJ2+ZhQS3lyimNb/+xlfeYEo2CD6hm7GJeQqbG3ShJrJgf74allJICK?=
 =?us-ascii?Q?zCeCAyJxas2dk6OJ5j+bS7XADmv9B6UQZFba2RAy5mDHjKMsELd9eZeOhrtu?=
 =?us-ascii?Q?DVIVSYQbg3HjkKvhj+y6u96Sc07psuaE8TUloL9a3QD4ekE0WLDwDZjVAsIy?=
 =?us-ascii?Q?pO4aNgj40Qd6Df2cq4glwJld0P/QNqXTvS2cZZXnaWrroarH7rPhcClGlNOV?=
 =?us-ascii?Q?1/zmu9N7io21ImAgYidIG4Zeldx/B3AY8nx7EnNZJGeJJcfNuqLBvPlOE9Af?=
 =?us-ascii?Q?l6nFsTIvH6B7W1tYgJcaDgpPlX2HU0IQ0VQXrFpYM5jEtX9jbC+rMdjJQLUR?=
 =?us-ascii?Q?TwX/srwh/VWwV4O2T5PkWgH0Wo/TvR9nRI/Tse0zWkyw7dnDN9lBPVFbhcty?=
 =?us-ascii?Q?pB4wds1tpa1+izqS+GTT+3SGWSZjnd4b1m5eiJ+Iq9BxKMmc+6JJgg8Ud0Ir?=
 =?us-ascii?Q?ofLC8urAZhYQ4mvHg+3le4EnL5m2VnNM9s3dkmuiouAmktfJsZRWKt7hiCjo?=
 =?us-ascii?Q?O/ZVp7XasQ8MPwPzZBRCjFiZwXgcSrGBgLzC0ZowfXKElftOhDdWVgY07gsO?=
 =?us-ascii?Q?HiyUvUOI+4W0sOz4Ganlx55e9+DAVHvebbJAtIG6VmRg0WzCV/N/EdKnD4J5?=
 =?us-ascii?Q?vrvEc+kv1HfQDFMnPNPgexxrlDo7oZvrVvIo15XR9qx+HKOIGw4vZm+tUgoX?=
 =?us-ascii?Q?K5z3IRFHPSkuxF5jJazV9UQrVe3A4HOcmocfo180i36sAwigtZL7T6xj7bBp?=
 =?us-ascii?Q?gWezVkaQcTtTZovu0VGLfe5yguomV6qsLDVFFhMCcoemKw5rMRHoFRWwmb20?=
 =?us-ascii?Q?uFVtKs7kuGljdexaPHAnfFt6CuiXGaNUZhZLt9fOKn+Igmt0IQ1cYyk4TUIm?=
 =?us-ascii?Q?wkdL93q7CQ0XFZ0VuB87Pb+l0oOsTUPgFI9H1D6bSfFoLzmWaJBJSqjVCFC2?=
 =?us-ascii?Q?3QUYtOnk/GQIlGXTYGG1IIBZraUymWcRAZwKvjRcAJho46to1Icyc7wkN+gs?=
 =?us-ascii?Q?2fjGF2znm8OwhwiKlb9CzInYEtY+4PgMPQQXQ32DAnygCFGAdjzjUmDsEAUE?=
 =?us-ascii?Q?Hwwa70iqTvmmqSxHjvGugDYSOcpW8N2lfDF6kbcXmIT901kfzAwMiPjX8wN4?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d72ebe77-45e1-4d36-f0fe-08daaaad5c70
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:51:18.5816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AFqI1WITHHAwVxyy6h8ZXtBR1tTw8o4TZFSz8xzQ1GeimrRrW3iM+xpQhABBDGmxKSwXzg99TSnh0Sv6Ob2JYcBUg4KBuDgOruMDdx3wqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5751
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Winbond uses 3 bytes to identify flash: vendor_id, dev_id_0, dev_id_1,
but current driver uses only first 2 bytes of it for devices
identification. As result Winbond W25N02KV flash (id_bytes: EF, AA, 22)
is identified as W25N01GV (id_bytes: EF, AA, 21).

Fix this by adding missed identification bytes.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/winbond.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 76684428354e..ed368a55d68f 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -76,7 +76,7 @@ static int w25m02gv_select_target(struct spinand_device *spinand,
 
 static const struct spinand_info winbond_spinand_table[] = {
 	SPINAND_INFO("W25M02GV",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 2),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -86,7 +86,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
 		     SPINAND_SELECT_TARGET(w25m02gv_select_target)),
 	SPINAND_INFO("W25N01GV",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x21),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-- 
2.35.1

