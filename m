Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C68669F7A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjBVPYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBVPYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:24:21 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1560B36FDA;
        Wed, 22 Feb 2023 07:24:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ww6hXc0O4L3glUa5VsSjeJH+Wtp5VOv2mfuzLs57/BzuUdhE2xNyyMD/B9Eva9CUe6fMOqY9yYaVXESqKeF/UPZSqPbMawpLDtwN7XA5s1Oto7qyU76m0UfU7Z2IQ4zYxeYvadddxUnBwdrRPmqRs0Mq0BqzdYS8/zcJ442TyloBF9eXdyjzZllJlt/j9VKJWvvgx4wQwRu/PCCl0hasey7Wx9GLpyENfzSEZQnE9ocfiPewx3Lw++GOX6SNl7QbN2DFcIvzt1IL5UeMadX2YzEqa7SCwJO1bsL0Y6YcAGFEOAQ8ZymAMrv4awE7OMicjnN80QScdfkbPjTYYq7YGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIEJUEHo2GRHrkf0aI2CheiVt8rE4V1nk+Gi4r5SXtY=;
 b=L+wroX/c7RGUAq+3WM9c6FG9pcP5c0z72nLIMiLZLspbmMvaQSUqc3q7372XwnsaELyg3yodNRQZNs1mo0K+2E3sZ5RAWHHsqOgwhXJPijY6gYGJkcr1jIeNnH3WnyhhyXrwNpGH2cFjXcxFcLNGFQ8oVQo8J9VAzvCweqF66/NDKqojCtHJIa1ue2jJZv+jJGfYuRsPzH2GNE4wYxb4qsF5CGTy/3dFYkcO3z5ZXfPLIECZYga/U+dexpwRgriiWxgtpZJdU2O+drq5YD2R2PR49ZiTVrMwtvHzhtU6SYT+mMXycG6wQYmjvYDof+e8i3FKg4cJcjJdmDaLFd4acw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIEJUEHo2GRHrkf0aI2CheiVt8rE4V1nk+Gi4r5SXtY=;
 b=roVaqISldIqEP3Gm4Q6c2epdoxOz0ixCa11PgCb732XBHBWQBRg+1nQ8eGFQGsqauD3An/cPKmVVgTJPJ3ZDYBVPf/hlcS0RXshRBE7+6yGmvehxVjBwDm5g3NiL8JfPlESes9/Fs7A4v16jaCWT9KuVIef5yaC0t5OwIMcx82k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by CO6PR17MB5058.namprd17.prod.outlook.com (2603:10b6:5:358::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 15:24:16 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 15:24:15 +0000
Date:   Wed, 22 Feb 2023 10:24:06 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH v11 2/2] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <Y/YzloHpiyOSvZfK@memverge.com>
References: <20230221201740.2236-1-gregory.price@memverge.com>
 <20230221201740.2236-3-gregory.price@memverge.com>
 <20230222124834.GA15591@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222124834.GA15591@redhat.com>
