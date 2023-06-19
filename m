Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5209A7359AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjFSOfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFSOe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:34:58 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2074.outbound.protection.outlook.com [40.107.117.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9CFAF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENmSI/S33HGExbOCx0M8SqVYNPBypVK5TXiAmpsNeWcgf7qLGhJp83+iQGDJ7dJkLrUhYpf1BwD2XaGvFp/Eq6FlCZ2suDq94lj2dFspibPdAQm4hiw409hHhaElO8YDd0z78yie/z2Lbdg/j6CnRLL+VU5ntQovyuisQTIonfLKkibCY49/QJKcJu7enKAXto1oX/fVnDBQX+9FcdjsgmTucsQcdzyzD2KBZone0nOru/WBVSh9qwktRHWrcQE+QUzMdFo5Duyp5H/zYiJ6gSWb0z5BDxlt4YLmRXlrq/KUwRU7MLObgOx9LMe8CLFpFh+/rpBrS9o4aBU5dNWugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWez1aR3D4yyyHcSGxyBeKUSih9rxiGPCSwB34G0c6k=;
 b=QryHGUDPaNyH3VeqKz//EozQuvsCpT4FpTqtJCyXR0G4JueBh9tdBqSUFI9g9XUzG1iIlOO8qDFeadfyes9yBtnfWv3ChmebsJYKMliveWU3kVujSbmPngz5QAiFNwh01zLaK+6+FbR8E7ifSgmVNe29+93fVuhtPdrHbWGZUkiEetUEYjtZUhU9brhomN6ChgRojbU7wBGt1AcwUeucOQkaLOizOeHq1o1NGziN0z3LX1EimhC7weC3m8qIRRh2xAQSduH5dGywdRWfqSDHxl1YMdOy8TdjJ9TQIk9C3X8IEtAmnDCxaI5WdS3gqW+fdahTF78TEYSxMj24h8+BDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWez1aR3D4yyyHcSGxyBeKUSih9rxiGPCSwB34G0c6k=;
 b=PYgbruJ+PIOQlJq0uFpAJO94ppcJzGnuOpeUjzdg5CZ99Eze7TZF7Si3zUXkX8S/VDQbBqQmGcwGKrusz/Ae6WDrcj9ROo0lDHRoxDKwTfD8x/0lEL/UPYyxKtPwzyJYQ8Pyt4Ovq70UI/lwBREL/0F5qECFm1v6ktzMCSTyH94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4479.apcprd02.prod.outlook.com (2603:1096:404:800e::7)
 by TYZPR02MB4526.apcprd02.prod.outlook.com (2603:1096:400:3b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.20; Mon, 19 Jun
 2023 14:34:53 +0000
Received: from TY2PR02MB4479.apcprd02.prod.outlook.com
 ([fe80::bc4a:4d7a:4c73:76eb]) by TY2PR02MB4479.apcprd02.prod.outlook.com
 ([fe80::bc4a:4d7a:4c73:76eb%4]) with mapi id 15.20.6521.020; Mon, 19 Jun 2023
 14:34:53 +0000
From:   Yunlei He <heyunlei@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yunlei He <heyunlei@oppo.com>
Subject: [f2fs-dev][PATCH] f2fs: update mtime and ctime in move file range method
Date:   Mon, 19 Jun 2023 22:34:36 +0800
Message-Id: <20230619143436.2105775-1-heyunlei@oppo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::23)
 To TY2PR02MB4479.apcprd02.prod.outlook.com (2603:1096:404:800e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR02MB4479:EE_|TYZPR02MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: e511e1e7-bc3f-42d1-00fe-08db70d25885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HN5FqU47W47zPVoRfKugIOPDKpkKlK8YbVAGVdzB6N8CnhG1LpioGgM7VfH6ryaGS10t9/9AiJE/er6e883CBhW2iCVSxGAAOnKsS50APJAlRaPU5t+DpQPblCM5Sp8hx7f+d7HVi+0F6q06oKjpsfWre1T+iHDoJvFhQbOlpQ4dlNPwn8HGAZb5HBHBHCKO0nWp9zbH8pJaAH7S0U9xN7BJUHxOgK5YY8Gp1sABu6UBzEh5vlmLVOWJsVugm4DTLqQs1z2ovNEDo/mZIBMUQcusUcOS7+oUGPiYL8TEt2KYB2lv6WGb2eQBFwcFhSZCFyJ7XD9umfj88DZIgK4nqS4hUdpvXSmFRZctmz1PzngP7RA2kMun295+PCXnVRNxz+fuwWvsLFjfqokfXSFnIjnSk1TibXAEZ6+v3g4Opv5dk6LJz+KZ9wOXY3G4ze8+wYdo47aUMSBKkANdibecNhjNrQPRW1JqeZTP8+DqKIQa/lT/fAZO0D8RCRYVaG71CkDGAFBFbXbltEbaghX4N4X19TH+9PdAxZsvhi7W/HlMcl8RXZoMAeO4zVGSf/TIFIAZzRU13NZl3aY3qR3E9Gunpk7DyD+sbfY8qJOv3HZVTBixFk6+w1P3AvdI1BVa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4479.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199021)(107886003)(2616005)(86362001)(15650500001)(4744005)(2906002)(83380400001)(5660300002)(66476007)(66946007)(8936002)(186003)(8676002)(66556008)(36756003)(26005)(41300700001)(38100700002)(478600001)(4326008)(6512007)(1076003)(6506007)(52116002)(6486002)(6666004)(38350700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EKqWaqd4vYU4uJzWK3fUvOX9TmXGqFotdRuAvO8280yIBqMuNLhgNXSAp9Zf?=
 =?us-ascii?Q?GBuc61ebo3wjpJ6eW2IWb50zWfDeL1EeVaymNWn4FH2ereDFuiTN8e+KKnQZ?=
 =?us-ascii?Q?jH9zUGzvN6Do7s+RFY6C4ZZqBRJM6R2FzBIJVn8rPyxgPVxZE1pAj70jl7cF?=
 =?us-ascii?Q?b3RWNOvZDwP6kNbND7qVZyRG6X067WmQKBUDacqeNQHGQSnUlI/C03NTDEWS?=
 =?us-ascii?Q?kR6+pIAPWYfaABAAOKopY9C3FDjg5xS2BMey0eYq9U6uttC2Z3lmTj+500IS?=
 =?us-ascii?Q?rkG0Q/c59xlnszxEx6hxvSJ/qdrq+Bc9E6pEPOP+KBIlGBfFvIjCpor3HRL7?=
 =?us-ascii?Q?yvW/0/nZyEukohSUvrtm60UKV6vVdBSReWxRKoPckiQgobMTCxv3nPP41Vwe?=
 =?us-ascii?Q?PLsiO/Ep4v3mq69yJfoHFh5gS3XXW0jj4BiwquAUPJ+JQOOoaYqYJa2fMFrD?=
 =?us-ascii?Q?qaQ1YoryIvstSHoBpQ5H+ndBnXVcHgCNvw1PirHMNz/vFZYCE/4M2tJRPHry?=
 =?us-ascii?Q?AzhjSUVSFO5ZdNbv0YeCg9ShxCwR83BIMabkbkPcn7Nic+78mSLmVgqDBUcB?=
 =?us-ascii?Q?MXzRLvpoRZFnZtKNwkNRtfI+oaaPhZjVJ1FjO1/ctPW8ffdiqsD0HHSFEgyl?=
 =?us-ascii?Q?EoIatB3TZFDZu4DMJtnK7buam8y2fYHQMk7tEhpii/CKhzQUyCm/o5a6nZsp?=
 =?us-ascii?Q?030VjPe1bVp/HRh5d+STEOQ3TF+68MDZS6dAzKOC6p44BWBtndvWpamd73R2?=
 =?us-ascii?Q?XiAmAifXdaAkTNMGbKywYctn4zMmDJRpJIt8klgSYj6tUj4dgskg2WoVfWIs?=
 =?us-ascii?Q?wp+9aBabrUrssZ+eftMDt59nG4TSKdxJvdEmy2NUKHm9isnu5GgBZmOQhUOO?=
 =?us-ascii?Q?MKntrkI3bJRPU2ASmG+OstLhJWJJCEeNHb58YI62jCs0cAosLNrIQSlt0lyw?=
 =?us-ascii?Q?Lqjr1hl294g1jp9VKYOBxHTtkjrg3OQxhBIRRBhONjJ62od+i1DTd1MOw4xJ?=
 =?us-ascii?Q?PQ+iI2VIBbxBdcFWjKtPkhxqEsKUMCKQES4bhaTAzXkql4fDy3SyyS6DiZSO?=
 =?us-ascii?Q?QeMVxLAipKGffZ/bWin/TdYGum21K8PSH/AAYmDOy+fpSt60qFV3PpQH3Xqv?=
 =?us-ascii?Q?05ey5pEICdJLeDevy8zi3hLwkqOEe6DLaLGFVn9NaLraqqhJ9P4PatdlTqVQ?=
 =?us-ascii?Q?H6xsoDW9oad4iZG94Gu6niV4XHJxNrZk4KlYNXV0ZjeQZEJes1abO91A1WVH?=
 =?us-ascii?Q?9sIOlY04i4PY3mQyxzpy8Sgv6JCv+ZkCLrsNfzD+nSO+pHpC7DycS13bULX9?=
 =?us-ascii?Q?1QWsaZhs8S/q8vJ5YmZiq2mc0ukguhxSBK0lpq+3YAFjbe8TCgpOUWXcKMhA?=
 =?us-ascii?Q?4rF5gs07vMAJUAk/aAyhhn+7p439dK4V3bPr9vJ1HMJJVaZrExOoS2phTRkK?=
 =?us-ascii?Q?R97q9UsDkm2wGrMoAyKmdDfr5gW445TLqGlIaS6WgOhq2fpX9q/SGiv0l2Ca?=
 =?us-ascii?Q?7USbZ91Hpg3mqUzrikCUg/9Eg/E3sFy7eBs9Cpvyu6E8Lk3CMVRFjYVRnlwd?=
 =?us-ascii?Q?F6dkNkQCN1ShAKmHdJAhhKnOEBjWVWMYAXFdQiR6?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e511e1e7-bc3f-42d1-00fe-08db70d25885
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4479.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 14:34:53.6109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InIl84tS10/w//wicsxoAhEtWFJBcz++0hx8HGl3hHzTVWZpOi2EssYE8gJpVHe3lHHjh4vJ+KtsAk3YmSGMFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB4526
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mtime and ctime stay old value without update after move
file range ioctl, This patch add time update.

Signed-off-by: Yunlei He <heyunlei@oppo.com>
---
 fs/f2fs/file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 34a6177c64a4..81e4b85fe805 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2881,6 +2881,13 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 
 	if (src != dst)
 		f2fs_up_write(&F2FS_I(dst)->i_gc_rwsem[WRITE]);
+
+	if (!ret) {
+		dst->i_mtime = dst->i_ctime = current_time(dst);
+		f2fs_mark_inode_dirty_sync(dst, false);
+		f2fs_update_time(F2FS_I_SB(dst), REQ_TIME);
+	}
+
 out_src:
 	f2fs_up_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
 out_unlock:
-- 
2.40.1

