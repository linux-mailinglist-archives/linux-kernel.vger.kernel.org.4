Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E716C222A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCTUEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCTUEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:04:31 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::71a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FCE2915A;
        Mon, 20 Mar 2023 13:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihRX7UFJMKsAKyEduKujsU1XNnMhD2+o/bzmw/Mm9sEE2QrOs8K0g1ldVvyrOHEXB+WZqz7xUWvBj9GvNJlsMrVPlo4/TUKbiSKET1C934MLEAdlLS3Y/kPFJJe768F95oU2TdXroAtw9CDitQvdYb+pkjKAxgd8YoGA4CbXigLb66RlMAltmLnAj9TA7xqGmKnh0SVi/xs6aM2+oGw1ytqMwguuEve9yOL0fQlQP5T1BRkUmJV/BU6qCflRFnSprFiUOSkTuUN9rCuDbTUb2pLF3EoRsADM5TOXisSs3XAQGhF//6Epz1recyw1+WosT3OZew+vMALA3HPljN1P/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwxDyCE2SULpgn3wOsOS4xWC1D15duqv7rZF/MDFszY=;
 b=H8Zyi1Gu8cJOOktk7pQgvnoGWn9j3ior48Aq8eq5JibkuMbmTScR3dfbtZlsfdQ84EBwK6rgaywRdFqw/EoXuk8CxdagxZgxVe4GVQcygMyCvO5o3PVtkxi8nANQgRqty38jOpBT+p1ZomfUsstHdJygz9OyZMcJzL8v7qG3XkM9YowZ4yKM/mEZ7IiiA/aqo8lBy35dehfztlBmAzonMOfjjqrVAylp4gP1ZI28hJCQoPl9AktjpYATVMjlfTEnAZmOFLrosTj54iZr2wEj4XE8kY5QSWp640MOODKO8UJ2uQmAzJW5gKWj7Rr4nsaRe2H9Ndmjsu4nIq7Gm4DMvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.onmicrosoft.com;
 s=selector2-bksv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwxDyCE2SULpgn3wOsOS4xWC1D15duqv7rZF/MDFszY=;
 b=e7h7DbQ+0jdC00sdYBKv4Pkz27SmkMynqZVtiW6BI9jP4cM5CLIAEXqaxSrvNFgV2HxYAuqzlgA1KReSFTJojBnedm96ZbeURYNedbl0tLx9wmjMjThBUukypnptMwyK7+azF4w6/g9aXERoGPkywaRQn7RAGbf53rSgRHy9cygXLjQi/ydRHjIcIPbjxkWMhUHFgULWtscG+WLbxe2dVnkFpLNCisVlFq+pNapt9ol9rN9AET6/UHOUd+Ge0YOmil+QfE4uNwmybyW04EtW9lZbhO7GkRzAgFkGCotnvBR2mBpZckbFPc1n3wAwmIbRp9fequrjpV8xyH/p99/qhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=concurrent-rt.com;
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com (2603:10a6:803:13b::17)
 by AM7PR09MB4215.eurprd09.prod.outlook.com (2603:10a6:20b:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 20:04:13 +0000
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::33c6:e01c:20d0:45d]) by VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::33c6:e01c:20d0:45d%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 20:04:13 +0000
Date:   Mon, 20 Mar 2023 16:04:07 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 5.10.162-rt78] Restore initialization of
 wake_q_sleeper.next in fork.c
