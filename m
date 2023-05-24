Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275E670F3BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjEXKId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEXKIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:08:30 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2079EBF
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:08:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePaiVVm5Zd0ndBNJeeGNgk4Uj/bLdGkoikdWzKDRnWQmIGj1RVqG7/bG0FTlkjNnWDbctpy/gF7iFd52DgroyI1mf1oVH10+YuXLo5wxLY40f805jfWq0xEhTQJrFwUnQao+gYEz47JigfgNkZ8tZVLnArXZFfvXwnoMTbN8qEYT94Y/PMo+PkWPRJwDw0gJx7YXVHS81BnHYdiMfWzy4b5+AiPvNPCXOJVESJGK0HnD6qs0gk2rDkkPx8L1+xaHE+BYnD7iQebifuMKw8UOMjErjEi2SHPStPPSgTvPwlF2+8BOHi7ai2buKDLey6Mf+QZvpZOUFRwFSKMsl83Dxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbWJl+unvZxSbAGq8mOhN1a2E2HqCJMHd8IlLW533MQ=;
 b=byyZK/pYYFclGel60E2TbMEuds+/J/zWqYdDt1NwmZ3amp5y9vuyfiKeJm4tR5ivFaGrLngDMCK2gDAvJEZs3RQzG+ScRASr3NETIA/MbXP1RVHE/7XWrIS2jTluSqUW15DbLxYJV+3sImrIxfnlvLM/DnjTEK6iHO/LMMITcYxKiGcxSj3ZorSYbwvm20be7zJKrRKqkPRG+zm6ZHob/u+LT3UQQ9McDA9hWMiXlKKXWZ2UkTSEskaBKlnAarLIJDxcdt+J0aZGmTyM6Z2xRLUiEhUV8ZecetoO5uang6b6Pu59OYm90n6/JXwiuV/M8hr7IQPXt/MLjNpc/Pkarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbWJl+unvZxSbAGq8mOhN1a2E2HqCJMHd8IlLW533MQ=;
 b=MiP6iE/MtwmkZdaDpcjQphtew0jOS6XgMiGJbWD1pRfXq3xyUBZwKe2er32UYiAEb/I+dbY+9NFGMF4mjKlW8J0F07r8hFjpZEeygRoYQZYDJomVhBQAf/3I5EOQEHjvGABgcU3gEKRRUB4Z2qgh+qz3h+BO8c8OLm5Ejmr79Y+fqLyCJhxTCNZCHB4nTIoWNNA+kXSVj1yHMYs2LkqAO2BI2v88H0X+jJ6qQ/VwO7Eaj0Fb2yPLbxyorcgu0gxd4PCW0g8tMFGjhHEqjrddwP8yJ5w3oLJDA171b3DuFmFcBY7DfxKW6/wfgOxmvocoXhse3jJ67reKEBs39bCv0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
 by PSAPR06MB3925.apcprd06.prod.outlook.com (2603:1096:301:2b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 10:08:23 +0000
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::b895:d992:299e:32d4]) by SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::b895:d992:299e:32d4%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 10:08:23 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com,
        Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 1/1] f2fs: fix args passed to trace_f2fs_lookup_end
