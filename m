Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3E16A0CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbjBWPb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjBWPb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:31:57 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6DA1989;
        Thu, 23 Feb 2023 07:31:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jToEif0a7lA24xJYo/VVLPAY3ourU5eWUGZ/a8cr7Su4lmTXC9N8OOyBuhxcONxQsFcP/WOIlTxAWP4eDsGGfUsKG84Lltzo1vhZLC41eEEvz8KTbCko4XY+1EsF62Nu+3uyphTNPmZK5tTJkUcEJOh+tf8Kysa35rZUypn4D2G0fnAeobkUSBoUS3DTVAAclX4l2pLVwM/cq20JtAFDPWP8mJRMRpiFNHt86VhRXm+SxQmyLIoqhmSczaObQBF0YDfGofYx+OEkiQv2BBKn6kKHm+bpwGt0cEyX/wjMsQRJdMvASLP3JzSOvO3aa1hM+g/J15xXqxxhl0hX3OiIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mj53csGjWA/xPndisqvBUabEXEo68GUvvcxfIEBs5sg=;
 b=XaWzornArqCTATpzSqrpLWGxyLrdV9bVAcFl+BJqR6JlgV79qli1xAXXAWoWXywGD575WlIZ+wf+HKIz4Ohbl4QcpbkNqcPxCKBO0V4alVQs4HwtGEOdCHuYLpXREfE8aF9pN2kO9VOZmv6Im6GeTjXJosNXIpuH2tyDmZrcqK8jWNgXdyqBCQEBY/C4unRFoq0rbcN3+zDKUrNI+C/Y523l5sqF37PVZ1CBwJJJGfVUgY+W2bhCkYkFvMXTUnlacbR/cENR7fVFfr0x+zZxMVmPuNP/hTefetM8ChUteTczL4wokIJz702WtWbMt59sx3wWvhEd02UJ+lsxMy07pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj53csGjWA/xPndisqvBUabEXEo68GUvvcxfIEBs5sg=;
 b=hQa14mshr21KRy5NkS9mBy0zmrQRRRv1B8WnTjpg+t0ru+Wb5NXzcakntUJAz5W1dGgcGWwKmXfZYm6xE5qUsj8TrkaekirRs1/4IVvnYtdwb9onchpqZOnnv0PQZnfNCopUEoWe1XFsW90Ru2lDOpvDCZAMUGd8/ajI2EC5Sp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by MW4PR17MB5162.namprd17.prod.outlook.com (2603:10b6:303:121::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 15:31:53 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%3]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 15:31:52 +0000
Date:   Thu, 23 Feb 2023 10:31:46 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH v11 2/2] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <Y/eG4oHc2jz6uSfi@memverge.com>
References: <20230221201740.2236-1-gregory.price@memverge.com>
 <20230221201740.2236-3-gregory.price@memverge.com>
 <20230222124834.GA15591@redhat.com>
 <Y/YzloHpiyOSvZfK@memverge.com>
 <20230223123020.GA26182@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223123020.GA26182@redhat.com>
