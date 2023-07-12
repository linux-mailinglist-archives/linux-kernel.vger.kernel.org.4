Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF474FF29
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjGLG3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjGLG3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:29:12 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2128.outbound.protection.outlook.com [40.107.117.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E96D10D2;
        Tue, 11 Jul 2023 23:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckafQSFARpsYTkfkiKBiXfaHZZHcmdZssLIXFxdOylN0JAeggNZdLlxJrPpIG3ye66Uy7BRRf9hhJXV+/5ImMvu/fcu1tEWW0/IDSknVAxxfd+BEORL2dvPJLtagNNL0iU2ZUtrSq38nUpMWudtAFV58/MK2JgcV/F85ETtTA5pagvKueXaaoJinr4e/Jml79vy304vp5kZMJChgnU6Js6Oe3lGHre8km8hfc/awNqz3913HTE2cd8oop/F5ATD4VMmQKZscn+LkM1VcST6yYFXGXx+55UjzBGx2heLaoueKhnvow14UkJTSMVhqDKzIfSG80p5fWUpjG7mBL77fPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k83S4Y3tdLmTiBXpT60jdbLyZrj6PLFn6F1UPSbBCPY=;
 b=cN6qADxEQpV10t8rzBaRUbwl/iWj8Jf8OMWJHaMkBS6k6FirrUGwEt3rU2BIVo03oWRGL8QoTNpAf3mA27oPuCPoBfylEgA1dzYMrJnODC3EI//gW3T6M3jJcWmmJHxZJl/CpBoD40S8eoBYaDYtVkgfJKMAEmpEab/DQ1ybuFNh40upboYnTFYYrkdXZjOKJQeOD81DlrgnmvyyTxRGKJ506hDcdX+SByxu+nqrCAqktvrbanMO+Es7MuIO7MyDXUTIUEnbq4GS+11RooVt7pnGL/sMqV1HgT08buw9j9FeDviwgTCLx17q4CiGXruf9+2MMBOKyVhY4GZP1LwTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k83S4Y3tdLmTiBXpT60jdbLyZrj6PLFn6F1UPSbBCPY=;
 b=EhRu69O4AgoF6A7zTkWi2kaoCnr45dvn9zvFcacjmoi5jIAC6lM1wJypuJ5BO90yYJdxh49yny3uwOAYnam7sqQOlmSJas9xF+6rL0l49U5DGFgg5P+SWalBUPqu4SvoSVeZxjz2CcQ88EKfwRZ2GHiNRLTA6kkm0XpH8DpB7PH4IznxMfiqIzu+w/AO6M+IGR09okrc8R9nhWKDt5srvKAk1yJVaXUCzGqmLVHPvURLecaechwr6xIqUK0eyTNZr1Gwkj/yG/Wu9MgvkhBZAmpS2LqYitt3DGdLpC4Au85KLJ/3sq44wKb8o2DJ0PYqOCR5wm41m+7CaMZjVCgM/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6687.apcprd06.prod.outlook.com (2603:1096:820:fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 06:29:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:29:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] serial: ar933x: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 14:28:39 +0800
Message-Id: <20230712062853.11007-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5d9851-df14-4777-5e7b-08db82a14b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DTsC9DId+NtZseeR3+zk3ky5ptfduHj89/11luK/GG2fYG8vcACrmdj1B7YYVDC3HBENtrJeTJQVwIRQL6z19qcMakFor56KpG0X4tS+r3ffVsWPYmwV8gi9wDAt2kAs9IA6dEaQFN33/TjsbCxHJC3bJX+hmxJN7UqIvD4E96qJd79HOCcJ9uehmvst8Tefpj7uleZVAl4VccRg6SZspJFzNFIjguafu+Q2QVWcWLeJd5UGrE8KmsZ4oT3pYBMQq8qciw2j/91v+1pJRYTq25b431BMKMLIlh/IbcsbMDqX88UfKi6qy5Ffj7aVuRQpBEIs7k8Cbtto7uqNt96l2DPOBiQ5FJopghXtcek1DkZzb+DUWE4cM7pODRz6d2uDKkuaBfImEOJ0lEstI+sN4uNDbV9F/O/1TSIv1JHmYyg1A6Kwx3xhzsWUzkvR5kk06rqlGaCmB1JxzHuN5b32VNhr4jSfXP10lAYSw4jjTCdBTbXVOc/9tSn/kt24P46rLeGGWfnWUyJxhejobCjeGHEmhBOfzDVhxkd9v49AOadq0VbwYQf94MIWoDV/snlKICBlGIimUNwB44zvi+8GvvG31z8+wi1qORtOF3upgpP1fXjEIByL5vqhkvw3Wbi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(83380400001)(2616005)(38100700002)(38350700002)(36756003)(86362001)(110136005)(478600001)(186003)(26005)(1076003)(6486002)(6512007)(6666004)(52116002)(5660300002)(8676002)(66946007)(8936002)(66476007)(66556008)(4744005)(2906002)(41300700001)(316002)(4326008)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Id13QsXE+YCpmDQiu9/1ILqFWPctDQPCALCuPbtGq4Z0Z2LXwev7rGYlcu2P?=
 =?us-ascii?Q?3PqiqmDRXW5vcTB6tJfFtBqTpHsupT6N5UfhkvrS0x2EjHZkg02/ysQga0Ec?=
 =?us-ascii?Q?HNY2jMVDEZCXvE//tg+G8LP1dRWimQj4StCHdIwj/rKRK5rKyqPi9iFcLtkv?=
 =?us-ascii?Q?uv6EW7v8Pukv9smeYaNWLvrkvTBwL+zo7hNVklwT0SdgPIjORGh1+0udgT0f?=
 =?us-ascii?Q?HkN+Svic3PPneXP9ps7sj/POwV8Jk09iUyYb4Hz08JgqEexpXG/utbJKpYjO?=
 =?us-ascii?Q?Hn2szPgK8fb4S2+nbg+rVVtJ8tRhPBWD00AdBA4s2LIRyt2Ghy693PCkd8CS?=
 =?us-ascii?Q?YaBLkDnZLnpw7Ll6P0MXgpHk5d5EonBtURYCY3TZHRiPgP8oXgx5clj3L26z?=
 =?us-ascii?Q?49B97WNWn/sX2FZosAVZWHURgVy80KfBF3wZ3HHIfmrH5wTWpkFI+nPIqcsf?=
 =?us-ascii?Q?rJlJtxILGYW38Y4pQStXjIznpOiZ7JdKYod5BD35fixKA86kjUg6GWkJ9spU?=
 =?us-ascii?Q?dHDlvFVECWzes70+zmNzF0U9laL7FntqYvRbzemMLFz1Sfm2IL54gDSeJ9TM?=
 =?us-ascii?Q?Bx9oIVWmmyegLICZvLhDzDBFxB3hNChtWG63YwTwFEL/8bcD67wFHzI/afX6?=
 =?us-ascii?Q?2Y0eP+wTNcJPV4dxMO/aMpk9KT6ytIqe9xLyMteitRITxguXQENDvmWWLVHy?=
 =?us-ascii?Q?qrucICJZjfttsWsVawfjm0eBkyiYpNaMDr997vp+x1a7iTnxyPZ5ApAoZBzX?=
 =?us-ascii?Q?D5jn/xIT5HIEeo0lBrInrjC4HT2r817h3q3nwg4ljpIa5Y7ZVqLF9f+Wb3L0?=
 =?us-ascii?Q?GqnysaE437k7zopUbblEyOW8w9do2P+3BdfQZSvgZMCohPrMD3bcMelfVveL?=
 =?us-ascii?Q?XDgYlqHZMVVg9o+tQDZCjXvpCxnTrYb6h82BBz6sz4IouHZzCT6E5qDv8+AB?=
 =?us-ascii?Q?d/7SQcPj690NSDX6LSYjtjgrbrFXJfhkuzBIEZV9/z3IjPVkY0h+4CpcEg8O?=
 =?us-ascii?Q?j66VRT7QbwXrwa/ozBovUGg1/P/eXlcrvC4GzJ64wkbcl2HBp/hEM6nOBn8w?=
 =?us-ascii?Q?UQFnt65fUCEz+tMVKhctyTQQFRJ1LOrjaxE63PsrWA731Box3goWjOylaYZD?=
 =?us-ascii?Q?OMlqDv4msTEmW/UJZn9/TTURFVV2LAnAlskIZRPKCYO+V+6AgjYLRh4fiM3u?=
 =?us-ascii?Q?0pfZifUjMwrQa+fv3AnBc+iPvCyo6k4GAStGTo26lEsDKNXLstVuXu0QCdGt?=
 =?us-ascii?Q?tgtC6JhzryDcGK8FJIlWOEiH1K+q0V3Z4ozNQqOL52hE2hgSJJv8BuD5Kn5P?=
 =?us-ascii?Q?ixcIH3rEq2vEAdOyr5B0+nZuZmr6m92Y6ZMVvqey7DHQk7s8Cjn/K7MaLJlf?=
 =?us-ascii?Q?OQAog3caWDgQdwbYlsdwYFcwE5PGJKGi2gJ4sFvOwplz3fAWrtN+S/kJhSsg?=
 =?us-ascii?Q?gqs3zLBPraDdrMPRLS6Dc7r9B6pirnZ4HOsIFHC3zAvfEBY+9WfPLybN3cdC?=
 =?us-ascii?Q?xoB9pMkEj/bHzdiiiVP1RRr6usO8XK89w4Reor5hz1x06F6eBS6SKJYGPZLs?=
 =?us-ascii?Q?FomIjCnaR9hJYAuN7oMOZ/1/m5ReDgV3HJNTEdj/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5d9851-df14-4777-5e7b-08db82a14b26
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:29:06.9043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDhrTE4G7DEI+5g/4HBIgyiHZe3/rS+KWNPrskWX4/SxNY03czTtLULIrWqPPc3UaIJZ/yg3Mm9ZoVTOqzX2BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6687
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/tty/serial/ar933x_uart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 4c3d04c6826a..924c1a89347c 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -749,8 +749,7 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 
 	port = &up->port;
 
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	port->membase = devm_ioremap_resource(&pdev->dev, mem_res);
+	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &mem_res);
 	if (IS_ERR(port->membase))
 		return PTR_ERR(port->membase);
 
-- 
2.39.0

