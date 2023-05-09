Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9D16FC352
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjEIJ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjEIJ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:57:26 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A4A4C16
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ID9mqbrjWdGhvYaHk9rcAxiM5TP5aKs8rHXyvCYIw/ofNdJ/OtFYpFW2WOwaQUscwRsPtIsVr8EGoc6KmpoHq7e8vAxJsQgyOxiDUruDd3MBjmR6zytoB8adWr1J6Mp1CI0p4+c9Ges+oANbgoyNL+Nl3KArsBVXaBV9LQP4kJFOg2y3gvXYfAvqvbEcYtUrNYTOPq8yyvoCDHKVmbrAtxEal8ZBn7c9q+VtIgJPaBp9hCy3fr2DnPjSvm3hcez3Ozwb+gP4JVZ978SH98VGdLzp8W8pS9kOybI4JjHB872wEI+a2sfZL0LjwOU9v+coER6DhwTmIo8BH6BS07SPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6luf1sDdpq7vm+r+VRwsJaFqPhL7j1YIsUOYdY43Kko=;
 b=ZJdJo6ZOVE0Nw5icSlifCXkl7iEF7m5BzeRK3i5Ve2HVXWMVtiu8S7uGoxSpO9yBSpYo+6PcZt1KfEOEYl6YdKwYMs4JLmVS5JJen4SaXssmBbiizhYD5yPRR7dVtKgvCUwXakEZ9chu4PK/2PJIJ7Pmhu4Hfp9rjq7+1Gov28J7kPP2XMGf37q1XR4pk2Yjf6e24JHpdENWR2L1hexZlZ2czm1JU8jUtvwLHmYiiFX13YY1WcEIY47E+6c/8ALcPRugLKOiIxezPCt9mhjk2v6ja1Te6z3tGgo4Hzgn7vMvEwQHRc1Ri3Qw/jAuZXQCE1XCJJfUJ38aSWGYgH6TPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6luf1sDdpq7vm+r+VRwsJaFqPhL7j1YIsUOYdY43Kko=;
 b=dzvELX6wEDZKlg4rpMjLsJStToyfe+Cp7KAFnzyNm8oRsIHWGfMKXfvAWnOFJAJVOQhVYrQlk9tVDRGfykwK3hvqqIDEi4FmDoDtF2ssMq3Ur0DX0z5Q7DSWU1oT+dv2zQjkPasJyKEHXu+67ZEqGcwaABMNCN3kogpbnfouVCHhqpV88TfoLgcB0tAZXvo/9elrMolC6DzgNi/1J3rLtIRhS/F2UfbZSYztZdXu3lkotdHzyNj/JXRgxsOEX8gm+sMuG5WmAFDx0hw1Rkh0mtJAqv5guzw87++T4JGHd6B/Xf3d7INrQsXYgQCP3U6e1q7oZ80muVfZSIjDG0oN8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6130.apcprd06.prod.outlook.com (2603:1096:101:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 09:57:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 09:57:20 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/4] f2fs: move the conditional statement to hold the inode lock in f2fs_ioc_decompress_file() and f2fs_ioc_compress_file()
