Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8515B5F770B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJGKsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJGKse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:48:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C45120BC6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 03:48:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVkpD6at8SDdaMY72hUyUMbKMI0YL2dmGc9gbq/B+cEAoDtYH8rZRAawwxJxLaJe1UE/NhMSEzlDEym3UjZqCOixcQX4U2kZSEuBQ4qLrvfvugEa+dazx690eFoqXVQBOtl1Fqb0zs1AA5GvTPiwvQWPgONw4CMYki9YgpY8hq+ZKTMWqrhg6dXChyiiYHQBp/5PtrSrk+Spn3Np7cTPr6BOQhLE1CauLOrWJyn0FKP/vxzhgZP0izBBWLJEl8eaSrQrYThRdI/saGgfAr81f2/LeC3CyomilFbOp4jB1NXoSH+gVe3JN1ju9vGT+6W1qYff/zPqSeHA9BO0GmfS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW9D+BSmI6pRhbYTKCGKsKv+BuzjNz4WwrRy7sRVd8I=;
 b=n4MzYqJ2trZ/IMe4A0N626FdichAwrFThsmWmAR5DP6ztNZDn17pLKKUFBeQAWV+ji+rEWLE5GGDRk1p+7gm+XWeT/ZEz8Rpg2ElOdVSc4DwtBczgL04WiAbOexxTCRMKRdN6DJ0uoX7Qp1eU96G4TH30WHtE1Gqt2fm63pfC2M0HmXYh5W3emyOixSVdy6jVcw2KrnCqkfY2nY4IpYGlnanHfaqUnGNPmRT/9AF2Ztb7PXK8SrDbZZTZFL9rXeOHilKAqQ7LnP7vzdeEO42ClbnVYc/1XxgFb8PSgw35duhKm0+6x8qfFpNAAiPR1pwcsQuSR4XdydWeRmPeXM9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW9D+BSmI6pRhbYTKCGKsKv+BuzjNz4WwrRy7sRVd8I=;
 b=V6XV1qGNoKk04Sjv4wlqFHhNJ1ZKmnk7LkmCVFPtaGif/PzJ7b/0Fux34XPHmtyEC0tfSbWcomXG1QogiMeay2q0tFYcNHuaRK7LoPP+zOlf9znJSW7SOZHE2ns7INGQG6i9Dw90kv5mwSsME1VnVDLy5PAbQtt7t+KgUBgaXMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from PAXPR08MB6494.eurprd08.prod.outlook.com (2603:10a6:102:154::16)
 by DB9PR08MB8457.eurprd08.prod.outlook.com (2603:10a6:10:3d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Fri, 7 Oct
 2022 10:48:28 +0000
Received: from PAXPR08MB6494.eurprd08.prod.outlook.com
 ([fe80::3c25:b934:e13d:d6bd]) by PAXPR08MB6494.eurprd08.prod.outlook.com
 ([fe80::3c25:b934:e13d:d6bd%5]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 10:48:28 +0000
From:   mikhail.kshevetskiy@iopsys.eu
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH 1/2] mtd: spinand: winbond: fix winbond lashes identifications
Date:   Fri,  7 Oct 2022 13:48:19 +0300
Message-Id: <20221007104820.198938-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::34) To PAXPR08MB6494.eurprd08.prod.outlook.com
 (2603:10a6:102:154::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6494:EE_|DB9PR08MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: ba979715-4610-4e1c-c88c-08daa85177db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3y+WKAip/xh5zr+B+f8S3Hyj9hQlp3YGksfCP8Q3WUMFaV1z/h3Yyrlt9RjFTG+YP6fSE3AdjGeoQKPc3InJ4JwxnvYjqyeulGaJft96cyb/G/noBQBCBnBTsqn6hCwNGFBtatXI1UXAu5b2VGgvTHh51gqqDCLYQFB8q4+asekihevLDbWnkJa8pQRrXDbk6Ta2KeGCM42XE3gH+bXBqiRxEhSEoy6W9IiQ9pZV71nDQ9jjc+nzHKfCwydj3tOroiaQ8yjfrus8nszOTIKFFtryZxlazKpntYF5kwS+WBiUCRpl4Nj/dCYoKnqS6s9oKe6Q20m3ykpIdPiLBg2Vs0fEWr10ipvVgfBrDFakmxiOskzgYGrouAQbuooR1oEVeappTW0/bzetPaJLj0j1LrOlxiouUJGdXvTAoEXze3Ba7trDH1753zf8urjmQyqb1DBt6VqnBS72Xnwunqwh0+7SwvEKFZZyXVmGDezYkAhWqoA7UgPZgrR2pmv1yzwGJ6yIq8df5aUB+9KuKCMyIoqzPXCCo+oOGRWLoYInId7DiHUIQbNSg40gW2884tNu9C9vDif5RbykWq8o1kYkfppXRuN9H7eEkzIAO8uSBENPItUNwi74mEXXUD1L7uJr338oslafz/qC6JhZ4xewbcr5YZ+n9453a5YfdmNlOQtF92yA9Hm8tpEwvn7WMRL+kh01sI2MaLwOXxolTtO+DyYwx0yC+k1zWuZb1M9Hir/M3R5NlEzQ3844wauJzMjGKAkdM5KvfGoOd4ijXE9TRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6494.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39840400004)(346002)(376002)(366004)(396003)(451199015)(8676002)(38350700002)(66946007)(36756003)(66556008)(66476007)(186003)(38100700002)(1076003)(41300700001)(6666004)(2616005)(86362001)(4326008)(52116002)(83380400001)(2906002)(5660300002)(6506007)(26005)(8936002)(6512007)(9686003)(6486002)(316002)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hUNcGgEZyju1Wwc2GLY5gJ3uYoaLY8in+Hme2HmfB9cZAmnNPs8KqLgOAXmd?=
 =?us-ascii?Q?P8B6p3JSk9UjHrCdgj9x7YL3ajIVj+EIw4AqMFDjk/KWWBdyyxtgqVoxNh8/?=
 =?us-ascii?Q?of8eBN0nm611O7PDyA0VCUx6rtBOWyZ7inRcWN4p+0toyhNz+bo0DtDKxLaT?=
 =?us-ascii?Q?5t7sLOmazcCtIWJPAa7PDJHmSpL+6e+BGN2St6XosQUL9UevKdvPlOWczbO6?=
 =?us-ascii?Q?ii7J7d21Xp5jBRTOPXBuzPv+qAVVk9UBrDek1m2/3DP6Jm7aXgC04dx+7G1q?=
 =?us-ascii?Q?9uAsrp3TBDEvumsVjXB5JwRz8xPSedz0UKNeJ6icOnqPPXiO1IetlNHkq6rz?=
 =?us-ascii?Q?PoJIY8EEhrybIY9XIZOmI7VXLmDIRJrIz+H0fl4NVtOQ42FR7rcXbpMCiyES?=
 =?us-ascii?Q?06fkgELpt4tHA0V4+pIEyyeO66SZUdT0+aP0S7jxyVzRDvwK5kdZIxayIf/p?=
 =?us-ascii?Q?rJBEQIz+wpsFSnsc7vqCA0ZW2pATNWFaHGVoqsAqG04xQKcC3TLMnClvgdup?=
 =?us-ascii?Q?Kz3/+somqoHHM/Q2VL9XB+nOw57gQMpAc5veK6/YnTGvahcgSTTlIGja+63U?=
 =?us-ascii?Q?Q+2sGsIimuftK5N1waejX+hBIfL3vrKXJTCg5fWO8+nx/FnDgc2b3hIIfkoV?=
 =?us-ascii?Q?7MtPwQtbM9db8RYKCFJfGRlBddM9D8y4PX4I19Cnmxw/R8dZTAbgLfuqQnPf?=
 =?us-ascii?Q?eNHvZkWFc3PL/lMNTnKox4PE6dRznrTioZ7511BsxMQwbH++hUWm715P5Kjq?=
 =?us-ascii?Q?KAjxc7Q/+N1asKMVz/wYyH3nPfl0oVcAiaxt7My4q81RP0V82v+oBhJjpPaK?=
 =?us-ascii?Q?v+hfTU8DwNQlmXWdXYsMLXb3pd07AX3aCAqzsMG2vSMt2Jif0Lh76639Yxfd?=
 =?us-ascii?Q?RCmULjAdP6HyRgae/dXjgpvSTC0KeQaZcZcFNN4pZepKOmQIv26H/LLs+VnC?=
 =?us-ascii?Q?zGH4jRqRb82jf+Z9b/QHp/E5CCONRQBapPBgrs4y9WAQrnvUXUAYUqaoYgA1?=
 =?us-ascii?Q?t5n4Iz3mUi3WUS57daviqID2Xibi4GryXyXWvoIHCLVv4dJEjGxOhGSOYTO8?=
 =?us-ascii?Q?84I7ia+FEBCZqu3jZlzHhOP3GjDkZbJRiMujGjHYmvIdDVwTOFRctz7r1TF4?=
 =?us-ascii?Q?DsSG/MB0SfJl3ef33wwaFbyb6o+2ZWFzrtftNR/6bAtMQgIIFOrnUAyR0F1N?=
 =?us-ascii?Q?C7AuQ8xkLGKn753KgOxe8xAUeug1qvaxTjON+08tFfn5voqWkfWawhooYXrS?=
 =?us-ascii?Q?qxYnEo5U5nOur7FK5Eb29hRibujO5PIuUXczoRLIUUrM+EGM1xdw2AR/y2hE?=
 =?us-ascii?Q?JuMMngLSGP17UXeCa82kbQ6nNtHn8Gr+HtmT4RfiifEc2CoBz0H/HtqehuG1?=
 =?us-ascii?Q?YnL89XExlNOO2x+BI/mApDKT2sADLSKjvnyVk5H86B7kfEjLaoBDPeo1a6cF?=
 =?us-ascii?Q?KB4VYQSuZjWN7aWvh/58SOZtsSGvBXPCeJjPJE8loAlwHartRenLUbjRWNTU?=
 =?us-ascii?Q?4sa+JONqd1BuPOzex2VmGCol/Rz98tXVyrxnOTLu+D+97Rnov3e50ekbO/CH?=
 =?us-ascii?Q?oDJh5s8bFKYZ0WKkyD7d73ohFgJV2M+sttBJHSHOCC8guSXVXlRs7XwBKV1v?=
 =?us-ascii?Q?qDVv69rQdOf5PKhKAIyjiUM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ba979715-4610-4e1c-c88c-08daa85177db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 10:48:28.4631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKJlIlVwTut+Pb86U8WegfTSV52OGBGfvpSItwf4mAOoBB5ZObJJbph2iaqjsZf6QM7Azt6cDilvEy2RLmzRUHa76Cc03vKRJgrvljcKF+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8457
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
idenfification. As result Winbond W25N02KV flash (id_bytes: EF, AA, 22)
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

