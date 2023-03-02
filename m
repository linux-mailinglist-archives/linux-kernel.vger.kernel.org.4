Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1896A7B56
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCBGWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCBGWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:22:16 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB413E623;
        Wed,  1 Mar 2023 22:21:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5jnJ3lC3Mga3DtHjUC4jhNxTTaD70MUGQ/DLvUmXN6mWCYusqwQk8Peag4pwJToaFWSaqnO6NG4T3C9zbeELMm8qjz9YXnlarpcPFFxUYFyFTUOGefBbetVoB2zgo+CXAWuyjPqrGcJGkTB59InjrO8F9pzC0f52Bx70MdpgxZORdTEcR0FsmYpYno1J4pBuF9LaGw1R98LaGY7xeBaLZKgSPF6sON5dONwxz8S8Hw7pcaWrdGt+ZJm2ARuJv1lxspb8u8Ji1vnyyRoacRrWjhLUmzOozOF6kxZYugFM7wwVolHc/JYSMZfarMkuhj0BJlr8FR6EmDI6+FKaBPtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KR3N6AUB3dpuM2QigjG6lOAHFxN5CwDW3fT31CbzP4E=;
 b=dNJ4mt2uh30DVOXY+I6G2ebBiXThFWxHh+xaaakZCoKu4sA+S+LOkIXIrdKcR73w0K+Nu1GpRPrPG5WVVguNZhdOsuppd8S7MDde2bp3+/OscG1ss/m36TE7W8Ab7rFMWFYQs95oxmdZwFqBmduq5/409AYPjBIdI9yERBS/7xj3BehDFa35buz9YiPlyYhbnek11f6l9Atc7f1ajtOVgIqLu8okvfZZL7GkYzMzX9EZ/uKOzSBWFiZ6jBZj/6R3Dge6kJAG+JfD5S9ZB49+jC1P4IBCY44cBuvfPyu2R3eRDqJfW61eV1vKS0RJbj/HX3k0Z2d1+tSB/4zmW+6dIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KR3N6AUB3dpuM2QigjG6lOAHFxN5CwDW3fT31CbzP4E=;
 b=lxdrKCFuqALYy8NXqcObo8zEvkiBG0yWBCc9yhv3NOGU58HprjZHv+SkIIojU3PecI74WQbwZ+GXUK1Mv/7/qBCB/6RbgR8EVyeM43BttLfg0r7n6n70zZ4fiRdp6FW87N/6RbNWQOEjZbeR5ohjzv39pf2YRTh6WOTaE+BdSMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by DU2PR04MB8632.eurprd04.prod.outlook.com (2603:10a6:10:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 06:21:19 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%4]) with mapi id 15.20.6134.026; Thu, 2 Mar 2023
 06:21:19 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH 0/2] No access to CAAM page 0 registers
