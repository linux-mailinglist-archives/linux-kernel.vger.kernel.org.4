Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2786C3C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCUVMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjCUVMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:12:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A09457D33;
        Tue, 21 Mar 2023 14:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXR3aRnTBmSGg9LtE1i8Fdd93tdwZfMRw4hpDFgt0E+VVpY1XM37pp50a7+/EVqNi09rFYiyqIXH1G9JQYmbF5lgPYfE2IWL4bGtUnfhBuT034e+v+aU61/FafjToTnBkbn+4Pd979lGXvYQFE+8gmAr7uWeTWhYUSrVxZfy/Oqfj5PdHkmCRLIE/6skNry76QrHsREt8TuuzVeJlMVOoKiT8IdVwgmuud7u2ZAQ6fmJ0OxNTUCkG5juywaeLZT33PS78v6mf269+CJLS4vmP6aODrBcH6+UzafdB2CuuFpw4435cNcJa9Qf5aOd4apfPEIYUrjPpP6JStmU9QJV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7y/63g55YaqLwa3uMIgrHDNeTq3wMpHjylXpEqxVLY=;
 b=BKXLamlbNEhTVzdtlUUSzEsQqpuy61JP6tf6xLFITsvwpXDvCCCEHwGL1fRVX0sKVzofDodDvYyuVBfyjrPX3qa1d4nNpa+exw1fvl+RhaHMhNmLsPdFtQvr9z4c7qBG8g3pk71YANCBDDrUWA0F8bMAmCm/0nfWPq5Uu2kaa/1dsBt2QoZ3lwAXgPHKSK4bJkeXxuhUDTpgCtrCkf2RuRYp2rlk+7HEEK6naKmdsKg5ZSsWilYealO51T1qDqjTWrsJoMUt92iSQV9ySYHxSKYod1neoh8Dz5wJC12tZoiJ9L9Vp0q2twVbfMMUhQi3gfi41XAdHiuY+G6ogXSfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7y/63g55YaqLwa3uMIgrHDNeTq3wMpHjylXpEqxVLY=;
 b=SPvlOPv49juDeDzPbS4ce2H2og4WfeXFLFC+Y4MqEEb6wv+recv0lKo+J1vrxMtXTOdO9ESWgsIecgrkMhhd+EuVNrEJpZynCLAJNj14h/kmmNvSc8A3Ydg6BmOcSelBQ1e6xyvt2oOwR1gNZCPzIfwgMF23I6nQoWEyGdDy938=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB4487.namprd17.prod.outlook.com (2603:10b6:510:12::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 21:12:37 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::12d5:2d24:8d15:1c05]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::12d5:2d24:8d15:1c05%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 21:12:37 +0000
Date:   Tue, 21 Mar 2023 17:12:28 -0400
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
Message-ID: <ZBodvECutssWNo6a@memverge.com>
References: <20230301205843.2164-1-gregory.price@memverge.com>
 <20230301205843.2164-2-gregory.price@memverge.com>
 <87cz529kni.ffs@tglx>
 <ZBnhmtvlenY15P32@memverge.com>
 <87a605anvx.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a605anvx.ffs@tglx>
