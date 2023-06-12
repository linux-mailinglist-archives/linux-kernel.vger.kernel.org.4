Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B10672B9DD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjFLIKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFLIKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:10:22 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFA691;
        Mon, 12 Jun 2023 01:10:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAFC70IB6SGXa643RqM37xDkxTuQhCpkAkremKCFlvKokJm4oLCqcUizUf5darT01ie63tY/dQ+7xTEOLkZzKoO3pzE7U1PFw70aca3cas0z4Q5+BGvQ5NrLYcViOcYQ8gWfKn5dMPa8nAJhoBWxUfYGoPqhZIuxUhX2xWVbKuSXAbcmBKgosKrZa6h3PVV7UlQZJA/7iXkXBpXhec9rVKEdhZHQJveb+1yx3J9VU1BcE6aAuTJkSa8+JoXtTvlYWOReaY/x4UATTCrxEkRRQ/abp1DKvhoPZxbKylK3cQBrlWoIUNaGcffdaWh9Iz6XQ5p/WAvJ1N/3Bx19knV9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5vbFb1onfZ1+D7Zoq27f+qqsauoDymBJSBsQcPjQH0=;
 b=gVNt6lTT9dXbz1ePDs4TUE74ha+h6FrHSm/VgymNmLqqVjvg1yLnw6xiaQtlbrwOqtkNvXhcVl0SsIB9jTPhsRnTLOtGbCATRuoEwI3oiK0sBGBcEUg5fhsvHN8SQGb4S88NwE0LBLQxGA2FEWaLz+lwVSjRi1ZS7h9NzISG3oV0OXpcV5zimcT/u3jxkXWIrhN++4ojqt47Fk2+ugD2EECHtj1KUAbse1ToXUw7zE5cC7j7dNUWF43QY2kBiiMZa8iue5Jt7EMcKiA92EdGxzDvVgHJc6cgj47+nMwzeBfUdezyfKn2jk4NXDqPUmqlGJn0juIqJVBnqyPepHVSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5vbFb1onfZ1+D7Zoq27f+qqsauoDymBJSBsQcPjQH0=;
 b=XSC82YhZLRm+egYuq1ABTma43bTH25JAZSX4xZ/YHiAzYAVgBFQ+nYfz/DfwREgzPxcv/z2iReYoyjK2St1h6sPSSgpi57TX/GqT/pilM1r3knzMg/JgFfiWx8+bgIBnD3aXoYLCneFbCWiowSUW8/d6NPMU+3bu5kYBv44Cmn7/UfQTA3296w3S5iGhYHxX7pumXYmiQSoTMM+7r7oOos37Eh9y+aPpGQfCX/ohPrk9pbXobI8OHFbl9ZME5cbSr0SN0JCwBwLHkJLbnf429WuDcaEuHy3BcMi7A6N8Eo8JgtefO2/VK5OhdKSqWKemilAA7zuwTg6PdAuc799NFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SI2PR06MB5291.apcprd06.prod.outlook.com (2603:1096:4:1e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 12 Jun
 2023 08:10:17 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 08:10:17 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org (open list:SCSI TARGET SUBSYSTEM),
        target-devel@vger.kernel.org (open list:SCSI TARGET SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] drivers: target: Fix the conversion to bool in iblock_execute_pr_out
Date:   Mon, 12 Jun 2023 16:10:06 +0800
Message-Id: <20230612081006.40821-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0151.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::8) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SI2PR06MB5291:EE_
X-MS-Office365-Filtering-Correlation-Id: d5882f15-5fa6-4f56-ca7a-08db6b1c755d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sxH+msn/apojbjksjSnMst08a1GyzH4kQVkfJCS00lxXIkE8Qv3/pejCivVF40UwBuV+s8c9wQ+xwVwdA77M+jJraMG8MRwlhRuxVw+6C7oluB/oUt0QUzuJ3NqJAs0XTh9qQr2DUeJQhyNT48R/NHHcB1NzqA/zgf8F6VhdrMp+0hDwV4QpHBjPWKhXcLHlHNhW8fsu5B8s/Q73UA+mCTCMDsY/20ke+TwFI4bNYjgSlF4z/4FP+cRIcAktcvlK1dCBYnSbmCwbuooE0uPAhSC+3+JxT82BFUtUROal5tbjL31c64ZT1Ag5h7xmn5ewwJchuZUoDhsYHOCbRzIYtkcITo7kZXWuEFyo5W4S0Lpp3oFSUEHs+sNumNpEA+YedUuPIlf31SyR8fuR1JjXTahbWxH7HS4eAJdG217G0qTmgcYzQ3qX4pepeiHSDJ+Xs24MGN1cjG8Q75xOJKYMMZiFFeAuvOG+J6qF3qfy21HNPYSUCSgD20/a2PiqOloxAt+phOYkmPrCot6/1SzVngSvK774KqzMFYSeHb1rsRLxq1DATBSmmzCrFLiacku/vpcAd8b+au8bRKk0K/V+ZCc+0QhgTX20dxxeHGcMmzN4JPrzN5Pskx2+vqFJ7RRo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(6666004)(52116002)(6486002)(478600001)(26005)(107886003)(6512007)(6506007)(1076003)(83380400001)(186003)(36756003)(2616005)(38350700002)(38100700002)(86362001)(4326008)(66476007)(66556008)(66946007)(316002)(8936002)(8676002)(5660300002)(41300700001)(4744005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yZlGE32ahR3Jx/mRqa6EQ9bYS6aarU1k9gJrGCb2G8vf9Q5cCafV23zdJfqm?=
 =?us-ascii?Q?Yb+1XZh3hmY+9j8TIGmxmQbjaEZhlw2E+hIJL7Lp/aO12HKTMRXExf2mWy92?=
 =?us-ascii?Q?hAyzeD5QhW3SSXujmkgpgyxHWamBzuATWxu7kkiBV1/HAux7ySfcdD1Meiu3?=
 =?us-ascii?Q?khyzp3XrSOd81vSof+miTmExadRhEXApgUrFiazY1XZ5YQxRHUX8GbYLm4av?=
 =?us-ascii?Q?/GIBU/gysdt0MCIzsJ6xJY/FW5YfbVuLETkwTitRmZST5QJ4p3LNHa6tGtKN?=
 =?us-ascii?Q?8DPe15vPsOK8Lrgi/hRy1RQyicZ3HQXH+WhOXjE+y80/wZyZQqzS05JfwypT?=
 =?us-ascii?Q?RMc3wmkUdqOYOUTMf0USU6ZkB/Tnl/W7hM8yRA+f8qbuI1iPTVb9YOg1TGza?=
 =?us-ascii?Q?n69uYsHB7+EOTEKTPIdPwl+4YLi+U5lAbax3CH4modyzwc6vDUdz8cqkrkz7?=
 =?us-ascii?Q?ZlnpaXjf738Eyfl/7f3kCcLGyGHEYieh3XWoiCn05FuqXYuTPGmbJa1/tKoF?=
 =?us-ascii?Q?yMdZEJGvLaZ6FvvwUzRCiX5CLm9zDe7HXwdKz9sntRwTaXKJd+ovif8M9eu4?=
 =?us-ascii?Q?xKFnM0c0dCOXF4mLs7+DbNahDs0ZsWdpjVc2SR7/JLbCC32OBJxoX4mebWEt?=
 =?us-ascii?Q?pTYy+4UpuJ7HnSsamnvHB8fjCqOtCTkf6xSbqSauUPL0Iq9YeCtYtiFiwuCb?=
 =?us-ascii?Q?cr4Gk+HD/vHowDj3FQw6YEXFNje6Cdl6gPiQv1EXEjgYmtBPOGmFv0Qv/ZB0?=
 =?us-ascii?Q?L8ghMg7U88VGIvrnMvKDYtT9+ypUaseHPkUItHJNiLkAuLGV2cnUtnhPwub3?=
 =?us-ascii?Q?QwxDt7eHrbKpEfTAvS7b9CYZztCZb9/S7WXP80HnHl1fVYtZ9NxXNRcDTyU4?=
 =?us-ascii?Q?DEEFNlVJ9NX3wcR5jtdfX0JzjJiARWNh6dwoscEnjEcMigk4pB86gIgyNr5D?=
 =?us-ascii?Q?BBiHOCfHC84sNibRV+k45Q76sR6RgCXZif7dTsfT8fQvbVwioF3nbRtGXYeY?=
 =?us-ascii?Q?r29R0THPts/iDq8ieIKO+g10axtpLAvqbcUzMwLP5T/599JE46+XzkSkrq0j?=
 =?us-ascii?Q?hwgnMwPm1U/PPhfe5XHfkjEWJAZVL5yWqZ6GD6xumTRwxCO3j/nJwXPbhnL7?=
 =?us-ascii?Q?ZRc1ojFt07EWwEOjEjn/aE8A+ph3HPIP0nDZcTjo7DZjiOaklHSyo5gdOyHh?=
 =?us-ascii?Q?KdzubEvjsZOiL6xRG7ZNHxJG+aZIYMDsZM0HGOVd9EUQ5M3b0V4RuQtmYPvC?=
 =?us-ascii?Q?zW3A853IiNApywiamd1Jq8BZW4fcIKZrgsccBaq/gYY08G8CrvEvifK47A5w?=
 =?us-ascii?Q?qVEepd4q6Ui+vbH0UbquEsY/1uKV0cbgznLiEJ61wszIHSPSrVYVyfh5DGkX?=
 =?us-ascii?Q?FYNo0vji8GPB/3WzDS/nFanlsf83OR9p7nfJWdxerzy/y6aOVfelXbVE/1WS?=
 =?us-ascii?Q?EZM34Ou9FeqCrQZk+teUTRC20QA4dsoHdDlM6NQ1/qFELbLaOtuG/UD3VLLR?=
 =?us-ascii?Q?mzsUgi0ysswRF4ZRxAPQCUdOZhNnSFb4cbkaS9L5lPccc647xPIF4wX9kPfe?=
 =?us-ascii?Q?0LgL2CVYBtMsxAdiCM5+P9e9+LbiVBJ7tlafXVl+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5882f15-5fa6-4f56-ca7a-08db6b1c755d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 08:10:17.7394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H43qYAW4J3DI5jjbcaupx8Zvv/fzviOtQGRZngDY7eQlvxx94Q4zPeSOwINpqcDZxhc53Vvj7KkGNTMemNy+qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5291
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of the '==' or '!=' operator are bool, so there's
no need to convert it to bool again in iblock_execute_pr_out.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 drivers/target/target_core_iblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 254c33c9788e..ea42cb5d06d4
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -889,7 +889,7 @@ static sense_reason_t iblock_execute_pr_out(struct se_cmd *cmd, u8 sa, u64 key,
 
 		ret = ops->pr_preempt(bdev, key, sa_key,
 				      scsi_pr_type_to_block(type),
-				      sa == PRO_PREEMPT ? false : true);
+				      sa != PRO_PREEMPT);
 		break;
 	case PRO_RELEASE:
 		if (!ops->pr_clear) {
-- 
2.39.0

