Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6D8614863
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiKALRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKALRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:17:23 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2071.outbound.protection.outlook.com [40.107.117.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EA0186C9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 04:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT78SybIvYQfPEi3lPYYQhORbf5tb+aFY04q50eLbpYxelpc4VVNUJEGhuv+tBSLGhnRiPpTf8qBX/ybqKRocbClmEsRdoZfx1hoqrq8NHRQ1NMhqYP7wdFW3mBC96riUUT0lNzIDxfrm6DwLexq/D9S0lLKUSdX/LuE9M8UazAKVKcz2CQfLY5cNpu6CmqnuiTZqh/mpjolxLJhegHISdTA/AljO8+DfZyTBIWk11/+N7QPan5V99VXUZJYeZHicVljrBvkQjBRaEfbizOYeyAdtDP0S52Q8xodIgh/erucFyqYrS6EQ02Cp+/acNaJa9ZdJvLig42f1ynfWj+Qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNJNR96SQGfGVhcGD/HTPXjUklpqRmiFrPhMi/J+az0=;
 b=n66yiHrKzJ73q/UaRqbYLgJiEnCxmuBXvEI8a4m4w4aopPe3JIWLHWac24ho8UrmD0q6mn/KPr7OWX6ZQs1y0cLPFSWybU5EqkDcP7MSQsgOYHYl9nfwz7oh53YdvRMGkKYpUIhdnDFkJcJRskNlV9oVsPJbvlmVqYSb5F4e3UaxUU9EfuihcSSuywVUPlBRMNxWL9wWXGUo2nAWHCecIz5we/pCgUBBLrLUTvxmFVgcoP5+DkYzRdvZiZ4IY3szWgfViEltGaHI2bY1FLguSX0aAGanVD/HYc4MAF5LPHtQUJVyEObDQMdRyYyKDaUoukdVawzAOFRQIpJML+KvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNJNR96SQGfGVhcGD/HTPXjUklpqRmiFrPhMi/J+az0=;
 b=TcZd14vSHVcylPoRDEACQu8CWraXslY+6RO33gEGVkINviirm4G/IBMCHHben6Er4sAOWAqhGvjBhHHw4gnrgjKvW1A3QFxLjW6EThE9UCjixXaXtbnbglj19e0sRlIFF8qI2BMaq2nGkY6LVq3QRWVKenosQIsdyUjmlGVa/MUayt5rOUjycpg2eCv4B6O6hSKbtYXZQfAXL0i4eIgFmMergrqQBtFwkxGWP+5btVH8mKn/I6BYSSrmQq80PbBNLUotmDKfjCuPFSn3+B1Rzeol32KTaC5aK6ikrqwVcqTh0Ipi4lVk46NPQh9UB+BKr/Sjn8fwgZfVm6Rw7Pb6jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by KL1PR0601MB4513.apcprd06.prod.outlook.com (2603:1096:820:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 11:17:18 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::5d1a:4f09:b125:9670]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::5d1a:4f09:b125:9670%7]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 11:17:18 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lingshan.zhu@intel.com,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] virtio_pci: modify ENOENT to EINVAL
