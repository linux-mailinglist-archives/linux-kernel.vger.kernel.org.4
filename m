Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C2C70F583
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjEXLmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjEXLmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:42:19 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95A58F
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyIgxJo40a2wRzUNybSdByExNwz7MOOV0QmGydBS0dlnIPzIXz6eP3rTcNEoLzHi0g2ADgG7qSyo7KbbX7O5o9UEDX3/+9pdZLV2k7Ve0Bve5TrJEC58LKWj1NJWFa0qRlnGBk3BKKA5eITuPiCTYky2flCYYrDdPAycGqQVNK7+GqyT8XFxkdelL92s+p3H27FYEip30o9PH6TcDTWtvjJvfFMvF/DnbQ/9dS58UfiEv95xnr3ogGLDv5utX01U3dZwJBx8d9y2PnyGdAttTMx/ZlGvhnxdluRmQxT9U+352oSBZO4GSeiULCx6j6a9l8SOUhYvvNMIL4sKWnognw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDPB60qnAsGtdLjHbrjnEpWwkuDDha+scDL5xys3n6o=;
 b=D9kRzFeR2UVUDpfKFOQzepKYkYXThHkXs7XYm/n1SKU3I0i9rTFLSIk5uSwhDCtAt5wL7XR+GiZTyS8TKn78cKPf21xIRd3T4ToWyWUTjov/5cPv+wTJ32IxfqTT97Kcf9GGqTgQponOy2YrVqCPgQprmXjrmz79C8WKwuvPumBrkAl04XM6dz9/km4pIZRvSBef70Nxj2ZFyUEgjTuCIWw+RkVUfSCqG2AJo5RFetBrb3A9E+AJreFd/YfJlXjaFAMwXIlZIh2Ow9GNqWpLEwnv7hzFy2pAhU1jvXl4P7isowhbDgHXPHn1NVDbp0crd0fDhwacldxVJzhcvM0qQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDPB60qnAsGtdLjHbrjnEpWwkuDDha+scDL5xys3n6o=;
 b=PzMZrr8x0JFDJSLhpwbxSWA33Nz6ArhOdKMvDPWj4WxOSuGu6CeJyaJ1fnXjLMCcKKVCXC3+bMrGB4OttQzb9TI7BaSGbypOk22Jpiz4EhK1UAJmNGQJ0Ap0Ww7jX0G7tG896ZSf8jgwj51QqFoJE09FYJCnZiEHoToGp67VcyQsqkI390bgEq3m0fciu6pN/hE2SJYptkyOZ7N4VBO7R08sMG2Vg5jxdfHMg7HnY5qzyqk8qDy1SOR6fbkD1IWQTPl0fsEX2BEX001u7S5K/4S9gD+DqMDEkxkcE7Rc9IcVDGkKA+uodlk7ON9s/RbpscmPXNx94awMIigS+ALyEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3227.apcprd06.prod.outlook.com (2603:1096:100:3f::10)
 by TYUPR06MB6079.apcprd06.prod.outlook.com (2603:1096:400:347::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 11:42:15 +0000
Received: from SL2PR06MB3227.apcprd06.prod.outlook.com
 ([fe80::9990:c35e:45dc:a76f]) by SL2PR06MB3227.apcprd06.prod.outlook.com
 ([fe80::9990:c35e:45dc:a76f%6]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 11:42:14 +0000
From:   Qi Han <hanqi@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Qi Han <hanqi@vivo.com>
Subject: [PATCH] f2fs: allows setting compress option to files which marked with FI_MMAP_FILE
Date:   Wed, 24 May 2023 19:41:59 +0800
Message-Id: <20230524114159.8999-1-hanqi@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To SL2PR06MB3227.apcprd06.prod.outlook.com
 (2603:1096:100:3f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR06MB3227:EE_|TYUPR06MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 51de8b13-a18f-48bc-ca18-08db5c4beb0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PHomqFu1UwzGe+/jbIWih3/WAX+nkyqSr5pvDJCY61vBRHR9mBNuuKRmpztspKgx8Y/fUhUIbjYacTeZxgvZ7bUYeqUtsGcc6GlFOvRrgPkkyBsoCZomMDoVZg5rh0tyf+U4kP1Ox2BGao/uEbhT4P1NR4gMhpTcfkwTMWp7gMBA7TarjMryFXb0KX1lrkO3t7aTNdZ4Wh54HywSUz/b+qvBLkGZaF8jfEPThfvgPFwQXTpq7OrK6WEZmzFibsSo4nRAKciHpWQWvqQ7UGRmwMNRTysakifOXM9RTiHS4RxPMa5IrdnMrdHXH0tpuiVsJqnSo1jUY6hn21su8Mosm/U456Y0bo7wuNxmbcpkf4DYfup5iXoMB0y13vqvRirSD6/iJl1hvdcZNqyqKuYT6R06nZZ3oNsmCGQ0RZA2PCGaRIhXEil46XORw/RLtSN4Ik008sO9FSGcE/IDjWfjoO4R7J96yth4qEqG5d0+AsGA8/MGdAN8Hd86uJNBdc+zYDvk0Pq5P8sx0UCD9yM//jww18sFTUY3V/Xwdatp3C50lOe7f2w6VBfGXyIqPkTBfHYsZx0WVVa/RTI66g4UrdkrW8vuTCeNcbG8lhmHoQOnFhgou9SyxC/vzmPtQ/N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3227.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(38100700002)(6486002)(41300700001)(52116002)(478600001)(316002)(4326008)(86362001)(6666004)(66946007)(66556008)(66476007)(5660300002)(8936002)(8676002)(38350700002)(2906002)(107886003)(1076003)(26005)(6512007)(6506007)(186003)(83380400001)(2616005)(36756003)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lxyU28GXWTB+aLgU+8feDpUFTcmLXzFxsof6VuVGCnzjR7Z9XaJMcQEZ9m9G?=
 =?us-ascii?Q?vr7rlg95CvmWP46MkuNhBW+d0aOpePJHaPSi0GZb0bkFa9O7kwv2aTA8pHTH?=
 =?us-ascii?Q?DJ7NkQeu0RgBdVXciermo5nOCTkKlMR1sRq6+/8Q8VGXknmHwLSv7uQ/e8C4?=
 =?us-ascii?Q?7ySi2CXb5SXsABdwNdlXYyV5f9Tg+fel8oDEQIFsGO80WkxsmJthh2s6RE3a?=
 =?us-ascii?Q?tJvMVCakLfZs8VXJmEiN+QAR7xcoh4BaZY/4oU6BshIeYuhEGqJ+ICOrWmEG?=
 =?us-ascii?Q?xksum/qo2lM83t23jNVM5dJcdO+QPvI+ufJPOWQKYkz6yKFCZaEL6mDgnAPl?=
 =?us-ascii?Q?W8vBqryF0qD7utxtLsuGwWPCxrTfpH+qEbiLfhqjNG4+km7eNmoLc/7awSNd?=
 =?us-ascii?Q?W11jXmY60ShhYIDqc6xg4dO4Ho+gTDLTBGogM3zlfT3qjWoYfbL4sAkJH6bZ?=
 =?us-ascii?Q?XBB7RZ8a7RdO4YDHvRWJUMOmXpOHz4jofaDfXeEW8WYHLCCYKMLOpbBWuWxm?=
 =?us-ascii?Q?8a/QyB0/26rpGWJ6nZubSYUDtBcjz6JMFxH/Vgzy1xmuVnW1aYxfc2coTxDl?=
 =?us-ascii?Q?fb/UnXkv0ST+VspfqV9PGTlLxbdSGwQaNgVR/sX2ll5FImUsTcLh0WPzrChw?=
 =?us-ascii?Q?5kP+PumOf0hGgWkDuGDn7XTj6YBBdAVzjRgXcu5SgmIGjxm/VREpUIWEbKwZ?=
 =?us-ascii?Q?OXmMibTM9RYf60fB3vGiCMghnbI26wf5LzVuA5T3VvWaN060WfyXBAL1F3+x?=
 =?us-ascii?Q?wwvreRX9hGqmq85wkvNwJMeHgu2GH8Z0+ye8uQP8kJaN1jufUpfxQbjyW4Ar?=
 =?us-ascii?Q?1xtM5PkxHJmJedFm8av5Xtr84nXU1Z25nWGb/wWnxYE/zN27/DffTXhOKLVB?=
 =?us-ascii?Q?dm9tF5UrheyUhr62+cjk28NY7rZ1ldoFx3RzCoUs3chky0EvVmV6+mPungHf?=
 =?us-ascii?Q?NWUFWU1Tt2I+vnJB1vd4yba5mx354bAxWW7DXXmxC3kst8xyccb2XIKWCR2Z?=
 =?us-ascii?Q?GF6brutMGmE/NVIG/du+c0buHVSDp8n3ybVZDSdhmXbkOuLXg0jomAoSO5jB?=
 =?us-ascii?Q?lMlro8pTlzCNFiZZmg9Im0WFw+zyxDcGXHEoks8wj/0FeqSNmek3chhkHZGm?=
 =?us-ascii?Q?HRbbwAXARE936QHJIyz69UWiK4YaBsWapjSmOJGnhXZt1JJh6lM3thtprjq3?=
 =?us-ascii?Q?Mm39KJyBWg0/kHOA5WglUYfeq73ZpubbyBPigmMITJ5cy3bGn+/VA/HEX8gq?=
 =?us-ascii?Q?IJCSM0jTGww9wz4AWz7E9I8XVWPTYycWwzWmqnbJXoUJu44k3aKY5n+XFFyc?=
 =?us-ascii?Q?MW9aR9Ai/WE+I/rcKYZRgMZqPYqSM+vKn4YvsVs32YckKy/PjD6wb8y7EUbM?=
 =?us-ascii?Q?D7DLF9HD9irCaj3zk9HcbrsRoUR9P1LySD/R7DKiM9VEsKO8KEAEYkhJX9dZ?=
 =?us-ascii?Q?BU2p2rUCUZI5i2xMdn6uxLO1RmB8QiHH/e5SZTaZQvdBwdPEa6GmEMGuubNZ?=
 =?us-ascii?Q?zjlSk4tGfE/4rMltk0pEDutDCrFKjUsWoJ0uoa1JP18AhlUGBqtyGcDWYpd1?=
 =?us-ascii?Q?jtR2IaMzn+zxLuzifpLiiAH89Ye36EayN4ZosQc5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51de8b13-a18f-48bc-ca18-08db5c4beb0d
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3227.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 11:42:14.3129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Il22ncSA2qiEekmF08qPuuKkMZtgDUoAKbzzPQVx3T4fJsTmqtFwK3C6LN+Ia72mvb6bgKTJz53XJ/g+xuKJ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to compress mmap files in commit e3c548323d32 ("f2fs: let's
allow compression for mmap files"). However, we cannot set the
compress option to the mmap file. To keep the same concept in both
compress_modes, f2fs_ioc_set_compress_option should also allow it.

Let's remove checking mmap files in f2fs_ioc_set_compress_option so
that we can set compress option to the mmap files.

Signed-off-by: Qi Han <hanqi@vivo.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5ac53d2627d2..3a97b753a074 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3957,7 +3957,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 	file_start_write(filp);
 	inode_lock(inode);
 
-	if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
+	if (get_dirty_pages(inode)) {
 		ret = -EBUSY;
 		goto out;
 	}
-- 
2.39.0

