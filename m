Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D129B6C005E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 10:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjCSJ2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 05:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCSJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 05:27:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2105.outbound.protection.outlook.com [40.107.117.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9F71A484
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 02:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mw+j7bkkDr7BzNV/FSM3E1G2qrTLcqFhqGjF/WCMBqXlVPft7MhnpfgDhXU1XAlGkEvvc3x+IdzBC/fNKaj05azGGoyookcE2A73WIT1aDgmzkBZ5QV4hphMkchFV2VtYRvTKGhwnfKaZxIKnM4BiPO+fKXwcD8DnHWSDnvFlsi/Kt2kcecfTmYWcDECDvqEZkGzOEf464l7S8kOUkm6y5Ur4qS8UFSamrGUEp7H7jy7fg4W6RojuXZL0TSTC6giBPKaTk1YeROj7VW9l5E/zr5TZncc+z859+alOMIlDMInixtn006cefgiY/OyUmMv8bISmoHJGMFqUjsYh+0nhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hls3ELBTfAPebu+2KYZozBFgc1+NwXVJaxIp2fmyeL4=;
 b=oX/5Yvtfo5qgoF9IhN4cv061c/yU1WBJDtj6MGFe0DZLoGrwhMlpICLSfMAYlMTE5F+wPgeQP+hHdjfo20pILdjsXsRhEAu/hGN0duRL4QqYfOphFBWg+DTCQvFGPg753KpXv6J3bKZZHqtIgyMpwnfPWfAynQTL4yxa8E2rYzyrDSKnvsqphSaVXCo0QbOvfo7fxmfLlZ7CMlpxB0SCQ+2EqkwBHG9BU9AxXkFwzST8ZOjOtdvqLMlPiV2PnrfvXfBuOX/fQrnjKTPhqyy8HcKDz6PWi6MagRNuUG1Icjv8/DU1lTu2SNdsqQFXuSzH+SxXVfL3MOU0zXTR7owpgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hls3ELBTfAPebu+2KYZozBFgc1+NwXVJaxIp2fmyeL4=;
 b=AdusP5DMXxj39u9WzxW2k06xK+ds6CzkFg5fzaODk4NmnoziZkQq4kairmMkEiqSEGw1yu5BpPTb16URyhpTjaldENCx4NQ6j8TbD0fYHrDw8aSZh8X/XX4CmMC4ISnkO7UuNFBWEeiyeb37YzsEpFR1Gsaz6bbNh2WwT7BazTVJDZhNxI7p4iCykhmMdjw3YZWYJOD4v2hfaOWhxIfnHy9wzPf5CYrXQYlNTOtFMRqehMvw7btPukAvAwmPbQynRZku/Z3r40iD0C/2IFAXv3bP6voDDI6Ysu7GND8fjCFcExYjqko/f3AYI+OZMIveph6XREbDKFtnuzpREwPvJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4012.apcprd06.prod.outlook.com (2603:1096:4:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 09:27:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 09:27:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2, RESEND 08/10] ocfs2: convert to kobject_del_and_put()
Date:   Sun, 19 Mar 2023 17:26:39 +0800
Message-Id: <20230319092641.41917-8-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319092641.41917-1-frank.li@vivo.com>
References: <20230319092641.41917-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: 5488fe64-967d-4777-fe43-08db285c2598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kB+NjScSeuCcXXqadgKmgzjfRup8SXEggCkOBKCYxNWB2CCTjV47KY2jcMT9eVQHUVU5LoWDDw6kkCKXp2oh1eAD7DndGmTSWQQBGVna4hDSczA4ZrNDKA4EayL2aSo/Zfd1DwVP7DF5Hq4pJpDVeAclIbG6l00AdRLW0SPqCOFED83eqq3EqauQGha8wq3Fxk55kzunNNtoj+5JuUANhKZeP7Vb5xGhF0evy1rUb0yjnFutTCDJyvD89ZxwD/lfQ01UjtIYD6N+M8RsRG/7C23nF/eU1i3PadCsarzdvR8VVy845bRaF/kZC44sF0Di+ycDkfu6IkXtYXvEpRdnTcTZEZndCs9C3NgUX6yEDgJZrxldh8JajbrZygpOkHGs84lG99J9Jamuih/LE5MDjeL7hv0zPyfftlBNWzIfNnGsgjD1VmcA2+hHz7LJgwMq58i3hT7tALK/kW5ps8GLHXIW3dYzYkl8cwfa8UtMcDwugIx7rj7DAKjmm6CiZbSHj2nnQ2jw6oNM4isCc6HABBxozC+deqdb3vuBMhDcfrY+/yvkc6m8mr+Y4h+7TdoiCgAsa+VQkSgciFeHETAF/YWZJRIA8Wf9x7u3cS5oilGbI6KHhKcl8DdegoEirYxZ3CRa6IkAzuZYa3ehT/IZN2+ZwG5/57dJ5X2H1UgfflDpPbkxoGOUOq16IdkuSJP7RLVlVkNx8UlHWAKqQ78aGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(451199018)(52116002)(2616005)(478600001)(6486002)(83380400001)(6666004)(316002)(54906003)(8676002)(66476007)(66556008)(66946007)(186003)(26005)(6506007)(6512007)(110136005)(1076003)(4326008)(5660300002)(41300700001)(4744005)(8936002)(38350700002)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MsMOPiaqI/u31IjWiVCLfrNN6rgv5vXfdVVxDm2FmI23bPXOX/46rv5aoGtv?=
 =?us-ascii?Q?m42AJ6UqXgmRhdT5sChI0JXH4YFnyoK1o2PR892KJZIGZk1/XkLlTslV7r6Q?=
 =?us-ascii?Q?9NIdRZxlUmOR1kgLHF3ejVeC4S3n4OK8KX42soxKcPE4D9r8y9HzfBjBdGIF?=
 =?us-ascii?Q?j8xEwGAx4DXGrpZiw6opxI1rqvJK8zN3IK2kDNYugJhAyneXNj1GvQfCz5lT?=
 =?us-ascii?Q?bNhltrjvM2OgUyzOwmDQQbFu5cJ2DbhrPMdcAfLi9eA5QtJTXIytjRmBrEY/?=
 =?us-ascii?Q?mY9p3T7pLZ+WblUyxO1JrKR+maR41PXeHXGobeBfkLIX48jPvQdN2Jj/wBv8?=
 =?us-ascii?Q?Lc6l1VtY16kXIiWIqZoN/V9/QHfUqlyQbZEXUCjxFaEbQz+FZ9QH65BPq/dq?=
 =?us-ascii?Q?q8Rgm0Emp6ix5ivFaDaJC23OFhEQZKzrsvKxlpLRh8cektsclVE0g3Q8A1Vm?=
 =?us-ascii?Q?dnYFov4wNKFFCaObBIph6EERGVH1wTNkED7cjEB4TWkJQCNWkk3E3KIjEg87?=
 =?us-ascii?Q?ShuKDeRqV3CY23XKkK7ekGVnB1FXz8lP6OSC551kjwGpXF+kDFyb8uM7GC++?=
 =?us-ascii?Q?SYqhjTA3WzensQq0dK+IuUYLkTnP0MMLW5a92799BN19K61otmeLrsOE2K/v?=
 =?us-ascii?Q?MQm9lNPxapbWoIdKQrXcSsClYZ9AkBZmolLfxC5gGrOg1DQzb1AaJd6Ra0ws?=
 =?us-ascii?Q?/DejUB5rQIyhEuAqaRQet/e/BRC80kPKPvwKZj60C9qj5Zz5Yc7Iu197TxcL?=
 =?us-ascii?Q?7X0JyVCa3uoIxZ1XqEz9XkGMH2CC6gdzRAGYzqrWRGNil8Iqxh5zIH0rlGt4?=
 =?us-ascii?Q?QXYtN4UeAA5MLfnlV1WPBCBz9Xi61zpTtrvn+d7wBU28dzWug22ULQFUnAtP?=
 =?us-ascii?Q?jp8h0YGarNWsE/QnhF49ztAkVKr3dPlQqXFeCfPFSPUwMuCPSpT+ZK+ESlAv?=
 =?us-ascii?Q?/hu+POKfDtpGujtcPZRHVQ5zL0T8QVpftb7EvgcutSZ2syDEgPYTVeQ1ieoV?=
 =?us-ascii?Q?4SnHgo+uD8vhPei/z9Avn6JEnCD5DLlSXzCankwffhA0/WbPxvK14SM3oSzu?=
 =?us-ascii?Q?pQ/IaDvPHjY6T42bhDtbmP0kmh4nlGgjOx5dcE8QHN/2bUo8KVsS2vjj0cBe?=
 =?us-ascii?Q?S0oWIxeGtiP8ZJQn3pdy9rYBI6GazZeHpEWz3lN+HkSkpJXFBZWu+udpgdah?=
 =?us-ascii?Q?Emcs19UpCTDRfYIMpJF9tw0+WyYj7HwLKg3AK953m+7DSPwYJYFL+CS8EVH7?=
 =?us-ascii?Q?lu5E3X2d2Ik7ODhYNp0LCpOs7nf5lPemZXR7kjxCQR+aNu+KLP2gbhiSLnMP?=
 =?us-ascii?Q?JSMHGOcqButvePk0Co5INGXOY20c3rTLHLFpBb1P1tmPW+cIhQkZ/xf4xNSQ?=
 =?us-ascii?Q?kifiwvjiqDJTHjjYdPhXmaxxtSBt8oK8YRp+xVZiDcHD8fIb8YryKnzg7Qvp?=
 =?us-ascii?Q?UhhK9WVW3rGM29jLOo4VURJUlKEco6mTNv02rBo6VsSdHF7hgUvYNHWOre/0?=
 =?us-ascii?Q?hdDSO/2310lUfa6Gkm7YHjJcYmzOMyyPb9BoHkAzq8vWcm32FHGrFLy06DlF?=
 =?us-ascii?Q?uk8EptsYoQJW7xZ36FDQqU+eBFvph5cKCplug8WD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5488fe64-967d-4777-fe43-08db285c2598
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 09:27:23.7661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1YrRh/ffdLb0e6vs+HtYh6XCLIuKCevTIpq5Cdq/MEZag904R4IXMGR63SWw3iu6l/I1iKMncwbcqWTV+5PNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4012
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
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

