Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A265670A5CE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 07:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjETF4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 01:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjETF4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 01:56:40 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F55F128;
        Fri, 19 May 2023 22:56:38 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34K5oEsn018549;
        Fri, 19 May 2023 22:56:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=fkC6Op28jPOcrPy2Bdr/cq5QNzq2WETYA3dLwpvdWBo=;
 b=L7kn8LDJ6B5f6GrU5KLRUSNrXFY+RezQXxDOjAFJs17sGAyBKj8wSuM6ld72NuKI/saL
 FNnxffZXIMhKHI1HGhuEnrYkSLLw/OYPyEQiC9JZSeEN7lNHUcxN6yVLE1l6tNyahSw8
 HcwL6HVrbXSEPxtyIpk/Bv3bu23P9drSrsjrPMHomvkptiZ4rE2EI/9ov2L8nfxBgRKA
 D/wWomwm82GcZ2FJ5P+5G4V/LUFRKmRPvx9zHfEyHvVUbAeakx4YF3S/jUyJfKKIMnRH
 h/uIvw8dRY3KOmRQBOr/Oo+ID2vz3QkedqZOE1RAQj835yQfXy6YOiqNDVNWZEkQWSPk jw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qpkrdg561-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 22:56:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpjO4mTv3iAwq8M8SgGeyqOFCID5pFbNYmNskMr/mG1IF2jWq/42NQUhlLi+un42UQPxIcLQZdJijnKaPbQNskAWPyTZql2kexkLJYeh4dE7ybumVjXKu9+YgX6rFggt7cEJfYt8owQoCALEz07hlx5za1qh8uDTKVfXAIPV++raZKoxgIPm57KYUdUci1d6LnLb9c7ka9BI/+1+EOVtyLFdr6Wo/1aS9w0WuqzByphjYaxdRaon9FiLfDc/xchIU6gFFZTKVxCz6xdmcbFfOtSRGKAca5JioQbV1sK4P/5lMOYg2KL9xFYciwRS72m2i+TypiiUH7KvvX9LKUwOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkC6Op28jPOcrPy2Bdr/cq5QNzq2WETYA3dLwpvdWBo=;
 b=mJ6fUADMXfD8rHrXNRCAhzgOULY9GybSs9dzmpyWaFZkwTOo6Epobdr5zC6ImcC8qTUowG2rbBJM3i5wuhzd1uvZC0/r5JG+8tLU3aBAm8YQty3tkjw2TWFYEqbwTFF4e0zrHUTL9Jjh/GmRoDTLpyrE89KG0RNOclx72NBcrORWdce2D3UgMtLT89750wMqhtEAGZVWHxb1gAemBxE2xweX9t71iyxdEfx5QG3QNZNLKFYPQlzKUXOO5xXgWT2157VPHPx1yOaJ2g4UtzmV8xEx1pF4mgRhUJUrbcFHK7FWIu5uLTViwUQAVl7Wxhgkdhjtjnzm4NlmbOKMpjE5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5175.namprd11.prod.outlook.com (2603:10b6:510:3d::8)
 by PH7PR11MB7551.namprd11.prod.outlook.com (2603:10b6:510:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Sat, 20 May
 2023 05:56:31 +0000
Received: from PH0PR11MB5175.namprd11.prod.outlook.com
 ([fe80::fcc0:8e8c:50cf:6736]) by PH0PR11MB5175.namprd11.prod.outlook.com
 ([fe80::fcc0:8e8c:50cf:6736%7]) with mapi id 15.20.6411.021; Sat, 20 May 2023
 05:56:30 +0000
From:   Yongxin Liu <yongxin.liu@windriver.com>
To:     luiz.von.dentz@intel.com, marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: add missing hci_codec_list_clear() back
Date:   Sat, 20 May 2023 13:51:47 +0800
Message-Id: <20230520055147.3212541-1-yongxin.liu@windriver.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::16) To PH0PR11MB5175.namprd11.prod.outlook.com
 (2603:10b6:510:3d::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5175:EE_|PH7PR11MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 3714ae14-2e9c-43df-1007-08db58f6f550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJXXbKyhH2+JRWcnCGGkM4f3G9q58tx42M7Jy/peHMNL0wgal898q0zskNlsJAknQNzgbdbGV2xzi7bBSjq/lV8jNf/aH4kcq1/QRWRHIpIz+nFz3ZhNoBqAE7bB1tPyGMpKckj7Nd3SzydQKVRN0P8gz0mHQqOXpSM7r8BZ20CzozS+bgSogK+zKBQP3vlwhYr2TruK86QfaKD5gjr8kBnG/wP7DjYCz623Duo5iONE4M86MLH0If5jVmaKkc1nbhFcL4FYT3Pu/3KsY54THoOTKMuCJjN8WRd2o609uHcoUnKWCBGz1qKFoV0xedqi7sf6+C+TkT2uLdKpHxcmBfOMFHWoSAFiZwQh+/0F0GMAFlRtyzJiNC/rqHx/i0m3uwDmxR6jsjqGDIwAmULcLsOEwFJLVBOqeJgQLNogyrjvReYBPYfxQjPlBUH0ctfIe+xcThpbhx3KhH5tppqh4bbNTQPjg6DwR7P9WDGfBU96XjUCknzIN4dJ6+uEyuIobmb7iKmHM5K2J5e3Ne87+9dv8FzvsSUgkdDoIyvnvc6d2ja3Si03YsXFT9GiyF22oSlfiBkk0uP6d1k+vKdY+yEC4HTNdBzUTOCsCocE8aljdn76iVOTAxF9pTX5GdXXcPEuXgmlfzMRzRj8sqOFZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5175.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39850400004)(136003)(396003)(451199021)(36756003)(2906002)(4326008)(8936002)(66556008)(44832011)(8676002)(86362001)(5660300002)(41300700001)(66476007)(66946007)(52116002)(478600001)(6486002)(6666004)(316002)(1076003)(6512007)(83380400001)(26005)(2616005)(6506007)(186003)(38100700002)(38350700002)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UP6YoeBEaTzciBKXfIfclcw7Bww0jQTLO0evRuovtByN+fJa7jAU9YAF/jie?=
 =?us-ascii?Q?o1dO5akTWh7Rg486RbR/ExPYDsc5lc+iuinwbCrirfMm17OdB8J43nukCRFG?=
 =?us-ascii?Q?tya+UU8hSq3U4mmiHaLutFd8Avat02KHZMdFyI+A7K9N7r5806PgJEUATp1M?=
 =?us-ascii?Q?A07vKLS2LQ+46WywargSWdvFdHxbakwZnecsa5jZyYAbivYr3rUp1/fAq6gs?=
 =?us-ascii?Q?tN23v23KVOVvLa5bUnudNf7XfrtfvshpMBSQ5d+hpECnmZTttORc10W+doeY?=
 =?us-ascii?Q?YF6bcCRYK25tU7R0DePzg0p5bts7fvhxjGMi8Khl49HHEc7iTSZ0XyQ+NfNo?=
 =?us-ascii?Q?IhIxlDS6OmPmqUHWD4KRr8p+ci16UjZZNzlYP4G5ya7cWHht8j6GUMbhsYbe?=
 =?us-ascii?Q?hqsv3VYmXaXRI8j2xx2TAGnVarMElPCH8cPfixRrdD7mjeL7dYgerFe2dWpX?=
 =?us-ascii?Q?X7NW3LQuQFy5V/Kkqo/meDV0qfhaJKLsJjf2yusr34iMAI+KdFZnkkmXfsWV?=
 =?us-ascii?Q?LOkhGLPbHjDX8MNjatZZUXSXTWBTNfyKQfrPS0C1Ytf4PAUdMBRIYcS90QtX?=
 =?us-ascii?Q?VTsXtcrczj1NJAT1jDIBJfLe1e/lt0I6YiDNZLlxdie6/5uHoLLxehidx6Ck?=
 =?us-ascii?Q?GMf/2DAgGO4Weyup2eGt+D9ULs3eY473/y7V0sSs6fFC5QGohxfw7B+dUHve?=
 =?us-ascii?Q?tgD0IUmUZOdIHsWI1jJE2oN75kHjvwhyzDmrZnos6Lx6owjjEIfdYeClaA5z?=
 =?us-ascii?Q?lLV4JAUc9UXvqgyk4OzVwlFGj0YHQdtREwfe4ABX6jqI0F/e1/xmsOWHBecX?=
 =?us-ascii?Q?Yt25zSKFpvsiV/bk+HFCnL4dPu2GgeJRnoyDLtbtdG+yugYUMvlAbAce6YlK?=
 =?us-ascii?Q?AoMPQ2Ryn3hOZCQyW6bCg0igi1F94h2C2pC2Q3GwXwWuxQ78cOxHJwxy3kIZ?=
 =?us-ascii?Q?1YRTECUjKv1NSXfhFtMXfjV7Tr8xxZIIsW3hWRXHdNEHht5xYGioGD4LcRTb?=
 =?us-ascii?Q?m68uwAqidHYFE6tdkpudCjaQGDj8eK+UpWWiVoHEMw8jyvFPGGkvXf1nCoXd?=
 =?us-ascii?Q?HvgSJaQg887BV/BYBSLVTjkG9B0iTQCglOdLWpBnkCnbkzq6VLEiBWgJNhCp?=
 =?us-ascii?Q?NssFGOUDoCtqPekR9Q68C52bfiIi01Do/gDlQObtY01U6k2yAChLbMB+Qd1x?=
 =?us-ascii?Q?dkeilNJe1t0sbqxDTM3TneS+Gupv28Xh9diFxoC97wa4y/vgxkJNCy3dJyz1?=
 =?us-ascii?Q?KgMrfiz5XWxvUhIfHTyTOaFCoJVDWclGxVnXOGZKqhOZ70hyEwawY1BG2bLn?=
 =?us-ascii?Q?nDqRwbWtD7GQGLMLw02J33S5TR0Jgpgs318IB4v7ZUJ7hIslA/QehcLj1c5o?=
 =?us-ascii?Q?yimFvfX6lq/6LTNzaLWOdoEOyKpstJSNlq2aCkwggzen5tvtl3LIgLJ3hUaM?=
 =?us-ascii?Q?R9wrsq28xBmD9f3/jIvpLqp1uxmV1Bm7/4v0rnrffeKHHlmhSwhB6ZgdDRqp?=
 =?us-ascii?Q?aVWipU5ZNM73bpk9jJjmmLr5SC6/IHeQ5lW9RVEmBCjDO8cEuQcMZYvz66bC?=
 =?us-ascii?Q?Qll9+H/nLQlJcS3KLtf+L7n0/441ufQVEBoCusDEgiy27gmH2EnXMBhLlx3C?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3714ae14-2e9c-43df-1007-08db58f6f550
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5175.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2023 05:56:30.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHtaeSnJLOMN729pH5b7v7KwmPraW5gm5go7z4SkQ9PVNvKJ8LF0FKVbgMGKe+xKqvVE5niIiAxK3BxQbkxYxmGkfWFI01FVeG4JuvMhbr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7551
X-Proofpoint-ORIG-GUID: H_4_w-e3MXoK1G5GsJBRmQAQtKUs8ckR
X-Proofpoint-GUID: H_4_w-e3MXoK1G5GsJBRmQAQtKUs8ckR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_18,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305200046
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hci_codec_list_clear() was missing in commit d0b137062b2d
("Bluetooth: hci_sync: Rework init stages"). Without it, there
are following kernel memory leaks.

  unreferenced object 0xffff9fe454c12ca0 (size 32):
    comm "kworker/u9:0", pid 82, jiffies 4294756186 (age 75.617s)
    hex dump (first 32 bytes):
      a8 93 7b 76 e4 9f ff ff e0 2d c1 54 e4 9f ff ff  ..{v.....-.T....
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace:
      [<ffffffff9add1386>] __kmem_cache_alloc_node+0x1e6/0x3d0
      [<ffffffff9ad47ea1>] __kmalloc+0x51/0x1a0
      [<ffffffff9bd01025>] hci_codec_list_add.isra.0+0x35/0xc0
      [<ffffffff9bd011e7>] hci_read_codec_capabilities+0x127/0x1f0
      [<ffffffff9bd01465>] hci_read_supported_codecs+0x115/0x1e0
      [<ffffffff9bd02658>] hci_read_local_codecs_sync+0x28/0x40
      [<ffffffff9bd06f5f>] hci_init_sync+0x14f/0x360
      [<ffffffff9bd096b8>] hci_dev_init_sync+0xf8/0x180
      [<ffffffff9bd0b67a>] hci_dev_open_sync+0x8a/0x2e0
      [<ffffffff9bcadbc0>] hci_power_on+0x60/0x220
      [<ffffffff9aad0a37>] process_one_work+0x257/0x580
      [<ffffffff9aad0dc8>] worker_thread+0x58/0x3c0
      [<ffffffff9aadb97b>] kthread+0x10b/0x140
      [<ffffffff9aa023f9>] ret_from_fork+0x29/0x50

Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")
Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
---
 net/bluetooth/hci_sync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 647a8ce54062..e94a5648e08a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4994,6 +4994,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	memset(hdev->eir, 0, sizeof(hdev->eir));
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
 	bacpy(&hdev->random_addr, BDADDR_ANY);
+	hci_codec_list_clear(&hdev->local_codecs);
 
 	hci_dev_put(hdev);
 	return err;
-- 
2.39.2

