Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F945612779
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 06:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJ3FUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 01:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3FUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 01:20:32 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2092.outbound.protection.outlook.com [40.92.99.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09D62CC85;
        Sat, 29 Oct 2022 22:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCAYQHcWrzcsEnwlaqr6vbrFJy/PM6etFiNzQcHVwYeWmTAkC7F7sRw7FWMD1OAKfOcdmJMoPpHlic2blcYV2rc+jN6/fR4B/QEJh27ieveMDQHYUZ1M0f/gB/sEwq4E0n1K5ZZuq7Lv9mi7+1K7OJAnGJ+LFfdP2cMG73TdB8FbDYWQ75pKvek/dk7FKs0i49mhb9fbSS3iAmLP8cPweuE0j9e52uOs69Pp/GUgNEC2twsufG3+XvXTIM/wxDtMrbZM72/Y6fWN0vZg5jvhSoKCRbTDxloSqMwrkSbcdWQ3KLbesviTCBPU4ttfujmqrIsdg5Wr7gcgwRGi7RwMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTJ2HuWWX3ZrnZYVyUH8xwOTjP3lfQyYAiSBDMD8ry8=;
 b=FEJCYETZeJQeC7QZlumHjL5DfKi6+KymykEHo17g4FadEUg3+C2rkrue+HgZHOO4gQeNCdj1Ko2jvpLFEryE3hPqZ7Ybe72ZucuLY3VBOG30z/0R+VEkZDpA3Af2A+hrN3O1drDpguY7VAmXnTIKs21Qop7DsRPSWB3hVLlDBf+0b7LNpYOM1m4cp2l/jxmVTPtgZgeZcAs31PnPrSushOODisOPcrikOIovh2DVYRIxACQYJvRTsgVdWyhrXD+pqJPd7bYCHqIMmCuqjo5ejejYPZLEl3U1Lqbwl6iyYMlBw5+9TKQ38PdERX8+EkJV2yT26qO/LdkBt5T0UUcQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTJ2HuWWX3ZrnZYVyUH8xwOTjP3lfQyYAiSBDMD8ry8=;
 b=RyEPpxuknaXgj1PcAcpaX7WvRNJzDBvL14vppsDcCJtJAKzZGmT9m0FjRCn+SWNvRopEbAaVv0jjmTyd9MZTfdO0638a+rhV8BAZMqVOXl2SohsEeCjz543nyZ0IedaTAsEbeftyG78hfftUtzthU16g30SojdKrU2r6QimjofjPPF+8o9cxIHMldrykYop8aQqVFs1XhoXcERNaxAWPVZzI5i/38cP9RE0+LNkqqWEyCW7mmRpxNbICOpXYjOn44Hv1do0TTd/Ih+zZmYVwtpAZJtQB6gUQadXjYiZN7MoAeLG3vNLwSlHccbHvP3cNspkEhg0qt8lhLQz/Qpdcsw==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OSZP286MB1968.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Sun, 30 Oct
 2022 05:20:26 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c90e:cbf3:c23d:43a5]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c90e:cbf3:c23d:43a5%7]) with mapi id 15.20.5769.018; Sun, 30 Oct 2022
 05:20:26 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     axboe@kernel.dk
