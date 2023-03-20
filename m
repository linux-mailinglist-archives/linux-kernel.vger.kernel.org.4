Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253A36C1DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjCTR2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjCTR2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:28:23 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2113.outbound.protection.outlook.com [40.107.117.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587A136FC6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWklLEbFM8DKENsJlGSu3WDDV/eyGWWojNY+AEVqReSsBiRdrAO5ahdTyjC2DnEhvQlhT9b6O+yy7IEmZtaduhhFYCzHKu04kArAlJcgYSGlPHkkYScJz2R+rrMWLB0gTSBBsAC+eP4S7tRvD3ZvKQxrHG7CYPdOv5KTF+eZ5RV0aqERRlhq4BEVvofmrzJPuSdmE3rB7aJ4IZkPiBbwhvX157FYcoPDqktZafg1DjvoCC7tlq0ZGv7Y6n9aDepTPFBlOwRP4jYgHODqRkUD4v3KYvdvblYXGLQ4mAklGK+MPrpvS0KZ+1VVI5Wh7QrZx0kduYmcSNklHlWmCuoo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaqFq2AW1lwumWthgUKClHxANBoTMbpm1VReF99veUA=;
 b=haIcO24cKm2FY9fvJkt5oYZYwCLIHDSpzh0a+6dF2T7FBgBMtpwOaLOMYKu+tJQ1J7nSJtPwXDbQTWAvnOtiH/8y2jaxBQuXU8hpkltGH+16/11aMiuzFDKQ645jDcCdoUVMluJJzxI7jOUesf9m49kyLkTZfalxGvWd9RCc4TREF0Sh3e6SSiSAi2Col2Y1l5tggJGribe8HBlcODrnTp7NjfrAKKIKMRZrA4tsJQbH+DLEozqNcEaV0+QS028ELhTZaB3qDPZKi65A1HiUSW0XfMXIWEXAJ0Y0rinNmnX5jNhjxEYypT9vUBgpcjVl2CuCZbLlG+PI4AsuVBIWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaqFq2AW1lwumWthgUKClHxANBoTMbpm1VReF99veUA=;
 b=U/kenAmx2lfJaD5E8MtKEfN/K/XvzEmz0amdfLV9CRLfpl8gGSyZ2mXp+qXw7C5Z4tPELenhqYbiGLru+LUPSHL+i/p+vQKTc+dljqlt2fuF8iCZTbtKOuzbEvEktY1+UZ7O7ejVD+75OtmkC9XmjMD75UOi/vJn3wCmzu4dF1fvfc/8Ra+Xl2/wYQtG3rBGxBwxY4OteBa7FXLZV0s0dvxN4r5f6+nRIgfJsM5rFIWy533q7y2DhI4csaJ1mM3q4uUHD1qhMNl+0J64oAwWPJBv+hDkM1RqsOKpcDK7Rep7wW3k02lCXY+5rxyW9lldRUYFbMXVQ1e0n1jV2/SXHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5191.apcprd06.prod.outlook.com (2603:1096:4:1d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:23:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 17:23:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, hanqi@vivo.com,
        Yangtao Li <frank.li@vivo.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] f2fs: compress: fix to call f2fs_wait_on_page_writeback() in f2fs_write_raw_pages()
Date:   Tue, 21 Mar 2023 01:22:18 +0800
Message-Id: <20230320172218.59628-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: 416db935-d2e7-4065-479c-08db2967c511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQdcA33MlWBSG7XpXmy6nAR82dp53RpJVy6pc4PG85dX9ZaFdOdf31W8BICa8WrR+pebYg59Ejr194/ixNiS6e++662J0482ru4uvYhn4BeabPdFDzdRzaRzG0OXMa0IHdBysqJjVVK7R0i5eZhiGeLFR93svR0S/aVRQjkwuvAah4qVoPrL/P7eDyprJLwggidYV2wNc7GWkFkiJJLEWMKsZONow8plgVL9/dZM/e0EMsYDsuE8O3uoDx+CV+WDV9hQRCOQpyiiv/i74lzC+02NEk9f8enSJpzBcukzo5CuaaUl3JfZfENP4BAGlXYy0bBQqgkCErmm1VbW6f8dJQtqcgTZCef0tQ97XMBGXrFdZkhPleCR4i3wqIHHkEwX5B3T0NRZTr81ZTBk/YeJd5zxlZBJRTVso4ODNmMXjnBwEKADhpg/F6PQ+w/byvJPiGRFItm6lF/L13xvkdDmKqUYWVbvGCFnyQilEJBCkvsm9KqyEiR0OEArTVjqPoGTXjSriMaxMX3kegUMo6USatInaN8CMLXb5Ml34FR2wLhPr+IzIF6vTiNQXBFnH/ROiYqZzS+AKGhkxAoUJJHXW7hWXubMmMABIeGCrQqg6ws3GGMPLIivZEvPyBh7UqiklUbD8gIw1c3hUX7a2Hh5QuN1N+I748/tmN7xxZy2BB0V/oIMeJb10+V5w+HcRn9Ko6ZJK3gGqn5HAxPqPfBbFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199018)(2616005)(83380400001)(6486002)(316002)(6512007)(6666004)(478600001)(52116002)(54906003)(26005)(186003)(5660300002)(6506007)(1076003)(66556008)(86362001)(38100700002)(38350700002)(66476007)(8936002)(66946007)(2906002)(4326008)(36756003)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aD0dnDmMpZ0kMypQQBdWBI55cP+NJ9ZdSBY2PZR985GutRFv2dxFFV+Pd0SR?=
 =?us-ascii?Q?CaogT8GuzPsqNWmrSNydWkMvFe4rqdcY7W/DSDH/60Do0GNX7GkoCFwcxq/A?=
 =?us-ascii?Q?PvjV3LBFZwhUu1l0rPmAbouo0DS5kuKi+gatBnC7WbdSXB3tFs+j2vbl3g9+?=
 =?us-ascii?Q?MiYppL75cND1NsPZya6kG8O51eZYtk4rL19YcBLHGjDzQLL4RoLsaF9agkH6?=
 =?us-ascii?Q?02NBAWNJefEqmflAYXNKqJad9KAzhtiROA/gdLESvn23+irvylUI7g5/x3TZ?=
 =?us-ascii?Q?q6QF5C3MXxYDyXx+bHcA/DaSCDoBK4wTRnWOuHTAuDRm2gvmYoDVJO1TmYxY?=
 =?us-ascii?Q?mXxR5+STuq2wfZ6TxKAWaL2/YVa+sFOTQVk+1kEwiegO8P5K2lfKjkQRBz6y?=
 =?us-ascii?Q?b8RtuHqINy/xqAlHF32EHCbVNlqxEAa++HsApbykO6tefLiFnvJB58092i+n?=
 =?us-ascii?Q?I5DVDm7vJAlp5gPnhZk74tlnYLCheF6CzlzlzX30PJQ930s/4hNOhHrMfR+3?=
 =?us-ascii?Q?UhFaDz5j7YOKb+wgTDRl3TsJsRS+XTNzVZTDXXKGvrPEwia2khmVxOFN1fN9?=
 =?us-ascii?Q?peXfFuWCrd1DyRGuhqSJ04Xrv6dmmVRGwcfwQ99O/YYccr2PXoLvyT/fNIU8?=
 =?us-ascii?Q?TmHWDfD4eMp3vA3Euqjmvh7m6oXPoDJAR+ou3dqaQiO077ab5t9U0YxWgRXU?=
 =?us-ascii?Q?4ene9gOrgHOI486O/mxGadrTAmCNHx23tSszV+/Gaj2U6EZRhHlzezfBAOnU?=
 =?us-ascii?Q?O4Exx/XsKEvxC4uRkHx4wEnvoxISWfIsDpBu0kFCbhbMOYNQR8WFX1jBD3v2?=
 =?us-ascii?Q?A4RunDwtjxl7ClS37Q11aeSr+UGslfQFSiZVhW3/HEOuZ5FSzfVT93T/BgAN?=
 =?us-ascii?Q?x3hUwXDvLIgtRUedSl0EQBj2WHsY5aSMJ6yflls3f7G6w6df6469IUQLV0Tq?=
 =?us-ascii?Q?yQZFgRQdPrqMJCxIlDWvzVRAjfIOSq8WZK7SMLW/heF7/omO1Sv4CHFE4Gpq?=
 =?us-ascii?Q?trZoKCvihxN+WSRhF9GR4ItcrGpTUAOoVjyYZ7Fc8JXMLpFCSwiKluhV4sif?=
 =?us-ascii?Q?xSex9wZim56YiOXan/ci96teC0q3YInpt69l6BiUjiDFcLhuObX7FxcXVBN/?=
 =?us-ascii?Q?pqn9opVDa+iDdT/yK4jwObhSgg7rCZP6e305r0cVj6FaeQfnfwYkm8CV786X?=
 =?us-ascii?Q?VNO63Bqckun48NYwwPEJGGVhj8tPT14Bv6PFLi22elMIAn6rQaG6XHKUIrmv?=
 =?us-ascii?Q?Tp/f7g1sYVSay7oVLNImMDlSpFec9OCjZTZzuGLxt7nIT84nAnz3MbufjeTX?=
 =?us-ascii?Q?bNth6nvskt6TR1m5wnwyRd56C+s5aMx+gSPZxqWn89UwwISIHMVAwDZw5olR?=
 =?us-ascii?Q?/aMUYl9Yp6ibycYWN9CVlCTmBr9/+WM3pw7GGrxeMP44c/L7xxtUuua/WI/W?=
 =?us-ascii?Q?aPTC16c/Du7XbTiavOMN+nqpd5TaohtpDFET83CfPj4bRIIYu915KR1I43ym?=
 =?us-ascii?Q?+88OvuKwUQ/3C0pUQC8qGu4TgR7pE20Xx3pz75K1TYo3XvtCXQNrE9GzqzWW?=
 =?us-ascii?Q?QRCI8UAj5JDTSnKeHKTDlkAgyOjbtz5PoEqL0CYH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416db935-d2e7-4065-479c-08db2967c511
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:23:06.9545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCpo8nMylvpaB5QKR2Fy3lHN3Gy9/8oZHbomHMRrych96z2Af4jzuL3B/MIoxXU9blhfWVs/2DuAOljREBbNUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

