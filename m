Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B978766BE9B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjAPNE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjAPNDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:03:09 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2105.outbound.protection.outlook.com [40.107.117.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F24468D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:02:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jxa52YZVzd8e6nEEw4XMWQb8X7PTRsvPsiAM0lzs8nnLf7VsdzabwSIaqvo4Rp5wyhj3cjtyQYPHfKz+BEAa0Kqfbg1FvV8WKuZ5j7lwnQ0cMK6P8gDyay/dNSKTKfrnxn64SB8mu6QLeE/BpOwfFgH/OZgmT5eVSGSdvzvomCraWxfuuf+EmPSjg8S5cuXRNugX1IoJh7sqx6rTZr6mTSY64JPwJm01fVRdagbjoD5N/aEbsWjRBkrk9AXt17icQkGzy30syjlj5Mi7L0TzsLQb+vlH8LeDhyxb8JCpeoe0coFyJg2+/wyQms6cA4uVr+SEsDNBm0Lbq3Vv19AIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f36cEWbdgA4BZW8xHZW2RLhdOIn2TffiaahwF6T7uf0=;
 b=U5iDUuBWhad388ZIJaA2rWuIA7E4vb/Yh4OWwK3sEzPnqFW9ct79BvqgouVcOLcBRQ5ryoKJ8SXqLw+HBzU/NTgVZf2t1fjfOMARKTg70X5RRcVjPx0GjvRa2bZbfuPc5Kns2BHC7RGuOHuVji9h4ZwUkjpU3Sjz0hFHsPZ9Ca1Udd/NKuW4rI+nAwCN+M9yzhGkk6ezaMrztkBsOcxjMBZTrg4vfvsXIsbxfPdq1w/mGN8MhR7Y2hwM12b56LXPS4Pw9lKecPyvaKhOtMp2f+8cNfHi37YOTJnjZ9PDIM/wPRBWWxasBt/NXfaMAD4MeifikVOSB60REmcuvknHdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f36cEWbdgA4BZW8xHZW2RLhdOIn2TffiaahwF6T7uf0=;
 b=KqslN3L2GzsK1DASsiwCMmikUO3rt4CTeo9q2qStq62nCAcJ7bqPFDw+vTZT2oibA55ucNNm5HNabsKCWPVluYuH4szXQlF/klYcvZjz90JI5AbZ5bB9MeSj/dq4qwXQMiUElZV3jt6QTIc512+qc2wGmXyP+4gwG3QPdzzUIURPYfPW7w45ln/qSyX/QX5Q76ysVmM6WWhYaA/iUuJOTQE6LslZ8bm9soZFlLHxoNYGyvLwd9dJEwRbhQtbK9vga8L+wyhr3xGsLTOKHdGqHQI5WNVp1hAxok1H+J6TJ0Xqu2Fq+P1xIIOD3GS/mpIJ2KpaghpAZX6zsSdrOb93qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4251.apcprd06.prod.outlook.com (2603:1096:4:154::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Mon, 16 Jan
 2023 13:02:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Mon, 16 Jan 2023
 13:02:20 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v2 1/2] f2fs: fix to avoid potential memory corruption in __update_iostat_latency()
Date:   Mon, 16 Jan 2023 21:02:10 +0800
Message-Id: <20230116130210.34490-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::30) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9e0167-5ff4-428f-12d3-08daf7c1e6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wFwys1nGB0/uJNLVb1dF+/ssEvXJBoHLL5p1yefpEhzgrLjaJc2xlV0LTQawfmUrYo7EHj5JV1olb3EMBNf7ZXtbDWjDjZHP9xUT8IPR/ZrVimCLWBCUK0XU00CcvYDnumULlwAJ2eGJ6NbBVku2HmmUJ3HcO/PO29sQHQTA7bsM8sFuVnkVwLH5N61v9KYvymbQnNlLtAgHD5rRlgh9/EiSLge/U230ving47+WB6otyUU7UmXnEhS5DElip7t1BB7NlsDTezFu8ED7FgHaYOdOLe4koVygdairrvRpCTX7g/eEU/y9pHA6z9AjcG8rGQhAgCfR1LLdCNU7d9yNlunrPnTr5m7N4yypIaFl5c9F9Bbdq01jX1kYt+QxX4Xx2YIdGGhPl2iEZEcRCgCvJ1596eafKxVOcbLtk4wliJbYYxwendpobBthZbUUHOAtB9AUbk9r9P0m0X2UB27y4XJsLU29GQU4kcu1KBHXdEaHjnp+4/nibvWfg/jMolKpECXMFYAk7y+tgKMQ260+AhL4Cp+uR1MmHtt3tBRp6u1dh/bJ4gnI1NPUdhF8eqel7W2FPfkO50wfxL+fYTcqNgpmsrEU7jD8EpT4dXjGwbLP4ARy9Ytqf4tbyDE7gAjha+Ffq/LwFX49DWTKvV/243wfk9mlD8I7Z1txGxk7cRug2IsfzbZMsQXxgio+o/xfa0a11/EXFx1M41pAjpJHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199015)(36756003)(86362001)(6512007)(186003)(26005)(4326008)(8676002)(66556008)(41300700001)(66946007)(2616005)(66476007)(316002)(52116002)(6506007)(1076003)(478600001)(6666004)(54906003)(6486002)(2906002)(38100700002)(38350700002)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8WDTwv/bDRJWpZ4ftmkMixewUOgEcXnZSDsWf0tF7nVx3RdCHtcuYe2sQ/l4?=
 =?us-ascii?Q?SgLEHxlrw2cJwGbO/ppU8VM782PqSN9zZL2oWkwc7CRkJ4ewcUMhLldbpySZ?=
 =?us-ascii?Q?gKYe9Xh+2J1YPpe0VGCcQzbFAFLKIFB7LkfB4o1S1x2SYTcEdfbh9nJdIEgA?=
 =?us-ascii?Q?LJopFYfsNJvuc1RSbQiX/k7cZ1+LIibDGro6lly5VRnRDzWp9G9/rENt0juW?=
 =?us-ascii?Q?1aKv6T7FnNDr3ql/HdiQW8vJUy+QaEykbC9S6Rr/Yp3R3mXZKHDQvyrBdMpc?=
 =?us-ascii?Q?JYYRn/i2bFQ9RjV1fwd71Q3WQodDi0/yftmB0OgaRC96GQcO5OeskmApAjs9?=
 =?us-ascii?Q?H8M9evVc7NqriM8H68y1Wk0wjA3x3t90CRNttGjgRR/dy66EqiD2dAz1b+AL?=
 =?us-ascii?Q?RvYdcdqESltG/0+/eEr72wzXlRMwFeLe3TPfFyg/QJeT4g/BnM8yed+/4QsN?=
 =?us-ascii?Q?ATceIaSpHNH5ld5fYXU6XwIrlndsG61EW7kcwI+YbCzwOeMHIHG4+W/86nVb?=
 =?us-ascii?Q?i944DuEnfQRHpKdkR0cv8si91BkqiNCq02Wn82F087wkUTT5j37H0H1qQ2ms?=
 =?us-ascii?Q?9CeaUa4EGSO6yWs6Q/HxwNNclqoFNhH8DC8/vweYUjDpYDjyc4G/9LCl9Kc0?=
 =?us-ascii?Q?vtw4m1KbN/Ky6vHmRa+iH4vJCOvvYbZ5pU3P7PvgsitpvcdtNdVmZF4DdwtM?=
 =?us-ascii?Q?M28ZQ4WKg/i7/MBsH7YnVVSWfZgrVgqz4ElCL/oyTQGLgVH72BrkDGBQphoi?=
 =?us-ascii?Q?XdJ3a3w1K0hKDEhKw0SOwYaWR07bKf9U5fJ6wUFAKQD6VccGjLE+kKLuYrhT?=
 =?us-ascii?Q?XknRoiHDyINri6DB0IMg9PB5lBTqPUkpWP+gc8RVfh3fap9alykK5kxP7URi?=
 =?us-ascii?Q?zQBzgJQwNR9+6cRSPRUhUShXDmJas8o4iILpjvLM4M9qQAQ5iA+j2oMDVchU?=
 =?us-ascii?Q?hii1H+omQZQJan2v1ytwAJe0R/4lyvKU/g4xb1WhdoMW+VNmWdHV4El0PvaK?=
 =?us-ascii?Q?kdDNWvax+dERqn6AeU3/LBfIo5tNKnySN3mAhpxA1kgvMndlmA8ohPu8iEPv?=
 =?us-ascii?Q?ntNI5T4HIC2YHBqM0qEgrDVca+FMAqcfUJH1qsCdWSha7CEXracZSsngC4Dq?=
 =?us-ascii?Q?Q6nnG+nh5H9yMdIwEHhUxKfmuO6UlPI0lQn5c0rR3inuyivJVolTFC8QaR1E?=
 =?us-ascii?Q?S8VgNncRyzCGSt7pWCjr4JbVhkXXavaeI+q6Nu3nVlOHxtw/HzJyvC7q1mZp?=
 =?us-ascii?Q?BeomFgYGG2N7MDyFglNn/cd9BkWB2jTB93aSIuLiIaD6a8RGD30rf9hh0CaX?=
 =?us-ascii?Q?foriqlNCmqjl15azxisAZx6H9+7ElyOQ4iXIbA0WzzlnYp4Rt43xEdcZ095e?=
 =?us-ascii?Q?I87OwxfC5Mk6BzPPAapIXVs5CTNUCjjGBDbd4BIRBjvhE08lEhaFRivqDSsh?=
 =?us-ascii?Q?36LMJCuK5zqTZnNEwWq022o7AMsghz7GNFb2CRZVYCxYpC0/ay/dhq2wENL1?=
 =?us-ascii?Q?6Pw/vUkrd00qskX8JbIRfVBDx9JzVpBVfCvTknFidYuAb3FDtJ7VahTQtgk7?=
 =?us-ascii?Q?B36sK6TNCD7/e1m6i8o39SW/w+oDA3oZI/vvZRz3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9e0167-5ff4-428f-12d3-08daf7c1e6d5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 13:02:20.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zi2jd6TjiGu9Slgm770d8hC9vHLN559HvfQcW9ENC3PNccQp6HH6/r+O4WF/OD/R/w6cxN0tF6uf4ujNFdmalA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4251
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iotype sanity check to avoid potential memory corruption.
This is to fix the compile error below:

fs/f2fs/iostat.c:231 __update_iostat_latency() error: buffer overflow
'io_lat->peak_lat[type]' 3 <= 3

vim +228 fs/f2fs/iostat.c

  211  static inline void __update_iostat_latency(struct bio_iostat_ctx
	*iostat_ctx,
  212					enum iostat_lat_type type)
  213  {
  214		unsigned long ts_diff;
  215		unsigned int page_type = iostat_ctx->type;
  216		struct f2fs_sb_info *sbi = iostat_ctx->sbi;
  217		struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
  218		unsigned long flags;
  219
  220		if (!sbi->iostat_enable)
  221			return;
  222
  223		ts_diff = jiffies - iostat_ctx->submit_ts;
  224		if (page_type >= META_FLUSH)
                                 ^^^^^^^^^^

  225			page_type = META;
  226
  227		spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
 @228		io_lat->sum_lat[type][page_type] += ts_diff;
                                      ^^^^^^^^^
Mixup between META_FLUSH and NR_PAGE_TYPE leads to memory corruption.

Fixes: a4b6817625e7 ("f2fs: introduce periodic iostat io latency traces")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/iostat.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index ed8176939aa5..e9a3df7ce4d9 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -223,7 +223,7 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
 		return;
 
 	ts_diff = jiffies - iostat_ctx->submit_ts;
-	if (iotype >= META_FLUSH)
+	if (iotype == META_FLUSH)
 		iotype = META;
 
 	if (rw == 0) {
@@ -235,6 +235,11 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
 			idx = WRITE_ASYNC_IO;
 	}
 
+	if (iotype >= NR_PAGE_TYPE) {
+		f2fs_bug_on(sbi, 1);
+		return;
+	}
+
 	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
 	io_lat->sum_lat[idx][iotype] += ts_diff;
 	io_lat->bio_cnt[idx][iotype]++;
-- 
2.25.1

