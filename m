Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18658679D93
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbjAXPeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjAXPeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:34:07 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE753BD8F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:34:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmtJgMuD39mGpHp9Lcwl0jh4j5IIOgc+5dmbVs/HpG+CiVh/8ts+i8yK/sFV/Au6YL4EtBAX6xf5Z5Dgt4XFQ5/VMt0QTSV1POsAh2taq0Qc3n6aUExB5lXsLlY7U+uX2KSmBs+rg3q7ScyAecWjU1vyl58xJNUuaxQT/X6WuK3U0v1mffsc4YLvxc2Vou2kKbazs2FxVHHbBamwwTbenEFdZZy0R5+KVPIAsBktTEsLR+M5OGL4E+Hg5Tf2qXRl1imb4C40moqoDfhyzHW+fZshFlUL879vwEg+Q8GqOE1UxqE2hmY2qWVD3R2/ho8e44h2NhhDfHKzNfGcD6negQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzrS/YczNlxfMf68w7RKv4T5CF4rfwv+fxYfN0w/LE8=;
 b=RmBWis4qB+Y5blzoDStdG+X90H10V0iFXoP51u65KbZr8NlNF7m0KXWJgFAlha1CbVvVvgDEl6va3ubeqyzRmd3GkBh8khf3cjTTZXUIM+wFLysFmhgtsI5sO53Yzsk6wogu+aaxp/WD0xeCDg1oEIOybKMpL3R/Tk182ctMll+Jik9AtSfc334nUjRhKjrN3WPpCNy2d2zp9OmeCHIFCh/KyuvVZKgzxkvawKoGpDQTKtNFhyo4mD8IUfew9bNlLtD3wj4w3l25PbawVYNPGIVwhbzWM0sy+JCpvAUk1VhonaTpdcmD1+F4zMdmBaoixnyNzgXatAONS+MF0kZipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzrS/YczNlxfMf68w7RKv4T5CF4rfwv+fxYfN0w/LE8=;
 b=W0k2j9sUqv3mbkOtn18CBlBE2flyXCRTXm3gRib0hZrnygteYWGWCwMgTHLc2BlBbHZXbNkJ/X0NpEZHcc/YAGozGblLTWblBui4cUzHI08wgswGKrezGqHeXC2l2ENxclCpWq1hwZJJJjTRHOXxDeIbSFvLggfHHe5e2Yksd3RDyZEdCAnMs27jtZXmicGn4c9JhAyWnZt+CNC7xySungXQcIRcN4t6W1ElnppMh4hzcnazkiBWzxVqjLY1LweBox2f0iiZxZNwEPpoQqyf1UZgmRxemlmllGnArr0TjML27jLtG7btmzyfW61ZGyy65eZRKEgx9tthr3rJSihHIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5019.apcprd06.prod.outlook.com (2603:1096:4:1a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.9; Tue, 24 Jan
 2023 15:34:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%4]) with mapi id 15.20.6043.016; Tue, 24 Jan 2023
 15:34:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 4/4] f2fs: merge lz4hc_compress_pages() to lz4_compress_pages()
