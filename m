Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626BE74FF45
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjGLGa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjGLGaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:30:00 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2106.outbound.protection.outlook.com [40.107.117.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3F31BE5;
        Tue, 11 Jul 2023 23:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbZZ9B1S4ANNjjFubtxyakVhFNA1VH5CvTW8Irw/C5dEtBME1KXvGs8K/M2VkUBTc8kfM5rdYmzt06T9dKg5DhXkjSr1PemJACxlcx1PHUIZqkjeXyGtMmoFe56jR3c9cdhQBVhDH2XUItdzyr85LIm1ixp3PnmXNtYYC4srIj4W8tHA2xHtCqo/nS+uHPsXE9QHxikmlxohgPtMhDqZ7lHVEOKjRo9mgSZDrKjh/5mE5rdIAtxE6//b6pTit15RepVotZg2LQgnqPHiETaMs7d0k6T5Uq3xdoB+GW87F9Ua4ErsbS0JA3s4Zl+d6vbZ/a0zzQKFmxS6SceNSNYDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UEnLokqPBvGBUxqF5Fnwd+zw0pYZN+9LXv8Zshqa50=;
 b=Pxz3iCosonmsEK0s5dSB/0UVtBFabBb8hJE7ckf+ZnJd094lT3Q/gWydKxy1UFFjSbkkzxhLK2XXGYj48OEziG9llltxT40Tcbi6PkCeAT8TIDRD6B++GirYAqW1k2qFlr0FNlmfJzh9h0ODo+RByTRR34OhqrE8b8Ctsao929UEJM8JC3VuyNyDG/Tey5TKxjDgsEZAq6GxDjRW+w4GffXZVTxxoUiraxjzFePtAE6xTZwVBmBiYjwru+2EYRhK65+s2hM+mGgae0hCc7MCnpHF2hyIEn4BdYCvKmu+UYyJFMwBT2RfjaqqEQHG3YDOJQr4Pcdkz7cWnCR8awAPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UEnLokqPBvGBUxqF5Fnwd+zw0pYZN+9LXv8Zshqa50=;
 b=Fc7QhUw78E5iOhHnW9W5Hfw+Xz6O1afakt8YRagq1v1orYoNFLdxON6H3ZckcDhXlvwdhUXVFtCTS3Up+ej8GKv/9sltuDY27klOE7O7o+JA+0OesOAtSf4EDrWKt8afjhvAyiUMWq990XH92emX5Jq6CPF3ZASKj0Dw2H/wIbutDz709k085NCo6zKb8ZjMyiHM3gjGMNrmWSfNBs3ZX6tPQnUzPb+J3owrM7QoYTyUrSsndSKIcZKEo60T8RJRT+TY0oU4iViL+FlRycL9FRBjJ+gSrPOGtgx6NOttpV2qoQ2NtweIvSQNKnGDBjg2pE+tz47EUzq4Apufn7JgtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 06:29:21 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:29:21 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] serial: fsl_lpuart: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 14:28:45 +0800
