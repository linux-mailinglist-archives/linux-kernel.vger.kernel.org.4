Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310D56678F5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbjALPVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjALPVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:21:12 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D139D93
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:13:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cR2GJxYiDBWuwHQfNctRQRbOFDfhcfH1Sh9i/iIstGAljToeBaNMVw+0Z15TNsiUu7O4xbWhtdVMi32LpFKCt1TE6deceuzwTI6G95QXG6TveK6pn6ke1gZN7zAcqLmYM/bcBtuZU1Uzth6iXVoFPrNs0gRZiLGX7HyquBQYkDhCie9U6eBIJLD9B1wirD/9nq9TaqjFWkhHjrDjSG3RWTBXi4CWYFbG39JpCJuvOzP/hzcmNwSoIb6K/ToCHt4StO0rEI5+iil33WqXqOIVBUPl8inZbOZJJ0evDs3aQovgzdb9n9MrSYpZIxeaAutXf86lNHa5U90FOxref3WIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qu0zBJM4Hr0BlEu1LMHIvb5WjxXyz2HMFpMCU68o/IM=;
 b=co6iOaBpelJS4v0Bss+C5eLOIkHDYk+OZL943dnv0u6mt0KJkP0+5H2y0b8sisYbkex2gcISr9vHmVV7WEOK0jA03Ke1OExyD8awj33Apba7XwgZCCto0hfjHc1RLw7ZaPSAwzPU+GSJdeMSKbWebLOTxh/OscU/kNVtRoV+L1BdA/j6b+TZEBbFGdj0AW4o8TWWa6tfSLrOCOcYq5QeqzHPeK4czjUXXS2yR6b5vYN7YC76gdAB7dtxpcwl5a2CON2bZFqEt9pDpcTZRMwkPpI/spwv+a7bcRuxNN9C2zCI3Z0U2VLr8ozDJwG3AXD1FuoMHIYWCXJ2OXpuFDqjog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu0zBJM4Hr0BlEu1LMHIvb5WjxXyz2HMFpMCU68o/IM=;
 b=aJEQmdEDHnsx5fc6znHLMQtpAQ0PlpgYwlWuWlNXfmMRAQV+bqXr3BcjrBLYQL5EVaPrzQ5KUX/amihIN5UBrrSchTGoE49seXR1cCJryQPZfS/H/P4y+RgUGoOMv/aw+CAJJ/SgHi6vpv+UvU/o0d7RcsdcnYV4kUq670LYge8Fr/tIsuDrS5zuB/0pPR7cUjW0dfjDouneb0jL7OgfWbOHnZpmahqShOQGoQVJMx3igJeMQEQya2CZueEJKsQNAJ+SK6W+xEPFU8iqh3K/Ps3QoCJF7JIeYBASLqebjMKwWYCkWjMy621VmedFPhrTzZDWAQjRf0Io/1UcJelG5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5460.apcprd06.prod.outlook.com (2603:1096:400:32f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Thu, 12 Jan
 2023 15:13:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Thu, 12 Jan 2023
 15:13:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] f2fs: reset iostat_count in f2fs_reset_iostat()
