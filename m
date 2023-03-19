Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40456C0013
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 09:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCSIl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 04:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCSIly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 04:41:54 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2098.outbound.protection.outlook.com [40.107.117.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8282F166F3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 01:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DineZIK2HUHWyVPHGkkOzvrnyMsQqGr1392+YPJf/zDFVDEjDYCJWgG7OttZPjt+/qfXmFCMjp/32pPwu6jcukO+4kYYry4HF0x0HcgUrbAscHOnqNVSgw7C47lDmEykZqWqOn3AMQVRsDJJ7woTcCcNtacFinfQhnB5lEaXyUPG/KDsDsKeilBv6mbZhjWEFZIlPLkDdMBhuo6YdSl5Qtpu38Pqoh6bxQpkohOFwVZNkQCr2HqpZIhD3C4qRYgjI2OjJUAYaZbRhYM368N/LWYQUdYZFs8SG3XA9JgOywn63X0VarSqIXIoZ02mIhz2QBmrVkObIhR4NdWSf3UAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6Q21IYBQjn5QhcxshRu0Kue11o9uiBgYrm7Mp0AiXE=;
 b=jQIPhfOGIvX2ri6MvikD/NnIe2jS6sC2FZbbndYGLWzQUjalD35c7RXTFf+F9Iq9abePw3uexl0nt5dzJuton+HQqHoP2Vdiqq5/3+5Zo3yAcrmKybVMFuaHtPzSH70CwID+yEefB4t0Pj1eOrsnxSiKkHbhzFCibp1gyfgXiZb9ud4ZFh5GmmX8rolZznzp5Auq0T3wzBGnTEA/pFmFCT0ly8hcniCNyD5y4Nq+Nf5y0gnmNLeyOWnRgwfgUcqzf2iJLe+HaHoITqeoVwSeQ12tbpjvEBcnXFhM0126WcGZV8PZYDggtYt11VrVR7DsK1p7CFpcibN1IpLfdE7PPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6Q21IYBQjn5QhcxshRu0Kue11o9uiBgYrm7Mp0AiXE=;
 b=lBxME6GXPRPM6CH0cPBWt7OOZTVAJ9wHy3ZCtj4EsFF18+JhP2mBsJ7vofvBWXycD1orJSP1cB8BuEd+3oB49941u8DYNitgFORwwarwI3QyCPRe5/qqs6qdVnCRfTRpbhKz6UaVQczflgYglqSAJ7Vp/jMwSaiqUZialzI0G+/FhajF1hiJck/xW5gwUzgvH3EOHH+iM+StodZUhoweckPUaS9RY4hIceq85pMevkuE0IgF77fzE3dyFo7Swjs1Nl4gL4C8Wb7ad5M0caUtr5jA1Dj6BNk7CGxzXktq9NcNR+ViroAkuxOl+Hnl17yGNyUJktWbYRbsvMwoEFYuqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5350.apcprd06.prod.outlook.com (2603:1096:101:6a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 08:41:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 08:41:50 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] f2fs: convert to kobject_del_and_put()
Date:   Sun, 19 Mar 2023 16:41:25 +0800
Message-Id: <20230319084134.11804-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319084134.11804-1-frank.li@vivo.com>
References: <20230319084134.11804-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: eaef1371-4f45-44d4-b998-08db2855c85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JW8U3pOOGeQJtN3cmjQuRvYDop+NKVoeJZkD61iqLmLywgBKcxZwRi8x9uTjgMbGhVHagZgdZAK7CJYPhR0/w9/DYc5xPZ4iVAOcW7as4wST59O3RCmk/x+Pbxf4apSJdR9gZPKBNzDlqc5gcpI7SzYYTPkyVhLIA6aUgfMXBfXQX74TjZaTZhfUgDcbpQmILKWu1zhCwWQmJIRjoSMdVABF4AhhcL0X/FowW95oi0RBUdV/mO2c8lJJbyTwlz3bbarOO9TPUEwW3Swk+1x4ler+0MX5wE20uMVzM31Ir+mP3y/BeV/hwhH6uSucvnlqxlAW2e2VRAyBg+vQQdsdn91w2tc0guZhHxDWDycuap4bA45wPJkExcAVmHmlN7HtrYx0NJy1Y/Oyh3HzAPjqX3aiak20w95vmpDBRbAnpelojTQwpGuPmcRUs/D3OxiADjfyYkKqYQDVgc4SaSi4aTe/4pXCUfyJmskeCRFrje+tYztQPiKnwvoo1cqqU0etvHMMTk+5zGLLFZ96sJJR+PdlmyOjPQ9N7V+aHmHiSMswlPue4ua12dsWyYNNeU+kEAaj/zePLOchPgCFdA1jpQxnuJMtaCGd2fu2c/muMChRNBeih2tuypAozYW91/gWyb6W2+uW+4R8IGQ8t+mQhfxPhBQbuADmpNCW/WAvcei5jIDQzbPuA157HEaM0hjkJgJbvfsGkSZUBQ5pRqeyoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(86362001)(36756003)(52116002)(83380400001)(316002)(8676002)(4326008)(66476007)(66946007)(66556008)(110136005)(478600001)(186003)(26005)(1076003)(6512007)(6506007)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(4744005)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qkez6sNTJJ3Zt6MpwXWhW92ABShVUgNxnaauqpsGF7rU9R9Qp873H7OGJjz3?=
 =?us-ascii?Q?8aYvJbXx3Ct6MP1eOkJVy5mrzEorpOAQd43PsLQDpSCmhAFxRnL2OWj8+uJI?=
 =?us-ascii?Q?1FYuSIEyQ+aHPE5vPsm+2OJEj0Y/ex066LYpIjHVyA+UbnXN2kjIuFIZaEuZ?=
 =?us-ascii?Q?q8wUE65cwUgNc9pfeJ6lx6GyCeSGqGMGsPEUPUiDZQTrwn/i0aiZ6mnWbON+?=
 =?us-ascii?Q?KzzqY0cPGXHOFQlVG4yr5WGG7bBWF4AB+FCRDriugJhe2pPykVs7RxM0mJK7?=
 =?us-ascii?Q?4f9B2OQ6v1/qtiJ/p0B3VDi00twSHGm6XkHmEPBT4t/9IF71JEFLuuzq6CqQ?=
 =?us-ascii?Q?ZREyOAJuWJMNoRX105OC5r57IBJOhlYBJRK751rBUWbqkkEfd5eJtCR1pU6B?=
 =?us-ascii?Q?wvrTMkBiCcAVTk/eQvYqabiS2oA43ZKWyYz2pcfE8Mjd1tG2OOiwqXxpib5S?=
 =?us-ascii?Q?tCDpieW9a6cw1jj0GUlLvFXZxToN6qMRw1svEQ2334mlcneDS5N6IrYkOFXW?=
 =?us-ascii?Q?GOwilTXwXF7JDbIcyUCtBj8mAeQ1OYVwDKZznbW/A/IZKi8kfIYFTkkkbR6B?=
 =?us-ascii?Q?WAI05eFWsqbX58ICs3n5J+n1wwP57oOGTR5OveUw0LTWcnktuxIfahAnBe0F?=
 =?us-ascii?Q?NLgfSAKKYKzLau80fj3QqZMTbm133T4ez7kDQazaMMIXI20q8emGmuZycoTD?=
 =?us-ascii?Q?C3K8z1bGoZWTVYRAM5UFUVbNR2Ov6zgqL75h82G55NfhPBy3S+BPuOiZvpxZ?=
 =?us-ascii?Q?XkEkaE4ZyH5c+B886DQGGr7j6NgdiewBgTJQBWSw23/oPnHzEsxnOhQSkCqN?=
 =?us-ascii?Q?14waoWml+BM0L58C3ZpkZH9w9OSSlos8mKPxZY8DewyZZkZUGGqs5jZvegno?=
 =?us-ascii?Q?2Kfu1ToWrfk7p6n6DKM0KClG+BYPa2ypS323POilPztHkcv8zamdeuqYETJs?=
 =?us-ascii?Q?5CbSqsSOwPeXyl98m4t+ADD0HvhurnMDtRfX3Q9fa05Kr+gs7Z94JQUeNskS?=
 =?us-ascii?Q?pXQbQ24nO5/cloqpdlhgOf32hCgGi49srYKEbA3XnpC0ZWHS1Sbcm35b5mcD?=
 =?us-ascii?Q?lO61eOYdYTscqrRCz5apLptC+vmBx3ZvZaTCHjFVkjEcq8vdyTZPXnCQb2dP?=
 =?us-ascii?Q?KWzE5gDmoB8Mju2y9mlESs3u01OYGs5Bx3KpAQsD733xyXE8QbPCT4ZbpqiD?=
 =?us-ascii?Q?7PyXnmSjICH2mQoolh1kAndXwV+eKcViIqnbF4/pd+zzNIZDFQ52dgwmmg6F?=
 =?us-ascii?Q?EppcpR89TJQtOdkcACbll7uR0nub3dr8HQrnN+/uVbI+sFchY4WjWPv0cX8R?=
 =?us-ascii?Q?Uwy7CsTmdmIlI8N0s2LzMHkeG7saJzLxQ/gHprKymq98siKx3JpKB9bCeR29?=
 =?us-ascii?Q?fl9l8lppivj0VFVDCF8Ctv3CXrNLF4gmwQoKK6bIIQSR9aE38mecA1iFTt09?=
 =?us-ascii?Q?rTknJwUbiEAIbTcMZH+sZ2kIdBo3DV7KwFgj46oRoulxzIHgJHcaep1IFRAj?=
 =?us-ascii?Q?oTz60gKN0JLuXucr0SKKI3yT1VxOx1iEKQEm4z80fMOy8c7tdxYYjyVn6XHT?=
 =?us-ascii?Q?s6xqLni0+GhD0eZyWKCreHEyomYaR5Hygwf48uuT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaef1371-4f45-44d4-b998-08db2855c85e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 08:41:50.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vB7CjvYfHxGiZaQuiAqf4XQRUKtEfnndVYNdhTK3ucsjRnPKRFu/1qTpv0ydHUMC7Eym8b7vMpn6MmQ2v0xQpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5350
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

