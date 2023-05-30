Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FD8716356
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjE3ONu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjE3ONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:13:47 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D638FE44;
        Tue, 30 May 2023 07:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APo6s2276U3Mr+asOHZKjBES3luAUxXf59e6ZkBJ8VuktcLcNZuRNxpvBczIYCBqeptIQ7I/aTCH7JFpF0SFi1sXFpXEy3kf45Wi5nOPV2r2iNoqXks7h6h74T2ofe/EyWeJEpEu4V5Aim4XX4kPL2aofbiOrHSr/5hj6sbDzaQsnlmp7ifrC/dnsiJIM3tYEjk8tffr4K/I5rZtzZYBK7OU7ASPUz1IhY6F2ANMJcImP4cZAsxUGoqjnwbUv5ZLqB1kUkRyFTX1T4bsl4SHn1kEDY3duldxkGp2eBWeXQlw5JbYE7jmSp/weqqm9Qx1YURJ9GYcTn47bLSotRBPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qBLjUiWq+OdoCD9JPD2suteEWFG+t70JrtUnc7Tal8=;
 b=njT75ZvCQJQPOmwI2dIJI61nI9xwx+65zxSXtC8Xlw+eHpPNrThJBgNVuVvcfo/pFRcxSppqYVRmYj4znnqAvpaJpIQdc2c9DRCtFBeSGwXmidsfPwViEHZHJBIFXx2LWadQlETociNSVonz4fy9itArJabKe5vRJiDQzR710c6ZUPztWbOgwd4Y3Cb4SdfatOvHC1Q4dkSAvxd7qNiE1lQuLggtLGIkcy2ZjC91H+JWJ49GlPbu0SROWAYGYnhBxoZ/V1hroDjJQixii4xgwfa+MSB9Dl9Isz+ZZbFohOukfj55dehwhsFcY1I5P8oIy7uGGcE5obyJ00PBvXALAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qBLjUiWq+OdoCD9JPD2suteEWFG+t70JrtUnc7Tal8=;
 b=jLYzQMjzCwG2ybKNJBcm/ZVX/KCKGgQ9Noa/xHnEnozJTMkUjajf1SQc3CdMIPM2gT37iKrvEI/TC6QR2sxNKIhdYqS2CL3At15dy4i2KS0vRHUsENc+UL0SG2e+HasDKxEuN48oKBIYGjQs6idGy6W1EgTFNFKUFJ50x/xhTLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by PAWPR03MB9033.eurprd03.prod.outlook.com (2603:10a6:102:339::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:12:49 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8925:5293:e478:c934]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8925:5293:e478:c934%6]) with mapi id 15.20.6433.020; Tue, 30 May 2023
 14:12:49 +0000
Date:   Tue, 30 May 2023 16:12:46 +0200
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
Subject: Re: [PATCH v5 2/2] sched/deadline: Update GRUB description in the
 documentation
