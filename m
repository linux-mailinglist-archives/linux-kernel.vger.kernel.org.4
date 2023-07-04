Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AF4746F36
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjGDK4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGDK4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:56:12 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2113.outbound.protection.outlook.com [40.107.117.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440DFE6E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBbiFBKqOYtGgH3009fQSQNRMSGI7+cwMP9iA14sQ7O63pdO2MiUBFlESsoHhtncVJzWteMICddRGKGNr6RFbe0Fn/eEXYRfyqoF3biWXjbyPLm8L628EUakRC2Tw8ws1AxhGbGTIhMEowPlfDFr3jZpNQOvXS8BLIlpSIcxl2dY3/I5Shww7ozpRJFwCvkeRh6hI8bGkPqCKhgf3cYcIni46AHM/7WDW499o5XY9NGp7v+Hzh+i+h2y3uQ5Vc22OXqORCDTd55CGhkT3gUO/Au+rXh8i10W5NBYovHeb4FopJdnQl6fgAMEtMYNWeyk23uGx95LaWTNwEA9afaipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GATdcBtm33VGNndw4XBx09kvDrIZUihrfBlr7VqigtI=;
 b=i1mSwLZyOvfnrJs5xk6NnW+SmvyiylC2p6BtkbuFNWM1EovWMhHqb0F+IHfZRgXxAEa580DFbiOAL2ipikqNB4UWIP6CRMNTbGxMsqOR3uO9DNg4YrkMFrXln+wFWyET9lYNJujyAnFjC1yumhqHdpmLSGLq8Ep2wJ2cBuTJMsMtYBunz9qUt2MiMy6Qu8BDy/DHcjB+vSugQHfaReNQMpIgk62Z0HzhnHQl3tmlAXstqVjVH6fxRpZAx/j65mL/TQ2Wkxj0cmL3q+mmshbigizWGTI5NiG5a+jKxMcwvAIIYzKypaRQiO+Wngf31b9nqkqQETQAnguVpQ2mFjZPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GATdcBtm33VGNndw4XBx09kvDrIZUihrfBlr7VqigtI=;
 b=hyxlvkDXiaSdJqUH2nD0lNkaf+sqnr9mb4I0UsT+Gsc8u0YCUlPFx1ig4AgrTvcABH3Ud9T13wEUU0uC0EKylyOmqnrF8cNLvPyX5ysHUJT452HMfoL+VGjnk8kVJOyEyPHO7WeeDS1eas21timONg5rwDcR5lBOuFgQjOBJfxQAkTIW9MJUdc8wldYvJMb1IeDPzhftSEYLP/sbtUGv+vuQorvYZAAmdFJYRODSFqhOauv2IbSDFEdKd2lnyJcZb36D7pBVKQHKv+ioBQA7d0anCyuBvHMzmCxYZNnyHEBNZc8TFJxr7KQQJh+GvLxUJPYviwbIXZnOmwHFmOhmOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYZPR06MB6401.apcprd06.prod.outlook.com (2603:1096:400:419::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:56:07 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:56:07 +0000
From:   Wang Ming <machel@vivo.com>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] fs:dlm:Fix NULL pointer dereference bug in accept_from_sock()
Date:   Tue,  4 Jul 2023 18:47:16 +0800
Message-Id: <20230704104725.2510-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYZPR06MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcda751-4a5d-47f9-e0ee-08db7c7d4460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBNv80N+Yr56NfIER5QYTEFwsqzo0dQKf7vv1pYWVXv8bLd0tPEnAGJUiTRaJ+oM7IWB3t6e7Bs1ac3ehvl9aCYEIo+ID1qJsjY9Um9lb3RzdU4AiTorplTVvcg6u98CiGVHZRvjFcICHcp49ite3aUa1yrUEsrdg4v5l+ikxQ+W79CZ0d28dCTJSHRSjEk9sKyW7vFdjPmvIAE+wR1B0w/lPpEgfCH+45gYfhgNSB3o4OdHrq7akoJw/3z497YQbDKqPxU2j5yreK8/E/XZFQSzkMNDG2U6e2ddzS5vsgBh4zwZmVQB/ScyY5+i19QjM2PWSAVF0vYGk10qAXq7i0CUHj+CUHdg/TRkBJONM8GdETHK7yLGqYvS8K/wc8TkHtj/FpmtTEyVgjNeg9dBTV6V8yROOnIWbG5meAVvO1SPB60OfOOtbDWHZYcqFgu93Wk+kvfmxiJitdlGxi9exbhN1+w1wVYeHjvOGvNGcCk9jJ9Fitvrvg5Wj3h/3D52t/KVPFxuxxg/pt8DslpNO73lrMXziNAfFitj7A07M/gUz2kJZlAF7TSkxogW/jzwZ/rKZN5qvC4obil3bk8dY59vtnmX3vtEBmF6C9xNf68/nC1yT3wlL8l4Zkm9xEbG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(346002)(136003)(396003)(366004)(451199021)(107886003)(26005)(478600001)(1076003)(6666004)(6512007)(6506007)(86362001)(2616005)(186003)(38350700002)(38100700002)(66476007)(66556008)(4326008)(66946007)(110136005)(83380400001)(52116002)(6486002)(316002)(8676002)(8936002)(4744005)(41300700001)(2906002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v7R3YhZqbJhxXIkDz3FvbL1IJWPuML3xyZXFayUO025DGz2+Sg7H9+k92QDZ?=
 =?us-ascii?Q?GyXGHvRoys+kITXz73qzjOENVVmYA15epmpeeOS3z0YYzewrMNi+7aLNhwH9?=
 =?us-ascii?Q?Z7PlXi8hXQYAUF20Sm1p7SFBN/Qmjy9+M4ZtRHklWqrnRyYymSan0VRl3Yjr?=
 =?us-ascii?Q?H2NHJrTEDFGGeCrLWmHN0YoSXUZKeYk6PaNwmA3U7pdmCjXsKGNj7NVo9TQl?=
 =?us-ascii?Q?EtszEny/NTm6LHdO3vnUae/C8jAoSlHCIzZbaUqEgQAAOC3cljekjw7fmY4c?=
 =?us-ascii?Q?Hc95Bu8scLDCDFvr7/WScKMpohr2x7Rqekgu1oSO+pWT1k6cNGS7jY8H6SAY?=
 =?us-ascii?Q?MRGSHFNUzO7CFVvUJ93kayVtjWbZkkJqBJ9Pu6oxHJGO1C3rlhtrLPQMphI0?=
 =?us-ascii?Q?N5Ia4zHl4EFeK29T303J4aOcKJLV3Ts7YvYDVFdlJPNA5YgjMFaonCT/neQW?=
 =?us-ascii?Q?XZcnPHkpxhnl6dLPw42IxK9ogth0iGKBXv4x28Cz3E8r4TpN3/eXruSDihny?=
 =?us-ascii?Q?uNQ/CTLbE78wG7ZHuNwMfrq4pMsSCFETwWAOrWsUUR/1JoxanpyPSac5f600?=
 =?us-ascii?Q?T6OEWz6dyGCB9xckojL1bySDahjTjMcXN1EWI8v807oBC6W+MR6hGhy9Jdhy?=
 =?us-ascii?Q?F9bwFox6hrQsgfuaoCY+BzfJUhZvlfuhD3IDiDl//O146lnVWKxNxFbES1Ox?=
 =?us-ascii?Q?q27Lhd0TSPecJwNvofrc9jtJDcccpU98lNDXbEyvbUn7cC719VgthJ2s8cSF?=
 =?us-ascii?Q?5P4X5g2eiPdy9NMrBZnDn16MGJST9lObJOrzsLRaox/I97dsw5WQaUrc0Vt+?=
 =?us-ascii?Q?Elu6ZQV4pPeLUygB58PBat2bnmcfwk1QnVwpRghGIoq15Ap65yCqZ74ZbVmU?=
 =?us-ascii?Q?bzPiJEbelEbLh9zIKJIzMRlqIdJ6lffHvbXs+HmhYP8stRS8MjF4E5bG4QEH?=
 =?us-ascii?Q?D3/SdVkFVULRsVK1R7IVJHTuUZvUOuhj3TG9yEuKiOkfbO1uWh7LvEzYKB/H?=
 =?us-ascii?Q?zW0bK4rgqNPFpw44EIFcHKeqhiijCxNzqtv2/6GghW8Ajds4k/A+t5kzWULA?=
 =?us-ascii?Q?Db0d321tAzeKK0Pzoo+BqgETJvgSbBa2qsNZ4e63f241WsQAmzoA8u1W3RDF?=
 =?us-ascii?Q?QMEDTWikBztQypcf7lKbMMs6lA8Z1IbW8ksQU8i3EQhwR7/c58Yvu+ENG7Vf?=
 =?us-ascii?Q?vT33R2dhP1RDkJDkWSkanijYxUgXwtW/eWR32ZS42JjPtFsvfGy1y/x3xQPL?=
 =?us-ascii?Q?hEFgDUEPSgTCka3MJVlxHc3mrCI5R49nYhKj8CtlNxyXNNnlN045XbzwRzT6?=
 =?us-ascii?Q?ic3RpoJECEWeuZXk4zFiSkQO80LfS/zSlDWh//mGCC452eL2x7s+8q5Myu57?=
 =?us-ascii?Q?ujsrceU2pw7f2ZVjtdRrW1J4HnxnlQyU05HuL294RjqMJ/y3+5Tg+IxI6itL?=
 =?us-ascii?Q?mEQvoBfV5CRCnDDrRMNwRNZsWNPNTttrSrCOyLXMjPLLUrSswCNK50cDxWZa?=
 =?us-ascii?Q?EFgYzUDJJpLHfVEqtuOv9V28lgBrMmLw9/Npjhbdfzv/vXIVJ8QCVj3iJzg3?=
 =?us-ascii?Q?/orXQNQnStZ4WCOOiUot3dJfsGLBF2P3Hp1RX89X?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcda751-4a5d-47f9-e0ee-08db7c7d4460
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:56:06.4534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3Y8ySFXn9cM6WO3Z7dhSCVeNFtuHLpTNcy6bDiGrGAIp5fGFqVTWJL4Gr/h8eSZRwe8IVsFDHkpbzoaUu4wIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6401
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

newcon -> sock is NULL but dereferenced.
First check newcon. Whether sock is a null pointer.
If so, the subsequent operations are skipped.
If it is not empty, perform subsequent operations.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 fs/dlm/lowcomms.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 9f14ea9f6..ea18b9478 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1081,9 +1081,12 @@ static int accept_from_sock(void)
 		add_sock(newsock, newcon);
 
 		/* check if we receved something while adding */
-		lock_sock(newcon->sock->sk);
-		lowcomms_queue_rwork(newcon);
-		release_sock(newcon->sock->sk);
+		if (newcon->sock) {
+			lock_sock(newcon->sock->sk);
+			lowcomms_queue_rwork(newcon);
+			release_sock(newcon->sock->sk);
+		}
+
 	}
 	up_write(&newcon->sock_lock);
 	srcu_read_unlock(&connections_srcu, idx);
-- 
2.25.1

