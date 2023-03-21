Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E646C3778
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCUQ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCUQ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:56:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD1D38471;
        Tue, 21 Mar 2023 09:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw13VXM1Z91+7TngGc9mjI0oTjKrOCPM+o45ISlbVrpqLLrlorb1+paEH7aiQfQ+JLxlx84uIJ3aEjyfV3nHg0LtfZUbTvxAgAOcgriigI34yFrlGNgnIh8pW9xZINzAFcII8/2t/kHYN7/k2W1jgB2BmFURR4zBoHIPJ4B1TIH8wmRkhBV+PhEZN3Ovs0e0hgoaiP1YKS+eHoZ/zdl/yhGNERQgRRf0WtUgq+qyUvVPFktGCvp+XgZ+7TAuT3y3VtaoaY+coDflg7YU2Jvdlh/uJ+YVTEWD1usUpJkL+pPskFcgC4msRQirY50OnyhGcPoyEg2HlrrrjjA0IQvx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8GfQgQcwOOVjsgPSBmmGjXec06GiuH1T4IBMc83IMM=;
 b=KMQbqAxRNqwJ8j4lZMTPsJmBaMyaeg0Fys+xskSZjCntU4F1iQ+oiF0EW5Do/AfoiWyt7yEWZgQ45fZQDyxIWOqDfL2wqWpGRbVXLNunH4UFab6iv1kHXfpvJ09WEVrEMGpzceOwH5EXYjuFkocaWEktTcnU0T64B8vLZbYgNkNERqQZ8yBIy6AeJ3elvhi7kK9ouDYE5yb229s3YXcb652lkLJgPrnm28zVOJPp/rWyDreAkSSMMnlGf4x8kfHdizh8FsQ4nqk/nBd4cWALLxdH+gYukcf4XuYWOm3VWRxtTNq3eLAVDqDWCp5VXMFA9siCnQkgMklHlNvjGjoazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8GfQgQcwOOVjsgPSBmmGjXec06GiuH1T4IBMc83IMM=;
 b=Xj9iOxRR6qIW7gfwQpBdYpMn2hvurs3+NSY02JMtgUIAGf3/PwDTXNspg4M4gP/I25VrfcLyxBTf4oxCdIcxz9QlfnArDrFW/qBHyRNYO+fuVFzD1rt0aLbyVC3dfTzOaQdGaFitHX7mXoaS7DMFjFfMFlKQhHBxsx5HiGghSzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM4PR17MB5996.namprd17.prod.outlook.com (2603:10b6:8:47::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Tue, 21 Mar 2023 16:56:02 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::12d5:2d24:8d15:1c05]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::12d5:2d24:8d15:1c05%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 16:56:02 +0000
Date:   Tue, 21 Mar 2023 12:55:54 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, corbet@lwn.net,
        shuah@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v13 1/3] syscall_user_dispatch: helper function to
 operate on given task
Message-ID: <ZBnhmtvlenY15P32@memverge.com>
References: <20230301205843.2164-1-gregory.price@memverge.com>
 <20230301205843.2164-2-gregory.price@memverge.com>
 <87cz529kni.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz529kni.ffs@tglx>