Date:   Thu, 12 Jan 2023 23:13:28 +0800
Message-Id: <20230112151328.29124-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Y78LNobSXGF5N3tn@google.com>
References: <Y78LNobSXGF5N3tn@google.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf2817c-bae3-496f-d021-08daf4af944c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7ncpTRynvLzu/Hi374WnYPuXjlT1kKLghVUDlKCIpRZyVLoPgPhlqvhYujziN6SgKzyZ/Z6FvYje6/3N6Px7iqcHd1XmKKOEAfVscNJCRMnV3rV1MhPN/zrOb8tDToV21/rpGjJSErZobXXbx930AyCHEy6rrwednnVEooDBJewUX5rzIpYVe09jNJXX9kpCWnzsVweBzeLb2xSivaTln2LHM4dS3/Z6dlXpJDgV1weiW//GqRS+/+1GutvICGNjVP2S7B8rgQ2qrg7mtIyaACX7nV6L4Fbd4PCOh05VEp8ZMaKkTFlo43DjoagTgZ4VYN8M8q5YahZiS0SHdof1vxQt4gKPoLHVk+P8SRLvi/JVaL/VItlZkzzg0LFUibkWDyHjyRLnSNW8sCyAxe5CXwXoF4YWTHMAcFkj5cBwZTYpKQ+JRkSsBSUXJ7d5PK2LoD38s9xE4lU7O/T6VDy5V35iAaX5cJJTDVxmmWaFJod1aiaQLqULMI29shLnPZUIP6ECIN8Gad1jB+Hh8O0E8LGZ4J1RCYdtSbNLf8gsMUwrKB5UggOVUg8FTY4uvRiDDwjNY7dYSf24TeGDeV+ihZz9f8PDSv3NElcrsjuxvK/zn68YhvzjLxUaVGYKB2qPZdUPxmp8mu5d5AOJjKaB41N4KBLyceQTKikZKTZWh4EtTE3opTz0iDahwHW/8N3Vizj+aHvQX4ThhswSTmhl/bdctr6UOUxIDwL+RyF3Kc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(38100700002)(83380400001)(38350700002)(4326008)(86362001)(66476007)(4744005)(8936002)(8676002)(66556008)(2906002)(5660300002)(2616005)(6666004)(41300700001)(186003)(6506007)(26005)(6512007)(478600001)(966005)(6486002)(316002)(52116002)(66946007)(1076003)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ECJROhaOqy84cUKAI9QExPiiZxaYvmDCt4Ft2UndvwiSy4pBAiVBufJ4IV9v?=
 =?us-ascii?Q?zxOT4ld0mEJlim3NWx+ZOkLTb5cunQPmY4VYYOjGtFpyGDLC0fZSB2Y4IFSM?=
 =?us-ascii?Q?habWk7ng/2bRWB3GwwonjoyQuxhX78KkZQ/l4RkpwR9veMlerAtTHedTCsIO?=
 =?us-ascii?Q?/jyFDcnOyDJc2JNIzL+U6ewCn3lhtU9MazNsoiISbj4F8FWr22gNqE37K0cU?=
 =?us-ascii?Q?vWj3q9OXtML5422wV5qRtt6M0kerVGp4N3/beAowPQWjkBQMPg6xQMz8Ml5r?=
 =?us-ascii?Q?8YTSywF4PmmsrLfO3jrtQZlfO72biPwNwk9iRRDeaVvZDY5aUl0DWNsMkV7g?=
 =?us-ascii?Q?BitiRNVlrINyZBXVfnqyA8e+K2hQ/L/x2fmga9IAJxu1pu+fu0keXtkXmLOK?=
 =?us-ascii?Q?8zOzL5+JLtg3jW9hHjuEMalwhWVTEwp6Jn6d3GgyMdOn3x8EZPJNof6gWxWp?=
 =?us-ascii?Q?EdMKzxVfYuzvfFe+rqxhhKD9YNKPhSixpd3tKz3oizO6h9ER2rGnWpb/9Fal?=
 =?us-ascii?Q?cXfBzbE46hV+2NyJypqIghbrHoThqFFBJkAVx8gHs6tzJ04imOBQlAZQM36j?=
 =?us-ascii?Q?PMbyUCwYOWCrztr5OP9akq9dpSF0wAVz7CZtwa9bRVxL79PPQyE94x7DOgVk?=
 =?us-ascii?Q?fOJdtG1m5RiDqWHRtmcWeOVi23gLurbv6TFndLUiDLYh8+W3DzZJgjr2vUdO?=
 =?us-ascii?Q?AS4zdRX0rGk5txOA96r4oZI6vaJ8RvyKrYOtYUt1Y182mKZFWy6DP9Lv0BPD?=
 =?us-ascii?Q?9nr1U+WAXs5sluT7gsoRfNX5P82Yqk95f7hjJZSsVyA19tVbsnCdtLdNbF9b?=
 =?us-ascii?Q?8PUlbBoG7Snx3l2kukNxMGH3i02HpjTqG7Jau5v4tysx2+U0qO/N2nU9SHEM?=
 =?us-ascii?Q?AAM5KZz+dCYB94J8ze5MGzZHjxsbR2C9LznR5t25+2D4G/e/8/1sZdVEorJP?=
 =?us-ascii?Q?qMqwcHe2P+UaiDyXgZoYE3Mc6SCRD5ICNnKtnN2UomDT4f3OoNQPa6hu5sgC?=
 =?us-ascii?Q?CSmeqVXVnsyXAXYgQK9CySfpqrLOv/ouUufzjPN0/iwZ4hKKRHMiXmrY66sc?=
 =?us-ascii?Q?3Z0/4hbjaQ/mcIkofrXJXhru7rlxZsy5QEIi4Um1HRXlAVLxK+Ih3y+O6gLC?=
 =?us-ascii?Q?v7nBn9hcFUH2j/oCwKNIMzJM+5QrsnIoFsvUtcHDDPvS/UBrtzs0IS6cJfY2?=
 =?us-ascii?Q?7z2QxKE5aqJHXrTQoJS/17p3bJTcVZP+K9G1CuQP+EEgXaRiRX2Czmy0VAln?=
 =?us-ascii?Q?B/Wf1xnQbyrTQjJFe4yimkDBzcrvIxbgDK05d+jN2n8yS9V/fva7P4ezQF08?=
 =?us-ascii?Q?8uFWgZx8jfLsQIsIQnB3PQOhCT5L7AcxJdmTB/AlNh6EvjwU1eWRvKOGPfB/?=
 =?us-ascii?Q?GaoHaWGRd0z5hpl0fIEfqEVqbAfnHS32drpOdLBVnvoXDW7x0Z7ki8Mm/zbj?=
 =?us-ascii?Q?0UyGVmtS4qkVNoyrBaa6xkXBbpAi35wiZJfP/NL/08g8gQuFP3NZXoXyIKVc?=
 =?us-ascii?Q?ebF9HKOuwvCP1m6OJQGgAxnE7El8e0S5BSpmpLz7ssiLvy+DnV1+KjbcMg0m?=
 =?us-ascii?Q?5DKOc13Gii/tmn+eSSDJpjs/fGmBv0kfDisElOCy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf2817c-bae3-496f-d021-08daf4af944c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 15:13:37.3049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DnC1Pttgxw3X3J4n5Axlnhedf0R9FJnM1a+314t/btdRwHaI9rxcIFaoCcpIVW7d39WOwoWdyYwnfu8Zk6VOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5460
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jaegeuk,

> Hi Yangtao,
> 
> These are all in dev-test branch, which means you don't need to stack up more
> patches on top of it. I just integrated most of them into two original patches.

Ok, I'll merge the previous commits and resend next time.

> Could you please take a look at this?

LGTM.

> Applied with the fix.

Thanks!

BTW, I would like to ask whether it is possible to maintain discard in separated file.

https://patchwork.kernel.org/project/f2fs/patch/20221217132318.37718-1-frank.li@vivo.com/

MBR,
Yangtao
