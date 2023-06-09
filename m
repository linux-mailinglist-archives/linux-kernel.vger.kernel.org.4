Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A5872956F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbjFIJg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241702AbjFIJgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:36:41 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34DC61BF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKgFZyUIBCRhic+QXaEx100a8EIBqsS6HKgUv7zjYYPBXs3dBwV5wBO2gqquKPB6O7bqKqyz1Ql9DPrekFnORtfKqY3cRGfC3oQ1YH3HDauFKtx04sOxG8ezFqE8w5s8b+lPsjwiqeCBXxNbClxpeEXPSQsGCrJivTwjvQ09l0tvdq40UZfpyFK0WPlhHXZcQZ/7ojidpAyL7hG5/GRnPaMgaPNo7Y+98yAfYe+Ur6jx8BhYMIIrZP6WwX5h0i7J7UMsXPAmaelUbfSF74NfyTIYhNUszedVSrKKrePEmYVRjTZ5C2vuKHX01pwkyEpa3ZH7JI3Cm5uM58p1aQgVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+YHe4f1slAs5iIzpI3MmONEWpxRHi0y71k9k3D+3Q0=;
 b=RrKnxUQ5wEJjZtD8NYHldAVmPe28YETHiT8/828XBLCPd68n/uh0JY6seBcs2wxHjA5Cv7Jz4jUEVoC+5x5c/CG0p1krkk6el/OUIZjXZUhOVuRWm2HH/2F2dvqOvzQUCqMPEREoZ4CLj+McGD2K574lCmTwkpaqq37ln9zoJ5QV7n4P7Q5wlPwYdlGP2AWj03t6XQ6It4LyAzW0POW8UKjoqSXXXY3qOQBOE7KChyY58O1cmc6XQqCvn5DEE19140gwftfZ8gBDBbEbiZUZaZMJmWu15B/W7r7apTqOJVkP2a0V3zIr5UH1yZU8Sbtz7Ra6izuHqQeO2AmrOzSorw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+YHe4f1slAs5iIzpI3MmONEWpxRHi0y71k9k3D+3Q0=;
 b=nIyonyfbIA6xtow0SL2+I5vSXAoqWA/bRvhTfWkFtBWpvBXK766/3Xq4KHJaa+4sa22L7sLOZygmvvsMT4WvRYCPcXw0CQWadW9UXOxmSbmjdRxXcKCx8w2uthF6Lwm1jI/wOhbnu+3wYvTo07rJldLxurIU4LrlKYIVpqdFmJOaKjdfVtNmuBgLhBthCnYtrwFP4M3Iqemzkwu7yzbGU7pMSoO95e8Br11UOshHIiVwer3WBe6AvyEdkdkQ3umC5vD/YFbqZPFp4lGWFvzoPp/wOJVsKSKJ9uyo5PfOiUVYpQqaLDUJ9or/lxwd6KcdvC6mIjwAI1jWRF9oa5iN9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SI2PR06MB4540.apcprd06.prod.outlook.com (2603:1096:4:15d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Fri, 9 Jun
 2023 09:31:11 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 09:31:11 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-mm@kvack.org (open list:VMALLOC),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH v2] mm/vmalloc: Replace the ternary conditional operator with min()