Message-ID: <20230530161246.4328421d@nowhere>
In-Reply-To: <20230530135526.2385378-2-vineeth@bitbyteword.org>
References: <20230530135526.2385378-1-vineeth@bitbyteword.org>
        <20230530135526.2385378-2-vineeth@bitbyteword.org>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0142.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::21) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|PAWPR03MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4a8510-12ac-4a14-c60b-08db6117f329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1LSlvXy/QMhedDYDJy8dE3MUIh+2XUCf5+k074W1IXn7lkWK5DoWt3LLf9FWjDmgxZKjdtkn5a7W4pl15trwRDlVlH3eQSbfOkOw3HRoBDpCKudmAEkHqR/U+xuIrkGE+3cNd0r8jZ7rCMukaMLev4yfHC0LI8o0IBf8nigABhuZx7ZRqSzNF6tqfEfNDTJf7JeOufhQUcAP3YDJ4V8sF9ijMbUAz0G/up2oHcmHIJDiBrMRwRrnF0NJVDT9JpkQ7F0xJ+3W0d/YXXMkpTpySoeOGuizdtavBUbsKBz+fSJekqdImOKEUxz05B+cte0RM3J22CiwwmrnyERVGufiQ0DB0ICVoW1N+YCSJaDb8ppkDvAiB5jUGVmzwpYVnYwLZJjbS9RbSw/nUQL6jlwPuoH90MoeuajE/MTDukZ6p4XevU5JbZlbxEIB+fjeWTHOn43SYr55GmJDVRPp02jouGemYYdqVtcSng5uRIqlta5ClfQBERRd7VJDxKFS+5Kj8miqYYSuHK654PqlL8qwjWzS9/QQIaC9fJaMm8c/C9DuYZZbhW1rqJuEDPxGwx3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(346002)(39850400004)(366004)(136003)(396003)(451199021)(86362001)(66946007)(66556008)(66476007)(6916009)(54906003)(4326008)(786003)(316002)(478600001)(83380400001)(6512007)(1076003)(26005)(9686003)(186003)(6506007)(41300700001)(8936002)(8676002)(15650500001)(7416002)(2906002)(5660300002)(6486002)(36916002)(6666004)(33716001)(41320700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A5RtKxSZSXndDxPc3zes9kzWsYViA+OlAxToUsuJxYPSIe0kqju85V5k4ROe?=
 =?us-ascii?Q?FDW7pCCGw7xE8bNu2uj565apS2HbI/4HyKqeDP8iVkQv7hFrJ0ZFADjONGla?=
 =?us-ascii?Q?RoGeXpYhUQGEykHe1QKh2Fe7+AHbuNsbQcHq/cK7PjLx3a9URyS3Eo1DEW7S?=
 =?us-ascii?Q?P12ihjqBo7aI8xgvmrlbZAG9Mr895L4am2VFI3gqXEWtlPZEMuzw69MNrDgl?=
 =?us-ascii?Q?bksGuUrAtR8mI2WntGXndfS9g2jMavoxBouScbo9rKi8qojhlypFsF0yjmmW?=
 =?us-ascii?Q?zdHySZ8uiOqiIvqRY2Pc6t4fuEq1As9KSTwT/32abKa0UUphZhygF3J41+OQ?=
 =?us-ascii?Q?cJMskfz6vLivyi/YqhddopTDMiklyi3jqisSCiPLiIuChVA9/gjlOXfCSQmv?=
 =?us-ascii?Q?yj/00LY9AB5Halik99LeO5+R6dWve0ikmGMBEO75UU/NPIeDxdWQAEZDCaRC?=
 =?us-ascii?Q?RMmKiIlnke0KSIpBakngm0+ZhpglwWWDPzIB7SPB/QGVENJW6hna4MCFUSLF?=
 =?us-ascii?Q?J//up5rHt+UAbjrdPTfu5I1QTUDe9bLUJZBfCAummhg4pWIlSIkNzA+uzgDK?=
 =?us-ascii?Q?+OsVag4QISTvODnWxFpgxjz0764sZEcEi6/4YoJS5YL0w82YRqkcC/ydo3Dx?=
 =?us-ascii?Q?Z+g0l/yfLXFyuh3PmjVB3WKlT9S4qnrsqJRDfsmAQxEJO60UKIjVUtr21VFv?=
 =?us-ascii?Q?PnoMSB835PLcKGWTXMOz9dHWsrBFv/PwntVxQnAcojOND3mHZnk1xngaeSXJ?=
 =?us-ascii?Q?dwH7nFoWPbmVY4/FRqozLwDcu62o0gLiprX0VdLZlHpJNmgU8va6ncfZS6uv?=
 =?us-ascii?Q?saRABrlUbeFaI7jb42aqntPMZVMe7jfo4BmdfqqJZp15lAghEoJBwq1WFwij?=
 =?us-ascii?Q?QbubDzvYxQGOM71ySViLsLQOrcNtDj0TiyO1gaG2FiToGOQJxjDGLnvzKHKK?=
 =?us-ascii?Q?UIAzzjo8VEe42JWZdJrH9vvZWNcgQwbpFJG9IEX6IeTa3kyzwxG1EhaNdLiH?=
 =?us-ascii?Q?qiS+QM7TEeMFHZD1KDdto6f12opy3hoK5ZdD7qD2BcVzqTulc9e2BVyKu5tt?=
 =?us-ascii?Q?OThlLUVCETRF+yv3p0j26W+Q3YPlJPF9icOh202Kp/pacMIWLBANcd+sPpmZ?=
 =?us-ascii?Q?Gz5PosffhbVmyo7zNSV79lmeEFQ6GOcDHIJTCNsJNYenz8aZGCoTR6UtPi4S?=
 =?us-ascii?Q?xXfIPtitTffBZPVdrvWzQTJpSb6TzjhMobxA+ooF1zTSTo/hzwV66xCtYWty?=
 =?us-ascii?Q?TLNWtM3DNQvibGmCOsv1va5ztMyd41Zq2E7728duQQXHMcJrL9QH5EMIj2BZ?=
 =?us-ascii?Q?oOQeJ+hTghtH9IpqCeHhkR8r3tf+aVeegGYbioxfd5DcSSWlyB9Nh2bztMgr?=
 =?us-ascii?Q?0sE13ag8W94x4P3dtPvNOjhYyhHPIAnWt7q4RtMj9bLi6oUZBPKPEz8DiTmt?=
 =?us-ascii?Q?iViH4qf7eJWgywGDk+pPKK8mUnbz1iKKgzqIFqfp4ZajLcGbxK3TmpKh1G6P?=
 =?us-ascii?Q?5KIARH2hTDLBE7hpNyAiu5CbfGwgVIlqP5Prg8gZ9X/GOgw8VtTly07RXw47?=
 =?us-ascii?Q?LvdBAOh1LkiimSwxYZONi+y/e8pvtrnuMGz2uqeUe55xvS28g7Ie/68NNnuE?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4a8510-12ac-4a14-c60b-08db6117f329
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:12:49.6181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCjZrsra8u/1kQg8eRpzYkBrNA01O/jq9nhBEORdE5N9zQU189BH7E/4fR8TpDghaTNoTopdwhWbmoJhbzHy1d6oopJW9OyEodPTH9BfnV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think this patch is also OK


			Thanks,
				Luca

On Tue, 30 May 2023 09:55:26 -0400
Vineeth Pillai <vineeth@bitbyteword.org> wrote:

> Update the details of GRUB to reflect the updated logic.
> 
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> ---
>  Documentation/scheduler/sched-deadline.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/scheduler/sched-deadline.rst
> b/Documentation/scheduler/sched-deadline.rst index
> 9d9be52f221a..9fe4846079bb 100644 ---
> a/Documentation/scheduler/sched-deadline.rst +++
> b/Documentation/scheduler/sched-deadline.rst @@ -203,12 +203,15 @@
> Deadline Task Scheduling
>    - Total bandwidth (this_bw): this is the sum of all tasks
> "belonging" to the runqueue, including the tasks in Inactive state.
>  
> +  - Maximum usable bandwidth (max_bw): This is the maximum bandwidth
> usable by
> +    deadline tasks and is currently set to the RT capacity.
> +
>  
>   The algorithm reclaims the bandwidth of the tasks in Inactive state.
>   It does so by decrementing the runtime of the executing task Ti at
> a pace equal to
>  
> -           dq = -max{ Ui / Umax, (1 - Uinact - Uextra) } dt
> +           dq = -(max{ Ui, (Umax - Uinact - Uextra) } / Umax) dt
>  
>   where:
>  

