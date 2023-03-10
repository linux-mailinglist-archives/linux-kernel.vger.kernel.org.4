Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747CD6B3483
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCJDIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 22:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCJDIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:08:45 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BF9E20C4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 19:08:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSq38KtgcXt6Yfqscsn9SZRX5IuAtXxGGoK9rmsefdN3uwqgX2O3YVyT3GPww+cOszRY0wBQFoT5Igq2WPF1sXpD0EHMlVxKYjMFBQoNnH+3sbGijqvWWhfMIEKVpt5ZpHuYKsZJT0rGsle3oZt4ZADIpSJav/4KysWlikK7If/7fJ1Xmm8lopeDHX+8bkwDt7Z+eootpd5vswKY4aXPiD60RVIm0oKWyhigEIOtMWXE3LMWowBC6ULKwWz0iyUCr6zy2o9UkERJvy28aA0osVp2Gigqv7iw7CAkY1/9RwBcYqpWylkH71SThaMINP4Yy/HT3C1S0Y6/KldZTYTP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17DcBGO+6YLG7OAiYgPiEvXKUjwNfnHVU4GCh2Uz8wE=;
 b=EsSIwGHSqTJfOYMViDY2w+LLnm3C7aWAvNZOGYBj6a0XT4K9OCdgR+24Sn0rfecqFkNL2ICcrjQYjJ4gJHxnUC6uYjRAWq7slsPhFPG6sVLVj1+8w+zZZqGTLFiJyGAqMoEe2UjnT3btDLjEjCRr+1Ihj3FdIV8Go3VHTK8MVEijDHzYAUnAItIIDe6Suxb8ukxrnUXA/ffypZ0ZkjKh4yA/4wgupOMyMV9zNBi/HYw3lMJ/qOpApWZmP3IfdTjl7eifreY2+YvgPBRxKavXn0OzTFsFu8Pwfr8E8ZaqAv/dgUSLVAM4PZ9HxTWFGpA1e+CkxgU57IB7vcc3TRT3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17DcBGO+6YLG7OAiYgPiEvXKUjwNfnHVU4GCh2Uz8wE=;
 b=G9m6VlPU/pTIPTc3mxE/dJgvPkF8gwWMNhmMBbYYUoB3wbgB6BzcXSg3LXCoNwPZ1M+SErwQyqU7ijJ/zaVBQwSNljb2Ocw8DYNT++WT6YyEUyLAtNwUmY22HlYvqL7VKYbtqsje+ALwDWSFAyeDEQU8+iDYsW83kPMoS2ZQtgKVwjfFHAGhzplUilPdE/mXy6BHEUvHqPRlZmM0+vbQM3KUhpr7BTVA3TPzVW/zAoKrJxL85x93g5DjZqrUZw/Vnb7C+FcvBvL2fuxxOGcGuTdu1AxsD/HLkB+bxNqHPFeCrveHG2bCP/xLCfFHyTY/uOKdFIr6gRVFXJb2ucu8mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4275.apcprd06.prod.outlook.com (2603:1096:820:73::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 03:08:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 03:08:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     almaz.alexandrovich@paragon-software.com, jack@suse.com,
        dushistov@mail.ru, brauner@kernel.org, ntfs3@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 3/3] ufs: use wrapper i_blocksize() in ufs_get_locked_page()
