Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B926C2094
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjCTS6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjCTS5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:57:17 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA5910EE;
        Mon, 20 Mar 2023 11:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnH8nEQd66FZ1cLIA/M8X997vGuWCnKLaOPFnhlx09SZPH/12x2TVlrxBg7G+pg2JrkVLHMeOU7KbKTQG/n2Kt+0FGOZ0QNpzVnbKFoTxWurqiY6HDbCusot9H4bSv9QCVMZIFerOiBG/mNdY89YxxDjJhMFRGeZn5J0P30gBI7KMmAC1plxjxPbtKuzO2byifOBzcM3eBOeL5J7BpUj5ysN6Xwzbe6QuonFXl7+rx3uL1yrRERXWlCMqcwi+aauYu50TaiPVeSBgTBAqsIfubTkR8Hm/JPbXHKpRjaoI8Rv7N6bDNGhVDDDXIQTwx19KePKVD8H6TWqCGSjELXQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeSXbiSKn/Htu8RDFyUlihMaEwMnfwHjUTJcCENoL/A=;
 b=kjrQyqDuysUYhcUhUKReIMy1ofxS6OawhH1kwfCSmdLR/b0/3apCn9FAMi61yF5CRj3RBg1RH7xQa2WpuYiskE2rVo3cKpNSXnZgycdA50ZZFBFbvNkXzFG1b+C1Go2y7aIZgro5tLUgXycF7y/Uux/AbqGEOAuxRTGoxmSFdZUURoy/hzpXBezXLECFtD5/VDN/GQRl9AVlOXzThXoRwv+t6ETiMscKK99XJE+A1U45fnQAZsv3k4xejvtyU8jcJDRywIqp2x8qAje/7FqQF74voOCYny+Qoi+RvuuJ1bHkgC/j29qZE14EPNcL04RwEX2tZBl1mw7NFeLOlaMXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeSXbiSKn/Htu8RDFyUlihMaEwMnfwHjUTJcCENoL/A=;
 b=kDeD+jMjL4Hor89FZpdLKWL+Byaf/dxFZiUqOh9KskRW/VXim1KRKpb7PIL97Hl/91BlIJ0hevA3Rp3Daz9T/T4/WalOsFMDWDAz9C6nMFn6PjBgmBtDg2/03BbnevqxKkqJEoPJgM27cASndEoJNt2sLLkbfe+vyXpxQw9gWeLxoCO3UZ8ItHhmTCg4V21a4XUhyPnZf1mIrm8vNoBYw3frBT3XuYF6RcS/RjfyhjRG0H2o7nehv1Xdtd01bMYKXlQt0qCeJqO5LJalD1GR8ImKyfQFF5V/LDeltsdLN97FAQrD88Ksq9npfnKwSwLpG7K7IIcidGUwbL94nJ9fBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4121.apcprd06.prod.outlook.com (2603:1096:4:fe::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Mon, 20 Mar 2023 18:48:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:48:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND,PATCH v2 10/10] nilfs2: convert to kobject_del_and_put()
