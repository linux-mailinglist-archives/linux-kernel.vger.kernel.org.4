Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42BD652BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiLUDag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLUDae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:30:34 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2139.outbound.protection.outlook.com [40.107.117.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E301CB1F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 19:30:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auNSYAiPhbaPbyglv4H67SqphGAQHpCtkrCZGdpEOv2vsXNwewiWqKVOSHZHtzdJ9ZS7dNjYydyZ08gnizf3wh7CP5yZ7kttnPKPp6s8+hR/vHf4MgRzlxhSkrjn92iboYDS65sRtULiuuZtOkU/dVYNTuy+56og67zJAAYWTknR3ZvuAFFUvAoujjdK0xrNc+k8BLILUq4eqYO+L7OjQ2mi2mGHbwqHrghgYpWj/pEPVIPupGgGk5in9Nbgb4hS7kgW/VA02xacKsOclVhxoWfagwSs7myvo+UZBCFAdIbmfMVC+uYn7GsDm05aHoXzYLdWuof+NEe0b4kyz8Y1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHTIdrMUoSl/4B0vwPhKRBRdkJUuU+9634i9HkN32cI=;
 b=TBCcyUd3z223Mjrb7R0S0FCkjqL9aZH6TyQhBzry66ucQh6CO+svUUJ5WjTAwKnVvVzC9Y0XCvTjmR0FlFse0C2NLw6uW5CrJvTbTmkETvbn9SBpNJM7CJwlCdgtLKUS3qMTVwSskLOvdnonNkWCpN/XYHoqeWL92oW+NEFQjhVsL3MgVFsfqaZb3R31lNkBtQ4RQuBWI6pQ7OyoQYnv8vx19IlqHSx/+wN8xQZlHld6XuSTRhlY6gJZw4Gq0kUOvETRv7owI6TDQwXfvvQ39Km9x+AT5vUpiPrWGuudjlMvgIwDXG1wSyHMQs5p/MAnzWTJKKfR8wDzie+dO6Ut/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHTIdrMUoSl/4B0vwPhKRBRdkJUuU+9634i9HkN32cI=;
 b=gCwO6Tk7Bqazcta08c68hC2ZZMX/nlxxpsOk3E2nta+1VTNuWM5pPfEh7RQfQOjsRK1sIkwWOlysGAIjg8QDMCTpLGtAiw3MZfxS3Do0AeBrfPCxaplXD2ALDCkgVAloX7GHWC7gWuAZ43qatQJOj4wIhZ70aALfkhGV7uABYLXXnk6IVaOKgs/GKClqfQ+GG50P4umu0qgXtDSwUjqWPNEYaonMagNDHxhHLhqNo+Q7g5gO+axUHlNQKAAjmRMH+EFUKqpCcJEFnACcK9XDNXze7uvvcUEA7Vye8kuvcKAU71lDT1/I2rlS4dlVM3O8Z7fZsOidwlJ/CQ5u6uB6gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4532.apcprd06.prod.outlook.com (2603:1096:820:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 03:30:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 03:30:29 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org, s.shtylyov@omp.ru
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH REPOST] f2fs: file: drop useless initializer in expand_inode_data()
Date:   Wed, 21 Dec 2022 11:30:21 +0800
Message-Id: <20221221033021.36615-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4532:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c8794e-3697-4eb1-9c68-08dae303b559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJvYkODY7+VcdAyLQ6gqo9zRLsKAb2rUg8kVJanVUMBHGWW8DEfdD3vFNgoYuuZAu3XRbjnKXWf0OExiRpKl8LIIFDRQfQmHHbYHof7vN+TMQdd364KjqNLNjQgGKGx8uLh/tfRS2VBbvj8EfJMxLH1+HZ5i8i+c3oH8qMxMc8Kp2Y/u8t3rH6qg+Eut+DGeUgUqzhOSXLkP02v2y5mV0nVu1ip7zRjooSj3NLT2Wv5oiuRyXHmnvFyFVbd+esKEc6UZfvDwi3jo4R7kpmf5VvylHuMFJhX4+Vin4kfMUe9DOnNWw5ZKbSHhaL9T1NvK+eDKKYvuuvaify3iLymPjTXpt9Bbjs6t47W5o5YvdHE8AX1IrI0vBQwgSxFH065hMUYezV6NbFJkzzXZty7BlSV9kJRQNjKa7i9gCdj/e59L6X6FWRUiRFSi4z5HopLVQejiSGPLlVuNiYR22b3G8ZfwOfSi3hzKLF75Ol/KZ9tL/TK7ONT/NUaFLflYq0zH6I3VMz6FG80S98Pu5gEzbhkVuQzojoQWVyrrKbaxqwHqqh2ga1zFLE4og3zZpSs0EMpG0BQuG9OArgr26MRZTTHDbGCN+KgkqG5qNWVLp6qFfyaBiBIcXeYAxa4ivpHLHD706vH3G2bwNnIRebR7s25MjcB1QVwqz3dNrT/Ye5MHB490w2yjTV/oDqtj6z34
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199015)(6666004)(478600001)(6486002)(6506007)(86362001)(66476007)(186003)(66556008)(26005)(6512007)(66946007)(316002)(2616005)(36756003)(8676002)(1076003)(8936002)(4326008)(2906002)(5660300002)(52116002)(41300700001)(38100700002)(38350700002)(83380400001)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wg6+QCem7hQEIo04SP3ZgB8o1nM1HtqxYL1LWRVgiCmmn+lOKcKovOYAZvoH?=
 =?us-ascii?Q?Qfr46fIhorq1PcEuWuzQZqKMeLEl1IASoy+N0gFeEergciCeMfEU9qlF21QO?=
 =?us-ascii?Q?GP0od/u0ZyO9nbghYadhZbr7uq0su86WfDDOdMi4RSZzmQ6UMPDragSIfWWe?=
 =?us-ascii?Q?EQ54DeSc0Qajd3pU5w2YSZqFrcRCM7K+CDWxnWcii1X8l6B5NZjcqnuXo6dg?=
 =?us-ascii?Q?GWota5O9jnP0sIXnPXAXwYXH+UA5OSEbY0P5LdgUjm3LGnwkR0L1z5JKJdwb?=
 =?us-ascii?Q?0uUe9LXPcvPZ+PEjN4rXo3yVmRRywQueHE6ExNenlsTiwt15nZYbSHEfhKRY?=
 =?us-ascii?Q?r73J1i1IEkgs6LzwF3p+TJUOQ9t0htuKB+sOIfUIZc3r7Sbm4xJY2OszP0xD?=
 =?us-ascii?Q?jrNHuzHHJ2veZxvBEPx2sEk+pcCGVRKv0frX4qjvuX+RlYElpuz6S/oX9Dyg?=
 =?us-ascii?Q?AoeLoa4s08mv89VoM8CmekZJBkfomDmXYq+LVjc/aF2sCQrO0vZNmyRsB2PL?=
 =?us-ascii?Q?NF6ZSCQPI8L3C4PWdv7QL0Mhb3UY6slzSiTTvFZJsnBtcQqA2O5AoclCgaP+?=
 =?us-ascii?Q?/pAO1DmVh+5aAA1x3U62RmFhiae0O7KCjETXFe/E2b9l8PFFzo+xPEzr1u3t?=
 =?us-ascii?Q?KmwL8ppyx0kIUNXJVhQWXCXe2+RAAsApPMt1nEiIgJCSyIkouTxElZXOveXs?=
 =?us-ascii?Q?nR/gkHPT32OA65QGuYfAQHxB2egmLWdbeINzTD5YdQF/9iiMvzJ68coJRwAT?=
 =?us-ascii?Q?Gey7IWmgVo3bNVQw2hEEywz8UyS9rRCMiate/s+B5YxYnGGRWl72o+6OROHO?=
 =?us-ascii?Q?fT7dpSpM/e4N5pN99Irz5M3R0htcAXjh8HU/HC27Ijf8ughdfx5QqZjcF7J0?=
 =?us-ascii?Q?d8IAXi55S/NAcrc8Dq1GxEFmb6WI+lh6Pany/FQizifPKKvROXDr/BW4IS9W?=
 =?us-ascii?Q?PTZcbmpBJmuaTiN0SN/az4/2Do7puAsiGkEMNo6bWoE5qcBIapeL6Koydhrt?=
 =?us-ascii?Q?TdrvdkoRJM2j8ikct8wz8As37Sk2RzemTJwz30Jk2I7j0YdAxE8oq3O0FQVX?=
 =?us-ascii?Q?R+YLNJDDz1S/nuvmTN03DEKn/c5Xhv3e70luizDaoPj0rRcLL1+pxWj7sgSe?=
 =?us-ascii?Q?qP3itplu0YFhfr17lpaFX9jgD0pUXFvxyyZuAh6YB+LlDPNmJ64ucLl4VYOF?=
 =?us-ascii?Q?NCmOoAYEQFFoDYZNA3aqVL9iBH9wZDgAnTh4oRwIShTKFfoAq4vNtxQ6DZYc?=
 =?us-ascii?Q?Ms2sXgMLVWKuAtOyQ+bz/ZqRaqESxDkTkMhsVLeDdgHkQ5A/+3yufc7Sf7pj?=
 =?us-ascii?Q?xXnqNfLShh+2ZJYlG/O8NTmasT+55xtxzp6lrwKHy3x4F61FWPZvnC4mtVzQ?=
 =?us-ascii?Q?hkxzbjJkHNjbsT18KXgyrmLebLXqjeH2Pos9qrTYNPq0pO3fmxBkdxe2W6PW?=
 =?us-ascii?Q?iMD4tcitCop0i9NoOqsICAZmbUzke3Yzu6CErvacR1vNgJh/EmFTEHXrLSav?=
 =?us-ascii?Q?I9mmy98frsWFeEM5mMwk3niD01iog6oasS4Q+xjwk2cctK1lBrsRmKc1GrFH?=
 =?us-ascii?Q?OiFwvkpVIf9mZph4IZ8lj6g66Z3PDG76Wc/SD3Qi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c8794e-3697-4eb1-9c68-08dae303b559
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 03:30:29.7364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfEDyUTusiNgtGzueSBWs7Ve2PlF5NkY0GK1ZDSZrEBF4FInQXtC4LEhccx5UnY4XNu1XoJUa1QA6sTDr5NRdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4532
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

> In expand_inode_data(), the 'new_size' local variable is initialized to
> the result of i_size_read(), however this value isn't ever used,  so we
> can drop this initializer...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'dev' branch of Jaegeuk Kim's F2FS repo...
> Reposting with ISP RAS mailing lists CC'ed now...

Why do you repeatedly send a patch that cannot be applied, and this does not have
a CC on linux-kernel.vger.kernel.org.

Otherwise, code modification looks good to me.

Thx,
Yangtao
