Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3FB637120
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKXDhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiKXDh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:37:26 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCDFD32B1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:37:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8fjib7JF6/PZH6xG3IIASg6S+hiNXq/b5rvEmqDAOraNNzqrGrN9Wi9LYFWC7pATT+4+p/5k3+c6D1Hgk1kWi2zscTDvp0u2H94HCsdCSSDDdzSVsPsmhEkMtPgT3XPIn7dhNu7YgLSqa+tC7R/sOrUDTFnp36sEVsJpP7yxN2EZGXm8idk1xFH3GfmYOSQcQ3IfOH2ZAKDMd5+v9NsM1IV1eCOCK0J2cY4srHnBldJ0UYzG8uzdk/NYBeI9wCrvr75wivmfkkd7ZGpbnzcVD1iqfD5yYv7TfiUA1ceNbQI/R1J2W0v+EC6RuQ5OE0YFOXBxGOoto6IimUUw2DxDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuQdlCLS4U5lKkdddD+BypX2RuHXnpjHr1bfgBWLB5Y=;
 b=HaAsLXuYE1npLamCLOLC7ATteYmynHL+1rW+uPARWA4cdQuvOZ5VHZYVvY0/WY7GPpfIKnJxzTPTw55DkejRQoLV23PiqNC1Ijg2oLhin77+06rdlcHvnR6r9pGgFY4Pm6Z7YLhczXv63TpZT9FZr0/WSow6Vq2A8n+/dl+b38gudBgJEEf7GM6XKvqcM0uFiIMkb2lryyin0fnGOB8KUOMt+VTW2jVlmrhs44GwA8F2YF3MQTBCK/hk2cY7jUp7ZaCeaRFv/1c6J/aznWw4WDQpmB+Qtaeba+5QAWbOGkjf2+X4+NptbYLyGBc997JJfFDHpnhl7eaTjGbY8kD06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuQdlCLS4U5lKkdddD+BypX2RuHXnpjHr1bfgBWLB5Y=;
 b=LUrzeG7E/o+71FjQ88JWA4khf4uE3TsY1sJ2tFjF1HoUv8qabRn+3Aikmas8zfDVeioSl5hpHTqAl6b/a1dY1iqMjTJ1hYSpxed3x+kN2W2k4VvjIaHT5x5Usy49GnDYv5/ZRdhN/WPIcKUdLxCePtNfr+brKRjwu2xLRoghe4Ez5X0+3jjtEuDS1sMiw3tk6LX0AV/ibdBazTqBOHy1AvuHobuShDxTuBI86war80pxcJLMD6/dkE/fLC5XEODT8X2mQQy8iPXcPsIeDgJ+XAwym0qx1TEShpwNuqndvWM09/ZOo0kvFoi77GEtJRA5iAGSG0FKL15g1N6VaWZoaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4514.apcprd06.prod.outlook.com (2603:1096:820:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 03:37:17 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139%7]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 03:37:17 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: remove F2FS_SET_FEATURE() and F2FS_CLEAR_FEATURE() macro
