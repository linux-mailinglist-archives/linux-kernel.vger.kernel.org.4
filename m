Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF26F712981
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244017AbjEZPaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243959AbjEZPaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:30:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DABF3;
        Fri, 26 May 2023 08:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKcbaS48fFKs+KaEEyJkso7MIJ/K7FKZmqAKD5MFZdSBk8yKDM4qch5Oq4EDPM2R8qoHkDTTwCnQocnDmWsouG84uVJuybfO/BPxLF69l2UvTdpcMO4GJubB9UEdZLxQukhT5uz+avlY1leSgnkKLbcaS/SQI7aKWugAVyhMFSPq0mTPICamJXxeOrl8DFHvu6CD2xERSdeNoPDIrTJfzE6G6+65EvSVeYK+HFga0snOhBNZB0gsuBtoTTyjtWKO/7egtxahS9+zwj96DgT8Nr3XjATxJC2o8ck03g+XaFA0kgwRZOYa8jUHklzZiIcqfb7AzhyTGk9QlJ4KauuHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnEusWUUjn8aOaTWyDEATbbl1QYYxYONuaWet/tpWbs=;
 b=W5rsGdTWNehXMCvjGptmFpsS9swC79rWQk0ee3tfZLMFJHKVHUOhgPgT0NjR54oBwUBSzO9I6JBDB1EJqi/PfOOkgVl7zNg1Wu56clH4oTbrFx21erDD9/tIssBm9Luzl+UDWWARltHAovtuxvDlnI247ycFGyS/5FqG/TWEpQMatS/xtkmByyqYQJzMYICK5wUHGfMhDOGRHcpwqYt7+evPujzORPaGWyoeIhFY+MQ9k43OprY5QpgVQIU1hqCD/fiXKIaMD5DNrbXiKMSJD0ihU8/NK8mEFJO4YnBeLFaacRLE45zTNGJ/PSNTEaaVZJOYZ7JXmWAjQU4yExtb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnEusWUUjn8aOaTWyDEATbbl1QYYxYONuaWet/tpWbs=;
 b=TBhVB8T+tXIAmijO3ZoeZWlX+DkFF+mEhlPiw5ISK+OHACjPPYheQ+SxFti/lNu5GtT9uW4hUtq6hVbeEq3rWStDGJhEe3L046Uupbjdp2CEprrrtgbGotnfji4o+wQeCLpGsFOlzEx3KFgedNS8sTu4NPcjLjZT5YFSVACR+Yc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by AS8PR03MB7463.eurprd03.prod.outlook.com (2603:10a6:20b:2e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 15:30:02 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8925:5293:e478:c934]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8925:5293:e478:c934%6]) with mapi id 15.20.6433.016; Fri, 26 May 2023
 15:30:02 +0000
Date:   Fri, 26 May 2023 17:29:59 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Vineeth Pillai <vineeth@bitbyteword.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        youssefesmat@google.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sched/deadline: Fix bandwidth reclaim equation
 in GRUB
