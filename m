Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CA06C5179
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCVRAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCVQ7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:59:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DE228E8B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhNF/RzQNc+fpWIx0DdgQ85QQfrDFa1ybi1J6TBGzwALqsF0bWBmSaQAhngW1e6jFgyeCH7k/oJalLW5zi43w7S1iJjBhxmTPT/w4X7zoDT9mRdtI/DZ7URZQyRP+MDrGyIH50ia4mXIdwl+OzefSaHnre6aoCtTQkqXi78o3Z8f9YBNuIgFOonxyzAnCByrkpNBGR2hzGG5lMnm8uGakFyBg739y38suABtr0VuG7ypWlJ+DlHASNNCZtvFXQhOG7MUW2qna5pnqqC+FCBdUjY90dmlnIoHfnd+ROXPHt+wvPw9d8+nVltYA/Ggdudu8PCnXWQOsdvgI2cxLNipmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeQHK9btMEEetoQ258/+zZi9o7P0QMgrRsf6CanIx3o=;
 b=TbIGKdmQsgLEKq8224wvjugRLBJJMb4iAZFgvMw4dn9qBnXbV9OEWIIIvzu4vqdmz8TfuhbI/wTknDDVzWb7cXsyRynR1PwraDq/CPWMTeMjbw/JW1aZjh2h5ztKF2rYohA1Y42fSIQycOUqWXR5Ey0uha/JLgRJka2tRHd3ufqqa8Ii4cdQ1xULtF2LYN1nfi0TrKbRMac3M1F1Wo5IgPDlTr4m0XOFw99E/kwTohCuJY46H/4wPNw7akBk+L/5RwwixkqZ55/V9h4YMhquZds8LzgT2BoG9Kh1wAI7brjUxeYmL+J4ezq+10qWzKZKeCTOq3Bg0ObFd6XObAxjkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeQHK9btMEEetoQ258/+zZi9o7P0QMgrRsf6CanIx3o=;
 b=Fr4B6MV/U4v5MDOmSdjE7cXXP3ITeZ9epkKH0V/xXFtNWv0XNIv61o29kazUn5QmpOWbs7MrOVckvjQ60gblpciXElSk1tsmUQslDVeQ3SZr1laP4aFwV+6gLNmMGHCzPEU4O52H2pvIwtexG7fjPcZ5GEFMHtwzfNViuyBvMAanhNbrr0QfBkq05cYkOSyAMGFAtg4uy82YxUdVORZimqxptYyAgnbiDJVib4YrRuwC8k54yjKcRF8Kj82+QeRKlbMC4s+ubdGipSB/6xlGStuGQhZGZXjDHiM3kiAaBNdTBCrwRQcAr6qyPVVc9QAv/tSLY3p49MT7DVTmaLBfeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5238.apcprd06.prod.outlook.com (2603:1096:4:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:59:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:59:43 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/10] ubifs: convert to kobject_del_and_put()
