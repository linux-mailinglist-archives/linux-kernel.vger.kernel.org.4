Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2566C517E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCVRAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjCVRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:00:09 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2121.outbound.protection.outlook.com [40.107.215.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3DE5F6D1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsMaX2Ln0gYXXnjF0ga8gs+GXleJJK4l0WAIaoA4t0U3ifLGRnY4O4phXxKDgkBuPBtTRnAqWiuBQL8yIyU/fqjDdd8obOvcef87CYTXYmyxvg6yYBt4q9P5VJMWDAn1R9X1DvD5Ame2A4RAqlVDz7S0NO8y2XdBA5TLJnK0ZjvvvxAVawp/uRNyp3bp8trCR7r2DKzKh8hDEmXrgLr8pUjXRC/hyo72YepqTVGPs2jkuVG7wi7XRElc1Yoetx89R1/2eqEdLGoHC470Sh44yfmCw15aQqjv6zcKmzAfwFgkhY9IRqh2kKSeJWBNSsUwRhsNulCU3ksdNh9DhNJw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNtRww3+WurnR/ssb+TOIf0NNF1vkQf8qeCiNRBrFJo=;
 b=k/SYhU3gLi0qHoKU1TXGJnvg7/nSZ24jc5nEzXCVmfZ0chm16oKfAC0c7wKrEwvPHvOuSfCum7S5A5Y37aLV9x2abNEKKORLm14IfurjrgPUYTW+n8ElYdF4zydKPT/HUrTiDaf0R/xGhnWzVzd0JE7cPwTam6844KdEb6vEfOsAFVTYxD/q1IRwfV7iRNWe5eeKF2VyAg+tbiUlr/54VXZzaSMC70OdJCw8hB25+RYvY5xnEuy1vwh6++qKJXruuZ0YaW/JI9BwJUkeqExsw0VD0oQp48QR+6HgPsO1LWfmim0yggUUymfbLGm2yFI+P80cgQ+ko/t6uLs59DinWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNtRww3+WurnR/ssb+TOIf0NNF1vkQf8qeCiNRBrFJo=;
 b=XE3ghHas5VmID4ddZIi6bW7Z7mU5WN/ugus7njcwadlqp4TRads8EjFFplE+aO0mhfeenX1jyQOgTs5CZZkP27s5lhBPDnumPYMlcsjOPLpyy2++7KQeCzYOJtA4VaWp2NkKRWPIwS3DwLbW1T83RL5/7q4sQks0g9hiAgLxqNwQAupwa3php+iTpnDYvUOTELF+auI9GtNSDLkPhHiBRWuHs3odl6WpmELt/Wgx6v2p49nS8jiBZAz3+Wb3FzSB333EhxSszOJ9BU3liZDu52+raLyLpVHgO9U6+9ahNwMkybVEtTCpEzThoFIfANHeS5U1GYqKO0+zK4bTByaW2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4107.apcprd06.prod.outlook.com (2603:1096:4:f1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 16:59:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:59:56 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/10] ocfs2: convert to kobject_del_and_put()
Date:   Thu, 23 Mar 2023 00:59:03 +0800
Message-Id: <20230322165905.55389-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230322165905.55389-1-frank.li@vivo.com>
References: <20230322165905.55389-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: d746dff5-adf4-4331-1bd0-08db2af6dcc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkDIC8842PqoQRUBIHYym9rii+8ZFNM7C7EYGZCPuyEDSdmNs6huNFAyw9v7yGp5Z34ImpDdWTGHkDyH5uQRUZu16SRMLxPk/sby3FicdG3ebwSAeiQTl8MMMwzi63jgKcaEEjMubbsv264JGSVUVFB21gQQWyL/p82wGGx7TeaPXf6G41Zzb3MUKQIw0GAQPejcxgVhTBT/LksgzSk72IxstEaBeVcsUpkgRsr4/DDxhErNPHzMOC5SCdYgQBrYttUX3vtfQMxODYbX7lkzX6dolycIX1XL/2xE+RH264KTDIrxtztTLbwJfkW+ukyUkbHqpSTRtNX0rZBglq22b0y5C85MLzGzmdGHGiY9CcJR7vLg8moHQKnrEOsZ46RdzxYZdb3fBMH5i8uPS1j7d3Yuy0wtmbCzc6Z8/IJ4EdnEThZMTRd5++Fnz7otGnU7GK2ORZFIYzG3d+vZ2fIbrCdQXKYmXT9s2qvD3kOR93H+EE6JroLl9oq97pgSGcp/yJVxH7ZP+8UNr/y57LTiyTDEpb6o1m1b9VyucRh5E6xFyWpehhSB4zQmgx8PvWSkpTe2DgyhE553osckoUnFuvAMrfGG7G/FOw4P3lXabUceWi6q4J70LQTR6C8920MxPAJyKaAe5zbXuvlyDIfiQC9bEQQAU5FyxqUkE4ZKp0+5pPcYug/muJa055hb2GfJ50jah7vAtuLlyA+D7qWFag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199018)(6512007)(2616005)(6666004)(1076003)(52116002)(26005)(478600001)(5660300002)(186003)(6506007)(6486002)(83380400001)(316002)(110136005)(38350700002)(38100700002)(86362001)(8676002)(66946007)(4744005)(54906003)(41300700001)(36756003)(8936002)(66476007)(66556008)(2906002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l1+S78XpM+CouZwXt1Rk4latGQCVLb076NKHd2zuNPYX1hdzVsV/ZWJHVZZ+?=
 =?us-ascii?Q?FF4UnA+okT9atxx0BDVVrwnSxh+X6SvJm0GSarID8qfoev9QUn+jVZJBSfxT?=
 =?us-ascii?Q?dPy2hNw7WJTib0woPJTWDDYXY9fY8EyO7sN6tqwDpI5z7KuclKwL2eROi51w?=
 =?us-ascii?Q?FteaLQ+tPd+6y19SEzTo/rtil/yPs869jPM4GsW7/8Sn8N/7fpVw5eeRGlW6?=
 =?us-ascii?Q?7GEoPSBS3TWlv9W3IV8bhkdZXYSuzVh5QMiZngPFh2x/9htmmP9egBJiBEST?=
 =?us-ascii?Q?RE9rOTgG94kmv8CtK4dl7Ssl8tTJ2BSrROpsr3BgJSAp5YFCJSzdH8ffg/i1?=
 =?us-ascii?Q?VzciKpPpBl8JvGTlDdUGAKXDAqmJDw+wIsIveUT5EdMxsPiYzJzeWDsEomru?=
 =?us-ascii?Q?8Idv7mv3yCGt/Vmj1Vv5EOBRGcKh9DtyOZsJZg1zxallMKst0ZMFFQFvacqe?=
 =?us-ascii?Q?iHSl3zHW+hdbefC94JiCAsh4D9dpVX2nR6zOLQT55q2dL9vkMgmIewUjJOjn?=
 =?us-ascii?Q?CFOTzmPmGMY5zRt2yBOBRDi93QL/7WOcc70WXFjKt/45LsHeoEn31Wc06NGl?=
 =?us-ascii?Q?wax7AbuqgMPL4ktnywZsFXg7dE8o1MQpXBFgT2hxyEDmYLNs3SP0i1S/NYI+?=
 =?us-ascii?Q?M+N7CaX+xzuiOtcsgBbSlsH4rkAsdyJmgRMX3skpHxwQyQHG2NzNXigb0e75?=
 =?us-ascii?Q?5Ry+wQOvKf2Bmguy8yck2dlEvN4wj3oLuMXVgwz7DvXnw/wwGUJLI4aaSZVI?=
 =?us-ascii?Q?Lga692XsbijoYKlyGsnUys6bCSdeidbo0p7z+Y5unUltQqv2JYMegBaMlQT6?=
 =?us-ascii?Q?JNeOLja3cRZHEPN2fB/LREnV3qRVijXDRDjAX11I1vNH4LhdX7A9/Eu5s8Mp?=
 =?us-ascii?Q?icE3JT4hcmb439Wk9uW9aW73W/8+8jtcqpMu2o71Z/T34ZFdprRWWVob0wQk?=
 =?us-ascii?Q?lWR5O7z91F7fIC13cz+sM5FsbGfK6n8nE7XxFloaLHg6SYGOzBnaxIy/10RY?=
 =?us-ascii?Q?xjbsRGrMnB8nMDIY8Dq/Lsx6V1Vi0GoG0lH1rLzNMx+cmYasbw1Rbot/d6Yj?=
 =?us-ascii?Q?HwXpYuDdV1s1jhXB/Knw2CfsW+fMAQJf2MEWzAyNZh+ei1cmaI90WdL3RQoi?=
 =?us-ascii?Q?YkpCyHS1YIttWikg+vCNzTDBOKFCQ9YvQ8yM8mqhnJr6BqNcjkt5JBJGvhW1?=
 =?us-ascii?Q?fW+mFhT3vjNygl3S9omXfpOl0X3uLQHvQcBLfd3k5SdVvhpK6JxMSijGVhMY?=
 =?us-ascii?Q?vZOatGirQflXyQzGRdpWCj4gCLwWZrpPoNYYQOat79AAtHjfx2PltgkfNN5/?=
 =?us-ascii?Q?cSZMomgXbns0MU6yYzaQeIo5nAQGnb4i1L2rmuTvH0bNPW9qXK0v+xrdY0la?=
 =?us-ascii?Q?+e3RjzAFRkl9mCudh7+I7PuPZXzy18qeS9kqcQW/29f1llTrZzj3svuGYVj8?=
 =?us-ascii?Q?IJn/mrBCOvZJwVv4HlGuxds6nDiGn/TtsQA0NiA1zWwNo/zKPeAahG6eke39?=
 =?us-ascii?Q?IejUeW62COxAKc2Zo5xqzyhGqPmGVqKP9nutwmxTixXamDvBjQX/PpeMHoQ1?=
 =?us-ascii?Q?tQ+NsM2aosrXRfnYbSahAQr0JIzcN1F6QPBYbbSz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d746dff5-adf4-4331-1bd0-08db2af6dcc5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:59:55.9783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RU8g0mPqti4noxp9nSPQB0Hjooh+40B+95jx1t/IMrf1d7CeYJUgXSjwJPGzDcsH4tspViaxVh+fb+YCL6FySA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4107
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/ocfs2/filecheck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/filecheck.c b/fs/ocfs2/filecheck.c
index 1ad7106741f8..fb9cf601245b 100644
--- a/fs/ocfs2/filecheck.c
+++ b/fs/ocfs2/filecheck.c
@@ -198,8 +198,7 @@ void ocfs2_filecheck_remove_sysfs(struct ocfs2_super *osb)
 	if (!osb->osb_fc_ent.fs_fcheck)
 		return;
 
-	kobject_del(&osb->osb_fc_ent.fs_kobj);
-	kobject_put(&osb->osb_fc_ent.fs_kobj);
+	kobject_del_and_put(&osb->osb_fc_ent.fs_kobj);
 	wait_for_completion(&osb->osb_fc_ent.fs_kobj_unregister);
 	ocfs2_filecheck_sysfs_free(&osb->osb_fc_ent);
 }
-- 
2.35.1

