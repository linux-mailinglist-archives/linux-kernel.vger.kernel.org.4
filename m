Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7465B5E62
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 18:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiILQit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 12:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiILQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:38:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28CD3D5BD;
        Mon, 12 Sep 2022 09:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGNz15NQSDg0jt1tQAo8L9CurdJpMUqUpoP+zpS3Xt7D41vSIhvLJWm0EPIeVrwtbTRNN9X/VJRrTYz00XD3WG6mqr0SO4WAVnDwgH1/EkH5xngiI87HUarTVjacMKhW7qnoAd69/nuAKl6UnMiKhrjqZMfsDibeWkHVqKAzcLSn/QTbJXYTepmy9etY3vWehasqP9zEbAzNyZZ2Dg09PegNoWe7yiY7QEjC8cYC4KWcogHeOsAf5H+KzpceUIWJ5E9128eZQAinNm2gj2uHddRYGa/A3DCthZJ1ZpXg/R+oRdxmCbYPhsoPD3pEyeipdWtkGmAEeHSRe2lk85xzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXuQkNBkxf4WOQyLZXJWRskOtVvkdZWa3oEaNVZQbU8=;
 b=gfNsEWyZ2LKZ5y8LMte5KIJ9dIdJYkgLhVEOA2SKaVvOdhl9N4GGNjGJPvJ/JD+agEZiESMP5RKVX+r/sOx/tBBJab9WaQhFnwgiqJ2bX4rhfanPMlbbZNsZru1cdJ0iUUSjaWwfiOgZ4iw0uVaDgenXSY31ns5f9pq16l+DduMpNt1wMmK7KYTc6RXFzsuYGUCJ5pXJOBTvhFR+ED4BwYs1frTtSL649Ep+msqGFveFOj5X/+JDung1inR5tLGYvYqzvlyJc83KXkZB1m1rEF+cYpIKcuBYbuOtGyMAMd2VWxlUUoe1bxsmkx0wSSaxn4IMswg8efzboLasbqV5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXuQkNBkxf4WOQyLZXJWRskOtVvkdZWa3oEaNVZQbU8=;
 b=QIyEvM+/NUBX+2ZDCqaRA/MYLSt2YhV772arFWAz1rpIhVK81LICUDxumRK9vtli7ubZ8szp0xPOWoneW8vzXTAFFtwJAm+u09rf0+s22zmgKaDxw8/R2SmIYN4/i1sOOB2vt286JUBGLWK76EFN5b7Gfd/uZHYBfmZTODLE3SpQgIa7sg/XQZpFbr6yzG+HstVa5TVLYXUw+/3M71HgjBMtMjgNFD6t4ZtoVjDwk9wTAkWNW67XLwP2UXtX/J2jarAzT3aF3IXTmowtO8WrB/tpjIqah5si9aPVQxdtbfYO3VUuPoFlidCjWLvm/dR6Y7rx4lxLzisF2IYJAtY0Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from DB9PR08MB6825.eurprd08.prod.outlook.com (2603:10a6:10:2af::9)
 by DBBPR08MB5977.eurprd08.prod.outlook.com (2603:10a6:10:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15; Mon, 12 Sep
 2022 16:38:42 +0000
Received: from DB9PR08MB6825.eurprd08.prod.outlook.com
 ([fe80::a88a:b945:e903:42a8]) by DB9PR08MB6825.eurprd08.prod.outlook.com
 ([fe80::a88a:b945:e903:42a8%9]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 16:38:42 +0000
From:   Nate Drude <nate.d@variscite.com>
To:     iommu@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        eran.m@variscite.com, Nate Drude <nate.d@variscite.com>
Subject: [PATCH] dma-contiguous: add optional cma_name for cma= kernel parameter
Date:   Mon, 12 Sep 2022 11:38:05 -0500
Message-Id: <20220912163805.4113238-1-nate.d@variscite.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:610:57::35) To DB9PR08MB6825.eurprd08.prod.outlook.com
 (2603:10a6:10:2af::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6825:EE_|DBBPR08MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: c1bfbd18-50cc-4b8f-f66f-08da94dd40c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3mDuoeY/PRFn0Hl8mMTlLPmCzry+9fzgFcsWIafGCnByohLt9A1WIGZpFAbCYCY70RHum//Si17UIKbbYIhGNiSYoyoXuTFldYtMQRdTo6/DpYVB1D9H733/GW5sMPxkjnGgKeo/ZJIJa+TM1j+eSee4T6iNTXKpqoru8YD3Fe6gqgPz2ySbsuR/+53yUnZtlEfQ7qNtQNNWim2Duy8iJict7P451A5+F+D5vmJ4zwxksMlrG3ZyZsfcJ5PKrkPBg3L6ToxKF/KyKBLejFAQBkXLqkeeyb/yrsB/733u31mlbxYhPE2czOn3kSFZaAOmDATtdsTxK2LktVoFqjRIardUw19a3NL9zAGZsO6rG1+zB/XSCVyP2/SsOqoSsP8ggMbtyBf1wB/tszn+GVyz2kqHwMuwwBTNpUyx+gDsoqVFcZuBtlmNUez2tGD77mkVMbduNTkBHLMMq5fa/caD+vEvT4OuPcRULQ+RtdEVGOSG97wvDy1LliOmUFOMW2dcneK3t5cfH9RSdRdnwvnNB2LnIbj1/FdwwQJiWlT/ySeKbrPx0IqcYfVzyDkOx5cWEfoRmRhItn94zRzl25QJG1JoTNw9ul0A90htKsF/Ayoi7azlyjJr0z/vMMyRzvGW0q+yBHzSgn19GqVOgA3A+fwcqVR38BG0nNy6GI8un37P/siUG9D5QczzCVK+eBWnUCii9OE8xrB+b6H8jtJUvf/ToC4Nubj0EQ4Sb3y5ybC2rLoVb5tZeoxEqDheYbls2K2bqGrMTXjtymoUob0BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6825.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230017)(39850400004)(396003)(346002)(376002)(136003)(366004)(6666004)(41300700001)(8936002)(1076003)(186003)(2616005)(36756003)(6506007)(6512007)(26005)(2906002)(38100700002)(38350700002)(52116002)(86362001)(83380400001)(6486002)(478600001)(316002)(54906003)(6916009)(5660300002)(107886003)(7416002)(8676002)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ycpVyeCO1dek1tfPsz5iNpiLf/j9/arQ7plskLqVwLug8K0pwTwqQMHDgP+?=
 =?us-ascii?Q?/4RuSbelxclPKm9E82K5yTQG8tfy+50iuUPNAyeEMJpRoYXr/k90v0b2IZVl?=
 =?us-ascii?Q?myq8vfxJSKanNoiSAO4W+T8FViDvJY8eEXCs8HWtiPi6HggmROL+Mjw4lH+e?=
 =?us-ascii?Q?DQBajgt181DHybgzxH76PHp3ksP4iKQ9vvf446oYUOsI1IrttX1YFdMmZO6O?=
 =?us-ascii?Q?hRGhB8ccxWy7LlfM+fw1+cWUcV1/GcCCaJd2AV4qt3U3KBDTrYWKrE/5huPk?=
 =?us-ascii?Q?Ocb6iSnCF359yP2JFbWTdqnULwPEe+5w5335eKT/CE4XSG2tCJkvqBJM+wxw?=
 =?us-ascii?Q?vdSmUTuf419tjFJhbVmdlozZdKWqUMBwwmEfh9SlaHNdH9+2qtWCGrp21OMM?=
 =?us-ascii?Q?CPgVVtmBoGBSdHOB7xPCRB1HPxmUoJVWihvCRNE+M1vqafJMOxgyJCgGT3ob?=
 =?us-ascii?Q?D7DV8dexEOR7h1GnUnAC6ivvYR4OlKr7PJxcOEsDGD5ngjr5kkyYbjhG7xeB?=
 =?us-ascii?Q?FBJTDBtarKKmprm1w8PgYRzaSFv23Zx5exTYDQf8d68B0oyUuu9OYzPupfzH?=
 =?us-ascii?Q?SaCxrc0bN9N4GeWT/e2tH9ETUpmHYNoF5jWGsAy6Xm8daZdCJoUzXzMGEM9x?=
 =?us-ascii?Q?SJwqW3Koz0KUdQbs80CALEto2nLE0mu718d5kdmxwG0Pb1XzchocTkp0Mh8K?=
 =?us-ascii?Q?LYMagIgH9zVTJmpp6k4dfwizBum0+auERsIqhOs1SfYjjyNcuum1Oh+yPbv0?=
 =?us-ascii?Q?3tUDFW/aWO5Cul70KJv0CXtThq45EFGuItSP0sf+04+2QBvXyPM6dBcghIT1?=
 =?us-ascii?Q?Z+V1QpMR5dIXtO/k96DLhvdbatiHEzewbEzuVtyYBjR1ZvyrqwC3DqXzRbmP?=
 =?us-ascii?Q?zYDrU4Sd4LIcpLfLP58Q8sutMh3bIF3tzvC3tVv1P+xfeJA3lF9U8GNfK0v9?=
 =?us-ascii?Q?2noK/jSF21QIWvq0aTc9GRMjKbDco2pGewQddfiZjaFaBly1XHdGImU9VGZB?=
 =?us-ascii?Q?Sgm21WS1/gTz0SHg5/7R69eSj2UtQQOOCRZ8n9intJiOGf3bojUEg6GUNbDq?=
 =?us-ascii?Q?ogjJThz5cKXAMOkb3ug07BZCzZgaKw7kYrAnasKf5Q2l8hMt7JoGyfssY4qa?=
 =?us-ascii?Q?YnTFc3Ce8ZTPnrtkHMNcwW2xGYFG4ZTQojezT8KVsXO2MxUBUewHS+FYVjbe?=
 =?us-ascii?Q?6R/++QX+/JYr51XpxVHyIIc5sReqOGXw1GQ+61ZaUzOnk77OsP7lF3XoR+Ls?=
 =?us-ascii?Q?DwCoZhonwwlOL4oxSPii1C/M+50MWPW0eUs8pjEivFR7pfr0m59RbB3DnemJ?=
 =?us-ascii?Q?sOOoH1l7QrcKuLU93XPBfrNMehIt048f0urro2wIzK2kTyZkKB4TRGudMjbE?=
 =?us-ascii?Q?6BPLkknsQkxfHtxWd6jhq11ImSFfDowCwOupZsolcfKKYO1LmgdF8hZSQNXk?=
 =?us-ascii?Q?wRl/vUW+oFvuAoz6lp7eupZAFYisPMj+3FEP3qJl/vlyXnjOVCsbjAQgdjJ8?=
 =?us-ascii?Q?ik/Aie3Ahg3aj8o+CY4HLvcNNhEk1XUMS3cpDpg9XdtV5Fk3OFdMadMe+lOb?=
 =?us-ascii?Q?MQEEczjeVJyonh5t4OlWrLdsTw484lGaoT8UgM+v?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bfbd18-50cc-4b8f-f66f-08da94dd40c9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6825.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 16:38:42.2788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gtXK+IaDZDB28NZuGpm7re0fqWqIQBvpIfKkxyjEOaWxR/eI0cGoslOOftHUA7nrjYvkYoGe16QRrGXq2nTAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5977
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cma is defined in the device tree, the device tree node
name is used as the cma name. In the following example, the cma
will be named 'linux,cma':

linux,cma {
	compatible = "shared-dma-pool";
	reusable;
	size = <0 0x3c000000>;
	alloc-ranges = <0 0x40000000 0 0xC0000000>;
	linux,cma-default;
};

And a device /dev/dma_heap/linux,cma is created.

However, when cma is provided by command line, a default
name of 'reserved' is used, and the device path changes to
/dev/dma_heap/reserved.

This is problematic because some user space applications,
like gstreamer plugins, are expecting /dev/dma_heap/linux,cma.

This parameter allows overriding the default 'reserved' name.

Signed-off-by: Nate Drude <nate.d@variscite.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++++++
 kernel/dma/contiguous.c                       | 21 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 51397a320f5e..975ec862d071 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -644,6 +644,13 @@
 			altogether. For more information, see
 			kernel/dma/contiguous.c
 
+	cma_name=	Override the cma heap name
+			Format: <string>
+			When passing the cma kernel parameter, the default
+			cma name is 'reserved'. This parameter allows it to
+			be overriden to align with the device tree name,
+			like 'linux,cma'.
+
 	cma_pernuma=nn[MG]
 			[ARM64,KNL,CMA]
 			Sets the size of kernel per-numa memory area for
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 3d63d91cba5c..e89819ec183e 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -74,6 +74,7 @@ static const phys_addr_t size_bytes __initconst =
 static phys_addr_t  size_cmdline __initdata = -1;
 static phys_addr_t base_cmdline __initdata;
 static phys_addr_t limit_cmdline __initdata;
+static char name_cmdline[CMA_MAX_NAME] = "reserved";
 
 static int __init early_cma(char *p)
 {
@@ -96,6 +97,24 @@ static int __init early_cma(char *p)
 }
 early_param("cma", early_cma);
 
+static int __init early_cma_name(char *p)
+{
+	if (!p) {
+		pr_err("Config string not provided\n");
+		return -EINVAL;
+	}
+
+	if (!strlen(p)) {
+		pr_err("cma_name must have at least one character\n");
+		return -EINVAL;
+	}
+
+	snprintf(name_cmdline, CMA_MAX_NAME, p);
+
+	return 0;
+}
+early_param("cma_name", early_cma_name);
+
 #ifdef CONFIG_DMA_PERNUMA_CMA
 
 static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
@@ -231,7 +250,7 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 	int ret;
 
 	ret = cma_declare_contiguous(base, size, limit, 0, 0, fixed,
-					"reserved", res_cma);
+					name_cmdline, res_cma);
 	if (ret)
 		return ret;
 
-- 
2.37.3

