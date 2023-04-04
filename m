Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B688B6D658E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjDDOix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjDDOiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:38:51 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C874E51
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDlGjzFwJDt0YDM9j0k495bhufxysqrRv4oXZZJzrhKuJ4nLr/et5z2ws3/QWpzL7P86JVCNuYkpN3t6sFiWdWa/jeHgkhxD/YRFG6RmnAjktZFcDa8Kc2DL1wuVD1wqanVrVtlGX8MkWs4ghWCITf+YhvO2t2Qwf+j/aePzcB4L85MGnSULaLmkk6T+fYf76bdN6Q0Eg2JNBs3J32ux33SgivwWZrBJAOo0Eqlj4jKM/moAhkPWBv7ThF+52i3UfIlO80FXCqZoX8GKEKduezGASE66zhGa51l8zPCNkexGKYOI03U0j3QjUbmHmqTLOMStuDUnK+ifaZdefjXLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUetdZrDZs9U0PZAM+RGHLLjWMxadoogoOp+BD749nQ=;
 b=nMjYUu/srsnDFtYT4vwL9Qn8yvfaC4fqFJAFpi6WwvfUBMJ3tjLOsvCQcFiraDfBFwQDBgt202SHb0yd1xA94iUyX26OMwYGMIUfU/taFpzUaW/nSaWzcMnuq9GkrDWB8lzsSFDxmvvY4PUb5vnWfBJ6MoIV8c1Y/9TpFzB5GqtPa/bKY+MYfI3fmIh/HNrzs+atHfcPAtz4L0L6r5/1W3ShE4IUgzcVUEUVOl1jJFoAdYzbqaiY8TWXjFsRurh/ouIgu36NkJWfILK2qxVODaI6eyLi7ad420bW1dZsufxYfHvuq7S0snRb4Geehwri/huM3oE/chahwErtqXOvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUetdZrDZs9U0PZAM+RGHLLjWMxadoogoOp+BD749nQ=;
 b=QGnu6K2XZZEjg/PI4DneWyiKaCQw2W0cimMha1AMwRrXvBu2fl0OGU8Vc867FlJbtFGMi2Eb8d1ZLbRI1Nk8E1IuKYmaPIbE9COVRhA5ifqclEYnjdrDSseURfD2OADpGO1iyhr/pJ7Cz6cnECVEjpRi2uVZvRLKy1lLKRqCAiX5GW/4F9nH23UGX86oEU1X4hQNBvPzA1nHc7QGLYZPsWVeghBftovJO1WUPtpRflN+8HPrgLik3qhyYQVQaxI1By6JWd8gYMmngq7u9NNcBMHCWZPPyUXGrceigUc1sIlt9VUX98xIZYPMstagTCtzDAVx+VyfH0SjgpOAN4H2jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5354.apcprd06.prod.outlook.com (2603:1096:400:214::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 14:38:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6254.028; Tue, 4 Apr 2023
 14:38:46 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: remove batched_trim_sections node description
Date:   Tue,  4 Apr 2023 22:38:31 +0800
Message-Id: <20230404143832.18234-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5354:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b93f20e-90fa-4593-fb01-08db351a4b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZciRhES1LRMzUKGQpDbWaQHgHONQTEZZamb+8UYY0fAAl40Fx/cXEnL2402EYZ3MK0e+GKk33VJHXL11eNoaTglXFVHJDPoGW9HbzhCYgesA37r3T9UogZnSD6xohXVk9TgVFzxc+sQ0JcOFXEwITklNZ9N+a5GzeJzWMUbhshx3qM3FjURgMF01CYgyDMOS1PPg2Gr6Q1gO+M5qj0M5AyEkq6TOvuxMnGl7nYNMu6CthluVfM3Hs9gyVh1mae5bAm/D1oNYBv1ii1SXJ4LVafiNLXFrrO1hMy1f/kdGEkmMdjmbbRjDo9AaRtVChh+wCmxS6YxG8tevnDm1rPQHYFKqPUSkepplwiVHoz/l2pqKl70F9chUCM9I2XTvtWCviR8RFKHuxsE4wcVXQRhbttKXy0eBnFwOKNGYVukH0cn1XN5uHXhEzx2fsxwVTqJ5lkZMzM8vNFf0V18P/xgkV9fsfgIZ0E4VflAMEmmQD+D83HnWs2hudtHFQUsruDO9kIFfw9LJvkqaZnqBPd7a70fnx06Af50hHMwSr3WeHdulfBbP22P1E5VO0YqcBNB1iwk5CE8KX83xfbIg3AsW2fQXgQbc4ni489vYD8oEF8+aWRXhBbOA7RqwonaVnGh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(26005)(186003)(6666004)(83380400001)(6506007)(8676002)(478600001)(41300700001)(2616005)(4326008)(1076003)(316002)(110136005)(66946007)(66556008)(19627235002)(66476007)(6486002)(38350700002)(38100700002)(36756003)(52116002)(86362001)(2906002)(8936002)(4744005)(6512007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m+nY+EbMNFMZ9fKnwlAIAYWZn0yHw6/HkDKywusc9YcGL7j6JeBs7dW27CZQ?=
 =?us-ascii?Q?8V73THsbFNxQcKFxKf74q7pbG4Ngx6zsdzOVIff4yVxDp2hTpQKfs5cRBSX+?=
 =?us-ascii?Q?8o6xetV42sgYm//0fwY7YdH6UHt/RzcLVgskrULnnYotmo/N0HKc+6EC7Niz?=
 =?us-ascii?Q?9FOjOOaVIzJAwhk2Gdh9UYj4vZF9DdAqQ5jWR8tlVqlVyVxjza4S3JQOx0RR?=
 =?us-ascii?Q?VO2wJU0DluOpwhHdN7++XkVM/Po2WYetdRg+iJMaVS2T7Ek6fZxSWeBy6Yu5?=
 =?us-ascii?Q?wDTVLUeeBLqER1XaIb0A52k11qLx6DVUFBQkNu+hBP2OxsopMaO3CvmzhpO1?=
 =?us-ascii?Q?NoIPyYUSYHmLcKAsMIvl1GYcFF0YtP/8U0QBh02cYQcA1VcCnJArxgcikW/s?=
 =?us-ascii?Q?QauPYhhtxUlMXCc5Cfew4cV1yu2Ktr0lAzzM3qaq86qpU5m/cYSZDWU0CiNZ?=
 =?us-ascii?Q?7fnuBjzi1zBPug8K9H3BZJoLMjUkuyh1i9kYrWOmILBnvG/5z3kntlBMM0Oy?=
 =?us-ascii?Q?XHDcP01p0ifLr9ZXFgdRXlRkA5YYnriatg2aahzyb4Be2Df6Lh3kX3Ttsz1c?=
 =?us-ascii?Q?hNwBDBK3seCA/ABsPBQi2VeY/OYiE3PJZAyiD56NBe+G8EGdzUe02mO1bMEn?=
 =?us-ascii?Q?Ie2681erGXfp2CXNnx4vE1Rw7bgflrFvnfBCIGbyrssgJi82ifoT0lS1aP0F?=
 =?us-ascii?Q?ke8/sGCWwrNEiyVZmIVgiih/JBbvWldmWBa6blfoGU4GqdJVXGhnS1JHuIQl?=
 =?us-ascii?Q?tCPZnwItlndk5hLWk+IyLQvDCv2ZvqgRgBcrQkyln1zCRfb4nEGyoPkZ90tq?=
 =?us-ascii?Q?EsyyC/x2q4i6cyDHRnZHPzkTEjfZ+1qkhKTc9gdTNIrqPX8xqZNMLZ/3dmbw?=
 =?us-ascii?Q?zxryJZMa0u8iq+11GHlJN7MYP+s07ECNL0HMAbvlFL+nRTNg9vtD1Ljw9FPf?=
 =?us-ascii?Q?7JZxziAvOO0f3096f8oV+ObdonlUPQv6xcPtZkfCs9vw/x9YOjhhPl13TQd6?=
 =?us-ascii?Q?4AuWfu/Phc75BKrrcckumEhl9tSzvBoYWtaQd+qP6/NnXyuicYwjF3R7wqxH?=
 =?us-ascii?Q?SFMF8B9qffesWu88GYASzNp1kZxKboQtGzUwKVTvV382vmiqv1Qv6/cW9QPZ?=
 =?us-ascii?Q?nxlpQbEgag74JYV0JraoEyZujIj+BtWRTEEn3G8f8EaQIYntkspM0s6aqh88?=
 =?us-ascii?Q?fxdpUl0+qlbJfhO3N7uPoP3XWLDQhcMshAw3TdE1rXoFUF6kjw9GcLUSSHOV?=
 =?us-ascii?Q?N3gku7ebsVaPU5XxcLGr0x53xNOzOKXpge6IhNZD8eK1Xa5m8y9tKNLVq3HX?=
 =?us-ascii?Q?eImwqbcM6/ShY1eedt87/rz1PtPUy2eahsmFpDGG1Y15fEyyRZERvo0VWPvl?=
 =?us-ascii?Q?LC/S9hFX//kAdMbi0ZkCxO6mhs+EWKgET3Kj6tL3HIZoqjM0+6Me4hTj9sum?=
 =?us-ascii?Q?0mTpw7PDjCSEJ4v6A7tjSRP25vbtpSPz8CA+wIUzkZVO11v0qdWPnR3DoWer?=
 =?us-ascii?Q?bfb7atuQZ7amamNYXRXr9JCHts7Ck4nj7qj1Jw97iQvhQ9vYpxZSPHwBBYEx?=
 =?us-ascii?Q?uu5T0irtCHbCoZJadYrxDP3dQlXom0ZzgpBMm3J9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b93f20e-90fa-4593-fb01-08db351a4b89
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:38:45.8385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyiwZ2gDZD7Io1bCLSiTDiD6lPX8FYhlAKFWi/fNRjxNAUkQH/VMiwRwvNH6wVtZNRPsGV8h1XI0d0v5cYidlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5354
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's deprecated since commit 377224c47118 ("f2fs: don't split checkpoint
in fstrim").

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index c1314b7fe544..8140fc98f5ae 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -190,12 +190,6 @@ Description:	Controls the memory footprint used by free nids and cached
 		nat entries. By default, 1 is set, which indicates
 		10 MB / 1 GB RAM.
 
-What:		/sys/fs/f2fs/<disk>/batched_trim_sections
-Date:		February 2015
-Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:	Controls the trimming rate in batch mode.
-		<deprecated>
-
 What:		/sys/fs/f2fs/<disk>/cp_interval
 Date:		October 2015
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-- 
2.35.1