X-ClientProxiedBy: SJ0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::6) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|MW4PR17MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: 8719639e-aace-47f0-82bd-08db15b3168d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCuA87rs047DaZwCiDeSvc1y2R2sMrDPeQzEsb4X7qceQYTKa6tZt5b0aIv57nPfMzj3AoowsjUsN2lJtLJ+q/aIttXGkxme1vUG0qzWLki60UJtrbNGkEKZhdQqWTrm4XWQQV6gKmoU1FSYLtnduUaH/r/JJwdqoPpt4kPcvDVXpjrMaraWsmwm1aH4Nf6G0nuSIsmcIs/y4yIsCXOKf7k6GOyp1vwnOmJZ7Aq8tJR6IZ+o1TUYpdPwn4O2VDTLTSRG2Kl7llphQ5VJTkEdIjiP+55vWVk9ryNL+6MQZMr9KOCMQKxIKPae61a71d+RbqgwaZBqawSgPj7W+UqqltqZRisxXEJYvq7AE6qJI6lEpoRjurxR6w2wfvWRIOA7k+y6YovK+i+3kG8qlBm4Vb7mdgsj0HPc11JfiorzQ+3ii0FNZqar2DgyKipP2oeUUtUtrow18791PZx8nuApwFentEahNlr7e8N9bWiSVJ8E7kvTc5dtihZcTrLE6lUE2Iue0Bw/7YfQVPj3JzSwYXJqqXVMml90TX7S7776Bs7MjZJz1B2dZRh0bWE4S4/QYNq+mL6WM9ffN2rC/MalsZ4Jl0fcO87feiKT28uil42pR/IEXhVULA9GN5SSCWFGrnnk2ZtGN4HyqpBt/fNlfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39840400004)(346002)(136003)(376002)(451199018)(7416002)(44832011)(86362001)(2906002)(38100700002)(478600001)(6486002)(26005)(186003)(36756003)(66946007)(66476007)(66556008)(83380400001)(41300700001)(6916009)(4326008)(2616005)(6666004)(6506007)(6512007)(8936002)(316002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mi6BBYIUBq6HIEf0p2cxxMLTUligK9dCuXleui3f39xTDpe0nnSdvvfpBDlq?=
 =?us-ascii?Q?C6rQQ1l7JUhzGZ2U0Dp3OxA+NMAO61RwwbWjpjnPKbxRyLvu8lB0n6f0Z1P9?=
 =?us-ascii?Q?/iFzGaOvYRGDakbzDFf6XPwPzBmZjZiEK1R84qbkmdMtfKiDACbpaZ5TG1I6?=
 =?us-ascii?Q?73EOkYSXQRTwbbmlxvxYFT/wy4tfLe1L8j80ugsOrJa2XQqZ9bcz6b8KE6jQ?=
 =?us-ascii?Q?ucI3m5sytrZOhVBI08LEPi1n6ivTV7biSDHORWEWtyTXeATG0Nq2kQ6DiLag?=
 =?us-ascii?Q?ih3AqDZ7EglVwQGo0mOpiZte/2Ew0az+FlAqrni0/G87DnXSAPDK/4zo+w26?=
 =?us-ascii?Q?qY2hn4DuwFRsiBhtAIlmymN5F4ttoWZIoG0EQCx3yxFTN5jJUXR1qHmyeaT6?=
 =?us-ascii?Q?qLN714AY6u+g0nWNhIA+i9L3V7bi8Q2Q6R3el+Kh356uASzjUxiKgmgCj9O/?=
 =?us-ascii?Q?BMV0m5rXRvpwGPgL5Zyy3qpHA4nn9HJ50ks5JfD4bjafNHHqaGUCPPAB3r6p?=
 =?us-ascii?Q?7enCetzueydQwz85iFXd8+jNlTJN+r0bpErov/CfKw7pMqaiThgYqosDvNIa?=
 =?us-ascii?Q?aweWQx4Fh8eAX2OhHeShdqeJ5b30G7p+Eq54GXVkzv2LWrUWXGDi1efVNgeg?=
 =?us-ascii?Q?ssaZ6DmFK7RACaCAycFpuw4+Tp5jem+kWkSrFgZMbc0Lq17bTnYbluGGuOV2?=
 =?us-ascii?Q?gDCvgp6Q16gKwYpCMkGnlbMY2zpfS+Rq7kXjwGEVsaeIl72CpW5XCdQ7/Z1T?=
 =?us-ascii?Q?NBQJp9K34SfZBujKGsrdVxdBLmzCD13WtEXdlQqOyz+u14iTzblyGjgdY6UW?=
 =?us-ascii?Q?Kl0Fn9mHOutUOxlIdRWFxCIXKmrJmRsoqFdzOMaIiMrXhDtFLzSqY40dMnaV?=
 =?us-ascii?Q?ZCWcBRJSGVs6w0bTDZH2XzSljD7ZrNuOsWArDDZubxiUHTU9w0C5dAvqkZJ8?=
 =?us-ascii?Q?gYPtLgJLF8PFS5TJfB1uqPw/kdt/gECiJZaicAFMccmX4QgQF+Z9pQoVHBpZ?=
 =?us-ascii?Q?/SC+XiKTaqJyactq6a3aNK0ZStg776Y85ruUtTUroKxpDDBtyWC5afqsJtTx?=
 =?us-ascii?Q?Tvriw3YJdbGDetgpmL3aC6hS8vFL7Nu/VKIboQ+V6YqsMOPIjyfMSzjOjAcm?=
 =?us-ascii?Q?bgO6MeXKMRW8WJhlPC5AJeI40vhT+qiHvfn7SPd/d+WzFcTTPU0PxJEvsU2g?=
 =?us-ascii?Q?vu3Jh8JKyFYz2CVBBD4JoMu9wrsq+5zMmIZ+/1vLCG272Gf8m4EiFj4Qz0Su?=
 =?us-ascii?Q?hUi9BlLZf9yFHrhCsjKqeWu2hkLq8yYvePkDgiyT/rPLDz42BJ6c+9LBShqc?=
 =?us-ascii?Q?yyzR6ZjdKV2fLAmxQqG8VTgJYZxmGEVGpJIs8e2BNMkQNUm7GN8m3pffcoVr?=
 =?us-ascii?Q?QY5BLvSSn2YeXRjgILsrv5LawgW2/LaiuUHKLP6w78JBmPF6A3/Py1mQ1FKO?=
 =?us-ascii?Q?LLujnNEZ+dQPqwSZ7DdeWSYT81ZoXPfHSbTEwA4Gf67Fh/dipQfcLIRH5mrN?=
 =?us-ascii?Q?tuwB6T2DmUfTJBI79hyf29zAW5aJc5QkCdkW8Q3swu5VSMHMP3O4IqKzQdm3?=
 =?us-ascii?Q?1uaWvcONB/X7+IikMzq/QvVZbov9gaTpAAeoO0FdfLe5LnHLMVDQ5t+MMH8b?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8719639e-aace-47f0-82bd-08db15b3168d
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 15:31:52.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EW7ZIK5ygF/RWg5dcyrA9bOHs6yQQlfhEO/Ld6Xfm7rHLkPMwkEM+HBMr9WdvKhxYQuhVRQGU6eqvNxdQ/IseXZN4DVCVt5W2cBJwROvoUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB5162
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 01:30:20PM +0100, Oleg Nesterov wrote:
> On 02/22, Gregory Price wrote:
> >
> > On Wed, Feb 22, 2023 at 01:48:35PM +0100, Oleg Nesterov wrote:
> > > On 02/21, Gregory Price wrote:
> > > >
> > > > +struct ptrace_sud_config {
> > > > +	__u8  mode;
> > > > +	__u8  pad[7];
> > >               ^^^^^^
> > > Why?
> > >
> >
> > The struct isn't packed, so this is for alignment/consistency of size.
> > The padding gets added anyway, and differently between 32/64 bit.
> 
> OK, I have to admit I didn't know that alignof(long long) == 4 on 32 bit.
> 
> > > > +int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
> > > > +		                     void __user *data)
> > > > +{
> > > > +	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
> > > > +	struct ptrace_sud_config config;
> > > > +	if (size != sizeof(struct ptrace_sud_config))
> > > > +		return -EINVAL;
> > >
> > > Andrei, do we really need this check?
> > >
> >
> > My understanding is that it's a sanity check against the above issue.
> > In fact, it was what lead me to add the padding.
> 
> Well, if this is the only reason then this check and the "size" argument
> ahould be removed, imo.
> 
> But perhaps it can be useful for future extensions, I dunno.
> 
> Oleg.
>

I suppose yes it could also be used to detect differences in versioning
if the struct changes in the future, and that would not require an API
change in the future to support it.

If something does change in the future, without the check you're kinda
SOL trying to add new fields.

~Gregory
