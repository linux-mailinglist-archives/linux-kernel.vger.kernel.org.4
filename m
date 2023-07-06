Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81613749E07
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjGFNm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjGFNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:42:54 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F82C1BEA;
        Thu,  6 Jul 2023 06:42:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdcifmXfOnR4oQymq81DCUyc9UB0NBb9zL0+BXZHvKYq+jUhIvVyFjgivi3o0F0gsVn3vw+pb6fgCKewzCG/9h56SzpCHoXl8Yp/iGmd6tzDi70PQd6y2cupPZfHGLztTPduWiBPf08rOQbBSPJSACzupSTkLJwbbzLvMQDWHVbmT2T2Hs0CV7rjGeluBKiJWjhX4FBwdhiAvcm1L6aAtqhGK1/PdfhizkTF93zRBENk8YjQ32TNPXVXEjNg3CJ9/s1QeGM4uznXUQkGHywDrBDIm8maMQIw48aeuxznqveHbe7+RMrF5A81cCa0UwcpWbVCSF18DwuxdOA+l0TqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paqiVsqv+bRJKbz3EnAjIaVHjiCcamW576aIKSFLeQ4=;
 b=cSgRK7HYwjOFPV3awxwvNxOyEmVFtfbEc3VHjY648k26ofy6Q7HhV03OCBrKAJAgBDM055o1MFqyi35Er6hJIP0k/nTBDKjyaiUBVNBi/2wKGanOluAPr8Ih2n4wzy0EtRgrgynz/DoKzXWA46N0VpguXJ2b+smTk9sw4ab/5YwUT6hGtzb77rZ47+5/YQDop1tm+rxz+Vil5AH09XyWK0LpvfTAAO5fs2xYirYauBva7g9+Kia0hogBTrcTaypzK0Ny79vbCQbEC9avjA70UMgtH9Xl60xPVqlwlCdaeZQbiH5yNcFYtvDzAg+J+yQ4P1pd6SczCX6i3XgGA1bDhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paqiVsqv+bRJKbz3EnAjIaVHjiCcamW576aIKSFLeQ4=;
 b=dvyfJFs5rMwnXhCv0VMvX+kv96LkAwJ7aPviSbR+7bVpSoyQrn9hKYwlQRd8Cekcey+vL5/fntLGDVI6/9fiHSeRlodcjQmf0QMGHsq7KipXAoznoY6LwEYuss1VyXGk3VRWSUDfNZB5LH8BW11/p5ewcviWJu1Rh/btBjfFhZlpmIj6AIPWFMMyPnsFuN3g8NDUOmlIo0cts3wfool0I8c4/Tgq2jp3o8aiP4EmtdqTyuabqJ210ONhh7HLC1FXYLQyidyff0YCkALpcVrmzt8vdvooBuVEMeK64JIrVtvKYYEv1YBMeA+/39MLKfzVMK3c0BJd1znXrHNQzzM9lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TY0PR06MB4981.apcprd06.prod.outlook.com (2603:1096:400:1af::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 13:42:40 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:42:40 +0000
From:   Wang Ming <machel@vivo.com>
To:     Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] net:tipc:Remove repeated initialization
Date:   Thu,  6 Jul 2023 21:42:09 +0800
Message-Id: <20230706134226.9119-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0036.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::23) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TY0PR06MB4981:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6b4d26-5061-4157-3776-08db7e26ddd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5jiFSyaFE/z3+cc1oLYUZm0aAZUa/fhZAuyDJSlNZpjqRcuD2mk86US8AwumkyISCEX6k6OfLnbGGQ5KeBmQmqY0TXOSippJaNTtiYS9ctr9mSIzQ0jnkOrT9Olay2Rd80lXwUHq/m3aLS2OSI8fEkRZQpuanya/HTP+tZg+FuLMNyTZMmSoDWiaV7Uc4JPSrmLB2jcMrJHjYiNTebJ79JNSUJYxKO0uuaKcJhH6nS7gp0O/lQ+2N4elIp4KKO5wxTxO1Fkhf6pmnavbhSxRo1Dm2i8UisgD8d09zrnUqPVQQyJ12G7pPPHNtX9Os19E7vcFccNU5XuofI4emKZz7feCZ1yZJ8R3rYjwmxFX1FoQk92stEMZR3lpsv07kzz4GPveZctMXU8Jcb5zC4msfNQpBUWIpN2HnNFi31YZkcPhbeF9PpjLd2GeGla3c8EVFRkhJyowSiqJqm4rfWzLk2E0CjOCQZlFVjMjh9X03C9mCiaLwHwAK5a5GdA+Pjzp+OTlecpfNzH8OsqprLLGKqNNYZFvK7obj8ri28/3+EyaNgiUOfdXeClXEGycaVj+g43n88wlMkldc8G1y0JRU0eGEwv7GiLHWFCqGhzWxA3JveBcSFTgAE/8oKoekhn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199021)(4326008)(38350700002)(110136005)(66556008)(6486002)(52116002)(6666004)(41300700001)(8936002)(8676002)(38100700002)(2616005)(66946007)(316002)(66476007)(83380400001)(186003)(478600001)(6512007)(6506007)(107886003)(1076003)(26005)(86362001)(5660300002)(2906002)(4744005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MhnkSB8MmiSCW7I5O774ShNcNWFlt9dK/0oT5iH7hRkOPw4ABDP6mabIQF2Y?=
 =?us-ascii?Q?06ivo/fI1tiDnan1k+Hu/aV6lHx/mDc0wJ8HX6Aajrg2G5mQRSj9IsN/ZvmM?=
 =?us-ascii?Q?SGVTiQolDtNOs4m1F7m8HdUNvPxR1zlUdQJ5t7pC4rAXvUm678HZMc7cjrxt?=
 =?us-ascii?Q?JtRdyomq06MoDE/HFncE4Hs24VyHWj8XDXfdgbGjN0Ln7WxQMpNe1nJFLLym?=
 =?us-ascii?Q?CFRKpnVbMUFwNe6umIjaIN8sSbNtbExMIiFD/lhU4so3U8C57VLHkTCP2Oc4?=
 =?us-ascii?Q?BweVHFpz64zAnMLZQQMEXPqhW2fl7NXbKJobXm1FBJsOiZJm0LAy3URO7MxF?=
 =?us-ascii?Q?B69pYrXJ0C+Xpptd1ng006cKeMbbvmwjIzm5w0LeQtk9YWZYOFRvYadj15Ey?=
 =?us-ascii?Q?I8Dv0snXQjBYrxVrvwGCihthRiD5eXFdILa5xCdijGvIrY6skcGI5hJKEbzq?=
 =?us-ascii?Q?icLQBUhukTR9g+Ql9S3VaN0tPrzGh2LaxEXWgITJzIFdfIu6khIuT5RMojSi?=
 =?us-ascii?Q?PaIWRPFlpyF4WliBrbzoktzfab3hqKRuYRuXhQPAnv4XBqVfIG5vIfmjwXr2?=
 =?us-ascii?Q?Z2RdY21DU1h+sSd/TMa8Q50vI89scQhYfrBC0HO7GLPjMuOKo2Lh3KzLWw+F?=
 =?us-ascii?Q?cxWuARu0+r5A03FiQ5fR3V4MhPUGqLGwZ4tZ4klQJKEtoxxDvn28PvH7lH2U?=
 =?us-ascii?Q?Kz+mfnG8TOqVQ+/jmK5HIHF8UfIGO//oK6Zfyt9U95ORGELo9CE2n8CD0pPK?=
 =?us-ascii?Q?eJCZ2Hz+G+ve0vSy361Zi4NIcddgDTk4mDs8NS99bkZpAuBOOFkKclMcEgoZ?=
 =?us-ascii?Q?Z1Yg0F3vMI6pZBIPef8vUWX8DbTNXTJl37TEhtErbS+r/jMxbHPR9poz9gd2?=
 =?us-ascii?Q?tz7n9xJwwg9J0DH9JAUizfuWYhzk6AAIcw0NdqrVZyVsCaUUp/UYR0QA9qwh?=
 =?us-ascii?Q?SvdAm1ZFrlkaS7nWbQ4vir0mB8Kveni+g1syux3b+Kn4+8csejTBr7clotcC?=
 =?us-ascii?Q?JPaw8QkXPF6IkN6PC4b0znU0r/rmt5AEJdgT76nuPE44iQS/0clKG7TGF4g/?=
 =?us-ascii?Q?NBqpvBY/P5Q+4yq0P1SdMu2oTa37+aa3G3nh/HVrqAIV48XZNTKXFXK5sEEi?=
 =?us-ascii?Q?ihyYTmBFHxIbIYinjDJADHYNzBAycuz3Rp/vVJ3jOrAnmRH1lt6zLXHZ1nFa?=
 =?us-ascii?Q?7HkuglZ0X0wWXeSavU4THKiL7mmNxQTlbDiQeAGxpt8jylub54QAES01ble2?=
 =?us-ascii?Q?ezi2+pSRVlq0VuZ0bxyni1eUYeTbQSffxiS7IC6oHo9P+XkGoVeIfVFJJ+/1?=
 =?us-ascii?Q?N5hkqmhaskPHS++WFmcnwxpEdd0hAvgGImomglp7mqJhJFSHB59/uGKNr2hT?=
 =?us-ascii?Q?mr1xHTeJRmoLCdXLvmK2kZFj7JA0NqXPjcd6MQZuPtbPc69Nle7G5iE5eGJu?=
 =?us-ascii?Q?akWOKf7PGATk3l1GZVjjtwXWV658uhptQFMEJpoTVUMcxY0C5BxkqSh0LmSj?=
 =?us-ascii?Q?M48/2PDM1VrUNvRTFAtzVZRjz7/iCw2LaF4N9w4lz2ffqsDKOTllFFuNX7od?=
 =?us-ascii?Q?t//poiZtr+ST6T0zjRqLLnOWjyQOYHn9j5xZc8BD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6b4d26-5061-4157-3776-08db7e26ddd8
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:42:40.1214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSve4jzRBiaXL3HKfZsERN6WFGahVUcVQUwcSsTJY7c0J2+llU2K3g5JRsQqkSU4LbvuLJCJcfiJqYC2KLfg2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB4981
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original code initializes 'tmp' twice,
which causes duplicate initialization issue.
To fix this, we remove the second initialization
of 'tmp' and use 'parent' directly forsubsequent
operations.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 net/tipc/group.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/tipc/group.c b/net/tipc/group.c
index 3e137d8c9d2f..b2f964f62c36 100644
--- a/net/tipc/group.c
+++ b/net/tipc/group.c
@@ -284,8 +284,6 @@ static int tipc_group_add_to_tree(struct tipc_group *grp,
 	n = &grp->members.rb_node;
 	while (*n) {
 		tmp = container_of(*n, struct tipc_member, tree_node);
-		parent = *n;
-		tmp = container_of(parent, struct tipc_member, tree_node);
 		nkey = (u64)tmp->node << 32 | tmp->port;
 		if (key < nkey)
 			n = &(*n)->rb_left;
-- 
2.25.1

