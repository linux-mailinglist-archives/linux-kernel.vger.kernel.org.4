Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333616C5171
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCVQ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjCVQ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:59:35 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2138.outbound.protection.outlook.com [40.107.117.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E7243904
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW1gh5Ct73wMkwssD5EM4HM1Py54l/c6vqTYpIuWYyxpf6xLYq5PQw1n/HTDrsKTSqn/71PnWhJH8vqQ7eMxGV/dmFxrdT5DmCrMqCHID0WAsqEUW/jKMlmSqqM8fvxS24E2xuohURTINVHZVKMWSSxt6d4RUXb2VvxYtsipk3gylyIgOoFX7DTtd3yu/OJKPDporsj0Iuy2798f6NqfBvLMlIENHiGkqLXJze1R/6F5il7ddUlSNYtQ+u+Ia0vEptjxRj4TXbYRbCGSf7gk5QgNPCIfZtC7nyV0Gl+eeUVj6S3eeJF4ouE7b00viJgJHCRvyo+RoJNZJRAI1ZYnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX4N8DgWgxcksV62oYRh79eSYh7nL6ePu6WISP6rzL0=;
 b=WFRs9USX8l9ErnVThlNjQjj7bLMTiwFqVuLdi/ef6JfDnK1k6/IDIXrg2nwreTL70K/qGFGD3BQUEcS392qKuebVJFPmaQsFkXQKNy3PAGt5/OSc6glXxvschwzvlwwDCeQ/hzcVUxBXxgDszOLEKgZSXyU249sZSadMN963oK0hN+gMteunrB4xNqhrj9+CD2oRWSwVt3TX7fTtQ9cPNgG+vYK2ZOiH+28cgSzo/Us8EGL8HMCWrWWUrPt7hSjO8qZlE/s4zcFB7DJ8quCtKBSK/vqS6i1agU7c6hM/30Yzy8wlthblsW4lwvmOpD7ehWv80/0D2aehc8jOrkM+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX4N8DgWgxcksV62oYRh79eSYh7nL6ePu6WISP6rzL0=;
 b=cOQn9vgNtjDVo3otiKrVw5NH8ytlY8RJmknoys1OciMIoo0m+m7p9kcVmsFb09Bidmn+2rJ+O3eJUCFiDNsjePTmL0emi843j1RaV/tTh02Wt1tZsH4fXQzlUA1GsWcgGowJiUi7+2suZp6YA8CMFxjvtlhAYaYJL9DF43uBgUGpfwt98VsGDSN1W9EuXeT6U3ms60dioT5vwRr68UaKMpI1WXJASqUFoHVlsXbeHPT79UP/KxXFFLNCwJbI1aH83fRC1e/dmK8N6QEwp8PFn49RizfogMqVwrWvMcmUK8Iz/VVMgLX1AMZiDa1YlkY4B2mJTffSeQjmDKBAyCjiiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5238.apcprd06.prod.outlook.com (2603:1096:4:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:59:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:59:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/10] f2fs: convert to kobject_del_and_put()
Date:   Thu, 23 Mar 2023 00:58:57 +0800
Message-Id: <20230322165905.55389-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b51b13-7de4-4a54-0d8d-08db2af6c6be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8oGgEjtarj9UwgRNDuVW1LH4thdLuu3lsIP4cOxXAzFfXPfLt43NMUm2GObDIvXlgSa9E6OXfQvWxCWEwG4lxcCdW2VSV+qHl0ab+c18LZ39ad2Lms2KV58JWmgmt4Z11VEgHNFSbhifFLc6CRo1OgIRBkx3kA456HhkAM9mKLEA8txunaB19zrK3GzUherZH7y63nOujojfCYiAcNim+q4VqRSHUGxwfI2ryZbMJ9tIy5gaZkczOmCNDxSgJJHerJk9mYXPLZ02JI83hAzcv7ft/U3VwHVB27nVW6r9IcagT8+KQ+jV/S0TsKktgiDxKOUfLe95pv4JTHGV9k780xdDuk1I4jUP05UZzQmUaahMMtTnZ0RA55w9xzLPoiSJVEcRVMzvxqYJOu6hWdAMqzmChS+y+dhpqSwFNcSAQL6X4oTAx+5V24y+FW+v4Kko1HgJodFnsLl3ZoQQIkZyYJKQwKT8bpJZOHAH3FTFcUrS59eTDJqoXx1ryRnjWCWoDLDXD/3Dz58AaDpAcMDDAJ7f34Y+vpLwV7bG88e8JssGUER/CnG2mqGgXP8K1Sv5YWxYWcP9ltOsl+Uka7opbvao5Tbq7A6RKdIze0A5GJmoWggMgj+CowjWwQqrFB3t+IMIFhafmqtekyfor0FwtyzJHd/wrL/Gcp+fn9uwLVf6u3scUcSrEkMozt+wZwiwEKsFUNRFkquB/3OnkbDEcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199018)(2616005)(6506007)(52116002)(478600001)(6486002)(6666004)(83380400001)(110136005)(316002)(66476007)(66946007)(66556008)(6512007)(26005)(186003)(8676002)(54906003)(4326008)(1076003)(8936002)(41300700001)(5660300002)(2906002)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2SuS710xo5cwPNs+eMsmsHQm1GFgGOwn0yovemWsrqKWiPlklfggxy1TrGwC?=
 =?us-ascii?Q?L2MpZsEiHTRobi8/voam5OldcrKZ++HF58BsJAbLWZNxspmQstkzi5DUyA1t?=
 =?us-ascii?Q?Bn53nagoxuh16eDcV4yfritF/UeyoX/wq/2Uo7Tz7T8kzsLu06THK65dL/7O?=
 =?us-ascii?Q?NMtmxhUIjMDVXfL/ovTYTY6S3Z6zvXvXvNGxWp2gx5SsgQdUM7V2XRs2L5Xe?=
 =?us-ascii?Q?TZd7ImRLgqXVViYHggjGIV0ZRJJBe5+O6RZfQxbkxec82Wb9Di9Dg3YFf+89?=
 =?us-ascii?Q?+oEK4e8+PZDIJzEBXcbGzO6iiAbMvgFivVYwjNT1zdlmlaHvHFFvHt0jSnjp?=
 =?us-ascii?Q?5647W+BjhFnF7CF2jWzLfASnp9Dxnbl3lM7svic8qXbxHCynCUdTMhZ/pMuX?=
 =?us-ascii?Q?qVepImawFepYNQFXpQ1RAgf4v86BrJ5TBCesIjV2AkeOYu5bzMP+nxPqPCuB?=
 =?us-ascii?Q?/eoOHWS1NkFsxNYOIEOWnmj1ag18vdXoj+owf50+QMkWwQQWbY3JOL/TnbDR?=
 =?us-ascii?Q?YTU1Mfxa12Sms4PewByjnnwoMWcwAs0unjZc78o/S1L1RYC1XcsOIj9nSPu1?=
 =?us-ascii?Q?UTmfBT+5DlEzVBYOPg+UUSoJ0/xE8D22mDUr+wfqhuPlXUko2l+lSXCdWg/h?=
 =?us-ascii?Q?DVGYvT4Bpbcwr0midvvOKH7VyXaYXaLMmDdUlF9An7cnsaMM8TJEqmR/e/ps?=
 =?us-ascii?Q?/34jZc+8lSPtf4bt8rtmkBavFovqPR9fSyCm0GkP3DEkKwjIZSJbi7y9Ausu?=
 =?us-ascii?Q?+ZPE4kB3hHfe+vnZf62+Uxzo1JxcuEfFA2zlyzYHVkIBMR2ri6JBDZSmy4O/?=
 =?us-ascii?Q?szP0omIOCK2SQPilhrjSOwK8vcHVErBuHRolgXQhbEoZNfS675gTo3GWo5oW?=
 =?us-ascii?Q?EXfZETiQi1ZfAS3184nF001+9Kw6DI6T63ozwmOBVaPm5Bg0fI5r+bgWyndE?=
 =?us-ascii?Q?J2b/sQd3tTXdMv5yPqsyU21xbRf32+/imChqI8qC8LuWUQ1XD+CAsHyGPKqZ?=
 =?us-ascii?Q?lEcecpxZaqxP4alUaNX4o+n4ADkwlmwKbihHp/4YBqI5+0PTqv0DLaCQ66DO?=
 =?us-ascii?Q?QnkXmdypIJART+p8S67JwilRrUT46oBeGM3YzaULAiDpvZz/IuVDToexbtas?=
 =?us-ascii?Q?xrW7AQARYwFeYzHoOC6yuAsybrI6B1Rfhn/kcig4jD2UgZzMQTe/ujxTfR+8?=
 =?us-ascii?Q?SW8YS9wuwhoeAtPWSvxSZcGfynk2vZb+xi06eIaXM6Jkb+FQYLGBuKrZxR7o?=
 =?us-ascii?Q?cXW++qoJJu4odOKlKxSZ5J80At80FSxLCkrFRSY6YkVfNNRFQB2LhLk3W/67?=
 =?us-ascii?Q?PPwp4QgK5XQmVAzHpF6icCjRcNCvuWtWJmbOIwhg6IuWRlwBGVr+Tib16kD+?=
 =?us-ascii?Q?mbeoSIkKRWQD3M8O61PtTlSFv0A0VZHZ1jWt/0H6Y2fAQyBRVhvoJqELXXBj?=
 =?us-ascii?Q?8PZ1WbfEQaw8PVdQFzURalUBOqjNys8f2WmsxCjJkgkywLqNHtXxtV0WSbya?=
 =?us-ascii?Q?G3Vg6VhP9AfgW+Ca0Xl+C2QSfuLH7ApblEJhPy6ohDqx3wv9ykb3jjX15Mpk?=
 =?us-ascii?Q?pmSLf1qWhbF4bDg7+or3YzBZYgsIfXYMi5xm6cyh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b51b13-7de4-4a54-0d8d-08db2af6c6be
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:59:19.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rf+8mNyL3G7CG5EvG5nyj9kZczFQZ0f4IIAErLolaZ0gVFWLEqP1XnqM6TJoQwoTJ2wleMe5akdK5/dy1iBX6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5238
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
 fs/f2fs/sysfs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 9ddc6ee19433..b455afc12cfc 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1478,14 +1478,11 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
 
-	kobject_del(&sbi->s_stat_kobj);
-	kobject_put(&sbi->s_stat_kobj);
+	kobject_del_and_put(&sbi->s_stat_kobj);
 	wait_for_completion(&sbi->s_stat_kobj_unregister);
-	kobject_del(&sbi->s_feature_list_kobj);
-	kobject_put(&sbi->s_feature_list_kobj);
+	kobject_del_and_put(&sbi->s_feature_list_kobj);
 	wait_for_completion(&sbi->s_feature_list_kobj_unregister);
 
-	kobject_del(&sbi->s_kobj);
-	kobject_put(&sbi->s_kobj);
+	kobject_del_and_put(&sbi->s_kobj);
 	wait_for_completion(&sbi->s_kobj_unregister);
 }
-- 
2.35.1

