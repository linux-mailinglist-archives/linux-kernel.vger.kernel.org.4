Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F7273BBB8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjFWPe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjFWPeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:34:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2033.outbound.protection.outlook.com [40.92.90.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA7A2117;
        Fri, 23 Jun 2023 08:34:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkOZSEUCm3u6ROvjRhcPN7t3adDg4P2IhYwhJaL5uRqZqHqBS5h+8qlKh1E6H5txkIFhcnvKu3pdQ/C2BPv9xQYzsqnLiQNG+tx+L//J/7Za+C8CVA8Wdoq32xbebzbLhT4zxIIE6LTdIed0ygbN+5tGG7aJe9QEP63BadHtPed5GHWjb5yJVI93HZXgs+hX0YlVf7BB6HV1eMzUwSc6zgQxqwzmUI6Cwno2COgF8dRr6lVKTPQpkCvQsXaJlIikfZcTBj+Nih8xL33iC3Io9NHchxrRFpr/7sCidwNtgjUgyh1q3kBoGaRonNXDdgBgFztmpgWrMnCokyFpCpLTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLprr/21Fj5NqO0IczSq5tMyoC4apgBU7K5sCy4rKbc=;
 b=cw/AbKiaERlubxZIoFiDbkE1YiHGi/TwjCIQBooxB5hg2LiqeL6wlE3DFLUklzbfYLHLg7tQ4XjY65sZXaBP9GvT1Sv+CofHG/nkXwymwN7k6oj/ItwdpmwvbKuuU03BMGkKpNu+qa+PU6Ry7zsEPFrZ3ufAQYwKgQ0Hjj0zJZZ+EoTM6f6k5+Q7IDb2zJ0+EzBdAQU+T77x8UtK2CdB9yQe3uxkIL8sDc1AdvyR8iPTDJEqLvuvgN1iI1enuxmM1XmLkLE6TKL52DAASYInuvX5IupYNhYV7UCczbGgvT2QezS/uRy3rDfwQgBdaGbKJekEbT+3/KYFgk6xtm8uqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB4P250MB1032.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:3cc::7) by
 AM8P250MB0042.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:3d9::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Fri, 23 Jun 2023 15:34:20 +0000