Date:   Thu,  2 Mar 2023 11:50:53 +0530
Message-Id: <20230302062055.1564514-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|DU2PR04MB8632:EE_
X-MS-Office365-Filtering-Correlation-Id: a873e6d0-4399-4a27-9aef-08db1ae6561f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kW4zSa0NBlEWIsX4UlgfuFG6NfpxyGPiijAKzfFW+YLqOLglSD6scEOUJbj15ExiQ0SaQuyjmIQa0vCva/uGT7hulje1t5pHnx5WyAtuNhFIrRTBktWYHLTWChrQdDd7ZomjlKy9C6UWWDj7WPAL94OkJQv5QIFxFpl2tFYwEZC+3PjToqXOKQ3eqx4GPFwoufSgkw17X3bUkPuohAuwE/jK8NH/pLxSPEd6flw4fsnve4BehO403fuVcVTY3dJNF9X9ZOuHbDerKNhoAHc678hK/gBro581z8pdRC+Ql6aU2Mmx2oVZHQGQnjWKLgNlVfwwi2waOUAUoE3ATtdl8JFbex5ejsbCw1Yy0AG3YM6mzGM7q06epz7YBKNAUmnWtfqJ/q3qpNkiruMO+UqME3yKKWK/sYDQYGqLPKfnN6amwbtbpyeBw6KEL8Y4HuJuN/Z4mUKn7s8BeMHjW4NEGMZuoSYdk0JOAvkDV6ukjlzqhS59biAxkAl3yWd0lEhf663KP0V7L4276RpDEyvGHkO0xJ12yjI3cKxgXOM+5fjJ6kx59y/qYFXiZiDgy1I/krzwQclSZfpItpp1IhVPPiuBXhlHAtURWhXYk6kXd5lCyVW6ffPOIppIMLGkpqVensZWK5UsPx6NG41LmeTIQqtEYtvH8UNKZKhcKc51Xlpy2hr6g4M0wEwGMj8euKE7fPDBfZe0D603fvq0PkZKEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199018)(5660300002)(41300700001)(8936002)(38100700002)(38350700002)(4326008)(8676002)(83380400001)(186003)(2906002)(66946007)(66556008)(2616005)(66476007)(4744005)(316002)(86362001)(6486002)(478600001)(36756003)(9686003)(6506007)(1076003)(26005)(6512007)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVBQRWdGdFRHdTFGNWZHT1dmc2JEd1U2NlJ0RVJPYTc3Uk1RUWtaRnJ0NUpO?=
 =?utf-8?B?cW42aXJPRVh4c05BWnFCa3RsMDU0a3lVMlJmMGNNZTZxR2dMZkc2bEwvaFVz?=
 =?utf-8?B?MEV1ZjhScENrYnhXQ1kxQUx0TDkrUGxrYmxlOWFZWmxyRkNyWDVoeFJyazZF?=
 =?utf-8?B?ek9qUjg2SGsvQll4UVRZZFVqWnlnWkNEU0pIRTlqU1dpdEJTRnlDeE9BNGNF?=
 =?utf-8?B?dlZvU2NET1EvVUk5Qk1oVkFGM1RLRVV6NXdKNEZqQk1WTkI1YnVpUzFaWjFX?=
 =?utf-8?B?REdhU3hRcUVhdzJhWU9vQnl2UWU5a2NmWENXbk9lVGk0ditBYmpLTm5XSUgw?=
 =?utf-8?B?dHppeXRwRjZaMHk5NlorSjhhWjk4V01IRUNlbkJMVXdKK0psQ0hlZjZYKy8w?=
 =?utf-8?B?OTNKcFp0YnJEMEFvVXhUTVpmMzJ0MzVsNzZOR2RPZERjZ2d1b0E1bVhDbDZU?=
 =?utf-8?B?RHZzdVRYZlJZMitCVDJBRWtvRGx6TEhvR0V6dE9hNVRDcjhLZW94UnZFUG00?=
 =?utf-8?B?TTJOamorUUVGakdJZ0pWczRHL3NTODJrWHhUdUtCV1ptc25TNnlOdk04dWNv?=
 =?utf-8?B?dkpGS2NVTkxMUEJlMFZ0T0FzY1pORmJUa3J3cUJiMW96KzFPU3FySnhDTWp4?=
 =?utf-8?B?NUdHKzV6TjhweFM0My9WQ0E3eCtIb29xdUNFM3I2MnZCU3hIYzJGWEN6SGZl?=
 =?utf-8?B?THFWM1ZVRUV6WlpBNnZTcFMvRTRxUHY3dUMyZWp2c1NUcnhGNHJKTU1Qekg3?=
 =?utf-8?B?enRHdlJwanhtblZ4a3dqTlB4Wk5rRnBjRU9DSGFiTTVrZElsaUJ0cUJ4dENM?=
 =?utf-8?B?M05qODgyZmZscGxnQ1hVbWZMSzM1dmViWk5mUnZMeFF5RklEMGMvZ3kweklS?=
 =?utf-8?B?NWkrTHcyTHlSazlNbFo0NDlrdEkwRVp1NzZDSUxxc2ZCajRjSk9IQU9JbkZD?=
 =?utf-8?B?UWc1aXVYekQyU3U2NCtjdThqaGpnNFIrZkRxRVg1UnMxSTJkU1FwOTZOWmFQ?=
 =?utf-8?B?ODJNdmErZTdtMEQ4YjBxajJIbi94blc0NmlrMVlJS3dTcjNHTDV4UDhHbXl0?=
 =?utf-8?B?L21rcXhIVnBabGJvTmtKa3krcndTUnBNTEJuU2lyQTA5YUhNbW5RQ3hJT1B1?=
 =?utf-8?B?MzBEZjhSUXB4RWhpUlNFRmxBTFRrNEdFM2RFOXJFTTBTejMxWjZOcFRLTlNO?=
 =?utf-8?B?M0ZRcldEU1VSNXNjVnVIeTdzZUROQUdJS0lkQUs1ZFJpNFMvQmpCbGxuYTdT?=
 =?utf-8?B?dlV5K3ZQS0hiNWVqTS9oT3VyWmFsNERCdU9mWjlweGRqSUNEcDNBd2lpaVc2?=
 =?utf-8?B?cGZPOWdCb2s1Ti9IUk9nNkthRmVzaStUMWdEYnN1bG9DRG85SHJFQjBvcnlO?=
 =?utf-8?B?czdkcUdmYXRyR0NUUkIzaFJwbVZSOVQyNzRGK1ZDMS8xUWJjREVES1FIVUtW?=
 =?utf-8?B?aldXRkFlc245WlcyWjJudlQ2cm5OYlZwWHFhckRNQmdNcnBFU3Bpay9TUkR6?=
 =?utf-8?B?NXB1Vm5EeGJOT0hGU2JRaGtxSmlpWHZQMGdUTHYxMGpLNGtFeGl0UW5heXR4?=
 =?utf-8?B?OVdPck5LQm8wSXlaRkMzS2hhblhDdkZYQTh1KzRIZlZLSWxUS0U4ZXMyTlo2?=
 =?utf-8?B?c3pxN2pBOXIxV1RtdUR4MzZJcWV5KzlzdjBGUXg1bkFjRXJvZU5XdGptZjAr?=
 =?utf-8?B?U01hODNyREQxWDl5QWExQVpCQnQ0VjZOd1FwVTIrdmdvSlF6emhvU2IyL21n?=
 =?utf-8?B?bWxLQ0xSSnZ3WXlnQmt6UndBeTB3MHRLeVVTcEhKT1oxbVhpWXNjcnhTdjJI?=
 =?utf-8?B?a0E2Rmx5b2hzcXMwZmo3a0RxZWVFU3J2SE55Um0rL0JNMEdveUJ5cEJ4VXBq?=
 =?utf-8?B?di9XdXVXVzNzRURIbzV0UUdCeW5iZ0pSN1lkaE05cEFjU25HeVc1Q0V0Tkh0?=
 =?utf-8?B?Q2RYcWdEYzQrU0pWNC9mb1RncHVoYjF2Q2h1MncwZVJsdmlXcFMwOFRhYkNW?=
 =?utf-8?B?SmFaaWJHaGp3RVg2Z2FPUThBYzhoT1lrdWRaVk9wUU9oRjBoYkU2bWlWYVZq?=
 =?utf-8?B?R3lDNVpQdUh2dVJGWjZxS3lsTWVBaG9QemVKUGVkL1ZGM0puT2dZWXFHTVBY?=
 =?utf-8?B?NEQ2clNjR08wQll3RjI4SHJhRGZXTGN3eWpIZ3JvSGxMMDE5SDZyVzlHdUxq?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a873e6d0-4399-4a27-9aef-08db1ae6561f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 06:21:19.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuRzpM3ASFfm/n5PkUhOl24p80qQ5UO4Fx8Fw4z83kGReJ0fQX2ZsRP8JyCn1i46pQRaphk03+J2FFv8PcOsEJ2r4LWOiGIyKLDDJ56t0UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8632
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

This series includes patches to reduce access to page 0 registers of
CAAM from non-secure world.

In non-secure world, access to page 0 registers of CAAM is
forbidden, so we are using alias registers available in Job Ring's
register address space.

Allow CAAM's page 0 access to OPTEE, as OPTEE runs in secure world.

Horia GeantA (1):
  crypto: caam - reduce page 0 regs access to minimum

Horia Geantă (1):
  crypto: caam - OP-TEE firmware support

 drivers/crypto/caam/caamalg.c  | 21 ++++----
 drivers/crypto/caam/caamhash.c | 10 ++--
 drivers/crypto/caam/caampkc.c  |  6 +--
 drivers/crypto/caam/caamrng.c  |  6 +--
 drivers/crypto/caam/ctrl.c     | 98 ++++++++++++++++++++++++----------
 drivers/crypto/caam/debugfs.c  | 11 ++--
 drivers/crypto/caam/debugfs.h  |  7 ++-
 drivers/crypto/caam/intern.h   |  3 +-
 8 files changed, 105 insertions(+), 57 deletions(-)

-- 
2.25.1