Date:   Tue, 21 Mar 2023 02:47:29 +0800
Message-Id: <20230320184730.56475-9-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230320184730.56475-1-frank.li@vivo.com>
References: <20230320184730.56475-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: a62617e0-6848-45fb-3804-08db2973a3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3NzJHHgVLk3DxsLLEmVqY5hPuPFKBZUanSvs1BxgTWor083j9N5YCr3Z6lkzjj3ojz/2Hz8bAD0xLTsV3B69vDBbHyEHFyucl6zOXyyGQjgjzjAYUqK0QdjOTyqrnMuz2+ehSL41bSON+VhRpH7CTvGSxOShTK/Kq+NvmD13KGAZi/oycYQx4gRpO3+ViBbbRV8MnhgHbWp6Izi/WtoBxCdCeOQcmAzFsv270Gw/2IAaOhnPcnnMEn3iLfF10XmIC9m1dV9C56/v1g3dqzWD+3w0zyCeVCXNaw0NoVWUncS9gqoOpOYHQOULdniv1EchQoHO02+UCb4runWW4k59zTDDQHmKwenhULk/RaMKeZjObVpsC5/Gs+NGEeIy6LX6iHLVhlpMaByIOHorj9wtOT8zjQQTx1+Qb9ZGKBSRbcLDOlEwe63nxBgGIR2u6HWJRVXXPp2RKSsKCgkTZcXLqRBBH6aX7tQ0/PO2l8gRQUXKp5yR6nfEIDF1XscOVsGMkjzp8D+syNUbHigeNgtmilZVj9J1/hNT6mhAjy29tPiD+YoVjZT4VG500tmDtJFXnNGoSWtn08T0vljn7Tii79y2DsL/NsK82WNVmRbWSpH6QyFF+VXsr7gIDO+1p11rVVhwvDDZLhOGXAzncaLUSQdDlWJ1iaGArEsrJuPJgfTqpW6z6o3dpgR2N7dPO7LSbu7XjBXAHDfxtmNYbf8Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(86362001)(36756003)(52116002)(316002)(4326008)(83380400001)(6916009)(66946007)(478600001)(66556008)(54906003)(8676002)(186003)(66476007)(6486002)(26005)(6506007)(6512007)(2616005)(6666004)(1076003)(38350700002)(38100700002)(5660300002)(4744005)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p+RkXLexjEDj2OJdqOF9HqdDYJrzXeABMXGl3dTi+yFAMHYlSzS57jFYldU9?=
 =?us-ascii?Q?SaGvKR+5JTW/4ZRF+mgs1qwrIr8OHHfgExL9MWQ7GTPwBPlbVPZTURR9thu7?=
 =?us-ascii?Q?S+BHMV5QotFSEoQQbgoEIhVL6n2KQhCib7ya48EphykeIv7fQmmXv1Td9VDS?=
 =?us-ascii?Q?frnoYCP9O/jEV834B89huaotmJKrzJmNcpXFwT+fXnl3C37eGPO61SkypkK9?=
 =?us-ascii?Q?ChDeZaNNBIt/cshZ2rTrDk2aTxvSwBzQFy8v3HzZhhD8WRHeiCk/SZ44NkY7?=
 =?us-ascii?Q?gXznB+l0uL7vb5jpacYHoDMwIgPQp8fJ8uLvz1sRcDJBt4acKLWEmm4ddmlh?=
 =?us-ascii?Q?iqRibz/8nrjKRLNyLpa+w6CuqdrgFlGlWlpoiGa8thrboQSMqFvyu/bGSw+t?=
 =?us-ascii?Q?/AMhgBOj7Z5/5u3o1HQj1u1eKBjiWCL+5MbD+IRSrcMOo+Q0yEbiBXwnbdkG?=
 =?us-ascii?Q?NMlnUhfJgvTkHbCQrAI52o+WvMqWEB3I3/Nw8oKQWF+bKQnj5or77IhJxn84?=
 =?us-ascii?Q?IZ0kiE1m6/9VlGLSlzNDkb0IQMOqNuNQP39CchlXRquRbDNRjguoGYNu9Vog?=
 =?us-ascii?Q?vUPMH6FL2TxwQIHBtM7QQ18jLd7NqysWOAtBRu7pOeCfuvnjtKF2AvZqMLVs?=
 =?us-ascii?Q?gixixu4Rd1VMpuH8SN8EbCfVWxgBNrDQ+XHL8OEPcWFaOWKmX8ulmUPd76I/?=
 =?us-ascii?Q?p0iWRovlEVACP/HkyT8+JylEqCKIDpFps66WugO05aucH/v1SRXCQ2jlaGl6?=
 =?us-ascii?Q?5C1hh3sp6Ixrz9ok/ys54hLnScqa1A3vfuIdIbQ2AhU0/kchUIf1Q0i68ul6?=
 =?us-ascii?Q?KVQ/yzeDFyKht/Vmoq84CsyB67+LZV9bia0krTgBDqnCPH2tabR++tozstlN?=
 =?us-ascii?Q?z4DMGi025F5amqUwRhZP9q6lt9GjKoazgsAyqWAwYzqHb7gxWT2LSWiArGlm?=
 =?us-ascii?Q?dv8OlBTAWY1T5aecbK6+pH4uW8qpoUqbVMG+huHKtk1cUaK/jxCrOSvmaGnr?=
 =?us-ascii?Q?KnXXVHmnpUcpABcC7HpnuqjC9BFh17Yhchq9DjasHr6DwlLYuWL0XfAARn8A?=
 =?us-ascii?Q?AplIqpcK+Sp6oH/E2FVKbrDNBt8tB8qZMSs42szdFGja7Ye2OFB/u/33Py1l?=
 =?us-ascii?Q?ruIR+0KABvpxP6saHnVPP18RoXVfuDUlL2/Lg7s76CBzZEuCwmBK4eqCAJVB?=
 =?us-ascii?Q?1jLi4nPpG88RN6vWki59HYlQpkvfHDRP7wjxFSKnqdxWy91vEawkTfn0ywUI?=
 =?us-ascii?Q?dpQGqSZet/lGZdaMyi164pSYZ+kiASLo66b1Db1zCkTPrEhnwp6YQZCJDWCq?=
 =?us-ascii?Q?ItjvaTIpJuZckgyMn8u/4xcopWpWePBj4abmIW7FLuwdVYjrVf0SWf6cdPLK?=
 =?us-ascii?Q?TB47U2lbVBRGp3ZD0gvsLrx4oZz5u69iAZszHxpywBKNhBxzAIwHN0wBVhGp?=
 =?us-ascii?Q?JpCOuIm0bOVX27ftHa+PGm/MChQhrNEkmtmJb6wIvPlHV79ZPUAUxHSOxO6F?=
 =?us-ascii?Q?/iPLXYyD6P+6csnWjIG4oZrIb422WGaZJszS71vCevPrTmbhcrjYlbxxUSVY?=
 =?us-ascii?Q?OElDOMax0J/CLoAAirmIqfNBnxx9jD7SzpyvBKIy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62617e0-6848-45fb-3804-08db2973a3cf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:48:05.1332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inzKkml9qGYVrucX3Vclfka/7biRsrxTiytsYxHaHLJGuLXH1L+DSzzUdOM0S5tqmtoJOmJFHdiS3656xWvxEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4121
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
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/nilfs2/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 379d22e28ed6..150965d58ca5 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -1042,8 +1042,7 @@ void nilfs_sysfs_delete_device_group(struct the_nilfs *nilfs)
 	nilfs_sysfs_delete_segments_group(nilfs);
 	nilfs_sysfs_delete_superblock_group(nilfs);
 	nilfs_sysfs_delete_segctor_group(nilfs);
-	kobject_del(&nilfs->ns_dev_kobj);
-	kobject_put(&nilfs->ns_dev_kobj);
+	kobject_del_and_put(&nilfs->ns_dev_kobj);
 	kfree(nilfs->ns_dev_subgroups);
 }
 
-- 
2.35.1