X-ClientProxiedBy: BY5PR17CA0067.namprd17.prod.outlook.com
 (2603:10b6:a03:167::44) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM4PR17MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: c3824a29-f6a8-467a-61dc-08db2a2d2709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBTF5nze1hraLl9hh0vbksw5W29S92EKJkrJNlinAUC8U/X13GLUiVEh+6rVCmjSQ2KkOHPWgsPYa5c33E8oH+dG6OEgIoyoNAMaGHshEVP6qjUF6kXONFWI4bASEX68DxjEVAbXHnp/uTwuweSjWNh46/kw/muwea1TAB7d/5+PbE8KuqgCyNdyhWSRvWCR/n646RHCsx9nS6r7ZhDADOVj9trIKKeMngAkfFtB4ufs8DjEMDRa9Y5oVb36G5wElQiR1Z9CzThquuo3F6HJU7zmMtr0DnT3/50bFDAj57IV2mFKPni5T6OPfQN+cKTQnQQMLSxVi6uVS/RsypkA9Mb03WDMv6vrAEfzNZIQBulbgUwgC4SMfOx2C89JqMafrMJPZRgP1NuLVQ2HoeLA2Fg3lbtgM28m86yOj0+w71PkwAnH4CcyJRiCZcPqZyUfmU+cr39n8p2Dvz39kCnglw1uDsEYzVjddDbSCQt8DtfpITyPOqII1sYXTHWZGAeVr++L0O/XiYJ9jUfjc1aU/eZhIDBSVA7oQOok3iYJ+aghykyEF/9+U4r9q+l0eqyrff8GNdlwFn9yc7V5TSHI6xUH6zWcqcZqE0XjIKLWIYHuurr6dsjb/FOs7qLgYl8UtzfRiveYXtbPEmaPOz+Kag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(39840400004)(396003)(376002)(451199018)(6916009)(6512007)(36756003)(26005)(66556008)(41300700001)(66476007)(8936002)(66946007)(2906002)(8676002)(44832011)(7416002)(5660300002)(38100700002)(86362001)(4326008)(6506007)(54906003)(6666004)(316002)(6486002)(478600001)(83380400001)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j+di4o66tgHwGrSva+bvVbIrjBTePb/GwEZEmwrPqoK8RIi/X3nxFadkb5NS?=
 =?us-ascii?Q?s6NBbtM3frniljQ4xjpr+pOEllhrSvXu8hThPq1+kREtotz9LgMNbA43Zy/e?=
 =?us-ascii?Q?rhqBhTMKF/7gGYwnOW5Go4XFWxM7Rc7Zsvd+NWwLyzpCVq0PSIwxqzvOhq5Y?=
 =?us-ascii?Q?8h9A2idEvEOVY7Jq9ut2EtFBCYCUfyDbqTHblsdSMCBk/INaT1u7GJPH/b1d?=
 =?us-ascii?Q?MmrIN4iZ2VjX8z6ffXrq23bwzF1DMnnHJ+yho7idhWK3HwTJ6SciBPFGvS4W?=
 =?us-ascii?Q?fX7jtZozR16KzlanZ6ul6PqhMDWTkHFdOC+hEu32j0R6IJpdGsJZKd79ikdI?=
 =?us-ascii?Q?2BF5OTKEQQHWTDDmZHKj360pVitqeKjG+xwVyWNb803NGDzMHUriTK83cMTt?=
 =?us-ascii?Q?BCdpgwI/fG65oHbun/fs1sHphZHA+7nPDkZ2AF9KcNqtp8+RiQ1nIJGFdtgj?=
 =?us-ascii?Q?DHc+trNEJZNw50yeYCDLzLJWUcgbu6VDNKUzU+hBusHC7P4soszklUKmazt+?=
 =?us-ascii?Q?3BnDrhqIJ1luUeUytwBYBCAlYC7I0wa+rLhUF0C9D3qv1E7t4RKGqmes4/wN?=
 =?us-ascii?Q?VUBtgdtCF/vy5jrX7ou03+bt1x95Vu0Tx/FzAPE1ybQ2emdrIVcJlLZ9VDYO?=
 =?us-ascii?Q?sT7UrdiaOsfyKaqbLe7+3jFXVrsnO7Iu5fmOe6/MmlkzG7der7jSqfslPleG?=
 =?us-ascii?Q?y4ayl0mn8h7vbI+89taXwDXaAb2gUM140c2GEejThTxKGu43usR3dIW0rRTR?=
 =?us-ascii?Q?M7OlTfWhiqSXLZz83nhT+Myk5L6Y7Ikp24HXZvXnN/QZNPIFG/8E00zXwacv?=
 =?us-ascii?Q?/x7qUndJ+t+uWTaLyQQnr+iE/7SLZ4KBU5ZGZ1bcAyv76CoA9SHaXRYl39W6?=
 =?us-ascii?Q?kECF6T0YMEjsBtc7NdA83VroIeKy6z+bbmofwl5CpSl+pMTKEJMo5P3FxoR0?=
 =?us-ascii?Q?S5z0qOOzwWBz9VRV4qNttewevdG6hHIb5UN3qjGsCFodb37z3gLhRnQHI0mv?=
 =?us-ascii?Q?8IYkOCyoxJgcf2bHBHm0aNceN2/ThdHMiYjFhAn6Wut7xUivBG6zu7Gr5fEt?=
 =?us-ascii?Q?2NxJmcrazSWJy1Re0rGD9Sm8GxnpXDZEpK/ZOoIwEtm9rrJUTt5f30PJjL0f?=
 =?us-ascii?Q?WOTO9TJcYgy/PVWizaugizW0LDocuiSp9ak9v/ZYbvVQWMAxvqUTIvtIgwoa?=
 =?us-ascii?Q?EjVoUlR9Qed4UjjP5mejK2Zb5kIrzhAB+K2yz/IERsn/Ubz6AwtaSwB61Pf2?=
 =?us-ascii?Q?XGJ3xY+wToPhaNtBTi0A2bgTFyqlM7zsKcoW5VGqs+QSm8k5IxfN1//vepZd?=
 =?us-ascii?Q?fsHWAnh6mJon5fFPdJCSAsBic9HqbZmq479352zUQ8Dj5YnX2C7wofFnR3IR?=
 =?us-ascii?Q?Xx3ozGYKRmQcEm606FB7oEEDPjBjPlyLKHrfQm27IjR//Z0/pkbuR50ztLGb?=
 =?us-ascii?Q?/DQWHzFiGPaQXzzYOQ06m5uNtzuT44mqNlRN+yK8xsAWEHn/mnT3afVJ762J?=
 =?us-ascii?Q?j93APqDVfcpMn9QMs5ASn4QlLqXOQH6dE46c0GrD92esTNBe79rtlbNqo78W?=
 =?us-ascii?Q?CqaFPbsFCPn6hlCE7cvBJBUs4ToPivQ9UR5HDauuceEYYwXp5ewxKZ/r6bZ+?=
 =?us-ascii?Q?oTdWlwCFvHR3FEAxEETvu+w=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3824a29-f6a8-467a-61dc-08db2a2d2709
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 16:56:02.2065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjulXtamMbjyJK5qc/J8E5UAENWoj5eWgt7SoqmyrRDHFAdAYW5DTw+NtnUNSjEKMcVP7D5sbdbO4I279GULZVeXr1jFBx2U7Lr62s1OaNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB5996
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 04:41:37PM +0100, Thomas Gleixner wrote:
> Gregory!
> 
> On Wed, Mar 01 2023 at 15:58, Gregory Price wrote:
> > +static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned long mode,
> > +					  unsigned long offset, unsigned long len,
> > +					  char __user *selector)
> >  {
> >  	switch (mode) {
> >  	case PR_SYS_DISPATCH_OFF:
>         ...
> 
> 	case PR_SYS_DISPATCH_ON:
> 		if (selector && !access_ok(selector, sizeof(*selector)))
> 			return -EFAULT;
> 
> I'm not seing how this can work on ARM64 when user pointer tagging is
> enabled in the tracee, but not in the tracer. In such a case, if the
> pointer is tagged, access_ok() will fail because access_ok() wont untag
> it.
> 
> Thanks,
> 
>         tglx

I see that untagged_addr(x) is available to clear tags, I don't see an
immediate issues with converting to:

!access_ok(untagged_addr(selector), sizeof(*selector))

In both the tracee calling the prctl interface and the tracer calling
the ptrace interface the tag will be cleared, which appears to be the
intended effect.  Just want a sanity check before i push it through, as
I'm not overly familiar with the ARM/tagging ecosystem.

Seems reasoanble that this change should live with this commit, so i'll
plan to squash and push it up if the change is reasonable.

Thanks for your input
~Gregory