Date:   Fri, 10 Mar 2023 11:08:21 +0800
Message-Id: <20230310030821.66090-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230310030821.66090-1-frank.li@vivo.com>
References: <20230310030821.66090-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3a4540-9866-4fd3-198b-08db2114be93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UhG5xTP4yssg+TGcvj/ga8TmcgZaEsvLQBLGpTzdh2TySWBAi6hHFCWMFL3HwxkTzemFeDWajdPaCJhYGszBuXlptSKA2qDr3/nG5r0U3JfvPGkZdruVWSJWkCqOAHWX8MmuTIaVecJ6l0jJjntapL2+E7EKS4P6DbsPZ3jysEm68neOZ7nyM0QV+FeJrvkq/ILEP4yLRGv3YR5KViz2K6yMk6lh2lGBr+PKqMN2arMM7FWNqNS9m1h12AQnVjUZaVJ8Cr1OuIgFpfD/83WdBi4ErUBKVgd1aYyDKloeB1tY12ueeOm5RLjG3sa4AwD9EDr17g/IVCu4mn3KYsRVNulRY9IgFnQUNbByvanfe1WkkDF7h5mup1XeadPLgPIhrRFo3XLAsyTkGTOFWW5H8Y4w6/m+kg9YI8rQvf9zCJRP8gucEarMDZuMDI84Z8yxjTIoyOoyRScDnMZEcMhplP5UcQkQ+DMNmme5Gu7KbRb5W7w2rk3vCucV+LiDT7Nvm3hwch6VVUSRTUFrS6P5wdbiTI86Fdi/eZ6TmaYCNGppBospM5eAxtOHeBnPuYsnFqrdKKZD0MFfR5KIWQkGjnzfCNeK/dUhYHCaYMnmFICBpjLmxT/phIbDmi9rzwp1+dvMwCBtz+TFXqsj31smcZ8AzV7Aipq8FOh9pHYk5hRE/61TnKlg1m0HO8bVAtHGBGPGVI+14dQXaAsIJDGJtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199018)(4744005)(36756003)(5660300002)(83380400001)(107886003)(6666004)(26005)(6486002)(1076003)(2616005)(52116002)(6506007)(6512007)(478600001)(316002)(4326008)(66946007)(66476007)(8676002)(8936002)(41300700001)(66556008)(86362001)(186003)(38350700002)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OiZPcYuAz/Innc0cNx/lg+0dmtWeo8iiaQQPa3WJi5K3I2Xmu7AgmW0heOXu?=
 =?us-ascii?Q?d7NSu1leFnwkvEXg/jop5U5uEeI6c+eBqEgjaK7fQq2bvbZHidvTyD/BL5w7?=
 =?us-ascii?Q?RBWyBnLp3ilKYt/1pYdCnsBxSSktJcGZlb6gaWXLy3i94MdqFKsH+7/3qpog?=
 =?us-ascii?Q?TJ5AG07HGd6XRItaL5OQzKOfNQ1eBqFN+GLD3abatIDHViohQLjvVUXTMdxb?=
 =?us-ascii?Q?DQnxJgIrCyvkd9BPeD3huBohYUUSt00VigJqsD5/CqN+Wx/175NnegUz9IAH?=
 =?us-ascii?Q?7+7nrsqbTvpE5gkWLW+FoVsBoaOWnqoke5sAbN8X/lZcE05MwZxSBCmmHBqE?=
 =?us-ascii?Q?6dbPVSLgIQEbn17VOair0pWeYIRxA78+QN8z5x2fs8HdQ8LkOGbhxgQJGxX9?=
 =?us-ascii?Q?ChxFXumw/omA4RcPR+aE5dX1HMbAm9470Zb5IxkUXutBNi7eNWiDS5DnkbZ8?=
 =?us-ascii?Q?e+m4l1l3DxaJNqrqObFFcL4DjgY5Yh8DmHvLoQY3vBlSC+5j/C+pOqDX+sMf?=
 =?us-ascii?Q?WvUvWFhr+pGLy6/l9r4jWXuPK2NC98w0gLAUaqFtGfHduSy/Sl9ZuqvTGRCO?=
 =?us-ascii?Q?s6BPhEY/5PsgSbKwMg1l2/51bo/emujJxV+tyjPoaR2MdfkFo3XlaSf0qnFL?=
 =?us-ascii?Q?r4bySsU5rMmzcmrfE4ppCR21wcMN6qx/0PgG6AIXGLhs4N/c9gb8Zw+ev3KR?=
 =?us-ascii?Q?6cBfRh1HG+0fr/22z+CVtBdck1CMTTKDSXTsgL63O1YH2S26GVtmyYxcKEk0?=
 =?us-ascii?Q?9DbwXFRuo510eYE/Kw3jX5aDQi0jECeWMpoQ6Mn6ROR6A1l4afLLC3U8kgGt?=
 =?us-ascii?Q?u4V1tYEbpZQ506AQ2tPWfGotho+uQOuK/kKsb+lGf2St0scgNMIm86bv9tbv?=
 =?us-ascii?Q?Ahh0KgN+tyDGzVNzAicdTMFewj5P3fGMGXU5nZYnmBbMFS9u1BhpJkP7HPNF?=
 =?us-ascii?Q?z7NRrFDDOGQtaYBfrbvbYQOfGIYgJuSNDcLCTarhXeZKu2vvxOoqtr4/UrLx?=
 =?us-ascii?Q?OyKLTJyraoM2nlcviQjVvKE1IPkD5yRx17KkuqjeW/RqfpnzywHwGA2tuFwG?=
 =?us-ascii?Q?nzDB75tHx6hvz1YVk/Hvte68vSkF/v6XnTYXra5LgFsL9MahAZzK/4zOHvrC?=
 =?us-ascii?Q?+FVpSr80v+XTXEcgy86n40n4U9mkLBrsU6mAsgPwcPAjFsJYiK9Qnq9xJTv+?=
 =?us-ascii?Q?UpsfjzRqIzeJQzEpdNXgcocK6wQr181IVl1v6evX9fc+l0IPBH+b9qUlHqOS?=
 =?us-ascii?Q?HquU53GEVC9qBdc29YTXnlZgrZTzL26070SKFBBS3IDDbb3y96803gHoal1X?=
 =?us-ascii?Q?sy1t9V9SaBsgUtGdjN9G5FevFhiyuhsFen5015fsqz9+tafUVVzmLqOc2E/y?=
 =?us-ascii?Q?YRbVkSwoRGk5o9qxFlebuqRjjTgevlIDqKx2UR4NZn2ztrUjWy4D67bVdCtu?=
 =?us-ascii?Q?oyknpWYsAQMqAb0Gw0MDSbKo8/IO3sxoVctqs+8INDsIru/GjB0FVbSpHTOV?=
 =?us-ascii?Q?qHTiLyDvIRRi1NgmRgJyMlc3NUzwAZmHYzgBfjzZ2FpMbC5b2YP3MLsb/8rW?=
 =?us-ascii?Q?0SwvGN3VTXI6R6+nLT31BpDaafOehegq9HNn6EiL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3a4540-9866-4fd3-198b-08db2114be93
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 03:08:38.5007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1dKmVNBxf3wLzjJvUXugW5BnccGdryKQ1ocjigesIpNmZhKVFyJeFFV1T7mvjZM6O8PJ1onXPiqTtRGIA7FCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4275
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use i_blocksize() for readability.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
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
2.25.1

