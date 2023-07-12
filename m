Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D918C750550
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjGLK5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGLK5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:57:51 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2097.outbound.protection.outlook.com [40.107.255.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0790B11D;
        Wed, 12 Jul 2023 03:57:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeCA4FjBJFMXnWcSbL8LpAx+FUT21YRqWbHurcEKJwnMKyqTX7HXf11alG68J4b8w0irKhLSfadlDg+JjemCXPq5SHhJ0sJ12ycWr27c6BeNnKFbyABSyUXM167Yf1dswGykCbhhMdO5r/mpT2d7M7MkH1A3Ht1Dse/SihJyIHqCW4pqA/0V2qRTiUrDFoQHlS3VjHyqBc6dKhhL3oVx3tpQw1RhcL3Gb7thopzbpcnIf/E9adGqt6qjBGtPt/2TrJo5YHfvfge/kR0EO6eK74vDsJh+pYtTcaZtzHqjC5IzSpoQG6DZBadseC0iJCMF5xuwLEoQI1IR3ioMh/P7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmHd49cI52kf6d3noQXMef8HaQXtlrzj4/Y4tikKOBA=;
 b=DEl8zvqGE+g8CcYEAtVdgWLHy8vJgIxa2THAAbDcLJDB4r3/PaFNP2PDAOa4eaKyo7FKJqKwbxxvq6NaEtIh08usjpfbfNABvqP1SnYf6kHH8ADVB8wbFKoxnqkztriR1hoDzC+ip4H/o7TeHmQK5YV2mUCIGPGVldA+JWqmTeoylFNfdw+hqrvGerlpy8l14hV7LsDRfFmPLnWtHNeTO0g4/rrB3iaFKyhHIGdhOm9sRfk0zy6GZo4tO+9Vp32DYhFR8Et5Biwh34415d6hLJnEoco04UAvp8sRmb06Og0YrhnveEBOmKYyr2EQsbRbQ0VnOsUlpahTuAYn/tZchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmHd49cI52kf6d3noQXMef8HaQXtlrzj4/Y4tikKOBA=;
 b=Mx31rD1j1pS1mYvZR/ERgLrpmGjqE22bG+DloyLDZ03qBFmtmVPUR89htFl5guG1HQ8FllTtgRQRtoffunCKnTnvS2IQ0p2xCG7WtsyBtRMxmH0gSg9N0O3N15f8oJqYCkObcyUBCFn2mRLKlPu4jEk97r0WFfWv+atXk4VJabZk+NCcrCdWsJtuqg4AeTfbznBO2C4YaeIqHjE8fY+OTEd+I8oBVMQhXYBxkbLGdwyrM1pnT/HSyrW5vJW35FMxTckq0XJH63hqm52UjWoYhkouUCVgh4g6AnmxixjZp6vpsjDvWmUSf0wjjG12rxyLs5AHdeQt2i5wobk7BdS2Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYSPR06MB6766.apcprd06.prod.outlook.com (2603:1096:400:473::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Wed, 12 Jul 2023 10:57:46 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 10:57:46 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org (open list:MARVELL MWIFIEX WIRELESS
        DRIVER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] net: wireless: mwifies: fix parameter check in mwifiex_dev_debugfs_init()
Date:   Wed, 12 Jul 2023 18:57:20 +0800
Message-Id: <20230712105720.11310-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYSPR06MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: f55a48c7-7ad6-4d09-525c-08db82c6d2d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLpPMoVUIhbfHsdKtGIf+SS9KONyk/dKRK+0sAx/OSH9GDm6XPlQAK2oU1pSl4B2EjU2q2sqRPSZ3JjCdPfXoFxJxX8RiQqFBe3S2n2VvEGwpf257EEhau9cSB7wTfbMKe7TVC713iVFvpdRN9lAmtzaAsVdIjhIMVf1O8EhfTGQ1i4HSl8Awio89tf4jthoi73+Of8DcIAilbIzMXz6gSz5UDrJlYrg1JllbG9s7Q4q8jCN5mSA/NkFJMkiL0cO6Wj1NcjwSBY8wS/m7PGI2bklTYpPJcSrDZwiJcBOroQQ0hLYOvUyYo3scgbGbMvs4RZcjMpQHw3ZAy+vQz7oDr57Wfz4bzlxRkor0vjrAY5tHSoTKMI3+I6seyE6bKHIpc5Ho4T4hnQX1IFLK3pfPFm27fVSTmiAPlhIK5PODxsj2QDQxuWlwC0sEkRPftsI4Mv7JNMp5XV18s4aa7NBEnr1TbicJXZ6vjvc+vqelChXokczTuI2NWhNo5Y/WQmzHc9R89sIj18ctEPr2Cnqz0YwbN84MpYjeyLP5jhFtSIm705uZTc6dgdyj4sz2c5aZCL+fSSg+IpG3qppzcwTTHDTlIwt22KWU6JNOK66zJVHKYviSISQ5YQggQY9Q4og
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199021)(36756003)(186003)(4744005)(26005)(5660300002)(2616005)(2906002)(1076003)(6506007)(83380400001)(107886003)(6666004)(478600001)(110136005)(41300700001)(316002)(6512007)(8676002)(8936002)(66476007)(66556008)(66946007)(4326008)(6486002)(52116002)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sKLIkDqPFqNZBo5k8LwBpf/VGB8rAKGmxaeCBlY7GjNKPnTR4/F9GA4hUGSY?=
 =?us-ascii?Q?7A9z7HnbwwVyj0xx8W0mDDC+/WgAZfijyf/Hbn38v9mfSDVj+ts8LuTqEl66?=
 =?us-ascii?Q?xgnQQMWMwvTft6AwP7bjIfr4Qa8GoFkS5wLNLXVTX3xKBmuUnHAX6YyYWAsZ?=
 =?us-ascii?Q?qLW8hZ6vwMJUhebUOMPQiGxtQ/1h156m8YW7+ziCXk76QtT5zs0IYe7S43vg?=
 =?us-ascii?Q?c3QZauACwRc9lv6wjEaN0hDHcOzhlvcfi1sfIbAxQh81ytTNuLXNKyYVaaOl?=
 =?us-ascii?Q?K/odvuSEb+NHqyLFuvOalTt8KkST+AECGZlrAdFzHbigBtVWKYuwHYNDsB9I?=
 =?us-ascii?Q?yQ9dhcHnN+lHV/zwn3Qx8cbmFZFHB8xH2gKXMjXyxNFaKJo39+DkxycRJEfv?=
 =?us-ascii?Q?0Qu/7xCHRaokofkqiBZZALAoVl0MDkMtAt/7av1trnTjdhPxuPQeKdH6obQL?=
 =?us-ascii?Q?nCapcRkNxF6O1dIeSPmwFzwbafc5yV/Omrsl8n9a7KAXK7fwMaO1e6fKpg4f?=
 =?us-ascii?Q?RXMqFx3yCQ3G4EOEvIefVzTQ8YONMaLtJ7ihvaSxJsbwc2DtpH8VCq9tYjIc?=
 =?us-ascii?Q?urEjT/Qh/8HjyvmsvFOuqWBZe8nrdrmIkAm/L4KyW0pFH2AupzXb8QZkhduf?=
 =?us-ascii?Q?m9LYE0EdJXovpPx1pzJEhPb/mRi6NkglNnbKs9k+ker1Z5xyJ5goiWkc+kuL?=
 =?us-ascii?Q?l4MJVtVvITGgzKHhX0YEW6qTcHBHmLRDMVVz0t/PvKFPiPsFrojevDmUAct8?=
 =?us-ascii?Q?SQ9FmmS9znCLOvCVAuj6junJr8UW+iksazf5SqaJPJO6FgHl4oBYMmGgddi+?=
 =?us-ascii?Q?TsOSJQEWvfVVjsw8bPDpiJl8BOLAoGorHtJd2s/aIHjtVp0h2h0AAtfDjHeh?=
 =?us-ascii?Q?UiDtJ8t57CR9fMUdzX53C9jXNKl73bOOBo1UFpHJteeDRCRfflHXQ93B+NGX?=
 =?us-ascii?Q?gAxJq0XmQrjLcVr7iQQnhhq7u0jRkoWQDNdm+/jcv63soMnqx7itmZEGbbSe?=
 =?us-ascii?Q?Nn/mFAXn8v20GWi/DmqfnWGUGOLsStIQt3zNyAlZfdGjI7q1LUmIjUaoFZYP?=
 =?us-ascii?Q?c33AgutQyhyBT+wAUU6ytR6uhxVdhEcvdkuCNbGCeo2a8PxM/YcThu9FuI8d?=
 =?us-ascii?Q?WW5+7mEcT61hXdOoV18H/ApWvAQEosOLs9lzsLrce7OuZBqf780CMcb0JWKD?=
 =?us-ascii?Q?i/ri+BvxxbCc+eM30fciKNJBoCWeSgnvLb6BeAWnuOu8zVjy8G1AbREI754Q?=
 =?us-ascii?Q?7T9RumC9QksAGiN0bszTxKqugzqEs8dyveoEOKm+fL88f1UfthoaVBWES3Wk?=
 =?us-ascii?Q?gZpwLSlWlbNRqnU6BK78GOOjicu2rQsD8v4rRmyfWbgp3TBKcVSxANwb+U9G?=
 =?us-ascii?Q?wIKQ8nSX2QTxz2RKU3lUDwtb4LkEp/NiCEd76tejObKjVKhTx1A8Hy6Kmtt3?=
 =?us-ascii?Q?MV5GY5iBW5MBYEedwHrqGh4N7S/ph25AZOqSvMh/tDFjEEOk08cNJ0uNDR/U?=
 =?us-ascii?Q?2vX3TRa+kLld+xoYmgnydUdfHKrDljtc2D5myrsvcIuGEkE7kVOf7jsUR00/?=
 =?us-ascii?Q?qDPGFyj2aPdd7U5tZZktcOKB1l6SHpLGx/NfgGoM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55a48c7-7ad6-4d09-525c-08db82c6d2d5
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 10:57:45.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYMOMFdtP+cF26XIwxH6JKZ941njspNO/R+A2pSC46zy617AUbRsuWerLMsvYNKMtWzhbsN2wrXlurgzf0SWQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6766
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR() judge the debugfs_create_dir() function return.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/net/wireless/marvell/mwifiex/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index 52b18f4a7..5af49c810 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -959,7 +959,7 @@ mwifiex_dev_debugfs_init(struct mwifiex_private *priv)
 	priv->dfs_dev_dir = debugfs_create_dir(priv->netdev->name,
 					       mwifiex_dfs_dir);
 
-	if (!priv->dfs_dev_dir)
+	if (!IS_ERR(priv->dfs_dev_dir))
 		return;
 
 	MWIFIEX_DFS_ADD_FILE(info);
-- 
2.39.0

