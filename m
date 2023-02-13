Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B87695283
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBMVAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBMVAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:00:36 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5058F26AE;
        Mon, 13 Feb 2023 13:00:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HELbxL9HVLSCbz8gWUbPfXugeLGx+pa6b/95da69qv05K5AWZ3yisSRN3C6VjI9xDe2Y9AD1AJZzkenav+PV6khzzlxl+WMflsYBFcN9gopomh1A4wD0E3sFkdv3C1q4hXl7KPt1Yhbsj1tPBRSnOHdDFzsbyJJpwquHvABwpU5NCL6T7ncC4xGGfjjQzspx8yVrJ10vK818okwKFi2tbUsJqFoJpjjgy1AWZQrYR7qDhWVzhdVUSFdf0x7geaL+Gz1WbZy3BYDyazcoBXTcgxlIZurGQawPLQTrdvsb4DIeEmWLrxVZ7IrkRZrmVmNTYXAQj2F/Llj39QGyJT/nqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pczjwAXtJQtkord87XVOOvUALSGM5ZkRZJXzgRgArAg=;
 b=nCafcUJhWwTUu5bc4CkVXAIaQNASdA2UhTtZUM47ueer3BhkDa4ePZhhchTKsjBL0DFleMtvKP7FUHgPFPrkKnoKTpl6id3oVye5sT3dEB8KughVQhPFOCTQZOGX/qKI1tOnmVGz59wQ9n0/NaGvGVBgxHHK1k+MY5HFXum7M1m4wbceXP3BJoRjWtFcmSZ9WOzLjVR1h+BP7CZltWf+I3SEgCXK3uKvyJyFNzLXtaGUI8sxoTGcwuuKp4t5pbETnAazyp5pr1F4Q/4LrvnVXCtKBM+J0Vdd2KIc8NYF3i/2+pRXFyad6GdeLjhBh+cyOcoayZ6ZEu///SD409nkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pczjwAXtJQtkord87XVOOvUALSGM5ZkRZJXzgRgArAg=;
 b=R8y14Fy1LRbXixudJx/sml2bbh4vSr0yySzeD3YzYT9h6HCQ69JczM2x7A93VpXR8N9SOXLTHruQOIAqDlW+JfBnY2AiFCdI1Ckxcx7ptj4+gDflTFk8jbaEy+5nw0oZnQkpQ3IW/f2fVAN5uOqrTl7iX2JBjqrw4BrGa41XkEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by MW4PR17MB4843.namprd17.prod.outlook.com (2603:10b6:303:10c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 21:00:28 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%3]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 21:00:28 +0000
Date:   Mon, 13 Feb 2023 16:00:17 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH v9 1/1] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <Y+qk4fkIph40KyDh@memverge.com>
References: <20230210072503.1808-1-gregory.price@memverge.com>
 <20230210072503.1808-2-gregory.price@memverge.com>
 <871qmttiqa.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qmttiqa.ffs@tglx>