X-ClientProxiedBy: BY3PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::11) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|CO6PR17MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6203ad-6f79-4f60-ce23-08db14e8dbc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3fmQpRk9Mmja7DIdbV+RjEk2u5fTpCMrRahyRGVEYAUEx/Wje/gPvQ0Fj7tumiNYFt3Sa6mC0RlpL852HarDgqxSuEXByfShpXKPUP4F6/2pRX/gophQKwbvkH8ThYOoZwMnf4DFCWxPgQfbi8wSjPB44/0ZRRmsDVBJNdgGZtV9JVHmSeOMOAQm50UNfz6M0u4f3GDeO+yFlvW5E814PR8NBVK7g0BKz4Yzoj72QrjrbOw5T8JA1w0Hxdb8Q7Mv6BMeLimpF8T1HN2Wo+HfEk2L4yz349dhTqFooXHb3M4WIB+SDXenzFjFX4YCOhYrXuUphxUhLD5qfrRUD59GJvdARoYZ/uViXRdmrLV0IOaj4l3jX0/L3+Yc2rx8hfNDa6bj68b0WtnvIkGG+drslL2OTCqww3MX7ZJY+WdVx2y5BEc4qbXZp1KQw/E8PlrqWafC21hAKjBno+5AskHegtlc0ShOSY2mjsfbg//LyFItLfFjouxw1AnhGPRkZNPOjpjpJ/SQOMZiqyQyAAgnPBmBMskN+AXknR54pgswwmrZj2mmxENMQhpfNFlOeZB9hAebJuCDSqyL84bi5L/z5wrbwe2j3PTuMd5SwQmmWVOu6YVpOTHohI9FpuoXQ5Bum+j2FhHk8nM9WX89auvVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(376002)(39830400003)(366004)(451199018)(5660300002)(7416002)(38100700002)(8936002)(2906002)(478600001)(6512007)(44832011)(6506007)(2616005)(83380400001)(86362001)(6486002)(316002)(41300700001)(26005)(66899018)(186003)(36756003)(6666004)(8676002)(66556008)(66946007)(66476007)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WpF7rsgJ6tz4yJHXr4kAxCDRE56O8LwoRLMaKeb+dOoRIXtvXDoVUvawZOK8?=
 =?us-ascii?Q?O2G6696U3pIa5UpJBgK683oNUaueW9fODgQ124MfSqurgdRrZfH9I2OE5GLs?=
 =?us-ascii?Q?Zfye3yd84n7PdBWwgV+XLNaECoz7tLAZkGiSBieyzh+PPkXc49Rkz7C7Ukio?=
 =?us-ascii?Q?hRTbJ5byY/3C+dq8ZYvTrDSP/ndjPsj8Qa64Wv74kNpVvjxjuEz+S0QWgggg?=
 =?us-ascii?Q?4IasmqcwdxP/e86jCSF+CDmTJShz8mphYesbSw8nS7y4ZR0LY//RWM4/wEkp?=
 =?us-ascii?Q?IoLFiiWu4s1EDlIq8OhmRwaBhxZH3gk19Ixft0AT4zCRiOd/w2saZXSVZS2B?=
 =?us-ascii?Q?oPeN8gJ3D5p07rBSoIQaNcb6mWV2sa4k6T7WQWAIxK7+6shndTAvTcE3vky8?=
 =?us-ascii?Q?ZGCZldUc1SNNzQalIQdf59EKD4fnbv64vnXtugxAWcDFXYwii1VYVFkc0+nB?=
 =?us-ascii?Q?RbkGtTDORlGyLxK2u2w2t+ZN5zSXJt/aa/8Mu6VE4vu5EkfGBoTQ26hTcMMr?=
 =?us-ascii?Q?mZumXq9AaOA8KP1Fvs5LwU6GWQFpIBlQWhR5CsxULH8qhBlQlqtk2izRiNVj?=
 =?us-ascii?Q?eItEoZT1Gu66mo7j8YUjqHBiO6l/U8j/bNG3iy4FJcnn2My/NFsba5YcCJMj?=
 =?us-ascii?Q?HTjAFSW943CyGIydtKfIS6agZxWOvxtMpLGqpN10FdqayxzeKEjPJfZA1G1g?=
 =?us-ascii?Q?FJTv2mGxcR6m5iwPXsQ+aVXcQcHe9ka+5s0DqnvQ/hnzEU20FbSi4RC/YYo5?=
 =?us-ascii?Q?otB6a1waR5zJXuQwQwIzE1asZ+M9FL+4bIq5Uu6MfwcywNjGgy7VJRltT/U7?=
 =?us-ascii?Q?I9o6nrfS0GX9M8RkSdg/aCxi16OXx3v1RB6toBcTHaMguZY8SyFeGbMky7Pk?=
 =?us-ascii?Q?4blX8YMdgpoSuG8+C2W9SAkBKAyMjqPZqRjrHQgHUcrg1Oluo+pzQQKioDF3?=
 =?us-ascii?Q?d0hmRIinXGbGi32KMxkD+yTDGOsCIGNn5klSMVenNGEYqvirX7RXYq9mFqeh?=
 =?us-ascii?Q?3GfF+0YduAUGSejhtGc4SVtWNIeRCWT3dqOxcw1F2tx1Z8uvZc9BJszlcN0Q?=
 =?us-ascii?Q?ySjpHkpOlz/EGcvwuyyhlhnfOj1xrALKry6WBZ6sI7Hg0H1R8Se3qYilB/Qy?=
 =?us-ascii?Q?3ndxDJ/mxYxQhYo0aAbyz1HWVf5Mrk/RlQyaOHrRn6Y5Ui/egl1PsfpujXwk?=
 =?us-ascii?Q?j+cvdVU6q9gR6Etvb323KVNmnpqOjxhe6FLzPxjJcm9lkddPvyEOG1+JLZAr?=
 =?us-ascii?Q?0/V5k6vPQu0t7gm7kMuV9rHUW6AVwDres+K4ttDcwBiLwjw5hc8ziu3jPqJt?=
 =?us-ascii?Q?wJzh01UbRWh1Gh8kVoatAotyZcdXX34HOOhNEg3m1l4LLVT49zIstL8NJS6h?=
 =?us-ascii?Q?ivsjBi/7aCfzPs5uouWPAdWfHO71aLqNwdVopgk9dRc+3l46Og9CzjZoaHa5?=
 =?us-ascii?Q?P6LX4XP4fTTjHSwyO6d1gIZegTO4yL1K87TkJc3kwkFmabFw7BkNqzpGpwJF?=
 =?us-ascii?Q?yqteKEDjNQDLd4NpigbMvad+TKFj9mFuQRsVmOLKHkp7+C7IPImpIwOHqmcp?=
 =?us-ascii?Q?2HnDIToZAqw8wTozxBXRyCW5YeEQCFA/tNvNW1W2c4hekCbOkirkQJLAfD6z?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6203ad-6f79-4f60-ce23-08db14e8dbc9
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 15:24:15.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7cMjCTqTyJG98p0vGYrCaZdIBZtuQ3LFlTEP2KZ2HiG5iyaM+1gBIyj3ZCBwalBxDIh7ps+P2oDNVA6cglkaSKQKPwuHfU4sv15MHayLRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR17MB5058
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 01:48:35PM +0100, Oleg Nesterov wrote:
> On 02/21, Gregory Price wrote:
> >
> > +struct ptrace_sud_config {
> > +	__u8  mode;
> > +	__u8  pad[7];
>               ^^^^^^
> Why?
> 

The struct isn't packed, so this is for alignment/consistency of size.
The padding gets added anyway, and differently between 32/64 bit.
Without padding, allocating this in 32-bit mode creates a structure of
size 28 (4-byte aligned), while in 64-bit mode it creates a structure of
size 32 (8-byte aligned).

ptrace_syscall_info in the same file has the same thing.

> > +int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
> > +		                     void __user *data)
> > +{
> > +	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
> > +	struct ptrace_sud_config config;
> > +	if (size != sizeof(struct ptrace_sud_config))
> > +		return -EINVAL;
> 
> Andrei, do we really need this check?
> 

My understanding is that it's a sanity check against the above issue.
In fact, it was what lead me to add the padding.

Without the padding, sizeof(ptrace_sud_config) will be 32b in the kernel
and 28b in userland.

> > +
> > +	if (test_task_syscall_work(task, SYSCALL_USER_DISPATCH))
> > +		config.mode = PR_SYS_DISPATCH_ON;
> > +	else
> > +		config.mode = PR_SYS_DISPATCH_OFF;
> > +
> > +	config.offset = sd->offset;
> > +	config.len = sd->len;
> > +	config.selector = (__u64)sd->selector;
> 
> As the kernel test robot reports, this is not -Wpointer-to-int-cast friendly.
> Please use uintptr_t. See for example ptrace_get_rseq_configuration(). Same
> for syscall_user_dispatch_set_config().
> 

.rseq_abi_pointer = (u64)(uintptr_t)task->rseq,

aye aye. I saw the error yesterday, I need to change my compile settings.

> > +	if (copy_to_user(data, &config, sizeof(config))) {
> 
> This leaks info in (uninitialized) config.pad[]. You can probably simply make
> config.mode __u64 as well.
> 
> Minor, but sizeof(struct ptrace_sud_config) above vs this sizeof(config)) doesn't
> look consistent to me...
> 

I hadn't considered uninit data. It's technically a __u32, but it's
probably just cleaner to promote/cast here than deal with padding.

> > +static int sys_ptrace(int request, pid_t pid, void *addr, void *data)
> > +{
> > +	return syscall(SYS_ptrace, request, pid, addr, data);
> > +}
> 
> Why can't you simply use ptrace() ?
> 
> Oleg.
> 

ptrace() is the libc wrapper around the syscall.

I would assume there are issues with #include <sys/ptrace.h> and
#include <linux/ptrace.h> in the same file. Since libc doesn't have the
new definitions.

Not sure if there's any stipulations around how selftests have to be
written, i just wrote this one based on the surrounding tests and got
it to work.  I would think direct usage of the syscall is preferred,
but i'm ignorant here.




I'll make some changes and give it a few days before shipping another
patch.

~Gregory