Message-ID: <20230526172959.5440b9dd@nowhere>
In-Reply-To: <20230526145519.2282062-1-vineeth@bitbyteword.org>
References: <20230526145519.2282062-1-vineeth@bitbyteword.org>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0158.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::17) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|AS8PR03MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 31cec9b5-645d-4ada-16fa-08db5dfe12f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNNOlXDDvgq8JoAIFoqADYFpCUBwlUkzjAwMVGCM7zzHpHoqQ8UxaL1caaKrhwaue1JCDKUYEdxUP0Q1gNMb85S7qH5RTwn5tXvDy3cMI3bye92pxGxeP1eh8eQCOrAxEh0RzHYEBFwkZZVYNg1Kd81YH7UsrioYsQfjm8Yprg4pJv/WJTO0WXPXXdvnl9kuhbC/EEr4JYToP9TVI6499/AsMNzB2S+rmqx9iEBOY6RIUfcmXmgmXLI/mZwVY3NQgZUDJQJ1dmNEtJI/DbAeQBWofkbbTtSRC/vhOgp01aLbXGQRp7fCb+J3jBrZiK2bhfVO/7thrx6PqKM0vlOJ5rVCCqp9yqdNpY6I8rHOUYDDVRkIx5rfXIiqWmlXslLDxkCdOx/XIhSzd5sdtDNHXmrXzvrC7hIQe1vgUvMNk+LvYaH73JK/O2zsyIlni93eUhIup5sf4E+5Dz72z7alJfS/6IrosMSK4DQmvXgdLsONWKU8IKgyKLc3qhTzfx2DxCTpvTDRVyoZtLjYd70qUF0nPZXQZrOxRVrymQQAqBzwpd5OeNDxoGTU1pJKVkAF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39850400004)(396003)(346002)(366004)(136003)(376002)(451199021)(2906002)(5660300002)(83380400001)(7416002)(8676002)(8936002)(66556008)(6486002)(41300700001)(66946007)(66476007)(4326008)(6916009)(54906003)(316002)(478600001)(6666004)(36916002)(786003)(33716001)(86362001)(26005)(1076003)(186003)(9686003)(6506007)(6512007)(38100700002)(41320700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kGsJeiUP5mS+h+5H+VzSIiCLASJ0zic//XCSwsYNqfxos87GGD3SnXBWgFL4?=
 =?us-ascii?Q?1hwPyHEjgdcOVLDK0GAlokuSjivSIzWoG7R9SHyLfQOgiwuf594yfdxzdt/I?=
 =?us-ascii?Q?Isgj8TJyBJBfSMVQ8rkqvJg3OX1XR8uuJzAxFyuRShC7icj2oYiMR/eiLg4N?=
 =?us-ascii?Q?rG61XWo1232ZbUSlru4VjM44E3794IiEewk1jzTo6DkjphLLO9ufsrk0YW1R?=
 =?us-ascii?Q?c3QC13IoEAerTftc8dkWCoCemWvHeCNAijnUjl7wbUt76p0f4UwvuWNm7oBQ?=
 =?us-ascii?Q?jkHcsYrG/xoGXYS3fo2DFLkWQ4M7gRk2bb7uU1mLw1f2Swkqy7XYkV72t1Kv?=
 =?us-ascii?Q?IA7ZofOdxQQWqOCe9ow+TGeIxqw9fO6SL+cgutcZeisLufB2hCDlzKkyH7wO?=
 =?us-ascii?Q?GItqPqst4OhC99aaVeOw96EvSqQ6oU2U5RFpcMYp/FgGOY3tvmIbQZl9rcNM?=
 =?us-ascii?Q?zDVTYRg3ZDoVhCf9KKKxBQc2oAzXnlXx4mWNIMyrGoEggiC25Dv3J2mBI66N?=
 =?us-ascii?Q?/0HQ69+hVyxshMcZ4/FWv4cRcyUMcVCqkZkgQcwgkgV8UMXIlEj6Jr0EM1hL?=
 =?us-ascii?Q?OSEkJA342Sk7HMLPdGOG+4jRJlB+U5quRpz/xq+faZAG3P58uZ5T5zw2XBW2?=
 =?us-ascii?Q?OmjJLzV+46b88x20jVD1zI30HoiWwtQIRNUJbQd6JcInnatV+lv9YkGl+a1/?=
 =?us-ascii?Q?ACi5Nv+fmMZzsB8g0l/wdXQQsbyKF8/woG3W2yDVDEQabenuvhNQPkY20Kdd?=
 =?us-ascii?Q?QHnoXRQZqFX6kjTVjOLYJajQ0RCOVkWT2g3TSLhxdFy+5dkqk/60daWqeDVU?=
 =?us-ascii?Q?cvwpmzG0/VX9U+YJu64F3SoJ0EqWIpb1aGApu0ckjKcL1hS4mwuFCOFthGd+?=
 =?us-ascii?Q?rw6DRIPhwcmmW6Ge/BQAt0hQb6yXI/5MGQOngY2nqAUjq02qUuHxbV6UKmWr?=
 =?us-ascii?Q?v/TOMpN99zUi/OvNnC5InMP6cKtE0Xh3H6uEbvqOmiwZ5l6EPLL4S8Z8nQhG?=
 =?us-ascii?Q?FRXDdz4Knng8A1jhUCPMfFydSUiTzIX0NAgDzsSjRUnUfJc8wKI+xp4bdkmd?=
 =?us-ascii?Q?ODLUIJ4YDOYvypbfMDOjp6YWJiVNitOdQxh3G4X4Qlz+AVuhO/iHHQpieBCI?=
 =?us-ascii?Q?/Z/NQeQRdx3jxKBdkxqaoSaJqev6Js1nuwUkBPwgbG5cIOtz4OOrmRqxw8eJ?=
 =?us-ascii?Q?0o3l0YAE4EeWZkXN7+LkZ3BA453z6yh/FiEhR0E6BwsOEdiPicoU3ypLyNDo?=
 =?us-ascii?Q?d8Q9l6mw3J15huKL8nhSGgulrxUBmbcG1p5NGmH7wfvyIUR0vWL7H1RQtSTe?=
 =?us-ascii?Q?ILqQ1KDfbyaJUO/h0ldVhJ83WEcevR1JISgos1INtQNWiPKDA3Y3wj3xl2CL?=
 =?us-ascii?Q?C04NGbPpDbNKbiqJM5PL0I2Ab5Lqeizh+9tzZRPMh5E+hKRODjc1FS8iKccl?=
 =?us-ascii?Q?jc7yk8tLavj2tbVW8kpMtTbvtazScWguxcI6Xzq33MYY4dDjeZcHC7Fg4eMf?=
 =?us-ascii?Q?EePnRM3E5SDWKzPP+79selsAGbcZI6ixwYrJZf2AU/Z+Qh5RndL43lGDoIDF?=
 =?us-ascii?Q?HezlMMIX+5FK9XsWJFGrbVZkal14eBgx2XcxKFYspiLRHVL9Y2ZeVSidNuYU?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cec9b5-645d-4ada-16fa-08db5dfe12f9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 15:30:02.5987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJEbqZ3Rw53Bv/C6DqZnkNEK6M4YEhvCYsAvdEItctw8GFEHiuyLJHtQyp/xsLodBIq0GcCeoCAJ110WWDWC9s6YP4nJeSJIEO+hcCl+8Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think the code changes look good. I only see a small issue in the
comments.

On Fri, 26 May 2023 10:55:18 -0400
Vineeth Pillai <vineeth@bitbyteword.org> wrote:

> According to the GRUB[1] rule, the runtime is depreciated as:
>   "dq = -max{u, (1 - Uinact - Uextra)} dt" (1)
> 
> To guarantee that deadline tasks doesn't starve lower class tasks,
> we do not allocate the full bandwidth of the cpu to deadline tasks.
> Maximum bandwidth usable by deadline tasks is denoted by "Umax".
> Considering Umax, equation (1) becomes:
>   "dq = -(max{u, (Umax - Uinact - Uextra)} / Umax) dt" (2)

This is correct...

[...]
>  /*
> - * This function implements the GRUB accounting rule:
> - * according to the GRUB reclaiming algorithm, the runtime is
> - * not decreased as "dq = -dt", but as
> - * "dq = -max{u / Umax, (1 - Uinact - Uextra)} dt",
> + * This function implements the GRUB accounting rule. According to
> the
> + * GRUB reclaiming algorithm, the runtime is not decreased as "dq =
> -dt",
> + * but as "dq = -(max{u, (1 - Uinact - Uextra)} / Umax) dt",

...But I think this is wrong (should be "Umax - ...", not "1 - ...").
I think patch 2/2 has the same issue.

[...]
> +	if (u_inact + rq->dl.extra_bw > rq->dl.max_bw - dl_se->dl_bw)
> +		u_act = dl_se->dl_bw;
>  	else
> -		u_act = BW_UNIT - u_inact - rq->dl.extra_bw;
> +		u_act = rq->dl.max_bw - u_inact - rq->dl.extra_bw;

This again is IMHO OK


			Thanks,
				Luca