[Process A]		[Process B]		[Process C]
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

  - lock_page()
    - f2fs_do_write_data_page()
      - set_page_writeback() [2st writeback]

This problem was introduced by the previous commit 7377e853967b ("f2fs:
compress: fix potential deadlock of compress file"). All pagelocks were
released in f2fs_write_raw_pages(), but whether the page was
in the writeback state was ignored in the subsequent writing process.
Let's fix it by waiting for the page to writeback before writing.

Cc: Christoph Hellwig <hch@lst.de>
Fixes: 4c8ff7095bef ("f2fs: support data compression")
Fixes: 7377e853967b ("f2fs: compress: fix potential deadlock of compress file")
Signed-off-by: Qi Han <hanqi@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-avoid the else
 fs/f2fs/compress.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 93fec1d37899..9b7149534a58 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1456,6 +1456,12 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (!PageDirty(cc->rpages[i]))
 			goto continue_unlock;
 
+		if (PageWriteback(cc->rpages[i])) {
+			if (wbc->sync_mode == WB_SYNC_NONE)
+				goto continue_unlock;
+			f2fs_wait_on_page_writeback(cc->rpages[i], DATA, true, true);
+		}
+
 		if (!clear_page_dirty_for_io(cc->rpages[i]))
 			goto continue_unlock;
 
-- 
2.35.1