Received: from DB4P250MB1032.EURP250.PROD.OUTLOOK.COM
 ([fe80::1f3e:9e10:27b2:5ae4]) by DB4P250MB1032.EURP250.PROD.OUTLOOK.COM
 ([fe80::1f3e:9e10:27b2:5ae4%2]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 15:34:20 +0000
From:   Olivier Maignial <olivier.maignial@hotmail.fr>
Cc:     Olivier Maignial <olivier.maignial@hotmail.fr>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Schrempf Frieder <frieder.schrempf@kontron.De>,
        Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [v2, 2/2] mtd: spinand: winbond: Fix ecc_get_status
Date:   Fri, 23 Jun 2023 17:33:37 +0200
Message-ID: <DB4P250MB1032EDB9E36B764A33769039FE23A@DB4P250MB1032.EURP250.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623153337.3818369-1-olivier.maignial@hotmail.fr>
References: <20230623153337.3818369-1-olivier.maignial@hotmail.fr>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [zanMV4eiVPO53ocmI8ZGKTnV7PvRdaP7]
X-ClientProxiedBy: PR1P264CA0058.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::12) To DB4P250MB1032.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:3cc::7)
X-Microsoft-Original-Message-ID: <20230623153337.3818369-2-olivier.maignial@hotmail.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4P250MB1032:EE_|AM8P250MB0042:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af60408-3afd-4282-64ba-08db73ff5027
X-MS-Exchange-SLBlob-MailProps: a+H6FLLcF3qXcYLnbyrqKtqrVM43XjewP5Mt+qMANFqJddK6Qn17WN7r6idc3ocOgfShtwL85AOCKS+x3jEFpwEsh1lE51a3VELdI42C61VRSRWdTGuol4DnIvHJwaSh8hxh7iTN6j2BRl0+mLjV/DIeXn6gDFLnUXNeNiFrzKt0nCQk1KfgcoK600SOhuwh2CHFWEEqkMzz+5AwZYIZnSjWTo14Ct3oRQbjwRhkIJvG2pHHkjQzv+jCgjGZLsfEzfotCsbeB955A7Hkt+aE+oaydFG597Y+Qm4qJNXCL8qu6a3jFLltikjF60Z+b1uhoxQTodtM6ztRdPCO6eMWl4Dv+LYfkwRe/aTe9E3lnyJLprabQ2l4Vss57bFAC0lpjDD3xAfDsSjzJlEN2UDbIvJ0VXscfXRd/nJ1Xmbrq5ypGD7MBgirweeL3grJY4S/76ta+JZAEE6VtMNAzv3EgJbeaP17vKRMJcDBCz7YfeWX4pGrlMnPaZ6A4RuuS2WGFQRjeoyaHx1QP2aMwY5vniSDCe1agCg2UId4bhqo8+PmsUeL8f2v+dpmbK0eHio57kc7sZ5yA4F/qtbQt65mf91JPNvv9q9kKrB8sYn1PfhVBP9nfHvDMI2/CDCvylBDaN1xHL+HdWaypvdYUndbxCoezHIZKoxAQfeRxUO7kVdagCFxnrhzS6Xwj8j/iBNEFR/JFvIAQf9Av7Vb+7nUksOni6NoXxijmXeoDIZ5OPZuFkZbx5uG1qJ18qz1DEY4kNISkgVTo2nCCIBtVQcIp2XK9hZxe0foDPl3iyKZQvJkfO3trKZt3geDwfpvThWZ
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MfYA1slhC80sh47rovDRaPLYl4+CiDSQALPtDk/QvPrNk4KmJqbRt59/Nyhrv13Lo3zD3TokVUvUJ/fByEXzPwIECL4g6bNYeGWD27VroIA4vh2TjD4ni/IzVqHsJCjNFiKIqQJYHHGcbNig72hNBsm8uE8AHX+y1fZ7gb4LV1XpI5TAgLvqeppDojRjHFJ4n9dbxW8Subh+3qxX3pCFV9Cz9to3FmbDa1DXKjPHsYeUL1cStoHVgeuOBfjoNTgxpSaSfOt9oq/Fmeeoj3hObtXlwQa6YdWE8RdW18EldJWljmBE8nlJ0Jkftwp1aj7CloCQ5yt9noGYCJkVZ2opm/G5wYs0tczl5HeQe+hrpbmU+rPYr3b9Yw4DYLpO8NU+IHDWyvIlEpws3nQ3XpvkgMRNJT9HC5/smr3yXXh3NIM67ok/MBVhyJjdvpkQLq8eAoauxJPktcsbGaBTwR+i5HOKfhYCmuu2CbrgfqBV3tZKGiMebpVZoynamLPr8wiys6QQEC5WkwHB3poQWhzh0n2m4C5ec8ivHWOA1N1Udoz1MuhptEH4vtl30FqYkKSX1gnjGAOYRsmi+kVoY5hAP/DNVgEBLCQ1GevbyWL/5vXD55RzeMAElt6810IZ3DpwoGh4whLHcLHXHNwHadJUQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KEYVpBj/y4D6RjSIUpaDSllgYCqHSEQTnGVgePh1kvZ5wgQMBBs4QvESg15M?=
 =?us-ascii?Q?Aur2zdgcZvmYkyZJN40xs2YhQlcAmmkVdyQrO1rCXyQDgesgy9uWHfZKahMM?=
 =?us-ascii?Q?9Y+4O6EzCS0cu6hm/DcMJZXVYWHSiesfdKce0miC+I9Z9uBWtLHycvJGpeXZ?=
 =?us-ascii?Q?LEkNhoo4AQYsIJPjXg8CgmNlYekE8GfPcJpedGL68YQP1q7dLBDdM0clRxZR?=
 =?us-ascii?Q?gV8KfE3akaw3IVj000chEu5pM+4uby9/xTj8IySaHb2zzt5VZ4TcxOu5cUAO?=
 =?us-ascii?Q?Lx9ZYfrxpUslQ8Yp5uKRcqkcIDIdi1PlX5BkbCqim3I8JvitkhgzX3c2YHga?=
 =?us-ascii?Q?CzlK4G36N0mU4lBq51apOJQ+SncLxegZ3bi4rRVKjb751hd0imaqBM4BEi/N?=
 =?us-ascii?Q?uU9bWC6ZaE+A7BQ1zLbo9m5SxfQ+mpEQfG+tsFhtWQsiUCQ/xwe31okvKU7e?=
 =?us-ascii?Q?awsvvILSSuIjHqaDRoFY6ME1XiHrRNh8msDtKy/z7j9NLyaYBc5vQXvFMWEA?=
 =?us-ascii?Q?hHX94ve8+bTKfUQNlpGqkmcDsKgh75KS4QBTJcUIHV6wzb4mnJ7pV9V62WI1?=
 =?us-ascii?Q?4u7/nsS03rXcPSzt6jW+k7P2NJ+3ICu1YagYBDKmM6zFuY/kg/Y7CQrtq8GU?=
 =?us-ascii?Q?0MDi/ax/X7mqbFwzd6S50YdKmLthG6gubFLljT/dzZV1f/QLs+S0Cuyc31vv?=
 =?us-ascii?Q?pWPBT0lkSgc2m0MZyP4NgLnTObS6g9hBuxbwcGmh0e5lgbVA1AJnqcaNZnzj?=
 =?us-ascii?Q?tKZB4rOe9HLajRbPMlqgug7iXi4vFHECyK8pYM6ACDShLxVlJBs3Xe8UGloB?=
 =?us-ascii?Q?xht/qe7dDbgSMSD+YTIxrVu/DUWKzr+PReMT46AZ9ROcEKqh1SHdDA0qHuu7?=
 =?us-ascii?Q?w1mGrWOjMHWDVvksUW0Bm9enJaFW1qFPTwroTyNF32b7ViJErsy3tq+Vnil2?=
 =?us-ascii?Q?T9DalMNrEIA6ZqbUjIJeD8gVuPggORpwLXQW4Wwujx3lUvHsoZOxJBwpPtEl?=
 =?us-ascii?Q?qt+Cy9V8EXIQHT3UcRBY695n126HwLiGp8vS6Lz90SV/xj5hl5PCngmPtM2A?=
 =?us-ascii?Q?QME2N8928KuKvVzDdOwjIN7zzPqnRGIQIE9NgpLLx1Ptzzox2iY2+CmmwAIh?=
 =?us-ascii?Q?WmGJIS3NDlHXMbbqDYAjs9elC8fRsYHpGqtyv0AsxozbDR+05vWjBUdDRg2Z?=
 =?us-ascii?Q?unS9uNk6+YnTMSWVklhhucGHQZW/Qtpu1W2uRjYm21xqWaNuMdt4oKiQhvk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e3d53.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af60408-3afd-4282-64ba-08db73ff5027