X-ClientProxiedBy: BY5PR16CA0034.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::47) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|MW4PR17MB4843:EE_
X-MS-Office365-Filtering-Correlation-Id: dfec24b8-684c-4b34-27cc-08db0e0555d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rE0Ej1ihG4i+CNaeaaKWvhOUjAUw6Sd4/tZM4obHrapnxGrvGnXl0xe7vYh5/TDvYkEQEim6lYQ4Hm4sNVuTRYDMYOZozpijg4crox3pgh6mP9UN6vj7bW89hyFlKsm5oY9Fdx09nNSCCMT+/ZDo5a2c5lIFhEOvztC2lKe9BV8DcbJ9BjtAORSRcoDwvgRQsY2WZYexemAfgQJrJhpqm6l+FXMDqyrAjW01H6+uywH6TQvDcsOurhqWNyuONC76Ev9p+ytf62lAaKl6JHFkoAqQDHt6DLQ4EjKuezevDVFei42Fr2TUEECO57GmVXtiqM9LSB6bNP9HBMZNN57/Av9B98T9xzvjqH3Od4ov/Ju9GS95FlI0viEv0CjBQXAFiLsYqEK/jABR8kLUbzin3AsU8qiPGcexpgmU9MvyIkaJBtI3oD6P0Y0w6CaaUYJLyLjgPh2hHpOiFPXO5SMpOkBH3/KuTbBe7AQi4yiRVL+XmXeYBosgMSvRAHibGC4OBntR2l6g+wHCl1HqOKayCA9UPTuAAh9g23M/y+GhdI3OcJXiunKmoS4eMjGJ0xalALuy6A5cGtToBf5RbV3sw+jVyzMbNA8YYMnXrhphNoDBRWFzgidTyVqqCgTNHcZrb89dlbztKaQbA18xZEp+dtjKimAnttVVj9IzEc4CVOmRkSn1EIXLFrh2IWHWMDD3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39840400004)(346002)(366004)(136003)(376002)(451199018)(2906002)(7416002)(36756003)(44832011)(5660300002)(6512007)(83380400001)(186003)(26005)(2616005)(66476007)(6916009)(38100700002)(4326008)(66946007)(8676002)(66556008)(316002)(8936002)(6666004)(41300700001)(478600001)(6506007)(86362001)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XCGWdvCbzZ6rALvcWcI9tjG/XX7B62GwTI7rz4Q8IRbuDBWz3t9VCWFQB/ek?=
 =?us-ascii?Q?DmGkIrJSFE2vNhiXLA/RB+HM1tQscJS6q9c41SiX4ZGgaICIj5rWMyU0ykXN?=
 =?us-ascii?Q?W1qELwDkCIpYpUTXxsPkz7SzVlVXbYWYhhM9vgc92v5+1ho818rBNxLJ5NJ+?=
 =?us-ascii?Q?DIZ0NPxwA68lDDanEsxZ6X0FprSZmcZaWKDQJwQakX5b67Pwz3VSOS2gC5nk?=
 =?us-ascii?Q?59Yz+2Rmv3y6ruEheJYl7uLT6/Nb89Hkp/8nHemK2wj6dNEzlyFqRKjPmvP7?=
 =?us-ascii?Q?bi+1orXG97DvtpcJZkPMRQvZFOlvBh1b1jWPi0urOSLToQAHHT5klPO61zfm?=
 =?us-ascii?Q?2AVgouDgaNu7ykTx6kVAn+ajgBs/62vtUK+clbYTB5LRG2eQlcKCdatICxn2?=
 =?us-ascii?Q?WVEAZq4b6XSVdVmHAEK+H2izkX/CO5N3iw75O48O7djC8PCrghadRogWCCs/?=
 =?us-ascii?Q?iDVVY0ec3QkEvvwhnixuFjWnXlAgqkAJ+iBvxnFUcdEn9GhUc3P6dFtFt/vf?=
 =?us-ascii?Q?d+VfVlN1bmbZRE1R0BDUtAGnsgATlh1kyYok5l7YjONKbwW2MKTkxZ3Odqkq?=
 =?us-ascii?Q?0chZ+dmsmJGUqYN9AGY+bdSaLid1v3EgGDVlkEdfuYbHg/EWPaeNuIMdR7TN?=
 =?us-ascii?Q?/6OBVmFAcAvbLCLVkkgyxiyw73HLb08ACoD1w1QPFS9KmUI+ZixPsKNTUv/y?=
 =?us-ascii?Q?pBdD81AatTBQg5Kq63RvtQsi3l7248skkrRwCvRmX9cDQYtO5Eb7+1NpdZ1G?=
 =?us-ascii?Q?DMBCE6GZOiCSDLUPmVvIzfCSzSBR7w1PLK30+2Y2p4jTjOL5F3ZLqFMlmllP?=
 =?us-ascii?Q?7rTO+C+ru8cmWBNDzXsgcdciRH5YDZKDDPq8dEfW36AvqVcJVAUka+16pRNO?=
 =?us-ascii?Q?F+f793pxkO7aKqh7mr+22C3vYnf7y8rb/TTgVnbx88d/q5pWhyN4IjKSVIgP?=
 =?us-ascii?Q?fKpnPxpyvkclgMP3MBYGCpgcUwl/g3H3VQgEjnfGvzric61mQK6wLAp12Vbw?=
 =?us-ascii?Q?BgDeq+UPFkLKUNaDQSHvRapD2mXlGL1BTSAjK34iE1EWndq6QY6Uo+E+HIOq?=
 =?us-ascii?Q?wvrneCE5uGTD9bXUi4fqhRss7QDPXoO5zDpoJRc46mctbVAfnnKPJZHhhrMz?=
 =?us-ascii?Q?5IJsp7osoKEHR//hQj4vWCo7l7o/nPYH3rJp4G/cXAGfGtXOvMx49dDm/c5r?=
 =?us-ascii?Q?gbxp0Pm+DdSPlxuSpoS1lh5BHT9OMo0tUXleHyCEhjIe+KiHtYari0+QWc8U?=
 =?us-ascii?Q?+F3C5Zid0bzyNIj4OjbCN24TWcx3Q6VelOZ8XMARyZXD03KPy5eYuH9ytADf?=
 =?us-ascii?Q?GyBct6i5wkb9Y5VgQa+KIEJaf0v0qZEFKT1/EGGldLAYJypyysiXBuXXM8OM?=
 =?us-ascii?Q?1SB3WOOCgfR6MA2y2v24OJZ9sLGY8zwx36a4DU0SZh4CrqiGPRHpHBCRX1tv?=
 =?us-ascii?Q?tQZLRiKXoc1wVMO2oEYPJ3Rn2GHAp2XmfpGnQtggPIabV3BtXklQkvXv4jh0?=
 =?us-ascii?Q?CLJl+otZIkf3UKULKGMlNxCvqAZUmvXKXrou3tgrjqgpqGnj4VeD3is3ythO?=
 =?us-ascii?Q?eAQ3jsIIfD/uV6oVHGdT2TseaBCgxKGnA2KB2R1I9FVejn0HZf7mmBH9MCHL?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfec24b8-684c-4b34-27cc-08db0e0555d5
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 21:00:28.3527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGyInsZjTfR25kZPbTBhQFOGJ3f3psAAN/15mKUqOg9eZp+V9ctJMqV7OOne/LBgMRo3lazPeaX1WthhV/yctzouvw/+XOCiDYIM8TNpX5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4843
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 09:26:21PM +0100, Thomas Gleixner wrote:
> On Fri, Feb 10 2023 at 02:25, Gregory Price wrote:
> >  
> >  As the ABI of these intercepted syscalls is unknown to Linux, these
> > -syscalls are not instrumentable via ptrace or the syscall tracepoints.
> > +syscalls are not instrumentable via ptrace or the syscall tracepoints,
> > +however an interfaces to suspend, checkpoint, and restore syscall user
> > +dispatch configuration has been added to ptrace to assist userland
> > +checkpoint/restart software.
> 
> The above is incomprehensible word salad to me. Once the ptrace
> functions are there then they can be used independent of CRIU, no?
> 

