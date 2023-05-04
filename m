Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8925E6F722A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjEDSxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjEDSxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:53:12 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54CB3592
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlrWzAr62dkeq+XM2tLJ3j4pU5WBOjhNeYe1KFLDi6yvhF5DR1CpsZM/v0prJX5Z8DMCI6YM9HJD6idYCNPqh1ZD3RII1QWM6WzlKqOeecA2FDi9di4iVymyOnv631ngShucWmBew9T7xhUqaSRgT2Za9olp+dDWKzl/w6eMuZeigW9Pmu5KUsojAW39Q87v1o1Q0XueTttPwmBdIqkoAeLRE/vhSoMW/RYj78KnzqJs/AKcOjb2+egiI3eKE/HCkX/xi/gBQepQ2qY19RgFTu8ZtLIbS93I7UAlcQ5JE9t5r4MS5hE/CKIKtqFehPeRaN6W/fuf8bG91bMneZgr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+maXVj5Eah4Gu1tQX3jn9hHsB2QLFckWniu1GfK1s0=;
 b=jdX3ZFWbaYrVYkcm1b8lAhI2AlV58Q+UaqMqRBCo95dnErwpmGY58pwdA5gMI718VicPHECw7F9a3jFHypBpg5SDLs61+1hVtXSJ44TqIRSl7NWqeyc/eBbrpcV+hrVGYClICgkpBF5DsdD0kICFtqUqXpr7fGgBXlamJSqh4de3JtbMGEgQPdFoBt67Pv88Ng05ZDrpsQU0tWXvXO/TXw6smSpLddTG/9pzLPLLeHR/tIOIUSseHb700b02Y74ekHvYlTfqWwtZVsFGHmTHgN/MFM9oZu4QI8uDK8G/7smyP9YkBu3KMGH+6+pUmrU8pdNOLZqtr0OnqhajRQoJyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+maXVj5Eah4Gu1tQX3jn9hHsB2QLFckWniu1GfK1s0=;
 b=WjZUuvQ6YUUO6zpdIp2wU0PWLMtwgxCj1aawJgc0AYmgZGPdZidflI1HV0rM9vpU5WOdbosHqur8VBBqMelu+4fi6XZ47VNanPtPprYSnwbFfKi/gJkL4J4ox4LzSJ1/4/HRBJKGgqKIBwqtwg2qENP0oYNlpSufYGJM2YeuK1g9QXoQvu6I5NeA7vQaxboXz9CeR7Q0y3lxvs3/7FAwZsqvMVO29gc28rMg/Ebrh26+aQVEla39TvYv+uieyGJUF0KWxaJnEla3wfb3Mh2NtoaSUYwd9nFsOX6wSpAL69y6QypCHctxIrMGD3V0f8k8b+SuTRclLvC1QyJvtaJHXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4162.apcprd06.prod.outlook.com (2603:1096:820:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 18:52:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%7]) with mapi id 15.20.6363.021; Thu, 4 May 2023
 18:52:53 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: fix to call invalidate_mapping_pages in f2fs_move_file_range
