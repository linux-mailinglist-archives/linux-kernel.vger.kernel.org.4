Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F3074A914
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjGGCmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjGGCmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:42:45 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB64119A6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 19:42:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikEr4gXWHJtdXcTLbJsndqQ64dPDG3UKh3JJ9R2kjpL6tKEVan5diNTi0wociz2DAvkr1incrHZM6zHUGD4ZLDo8MN6mSkEr0fU1dFT2Z3+Xq8jrh7OBYh77mAwOvUlo3FAI5qGfR0p8cOkUkdvjN380bi9bxc356+iS01RDwq9DDu2bgqinE5/iqzZotUIv4Ids7IpP67qjhBinpjQYEchOMoA3epJfGiLYvpsvHB+0g3H62T0TBAD1tM5Iph2g3K6YXHlWMy4NYU0CUL+2qy6iWmeLCQP0oUJc5HoXR9w0czgSD5v5fStd2p4ZF2XZ1Q5YclbIlvuqpO7Tz8XCYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPILx2WGJL6OuqPuDyg+504gLdJZpDhkZWCSEeM1ksU=;
 b=TlLXanWfEcNHf1QKOA4+WFOS9kAwKCBSN+GtsRXsaXIYD9AnyWN15xyuuH0kvknxiG5k02nrkbI35H1rxiWfSlB5o2Di74bhI4GwGoq9dBU9O2jjGQgOSCX2DP7CB5181/qFptiukTln2BMBqWiP4gVgl0fjmnHKGOI/K9i1EMGn6GLjZ9UDAhT8aVB/uPBPDsUCAzndyPESCGHXQISjS6LgkAazxUw3pjwinJFbz57D9U8/MvWIdMOKqn3UtH5hll5Zzvyh/YssDiZTl/hD+ETloasfTNb+LR6DsUMlladXx1NBEkGr5LEoEgQ/hze2tnWOxTfQa3V5OJgz9jMGLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPILx2WGJL6OuqPuDyg+504gLdJZpDhkZWCSEeM1ksU=;
 b=lVTG9UvHNy7QBTHyrBR0VBGgUYQLP1sapsChGLn2TIKgJwu1d229OkKvjcfq/rhZTbbeATOUJ3A6y059w+C9YELqyyqk47weM7Szd+H5MImsZDXci5OfoKBM+OqVHYtN1svFQdf0/DTjD+qLQjoshc4eMczi0UnwJNJuDHpmrAY1emPKWhy4aoDJn3qjPRVS756eonG0mGjecnU2zMsbzmKa+8A3iqqYZNPinotABnWdH2TKAKXf7wQVez/TiCaliRffphA7HYShg+fs57XuE6FzvfI0vbJOh13Cf9lPgF1e966aa8+YxP9A2O+gCY4uCFeGnEz7XjUdRVuR0hxDaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4482.apcprd06.prod.outlook.com (2603:1096:820:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 02:42:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 02:42:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@amd.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] misc/xilinx_sdfec: Convert to devm_platform_ioremap_resource()
