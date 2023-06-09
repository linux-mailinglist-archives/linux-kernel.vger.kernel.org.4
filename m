Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA0A729538
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbjFIJcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241604AbjFIJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:31:47 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2138.outbound.protection.outlook.com [40.107.117.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4F0558A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVu/AgHJFOonW7ynfV7wVO0SFlFi8Ns8Rk+cvNV9MuCwPixu3COH3fY0fnZ+nsl1gQADlKpE10QepPS3w4vJWkRwZUro7blQGDnMpAJIiAbRN9d5sXdgmorbLOvx6ja3rciIcs/nclMHsJa+dkZSSSh1ZC4cnB2WKiAci5bLBmRFDaV3rFTbv5NqDa/eF9W+4KQ6YgHA0dZ5Ph34vGiN8N4nb2mnauhKduM5gWWeTS8rcnJ1WBON6t+iM1OklflxC7Z+wvdWiEEJxCexq1zgp1yBh2IfhCPUXd0yVBvp5jVygb8BqYDBPybzcwEBj6Ug70lWHqlYJ5RX0MThlkVn3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+YHe4f1slAs5iIzpI3MmONEWpxRHi0y71k9k3D+3Q0=;
 b=HejHaRByrD2kNbo8KZ+f9Vbp+NVKe4CX39szPStsub5ikaC8HZ5xAA/+vKci2Os9U9azNRCjN6vF7uWdXqynHbnsIImIYpWI4GAjqT2zNfvsjU9ALlRBoatrRTlNcgTNiU+vZFTvTGcvGjaPLqdoYA9+moQlpfllQ3ywaJ9ah0Wt7jgRrRnT97T5pHx3+GVIeFGTkebrqye5/W1AJz1TB8/IlQQTDG+Be9MSO7FoXO9pt8ekgM3T9Pk+wkR3IHjc5rwaVVRxLR62y1mto1gRQTWtVyPmiuVjEQLxkb5L23O0Vb4JaArcI0Zj5NmaEPak+g2zwDkpGKURGPu7P07R+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+YHe4f1slAs5iIzpI3MmONEWpxRHi0y71k9k3D+3Q0=;
 b=VsEYBlefRx6f4U3tfG6pO4Z+goQeUy7h5nazO6V/mhISABELQ2p/v5G5po60mvTVNOyo9EsrrO7VqwpMNvfBz+eD3T9biX4R4aRd+SJXsLldTZJldDUKvrCjkL7IL+X+TLjDJXlpRc+D7sp2z61P65jbkdKlXdSEb1z0qSmfZAacC4bJ5tesR6vTMPQF62rmBOYeCd6En15uaUqkGO198r4iaT0majNf0MQLoW28H7WCkMBm2TX7OA3HBUGZRUEI2DrgHwkcbnuWwti9HVHJL1GkwyN/OaPW3ZMLWdvcA6a5Db5QK9vWJk21hmo9Fqpx34ebCVO5nr8rSopTKs/5Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SI2PR06MB3899.apcprd06.prod.outlook.com (2603:1096:4:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Fri, 9 Jun
 2023 09:26:12 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 09:26:12 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-mm@kvack.org (open list:VMALLOC),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH v2] mm/vmalloc: Replace the ternary conditional operator with min()
Date:   Fri,  9 Jun 2023 17:26:02 +0800
Message-Id: <20230609092602.26412-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0168.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::18) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SI2PR06MB3899:EE_
X-MS-Office365-Filtering-Correlation-Id: f89ad603-151b-47b8-5a9b-08db68cb90a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ZnDYEqlw4ayVHbNjgiEsn/jCppmEnjj+IiZKTItFH5DO1gQNKuNmLokv9hTiXFK12re8wJ2pZnpOhYQ6FiB/VHmUb3eSHJTSLYvAfe+R+oFVqiPo16qYwPmGYnVG4m8vfTFXL+wIGnV5fJy7jirvci6k0IjG3o/6r13G9ZkdR4LSWz1pqvassCYKVzxdEH98NB2Hm7NVCL2D0DjQvz+kjCnC7uF7qQFUECNoq5AyWn8VtBSEK1T4sC8o0X4EsDPrVVENkn/uD/UiHimixoOrqKDeMLpSNCkjv5bntLPbgNR+lB4PyGALRMtdD+RqEA0SbuJbCX6Dyg5Cp0szaQeAuQGGAiduHf7rdzdb6TVbcc8wXpvWmJM09OFZsbZ16+atX8aYShrlHTBvsl0dHn9GqBCSySkByWAx7Et9TPytnk1F7UzMw+PjWVgPBfoV/ftbdU0FtEBsOEzLR1nQ2XhWtWMe4CHsXjOF7LmwCHLQn+S850jGWq7SECReCWPvyi5nz7vzsKxKCHrJPWygzs2x7UhCkxfzocMr9fnyDwZ7BmPmVn6h92kRGWaQ4eS9MNTrbLhGohRg5IHxAcEIZnBdaCz7OlqkBFp6cuRy446zTGx8//KLbfyOU1fIafqPHeF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(2616005)(8676002)(8936002)(4744005)(186003)(41300700001)(2906002)(52116002)(107886003)(6512007)(26005)(5660300002)(1076003)(6506007)(83380400001)(6486002)(478600001)(316002)(110136005)(38350700002)(6666004)(66556008)(86362001)(66946007)(36756003)(66476007)(4326008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ynKZaEZhLo6EPYhMwJ9ODASO1rI/qvuH/jkCqNGIBZFfuevYsN9TJS3kPkNM?=
 =?us-ascii?Q?bCMegZjAm9Vhsr3i9YplJSpqGdnHK9WvUxjo9rr+Z45ww8fLpopOUpIEoQfY?=
 =?us-ascii?Q?oQHug2ub+dTuOrEGbMYyCGReeYlrw8ted4//P/SZ4Bs24SqgJwrZUHhnear6?=
 =?us-ascii?Q?KE8D6H8VJTrQp654oALRaxxRKpR+tdJ/kXZhT1onozHx0jnraEhnGgpkTIuD?=
 =?us-ascii?Q?VdHNMVPe5R0VrYmolvZDkyIhfcw4tYLxpslBgOvelty7A3ibyTF8uUqyW/Yq?=
 =?us-ascii?Q?hRItMf9yjLhDyMHUGPi1BgTSSqVinTemAv4DW9uAPGZT9OiaZ46X1yM89/OC?=
 =?us-ascii?Q?UDuEeQYtsXfwjToaJqCbt2MMw/CGpKyZ/EGHJSt6lsKn1+JblkfyCKNDd13/?=
 =?us-ascii?Q?Ccme1D1I8Ro3KEOpmXL7LmrlV6vJOg8GRGUkgp6jv74a9t/9vw6rCbtVTu50?=
 =?us-ascii?Q?g9XxwizbVNOALGx1xAXAFzqPvj4OW8wBKL/aOKno+a9pONPCYU/FgrAa7sx1?=
 =?us-ascii?Q?dTDIFh263Ylr4BsyoyQ9lgY8MtNYMMqSvNx3fh3sx9qc9Oh6UfbwgNhVIMx+?=
 =?us-ascii?Q?9C4Tsx0pepnxRLHYqhF6TNAH5OMi3tfnYiTL3zzbvEmBgFQ8tvUOZ1k5c1w7?=
 =?us-ascii?Q?0xI55IEC0upkDaicHtZFbTy0EQ8UkENtL3BTKVVEUBkC/dQIqUZbj95INCUm?=
 =?us-ascii?Q?SqL+Aco+UWXqjMnU886PsgtoTio7+e2YDN2VW9gquDm8HDwE4eQFAziECxxO?=
 =?us-ascii?Q?zZ4laPTlHiHUrIsX/8KOg9wLUpZTqfMDBVLdg3ZIwcjbiOll29YfhjghrVbB?=
 =?us-ascii?Q?wT+Pe/M5xBk7bM5fkr8/OjSq63lNYDnu1yzHyidwewVXedN+nuikIdAndpnb?=
 =?us-ascii?Q?9Y/8AwN55RcXyxBwGOIQnkjtofKWzZ0Uq3k4viGQiTPrNvAPXKSXMLvJceCO?=
 =?us-ascii?Q?VpkwnlSfkdVATFkdVJUhy6/Sc/PbW5itAZCQab6AAlZHukUGXj/uT0phwJuo?=
 =?us-ascii?Q?X1kvxrtIYs4jj/9sSHa1BZwfcr6oAuVsfzkBxSUKP2Xv98Xc0wZAVufENL68?=
 =?us-ascii?Q?QfRZtXFaSotzEj1yldvAWyDf6oSuGFk5eppG80olQRwKQD8AGOgG2l41NhXJ?=
 =?us-ascii?Q?FPkzg23yEMC2LhYHDY73ImlJWAc0XjInmQoLhSiHgQ/SsLhe1+MSknuBjQRE?=
 =?us-ascii?Q?wWI/7Z1f9qHXFJWVt7rHXwZj38eDEBk4795sYex68a4XQ69arbxTyS5ZhnXy?=
 =?us-ascii?Q?zF8BgICMD4LnVBKdrto2s7IAHpMdiNSEnoCyVLPbsrwW4BJuoEOOdnEQHKMF?=
 =?us-ascii?Q?ZdaWYbdOB/sTRbaqFVXXnouoaLTaXsbJSKf/Q+BL1GlvWH4MSu56Lp5U5zNd?=
 =?us-ascii?Q?+6BLswcv1cZ0moK9aMhJE1LkEwU5s3E05/riTrJ2axmxN5eT75ZqgYTP6Tz9?=
 =?us-ascii?Q?21rk69bOYYg6rz91EhT8Y/TlglYCunOcKRHus7EYIn3m2LQCegNZ9lTR6DsD?=
 =?us-ascii?Q?UiMbbH9XnCgpOsi+adEXh9kICW/cTxQKPu6G2L1vNDt3AmG/gGw9rIT2deeC?=
 =?us-ascii?Q?rhN0tQYI184oSMRUP3XVLCEuCaTGaMDv4hgKgGpt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89ad603-151b-47b8-5a9b-08db68cb90a5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 09:26:11.9788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+/RbIN1WI06LeVN1zb9W+vPNeyQOlLsa9M2t3ylKOFnmNfAW/SZHbjKqILYEDaUBYltJa8JaDWYkk2/N2YWyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3899
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be better to replace the traditional ternary conditional
operator with min() in zero_iter

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 29077d61ff81..6125ed506895
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3571,7 +3571,7 @@ static size_t zero_iter(struct iov_iter *iter, size_t count)
 	while (remains > 0) {
 		size_t num, copied;
 
-		num = remains < PAGE_SIZE ? remains : PAGE_SIZE;
+		num = min_t(size_t, remains, PAGE_SIZE);
 		copied = copy_page_to_iter_nofault(ZERO_PAGE(0), 0, num, iter);
 		remains -= copied;
 
-- 
2.39.0

