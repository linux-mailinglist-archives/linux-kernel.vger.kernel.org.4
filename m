Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE4160C1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 04:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJYCdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 22:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiJYCdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 22:33:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4474511E472
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdXBjYdwMidlhK4pb+kHISqBtK40k83ZxVetXd9kBzi05UxKMJMiy02t3zFGTKdtlleaRDyltx0SlQL9SrfnN3TjeZThrpycuSH1rb42u+RVE4GcX9ldMBHchOlkzY4zsHoLyJbcZG4Cmhz6CXutdurisNP/wrOo/gTTTS1SsxBjto/CB9CiWAGon2ZjN1BCPSdY6kyiImko9daJfd6s9nGTXhi2AuO2d51KXr3hiuywUA2gmyuzOLU6Uvw53RMPucXkhItb75evsH/dRpzwBW5Keo0fXfN6I6vU3Z0J2JYWDqySm/sfnNV+zoxkNSTkA+bHSmJN4I7si+Rp4qMYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MpBBHOKRwbqWduMEQ1U56Sy+6h8GvWYGHGjEz5vYKA=;
 b=BUv4GQ3i3KGcXAH61wQApGOk0xI1y71Fim2eOw+9MSK8PMLM7y0ksUIkwHtMS5nDLhv6foIiuBLChxRxBv15UevNnRJwnQp7yQMzoKnnjPClko1QwHj2COCt6lHXMHcXKMzIyULBpgroTm+7kyCNt1CKiRgQVuAAISJbk0IEkFhsTHPLHxkAAwaiORq59WArKnhf+5gZaugxnUhA5+3GQ8rGiiw8FrL92+ACojIdNPwiZqP1GcLjbL4ByAtUDl6T2aHiis6pmameLJuNoV0mfa02J+Zc+FcIQGg+yeInbvdRXJ+2SMwg6ss717VygHgscfu+haO/pTNVzdriT+C0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MpBBHOKRwbqWduMEQ1U56Sy+6h8GvWYGHGjEz5vYKA=;
 b=gSMLFJnnkg7Hu998I3N0knsMwj8TZ8ZWLn+RWQ8SddMnp9JsrR5eHqI36kX5pErDK2b9La5sUHxXJi06Y3Zw6szScjEZwpFb/DbyeX4dmknIPNBiJgH2Tu4c/E0/lmskuO7V6jYamkB2nPp9ypBVkZgRpN4eiiyeDQhlh52i61H8RHbSW285ihUC+yIoyBIB0fN+W5MDtwVdPTrMoBNDSwyJGXvqA5LR92G8NEIKnkRNufdQoVYyto3g05COzmM3ifuz93iMGKVxhZc3zQH2PjDRxZ5syOu3inzt7jhqSmhDPvu3e7wYrlI73Y6o9YyKRUFY9733PQCUIPQWRRagqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6136.apcprd06.prod.outlook.com (2603:1096:820:d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 02:33:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 02:33:43 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: make gc_idle sysfs node readable
Date:   Tue, 25 Oct 2022 10:33:34 +0800
Message-Id: <20221025023334.77096-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <dfc051bb-71ca-035c-b945-ad298aa5e1ae@kernel.org>
References: <dfc051bb-71ca-035c-b945-ad298aa5e1ae@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c24b58-67d8-466e-7625-08dab6315571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/84IArZBNfnLLqokQjrcPlXIEYUYWWCJYf8ue+NMDAaVsWrCqJqzOxE1u01SJt/c4cq+iMgt5nulzZ/lZKiC44+xz/he/Xu0rHFKKXxgGbqUfESSVuuOysM4xe0xZ9T4a2vgui7EQyVrAYGhsVakmy/VJgWeJKmBKUfqresjH4XvpyIJ2b4hizCGTplVci8c8LHHUIeUESFLw+Zh7WrWqoX0CyMZB3QuTEJr9gG0II7iaiQF16ogpWDUd4D4BQf5VgeQ6tmSMrbV7QvVXXkhjgcitPD0CBtwP7Ilt0YDwgLcMfVKz2LRVTQ6I/EPdjC6GHR+Sn6ZU6MgN8Ygtjh0n199aEamiV+lJtUrnyS2RTOYHDg2UE1cPC48IALUecyma6OfEg+8PEWJTnf6hAU9LqJkGtfSmmQ74illqiSPQD2E0UyCFA+EyDf15QDWKMoxM2ItHQiqEFSX0LVWRp6Km39fKauK2XDJnSgd3QDYx+Ou5+AJFWqTqa0qF6kZdfRKseaW0UfM9cN8gQQhn5Oi+SXFpy+hFosmq6qqE0Ko3/gw2YwzAQH2rYPjR2BFjyc6bBepfkopJ1i23/9bSKUvDvzyfCkCqASv/L10J/l/zaiwbx5HZ0H7Wcwke9K+vUOV2H37Q7arrZv3VP3b6/dciGHQyipf1Q7EqIyqVxivUhQg8AOHcCL/h3/upMeoMIDmApAaU9v2K4trTaSiRc7qdzL1Nkf3xaXUXgALfmFryyLjNzyNf3Gh8obkA2dc/Yd9VBxY63h5tE0Tb7fTuZW5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(4326008)(8936002)(66946007)(66556008)(66476007)(8676002)(6666004)(26005)(41300700001)(6512007)(5660300002)(52116002)(316002)(6506007)(36756003)(186003)(38100700002)(38350700002)(2616005)(4744005)(1076003)(2906002)(86362001)(83380400001)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xVQW8klqrcm9QCGCYn2CpnKd9M3BaG98ALELFrJFPbRcJy/VwpReWJQF9z0N?=
 =?us-ascii?Q?wgFT32MGZIH9I26UNmaMbzqgT2ZxJXnTMKqP/OUHNIYu8hQJ88IScJMM8kBC?=
 =?us-ascii?Q?fLh6XMtnHKytSD9IP2//S5LJ2o/PyPWlJPpEl9b82Eu+HZ97ovmOdYYDCz/4?=
 =?us-ascii?Q?BVPttVALgF5SXE6jygoriTHMfJODhyGvG+rjj5NkEzXa2/mwFteB4zsCq6tj?=
 =?us-ascii?Q?NI6SMw9xi30+MiamMjF78M5JK1HkCVYPIVY0SadI3x87jQc3kxRt+Uxj9e7O?=
 =?us-ascii?Q?mSYQ1iW3mrsKFEAtlylTjsFRwfitmYPfFY9UL+7YLKyutTCrcCsdzUeaJJAC?=
 =?us-ascii?Q?eO3LDv7WCN4gdHELjHbKX+9wr5F0pNwwsWge6DYR41pVeEEm+jpyLrut0pk/?=
 =?us-ascii?Q?OzpXOK2dzyOAMlyPNXouB5qnU0zNti5dWB6YcISD23PD6nNZx/KNxhczXlXx?=
 =?us-ascii?Q?PzhfT2vlMxeM77Ad5z9b5GsZnZfrmLenDZD/eNji7OnJRYuFlB/iaNZE+x50?=
 =?us-ascii?Q?gh/g2CrILyt5+nC98Q0vuB06cchjcUFyAEVPa1m/0342fIuORCXSo6W8jq2o?=
 =?us-ascii?Q?3ZQCHom4fAWXp69mZ+1J89CLi7orKYc7FqgDoSCVG5R4q4znABKYsnshN/DN?=
 =?us-ascii?Q?r8mF6OtQkatFBCCMEWqn3sLXpWiuxQ1iRg2P4Xx6zM/MUEm7kC4Z3gl1qLCl?=
 =?us-ascii?Q?/SHWfp0gy+EA+xAl5zWDBrcDZbIoNH6wu0k9VKZ8xy6kJqS9qHa9Jskps+74?=
 =?us-ascii?Q?5wzsqsgroJM07VYjesTpnmN6kB//2QNvzyK38KJTiIr4JsoaKt702CHWHgXO?=
 =?us-ascii?Q?qjJZwNegZyFnfGmuCsSqdAcrYzz0mGwEWt5n7LqL0oPOsgUaLkf7hsn2GUbk?=
 =?us-ascii?Q?efp/s4+6C0Z7e1NqLP2MdzXgmQJ256feG363/NXiltv6KiBFFmGavFR2U+Js?=
 =?us-ascii?Q?Xo5sgsJMKVn7G0Uvf36AcMUi5lzfFfR02SLMyhJvnaVKEUuzQpm5HMDZbK2o?=
 =?us-ascii?Q?V6aHIP7ElC+Ft+JFkWeryecB0b0lmnJxd9MXN+IQ52+gw7BpEJQUbWWaZrhR?=
 =?us-ascii?Q?lhEFEXFqva2X9+JUfNm83CFIZ091IH9Zl4zq8FmenBtFt7s6BoV51du+qka5?=
 =?us-ascii?Q?rlD+S2gOzLSqt9h9GS73tIgNwqdmyRUJZ3WB8WIZ89s2YZTesHXZJVFrxoCB?=
 =?us-ascii?Q?/KRZ2NyWUlY19ie/NSFxR0XOACaw4VdhpsqZlDVxpErF5GbiNZw9ApEGW5oc?=
 =?us-ascii?Q?H7hJ8YT1uYvZyif1ahnkio4DoVxtmr91+IHVZeSad266eypo1fpQmBQNWFQs?=
 =?us-ascii?Q?vfG5zXY9RsCZfz0Jh+AsArkD7pi9RAnpWrdhg5nMPFvrvCVC1DuL98NHYKJs?=
 =?us-ascii?Q?htM86fJaiHWWJsrsZN0XOniCk2756zJS1UEbW2/IwN+p6D4uDQnpn7Z1osYx?=
 =?us-ascii?Q?bkH74mRdeFjBU5K6rtPspl5PwDHyskQZAqzj2meUA9HK1MlUoC5Ai5PmrXhQ?=
 =?us-ascii?Q?jk5sS//o0mQK9NEmRMCAZl7eUf/XfFtfQ1pCo2SuQVA92QBOIYpgpbzJ4PfE?=
 =?us-ascii?Q?MtZJydZCJNTkvP1Hvw+vXAgSai54EQ75OdKQS2ny?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c24b58-67d8-466e-7625-08dab6315571
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 02:33:43.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xcasev95LZic97VjC+qYMKbRjjhvcJ56litu6irb9zHztwOLSZmiz1GFLzBbwwYznmxUOgebguDGK2nOIAbbFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

What:       /sys/fs/f2fs/<disk>/gc_idle
Date:       July 2013
Contact:    "Namjae Jeon" <namjae.jeon@samsung.com>
Description:    Controls the victim selection policy for garbage collection.
        Setting gc_idle = 0(default) will disable this option. Setting:

        ===========  ===============================================
        gc_idle = 1  will select the Cost Benefit approach & setting
        gc_idle = 2  will select the greedy approach & setting
        gc_idle = 3  will select the age-threshold based approach.
        ===========  ===============================================

From the kernel documentation, this node only describes the writing of
the value, and does not describe the reading of the value.

Actually, this modification does the same thing as commit e60aeb2dee1a
("f2fs: make gc_urgent and gc_segment_mode sysfs node readabl").
I understand it is an addition to the omission of the patch above.

Why gc_urgent and gc_segment_mode can be modified to string, but gc_idle
breaks forward compatibility?

Thanks,
