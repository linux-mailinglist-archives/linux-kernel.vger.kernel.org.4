Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D83E728F37
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 07:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjFIFHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 01:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFIFHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 01:07:07 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2105.outbound.protection.outlook.com [40.107.255.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC3C1984;
        Thu,  8 Jun 2023 22:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/ve0L86bbJZ83j8DSAB/guJuHqJvVuDMwOM7tPcH8sVW7ZacsWPex+csSkaQI9KcFgFTNQIciz6JO5hFY5o1kJhpwjyR5GuNPl/8ktBNXe0f3XKsOoMA3Pk+l4NUaRdSzhIZ1NWmwu3+96k44kz4KKVMHROR1nTeYh4sJEGDdp3CYPS3aEuYmIYMprrwI6ruPnWorDbuJeQ1RaQAl+KdVzmdWihKw3T6+hefC+JIQoP1USI0T0ko/NAK3PLOIzabLnXfsalP8u7EPRULi+98CjxHM7WkPaihU9K3oEPE6jyzA6nXzxwm6tVZloosLSREkyEKwL48Hc3Y7V8ruyz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naFHnu4NozN3tzktJ2dc0Buu5Hkl/08DjfQw7Lv0JFU=;
 b=gPtcFCeCLSvro+ixVTxC3pA9psp5lI/AO2KRV4QYAfSk5aLW/qOhGDeWzA+h4Auio2qedaKdACA/5O69de1/P1mJ5593T/8jKzr0cbF5x2mQGQVTDskrvsD9bNeqeKbsFIiRgJIzikv/gdq79yWucMSS+P1mEWpP9qO4YY1Yss+7HLwKkLIpklXN4B8e29RgsygiBtAjrTewrL/LKH6pWQf1TqzucBl5BVdV773J3K4zHwPfvAKL82DqRMHiRZgDrs0Nria865dJPDTQiZV04oJ9Iru2uoqzCEM+cG6R0Bj8AdpUlS9fGRoYTW/Mut9ZUca2di3NFMwx4Ov2gfDZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naFHnu4NozN3tzktJ2dc0Buu5Hkl/08DjfQw7Lv0JFU=;
 b=cHGISQklVAW5WTCtgzvKSU6o/gbD5gSoqJXTRzOeTGAH3uP5xTRz0nDcPpUz1ETNCXUOr1ev4vmmLAqC7wXvDzAwWUJiw/6RxnMPTHHTEPCHT5w598amfW8ZD2STtdqGIhLBe0mFKjQZVyhaWMrB5zVxS80VnxiLfRyfLHRQV9g6Vp6xxXdWaLeqOkDRjbTtADi0nQZJ/1k6iNRkvzwbyGqOcnDuEoudvHoIiUmgRkN5NXnO1aiSTLNhyiexcd2qTyAvlg28T4C7S65DBO/CMbnQlY5oU2znl1YfzFuRFbxuSDq2EDymMnVhb49mkaoFk80yrYWOV5gDHGI3oInTQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SEYPR06MB5301.apcprd06.prod.outlook.com (2603:1096:101:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 05:06:50 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 05:06:50 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>,
        linux-cifs@vger.kernel.org (open list:KERNEL SMB3 SERVER (KSMBD)),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] fs: smb: server: Replace the ternary conditional operator with min()
Date:   Fri,  9 Jun 2023 13:06:36 +0800
Message-Id: <20230609050636.27669-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::18) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SEYPR06MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be0bd39-1ba5-4df7-e17f-08db68a75521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMmiiyeWfCrtEZY9PqvvSK11D8Xl40awdfjlJVZTIkQCPdBKNcMcaYsPDJMZNgLNTvZRh6Mq4cJqJl/DuNO04eP4JdMTzwQzgEAddpnvILutvdpZFz/4fdmwIFw2pATPF9Hx0SkRAEoQvNXPKTQL8TyHtsAG7qb7NTP9HAreNMw/sZHp/8U7dUIsuiOTFdh24b5dP3+aqHNEZGNt2adYUwe03Tucy7NSY5wXI7fzmJU4xSAY/izuHk7lrvhUvq3kozQCLQ79Slvs0I1SWksSqyVCQyUDw5eYZ3vVQLK3aodHlXKFB7IF51U0O2bm/T/6iNuubRhBup3VvQUjD5OSA2IHAXawfBqljOFM+GTxxm3CIZILu+LaaZhLqAMWLNMaddwDaGwP4VRYqJLeSiUI46lUWPgQpYyKu+rX2EGtbbzu1Yeu3zBD4xAXiN3520VBldf/nfbOq0a2YAsH/0XDElqjJ/UWqry7jN63BrDOeexyMmeLWRChAeOWw2uGgtfYnIEGqbv1dzQfjCJKxhEOAPB3QtA9p7JFoyLbIwpO6dFS7UoeLcf4ozcZybeveO69c4sc9xTssAuw3FkNlTSug51+WJWzTdMwCvXG9djnhEjoJzEIac41oPZcungP3DMQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(66946007)(66476007)(66556008)(8936002)(8676002)(4326008)(107886003)(316002)(110136005)(2906002)(41300700001)(4744005)(478600001)(5660300002)(52116002)(6486002)(6512007)(26005)(6506007)(1076003)(83380400001)(6666004)(186003)(2616005)(86362001)(36756003)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xXd9iQezmAnwXXWwr+oduc/quJjeqbFfUx/f8LqZz8cXNXVN97BRdhHIQU4n?=
 =?us-ascii?Q?uQ94qOf9XqnkmkCizumQ4Jutdd6ar+J6NBDxtFJ2GDtDITDgshpQQjCuQGBd?=
 =?us-ascii?Q?09zfOkkuC54DKGrx0TuxbHfl+t5W71AutCBKPqMvvwchz/YvOmmb7VEUnh4j?=
 =?us-ascii?Q?YYccPxmlDnDz863Eem/+mZ4osL2FCnMtSbOVcy7+EWnT1MZ91M01DjCUJESO?=
 =?us-ascii?Q?K25ScxGLoHfxHLs/lx4h2oHracUr2aPsdeUddFiNxZu6o3mi3QdeXMjYL/km?=
 =?us-ascii?Q?+38RHdvQmWBsneV3vpotoAaQYxGzMJpKVngATs5xaIF4KJh2Av2YgTUvzVpW?=
 =?us-ascii?Q?YQTlOT/417aoIVoBwG7HI3z830oxP80jC4jdi7dBx/3zoUEGBdTQXbLQM5SA?=
 =?us-ascii?Q?dJtTlh/GI/x6sbtf5Jx0V14Md/0GBin8LnrtKs4OaSqbRXUrnvN8U5V3qos6?=
 =?us-ascii?Q?tE/8DYnSc+GGiQ2Vm2QUvvAzmwYJeVm7l34bdg6Tk1/o5CJDh7fU+66NJZ41?=
 =?us-ascii?Q?mW6wCPBYocIbuipFHEu4duUsjQWnl/XtipXWK62trqHGCc21cE2gd/O0cc7W?=
 =?us-ascii?Q?5u/BF/wHLHerk2Pe8EnwcYlJudhFUmSjqWlxilq02XhON7IdBW7dkoDXbuFu?=
 =?us-ascii?Q?3RXcpPG2k2+z5URPj9mxUL9lboerDY/Jj6ay0GzieLps4aqYfsVmXrRfTKBB?=
 =?us-ascii?Q?47Auqru71cgs/pAniTpF93GT+mWPSGmVaDzHuW8lenYEqq3OKnojsHh7HMQT?=
 =?us-ascii?Q?Ex7lfppmy8u2uX5pS5hht7xdxhDaz2j2waXwF9klmq28QYFqXzMNtfeEOQZ3?=
 =?us-ascii?Q?o/nJ4FDYOYLJG7+uUDvVP/OeTkT5NpaxhIVmWVZrmZf1RM7qL8/X5yPZF7IL?=
 =?us-ascii?Q?8XHRkkiPEs2Dlqx0FfvtWyjFntAiQoXYOPBuNbgjnnoYqmcgZ1UQZMfjNUuP?=
 =?us-ascii?Q?O8iXC0hOp6DAN1uJwXydvG8aWrhR7N+Uf19tMgVjY/9XNXEG1JQj0PnYf7Mn?=
 =?us-ascii?Q?U1hHxJW+iojB4oxXTbjqH9OlQ0GzoIQIPJG7FF57d8NQVQGyt9eb6bzy3uFB?=
 =?us-ascii?Q?QnGw/zJVrRu3RZkH2kSZHxi/3dBFoT+GlskAzBNs7Ztec8st79XSsU65owXs?=
 =?us-ascii?Q?Z1WzCriE5O1xYmZVx2ngiQXfrgctqKo5IeCu3HhyneQYtjLhOjgTeigA7wuy?=
 =?us-ascii?Q?B/5aAkhZIA0vIS4YOzv0kxo8IZzW6TkmQFDmibnef42pphxdBVQN8Abma0rA?=
 =?us-ascii?Q?E7PzUqt7jYeTk0TZWxQTtjHT7lFpHMmo0IWz9bZiYiJxIsY8aDnNY22mxtfk?=
 =?us-ascii?Q?pD/eT7li8v1K3VHmw90luaDbw2DycVwlBFlxeLE4XUzHk8UddnJKQ2SUfFSe?=
 =?us-ascii?Q?McdYQZZ5kHq9FMzfH5R4RXVRgedDrA1N6w0XYPdiqGZ+RZM8gb1go8jrrPMt?=
 =?us-ascii?Q?qlYtACtAnLed+BB6AaT8D+kMZMIb9qur7DNARlU6uthhGGBe0MnlHuHHzT7F?=
 =?us-ascii?Q?GyKyZQCYWG86uAayucrYn3FYlsCSbI1A9qVU/RVf1LKzlDtlFHCsPcDP94zh?=
 =?us-ascii?Q?N/njBU24lOhPyrFeOeQg/XgRCepmj1oDsaX3icbr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be0bd39-1ba5-4df7-e17f-08db68a75521
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 05:06:50.2705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuJat0taSjgvzWcK7X5JbZwU8Tl7469+pJmFXheOmmENadzweI9rVfi1fjQUQFn3Wepm9FLBxhWt5vwRDpzsDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5301
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be better to replace the traditional ternary conditional
operator with min() in compare_sids.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 fs/smb/server/smbacl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 0a5862a61c77..a93ae72fe4ef
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -97,7 +97,7 @@ int compare_sids(const struct smb_sid *ctsid, const struct smb_sid *cwsid)
 	/* compare all of the subauth values if any */
 	num_sat = ctsid->num_subauth;
 	num_saw = cwsid->num_subauth;
-	num_subauth = num_sat < num_saw ? num_sat : num_saw;
+	num_subauth = min(num_sat, num_saw);
 	if (num_subauth) {
 		for (i = 0; i < num_subauth; ++i) {
 			if (ctsid->sub_auth[i] != cwsid->sub_auth[i]) {
-- 
2.39.0