Date:   Tue, 24 Jan 2023 23:33:46 +0800
Message-Id: <20230124153346.74881-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230124153346.74881-1-frank.li@vivo.com>
References: <20230124153346.74881-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: d238ad98-16e5-4600-98fc-08dafe206be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dbr635F61kSQcG6zkrLF8XVB4zWsAwgCbSTQIJnSmmlpZxsmHh/6gqYN6fQR2ZelIfInHpTzawsHmGlFFJdjTbUAVxkRPOKAQGgInmq28KNOAf+mOwD/Y/QEhUXJsSFOmqzVfFEfKG+qhqp7syI4ufSeYjp4HDmVy0B4q/ADS5zVCue3Nzn7b0+eFigmkAO6ec+U5dIRo0yiBwSXvO+8Tfgn46Y6g/POqHSuG1yX/DLgA7uRm4jMiGnY4/My/s5SE1UJQQ9gypkcA/BQqpcYfZinr+ruHyn7NgH1GgAyj7dit9b+cJrw9o9fZmZzfWx5tuqAvB8uAMVp0B71OgG7lJwNAtFwE9t43kK+Le+7ypMyekDgojyg3OqWuhF6s+q3+VFO4oFHwIMIoh5PS5r5iVRXwKkMkUMSHCGi1/Ga/1CFfSH0I0XPkeoJkvTJWdey/DnSgo2yi5sfcihAcpXDzB9pNzTwsvnDVVhsxFw7lBwpyxJnL3w39o9MNIxzeWMMLbw4Cj4i0FCTLCtFp1rKOYqAL96IG+PU2qfX1rsTIc2liC6dfI1Vt5wqZgWN9taxXct3YwiVgcNps9CmZGgSpFfrycGsk7n37MLLC7eX0DF6Z6zWfY2qn/Fi9N/1Y1mWkApu2dZTl11jF80XxuqdgqzQYqTKuqeLTXuB1hjA1ep1DSrHd2npL1lmq8xusOogMBAB5ufnkR/bHMbcxeJJCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199015)(2616005)(2906002)(6512007)(26005)(86362001)(186003)(38350700002)(38100700002)(36756003)(8936002)(52116002)(316002)(5660300002)(83380400001)(41300700001)(6666004)(107886003)(478600001)(6506007)(6486002)(4326008)(8676002)(66476007)(1076003)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?slyjkFnu6k1g0qCNFTy4TXybn3WAR8FsmvLpFGT5p7ONAb9rdar1CVkU0DxD?=
 =?us-ascii?Q?6ffq77nrFAD9t8gjUPHH8es5SheT2zvWGgE0n0j05pKFQXfrIV0fjWy1VeiM?=
 =?us-ascii?Q?y7t5U3T0vF2r/hl+7kBImTurcGpoSAd4RKNywk7JtOwP5D8jPx/0You2cEct?=
 =?us-ascii?Q?Fqcw3s6sZ/gpdpwe28SZcJI4BDHWYa4Fco6ZyfnICmP9S+BVv4v2axBXPthj?=
 =?us-ascii?Q?yjbUOOT2CqoFOvXRYUwewuYzUarbtoCvylbvivJTwpq/j/3obdiagvobj4/J?=
 =?us-ascii?Q?8N/yZ34VUN8tZXxSBo1cNwfgBAZ1JE62h38UpYoe5Vth5BFH/SZ0zRovLLAz?=
 =?us-ascii?Q?k7FjRyMLNZeNgxNdflmHST7Cm1e4kDtYaruHDXDHHYJ4NN3reG030YXujd5S?=
 =?us-ascii?Q?Y+j8QAmvOS2NtlfLDIjnEXLt653P2/xGiEDhmP/Zj8MP8GrNf3fs9A9k5oNU?=
 =?us-ascii?Q?sC6dmAPdDGV3bpUF5xvldtY1lEQtXkp9A4QP0cXh6XqKkRp7fgfw1Tg6bEWB?=
 =?us-ascii?Q?Wc0U5Dc2PmzFunvwBxPF08XGtBgFFVlYfdWNkM2uKJATOhSpVKcRjGICAX8x?=
 =?us-ascii?Q?L+9n5TPBSblbe/ILVx7NkKjPhGF9Fr45zftA1SbDomzStp6iZAi6Ctag+FuY?=
 =?us-ascii?Q?1JnxQuLYJAIhB7NcgHVsMbqqSH3Fk297pcRRPWiKEHIO9bqVxrjQVgQuVo0m?=
 =?us-ascii?Q?MfHmkvUAck3Io7S1ryJo+OrcK8MhJxHloEl2JI7Hm9t19G040IAa6bX0SkuE?=
 =?us-ascii?Q?QMuEYGt1vrmLKEHkNTEt/zWv0UgKQkzRZrUH6AzhkhE4C5vm21TyOUFEXeMw?=
 =?us-ascii?Q?78Gv1sjwvyTK6MxlXRSxAF+cWOF5fFd4uM1tYiaHSyBQ5DJ4+aCzX6Hoo9xy?=
 =?us-ascii?Q?599KOK6Nb9bkSkP2ilijcFvDjo3o6MniA04y4XnOWK5uXosTX6rCCGuvjIjI?=
 =?us-ascii?Q?7oJUQwJyOzl4hrZWFSOaUizi5zUkAgOQws/Cz3l0X7OZHr6IWkQvE1C6OJze?=
 =?us-ascii?Q?O/6KBYoCku7Gj1+d6E+77AJ/HLPqcI1RwNFDKY6lC/LL2z+BSIzmCllMZPtA?=
 =?us-ascii?Q?+LIWbaBxd9OYjpqewDHh6CgXx0OFvBTflLNUiFWO/ADlG789eeShVMamRbBp?=
 =?us-ascii?Q?fySIQyrYupw4fhWSN3HSVk5TH1sASmmuJUQCd0j9GOel9Xh+HvkUCYcdfsv1?=
 =?us-ascii?Q?7p9lOh5yM8unvitrHdSTgz2O+SPi+jVWnwWYY2JBSJq9d0JIZASQGTbvEEoJ?=
 =?us-ascii?Q?wuJ5vqc5Zgo3umDE2M1rCTGQyHjf2BWogXS7XTeTdM236Kh9DaBcFiybaBns?=
 =?us-ascii?Q?22ZgwLrh8eip52Fls9kmFTsvl7aa2p/DrrswjJ8WAJEBWaqV+cyadgLiZaCm?=
 =?us-ascii?Q?ho1+H6JukW6i3zBryCCJdonhxOYOk08/nvBSQzgG8Ev0T931zD8Ue8UyxHhH?=
 =?us-ascii?Q?PfrVqoydIrCOXSReWZ9pO/LGa2CzWwMzMPFegWBYpDDbmPOt3ZiEU+DTex9C?=
 =?us-ascii?Q?guALlnBQes1WJYCVunjv5zr625oCcnoK6nIO67RZUV1+gGgL29O84gTHd78g?=
 =?us-ascii?Q?2fDGQndJKNsxBiPODqN6ECvzhYdbZ5CHkYkZ0FUa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d238ad98-16e5-4600-98fc-08dafe206be5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 15:34:03.0213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xshbnf4v/T5RL6L317dPFSu1t60QxIhk9pF3T5rhoyHFACoc0qmxmU+025A3IFIRZTPEdEdKA4hE+oRRzocfIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary lz4hc_compress_pages().

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/compress.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index b196b881f3bb..112f0e208b4e 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -264,36 +264,21 @@ static void lz4_destroy_compress_ctx(struct compress_ctx *cc)
 	cc->private = NULL;
 }
 
-#ifdef CONFIG_F2FS_FS_LZ4HC
-static int lz4hc_compress_pages(struct compress_ctx *cc)
+static int lz4_compress_pages(struct compress_ctx *cc)
 {
+	int len;
+#ifdef CONFIG_F2FS_FS_LZ4HC
 	unsigned char level = F2FS_I(cc->inode)->i_compress_flag >>
 						COMPRESS_LEVEL_OFFSET;
-	int len;
 
 	if (level)
 		len = LZ4_compress_HC(cc->rbuf, cc->cbuf->cdata, cc->rlen,
 					cc->clen, level, cc->private);
 	else
+#endif
 		len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
 						cc->clen, cc->private);
-	if (!len)
-		return -EAGAIN;
-
-	cc->clen = len;
-	return 0;
-}
-#endif
-
-static int lz4_compress_pages(struct compress_ctx *cc)
-{
-	int len;
 
-#ifdef CONFIG_F2FS_FS_LZ4HC
-	return lz4hc_compress_pages(cc);
-#endif
-	len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
-						cc->clen, cc->private);
 	if (!len)
 		return -EAGAIN;
 
-- 
2.25.1