Date:   Thu, 23 Mar 2023 00:59:00 +0800
Message-Id: <20230322165905.55389-4-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 574b2aea-b45a-4289-6fa4-08db2af6d564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPCM7jg44gW4dKN4xtdG7iHtiE4N2NsGi1Ohdc4O46oTAJlgSxrEqVVUzUkyKpTkxVbi2Z17ei7wcpFWGvoU95A74HEtuTcmv0IzVJb9/dMUTvQaTItMGDQarSVeQpUwat5YGYgZ32J6cfM5h8F48r4Zu7F3LnQNWYj7AEA4A4M8NZMY1h+Zf1NGXdnJ8gL44Pa2ZqUSuMj+u9zufRJedG1h1OB8gVpc8MvmWph7l4VaQT/0zOrxOWrGVyivfzCAu2NQ/BBOToj96Kd8r9acl8VmpmtTqnuGkXjta5xDijsbqJSK886MXLnfg0wQ7JissyiWC8suQrgCRUqAPHUEo/mlCVVaobPyCY+G8OcggxcgHpvsdoX8NQiDv9tpLW568zeWRorFGyyrT5OqFEp+0xy06Lnejtl+3mq4hJ1dCuVSVrwgHSKehZLs08T3EzCX3LZkEP9IbT/UBOL1qMkoRM+7990+u6rkZdubSY3bewbxLEQI4j34PEOV2DSxEWF9fH1blvQoGGY5TrHOaTgDlSV7N0fdjSZjslsy/WhMfAHzuqOPvqVUXBU56fSumI04uQ/r3YnrEfaSXMTcP8uVqq+oxzu2WXcIVIDjxrfEshsyM+yGUaYSTF/ksd5uZnyptTsF4GrKZU87lzs2H7e2ET2IY2hhxW2hIMtcq5GfbLsPiZ4AmzQaBwFSsywc/DfBEOPYpFSLeMlUFJ00LD7oZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199018)(2616005)(6506007)(52116002)(478600001)(6486002)(6666004)(83380400001)(316002)(66476007)(66946007)(66556008)(6512007)(6916009)(26005)(186003)(8676002)(54906003)(4326008)(1076003)(8936002)(4744005)(41300700001)(5660300002)(2906002)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E5utXRMp2izd11Qlu2O9ryZY+NvvFBdzrCZOElIip+WOWrheOlwta9vzgFue?=
 =?us-ascii?Q?T+XFvT3Eeyob3lePU2jnoF/wrceQ7pvB9xYaVhlkvEs9KRJx/U1V2y/nAzCD?=
 =?us-ascii?Q?qOQfRYn0pQA63ZYQBukGwDtkXjFRjbW4iNC9fZGsMzqdmidBHNzKJ2JUDm5t?=
 =?us-ascii?Q?pmvunU8RA/7glDQOhjqvcRqsMf02iIUifx7TtolOjM6sx8wQZuvpavJpRcrk?=
 =?us-ascii?Q?4ho9HLwdSDXpB3xRFrgX+PPGxbt58FjMBszXTIcfWAnyN6s5EC09JFgoSyKo?=
 =?us-ascii?Q?eBX4tHKaGFKy41o72fVjiZTG5fA2dicki4+wpMILdvUlfpsKjdnuER7Esdii?=
 =?us-ascii?Q?90Fc+id3n5g9Kc0ZUo7lUTkIrHJIy4yKhg0uWss5bGP7gLICN600CBZUw8oS?=
 =?us-ascii?Q?6LRuIdyzzCOR3QUPOgRSOWwRZpWDC7bAA84a+KRQEpnGDyP063DEVtOpwhgk?=
 =?us-ascii?Q?xovtM+zhgvskivClZnvmArFMNWutLvAvamFmB6Ptgp3IhApEAinYR1sKhPNH?=
 =?us-ascii?Q?MXZAC+d8zEWa+r5FhNIOrXEWyxP75K+61VwDmfjpV0yDaw/YXkSpSUFnSeQD?=
 =?us-ascii?Q?a+BH99LsvPZiBZHSlzVvzB5M3Tab0WfWALK42765CMH4tp/EPnKpW3k9A6v8?=
 =?us-ascii?Q?3Wc3AAODh3tdQkczqibZQ54AdJtLsDPW44dmRG8Yhf43PC9416wGGLCCPax3?=
 =?us-ascii?Q?Gt755tgHLfhzNNqV9i4bZqMc4KheZkghZ3HG/i6ePbVIvCcDjj2dciTCEc4Z?=
 =?us-ascii?Q?47cFx3wNPm8NWeVkRqqYDkO6FNA4bQA4seNFqdkNjwvNaEwpNDEShuHTb9ni?=
 =?us-ascii?Q?sBlySi2782FIIs+QWyugxtENP91ehKBR0Hp5vZZfJW8/Ukk+mNN+VEq0e00f?=
 =?us-ascii?Q?2j+bbVCZ8jkD8E7gq2H1AtJS2lmnetK2jFRkCNpvi4WJvJLCqYL/of/K1bZ3?=
 =?us-ascii?Q?9blv2iQDsxOA4fWDGu9WjaDx0MY7KaE9bb2XZk7szNhDH7kbe4ud/mEJh6SH?=
 =?us-ascii?Q?3eLQgrXWRKL9hXy5uPJ7hRlocAJJ6wl9JT8HsIxkfVIUoWbuWqDrgzl1LdHw?=
 =?us-ascii?Q?6d+flKfDNQxwW0Zbro7QYBhspsCVkGp512mMNhu9hTKBkK9uqfoqaQTPsEX+?=
 =?us-ascii?Q?8d4oY0SW3JQBrV+vAwCy6Xs+bUTqsap/MDAQRuk8B9pOVNtydT+oSf8kzISd?=
 =?us-ascii?Q?bKFdgFdONFdSTLbwI0k2e8NzN8/Sp7mDwIlyWoxFHrLV0nWH1QUWVm2Hd/vW?=
 =?us-ascii?Q?HyxTYLXjbECgVeaFWT9416Bt+ZwVXgw1eD4Ht672AXUpJIAsUph6bg9FMD2r?=
 =?us-ascii?Q?yEOn5RlhslWM1HVK/91CVSdwq1lo1Lvs4n0VF59f1dBAnfulB4Udzgw90jPL?=
 =?us-ascii?Q?9caJMk9QX2QUXxfOafURnsjwGgndGyQukzVZJfx3uS65GyVAEie2oRTdN+AJ?=
 =?us-ascii?Q?FDPbYZFsD0twI3oDa9b57ZBjOuOrVGpAEz0jGnDPMnEBtBGR5/l7PAZnkMO/?=
 =?us-ascii?Q?P22695aPybuewI7eUrJJ+mCPGoN+o85pMIJMYNvSbrq8x2P5iVv/M3u6M0vE?=
 =?us-ascii?Q?P/jtsmZZqA+UQ2tWJFnH2sNbT4CTTY0iSguXKwWb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574b2aea-b45a-4289-6fa4-08db2af6d564
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:59:43.6788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zjgb+F1bBo8UWrfX7aNQlrnq+N+zKL8z7UO27F/t7N9DX/0WxT4FfBZrawbNUueRSShVvsh92TONJYO4pIaSg==
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
 fs/ubifs/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
index 1c958148bb87..9571718e61a9 100644
--- a/fs/ubifs/sysfs.c
+++ b/fs/ubifs/sysfs.c
@@ -130,8 +130,7 @@ int ubifs_sysfs_register(struct ubifs_info *c)
 
 void ubifs_sysfs_unregister(struct ubifs_info *c)
 {
-	kobject_del(&c->kobj);
-	kobject_put(&c->kobj);
+	kobject_del_and_put(&c->kobj);
 	wait_for_completion(&c->kobj_unregister);
 
 	kfree(c->stats);
-- 
2.35.1