Date:   Thu, 24 Nov 2022 11:37:08 +0800
Message-Id: <20221124033708.10580-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 7964d4b7-307f-4f5c-fa69-08dacdcd2f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/NneDr6vjFIjWjl0IRtm9gx+BzJjnxof+HN70HWUFCa8IWsablmHp0UYxyrejQXi+zpT1x0woWS52qecj6biUA0U9wIwcHqUfrfG0UsJHPiGPUmPvKHx3iXFfKCTOKM1qV7iEOzUwBh1/KwsGgkRHio2iX+o4E4l+Hf2SEtITjxJLhmITcsRD9QrwqcB5G1iYHWD7MYJmIJggP6JTKSlIBAHAGcH2TIvAyors6U9CgSgmJ4JV9zyJ6vCyCRQbmPBKZ3r1x9LRnXp1S9yEVuSR+aRHj4dJXQwdUeU9E6WYgjNs2kJJWqD/n+8DIYoJGjZSh7sne4ZJYoz/xdW7RjR4EAjgrUPieOMNonlU00cL5DQLfzQ2cqgs8dM2j9eriIrKs8Fbw4K0Y8D9+eODDex6Le5utdWTkZ0BUTqcFQKpIvtXxBRCWyIrhzNJ0jj5dUcX+ir3O7DKHCreKqrewPx78JNApP/imY6AbjlkBjhdgEW9pdLpl2Z7nQD9mCxzVEUzRbN6OiqdENXBAW1a2vjv3hIHbAC/d7VYIwHzvl5o21nBAGgowXx0dRTLhMOXqJIfHpqSzsg0Hgpuuors2yTuD0/hd3NriCrOOctmDJUJ86vqHmjs5hhHVuOPBqLHT7TUYecUQFA0agiicB+MqS9h0qpYad6P3tVEmRAVUCdFuf+lCIV+kNrEMimmc7ARdS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199015)(52116002)(38350700002)(38100700002)(6486002)(66556008)(66946007)(83380400001)(6666004)(107886003)(5660300002)(8936002)(2906002)(4326008)(6506007)(8676002)(186003)(1076003)(36756003)(478600001)(26005)(316002)(66476007)(86362001)(2616005)(41300700001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A5/rFk2L0Zo+H+h67pATrsgbWKs+iXQORCHL2iyMY1f2Q+ZpVToNWL99Dbvr?=
 =?us-ascii?Q?9EjjkW+QtHrTDKz0NeyXAh4RPjY/oihRrotbRIu9VnYuHxMaBhwyUvLKE5g+?=
 =?us-ascii?Q?T1ENyZ9clCKbjMf3S5AfP3gmbwicouXgAiHo35A5RXDhjxRaSFV47WrIFc4T?=
 =?us-ascii?Q?5Rbz12iKbLDrxnbfBXaVerKffgw3H6aHNo/qKuDGb9RXxhrImA/TBwpxdpum?=
 =?us-ascii?Q?vXtvFFhMTdp/yP4tdKlWsBnt8URv6RwAhtAgj+bfqWwmy4ZEOrZUqk60rRc9?=
 =?us-ascii?Q?nQqyE5mFdCWuPm309n4leUwX1wbX7AGPBlbg5wLtuAzi/NhMKhBlCTtlaLqO?=
 =?us-ascii?Q?+ais+hDHAm01h1b5bGMoGo1A+qnwGuk3I31d3fuU14FG2exHIlbKZjOxDhUB?=
 =?us-ascii?Q?f2hNcZNbmKbaVNfrY7e56+Xl54UKTwPqtScL2//mnwBKbQmCr22wWEsaQi0G?=
 =?us-ascii?Q?4s0UaAA8CFbVck/wWNiRJX2lweMFRJbcf0UI4mXuxtPURB86Dj3wGP3aH10J?=
 =?us-ascii?Q?Qy4SS7OHD1ljTa7iki04x6S4NuwHWWJS1LIJt/XAPVOxm+2J+V8xEr8OyQHp?=
 =?us-ascii?Q?RdWub3RPf/yaGDtXsoDOVwjYSBJrkta/P5V9KiPgykSCyd6B5Ktvo38bqPmT?=
 =?us-ascii?Q?wadQcyBKlAi6A7pkzADu0sGBSg/taZWa2Y8dVpe0tZnUhJXMLw3hzwyEGprA?=
 =?us-ascii?Q?AqQrhDmi1ocrKNuxg60hM468fwW1qW/y4XOeIUVwqfIdgi5rFI+CPm+RkDEu?=
 =?us-ascii?Q?ADocLETukFemMTEk5Eyl9Ds81cAjyEBR85l3muCfJ+due6uAmBwDT7HxOvT2?=
 =?us-ascii?Q?hLYEIiSNdq8f2SlU+f5XpTsLaZ1VCuWby263a4kcXTt3vJlRFDLYYVcTudYF?=
 =?us-ascii?Q?cpu0RgXFsk2Pa/HL5aLZaMBRJcFjoxEjAAQK6bMJ8uDEom3ecmZrLqJPqmhn?=
 =?us-ascii?Q?hczZ0pfsUkDBS7B7XC5b5xtBcOE//bd/yiWjc3ftwDKnga8dl3t5kHvFmqhk?=
 =?us-ascii?Q?QzUTrQQUSb1giV3M6t1hA4HN07Dc62IaOVSUjcxDG1HJgT5nnewmDxhvHfUb?=
 =?us-ascii?Q?C3JWGu7U0SqEQ5qY3nPmgaOZmD+pKKCWy2ygdtpweGJzfO1vHCGpQlSTI/7h?=
 =?us-ascii?Q?LeRIfeF+Sl1JPOlNBQCSE1MC8CLexhXTcRnDHEQi2u72R6GskYa5jU990n2h?=
 =?us-ascii?Q?eit4Ry7TINg2rCmJbQaf6SwHJbvQNPfdQxK4+4m5GQbqhNz3uX1LZvGTbG9b?=
 =?us-ascii?Q?bVofuF2tdJeq9lSDLjv/Orq/2x9Gja4phNBOIVxv9bLUz5NKRFvZLEPW5wyQ?=
 =?us-ascii?Q?UPicYiKKaoSygskgtV1UhYQ4pHpkLXCNeSnqBED4D2V3BKWmJXjNwR3VwlPE?=
 =?us-ascii?Q?S0XwGbpMTu39Wv52WpD9YQVWcsVJc52hWdpWGjc+w4RRLYgcitKT388Q2j9s?=
 =?us-ascii?Q?2cdv49nRqgEQnXTf2aeCKeGeo0kRO8ijtG+dBUpZQrwSmMVwZOFRwL0TnDRE?=
 =?us-ascii?Q?Vld5KgrVNEsDtufbYvobRVkxT/qBvh+cR1eZMofPDK5Fi/K8qYyeVKtYihIK?=
 =?us-ascii?Q?DNU0rzE3Rrh4RdMwPF/4iC17YoKpA+QeKAnymOt8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7964d4b7-307f-4f5c-fa69-08dacdcd2f8a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 03:37:17.8316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYEHZlJXwRw5LkB8LFi4i2I6E5Lh/A3jYZdA3VTG1qmOPuwoQvAf4dzYmJc65r8xkPVzAwfkI6/ujEpBcZbxiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4514
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F2FS_SET_FEATURE() and F2FS_CLEAR_FEATURE() have never
been used since they were introduced by this commit
76f105a2dbcd("f2fs: add feature facility in superblock").

So let's remove them. BTW, convert f2fs_sb_has_##name to return bool.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f0833638f59e..0640c703cd5d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -203,10 +203,6 @@ struct f2fs_mount_info {
 #define __F2FS_HAS_FEATURE(raw_super, mask)				\
 	((raw_super->feature & cpu_to_le32(mask)) != 0)
 #define F2FS_HAS_FEATURE(sbi, mask)	__F2FS_HAS_FEATURE(sbi->raw_super, mask)
-#define F2FS_SET_FEATURE(sbi, mask)					\
-	(sbi->raw_super->feature |= cpu_to_le32(mask))
-#define F2FS_CLEAR_FEATURE(sbi, mask)					\
-	(sbi->raw_super->feature &= ~cpu_to_le32(mask))
 
 /*
  * Default values for user and/or group using reserved blocks
@@ -4384,7 +4380,7 @@ static inline bool f2fs_disable_compressed_file(struct inode *inode)
 }
 
 #define F2FS_FEATURE_FUNCS(name, flagname) \
-static inline int f2fs_sb_has_##name(struct f2fs_sb_info *sbi) \
+static inline bool f2fs_sb_has_##name(struct f2fs_sb_info *sbi) \
 { \
 	return F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_##flagname); \
 }
-- 
2.25.1