The verbiage here is half-baked, I'll just break out a separate
paragraph to explain better (or drop entirely, if that's preferable).

Since SUD isn't really designed for anything other than syscall
emulation, there's not much of a use for these get/set interfaces
outside the context of checkpoint/restart.  GDB and friends are already
perfectly happy and capable of debugging SUD enabled software in the
absense of these interfaces and have no need to disable the feature.

> > + * struct ptrace_sud_config - Per-task configuration for SUD
> > + * @mode:	One of PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF
> > + * @selector:	Tracee's user virtual address of SUD selector
> > + * @offset:	SUD exclusion area (virtual address)
> > + * @len:	Length of SUD exclusion area
> > + *
> > + * Used to get/set the syscall user dispatch configuration for tracee.
> > + * process.  Selector is optional (may be NULL), and if invalid will produce
> > + * a SIGSEGV in the tracee upon first access.
> > + *
> > + * If mode is PR_SYS_DISPATCH_ON, syscall dispatch will be enabled. If
> > + * PR_SYS_DISPATCH_OFF, syscall dispatch will be disabled and all other
> > + * parameters must be 0.  The value in *selector (if not null), also determines
> > + * whether syscall dispatch will occur.
> > + *
> > + * The SUD Exclusion area described by offset/len is the virtual address space
> > + * from which syscalls will not produce a user dispatch.
> > + */
> > +struct ptrace_sud_config {
> > +	__u64 mode;
> > +	__s8 *selector;
> 
> How is this correct for a 32bit ptracer running on a 64bit kernel? Aside
> of not wiring up the compat syscall without any argumentation in the
> changelog.
> 

you're right, these would need to be unsigned long/pointers, i will
take a closer look at how ptrace manages this elsewhere and come back.

> 
> > --- a/kernel/entry/syscall_user_dispatch.c
> > +++ b/kernel/entry/syscall_user_dispatch.c
> 
> This section:
> 
> > -int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
> > -			      unsigned long len, char __user *selector)
> > +static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned long mode,
> > +		                          unsigned long offset, unsigned long len,
> > +		                          char __user *selector)
> >  {
> >  	switch (mode) {
> >  	case PR_SYS_DISPATCH_OFF:
> > @@ -94,15 +96,60 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
> >  		return -EINVAL;
> >  	}
> >  
> > -	current->syscall_dispatch.selector = selector;
> > -	current->syscall_dispatch.offset = offset;
> > -	current->syscall_dispatch.len = len;
> > -	current->syscall_dispatch.on_dispatch = false;
> > +	task->syscall_dispatch.selector = selector;
> > +	task->syscall_dispatch.offset = offset;
> > +	task->syscall_dispatch.len = len;
> > +	task->syscall_dispatch.on_dispatch = false;
> >  
> >  	if (mode == PR_SYS_DISPATCH_ON)
> > -		set_syscall_work(SYSCALL_USER_DISPATCH);
> > +		set_task_syscall_work(task, SYSCALL_USER_DISPATCH);
> >  	else
> > -		clear_syscall_work(SYSCALL_USER_DISPATCH);
> > +		clear_task_syscall_work(task, SYSCALL_USER_DISPATCH);
> >  
> >  	return 0;
> >  }
> > +
> > +int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
> > +		              unsigned long len, char __user *selector)
> > +{
> > +	return task_set_syscall_user_dispatch(current, mode, offset, len, selector);
> > +}
> 
> until here want's to be a seperate preparatory patch.
> 

I had considered this, but didn't know what was preferable, given that
there's not much reason to create the functions outside the context of
this patch.

Will do.

> > +++ b/tools/testing/selftests/ptrace/get_set_sud.c
> > +	child = fork();
> > +	ASSERT_GE(child, 0);
> > +	if (child == 0) {
> > +		ASSERT_EQ(0, sys_ptrace(PTRACE_TRACEME, 0, 0, 0)) {
> > +			TH_LOG("PTRACE_TRACEME: %m");
> > +		}
> > +		kill(getpid(), SIGSTOP);
> > +		sleep(2);
> 
> The purpose of this sleep is what?
> 

artifact of taking other tests as an outline, will drop it and rerun.

> > +		_exit(1);
> > +	}
> > +
> > +	waitpid(child, &status, 0);
> > +
> > +	config.mode = PR_SYS_DISPATCH_ON;
> > +	config.selector = (void*)0xDEADBEEF;
> > +	config.offset = 0x12345678;
> > +	config.len = 0x87654321;
> 
> What's the purpose of these magic numbers? memset(&config, 0xff,...) is
> sufficient, no?
> 
> Thanks,
> 
>         tglx

Nothing, will drop.

~Gregory
