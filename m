Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127C1649F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiLLNGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiLLNGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:06:06 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2105.outbound.protection.outlook.com [40.107.255.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF714B57
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:06:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7R0vSbLy5bDlU5Yxf7wv3QGss/Qkt3Pfi2cRyp53CTRr4wOsh2H2jAFiwrLTGoWr3ZzWQIAxiDYyKXKR7cyxIvL+Gx7FdEPmkucYC6+gKl6fMPLwIebJR9lkODxY1NH7yOwNd3cSZL7kuhgBAfD8iMSbYtGlBlddBBD6WNYO6kLDEdjVhwB481GXDflbEx6nh6nGJFNpiNTSNDRTusCkPioNh0uivkMeU8hOnomNY0CkAvBM7yfGv1Coj0/2SxAwSY6jTWhg3r/30dp37F5T38/tzuOYz6V8fB1uE17hCt59QDlIJ1ZiWhOyGNeBHcrU5KtQEKtHlNI9G4mOjXe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFBXN07/yg5Nlf7myR2alo2M6bm9JpaWBB42W8Pjs1M=;
 b=oQSK5JpmtePwtPTiHLpZxp5zVdN+8v+bEvuS0VGRvLp1BszmQwlb2lt6dAbsggIDwoURt4ooAxPS/3BtfZH9jt9uldVq06xP3lJufr5P1PmEsGbwMXikmUIJ87VMK95zjNhvs++3KcEiaJ4Uk+zTwVg3d0BT+Bgt2pqEGV+JtnteyJkW4kplehobUA5PPeLmw4Yb5/BNfTtox9Mtiy6PdMKok4gP4ob6fn2/5aHDNN76NOnqpZCemydRAkDsgbAAuqojDTeNqs1uq5svDrMwFN4D3SPGqXX/2goJ2P7hjpbPPiCgh7Yc/GGtuNXrgFC1lhXEZQhnuEmTsAaMPZgGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFBXN07/yg5Nlf7myR2alo2M6bm9JpaWBB42W8Pjs1M=;
 b=FLqy5dqUfI0EDI+w30lDjCgUmDHCgusWhlGr0BTFJtC/RAoR9w57rKMdowZIAacRG7H24ZEAOflOrKSsVQwYAF4ibUD3XO56bIbmFFSbmHE8JN7tWkMKgi/tPgRxaGteYFklIjjsiajmc+FCe7OIovJ6B1G21RoMkD5cLMsIH2e69xV6Un2ICoMq+WW9K4bj0ls0WTeDoRE+nJVjQdeIsT8YSnBGyh9woBM2URReIkfLWdRNJSs5RMpgPC+nhk+fG+izjJ9DG7CZ1BKUhkhL0FbyAPYkNNP203Y0n3OBRIfYfkVlY4ptKDOh4/+MmoHDLSSpxwc8KrDnw4DMs+lVxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5698.apcprd06.prod.outlook.com (2603:1096:301:f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 13:06:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 13:06:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: don't call f2fs_issue_discard_timeout() when discard_cmd_cnt is 0 in f2fs_put_super()
Date:   Mon, 12 Dec 2022 21:05:54 +0800
Message-Id: <20221212130554.79049-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <3f2c81f8-7946-d2e0-8768-6f0b03282944@kernel.org>
References: <3f2c81f8-7946-d2e0-8768-6f0b03282944@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: de9173fa-8fe6-4e50-d074-08dadc419f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AWtRQGC/4OGC+wFvyK08KxpARD14fwHUpXrCAsHLh1U5hZZUlJIliWazZuvw+Zlcf8RrBGdW2tKq3D9FYtvQ4sccLmy038tkca7uG6V2WCjbUeFoY9LVRgN1io4FMmJK+Mv5fctqprwMAe65kB4SYSsaGzDp9BI79zFdE5p+nI50kweF3WoSaRpsumkZq65Z09mtFIiorDQoyrw4nUARfuvEVE7cItlPWvfvlzAf33kEUHXw4a6WBcbgLgiKJWK2AYzGqGvB5Xepq4/uMHWqNpl7t1e8eicbrlJCK7Fo7JPRqVmUK6j7q4X8tkpXGe6JW3D2pwGp1YrPV4+01Ifc8mn3GKVi9RJ5kvmWN9NIlIqe10diUJX6p8luVLk5az2hFfXDrNeH9PqkM/EksgcK89F8j8DYivFRhI7+YDxeJDcnz0+WQGObAmk5DofQr/GFRhWWUoJgCGp7Fw/aYvg1jI62BjSEq5cWUICxwkfPWNG1Qe07L+l/PQLdy6yHRwe4mIpVhFwulTHU957ZNLkNYXkdzCnWwFTAPGg1LWiiT3KJSdaXdt9lr/RLnmORG243nR/sC3Lm+mEUL7XPlNhw7sVSjrk96wcaojbQXm9vjiBU9QlGMc437jcj8hpPfBZ1PeID2Gf1MLzIWxNTLvVh7Sq8IULJjewKxEKdA8N0roWthibKyrNahaWsjmqZ1X1GIYMZjxDsKBgKuyPXrz7zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(36756003)(8676002)(41300700001)(66946007)(66556008)(38350700002)(66476007)(5660300002)(4326008)(86362001)(38100700002)(478600001)(6486002)(8936002)(26005)(6666004)(186003)(2906002)(4744005)(316002)(52116002)(2616005)(6512007)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?16oUwSMmVmyA0bndqrb5uCflwGRU9HKb1RfY9vZ2dYgWD+XQJPjTMZxsHeFL?=
 =?us-ascii?Q?9J5tCuKeGvpK9kq0abMhWM/gR0nWdxurlCOC5HoZNp/sqVc/0NghE1Rk/OXz?=
 =?us-ascii?Q?Gk8rKG/DpZxfq6Kg/G/7hHbDM6WRUT+KoUWw2CHpAZTUZXAMWTLlLyCnm1NA?=
 =?us-ascii?Q?j6edx4Wkl1DvXj9nXjBRvQRruC3G9fj8a/supmNCDyNRdprMMsSX7UqxWcI7?=
 =?us-ascii?Q?butwn8PPgVhzsR94R69xck4/oiuLdaBhGKJ6jscnKnMM0RGBKkH2p7JQDUaw?=
 =?us-ascii?Q?a5HE/UGQYUf/M6HW4j6LUKpBR0f8VQjf1/5EyggvrriPI73+2zq2ADzajRJY?=
 =?us-ascii?Q?Vxnh+mIvM4R0vJO8J+6/RFje2aXjmYA8GSKBk2IhoaatSUo72wStfuRNKNKv?=
 =?us-ascii?Q?VX9RvB4kFn2t9E1OVcC0Lc7Oi4YdHxayMJuU3NcuOVbR2Q6F54GbxpE5kk8x?=
 =?us-ascii?Q?mz3YZvwpZbA6WlkSTO1NI8DRn+hFK4am340DOnEc4tZ0JEFYfaAc20IiRio8?=
 =?us-ascii?Q?jFJM/7LNYpwFTLLUUZfMgyfzTo3REHSoiZjqTsIM/Ddu8YWlOlTKaMYFH10d?=
 =?us-ascii?Q?HdwlEWK3nJftcO3rOwxv5tu2ZM1stcJ/43RUwD4boB1rd8Wyh+sggB8G+VzB?=
 =?us-ascii?Q?briYvujsPBd3iimpKTkyQqEnpaDYLoAxMRKln6+uTtBVsnNoAJatAj3Lspbn?=
 =?us-ascii?Q?+mms1CmehB48cz64AqrqJY3QC6hwr7/0uHTv51rrsElG+P/OhgpdOJNo/fyo?=
 =?us-ascii?Q?POy9o4ot8j4WXXZx8UyqTvrwHHo3YcnMYXU2O5lT/IeoeN+VhCyr0obBvf6E?=
 =?us-ascii?Q?/xDTx4W9SH4bu7/Cm1fbsUMqLNUocjl5zWsyB7KO7OD9J/ziYoVgOfyp/zK+?=
 =?us-ascii?Q?bMf2j6SQ+7lLpkWEiEhTSLSMqgRydVDdkESkLR3molRGot02D17Gzyq+j6u+?=
 =?us-ascii?Q?Y1sM+T42CkrCqjTm6UIdt9KU+mcS0CmvW+HTPRbd5LmfQdktnRXXlv+v3D+W?=
 =?us-ascii?Q?kbxH5aqHWiZH20GxgHQkRBNvRJie3ojYiKRCzJHWBJNfzBP0EKUF+x6zVkD5?=
 =?us-ascii?Q?TlM3M7ydSkBDdTKO/vth3nWfhmG+HGY7+qSCW/a7SSQPC7hXRKT3ezwoObRe?=
 =?us-ascii?Q?ppDOxMxjLVH0xCjeE7qfVogbtZFlsopUNWlzt5cWN5kifE+1NIu3Ou99JsCj?=
 =?us-ascii?Q?KoJum+JsugOye5R9FzCMdK6cwZ7lSErLFkPwyeb1EBZ2rhvn7iAIeBIh5Qos?=
 =?us-ascii?Q?KaIa9S/Imlup+ybWf0aL329yjtvTRhinXytb4eQCOXTdh3lJQ5HBRSYBeq6Z?=
 =?us-ascii?Q?1+39cHCnMg+O46X9S83ZKDYoUfTzrcuzv8JIDsygtzbSm1a62GbgY4DimT8m?=
 =?us-ascii?Q?Sak8CmdRBf/cdT+3m4OUd6H9WK23d9za0k4iU0NtALoHMm7b8wok6E/YLXLf?=
 =?us-ascii?Q?28sfL5wXY77lip1rYSTtrHLM1IYanTlSTeuyeSsRdPugngKUiTvkL8lUsIC+?=
 =?us-ascii?Q?6AvU6toWt6ssOGN8LvZHcwAeiszr4VjtVBz89EketgzS14xUZgz61Qn+4xZr?=
 =?us-ascii?Q?7DTadrVc43KiEz+o80i5v5RF5C84RmsMTGAnA2H4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9173fa-8fe6-4e50-d074-08dadc419f28
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 13:06:03.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KD6uiWOp6dM2C9U0bkfkcco0a5tpsoBsjxfRULO96YYiTHa7seKPKkykMmTEzHLKniQ8q6MbNlwvZFaZt89PEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5698
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> static inline bool f2fs_realtime_discard_enable(struct f2fs_sb_info *sbi) {
> 	return (test_opt(sbi, DISCARD) && f2fs_hw_support_discard(sbi)) ||
> 					f2fs_hw_should_discard(sbi);
> }

> It looks the logic is changed?

For a storage device that does not support discard, and we have not actually
issued any discard command. I don't think it is necessary and f2fs should not
be equipped with trim markers.

Thx,
Yangtao