Date:   Fri,  9 Jun 2023 17:30:57 +0800
Message-Id: <20230609093057.27777-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SI2PR06MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c919d9-fd11-4f87-0cac-08db68cc42e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHJT4PeWiKZtR42wOiF4okrzEPqJBNDGaE5ObCWQTi8Dpb4tVAwqej08oqprDCkCVaAzJYVrl1Vo+FsGnsMRoPkU7BoDtyPY3vky5LYUmBmbCahEuO3Yas/eNQIgUq2tm2lpVTkNdBL3Wgo/veNxdx4NZxpEthizP8RvlHN3ZAV2+EvMUVmj+5nAFGfwkho+GxWQV79Ws8B0hr9TIFD3IOhD9bBTFqLrgIvjd8GZF6XcZLrJxgZBI1k+D7z5VoN4W+ddlZ8hCFBB24OQxOUdDFvdNZViyi3ZYb6YKhhQCnrN6cvg1Y7Rkr78BQ+quMgLFDXo0o/6BZyuxUhAfc4KCgbJjWlsY8AUOrvXWC/MES4n7qGEgiW9HXTh4H0BoWHkRfGLTkJ4LRGMmIOFElgw7Hvr+VSzq+DDX4ZdZrr/XwltQNz+Q+zyEc/VvAj22L/BTucEGQHbYPGuwuylqfYMMHbPZRqubBEm4eeLJjjVzlCvntFSPKG1VzAQIqLvaCfhXhMrv0vZQ5Sml5Z+44MonpTxvZCtWdyf5ufRA5QpEnNlPezoLcSrWOvb4d9QQF8/qfreTSFj3a5Rq0s3oig1bIi48aLS1j5y4D+eqCPivqSUWN/ObJcCr5731xZDtuYX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(186003)(86362001)(6506007)(26005)(107886003)(1076003)(6512007)(52116002)(6486002)(2616005)(83380400001)(6666004)(8676002)(8936002)(5660300002)(478600001)(36756003)(110136005)(38100700002)(38350700002)(2906002)(4744005)(316002)(66556008)(41300700001)(4326008)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6VmY+lgWCxf9+t65AO0x+qlw6wcElGKJD4VpyIZ8lWJWllX/EFmwesnqeu4q?=
 =?us-ascii?Q?XaJWDLRMNOvleFvLA/TlgpwwN0089poscLA8zwfhwxeWTs7oz4Np2Y49sf0y?=
 =?us-ascii?Q?I74napPJtZmB+D22UtSmZHl2E9r5dOhA7sWjGziXnRZBOacCp5eLOf4caSF1?=
 =?us-ascii?Q?j6nwfT7Imrszk6wyTec1Qwi2vFACNWuIKwjs9mBnyaQBwMJtS+Y14JLJN1kJ?=
 =?us-ascii?Q?mk3NGKnq+AjkrndO9CKEw6uijiK20h6ss+0Nfjxpd+k5XR1eeD+fvAfcsfmL?=
 =?us-ascii?Q?VvpgiVRX6crzfhNAduUm1r8e/pqTCgvyokUjnnY3ezlfOgiVvC4zSPg03lgP?=
 =?us-ascii?Q?AsmQ1mKDvDDpMO+gisVMq4WgZu/jOksWUj7nmmqiWWjYX0YC9D2D0/Amq0VN?=
 =?us-ascii?Q?OmECnDY+NLjieMKVu8oG/AqxjqP9NJZu7rDjnTqtoDjxLmV15nezdvY2xWs4?=
 =?us-ascii?Q?7GzRLcHDmOrOYfkV1YA56zbuFy4rRBtnfJoFY2onSc9Y6KxUbuF6R72yVhFw?=
 =?us-ascii?Q?nMvDTCjRyWnAstGNy+ZTBjzt0cflniA+7bAePZqgWxFtW0+JyW7GuI5k3IDP?=
 =?us-ascii?Q?0QtUsL6jzTnb1ibf7Xfvvf2ihvqNQlH4BmJc54IYcXDqKmZ7YKJ9HV59Mt7G?=
 =?us-ascii?Q?H5S82paJB7Q0wqd8pBXPaEGflPs5i4aRNf0BBeYb4+j65RUqaXRZLkG96WaB?=
 =?us-ascii?Q?T9btJ/1gM35YRatLTAESwdxg9IiohJK0+Kb1Ul9kwBOp9aLXCHQpoi+elEA2?=
 =?us-ascii?Q?/M9TwWSq+zt1beuLMb82V19d71YHbkjS1xp7G94Pb07KUbne5XOtqjPqAefq?=
 =?us-ascii?Q?3M55Z9FJNkmdzRpY26rH0G1qlGTi6w8dRu1CvxCRYskv7jdFDoPCMVnCDYVN?=
 =?us-ascii?Q?zP0TQmUQmOi40aFqwROGrupVBXj9r96RQTABkwxLEexYuF7714vhlPSNCQ/e?=
 =?us-ascii?Q?aIcrHPs2ZInqchi3OkPIZvXsL7a45GTgeNb989hvja/MwSMfb2txUjqFpEaZ?=
 =?us-ascii?Q?6unmMnTBmp8FowvxwZFy8sYy09qpzN1vHz1dWgEkMDWmvdeRBdZW8c1M3Rfq?=
 =?us-ascii?Q?/yCokkYD4sdUujudZeai1KJ8ey9iWO88836QdmN0hCOYMYX4H3T+HFilXO/m?=
 =?us-ascii?Q?BbeqHtBE3AdkweiLll4sLl2vDklayg4Bkc0Ml2NQKNmsk5tStXJza86A6nvc?=
 =?us-ascii?Q?aG+isuG0NBwFHKY7g0qUOl4cVTXZCFfQM9Afu3KGuBkpGnIEmy3MRqOFqEg9?=
 =?us-ascii?Q?aKOOa0hG/DSICabfm781JBge99Q0HJ8Q8jI9wXK1nwE5fH74X88UGoiQxC2i?=
 =?us-ascii?Q?JpOs3wtsQebRGtczQMFHSDtljQLdTztTexZWu7Kq8M1BzSEUF+HVrfaxLOxW?=
 =?us-ascii?Q?h5axK/v2BmIgredqDLflTilJboX7ZIm8b43snduOJVESkqiYD63CvrSGJrQD?=
 =?us-ascii?Q?bNnQH+pcE5DX7Bq3c3iRP0TDEV/NxKnFpnSSEGgUBBVC5upCOpcIopa+6AEk?=
 =?us-ascii?Q?eQBAgU8MDbX1abO46XnuilGf85Ff50nByC23DJl/H51PyeyDLByCF2s84kFS?=
 =?us-ascii?Q?TAXtpeVGMIQu8N80HWR9cZZ6+AbrlLYkal46EpcP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c919d9-fd11-4f87-0cac-08db68cc42e5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 09:31:11.0674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzSgHmS42p7So648uucqjkKFwnkGWK7CX0h3apen6WobBmJV7FX6prs63ab2HidVBKz6MjwjvV6bXE58qblGCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4540
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