Date:   Wed, 24 May 2023 18:08:12 +0800
Message-Id: <20230524100812.80741-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To SL2PR06MB3017.apcprd06.prod.outlook.com
 (2603:1096:100:3a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR06MB3017:EE_|PSAPR06MB3925:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aba4389-1a8e-4983-d37e-08db5c3eceb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDaCyEsQUz3Ow1jGM6yHa6HQl4dFJxryVH+lLurIZGdV5hDOXuYIKXMkQa8/cqDyhttkd/inelq6n/IYIWZal66LnlkeJofMZuEUps1YfdMkyvzrfUIGMU1oaqdsuHBaMA54GP1At9aPF+3mVwF2n+ceBlhIdysdEwqhIIqRnYQkON2tLms3S0zm1dEl8T4Rzi2zeDzaftl5y3Ydg/ip8lfAPC4KdJ1lnh3BRghvfuzkNgb1WE2neOIlxhudemk8eXdtfjacJoD7pVFloNyhYXIqiXx9ZZ/mqd8aLrmnAT1/a0RFCiieHjM/jwy8kTDBKIQDgazBtG+9XiPMmJW73d8UP3CyN80OOHq9e9bzyQgrIZwTB3gOYoWJgOU/hVyvhdzCJIRstxO6YS0sF2BH1VZu09olP1L1CUBHzChNG55kF4Um1i3gJcd5o5DgpmSg9bWSNJNv8eWy6h/KGxmwrF5zbSNVhGB/nzL4xk59m1KBGMYgNtNE8Vk8SkkOa2VJSCYL0FTLy8qK2yBv3aBqjKkMjeW74ZeGWcBjEi25oCMnqGh3vnGSxXubzDHiCt+WNq3LiQ/FHaxGwSxsAJ95h17Fo8YDGInr3ywgKdTs5lMo0S9f35nq6jgrvzyjr7JZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3017.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(5660300002)(8676002)(8936002)(2906002)(186003)(4744005)(36756003)(83380400001)(2616005)(86362001)(38100700002)(38350700002)(6512007)(6506007)(26005)(1076003)(107886003)(316002)(66476007)(66556008)(66946007)(4326008)(6666004)(110136005)(478600001)(6486002)(52116002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zc5kEGYdyuIZPEB1/VbZUbQRJaTHIe57CTVByr9ZhETP2DT6pEHq/d4UhzOC?=
 =?us-ascii?Q?KNFISnuDRZrF0KpDPknsj0Mcv8v0YEvecBNBpqam96AnC5VKUvTKhbfjn/i1?=
 =?us-ascii?Q?d5p0U/00ACU7Jgy1PRiYi0wCBedkfgRgiCkfrz0WdWC9N1DzHuZYRDw2wAiW?=
 =?us-ascii?Q?bXID0kWFuvOIzyuUjnPTTBu9YqtSd2zpK88FV9SxAA6PKQO3eRew4xIuaDio?=
 =?us-ascii?Q?tDNNHuz9uhmtKLvHEy54fewFpDs72ldoKnr82H3Bk8MhNJH5aWOtAGknlcAe?=
 =?us-ascii?Q?cidxBG10A6qizr7jVIMNZwt7kJ2iRjB3ltKQaCiDLoe2AV/urTioli0BCHJJ?=
 =?us-ascii?Q?YNJdMA4koIw8surj+2pg/PzYCdeAyJfkiBTwC/Z+mfVHOlbxDkLRM5OqHaM1?=
 =?us-ascii?Q?36gXmkjVuis5fL8qPnTytZYwvT34wDqhkB/MYr75lb2ht1Qy4ti9YdfLahWl?=
 =?us-ascii?Q?/h3g4NxURelZAIFLBVYubNLslkq6/UMUobdS4xkAeNTqttI5GwanarlIKsHf?=
 =?us-ascii?Q?c5GLVM74cHlJE/Jhew3h1kaayZeZsnXvrTUGAX0AN2sM0SY47VDH8dla5/Un?=
 =?us-ascii?Q?hBGI++oEFk+pzVtxFaZ+3mXDkvTGtYBpvl+lyx0CH+dvj+awuBwASL+XmSU8?=
 =?us-ascii?Q?Qhl60l1LiYSdXijPOaNRXHiF/RCz1P9ghEoLY8RzIXmCCe/7vSQGkguSLMpP?=
 =?us-ascii?Q?hYtrc26E0sxb/wH5o1MBpkK2V5/11ddCITV25LJk0UQbEglxz6r7tWAx8wN0?=
 =?us-ascii?Q?0f9nsSarMYNf2G2aJ2MFalxKLgKhXbOoYVgTVYRC71yKlGZY0a7mBpZrtXT8?=
 =?us-ascii?Q?+KCQQKpKkDRXtYAYCz3g0mp7vSGEJsqO02R1mFyJSiK4y3Z34RlSNv3fFVUG?=
 =?us-ascii?Q?LaamVOTXoWrPmv/ItN+g+XcqkL19TCfJlkr4F34YtlOQOz8/L1Pg+Cd+6T2x?=
 =?us-ascii?Q?TgepxQUO4E/NMDmz8sV+Od5QOBKKSFpqZi8ft72Bc6g4JU0RkL62s9WObXCv?=
 =?us-ascii?Q?kFD004ffa50jHTyTR2FB75IA5I9pK7yciboSh2T++mYydKnNkrjoD2BPPB+d?=
 =?us-ascii?Q?SET9BYkoxPNrtFhFdrs/FF2DEwq0WYWADLjSCvrnu//UoTBAVdrWUF3ZIc2A?=
 =?us-ascii?Q?SUePQ2AXPclYKB4Sd1GDI6u2JWP6XU7VGPfYDb8h9L9enzJSKfJwsupVG9+1?=
 =?us-ascii?Q?xIZ3qHkRFC0n7u/K/TFbKTgYVCeGXo1s8pk5oJokXKN4ySdSSS6CP1BMpcx7?=
 =?us-ascii?Q?GMKdr/Xs1LHEQjmj82hlPcJu/xqsHpPK0T00NlbQNLoH8/IlQ9hnbGXTx0z4?=
 =?us-ascii?Q?kd0PXa7e9aVB1MalFV1n68aViv7PD5VVVWTPI76MN5czXeCvZ00ZTPenXh8i?=
 =?us-ascii?Q?iRX+65VirU/jIq6KyVMjShrUfmqsuGMfsGnjVvA3I58FrcG9XW6vZH3twvA9?=
 =?us-ascii?Q?jgXxfBu6E+Q7g50irkzU+/OWFdSxIWDVHXzPN99TzxJ0ee13A7GiojgSwqpU?=
 =?us-ascii?Q?2eWCk39XtW3ISV5LO6HD4WIoy0InvQJVnkEtng5euVkd0uAxxv91WROxGBcB?=
 =?us-ascii?Q?hMh3Tll1Mr39wrbcg8+qpDjeNoQv1kuDKKyL2raU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aba4389-1a8e-4983-d37e-08db5c3eceb2
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3017.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 10:08:23.3844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWpr08kPzoSSaPdZytltp6QrLVRBAu2gA40/casTtq7GshLbxST18Jc1l/Ddv60C1w4C3f26Usg8/HGrg1M8xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB3925
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NULL return of 'd_splice_alias' dosen't mean error.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 77a71276ecb1..e5a3e39ce90c 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -577,7 +577,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 #endif
 	new = d_splice_alias(inode, dentry);
 	err = PTR_ERR_OR_ZERO(new);
-	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
+	trace_f2fs_lookup_end(dir, new ? new : dentry, ino, err);
 	return new;
 out_iput:
 	iput(inode);
-- 
2.35.3