Date:   Fri,  5 May 2023 02:52:38 +0800
Message-Id: <20230504185238.19488-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: 4762bb70-cc00-451d-b20b-08db4cd0c41d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJqPfdwgr7tVYecnQnr1Kd4Mltv3x+86Z+kMEgDclVOQqj/J/7LtAnoyYW8EYEQx1HQDQvB6qoKahr7UpE5iVErdQx2yKPm6JaM33k8DZ0apcOOhwAx+AKC+JyHDq9jnHu8D+p/rGb/ijy0xNztiU8EYbq4ZVcUls9g+2AGd9NZVRG+NBseoueIwA/3VpLiO+BTAO1Oh+bNXCLLPW2Fitd6jP1rJEiaLrXgIOd8625oqceZM2tgnf45uVlDwtdpJQDVgtzBnThTWYrHiSFd54UkGdeIjQLn/euGL3fhLDFpzcSgq6WBFW3SNPuGFKKVg4LAO37OrI5M0RS6xJwbDrjjJSBzsAaaTTQNCTM/7rt9krX/CE8zzg0Di/JgLixUhTzbfPaEG8wGxv5VTBFb7I+dlzVVfqxGRbazSOwrL7fWsqXJHyTtyfdS2pMvKFMiPdlEInzzpy7/mGy20WpDjIxlNOS7tBCb7laprxmD25pN3TPvPIveInX1xkLkzaY0vWBX+Ww235zQ9v4sL7ppGjlODNZzieEGKfMkE1Izavo91K1DuUtLSDUs95Ch2dwzGp+zsL/hckYOwDGaW7Cg/AQHG/bpM5DjuQoLOPrJPj2rzPOPbEobvFjJGGs6+OK2E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(41300700001)(2906002)(186003)(83380400001)(5660300002)(110136005)(38100700002)(38350700002)(8936002)(8676002)(316002)(6506007)(6512007)(26005)(6666004)(86362001)(4326008)(52116002)(1076003)(6486002)(36756003)(2616005)(478600001)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZOODIV0zazTOtaGgkEJ9G5d/uSAZMhFVRpHRQU7lJFCDAILGlsHMCgM3yXpE?=
 =?us-ascii?Q?D/pLVpoUyF488GjZHCzyGROz4PmCW6IUz+wZ1nLe6KHqKBTtv1Qb8FktfWYg?=
 =?us-ascii?Q?Y+MytbKx1T/ghApWhTGj+Znkt5yfwbR3mOlAm3WHY/26nSRG4COw3w+/i5g8?=
 =?us-ascii?Q?ZESqDUksOzJydzY+cjQmSKaHDh24mywnDQX4h9qHTM096WtKXVq3d2EO0auP?=
 =?us-ascii?Q?/gAVsKnQVKK30gZ1LOu18W4yeHLEtxzKCJBS+dfHYg4sRtnlCGN4i1zq6daI?=
 =?us-ascii?Q?9AScxvQ8r0R4qord/AzMkmx80YWR23r3Xp5RuOo99toSjFTLSSJLymDy2+pZ?=
 =?us-ascii?Q?LaDPnVMbwNLaL6dCDb9W/zOklSqWaAp6yZ4Mt7dtK30DYjG6c997ipFnuXV9?=
 =?us-ascii?Q?f6UKrqB5IVpzSoEzm8Mi1G1ekFAQZE8F/B9nDfDjpAN6m8KnmqvAliqR1rlU?=
 =?us-ascii?Q?PknM7HdsyI/5o6Zg9CN/mnVZ0dItNISiZehnShbJ6l+1cugeV2bZKWlLNeZw?=
 =?us-ascii?Q?ZEvQgWk9k73vo0Q4gYwHo/tBpZYkX8aEJyVxkICPOUD1v3nn0HlSLqm8DpPh?=
 =?us-ascii?Q?zRiYZV4cGjt7coZEi4dnpqEGbIivqIQXYO8Vao0vAc47P6E5HCwYnhyiBhP1?=
 =?us-ascii?Q?1iqfqVaEzN5meGkZZ8qyG0URDvCx7wIduFqT5JMK4a2DBBPzQy24d3Ll9bfi?=
 =?us-ascii?Q?JI1CcBmCezX2ZPi9KhhWz6Ut0Tr9+Xz5m45/k70MjzRbhuxP2ePE8mxV2gjy?=
 =?us-ascii?Q?5Arv2m9UnJ9nu1sS31YixNS/VPRBR7Ptleq0APguCM7PwGGWT4AZRWs88yPw?=
 =?us-ascii?Q?dyBNoM4XBCqYNX4wjcxcKE0yHqjEP3XKe+MPSD+BXBj+TJY48wuMmxGZhyP4?=
 =?us-ascii?Q?0ntfY6+VV73b2bvv6lnLpQXcZcDta4GUsl4jSpymBsJ7WpgS0TuO6LgMYhhL?=
 =?us-ascii?Q?ZPzBv/6RjOsl5SZkn3rPQm2YeujWrio8uKJhpsFiY7rZd0mgidtY7/MuKlyk?=
 =?us-ascii?Q?Xe5VPtAtiBR5oEt5sn1yfpUso2JEREgkt09TR0+CvpSuiLCMms+cArEWR1DG?=
 =?us-ascii?Q?ZXMugZPpwciqE5V7N1TnfeiT/KSp9fIadjz3m+0RCin5DzGoToIfhAAFf3mQ?=
 =?us-ascii?Q?7QCDTx+LcUhaGcEzaPGaIHQRFdABPEmw1JBf4PE1DuOrJ+1obG3JAvo7I998?=
 =?us-ascii?Q?VHbFb/89aY98R8IZkQn483xEwA4B6IpQk5tuzl/Vot45ZGD6LpsA3NEm85dG?=
 =?us-ascii?Q?IzQpjYihp0GYS8p4uG9Unkdk0FQquAROg8dI09V2RC3TvzHiJUC3bGMvCkGh?=
 =?us-ascii?Q?/WF70lX7ig0wAoVup6v1edRCBPK8rcajzziAUjEkHVRE1jIT7+QbOcWVp63C?=
 =?us-ascii?Q?PL4E13qsviMhomJgJtR615XOeD8pm+I1o4+tUSSVO6o5RXdEH2PphnZWxafs?=
 =?us-ascii?Q?T7DTAEMrVSGblmF5XkNNMqLFVi8MYs+/dMml6DmjSryGcMvkzc70bvC1KBXe?=
 =?us-ascii?Q?MBBKhTsG4TNkn1LVklPWWCBPah/n6InDthabI8DTO6KlvivVKWcNt7KCucJ9?=
 =?us-ascii?Q?AY8xHCBgDuuNf4YgsMv2PmyaHKc3R1KMIHICOlBH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4762bb70-cc00-451d-b20b-08db4cd0c41d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 18:52:53.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGCQ9q6uUskk1zT5W/xupUv4q5XXhh7XUArcalJy10d5ZcT0WU4kMSigy/jB3RTu3cKRWuA+kQuQlVj//pSWFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the following scenario, after executing the move_range ioctl syscall,
the block size of the source file is 0, but data can still be read.

  # stat test
  File: test
  Size: 6               Blocks: 8          IO Block: 4096   regular file
  # ./new_f2fs_io move_range test test_move_range 0 0 0
  move range ret=0
  # stat test
  File: test
  Size: 6               Blocks: 0          IO Block: 4096   regular file
  # cat test
  nihao

Let's fix to call invalidate_mapping_pages() after __exchange_data_block()
success.

Fixes: 4dd6f977fc77 ("f2fs: support an ioctl to move a range of data blocks")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 78aa8cff4b41..ae7752c5cd0a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2870,6 +2870,9 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			f2fs_i_size_write(dst, dst_max_i_size);
 		else if (dst_osize != dst->i_size)
 			f2fs_i_size_write(dst, dst_osize);
+
+		invalidate_mapping_pages(src->i_mapping,
+				pos_out, pos_in + len);
 	}
 	f2fs_unlock_op(sbi);
 
-- 
2.39.0