Message-Id: <20230712062853.11007-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712062853.11007-1-frank.li@vivo.com>
References: <20230712062853.11007-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB3963:EE_
X-MS-Office365-Filtering-Correlation-Id: deb0dbfd-802e-4d3c-f2a5-08db82a153a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZX5EZYrjFEL3JBuU/MvWuIA0lOnSH+RBqZ04+kXPE26X+3TcfQfyXFSMqO6pJxmQKETx8mZE1ArFGo0cXiNvcK3RiDOf7NfZSHXbQGOqjeZScHl3w6EFPepqpX0wo84ZSCWv0d6FoDnn9BWnzcIW63NsuCb6FQW61yNS437nFCxZmNeuP1rHIDAkSFRQVTR//CSUAGWrkCoxJewpwGonKnFgglkapEjovS77r7SyireUKT/cR2iqfp73NDGpMdljwLtrvIYNGTxe6z6YmqoxHXmDQzF00zGZHP3537WYQk1jv7Vx4AFajndNukZuL3O3cxkWGCpIuCq3nFKCxRr72xXnrsp6rmmtABo7dI9mJHAAwN3HyOlMN9hVj+dJLDtPcjrqSfSP4i4e9ZxxXnsuMPmPNzt6bg+l9S69nP6/Ge/YLYmh2ATWZU5RRq4MpkT+JNbGnF9ijJOYRY7pxpmN5Ad+B5mjvx0PBlQ+JyUVxq2xBtPpFnntWkXenT/bLKUOu4D6Cc052UhohUaEODcfihktiCCJ51yMMqML5BA8vwi8/zsU/SfKZ5RvcteHQyUjVp9WO15gkFZVffUmyb95GBygVMH1PUJ6B65z1QX7FyotmB1C7JG543cHuxl+2aX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(41300700001)(316002)(8676002)(8936002)(6512007)(478600001)(110136005)(52116002)(66476007)(66556008)(6486002)(4326008)(66946007)(83380400001)(1076003)(6506007)(6666004)(38100700002)(38350700002)(86362001)(36756003)(2906002)(26005)(5660300002)(2616005)(186003)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a9RZnztODP63d+JtNcStRHioQXs+iZxJSThMmFwBf9Xi4s0otIelY4nzOmEK?=
 =?us-ascii?Q?zw0ay74I1yt8vo5YXj6yrZF6IvXlrPC0fSRGpbvaJdd3AfmVnbWEkt5opA/E?=
 =?us-ascii?Q?fQWM20StUhpbozgPpctCCXmdF1bBDaOzWwB8po1hNPz4gKY/AuMsK+jVjVna?=
 =?us-ascii?Q?AU9jdhDMD1BgnAck85NsjRw7md3xXgjJzcXAZh0db7bi+rKTZh8NJ3cME47o?=
 =?us-ascii?Q?nXAEdehOk+E3XITIAQYoolyoqv/3zSWBaucIQarRK/tHp6HIR2i2o6hZHzn4?=
 =?us-ascii?Q?oQbFtWty0eaIje+SB0ubXTTf1d006Y7pskki6h1kVfv3Gq4UeQkQrcivE4mD?=
 =?us-ascii?Q?9uqC4CrQPzQHNqtqOMPUw7E7cvRNLIJL2T4gFPIqP8jIrJKu/JNyDK83dD3x?=
 =?us-ascii?Q?AwmzcwEAi+4lWmsDzmAooxsCkfOs5PvlmHSi/s1NrPQJSyJyiqAjJP5ARF9w?=
 =?us-ascii?Q?PAm8rHYkCqCW8wKQWfm8JidC2DF52nBBHk66uMv5HD51wyw508OKSTSDh+GE?=
 =?us-ascii?Q?jT4FS1d5FGvLFQwLmvGYpvlSJWUcBNmDVMzd/6ubgwxO3FTVZGEtLhRoVboT?=
 =?us-ascii?Q?GkWzOVhSviPwyle7Pm1ag5i+VmpIcWakMYqwgifz5ei2W8tsuu98igFQFAo6?=
 =?us-ascii?Q?fuF8m+MnKeerPLU+ZbJoFQ98iblURudeEhzLtEYxkG5cUSb6XozHCLGRHX82?=
 =?us-ascii?Q?7T46Zw4bdsWJWf36PDFqvA+Y8zMi7Hbj82PP9+VQZGTpDGTIPtNr/jSZ6aJR?=
 =?us-ascii?Q?DCdyxUkrVVayPmYobKUoWvlccl2moeJcHwsFa1OCDEhez8MscYkLN1+faWf+?=
 =?us-ascii?Q?jUJ8GmgB2TeHFK8gUVQ/rBEjuoO7GuQ244k7L1U58TGhrKvN3rn8uP7jv8g+?=
 =?us-ascii?Q?jLPJmDiXFL5VbxovY1dPXGXkqvxe4bzQvpEMBnystggs9KjyB66AafXWyDN3?=
 =?us-ascii?Q?p3YtIzSn5oRSw+Iltptm9irMy6QIfcP90gbJuL//R2PikSwmLnXyBdb2rhIw?=
 =?us-ascii?Q?wG9AlvxRpe0X4j0iLSDwL4m4+veuQKHWGISWkiT10lvADb8ENe+5lxPjNAPW?=
 =?us-ascii?Q?Ztn7G8tkNYfJ/HqgsjjMaRBbCJvhdSLZFiqOUwwn42Ko5ot59XgyZ0C5dZyt?=
 =?us-ascii?Q?gsazH6ZlFWkhCf9GC+JUUZzeWrTPUhmAYFjHxXZSqeTScoa341ZyIycfeZ0r?=
 =?us-ascii?Q?SLhWqfOiICYDZiwkruixz1QLEGI7Ipe5T+GRo42EZGIqcpqxs4yu7duydoOB?=
 =?us-ascii?Q?4ctGOVnDuxyg9oqfUxFH2cfSo1gV48x3hTS1r/nTb17p3j2YMw5yju5KazBx?=
 =?us-ascii?Q?T7O5AB+hCCPxGUs+GYgXZcbg2TqN6XxzrIvZdwJPDFoR0CpGo9DLdwrR/7HS?=
 =?us-ascii?Q?GXGoI09f2JBj3WEN/SyT778vtqv++FgkoiMqSkwLfGy0lUPPqtEAh2DKcHKv?=
 =?us-ascii?Q?KU8n/EetNaVVH4waalomD4tDrkGYxMzjEUjN0INuuhrOAAkZukcM5e/iqsqu?=
 =?us-ascii?Q?sngGHA4mfbgytTyXZbU2iptYyIIRLpHmpJem975ySqLS7ce0SbWofjDJQ2wh?=
 =?us-ascii?Q?9XbBvKq2HTVjJjUgz/qChlJNiDWEbAEnfbDzEQk0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb0dbfd-802e-4d3c-f2a5-08db82a153a1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:29:21.0249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9mT+duMKKuiUXJaNLNs1qBxgNQG9832e+ZG/2Zc10RXgL8gXdwwBBkGeIPQaG12Dpb0H5oxng8adN4zc70JVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3963
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
 drivers/tty/serial/fsl_lpuart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 4d80fae20177..b04951523c5f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2811,8 +2811,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	if (!sport)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sport->port.membase = devm_ioremap_resource(&pdev->dev, res);
+	sport->port.membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(sport->port.membase))
 		return PTR_ERR(sport->port.membase);
 
-- 
2.39.0

