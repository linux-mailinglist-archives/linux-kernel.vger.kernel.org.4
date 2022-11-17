Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0862DF6E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbiKQPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240563AbiKQPQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:16:36 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0185E8D48D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:11:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5TtG4lSCk66hWAeCIOvJ6dSeVqz107qDV+0LF9Z03P368hKt9+3XIkOVs8/T5jJfxb4EtDopYJdy4JgzEEue8KwPhNKSkBM5rBGQmPVTceOiNsJJ6zNvYLECE2bH1+hzgrQCBH1AADmoMraxB++ZOAKpeuY6vsqJZLZ2pQIM3+yaNzPM6YqBWd+nPlkeMFgRiwZA52evhmTaEnoQhaoycdnGDo+ZJn1VHizutPqaPpe68ma0/8US5JVp2c3/UdkMcLDAH6RgYHVc6GwNFidoUR67+3db7qCf9n3YxvAytWB3qKc6CxRKLc+E+awGZA++z7CqiatBMGstr4RHWMIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjoDJ5jcjc030Rw2+5AV0rnmiqmEAgLgJYpbTT+k7HU=;
 b=TVg6VNpBAfkoyDtEFgDiqPkxCopBZ/KTOYdTdbZA7aSQypfVpqhjWo9BJn2rSwNeZZteH6c7WXLg4Qolkn50k03DTTGpFsOqVSiVclNtopI50xVw6UAGc+wEhg+6De3QMGkCFuCDt/VO7bgUwJ7NsdLCNGy2ymaRIKpUk3lOtlaDlz0EMj2KpKkJ3uUj9UFMsjRdyMrQksvfltipISzD0LHSaFvW2u8SAfluo81QC5y2wkaTMOAU9e54zLyO2YeuoccqrG7V9E+/EfsskuSEWysX8hppecU82IV+aGMHzcAXlXZpPMgD57ljq3nLKWaai5LLTiHH5CFV1Yxc3bP0rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjoDJ5jcjc030Rw2+5AV0rnmiqmEAgLgJYpbTT+k7HU=;
 b=J8kygpCTLwk3p6N4LaUlnzn+lCihUQxBAu5ymJYJDHwaF/2UE/W00AmaCcWBS2KyrDbr0D+lHicGUBSSaD6zhwzy+mVvS87MLwJOgqJIFxr+cPHzVb3678kuNx279w0ZMLu6oJj6nmMlaO0dGy+CZnf7AWMhtm6KjkJnOjTunhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 PUZPR02MB6305.apcprd02.prod.outlook.com (2603:1096:301:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.16; Thu, 17 Nov 2022 15:11:18 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::2954:8e56:dcd1:452c]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::2954:8e56:dcd1:452c%3]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 15:11:18 +0000