X-MS-Exchange-CrossTenant-AuthSource: DB4P250MB1032.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 15:34:20.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P250MB0042
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading ECC status is failing.

w25n02kv_ecc_get_status() is using on-stack buffer for
SPINAND_GET_FEATURE_OP() output. It is not suitable for
DMA needs of spi-mem.

Fix this by using the spi-mem operations dedicated buffer
spinand->scratchbuf.

See
spinand->scratchbuf:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mtd/spinand.h?h=v6.3#n418
spi_mem_check_op():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-mem.c?h=v6.3#n199

Fixes: 6154c7a58348 ("mtd: spinand: winbond: add Winbond W25N02KV flash support")
Cc: stable@vger.kernel.org
Signed-off-by: Olivier Maignial <olivier.maignial@hotmail.fr>
---
 drivers/mtd/nand/spi/winbond.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 3ad58cd284d8..f507e3759301 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -108,7 +108,7 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -126,7 +126,7 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 		if (spi_mem_exec_op(spinand->spimem, &op))
 			return nanddev_get_ecc_conf(nand)->strength;
 
-		mbf >>= 4;
+		mbf = *(spinand->scratchbuf) >> 4;
 
 		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
 			return nanddev_get_ecc_conf(nand)->strength;
-- 
2.34.1