Date:   Fri,  7 Jul 2023 10:42:22 +0800
Message-Id: <20230707024224.78907-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707024224.78907-1-frank.li@vivo.com>
References: <20230707024224.78907-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 3451c66e-964b-4c2a-a5c2-08db7e93d2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9+7Su0s2MfwjSsC6fBMDjuWa6BIV0lJOQ+pdaK4M2Tn24+VCU4F1TJxVGg54GJEX75v4Gvw0+9MCghzt3AiK29WdeSqI/5vyI7JWKBalbJpA12dhqd/LMt6V81enMc9gVOcUo9btqKpK0nfgLmt919AgfMKvWmqIgi2M57dEvKwFYiONtbbSMYC2jZ9T3Q5hQBtU64K3YkdozbBhbxjrtsatN/nQK6CaapBUFZSaYLLx2Dy0t7fXicN4Lygq04U00Jbnn/5iBZ2CFRAgn4y1wUToTkTlU2zE4X/95NVQBbdowqT7JrTK/6IGU6dA6qH3feyT6NnhFhi6WFbop7wxr4JoU7MdCVA9wQDIUgvxzFIk+ku+s7pONk5weUZw+rPBU7bNxdqeRqj8aI36p77Wj3t/GEm/t3ZbvXgZSyoKOgAB5y+sxMHBloJURausI6szZ6ioOK1RzjKibUGLhjZodurMyXSqJpVjO2JkOND6L1ZnSeSEixeQv8UoR4sHyl/DtkuZIT8G+OT4Zmp+r/PPpnD0XPOgLbHHGzmEO2yQIMbNe1/nVEX2Rr/znoVTWomkbm+AGmKQ01LrGvK92OWlbGttOARHiUo2tHF/EoI88mBfFhsoC7gJySiSzacHYgy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(6506007)(83380400001)(38100700002)(86362001)(36756003)(38350700002)(110136005)(6512007)(6486002)(6666004)(52116002)(8676002)(8936002)(5660300002)(478600001)(316002)(4326008)(2906002)(41300700001)(66476007)(66946007)(66556008)(4744005)(186003)(2616005)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5z2ISQyW5yIHEFsbYAXPtplgNps39vkyZ0+QM0M1dpIntrpjR3PkJbaCPBUI?=
 =?us-ascii?Q?I0l/O06Xom+fGaiSmp4D5o0Z/3i/QFj7WEFbEfMKeMuwhRtvEZC9fcFYGijt?=
 =?us-ascii?Q?+tkmr2bdmN1UIM4U/R16Oy5gTJnuVMQIAy8We5nYH055f9WOuYX/PyGIr7UG?=
 =?us-ascii?Q?nAwFMowVVrEufF7p4k6yFEheAkbN0D3QGzh5dC8ZhHF68WeD+LoQ8l8FqA7B?=
 =?us-ascii?Q?m8ZTvXDDF2QwjiWs5sZn73uEjNCTwQlFFvw9BLdlEsW1k77FdUuhydnoyKaT?=
 =?us-ascii?Q?KhrQ44z0Gy6bvObPogfbB4j53Vli7Ewmzt5WPEniik2vImwW0K5tbuxSIMyE?=
 =?us-ascii?Q?VbVf+9c7Vew2di1KmCtPqFZjeWiAKaR4CeAYEffhf7nzFmdR9b/mP2D3rOSn?=
 =?us-ascii?Q?9qmSGK/Q2CHbyHAeHcZYHg6urCu4Uii9UwnhXPONdBKwP3DKgdHzptieg3Hm?=
 =?us-ascii?Q?JQX2UM1MP/mm2rmQj+TPLo5jcsaCIQrlC8jJfIgQ72KGw3aqUAF/PWewwhSP?=
 =?us-ascii?Q?GEzeeCYRUUIMSi1PGQz07bNplP+ufviQofPd4FhduAf3zQJCLtHCQfBHEGAN?=
 =?us-ascii?Q?6W5nj/0woNlfmqTV1bWreB9jwpT0s3dgBN8CDsw3pYtOG2W6SUQoQym2YWZf?=
 =?us-ascii?Q?e1HQLDoFRc/gmGA7g3kpzQpc5sWA+pJjvKKvcSWvvngXic2JpO9V8tK2JGaF?=
 =?us-ascii?Q?Xc7OM+5Xp/soDMWRTaNSdWAczu1tIGS/WYLutoovUnFe4i+2DKW+k70mh/pH?=
 =?us-ascii?Q?mpwGvkILRXT6aAvOd5xt4/zr1CsjcVDK4i41OUwkENdr++re2DJUzf+oAgBv?=
 =?us-ascii?Q?F465roJPOLVlaf2bUnhUSogmEhKADNPMJLQxD8m8B/kfOc6rIT+3v9IFkfcs?=
 =?us-ascii?Q?KsqJ9Np8Urx3qCbAqEnHYnm+upLeYaLFF30uv6o/lJzn59ey3G2CJDPYOXvQ?=
 =?us-ascii?Q?lGPLaCK+/8j9qyMhSXPzNuiM8FOAUqmUsF3DqcLVT7bNIidyMDTy3CfFK1mF?=
 =?us-ascii?Q?3KVdePsdF8+TmyHrkeRQAmhBrQSA2ptX5fTGi4dCxMeG4psGpMPXnIe1OweO?=
 =?us-ascii?Q?Fym0+IDrijncomvEzlyPbgyQvNZvL45fDBEZvtNj7meaU2Esn/XdAJdVQD5R?=
 =?us-ascii?Q?635FYlze1yGCNs9TL+sr+IKOz1yYJeaCyF59k7pxvRFE5ycWa5+hhw4GV2ll?=
 =?us-ascii?Q?BySXQdgOZQgi8oEqdwun6v+ws/Nt+0MTbm2MjUKeRFIBQ0awfibJ82XwZtS9?=
 =?us-ascii?Q?1JO+owVk3I4hrnE6FpYGxpMZV0mie4k0QHP/DA9rT4qp7TXm9u6TF7Cgh5F/?=
 =?us-ascii?Q?HSvjW5vBTIaQFQSozY8c/c/Lqofy8+Ud/7MCrXygn4Q3gtKntCEUjcQHzohK?=
 =?us-ascii?Q?7r49gjp/bnKrQeHg8D83f7u0O55NlVNL9KyP01A/F8yzq+xQ32aprDMEmOT+?=
 =?us-ascii?Q?8sJg7jdwSUc3JkXcVLZ4szW2HXH8gOphLqKH4PxuMy35ZaNPNxvqdBGp2Yyn?=
 =?us-ascii?Q?/R08Tb09OysUQ/gUSbMzXcpeaJMpkMt7iQXu6BSoTp05zbyVc8n0uzNBm5I7?=
 =?us-ascii?Q?lut7+IfP4BziltqrsuMyUwealKfVZ8tPz/FWOUIr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3451c66e-964b-4c2a-a5c2-08db7e93d2ee
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 02:42:36.9945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvr68kGLQLLaSQ+AMERxwXIvncDPRLjHAK5A71MdS9kU0tvhy+iQdqrA23T8kL/j6cCWSD0QuRS0IcGGDXN5CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4482
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/misc/xilinx_sdfec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 270ff4c5971a..0877c42fb8e7 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -1347,7 +1347,6 @@ static int xsdfec_probe(struct platform_device *pdev)
 {
 	struct xsdfec_dev *xsdfec;
 	struct device *dev;
-	struct resource *res;
 	int err;
 	bool irq_enabled = true;
 
@@ -1363,8 +1362,7 @@ static int xsdfec_probe(struct platform_device *pdev)
 		return err;
 
 	dev = xsdfec->dev;
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	xsdfec->regs = devm_ioremap_resource(dev, res);
+	xsdfec->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xsdfec->regs)) {
 		err = PTR_ERR(xsdfec->regs);
 		goto err_xsdfec_dev;
-- 
2.39.0