X-ClientProxiedBy: SJ0PR13CA0196.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::21) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 0697758e-ad11-49b2-e16b-08db2a50ff5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yU99emxG3xzgBIc4qtu2y5dXv40KfjSS3sjC/Fx9C9wNnSWcUvhqyB6X87pGb4S40K7pWF5ziY0F0AnkV5FEpYVfwTrZzte6klwgr1BIEDja/TTGWn1LKRU6Ecw4uSAhsePVqZDWbLFTRmxjqAq+mCS2b+VVjsFgJHwI0PjfqhBWXX8hZeY/JaiXO5DmSkhSrtNovJubji307Des3g/HjYoevobkGKUJ9/VaHqPKtUM946tCME4ZpaBVUg6caWenVTs+5Iy6K2Xn8lEVeP3CRjjpGlC9/ly+DojKw721oaczhYo4f3FmYrIub1/Kbi6bGjBboy8v235Tbb+P/k018Uh4ncR2veUZSUj2P5402EBPqE4dG59IikY3rTt8VyANu1PEVx39NCnfNbzjmPHS59MGpKAhAxcLddJTIU0/8FLLihFb8bPB6TqzngbkABzEPgGgc2oj8s4YJSPAh1GnD39dU/h5wy/4zpLeYyyMtTjQBrdZSV4Ljz1T3tIwyf9XvyBgsQR9GDiIWKo+lRi9mzdbSooW6vjUy8wc26wjOHODEYyHTUUiM6vZUhNNgKj+0jOdXudaqthk2aGow/rkqof+stg2P41hfxZs6Vm4RN/LXk0RKrbZOTjmjLd8Ki74Xlj24jMYeKzaEjD9qyBcSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39840400004)(376002)(396003)(366004)(136003)(346002)(451199018)(2616005)(54906003)(83380400001)(6512007)(7416002)(6506007)(6486002)(478600001)(316002)(26005)(5660300002)(6666004)(186003)(86362001)(38100700002)(66946007)(41300700001)(6916009)(44832011)(8936002)(2906002)(66476007)(66556008)(8676002)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D+LPnVGXFc75Va618gF11VRfbRGN5qaOuAytzi+ZaM1txDwUedzqEPwOl1g/?=
 =?us-ascii?Q?f19+4S3Ubc14gyW9bUcoV+olPvdN8I1UF0F1K4x+Wnud3YDz2XAIP85LWSTI?=
 =?us-ascii?Q?K+LRXBvf9Z4HrzDTfQiYzmYrVOC2lFiS/zioCx/7yKg2TY988ICZaVNo3InE?=
 =?us-ascii?Q?UV+H3TmicAvJ2hg4owP8XXLigyyQ685u3V+P0sTOYs8AwoL+fmyE4JQ+10i6?=
 =?us-ascii?Q?qWyKCjFVVcc3wu9XevNmE2MF/9lxDgxLhMYer1ohdN0k/6Do9nXyAIANAoLv?=
 =?us-ascii?Q?IIbfR2kK0xTeLZVUo+CsDhhP6CCJfo/kCa0v2rb8wy1wwr27ezkOaEP+72q7?=
 =?us-ascii?Q?wUO06aOEXnSyYxXWkE0wgEdJ7orJPu3hY8nMicNI9CUQ1SJBHo3+jdL7ET+D?=
 =?us-ascii?Q?AD8J8IWS0yC/Ybwduu/1vbuMk3gUCn0+mc0kdY9EPxwELNeTJz7rcC/v0Vo1?=
 =?us-ascii?Q?ekDWml/yOO+J4euNpxjHr1DtUuY68wTdqUliRSwfYYomH/BaPRXc88rchHmi?=
 =?us-ascii?Q?dPfWGzafcid1LAfNoBCkc3tx+YcEPPvKoMTk59BgT8i6AglOqYx5T4wZWnV0?=
 =?us-ascii?Q?GpH8nvlnFmOQL9ZL0d7DZhCoLBnC14a64SEduNiPkCzWBovkWejAZJqh4YLE?=
 =?us-ascii?Q?shEal/i7EQxoq7HoRCjlpl5ZknPPZ9YUHWjOBLgZPIFMj30Lmp3+RoQAOQvA?=
 =?us-ascii?Q?bPHc/Sv0eJm/qlEQpMdZRG2WaiDd5DBbebIZ6IQuDoXjytL/vyz7Gd6oU8Qg?=
 =?us-ascii?Q?4/nsIFSVkppBVAa2LqnRlHxPd+KRBudJu0KqrmPiFLbhkmj/w08eEK8VuQg1?=
 =?us-ascii?Q?JTRxaYbJb+sM6CS3vShCbskbO3vBxgBoKTXJPvjh2Nc/jFAW5MBSfWQPcdkc?=
 =?us-ascii?Q?0AYAq5EQIFew3b+dBx/8pgFQSXjLN7OuOaN66MS9sKQGyJvp0YT4UCigB+id?=
 =?us-ascii?Q?0ql47Qr41WKJYojn7ZegCIgk4KNp/0Y0H3BN2t5VPdgAwi/rxMW/CkTIaWCb?=
 =?us-ascii?Q?gUKLZD63UzixMwMD7zY3cr1c4//jtPfe7jJHsGjo8lKyTpHtWgl3TcVlP3ey?=
 =?us-ascii?Q?Rhv1Qowo+lCx0lsRJSb0Xs5DW6vDHvPtQNF5m29gGX73qICh/4peRO7w1qgI?=
 =?us-ascii?Q?1vP+9Ta2HMb1VcPA12R/nG2UvdpJI9rUkjjLufJKLamn/n09l5Tq9vpTayXu?=
 =?us-ascii?Q?j11I0Y9uZMf6qpYsaETIHTAN5bepvU8ZSigMPoNyIfSamFiwb3bFQ83cOj6V?=
 =?us-ascii?Q?90Kit4msej1kQMQPrQ5vPrKsCGGDV/VAM4BUbbtMsRoNCOnFrpsvAlKXd3pt?=
 =?us-ascii?Q?U/EmxyVUXPuZ7zT3CBO4P4ffUkG9iGsEESajPIWckHqgi94PhyoHXGl0CMbK?=
 =?us-ascii?Q?AXOZkioeyhzvHwF/v4JV+MeJgebhbhKFsuwx1wZdNvVDywO9VCTS+3aodXBK?=
 =?us-ascii?Q?WazMLtMMcgzJY+Lt9+9AqSofnkrhFDDHj2MqVl7NuDYYwrWw6IjMryaBiChg?=
 =?us-ascii?Q?/F7/WhVGQgf1lpxePXxDYyVwlNPTLGNV0yWOCODgKcHpvos7m8CwqOxgbfNX?=
 =?us-ascii?Q?d7ZwoJ6fP7yFU+w8Tv9hAbk0YXeQVFgc9NSWPrmLv7BNnId+d74k/k2HbEW4?=
 =?us-ascii?Q?xctkGZwudDd1U8twlgh37Vs=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0697758e-ad11-49b2-e16b-08db2a50ff5d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 21:12:37.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1p9sCWhVoEuQQuy+r5wSdkJ3cyKcgJxzOI4QRMOq6PunWjoJIlP8Q61lZYwCJauIUjMO3aMwXE1fkX+MsmG/Jr37P1PBhqpXQ0N05SAuG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4487
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:46:26PM +0100, Thomas Gleixner wrote:
> On Tue, Mar 21 2023 at 12:55, Gregory Price wrote:
> > On Tue, Mar 21, 2023 at 04:41:37PM +0100, Thomas Gleixner wrote:
> >> On Wed, Mar 01 2023 at 15:58, Gregory Price wrote:
> >> > +static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned long mode,
> >> > +					  unsigned long offset, unsigned long len,
> >> > +					  char __user *selector)
> >> >  {
> >> >  	switch (mode) {
> >> >  	case PR_SYS_DISPATCH_OFF:
> >>         ...
> >> 
> >> 	case PR_SYS_DISPATCH_ON:
> >> 		if (selector && !access_ok(selector, sizeof(*selector)))
> >> 			return -EFAULT;
> >> 
> >> I'm not seing how this can work on ARM64 when user pointer tagging is
> >> enabled in the tracee, but not in the tracer. In such a case, if the
> >> pointer is tagged, access_ok() will fail because access_ok() wont untag
> >> it.
> >
> > I see that untagged_addr(x) is available to clear tags, I don't see an
> > immediate issues with converting to:
> >
> > !access_ok(untagged_addr(selector), sizeof(*selector))
> 
> If this would be correct, then access_ok() on arm64 would
> unconditionally untag the checked address, but it does not. Simply
> because untagging is only valid if the task enabled pointer tagging. If
> it didn't a tagged pointer is obviously invalid.
> 
> Why would ptrace make this suddenly valid?
> 
> Just because it's in the way of what you want to achieve is not a really
> sufficient justification.
> 
> Thanks,
> 
>         tglx


Ah, I see, The issue stems from this code in arch/arm64/asm/uaccess.h

static inline int access_ok(const void __user *addr, unsigned long size)
{
        /*
         * Asynchronous I/O running in a kernel thread does not have the
         * TIF_TAGGED_ADDR flag of the process owning the mm, so always untag
         * the user address before checking.
         */
        if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
            (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
                addr = untagged_addr(addr);

        return likely(__access_ok(addr, size));
}

The calling task clears the tags if the tagged flag is set.

The problem is that no task_access_ok equivalent exists to validate a
pointer based on another task's settings.



The "clean" way to fix this issue is with a task_access_ok, this keeps
things portable.

On ARM64, it looks like refactoring access_ok into the following: 

static inline int task_access_ok(struct task_struct *task,
                                 const void __user *addr,
				 unsigned long size)
{
        /*
         * Asynchronous I/O running in a kernel thread does not have the
         * TIF_TAGGED_ADDR flag of the process owning the mm, so always untag
         * the user address before checking.
         */
        if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
            (task->flags & PF_KTHREAD || test_ti_thread_flag(task, TIF_TAGGED_ADDR)))
                addr = untagged_addr(addr);

        return likely(__access_ok(addr, size));
}

static inline int access_ok(const void __user *addr, unsigned long size)
{
	return task_access_ok(current, addr, size);
}

#define task_access_ok task_access_ok
#define access_ok access_ok



A similar change is made in include/asm-generic/access_ok.h

If this is an amenable solution, I will pull this into a patch ahead of
the changes in syscall user dispatch.


~Gregory