Date:   Tue,  1 Nov 2022 19:16:54 +0800
Message-Id: <20221101111655.1947-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|KL1PR0601MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9ba790-e73f-40a4-1ebe-08dabbfaa367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMx+4HlsOCTmeGhD1L07mbD0LbCYR2mZFF5MlCaqv50H+oVbN36l6V65jBGtjbmytB4Dr2p3Q7QZs6lu6aqV3xH+5jk+EoqIP+GWOxTPLwxu3I93aMbbmxooHe85dg8Xi6xTwtkiktMI3mRZ70JV3gu+USxtpc8v9+5VtLLkSfqpZwhfo4h5rvZHE1TyPcYPDKX/TgDIypct2gI/hMipjSGXx7ifpkVIHD+cQKRbSRR51AuZsP6iQbic/FQsOlMf8akfEDmum6BfYWNvsK/xh/SXnz4HQsfXc+nihRMftLi/nD4HlqLPNuQpTguxS+hdORtoSDMWeCWUtWxhV9bakYwIfQejWC2MIoGDlBQ8BVL8TuyUwxouvgp6igUDQEM+an5G1jKEK4xWdQKP1l6xiddA5+1bs2c4sG7nY09uzvkRPPg0TS5/+sDV2KUrzwvSK6nAc03WOcYmj1STFOxsvppgUbRAj8ICcoQMt+OCZ7XNyE3JRTHF1MS/x4BQfD36pGzkcYQIZJ4aEvb3CA1diR6tmpD5mSzc0lbe5J1uOUDpuzeh2SESW1zRa7SRda2gfVJ+ETpKkpYFdnXOMM/tuPitD0IhQ8y9EePYbnauxRkeGLfP/ygOZznGzrGfhDMACUwiFJsy5Rg8GdOXWPq5JdCllI2REgIR+0+1oK9nDxXFlsmSsmXOlHLe2L5JPID9CrsY9zpHWcgvmoiu6/unvKetgDenCrP8AxUNnCjOCnuZ8LC6TdiryRT9NWhIXiC6fZjBfphspaj19Re+8rwwiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39840400004)(366004)(396003)(376002)(136003)(451199015)(478600001)(38350700002)(2906002)(38100700002)(83380400001)(4744005)(4326008)(66556008)(66946007)(66476007)(8676002)(44832011)(2616005)(186003)(1076003)(52116002)(86362001)(41300700001)(6506007)(5660300002)(6486002)(26005)(316002)(107886003)(6666004)(36756003)(6512007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nQRcli3B0adNfG5k2KmMSLzv9O5n0ONCu4ZTDv13TIRKU6sOEN0S+qSxMZn1?=
 =?us-ascii?Q?151xKZh4xUKjPkx9s64ct3DUuL8B5onOO7B7Dc1Axd6mJopAKznbcjAsbT6r?=
 =?us-ascii?Q?LVgENY1OQgGKhysfGv38xIxRjIseTy5ocK0DbCj8avexCoBIH8f922O6DRq0?=
 =?us-ascii?Q?Pw1d2IZf8zblp9LeQzeqaagUM5JODgPN8kNozWrGV60O3iQsOKRS/0WtaTc4?=
 =?us-ascii?Q?YyF/INqwWXp29FHQgMdsjyG1du/AJFY0zOBvHUxKe0nj0UfCPFQAB9hMvgbe?=
 =?us-ascii?Q?VyAIh/WlOQAW7lPX+ZoxuL77UoBk7sERv758dA25XLoS1u9nW9LEbmGY9rFI?=
 =?us-ascii?Q?lUEE5sOxBLs0Jg7LDIiBJJgyEE4ARxf5EDE8CzNY//4tET4+pHiHLc3OHflw?=
 =?us-ascii?Q?TEyslSo8Fv6YMBFoFAPSlDQx9vBKIlWPT4AGJ3CRdGAK+2mLeikBYtgF8mKt?=
 =?us-ascii?Q?Txl38Qg0cdNI1jtHTEvS4G3mkq45UyP+NJd+UIh0dg4WJJgmyxWILkvjOY1+?=
 =?us-ascii?Q?tBGKFV+c0CAm9797VORV0Sr3f9MlxhB9lGEjX/+xXJmMLwFy+lPxQR2Ga+Io?=
 =?us-ascii?Q?Hx8YU8u2PA6anE9KkuPimJrKnmJPPnaPOhtNub00MhObwYuHLU12wI8ScbMw?=
 =?us-ascii?Q?ShJKtZc6CRk4wjsDTRIXPKx3V0FS8d5c4PzhFF2Efz4x9+963xFwNk6uX2qh?=
 =?us-ascii?Q?KCfHBtbkb88KDHj31L2BO+aX3j2O9gocXk2g/dASb2QF2bicpEkKg3f/TQBx?=
 =?us-ascii?Q?H8VHA48Gg9l3/PIwAvLAHCYw15ENmb0bGQmxBiTyA18WB4/HXh7HOcA8yOt9?=
 =?us-ascii?Q?j59C/cKeUQYpyiGImEvQzr6PzC3FGGp5oNH5OwNvlBp3GKqG00VAd0hWmVJw?=
 =?us-ascii?Q?0ETJxBUCT6Lcw3YpnArDlXyxKo826Ml3gKfiB2Rhpo7rHBP42wTJCwWz6xn9?=
 =?us-ascii?Q?Duj2oxyjI6ZtdPkZcuGXlgNHwnKdvNjbCDJNmb3CJoz0GhJxTTrD50HgpLcv?=
 =?us-ascii?Q?/VN6NjJU82lmAbdlaKNagKxVh201rNUjnz2K01L3o2ZinFmbuv2B3LWA4kED?=
 =?us-ascii?Q?NH7nZz9JaU7rE9IDZ8m1xTPUkncDYccGC9L/uc/phaR4Wfyh/mlngmeHPRkG?=
 =?us-ascii?Q?6fbWjYsF2nkozwb5aFQuuN6s49RCb+ehnNEQkJhJKBbUepLD1S4OAZaRiZAk?=
 =?us-ascii?Q?h007HucO902h8U6kVOAxe+M7U+Oc/f+Je3rbvfrOmzt1XxGHoWwwnMv4KqEO?=
 =?us-ascii?Q?CvZGLEIcfETLHxrp0eJsMZp+iHDDa4x0VOwMlExREats+WvqFXdliHOYugI2?=
 =?us-ascii?Q?V0C/U7vao83cSJcQiaTBPCgRn+I5BwWU+fNdyC1egm44fQY2qWRF9/LNisDV?=
 =?us-ascii?Q?STxaoONZgSby3AMqGg1/zZjaQk8tMK+h6z2tsWCcvCaj+TnEYSNOebiL9Fuh?=
 =?us-ascii?Q?92blFfuSdA7C8uCKvb118N0YHUFkZFWTwssTUmUsyNrTIdwMXvkaJDg/4/FN?=
 =?us-ascii?Q?Pmh1Xv4Dc7S+iYFdvHEsUFwJh2b6uRgOm2iBXWirZJ3PdN9bp/O+cH/joxWG?=
 =?us-ascii?Q?bOOhytqRFtnWWdsPxCArLLvZb+XvxLHBo+BaBxIOKIjJtHf4+6BmZX58a2vU?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9ba790-e73f-40a4-1ebe-08dabbfaa367
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 11:17:18.6508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Jnz8pk5JS/94KsxdplrULjHyi7zCcSjvb5KjseEzrJ2PKdh1K3quoPmlTEyH/un34ZmA3Yyv9RFIek6hJao79oyjhFjel7kpDmhlmGhECo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtio_crypto use max_data_queues+1 to setup vqs,
we use vp_modern_get_num_queues to protect the vq range in setup_vq.
We could enter index >= vp_modern_get_num_queues(mdev) in setup_vq
if common->num_queues is not set well,and it return -ENOENT.
It is better to use -EINVAL instead.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 drivers/virtio/virtio_pci_modern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index c3b9f2761849..edf2e18014cd 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -303,7 +303,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	int err;
 
 	if (index >= vp_modern_get_num_queues(mdev))
-		return ERR_PTR(-ENOENT);
+		return ERR_PTR(-EINVAL);
 
 	/* Check if queue is either not available or already active. */
 	num = vp_modern_get_queue_size(mdev, index);
-- 
2.25.1

