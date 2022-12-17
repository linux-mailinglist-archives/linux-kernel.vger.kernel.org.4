Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD11D64F7CF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 06:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiLQFZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 00:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiLQFZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 00:25:07 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2099.outbound.protection.outlook.com [40.107.255.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF9625EBA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 21:25:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZEZLChhrd/gdmRyD2qHG41rDxx0V2qFibNRCy/UDSnMaFczw72gBhokl27O9ONbm1shO/8ztufy9sJIgHzpofuJG2bJCUU5Dbu59QeFrWpLgVZIxKLlDXaw/QTyqUtQj7eT4cDzXj9PSCnONEVYDauIwJ+PjjRp/XVh+q83JQj7TcVX7TwqJh/MX6LXxjdTjnZEz6kgeYh5duGHVBFNvE/VN5CNHAWqfIP4hGoCXR1UDR/hWRsUv+ocbArp8CFt9HNevVhdjDtxBgQ37XaDRsYReC9OidTYhYw/1/EE95TiBbEQBpQurC4nW0QElo1e/TQ+3TjPMXE8JASaOgN6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ9FUlfJqKUzL4l6233CxlevyZaBJZZfa8QSv9Ld8lE=;
 b=EUYvuF38MNYVdor98jSfl10GbvX9nKtUuYrZlpixXJHmCeAlEKm4E9eZZVQcEQSVrDLBOQ/Ak5ZhRVVXei2XCo3Mg4aDYGoug/cgYuKFm9hTjh2iVDYg4+x7o+po1FNLn6rCtULanGC+vTYJTfK8cBAAQbhbjuwKXCgumPcIG/EdYRBIFdLi4IJybBS3QgQvmhqktR/CCGGIzfVbXbPOPFBw3O0HE5r2w4bkIsY8uBfMi2QSB9ssr9acUMBfNvix4XHc+JY6O+9qb9y3Luk7QVEJM1oeE1tGkuqlEIB/TXGnQROmzZVUmqAuDxC5TRfBEDstysVrL5PCDqnkcnPm7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ9FUlfJqKUzL4l6233CxlevyZaBJZZfa8QSv9Ld8lE=;
 b=JXwsNQsCf/YgFED3vFSK/SG9wbf4UXAlcAnHajA8uvt7CPmW2Yf9o9jn+6thXE1LOXZ5ATsDS79Ty9UZjecz7JdIuxSyl8haIcRHB1IGBqrD+ss7Ips9O5yzAaO+Ti95DrxyljCjMU5wQzPjVf61NMKQlOdcKnBvnRc2lsssGkvMgmKaZTEDmAdNRv0rxoxvIDf+T6Cnio6mTPFMvrDe3whe+J3Ovu5z8ZsHaiLEHQbsrA4LIKdJKe3kpQE9fb5ndNprml4AKqclugmI+pav/MvKrCnQUqbvCTeDxGKTO04MqKb5sj/4sXc+znTDo7GJT5uPSlEea84TWgTn7hkVCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6195.apcprd06.prod.outlook.com (2603:1096:400:352::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 05:24:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5924.016; Sat, 17 Dec 2022
 05:24:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: convert to use MIN_DISCARD_GRANULARITY macro
Date:   Sat, 17 Dec 2022 13:24:48 +0800
Message-Id: <20221217052448.60656-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: c78f4f27-c803-42f5-08fb-08dadfef0a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qha+tbxLYQ7UyKmJuY47nPY8wfjLP9F2OzBUTa9xIvuSbtu0LxsRxxx3SDorb5YeiU97TjkgfCrzoiSlgW22pn4olYcdIb7Op4i2feXg6ctP/TxhxyK1c6nqxo8JuUa16nV7q6y8N9r6zn2Oy/RjAGhuPLI2UMn6hP9X4Y1pVP2IiTXNagl4REw+wwdcajiSPr1vhE1oGSrOM8wrQ9ExUcIivL/gmO7KolA1JSSmFKMIK1OM7Lb/wsmWEXhnnHR6S1M2BfNHc4fZ1xKIlqOHDBccdm78GegFpG+HmlXiGRwrCXX7Pl6eKeCb61J6jf5lH+ec2zS2iov8NIr82YZdHfxYwQclm1/I0+wUdxJ2xYsYW+n0jvp2+EqW6dOgr8ImdDeyg8Tdvs3nybm1Lwhc6T24shuutJw9Vkt3lle3DGU2Y24GK5nQV4rld2trEPsfikvj6bcme+5/YEE7DykG/FJUQK5BYQYSNOXywynpzzsId+FVIs0i2jcazGOTZfzGiSxpbITYcalC11BQMaRDLj77a68X/Kk5pAex6RsEeWiU59V7m8nGEbteAGs7C9BMnfKH5EHY26WJf6h4EXEcP6rj4FtaOusqFbSKrcDai9xSvTGLqKUfkOHArXsi78Pl/m1WbAPPBt2c9mbYh29q+03mILmwGudaCVYofggZNQ2aX268VQFlwGaA/7Ngcv5NZNNXlCLoYZ7MFuZvOcbSIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(26005)(6506007)(86362001)(6666004)(52116002)(6512007)(6486002)(186003)(478600001)(36756003)(107886003)(38100700002)(38350700002)(2616005)(1076003)(83380400001)(5660300002)(8936002)(2906002)(8676002)(4326008)(66946007)(66556008)(66476007)(41300700001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Y/zkNWB78PROaO2MGMqzXrVdQy/fqZVJZkbeVZcVfhPFcr5wINm9Rl002+w?=
 =?us-ascii?Q?Yxyk0H+yOTsioeSp3smp07g/NVcNuLSEKfFlHTMsDyNSu0rpOYRyW1/sPIJs?=
 =?us-ascii?Q?LRAHVUjYA6mkNxfYqR4rNMkU+tKO2ROIha8LXJnAyrfoE/i/o/yHsUvFK1FB?=
 =?us-ascii?Q?QqVc1kDgB/6jym+FYuKoS8i7ybuDQTOdc2gvTtwx83lL4NOKbcK4pAt9sfkD?=
 =?us-ascii?Q?CQZQ+sBmmTFkM0xgL5/Xhtl2RgdokyIQPAfHwkbqGtI2y097j/gH0fi3dmW0?=
 =?us-ascii?Q?E77Mo8TJrE0enhMiMmD1zLAxoHog0Jr+2z9vPeTUMrjb9m9RwsWu0qOKatO3?=
 =?us-ascii?Q?vTfe3e3lN78gmDTW2RigziUL3sd8+76Q9rjDwKvFI2pmCWRnm0RyEwErTHze?=
 =?us-ascii?Q?Z81kcZIWPsY1EmvWfbmbU9Aub1M29PD/5I0FjMMMOXt6fipM/o77s4XBBCRP?=
 =?us-ascii?Q?inNRkKrZN+BP0zYSPDPVMm3Buu0FQhq6E3XZ0jTAKVWZWTRSwKdHeF6kOaMG?=
 =?us-ascii?Q?lMEvqrsYwOqyhn8cSqck3208ppOG7TfgKBFqhxiWtSTP6x/kSydQYa+LImMS?=
 =?us-ascii?Q?fhPEXFwW+yVPGVGVP9ij7Wc3oY7YKQwX0lTXcJeFBvv5/0lmnsv9pM/f24Tu?=
 =?us-ascii?Q?KImSW0aZe+FXuHcbaTKc2APzmGHomYhhjbyUM9jOfHvkpFPwTRixoRMJhlnt?=
 =?us-ascii?Q?BgiTW1e4gwFr7W+vRu1YsW9zw2DvxTTiiwSoyuOefta4Fw7ZX2SG4ODK30m6?=
 =?us-ascii?Q?JRh7W6Inz7F0SPtwfmoTciAo9Md6iNDZzcmfbPZunyAqnLccPVrPa8qx7Lp4?=
 =?us-ascii?Q?rReSzhARm8mzHHj7spE9siMJI1fRXsW/00NtASoTllOaYlp0svd8wXWeMlyr?=
 =?us-ascii?Q?B95eB6otUfUokuBGwtV5FlCKfZgtjxHrRtNEV4xYOa/iK1hovSmSY9feQl3v?=
 =?us-ascii?Q?CPu/no24v61cmq1uVg5a29RYoloJkgAms3VKiABtpRqgvLu2DIE1oQCq4OuC?=
 =?us-ascii?Q?Ih8ETw3sncBe0mSUKsaPFTQJME2L0/RjrzWK51NSIov8V598RdNakS39kMXm?=
 =?us-ascii?Q?qsv+EZKUtPbTHxNsoySpvVZYf4WFxycA1XuuWANWww0YMjyTRrbIXdHvYRaa?=
 =?us-ascii?Q?6ixYLEp5F3i0BXqgoZMrP/WlKBO0eU61sf683n7iiMW9MBBz1QX8hWpIqts7?=
 =?us-ascii?Q?dEA3zs3PsS1WThQDDTWn5ZBFnuqd1Dw71SQ0pqWmOVoZTGKo1AQlfMarc4vb?=
 =?us-ascii?Q?biTAMoBZzLuXtPM/OvQXfzfgnxui2LD5x2WjhMlGxbHdh7fqqD5MRk9HmT88?=
 =?us-ascii?Q?b7zNDaQtKJ+8Ae+OM5ASZOQiYFbgUdVCs3/C5PvrjuGobwGg80K9STMYuTvd?=
 =?us-ascii?Q?gW5gBtcrT4Kj3gwShnixN+CyG1wY/KQNeJwm8gFc/N5sSeQXURe/NhteR8jm?=
 =?us-ascii?Q?GcVcUC3nF3YLtaRBhm/0+0vcESo2Sqg3j+lC87u3gdEgAEzHrMKAEPuqO7k4?=
 =?us-ascii?Q?we57Yvr4s+q+tfp06slY+Msh7zaeNSv9uhAjiIbnu5LPXObbC7pefPXPwDfN?=
 =?us-ascii?Q?HOAL/3j7XAUueW2/EGCNTMAenldR9qoMi/zIZfwj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78f4f27-c803-42f5-08fb-08dadfef0a5b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 05:24:59.1356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpFgpb+DuNC1uVBmPKKBspQ9Ul6CUWgpQ7E249UcqOoacTl4QD1hcwhZgumcOxrUpUDMKHTlbkBwVR+agpOYpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1cd2e6d54435 ("f2fs: define MIN_DISCARD_GRANULARITY macro")
introduce it, let's convert to use MIN_DISCARD_GRANULARITY macro.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/segment.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 25ddea478fc1..c95a9683f950 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1610,9 +1610,9 @@ static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 		return __wait_discard_cmd_range(sbi, dpolicy, 0, UINT_MAX);
 
 	/* wait all */
-	__init_discard_policy(sbi, &dp, DPOLICY_FSTRIM, 1);
+	__init_discard_policy(sbi, &dp, DPOLICY_FSTRIM, MIN_DISCARD_GRANULARITY);
 	discard_blks = __wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
-	__init_discard_policy(sbi, &dp, DPOLICY_UMOUNT, 1);
+	__init_discard_policy(sbi, &dp, DPOLICY_UMOUNT, MIN_DISCARD_GRANULARITY);
 	discard_blks += __wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
 
 	return discard_blks;
@@ -1695,7 +1695,8 @@ static int issue_discard_thread(void *data)
 
 		if (sbi->gc_mode == GC_URGENT_HIGH ||
 			!f2fs_available_free_memory(sbi, DISCARD_CACHE))
-			__init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE, 1);
+			__init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE,
+						MIN_DISCARD_GRANULARITY);
 		else
 			__init_discard_policy(sbi, &dpolicy, DPOLICY_BG,
 						dcc->discard_granularity);
-- 
2.25.1

