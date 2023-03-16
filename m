Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9DC6BCB05
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjCPJgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCPJgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:36:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2125.outbound.protection.outlook.com [40.107.215.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730A15AB4D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:36:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHXvq5jUbFI2kTFbfS3NzLzO/lWuaAZqjkSsurZ1OwsMENMjGaUd0R8pE4/h7OV0ulaaYiTK19TIcrkuoPdZsBv93pcS3W395g/6btGWv4jZCSQSAQWVJ6KKSff3cYJdViEUCtsXECWw6KxN1TsvhmaMt7FDXPuKY6PZORGl3b9rGHLdizlRKequPaCLNz0yGi13LUT5RVLz6dxynpHv/cj8EaUAM37q+/O/pmursUmN5gdbEn3kIZxuEXNDA4h8fIuEI2S8OzYDUd7bd/PAuBAlL7ZyDSMHaAThmIcH5xhhSZTamVF8klS1UP1Yvo4SpaTXpHpLCBABdfggoM2G+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U0RZQPnC1tcpJmmJoMmkD3JOczH4sWS625pRkRPWDw=;
 b=LKbB3OWaJuuFvrCn4cqzWZDv0Tr9+Lm2T+wZvT27Cx0uqsHRu3ycCq6oHQwWh09pL5x6b4j6TcJKdBGvEjuB68N+3CdfbCy9rmPImSCtTxgjFXdqztxWmctUMa1V+xSFv/6qitXlsXkwhNFtoc40OVv1iDgJiZWejGc8Pt7Dd45aGDqFH5TuAaaU5MYI3PN5HLYJEaXOgXPp0vfzlOVq0XONturq1cq5YCt2r3DbcGoXrbr1PgmHfShRDdk2ePYIa3IKS5rcFnIxMl1GeVskKGGMJY8uQVcbhHdWqhwTHkP5CtkDl1iVEbWFZ8NKfCY4gJvoWHx2MTkCk1WVVYEB6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U0RZQPnC1tcpJmmJoMmkD3JOczH4sWS625pRkRPWDw=;
 b=Be6vO9loNrFzogyliYZzoFy8YBhqaoLdruAAFOjOVvrk8pG9oYgDE3EfPSrD48ZQngdzV0eFJo4PFo+bzeZrHZ/5p/T+xItbAlM7X9m5wdnr2OOSCpe+dNIEa0F9Cm5AdS4a8IAoHIIP8+c3lCQFXPCp1wIpi4a+UBegy/FMyeezVTKumZadWRJVJl8RjX+7HYqRfvsDsYTXbOHbfyDDhH48gI24rdX49a9YbPmP4i2q27PwZJ7HuTPapsYGi0ydh76foef1lriQKZMeNJAqS9w2+CvY7PdkLA/kj9Yvv8ov0XUnIiiP7JujZpLX9H0yA+Zt6sSOlXib7e5bcakptQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by TYUPR06MB6077.apcprd06.prod.outlook.com (2603:1096:400:353::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 09:36:43 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%2]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 09:36:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, hanqi@vivo.com,
        liyangtao <11127627@bbktel.com>
Subject: [PATCH] f2fs: compress: fix to wait page writeback in f2fs_write_raw_pages()
Date:   Thu, 16 Mar 2023 17:36:32 +0800
Message-Id: <20230316093632.25929-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To TYZPR06MB5275.apcprd06.prod.outlook.com
 (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|TYUPR06MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe01bef-114d-4595-8719-08db2601f345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVPYnU9fuoNhliwIw0Aqo8TiPIUGHi55hfMjSMReUWStjfYkFyeq6IploLVr32F+uN6GRCRo6PIE+h7VYhg+8xzhTpDkwhsszfCgtelLjw+hE9F/L8Ce79tUvy9S1wI8WLHDxZ+3kAO4hzA45bhtsaeaGgkUfxRTa+GBSjJCHKzIuxJnJc90paKL1pRvY8iT/iZa4rs+5LrkHOiw/muZL7Av20shGq2hl2lCQFSZVCvqM+v9t29obH9UhXFfkVsv+7AUjm5QcVJbkGE6Qc/aYakxy4r7XOCBd+I/UEqVPnJZpTCRD87CU3NV6jaAf417kvOqErADg1iBxHkv2XPQLCStFCHc7T+HVpXzrCTMAdVvu1GRyKq8R6gCjFJAnZ3aPdDfD5hegL8yD8pq3yov4qdCWpJffwHL8BBqBNiLvBVT8wbLmFkEo/WA3vFrXM/GgElPRB/QlRM5d741LHlPeNqlQoKThEIs1vM3WsRGrDJQPaVKXTC1hEKyAzG+QnlzhZErMTgtHmrqMP5tEnEfIiMkcnjIG+1ZG3ev59JHVQIf/kehZ3DmAOZuglmeM6i9dRR2k5r815EVdkZ86dH3Z6L8R0qsy/1rYHscFMlqb1BPl/loZio/Q49Hy9l+tRoBO2BYVVQb47+P7e+PFSnYa6EcAPFkpEqn6HHi5/kcY0aDXB1JABadKvxZ/ohOphLKSmBW8nvOs/c3bTkpuPp1IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199018)(2906002)(5660300002)(83380400001)(41300700001)(36756003)(316002)(8936002)(66946007)(66556008)(8676002)(38100700002)(66476007)(4326008)(38350700002)(86362001)(478600001)(186003)(26005)(6666004)(6506007)(52116002)(1076003)(2616005)(6512007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Q+QO4zuQm5t5yx/y4t/HUG4oKZ5Xp17Dj8toAGXcf5dZra+bpyR8cn8WqNk?=
 =?us-ascii?Q?yjiMwn3Jaali9XfMx/NAK6yidypoK6kFuehQx87Os5SZwrtaKkwRI1Ow8Ohf?=
 =?us-ascii?Q?gelwTgvOuTKBrS7AOKynrUON/i9qqMlA00obKT3/D6d8/OB2BNnxLkOC8MNe?=
 =?us-ascii?Q?gA7egHfunYuGTTWcwncOz5ududCDc+iAwWLtNC2cVkX/8KUL7Xwc5LJI5sx5?=
 =?us-ascii?Q?NTLdk+jYX30cvo6mhHSsdRyJ5btV9JzUH8lmOxtioCPUE65Wy26aKsxlgffJ?=
 =?us-ascii?Q?5MclZaro0tMKigOyycSqJrrrBZsXwcwqfC9Qr6HI2n2P1v+PoVwqvHxpVifj?=
 =?us-ascii?Q?3p3BgZL7YXmV/tfdDz1JM03QEx0eNGLtkPFeh2+hJcPPQoOOlzGwEcopBywX?=
 =?us-ascii?Q?J9PLe6K8GByuYfuEm7V4BUMG1l/5aaXEP8zbsneYAh0M/sXqAR0Fby7hypj6?=
 =?us-ascii?Q?xfXHrcmei0qU7EQCxvNcVTFcqBO4khQFaYRSHV1xxMOzrnjmDNNYo3XogVgQ?=
 =?us-ascii?Q?PcBuQo1z1U9H44VgbPNpEsyvSMgCK3mYcU33t/06g3/tKfoXz1f7mYxEJKrO?=
 =?us-ascii?Q?/RLvM7wdHXQuQlUM/25d6RsWcq2fW/Z2TrhLgM+DkC261Ju6UHMA0oa3cmUx?=
 =?us-ascii?Q?l3FSSAkaseYvyxPCqnsojNiTja+u36YGTJjVLJmydmuapWiD+7lCe7+fvmfG?=
 =?us-ascii?Q?+2OqkWy90fUD+BcUAXWYvYu4wWlCKB/vdALsjyonoSNhpIhfRBfMNVL88D5Z?=
 =?us-ascii?Q?cCnAkTbdhhs26iWPSQujpT9YGYtjsAXMLfbP/AfbH2ODmkkQs3xWSdNoLPcZ?=
 =?us-ascii?Q?1JdfYgQ5f8VKUE7xCGdTmvQ6LBmsUfKr3FOHAFNhTx8kzdxXG2SEz7G/8C9q?=
 =?us-ascii?Q?YB5qISuWII9y5Cq7h2QDYU513Hw6EtNe6g82xUNCAYbGLEfCBkXxXG38Zi9H?=
 =?us-ascii?Q?90GjJyCpVXNpAmdjCzovLTWLXfAYYTAAhYh0B0wzTRjF4Cci6B+TOvD6s1ix?=
 =?us-ascii?Q?fkt/Wc5+Fq+pElEObpKm4uwXUdlyBCn5jsAWhaetLPVFOOPVSur9t3qIAJvA?=
 =?us-ascii?Q?y4VJXSryVqsXQYoACEBQxM9fDRthaMrThW+esE22Osxho8efo6he6jINaK57?=
 =?us-ascii?Q?9/CrdXwC3LhpXHq/X1d/02Zw6IemMb5e4XJGSyrP0vulBZWshTkjdY0/9RjS?=
 =?us-ascii?Q?GX1EkpZRGNpl/KydkaAAGt+9FnvU1mVfKeckddHkM+Rvb4mDP2PP47+WsmU0?=
 =?us-ascii?Q?vMS0OZ+2o4M8nvJinNZrFW1NLSXiv5FrZq9gkJW2iJxRlP6X6214CC/k8fWG?=
 =?us-ascii?Q?YrTfDT2g8FRI10j2rG/Hcpn1i2MOQMRWpGDThb71xWzksRk9JOxtxb10gfx3?=
 =?us-ascii?Q?J76f/cCob45jmTBQ8JDmPdF6UPdMzwAJottFFXi9G3gW1/pbSvvl2N5Fp9vO?=
 =?us-ascii?Q?v3lvjFVf310mWUQY04ZYRNew6Vqp0kCPGX8CdWaJyZ6DqqS9MeAfucrO8/Jo?=
 =?us-ascii?Q?69FBJCl2z4eVBfqtJteinNrfhs2ZP2U6oKMk4d18BgyXIxHtHcWiwnMfQpJt?=
 =?us-ascii?Q?NdS7vgktXOfv3I1idR1VcqQFmMobSUSdbez56PKZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe01bef-114d-4595-8719-08db2601f345
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 09:36:42.2878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wAUac34AAqmAdS3T5eZkQAJA3Tm5mijNNsrZXX0GanBPwG02xFC94Uwnn9Ady6TGrU6riXFYWhHrZUeEOr75g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liyangtao <11127627@bbktel.com>

BUG_ON() will be triggered when writing files concurrently,
because the same page is writtenback multiple times.

1597 void folio_end_writeback(struct folio *folio)
1598 {
		......
1618     if (!__folio_end_writeback(folio))
1619         BUG();
		......
1625 }

kernel BUG at mm/filemap.c:1619!
Call Trace:
 <TASK>
 f2fs_write_end_io+0x1a0/0x370
 blk_update_request+0x6c/0x410
 blk_mq_end_request+0x15/0x130
 blk_complete_reqs+0x3c/0x50
 __do_softirq+0xb8/0x29b
 ? sort_range+0x20/0x20
 run_ksoftirqd+0x19/0x20
 smpboot_thread_fn+0x10b/0x1d0
 kthread+0xde/0x110
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x22/0x30
 </TASK>

Below is the concurrency scenario:

[Process A]			[Process B]			[Process C]
f2fs_write_raw_pages()
  - redirty_page_for_writepage()
  - unlock page()
					f2fs_do_write_data_page()
					  - lock_page()
					  - clear_page_dirty_for_io()
					    - set_page_writeback() [1st writeback]
					    .....
					    - unlock page()

										generic_perform_write()
										  - f2fs_write_begin()
										    - wait_for_stable_page()

										  - f2fs_write_end()
										    - set_page_dirty()

  -	lock_page()
    - f2fs_do_write_data_page()
      - set_page_writeback() [2st writeback]

This problem was introduced by the previous commit 7377e853967b ("f2fs:
compress: fix potential deadlock of compress file"). All pagelocks were
released in f2fs_write_raw_pages(), but whether the page was
in the writeback state was ignored in the subsequent writing process.
Let's fix it by waiting for the page to writeback before writing.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Fixes: 7377e853967b ("f2fs: compress: fix potential deadlock of compress file")
Signed-off-by: Qi Han <hanqi@vivo.com>
Signed-off-by: liyangtao <11127627@bbktel.com>
---
 fs/f2fs/compress.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 93fec1d37899..904af359fa8e 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1456,6 +1456,14 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (!PageDirty(cc->rpages[i]))
 			goto continue_unlock;
 
+		if (PageWriteback(cc->rpages[i])) {
+			if (wbc->sync_mode != WB_SYNC_NONE)
+				f2fs_wait_on_page_writeback(cc->rpages[i],
+						DATA, true, true);
+			else
+				goto continue_unlock;
+		}
+
 		if (!clear_page_dirty_for_io(cc->rpages[i]))
 			goto continue_unlock;
 
-- 
2.35.1