From:   Sheng Yong <shengyong@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     terrelln@fb.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Sheng Yong <shengyong@oppo.com>
Subject: [PATCH] f2fs: set zstd compress level correctly
Date:   Thu, 17 Nov 2022 23:10:54 +0800
Message-Id: <20221117151054.2232946-1-shengyong@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To SI2PR02MB5148.apcprd02.prod.outlook.com
 (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5148:EE_|PUZPR02MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 04579d50-2210-40fc-d8ce-08dac8adf92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKU4o39gZNSpRoDAcRxvKpIS/XC+kR9XRn/1anA+yQ9vNQzVYzRFKF7weB7wMQX96dabHS8pG6oF23y9C4R0c/9vuq5xwXuVLr6A3mCIlu1km0x3mGLYDlqm3GlBpKA4I6tFUOyQpZpBXItbA4ZMTRu/9zlfeXeWwCu0X1ttuTttNy7UfxdumA9iv6ivLvXvyuL8o+aGKp6TwXhqLl5zMLxdBrYT+CeqXN6SUvglck1DEPfC2PzEkV0L4QAO944NIcyVyOcXjnwJ82iFLIffXYJSEIk0jsaPTE1WcgLRKsvJnBzbWrhz3Kf5UsKWuTd9dxfXcv2OOMSxgNaYRZRK5BQsr7qD4Ki05W5MuNe+6wuiCBby81mFxxCqQc2cKV53n5w9XLEUDwSdf2Hyd0seXZD6RdmFvE8jB81gtjJBB7agh+QVWb2Pr/yE/YjEnrCLLq5hAI+7RLpj7E7YzWLZfdfwbzDwHg6PVPqaSBwrqAFn6TbX1d0JGFCy4xVlkTTbr1Py4vzHPkuS7+uTXBDX3bxKZW0MV/j5uMuWuMajWOYj71adQAy9WQ7eV+l9FXy9fz2peVX0hVw58nn4hgIY2MmYHdk58B7pjtUZPh1t2+tc9Idl31BJVfuejx6g7xLuFFF+0RGJXDZj6HB0jpMfKdOaWzR73WdmnRVJYJLvqB3v4vCRrbqqIsdYlvCCOTCF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(2906002)(6506007)(66476007)(66556008)(38350700002)(2616005)(38100700002)(41300700001)(316002)(86362001)(8676002)(1076003)(8936002)(186003)(4326008)(36756003)(4744005)(5660300002)(52116002)(6666004)(6512007)(26005)(66946007)(478600001)(6486002)(83380400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cpHix3ssTUTYbbZrtRRW9n+1IVApBxp+ltqWB7ezVRvnoXA01fMwvgiwlX/u?=
 =?us-ascii?Q?s66HwA3XY4czUNDfQIcAGGYuisKuDbNAPvxPf2Z46jH18M7zA4ngL78nYWa2?=
 =?us-ascii?Q?zArkYrj6UiDW18BW7Z5oyqcOkUT9u7S0vrfxoPN3kTidTEsWlAYAd7Dt8LpZ?=
 =?us-ascii?Q?bF1f3y2oyAke/vHQARi2fZgEmZHZTpImXS2Ijik2dW0SpN8Mgjwsay51S9Xe?=
 =?us-ascii?Q?fQ03h7BgUHNYQAHH5M42a3J+2qEbkyoZhvvxi+Ef0DQZllAFrnXuNltjg7Sg?=
 =?us-ascii?Q?gKMELJii1ZqmQCvhJQsRdFQJROJb8JZD2o3eNHAxKXn7FWvfnbAYwIVj9x92?=
 =?us-ascii?Q?cZ4t1etyXOKChMgLL9YCQNr2EfRq74IKiZc4m1s0gyhxb33UTL/rCPHeijuh?=
 =?us-ascii?Q?ryKXwA2sHOqR/oxoqy5MGDs15x5KQO6seZSHWAkbCs/MhjblWEgDs7fh8opi?=
 =?us-ascii?Q?cY76qlv77miB+DrqUKu2RZw1Trj1YSB6kug3iiEPrP3MriD/8hnumepLqNrY?=
 =?us-ascii?Q?hVNhWgxdXvcpN2w9+rGh+XYlgj2ZP94S8pSRbeuZCf+5YuomzKRzo1I3RrbG?=
 =?us-ascii?Q?zWEl1UHjFOgkx2bl8VftKv9AUh9LFgS+UHiIye1SxCT3A0LAlc+RHgWt3Ubx?=
 =?us-ascii?Q?6SGB1iueXzTB3SViAFP7DRXVes8Pl+oM2IJJAmaSJXgBmCMFViv0p35GZS8n?=
 =?us-ascii?Q?HEGu1e6gySw/B8tlS8t3I7EqxOBbkg0pEpZExOu+B55ypp6sIJvjPdNkul0D?=
 =?us-ascii?Q?eXD8genN1yzPDzJ0LN+7rf3ikWmHQQUN0zD1cR2Ghpj5NL3u65Wfa6CmFesV?=
 =?us-ascii?Q?lkhQmrHlq7MmeMB105bTJ8d1t7uJ74ryH6WMcHhkj1BZlMzaMfURE0ZvCjGX?=
 =?us-ascii?Q?IcirXlFRMcMT7rA4QMMEO8nLRaWEj7NKL4yvcdNOQIW8G6U1z0laO0NBVM4c?=
 =?us-ascii?Q?3zHhNyYkgHkeieWFM/dJIuNMfHp2vNk1HhtxQN6qzcL4yz9hKaw+pXo3fJ/Y?=
 =?us-ascii?Q?C/wqYPd8ZOQaAcTYlbf7wO6kH3mqVY9Agk2N7dGHOah+BYE3xcMB5ccYlnfT?=
 =?us-ascii?Q?pAPRdbD1IY1uc7m9TZRH3LqTJBdcDsG1f9/n6yeTIRjsyMF936TX+TpXtv3I?=
 =?us-ascii?Q?fgauND6LbaTztz0r1hSCjJU3vn3/zQMcHm5dFbmQ7lzaaKIqK4xQt316hd1l?=
 =?us-ascii?Q?GZ6Rjtd17Y0cYuhfts6vS/XEBig9MPuKu9o0LcTEvd17KHtPEHrpVYpfh9E3?=
 =?us-ascii?Q?Qfdf/XPif+lp8Hw561w4akWn65nlIizcVcF9Q5YbVPwYolTYyVBAn8P66jiH?=
 =?us-ascii?Q?YKD0FCnpxaESYUc70prtvSebSzoijJTFvh/GzMb8Dq/j9GdSKrKOFj61aHuU?=
 =?us-ascii?Q?uMYkzc5YgYnAIhwNe2OSIq+DO5W7p1Yh30CHU61HjX6NiyFKRM1H60eNJ4yN?=
 =?us-ascii?Q?2GHuR/U/612nfak2A5hK7ila/FAXTNQ/QawoKxryQWDwnFOFEmq61ld4Yjcp?=
 =?us-ascii?Q?Uo1raxVtcXMgJyAon9yw9h7EDVlDv+J/AreiL5clp99oEaV3VVXcUag1Y8TY?=
 =?us-ascii?Q?XVtju7zs4HcP2+7LKDcoaQbLQmtCRVCcCy12gJF6?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04579d50-2210-40fc-d8ce-08dac8adf92b
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 15:11:18.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ai+9fSNOmiPCdYt+39jZb36ZQjSiMhDEURwJ38ebe90PlfO2fHfj8sMJSKi8EfjdJ9fN9CIfrUoPcZ9+yMtVfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR02MB6305
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: cf30f6a5f0c6 ("lib: zstd: Add kernel-specific API")
Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 fs/f2fs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d315c2de136f2..74d3f2d2271f3 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -346,7 +346,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
 	if (!level)
 		level = F2FS_ZSTD_DEFAULT_CLEVEL;
 
-	params = zstd_get_params(F2FS_ZSTD_DEFAULT_CLEVEL, cc->rlen);
+	params = zstd_get_params(level, cc->rlen);
 	workspace_size = zstd_cstream_workspace_bound(&params.cParams);
 
 	workspace = f2fs_kvmalloc(F2FS_I_SB(cc->inode),
-- 
2.25.1

