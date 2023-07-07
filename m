Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C63174AEC3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjGGKbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjGGKbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:31:15 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2101.outbound.protection.outlook.com [40.107.215.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C1D2114
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kb/t3UEn8sxEQxQsrhTe2q5C6KG6DwE8xs0IVW4D8bCRVCiGebwIOZmrtI7QPCU5f2vGUBO0hPAyVAeBtjlSzOsrYNnwOPZq8zu00NFSx4/Osi+Y8qsp0zv5mi5PWiP85OJzvKaWJKuDHYJzJeIYW3V3Ypq/74s7Q16JfkMlkF4XsxDCmN0TZZlu7ZkNncUZ/TdaTEn17i+3y1XbzX8I6Q7XFWSw6cB8jBAZT0wf3J2vrRfDSASEojGnU445GER6PKc6Wf0UwFpKbVXYreuZf3RcDqxVHNLyOxHzm9bdmsfzqHH/HvkqoW8GPQPmkD5YkrhiLi5m4p+aBy2XOyILKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0aHSf7+GQNLJ5mkAfafkbU7gt7WCJVAa7/ncohNjL8=;
 b=dfLtX+otvGpsKvNzNokSDIuq7cHnIQRD+Eqtw82H3R7TzJLEhvNGLxvKJ6fm7k2vh9QgnSmAO0hrvuhwHSM6BLOy4KCejVKRk9qUUknqfvIWLAU87z5CHjFvjDrOlZwStrxZ3DLdPMa55+CbYcAkW0GgjAaSZ826PXQxjYqLoDGD98iTom6sZ9ScUZ27ZrTf2LuOBodz3cKMclnni+SAI4HjdgyPPadtfLcd4fkfc9hbwq/JKw02bbOqX+w7TzpmDYuF+nysscNRZWphLaWBebFaaUjuAFqFGoRlcqzw8w5enFLpo+/bgX3YUlz/pq9hsYsnUcKc9BWvd+KXlDfwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0aHSf7+GQNLJ5mkAfafkbU7gt7WCJVAa7/ncohNjL8=;
 b=GTB8GZsYJc1JiEbislclwuoVe5ZjEXO4G4DaQj2Yu61hOCuvju+gqNe3tt1e0l5Exl/UZmQ7gOMJfh5l5g8z3mEiLJTGTls5MxWYwgiOvUx2X43YkNeinByr2X+KZNldf2mIDMDJNbDeaLDKdYiKcLhNbLUJKURQLf869wGTfo81oUzzMORKIBRXdoEPRyaSBaPd8OwCy+ZiOiQNIu1hAil8PpMNJn25NJKaqc/cNb0ITvTQEZRKgax0WIjHPuDP3BGFnAQTli7NDJwXiIgMe7+EPXd/xw71bVpyZPV6Pt/OWwE85NYnL1nRgd895Ku7+d9oNdghe8V8DvgNiqeUHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SI2PR06MB4091.apcprd06.prod.outlook.com (2603:1096:4:f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 10:31:04 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 10:31:04 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] fs/ufs: Use wrapper i_blocksize() in ufs_get_locked_page
Date:   Fri,  7 Jul 2023 18:30:54 +0800
Message-Id: <20230707103054.1919-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SI2PR06MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 125cc35b-b128-4332-4808-08db7ed5444f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQlwJa5yrRCmeacvc7KUqshpgRwosxGdlV8x55pSLybT/0tJZg9cZklZyPiNohToY4jBpf2/mNGLmFwAaLxU40tC3u5s3VbLGl4AY/kxrCDtzfywFPGx77+neDsJ1/ETapiP9UQuAnje1VMi4YSLlgLpoV9Pixx+sWlPiq2k1AhQzg2xx3VOgxizYWr4K5rlDuwaDWoUtBExOj83CU+0jLAtpe2KNf3U3wo//jpjJYuZ1tb741IStx8vGF9bX3xKGQxMo4d7RtyTQnv99iPRIZWOOPPhC3sB614GU8a9TVrAW6QNL6zN9peUrQiPtMpHXb32oV1Q16zogQQnmuyS4kmzKRV8qsW9XOoF5yYQjby1s/v/QKH/m1vZSTiyIUJta3J6avyOKhSI/5/VB4mfB5qB6Be8YCsuLbF0Z7A7yarYdAKQ2m4r/1ttF8ZBpCZn1d8NNvLjpviaxq3ERw6sNCEJUvE66VxJdvzIEMUFQwZhYFvyEc4sddbSyFCTudQHuzBmZBYHIFGoqOmKXSVEURlpc4k/r36UTq53b1VWQLFRKYxZ7AHdbTnKjMugTZ22tmtq765X+HNB8WkuSjCAdwyR7qsn3602hkKKsTuUa4RnGuJ7gUH+/RbR6+OHKhTD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199021)(2616005)(2906002)(4744005)(83380400001)(66476007)(4326008)(66556008)(6486002)(66946007)(52116002)(316002)(6666004)(478600001)(26005)(5660300002)(6512007)(6506007)(186003)(1076003)(107886003)(8936002)(8676002)(41300700001)(38350700002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SwcDmTJVL9qjIAY0LoUNRw9vaS4JbgefXVJt8STTvQnvSzbYDsiFfAWxwd1Q?=
 =?us-ascii?Q?BrjwryEFVGT9UEDfHVeyIXXV8OhrnW4iXTE/UjT6YTBxnijBKKz4jo4Wupqx?=
 =?us-ascii?Q?IacKLfkY+3cmwazxeEXUNra4xKb8kjBtDYI9oDoECBsNPiBRk71Nh4QfQeZA?=
 =?us-ascii?Q?HkmapPws3jc1/HKzjBxHb24AWSL6bWBWggOTK357O4n0mPxQn8NxzC5UJGpE?=
 =?us-ascii?Q?m7p3o0OqMQDTlstllEMFNg1d8SNIaaPaQ6YG23R/LvFvzEFzxI6cdQUd55Rl?=
 =?us-ascii?Q?YXqzCELojUQI4gqWQVTJq8FWOnWHIbvBjPlqN4bN/JC6TM9sPgEeJ1uJCMo5?=
 =?us-ascii?Q?z1yT3TRs4vS0kaSrQQnveAcb6bxR8+iAz2oi74WM5jn0IGbKz2N6STQ4g6A0?=
 =?us-ascii?Q?RdCzlmch6IFfGa3mpvJsY5Q3tEZCt16wmYWNBstUqSET5mZqxxZvAAGCgbOj?=
 =?us-ascii?Q?ILyYzyGVvKbNw+blHY1jn2iNzAimFguyxgl9iISs7ZhHokrBEYg4B1QQ3Jri?=
 =?us-ascii?Q?gvDdLRRq5spzau9ixwGM/I3aJbjRe19JBc0lTdERr7PQZW9l/nYG5joJ5XEp?=
 =?us-ascii?Q?ujQYG1F2f1jpl6eGXn9citvm2/eHYG1ucp/FSjN9wLwRY0O9FSZL3kIfJpLG?=
 =?us-ascii?Q?DmXgIbYx3hTBbzJqXD9VLpRo3rIDC0vnkFoUh2tkBXH7kHQHQa+t/mtSsHyv?=
 =?us-ascii?Q?6p0I2kzNMTaT0u/MPk8rbQvNCZu/95gfim+Hwf5pCFWlTASlr5vuS1JVdOIR?=
 =?us-ascii?Q?oiZoN3o5mIBlIyjDvqSqLyfZznNcVJ74PhY3qBaIe2NKh0HeUy8jsUyJ0pYl?=
 =?us-ascii?Q?bh+N8YdNa6/44PwQ+qlPlnMhI5t6jT7EkiFq56CSW7XsBXJyMQfeXC2P0SOC?=
 =?us-ascii?Q?m4akeSqJFxoMNPxPWvwxoeXlEZ1CxsDgANmZtnc58RDYvMvuISvcyZMMkyVc?=
 =?us-ascii?Q?GRheBcva3vHfNKMxadgrP7J7hPnLhAgxGtpvepJytMrirX001BusSY9nXj1l?=
 =?us-ascii?Q?bwbxaYFE1pNWmZOsIcNf+UNim0ah+uz6PbzoWs2AxWtkOipme7poynVHDGJt?=
 =?us-ascii?Q?ocKK3hQ2FCsCK5ja8ld5Cke8PsUjsoCHTwcidtz7/pj/gkoQuG38txdxqjX1?=
 =?us-ascii?Q?xz8Zs154aDv0sJgmYQohEeJem1UCpp3VsSDcxP9hJMcuW9zoELploSJUELTn?=
 =?us-ascii?Q?MXBxjCNUcFkkSHaMFM3tKMlOd/40XAZ8qyE03YFnj9RGg8HcwpqJR3g9wXKU?=
 =?us-ascii?Q?w/tzY17WtxkyzGGEd8E7g6xddTCZHsJGEJzkIzR2YSYiAqj+CdDhLKOMKuH4?=
 =?us-ascii?Q?eT8DkP282VCnhjB0UgiYT7DaMYmwq4w79T5/ccu8+1stuUhh9OjO8NPiXhc7?=
 =?us-ascii?Q?ZLeSuz/TnjthEMbQqx2wnhgDPQHFcdkd/cq9IyxIKKh+/cr+0gt7x2oO9kj9?=
 =?us-ascii?Q?G0V8oKhuS06HZAcR2FsH90JDS5YqlsB+QL5a54mklF7/A+Bvmu8uJeeiGgZl?=
 =?us-ascii?Q?ceYzJsCVlcC9N4IpUlOBT/mQrjLR6HvMSaa46THwlbO/Py9wQYzYFnRo4W5N?=
 =?us-ascii?Q?wTCY2JyO7sFjOSDHIEaTKAwFVpLUCLewSmFYI416?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125cc35b-b128-4332-4808-08db7ed5444f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 10:31:04.4091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9HjWb9abeRZfeYFnMQUjPemUSwxwVErbhrZztfwksf6TpisZUSb+w0PVBqU+TDcH7R5h513N/W6P7i39mM1ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use i_blocksize() for readability.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 fs/ufs/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ufs/util.c b/fs/ufs/util.c
index 08ddf41eaaad..f9c1009ba98a 100644
--- a/fs/ufs/util.c
+++ b/fs/ufs/util.c
@@ -266,6 +266,6 @@ struct page *ufs_get_locked_page(struct address_space *mapping,
 		}
 	}
 	if (!page_has_buffers(page))
-		create_empty_buffers(page, 1 << inode->i_blkbits, 0);
+		create_empty_buffers(page, i_blocksize(inode), 0);
 	return page;
 }
-- 
2.39.0