Date:   Tue,  9 May 2023 17:57:04 +0800
Message-Id: <20230509095706.17844-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230509095706.17844-1-frank.li@vivo.com>
References: <20230509095706.17844-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c37b63-ab5f-4a0d-c806-08db5073c781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6l99tE5w3DDX9R3o0uriggDGr7khTXWrjryU48YwNGEi6pHmk6MjLns+A0K57Q7aWLjV1FBN91ESJgxPwGUOyzAi5itCf4SF4U+bXgcjAK5VETxMCtw+8eFs8LTHz4VSvQlxLBfqfsafr55VI+k+2PurARZe7h66LWfqqphWuAu7IXNKksWAjNhR86xwygB4cs01PIeoKc2zdLjVi6K4iRKjT93O+exsddiPwKVqxrGm9IhSq9XQcTdA7zmxmUSuASYHdb0WyQ0rsuNtu+tyvZRAYU8Ry0wYqhtMHpZnFovUQ6fPdpK9nh1hywyUhQ5thcO1trBeu3xt6CKLwqjfmZK/AqYic4OszEmmpueCEF7hDIUMDU1tDB2kOMok5u+IviXR7XpZfwrDJiC7QB5VBnddBKOTeOveLdB0SpI5lpTJ4aTeyTHADvdpp8sMo1VK3jrz/Q2aAx5Z4rMCbkQWSJB0pjsamuENRN4ES25Wbnfk1SP1FHYswc9iHQOouok0vPjLQ3pZZhHaMdQWbmkQACd4qOTMMDONr2FiIN/1T9F495F9SBpjHnbcWmxRuOA4mujDlNmwahV4ZwoNF4iJBY34IGOI8mgXRZ6QJxm+n6OYSB2wfACq9CoYwXMVLWJD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(6486002)(83380400001)(316002)(66946007)(66476007)(66556008)(4326008)(478600001)(6666004)(52116002)(2616005)(6506007)(6512007)(1076003)(26005)(107886003)(186003)(2906002)(86362001)(36756003)(41300700001)(5660300002)(8676002)(8936002)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n/15Gt9E5lmgjRW/p1l5QBAqVrRUMZBfY7E2Elo1lNkO0xYCqb+Ov6SAwRpe?=
 =?us-ascii?Q?U0a4VHcF80f9AiCBbN88HWHDat0f8h7DKsU7OobRnfbzSgN/QsJTxJzsvXpG?=
 =?us-ascii?Q?UOgZK0M8bSbM7xPk1c2UeNlIgwhYzIizIywjdJ9mzugLiLIPV5P6LFDj4OSk?=
 =?us-ascii?Q?WSROOw+O/FXq+TuOt48EuSIBnvCPZ2iaejXJK9uMl8E5jsRg4+t7UdKol0+7?=
 =?us-ascii?Q?hN2+yP7IfGuUIIdMuPbOswUr6q+oWo1N3LccF8trKZHNHyLSom2dKl5rIXaW?=
 =?us-ascii?Q?ZYnVYCUk4wJB0/nhgL9H1b5SOWr8XIxYdKGrbdS6VdihX/PCGrPzXq/yMh6y?=
 =?us-ascii?Q?YuJJs99F6XZBnXZmj8Z9pNS2OVjaG92HCvVYgvCiPBRVQ5fpTNrYZ1pdYAEF?=
 =?us-ascii?Q?DmgEb7P6FbLP2NkOK0s0aI6pK/QV2+L33RuRep7HaR+UNUBnHkEFYMrfGosv?=
 =?us-ascii?Q?PbN/pB7DwLEnH2TdzfH4SwzE/gM/QHjZljFdHBMZMIfWYBwr+B+27OlNEqk4?=
 =?us-ascii?Q?hzBEYLT7L9/GR4qAp7671wAEDTaxvWf07G8Lfn9cl5RJn8EcFB1wm8wxtdym?=
 =?us-ascii?Q?fHKrtuf1ryw/GHUIHNe2yoxs6zuKW4GF3NmShFaN7G0uN8nOadFFx6Sten5s?=
 =?us-ascii?Q?D9pBIaDaBjQ8hMhXfNBnofs/dbl/fLAEGlfkmQ4i3Zx0ewjXCwQDid5Xjbco?=
 =?us-ascii?Q?K+RhD/LHSRqJqCFuyr0x0Gqwwso6AnEff3c91fWkaXYjftwOCaLLG/y2DGkb?=
 =?us-ascii?Q?Tl/D/tCMji3VIy/lLeMfBsOo8LEv67+9zGDM4hli+tK5Egsgvfx3xdDzDb3H?=
 =?us-ascii?Q?o9sxttSjsl2sLLjKCxbBHdA1/fwVSrUBaMeT4TKNEw9sgirnzEgWGwbkCa1k?=
 =?us-ascii?Q?C3APZ4SQCfRGGF2bGZA8ooTFzm0doHgoHCBk3H2n0j/1TzifUanvGdbyqgxl?=
 =?us-ascii?Q?e4tTMWMibBij3a52XoPcVIxCobNeky/IL+DgOHNqvAxk3BTuvmf4JrvowXrv?=
 =?us-ascii?Q?JYJ2ZVkA+6TwoygKJ473UstzipEmlKDWB9w1UJLRA/JfFHtnl5eDLD5Wgtue?=
 =?us-ascii?Q?6oeLikcsHXR99B15Qn7rmItqYxYof327ygauI/WIkXoWswyvDHcUFDx5a9YT?=
 =?us-ascii?Q?nrNC5y6lO8wU9fQP9lg27Nvt341fvOHNMLVqsxh1buWDbAKTXofEsb0aD6Ma?=
 =?us-ascii?Q?iWwVKyXGJYU8sQ2upH5gXBCcxagnMnvRlVAGCNOVVqwddmrwa9LHUUqAhoyc?=
 =?us-ascii?Q?lFrSbocb7jLUYbk+RMHTDDFr/XSpRbCZ5AbPH3G7RvpgK5EeGPnujzYqDZd5?=
 =?us-ascii?Q?+MkZSIFoswCTrJ5N5egAqesMxhZ4VkyfR/X4Hn4EqrJPPZFbM1eQfpzkf12O?=
 =?us-ascii?Q?W+CvrHlRVT+SLBhgUKM4IphXb/0RG/9Fo8UWdnOYlH6wQ5LwzbjpsYgegbqA?=
 =?us-ascii?Q?UYt6uK2oj15mQLfXNbD5W+YXuzFTfIhUTCV+MpcdiiC6BK3AxHrn+W6oxDB+?=
 =?us-ascii?Q?nUTbtikYhesP3EXFxM7hHizH60FS+2gKic9gsnDFA0spUU5WxvaeAYR911yY?=
 =?us-ascii?Q?vh9g0Ct7Ohosz34xr4hHAvr622DVYLJKbjS7d4kc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c37b63-ab5f-4a0d-c806-08db5073c781
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 09:57:20.3153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuQiTvc/rfSNjWP4ofBTNSMcOsguGSk4W0+8GL2gzPs81gHEieU3+1gu5h+sGpeqGqjEhaHO0pRauaekR5ThwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For judging the inode flag state, the inode lock must be held.

Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/file.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6f8936ec689c..a6180d4d94cb 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4043,14 +4043,16 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
 	inode_lock(inode);
 
+	if (!f2fs_compressed_file(inode)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!f2fs_is_compress_backend_ready(inode)) {
 		ret = -EOPNOTSUPP;
 		goto out;
@@ -4118,14 +4120,16 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
 	inode_lock(inode);
 
+	if (!f2fs_compressed_file(inode)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!f2fs_is_compress_backend_ready(inode)) {
 		ret = -EOPNOTSUPP;
 		goto out;
-- 
2.39.0