Message-ID: <20230320200407.GA39185@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <20230320193731.GA36840@zipoli.concurrent-rt.com>
 <ZBi7TbNgBAZL6tdw@uudg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBi7TbNgBAZL6tdw@uudg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN8PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:408:94::46) To VI1PR09MB3582.eurprd09.prod.outlook.com
 (2603:10a6:803:13b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR09MB3582:EE_|AM7PR09MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e59036-f218-4650-8757-08db297e46c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWpEM2L5sIgrwh5sbNS3u/x7sikUSbNepqfsjr21+uOT3s65icRZ9cXBkk5Jl+HfSGAgIrfm/JX/+8QP/AWgRlZG06hCcv/EynSzOFy6ySitDlIyprqzihvU10svIzBsCjesnnZbtlgrMGVON8ox8uoj+XdV4CqAw7DL4TW35gkVMl5jwD2p8D/PyYCaxcQntJvfAzpcsOsrFnpyT6lbImBWEMQ08IM++FBYYGLIU+wpAKXc/YXpMJQJwg5Bqk/LHYnvkIt65UzJXqEZ3ElJ8XPwRR9RxRAHBV0imKOdoJaJXLDDoCimJEfGfjui5hAKUnc79rr/j+BzJE0i9l9Hdot6/q7FOm7ADmxmq1ZUpbmxfNjUPG1fKpXFMzU7mWdRCZ4F91N8ihBeiocdavNjc1Goojlh4p62JTYk2ENQgC7GmhkVIIVCdmtLwy1am3RV3xrI4p4Wv8WOXbo3dO5xkJVEqz+wSdIQ5pz4S9qKXU1Aq/yu4XXOtS71sIyzhKouDWLpuascOCECCOJGZGku4DZa9UlE3w1Tt55TpbwFQW7ZdYp07J8VkeLcaOE9GulsmP0WTc2BtRmxvCY/uNyf4kF17iQWLt1Hpw30VyCnnkQyK1HlaowIAcZ7C1mdtF+dOoXpZ2oQNGjvzdmSwk8uE91Ud0efzGMxOloIFxP0A5P5b9vNsQhjgLYePqe2aCIO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB3582.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39850400004)(396003)(376002)(366004)(451199018)(41300700001)(52116002)(186003)(966005)(6486002)(4326008)(6666004)(478600001)(83380400001)(8676002)(316002)(66476007)(66556008)(6916009)(66946007)(6506007)(1076003)(26005)(6512007)(44832011)(8936002)(5660300002)(38100700002)(38350700002)(2906002)(3450700001)(86362001)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UlA4G9D+RRycZmHbtDrr5o2ps+qI1i/xUux1sbdgPTcEzqcZRWjVEx8zt86T?=
 =?us-ascii?Q?Dw4BXJpuaQRXBqLNK0scOMyRkortfnbNadNaH77DgsdISjfgfP8qkUc1mIj1?=
 =?us-ascii?Q?xmgoRMN+2x4o0sLWLqrcKNZQLAtCd1Gl0JRboTzUC9ZPgQoaa8Vw/HhHJKZT?=
 =?us-ascii?Q?Ay3ZRS3AgkOzVsvnAmSk3Hb0vdrTcCqpcNICcNaNsIbn2GUF/qpyYRJbQCjD?=
 =?us-ascii?Q?Rtltvt+0+F9RmGVRFq/3cojdQT7mIWC1tUpS2GQ26rlQZwVAi9CXMRYAmluC?=
 =?us-ascii?Q?3CJiB26tLzWCYy57FMXtvUzEiGkAqQEkZtPRXfGt9mVsBr+rqAa7IOOR2xGv?=
 =?us-ascii?Q?B4zW/0QzbYkwUfgYoQ8Y3ikCzd5wNBSQx2n/lPrSQ1dphymtFjDxx2BKTgVQ?=
 =?us-ascii?Q?v8ztXhlnvQ//lERRITo1Y8Y3JKANz1erD+blIrE88KljqKPchASBLyLuop7Q?=
 =?us-ascii?Q?pAe6bcmi2YX9gWXtsuku2qBdQPO1m/3SyfEllFSPw7MRuDsc4t72gS9eHRiv?=
 =?us-ascii?Q?K+gDBJrz+GUOkWeRUy8Forag5C7rEOqSmr6ma2NBT8pjDZK3Q9I2Z+2ntsqf?=
 =?us-ascii?Q?oRp5020tvIpUlyPGxxoW2MWghxYPDjGFBZuAWHFoICn4eDmg5y7sIGWu3K9y?=
 =?us-ascii?Q?BvWa/I/dBAzfnlPlurvOJVIftG6YTD1HQ/QjPU3A1GtQUDpE9GfnWY71QsL0?=
 =?us-ascii?Q?H9LF32cwQJSAMZk4iwMU8WwgX0d4hFAfM8QzYtGRAkBcV++iB/4y2P5Fp48w?=
 =?us-ascii?Q?84+kaPvHWTmkphmfFZdAWqQADOSShNUf37/i2lvRlG83tjTYPWJN8yq3ayqz?=
 =?us-ascii?Q?ocC4acLEdk9E2W0dc9c4snpDZRa2iB2Qy/58J3Eg3ye4EliojCDeKc1A3Jw1?=
 =?us-ascii?Q?TP4eY5DeaZAMgNQ19FwttqJblyJ8+rX4kXOXFj7azcZ9ZI/b+aaTwU/EKpbu?=
 =?us-ascii?Q?maxInrRy9dLU1mYokaruoDYj0XunYCHgAc50MN2AMQwR3Vy9QK5+s5qEAlKR?=
 =?us-ascii?Q?fKM8KpC2Yq8DFIyH1Kcitd/EpKCF3cBip9EtqhbHfcpx73LD3ebhm4lc0xuW?=
 =?us-ascii?Q?AAfABa9Rc03CPbjPUlYxuLdKFH8tmJAbFUWhlvZNhdy+vTQI4DqJSxx0GSr3?=
 =?us-ascii?Q?xvJRDtYl+XLdvR7maL6L+WyE/uux7IsrpzJvmwwW/rvkLaRgCjNggMuq3fUO?=
 =?us-ascii?Q?vTiY9s2abQ5/RpNTgo3fpRTVTY+L0ZPoSESIIaJR4CjSC4b2xaw6r/qEmEjC?=
 =?us-ascii?Q?A6qYAkDZFG3LJNXqs8CCbO39fGRMoSchFLUYryalq2I22KsaCNUfrObr8QWk?=
 =?us-ascii?Q?oZl5dkNOiiIEw1rUFhyA1mWqO3ODfrsrMRyphNR9c1enlwkXuZz+iVDf2UVA?=
 =?us-ascii?Q?xuYMM79GOt3pOYPJGPX5wliLFaEMX0HNRtUs94evWkKgnOw64Uw1m+RZES5T?=
 =?us-ascii?Q?5nE8Svn6Dbf6MY4lZRRRSRnW7bBGJcAjziyj7m3nrMCB+5wNeHBGQdenvS0S?=
 =?us-ascii?Q?TIhFLBPzybYMzneHHJwkuiweQNcS8byUBFmz7NriDs8XnoyHATgdSxctlcEh?=
 =?us-ascii?Q?1ZN8CNGYnxqrF/Sbsm6n56ES7Hw0sSre1oGqdNM/Wf9rI6a/HxH3eLigJr4Y?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e59036-f218-4650-8757-08db297e46c9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB3582.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 20:04:13.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVilrpc8fHWMqAnEHVSqIO6G6zr4gHgVUgry0zMscAlxJcW8BGjIRbY17dk4EeqFKhvdzj3i8VMjzWZuDN/qibnMVmUh/xnPN87HPwzeDQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB4215
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 05:00:13PM -0300, Luis Claudio R. Goncalves wrote:
> On Mon, Mar 20, 2023 at 03:37:31PM -0400, Joe Korty wrote:
> > In the transition from 5.10.158-rt77 to 5.10.162-rt78,
> > the initialization of task_struct::wake_q_sleeper.next
> > was dropped.  Restore it.
> > 
> > This appears to be only a problem in 5.10.  5.15 does not
> > have wake_q_sleeper; 4.19 does have it but its initialization
> > there is still present.
> > 
> > The 5.10.162-rt78 patch that damaged fork.c is:
> > 
> >    0170-locking-rtmutex-add-sleeping-lock-implementation.patch
> > 
> > I do not have a simple test that brings out this problem.
> > My test consists of a shell script and eight binaries,
> > all of which were written in Ada.  strace shows that it
> > does a few thousand forks in rapid succession.  One of the
> > forks stalls out, after which no fork after that returns.
> > Eventually the 122 second stallout occurs and a large
> > number of threads are shown to be waiting for tasklist
> > lock, either in do_exit or in copy_process.  The kernel
> > .config has rt and many debug features enabled, lockdep
> > included.
> 
> Joe, thank you for investigating that problem and for writing a patch.
> 
> Earlier today Steffen Dirkwinkel sent a similar patch:
> 
>     https://lore.kernel.org/all/20230320080347.32434-1-linux@steffen.cc/
> 
> Would you mind giving your ACK to his patch? I have that patch queued for
> my next build already.

Acked-by: Joe Korty <joe.korty@concurrent-rt.com>

