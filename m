Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268C06C5237
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjCVRT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCVRTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:19:21 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF421C7FE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCkOnrnjxWTvZtd5lpGFXZE/s6fQnO+Nuoi+hMwtxlrHHbVWhHtrtTjO43kN9JbAK34/Ws1ZLOLA4LZ5YYl+rjZtcBm/3TSPDJd5kgq1z574RmXhLFPpAADVavdt7wBP4G3LNZYQbhgtBekz1HxrSWB9CO00u7rVHrLj2oAHfqsXwPdBCGrHAGEh2gLoUlbo9UnraWo1VJZsZpIY1DJdZ4iARaCTCNx3X7zQIKMkP8SEf8u2GfNzqnDtEFx5YNm5TqE7G6yP+92ff0wpln9XAdO9gLuUPZ0Hiz/njeAr+W8AsKjXKsh8fMjtJxJ/R3RMB8ao+IrT4sBqIDmUet40bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRurLv1Ed3kltUm4si+KO32XsTsoEFyabeSF7dJIWPc=;
 b=nJx7des55Rz4tAp3fmqYWcILw9e98ya4BDxsrbO/ncEGFYBbtJFxqYPRY1o9HbeQaD7yOOQqMFw4G7NwzGcQga3gPGiimZbi6N4i3k4RSf5zZaeYaQchGZmr6kyC8CNQ9KzT/khU4YM1z7Yt65XlLgs316KBfEJtmdE6uqTQtk9+zbuHbNjbJ/LShoXAlTSD2Up9Nw86qNqcsa4y01JMSs8hzI+96Ew0Klwc+6RLryRbkcE/BdbDTaeYYOcxIQIkc3kW6MichyhEXrdphHv4s+DPIoICno9cRLEdlgACY4HtCiauz+mHd1RhBEdom+Vm2T9t3D++Ja9LPPu68vu/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRurLv1Ed3kltUm4si+KO32XsTsoEFyabeSF7dJIWPc=;
 b=OxKMyqrFFmDPLoLI7dCiMswsPAYHGWh44hlRlwYN6jQX3MSNxW8G8fJKxNROt7Arl+KHeg9N4KFJPGqfmz9NT5PwcJw6Yttk4ZJBURbTlESEHfxyExbXntk+hKzeVCReu+FjLpa4Yz6/6SelgKaCd9xKKeEaCZH0SdLXa93zBfiNOODf4vsY6okhrIA+CgyS52UAixzJnFzwpxOUNGhmf3uc7tvEpqfPG+cRXznnTe23H/mYWuF1g3f/F+JVzD0XBP4dVnd82A786h0MsmX8i9MV0RUtCA4wdJWMaVUEDxKc9xAXZrDJ3SUhxnOvie5YED5zZLbtRpKgWpl8TaBUWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5654.apcprd06.prod.outlook.com (2603:1096:820:b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 17:18:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 17:18:30 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     gregkh@linuxfoundation.org
Cc:     frank.li@vivo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mark ecryptfs as orphan state
Date:   Thu, 23 Mar 2023 01:18:22 +0800
Message-Id: <20230322171822.60275-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <ZBlQT2Os/hB2Rxqh@kroah.com>
References: <ZBlQT2Os/hB2Rxqh@kroah.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb099c6-c6d9-46a8-11df-08db2af974d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auHx2y+7LpzZOY1B03bIatv7Wyz2kl4tUsdzN77iIIsKTbTH3UjbRTl0Q/KI4bzgsZDAHDO2Y3nsebmuu7lBaXHhZu/Iunj4zsbLPGbsimxqIEKVeFgJUM6JNUGf/7IvCTCPWZr4cZH1XQr4M9lX04D6LnOKYolattHaC06VDp3FpfUxm0lSrgHzLuqqypJ2UH3Hsl1xgqgKNnjbumh802C+uSMtEwNeuzGixdItBJYc9CBdXO9rB0CUZYd3YIB0cHPutZYAwrKXEEDT6JjSnLIZWyEyw4LFI+GwXpaIkRIN/6xYRUsZg3HCFprZroU1ScDR0NK98uoxLILgCzLriYLVyaL+EAfnWlMGidl6t2m+KErnAQB/UDcnJu0MZb+B1Rjk1oGM6f8OscrTCdGqRaZv+18Y8aQ7nhVviNmJvjfkHMLP7Y0AsmUvlIqDZ8StFnxmgW2274xMg/IjWaA2Vby61q3HzdELue5K78FB4wCAvzpwl6/a2rMOWElKd7JAImOYVfLTCNVDwz8YewxPsocB+A5XTvhXxPKoPrSN5ThcDPyHbaxHwjmftPkA1Mi4PLi1fHv4Sno3Qguh+MUvp3Iw+Dj++UDpB4Lq3yQbF3rOxjToIR7xsuku9bGen3FRMahtRde17EyH3dxPs2E4PzQAnfGqfkyNnyKFbjdBmELU7tPFWE9LK5ujL63DTkjSszlGWjop9RC2XKjDdbf24g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199018)(2616005)(6506007)(6666004)(6486002)(6512007)(1076003)(66556008)(478600001)(316002)(4326008)(26005)(186003)(8676002)(52116002)(66946007)(6916009)(2906002)(8936002)(41300700001)(5660300002)(66476007)(38350700002)(38100700002)(86362001)(36756003)(558084003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7FE0MqKhs7gzLdScZRY7Xrv/qVnE0HbYAZSh1C9wT6Uo1mCgEyqJRj6/6h7r?=
 =?us-ascii?Q?YIshqpPAwD+C5WHgrtc/9RQ1T3cl1mAs8l/HxZJBnt1L+CpcWgvVBEZJrYOR?=
 =?us-ascii?Q?7cWIibWc/p2r8IKm0VdVUeKjHgwUJOGCvjv4Pl/Z7afZjirXFQPn7Ld2acNA?=
 =?us-ascii?Q?LddpJ3XrJI24j9A/bjBmhoj5CGau0NmrkNNS4wb0Y+A6WAaUPd7IzLJV+DzF?=
 =?us-ascii?Q?8+EvJnC37LRdByedFzzvojAl25wKrC27CBNgAcGdEypt+M95py8icDQbWBOD?=
 =?us-ascii?Q?UIce6KfxAFuEVNaTQYALqEUGxXDMCXvsWp61hgACmG/blQ0pQ1oHk/TuxiMs?=
 =?us-ascii?Q?f/fy7xojlybrHvf2E3eSy60SkbX+/M18rKpOuYQ9+Ut2Wr7ao/2L9RLfJezI?=
 =?us-ascii?Q?uikX09L9hOtslrk9XCEP1vAiil847kJ+ZmuL/yMA4eNI9YdopWt3Bi8Jxq/z?=
 =?us-ascii?Q?PjUWYNPa/UdVW2OPEgyGnATvpmIBtM/fp/uQ07OBFK4G7nTp0npc6Ifg0ypP?=
 =?us-ascii?Q?83GGG8dEM0WuvbaxgZyoOJxbOEwUVMBH7qK7Q5tvaECv/kz0kHboEEebi81e?=
 =?us-ascii?Q?yaTgVs2fWvrLtuE5paT73YqyL5cWchoUppk/1erdhrx/hPUkgZTA4H7UxaTk?=
 =?us-ascii?Q?L79aJiLEYq8l0a1sHoJxjhSbOyhpFt0TKLDgEM3e6LHgC+35lU8TCMhHBz3K?=
 =?us-ascii?Q?Ykdm18izKbPel640Hhoi620zQnr/ZoN3JKZbIi++barKwKlRnOJkF9cMHJW3?=
 =?us-ascii?Q?PtAWX8aRMuPNVjS6OLPEgCDHQJYaZJlp1dlTC3r9idJu4qzMujj4qHTC52WA?=
 =?us-ascii?Q?F19ekDWnIcEIZI6q/Awygc+/IDNGpUPD4EIZM7W0TFHsOp8fI9qAi36gNgin?=
 =?us-ascii?Q?V8OD7uGpaz/21wjfhT4H4onOLdf97wCtk/oRhLXb6KrV617BWHQnzClV3WiG?=
 =?us-ascii?Q?0jPBB6vMduQXUDbY/iIkAtt+eZbuGirKRpi+dq2Y575gA1zzds8PsjWgSv9s?=
 =?us-ascii?Q?Z1gm/2fVtQ6Xp5RqouuNKDk00AgRMlyRSI3HsK44i4Qu5PrIQHA07+es0IjV?=
 =?us-ascii?Q?zieYNZDV8NQHu8bOXvonJL6vGHNhipS+fpfWppIvvChv/A0uuLXYAZ3iVrr4?=
 =?us-ascii?Q?ZFEpKa+pEwySTdhe8ES/u6YM4uB+2kj99U0+EuJAtsKpteSXL+R42obCp1e5?=
 =?us-ascii?Q?nu0JlQEv2umf+2vdQrxeN+yecw0tvkuIYxpl8UI1s/C+kTVZg3axeRELnT0D?=
 =?us-ascii?Q?f0oaLNImorjeuxP4kZ4LGeehRQD0aVo79OgXme7W5zb4CnYe0RgW2gQtNMEf?=
 =?us-ascii?Q?fp7PaaY0oA3ql0ApG80pIS7k85R4SPsLy+AejDkkD0vC8o0Wow8npTi0g4E5?=
 =?us-ascii?Q?xRi3LL7oXCXfxmghOnuehw4yN0N7w9IuEsE+s1ASAFPGIUT69FeVWRN77Fu8?=
 =?us-ascii?Q?Q7v9twLS4IFwFALLKSHMf4QJXibDcpv4eQlhoI83tYsfHm62xr/Hez3xmq7d?=
 =?us-ascii?Q?brsOpvlqA3vkPbpIwQp6ncvij6BXXlNQLUZrP38olIBieoOGPs7dZFV+thK+?=
 =?us-ascii?Q?1Y/bByhZZNoCALjV8Cc3aiQItSgrFdLpDs4kCvN2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb099c6-c6d9-46a8-11df-08db2af974d3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 17:18:30.1082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSO5qGc2eurB386BqRwV7xtNPkMrU9oRV2/Um8nwkg7F4zb1g1zxIvHwEdFKcuBSWIVuF8lkQ3+IRfia05STeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5654
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc code@tyhicks.com, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org

Thx,
Yangtao