Cc:     bvanassche@acm.org, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH v3] block: simplify blksize_bits() implementation
Date:   Sun, 30 Oct 2022 13:20:08 +0800
Message-ID: <TYCP286MB23238842958D7C083D6B67CECA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [gDpJn+dl8hZsB8/LKwM/zZG0/N7WoT6k6ASnKAZQwBA=]
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20221030052008.22283-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OSZP286MB1968:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e853545-0a37-4ad3-8d3a-08daba3673c4
X-MS-Exchange-SLBlob-MailProps: ZLYX9kf+sFbSGQPCthfGnzMHvcLRKUdKeNqTJvdXx5zmkqUzjKz3rCo1at5+Zm1Mgj9Sx22hZoF1uwnZHrcLUEpccZHbcqAgEdPXzqxts63qYMSKgs9z9nxD+YFbm7R1ccnouNuCvhmxr4YpXayGRxeRAVM2I1wwEtZZ/izsMPaG4L6GMaY2AB/GQdo52vCc1PQLNkA2IPQfP6AqSk+pJDEDZfLAJ3vceJY+H09psnM2OjWO8+Ph8lsMemL9w9FH0aXmzR7DhsctJ1GTT9gm9cZE1TbwQ2ty+YnnAOD0KRhj1gc3jrvSxSeMcIkV6Nu+XD4G7zEw+uplInh7YsxCP/+bwb0WB1IHhSyH1Efj2Xg63Q813YFQNwcOzI/SCsyYE7B0p6w3bCRAAOYI0Sn2klPgH/0uBtEcEYSs7qHtpg6xks5X3dq/tdwO35ynHinUSaroQ7BTucRrJEiQ+Z7trHBgqoL9x7JtqQsN+7efflL1nAQUrg3NERGv3gZq1JvZh7o89gRXwUA/tY9WjpoIDS8IxWrxil2PDK31rKvhsgd1fscuyWpqELqT96VYcygI2Oj0qla5vKMBZwNmcD9cQ3NUYMj0hUaPhihBinx9oVGVP42DcG4LxT4CWQdRgdJL9Ox7OEy3HotmLvRQb5GarvGyJIkZif7ptj4KD4wZQ22cH5wc3+e9qppzYU2QOK6iX60dkgZN7dhKinNL79WLXmuF4p5MCoAlLOnQQvbeHbKx4QisGQqOU1mDVVBSa9YsdLMGEljELlsIWKevTTAvBJ8D2zfGFd2BU7pdprs9Dc0x4BKQ3jgH2Q==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQ4Tz6yPIMI/ZPbs/4mYkphu+2I3rbpTxm2vYYxfqz1/HD4S3mFxwk4iiIs8NktwD9hGtZK3QZ6bDKb3vnM33eoj3nOPVPXOjOASy2OUL0ANKg+Qnei+bASz25D/H53jzbNZEdir3AIn7BMkKH8IfWv2GppdxZsuzsZ0KMaKLgsj4DgshjF6V+UBjdEeSMAft4WuTivxBK0pFWaPwYJCdyjf9kdZ5FD8CFyqdDg2XxNSHDD7fQEu90Sb0MHHICEMggDF/EjLFUGi/B/aQpuoDGGxj4a7J7/Nj3w7xMrwfzfLm/PlYHSIhg51/tV3ZdT+G0l14YFPhJ8gz8EiPPkXFHAhkSugf06IQcmOML8ObXURUnpNCiERNIrDdpTrB5rfsADg43Yb0WEOONvkjwNtU7qT8hQhxPZ/Pk+FLjXFtqas94gUe1FJFrPX4dKxJ7fwnaoAkFm6XeOMpA3Hjn1TMsWfQZIxv6vaJg80if+eD8Jx46Tsyyna5Rdw+bIIjZZb/06renY/snzmVCSCp2iVdq4oKQFjDBs/nUIKPhiOhYEGHsm7bLgD5Zndv3XvE460ZtN9+1bvdMN/QPRhCsMC0IsbrtSmBa6Sp3WcTp1crbypuxQ8TgC2c+FAOThI8BMPkzAsmIegajpUZkaH3T0gQHqXwld8kceW1P7JR/1/YQswI4sD+e2wpAjWvWQd3t6o
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y4Ki2FNuNfl7xDgbJzFGq6VvAmU9cPK7JFE/dNt+PBrwRJoy4oQ2YdBP+Wmn?=
 =?us-ascii?Q?ajCSZkaXty1U/tSgPq0l5gbYlm9lZV+bPDSak4kPD+4mhG3q/bGG7eZrasZw?=
 =?us-ascii?Q?XipU6j9e5eCwGG618mED9kr8jLzOCdTy69QtQjzVK/SeT+YKA+30qlNG6ITM?=
 =?us-ascii?Q?5JHPfQ/2WnQE82OyuNr3ofoktIbb6ZiZBx8Xw8ZZvbCLGar5XSLquUgJhakQ?=
 =?us-ascii?Q?XeyfN8nhggr4ycSwVLSdVxbDLviCEKpWJ3SHLzu6fGo8XBdNZXAEB/+hfbSr?=
 =?us-ascii?Q?gXfrwx3FHs2x8q8e4bx+ygxIbMScDurWhjBXxjsxSGJeCmPdmXuQPT/L4U8Q?=
 =?us-ascii?Q?y2YwE+oIFiYiQbpZJgmITzX5SXXndEWXAx7nFbRIEWRQsD5C8Oy34Fp/B4UG?=
 =?us-ascii?Q?I1Ft+uiaOsQv03eQZiClaFE6JC61JeXKfW8M7Rc1YcgDtfQoIJZa+zNrt0Q3?=
 =?us-ascii?Q?ld7lP1S1EliXV0rEr3uBkAlUG/i0YPYh4EgQD2n874OmVnlokTVDQkGEm5I0?=
 =?us-ascii?Q?3BCWxh0CKdUL1sCSPw06uslYH6WppOK7WIC4Yuui3XUQdznGbtBau2/KmJn6?=
 =?us-ascii?Q?qjjm0RL0gJCVmt4NPfJCj2qOd8b8vPpsQRWv28Blw7jfRvnZEhRus2twPm69?=
 =?us-ascii?Q?mESKC6dHJ/SK20QdkIvHhODaYXcYq8Zq3UhRh4UXnwGjVQvwz/2t1tMmT5jn?=
 =?us-ascii?Q?ScHVkYRmby/8DlyYwZl2+okQ2H1SaFxwI/nmZM9dwfOLBHm/cT8X8R+GbmWw?=
 =?us-ascii?Q?gCMi+k8ftsvezVLPIisMvj3Ch3vaO3BcHPxw5gj1ww6RdwwVf28KVoQuL7CA?=
 =?us-ascii?Q?9qRTPVuZeN2PtVEQDbZhNH6TCaNRCQmTkUzR8XFSdcqfCge4amoO/X2VcNhr?=
 =?us-ascii?Q?vxaDC4BkAFSAlDNE0BCUt9cy9Iz9UR1Pj1JkvgHCAZ4aT0Fvr6xIBP2MnOSy?=
 =?us-ascii?Q?zpuwmTa4bswPW4AtxlzJ6QAImGLdRQnwDI2nMMsozmJuoFguCK62SGDhWYT9?=
 =?us-ascii?Q?zwh69qcVF8XtsM9SswnQuMvdnYS4MpEe+hFfxJ1ea/KPBL0Fzrh9tUPwT6TY?=
 =?us-ascii?Q?j/IgnwMqtRDSJX4q1jH15hFGpDHx7FehremTZ/JC7+UPwJgDGrzX5zo1TAy9?=
 =?us-ascii?Q?RQL8oUDDLTutlUel9d52sdvRe53fe2aJu+NfNjD9bILaTPAv56XkpCzBflJ2?=
 =?us-ascii?Q?vARLEt3/9F04PQzrsskq9/lQ+0eiMltvn2cCuQmpYAwu0EFG8dXT81rsdvpg?=
 =?us-ascii?Q?KIupxPBVkQfeJw+pGz1iNbqw5e6FNgR1eqjQd2s6ZxkEDHcgC7v4dvff3lIJ?=
 =?us-ascii?Q?vH4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e853545-0a37-4ad3-8d3a-08daba3673c4
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2022 05:20:26.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1968
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert current looping-based implementation into bit operation,
which can bring improvement for:

1) bitops is more efficient for its arch-level optimization.

2) Given that blksize_bits() is inline, _if_ @size is compile-time
constant, it's possible that order_base_2() _may_ make output
compile-time evaluated, depending on code context and compiler behavior.

v1: https://lore.kernel.org/all/TYCP286MB2323169D81A806A7C1F7FDF1CA309@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM

v2: Remove the ternary operator, based on Bart's suggestion
    But this may lead to break for corner cases below:
    BUILD_BUG_ON(blksize_bits(1025) != 11);
    So make a minor modification by adding (SECTOR_SIZE - 1) before
    shifting.

v3: Remove the rounding stuff.

base-commit: 30209debe98b6f66b13591e59e5272cb65b3945e

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 include/linux/blkdev.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 57ed49f20d2e..32137d85c9ad 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1349,12 +1349,7 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
 /* assumes size > 256 */
 static inline unsigned int blksize_bits(unsigned int size)
 {
-	unsigned int bits = 8;
-	do {
-		bits++;
-		size >>= 1;
-	} while (size > 256);
-	return bits;
+	return order_base_2(size >> SECTOR_SHIFT) + SECTOR_SHIFT;
 }
 
 static inline unsigned int block_size(struct block_device *bdev)
-- 
2.25.1

