Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D57E6D016F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjC3KkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjC3KkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:40:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3464830ED
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iG4VSaHfvNw0P6UQKGPpQdL4jBbnUDqRbgQXxSsxj1d4GgPPmgeuFI5Adhsr8y8T0J6t4aTFHaskLwjHEtifJlQIKsXufcQ0geeuKbYi0xvNPSk0ojV1dG9bqbLNfa4/phbW5B2eKNHPtx8HdUMfjRO8gmun6xh3+67mEE2v8XDqv0eaMTP9wrLR6YdLc2bVDpo1sG/E/yMarO6wETlCbGuiAGUc6NZx8e5tLPmiLNehU0/6C5SNhXb7CI9c65ztMv8DsFjg+ktc05uP8HiaOz/4Qwm/B4Yfc0vRANcm362v/xwDRJRsNbk0lYz1a0evOv7NHpXrMJft1zrYklUEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P789bhQeavi5O4msrwUd9CN+78Ng2kBtERmfu9MQ0g=;
 b=mMeu/mSBiJGD+fg7eTYxrYIPGNsj/ZiQs4+IgazdIzSuniJVYRD1SP1/I+NzizWfi/qjt4Y1eqLIXt1JC0T8Zm7MBLZr+bcs4poq2YV7Y4dyQ3VtO38rOQz1BrILiAayvRsL86BeyJcjw45uSWNbV0gxgUMW2iVhXMfS9B6cS5bUJ5AZFsqyhzARn9dO1eQQz2wsNac2PH7yb2FoyELjTGrZSwUthMKi39hEcQFAYgds3Bx+kDI2nmKUPIH+QtTvTSp34/D6DZMU8M8HiU+P2fkrnxwRy/0aA+OJxtdfyIH9FEVthrD1noHTXbGiuixDxn2qPLvIHXlIUn8tsgq4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P789bhQeavi5O4msrwUd9CN+78Ng2kBtERmfu9MQ0g=;
 b=YjNKB+8ZwKqsuT3TXk3EE74EwRMpRuQ7dg3JGFcR1uWNTec5U1g+K2mpgJCllWpbFCxX2QtMMrIg/A55MJ4jDFtyu8r5gljGFh2KnidyKmkUHCMNcU1QPvFW+emFvhkKSyQfcbYyAz5k1Vs8fo5Vt9sfiTLKkw/slu13YpXLeRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Thu, 30 Mar
 2023 10:40:08 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::7284:3bb1:fef0:a6c4]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::7284:3bb1:fef0:a6c4%3]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 10:40:08 +0000
Date:   Thu, 30 Mar 2023 16:09:55 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Libo Chen <libo.chen@oracle.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/1] sched/fair: Fix inaccurate tally of ttwu_move_affine
Message-ID: <ZCVm+93vj4oiQDO3@BLR-5CG11610CF.amd.com>
References: <20220810223313.386614-1-libo.chen@oracle.com>
 <Ywck+3E0DyNdUJRE@BLR-5CG11610CF.amd.com>
 <90041ab2-a8a1-8572-969c-143a707faed2@oracle.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90041ab2-a8a1-8572-969c-143a707faed2@oracle.com>
X-ClientProxiedBy: BMXP287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::31) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bb4836-8df7-4645-57a8-08db310b2151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rGotUQ80stOYVDe5AfRtPgEzSnotoG5s1Irj/v0KOOKidCkWEAOg2GZf4AbQLJY8ILui0dqMosqvHYk8YNVcuqKpRzbWSAHEqGRX+529NRCytMbbTbRIr+JCGOX0lb8oWUf+Yz9rEh+2fL/w5J+MQjI5AlwcFYPh8E/8UxdfySdaX7GfbhT9Ev9aqcJi7diKCEItmsBcl5knvpeVStojjIREO+L4PriwtJ+V+muNJitCnhrJXx2FH9U5WESyuWhWdCIVkyz++1MdHs2Ke/wDw3gG7guLTSmoRwXdhJMd426VvoA5jPqGUxhGN/aiHPgpTKN+U9ZsfTEMTFS8Ql5rlqe4mXnrdElv+WDuF0b4dgy2yXVlnKEQsiOHrj9gWKZ7p55WHjgRbO2DfzUrLci4CjjHfn5z/EDNCZcelA+kLBWPzIthF9tUWzdMZ4aDCMWECyKHRZuokN0aY9v/bgPVUX8iAvS0cKKC43JP1x6O+/GH91Sjbo2NE0TadHAoEfu8xj9z1pQ/fEvwspNqu/GhCOKcZRmkC1mUAYohU4UUSHNDIdQN+Sz0v8JBlgguAAANFNiclZKtLGS5RdKbJUlfXKZi8JmV3/3t5iSQ/UXQPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(4326008)(6916009)(316002)(478600001)(8676002)(66476007)(5660300002)(2906002)(66946007)(41300700001)(8936002)(6486002)(83380400001)(6506007)(6666004)(66556008)(186003)(53546011)(6512007)(26005)(38100700002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AeTSfJ9qeR2dEOXTP1V8AngatRgrzZ76xaNrRJ74l2IJZHqK6Gj9gS9WKo?=
 =?iso-8859-1?Q?jFVdhhdKdMMW3Hl1jxWEDH+Oamlnhcwq4aYN3jkmSNREH9FpFMU3JG/s4u?=
 =?iso-8859-1?Q?/6V+swUuRcuF4qnhc4AB29wH6VupQlLEpWj5xRu8dsFqUCa10PYJJBlf9B?=
 =?iso-8859-1?Q?vYH2grdj4F4la09hbIL1XZi8QzgaMXphlOxpYT+xHIUJw6rTBMV6jEh0sS?=
 =?iso-8859-1?Q?wAzFHs6eHqr6WfEdF/593bo+CjC1pWIX5a6JuWelYB8imiephLDNCi+PMI?=
 =?iso-8859-1?Q?sTlwrAYDBp1M6LETKqVHRiDzZdTFC63LcFKJE066PSYJ05ckZbsrJ0KBkc?=
 =?iso-8859-1?Q?xSWrOuBlkYcnCI3WdTMI97Wgpn6xSYMrvjKAVH37my8KOtxC5Bq+fzINj/?=
 =?iso-8859-1?Q?2MB9Xl1EybsqRzyuEEpoyF+QSrNGutuL7cWw/DM/2y9RDlvAxDSZ+crodj?=
 =?iso-8859-1?Q?l06Oxmkx57QBu1A6VEl5yF4jaNwTs5KSpG4x6jXUv7wJMXH10Uht7deTCz?=
 =?iso-8859-1?Q?eI2xlYUtLLuOVGXLF6NNzHnIC9wTqRtCPoMI/8fcp9kwxxNICun6PRKeJA?=
 =?iso-8859-1?Q?WbEB//eDXCUeOjKrC/bKu+zFYHcLpGI/lonXbbuHCxroCzXyECa3MGX+ae?=
 =?iso-8859-1?Q?CdcW0syh+P/m5kYjmy7Xin3DlGfG5OVrSMS8myPbEOey3QStWn8NSiVb5s?=
 =?iso-8859-1?Q?eRy3mSHKwFPNW9qx7h7KIQ+2Kq1YmLv38HyevVCtFjuGOnqI+UJEY9Iapg?=
 =?iso-8859-1?Q?vaO2LzuNJAJTtuKaGEIEbXwsRyRsfC22H1LqjGWQTi299gCDN3314qDnk4?=
 =?iso-8859-1?Q?3i4mOreW/Z4tjeN0J4RJffGK1L+pH0djsMtiAwCqJdV36yHfZWdpF958hP?=
 =?iso-8859-1?Q?hUg6idG8ufeQV4JUp0tNhc3Nhh85Q5jXxxonnNnE6cOqV7+I88G6I4Et/A?=
 =?iso-8859-1?Q?YToSanQagHPwshqX0qusOp+vQsV+BRx8pfBCSV+LvX6CJiygY2f75NH07L?=
 =?iso-8859-1?Q?PV3tgWAFoQlWvWo8n8qc5F1SNPYqRdk6ElK4Y25/B77+QajRLDkCe7l+S+?=
 =?iso-8859-1?Q?vEBjjFGmVIQt7oRmHyz2Bp5edmp96oOl7x5GwEWJWd3Cn4n+y4W+a6s+2z?=
 =?iso-8859-1?Q?T9PfMC2TuwLVwcMKS0a309fo92CcIcgJTaGkqz7XJz7ri6Zx/DEIwSP44t?=
 =?iso-8859-1?Q?crYyu3MSyyheSD19bi0e0dm8Lw9YJZS9gfaeKEuJ9vsYnBYDWVUmp/EbXf?=
 =?iso-8859-1?Q?rXRCu/X80nBVu2ZCTtfHYYqEL2IptIbZcdvxdAGdZlcLjryXpwx0nWv/4Q?=
 =?iso-8859-1?Q?oI9sFoyhNyEi3UsZrETQFpioR9kKofK++ickAMSIdPvqUeiEL8nVzPyAY2?=
 =?iso-8859-1?Q?HrxqqnjgRW/4TtBn4XcS4eo4sqQ6icA8z9lQK3TSbwH/NzHT/CWQpkBCQc?=
 =?iso-8859-1?Q?QIL8RxCyTjZIuQc9u9suDAVLHL4Xk5j7Ol5+CgeienWXCb3JbKOMxv9hEq?=
 =?iso-8859-1?Q?tlA4qrdaEGRMj80cyHv9vjyWxMEwIExjKWCx9YX0ODsaTyflsXVfrRyrhT?=
 =?iso-8859-1?Q?4sQuCl0Eqy/tHZzpBoMjcQC9QE70M8whu/HMZvqf1VEfPNVpB5axKt4T6T?=
 =?iso-8859-1?Q?XzDSeW6sM6LAekFTjlC1uF/A9bQi6JXEfJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bb4836-8df7-4645-57a8-08db310b2151
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 10:40:08.0301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLyrcI1mELwMGAMi99PoqIeJKRNovmGT9VgjD7CExPZH5yeKA3i2ZOPSUHAv1NSLZ+cqyyyav3kqNmu1hzZXfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Libo,

On Thu, Aug 25, 2022 at 02:13:17AM -0700, Libo Chen wrote:
>

Sorry, looks like this message got burried under the pile.

> 
> On 8/25/22 00:30, Gautham R. Shenoy wrote:
> > On Wed, Aug 10, 2022 at 03:33:13PM -0700, Libo Chen wrote:
> > > There are scenarios where non-affine wakeups are incorrectly counted as
> > > affine wakeups by schedstats.
> > > 
> > > When wake_affine_idle() returns prev_cpu which doesn't equal to
> > > nr_cpumask_bits, it will slip through the check: target == nr_cpumask_bits
> > > in wake_affine() and be counted as if target == this_cpu in schedstats.
> > > 
> > > Replace target == nr_cpumask_bits with target != this_cpu to make sure
> > > affine wakeups are accurately tallied.
> > > 
> > > Fixes: 806486c377e33 (sched/fair: Do not migrate if the prev_cpu is idle)
> > > Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> > > Signed-off-by: Libo Chen <libo.chen@oracle.com>
> > > ---
> > >   kernel/sched/fair.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index da388657d5ac..b179da4f8105 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6114,7 +6114,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
> > >   		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
> > >   	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
> > > -	if (target == nr_cpumask_bits)
> > > +	if (target != this_cpu)
> > >   		return prev_cpu;
> > 
> > This seems to be the right thing to do. However,..
> > 
> > if this_cpu and prev_cpu were in the same LLC and we pick prev_cpu,
> > technically is it still not an affine wakeup?
> > 
> I think schedstats like ttwu_move_affine/ttwu_wake_remote is defined within
> a sched domain, so if the waking CPU and the previous CPU are in the same MC
> domain, then picking the previous CPU is a remote wakeup
> within that MC. If the two candidate CPUs are from two different NUMA nodes,
> then picking the waking CPU is an affine wakeup within that NUMA domain.
> Correct me if I am wrong, this definition is consistent across
> all levels of sched domains.

Yes, the definition of ttwu_wake_remote in the lowest sched-domain
containing both the prev_cpu and this_cpu, is target_cpu != this_cpu.
This is fairly unambiguous.


From the code, the definition of an ttwu_move_affine is to capture an
_attempt_ to chose the this_cpu as the target_cpu in the lowest
sched-domain containing both prev CPU and this_cpu. It is merely an
attempt since the actual target_CPU is selected by SIS and could be
any idle CPU in the LLC of the prev/this_cpu. 

ttwu_move_affine makes sense for sched-domains higher than the LLC
domain since we move the task to the LLC of this_cpu away from the LLC
of the prev_cpu (This is possible on AMD processors which contains
multiple LLC domains within a NUMA node). Having given it some more
thought, I am not sure how to interpret this metric for the LLC domain
and lower ones, since the eventual target CPU may not even be "closer"
to this_cpu.

> 
> But I do understand that when two candidate CPUs are within an LLC,
>     a) all the fast-path wakeups should be affine wakeups if your definition
> of an affine wakeup is a wakeup to the same LLC of the waker.
>     b) select_idle_sibling() may pick a CPU in that LLC other than the two
> candidate CPUs which makes the affine/remote stats here useless even if we
> are consistent with ttwu_move_affine/ttwu_wake_remote
>        definition.

Fair enough.

> 
> I personally think it's just too much trouble to add additional code in the
> kernel to, let's say, treat all wakeups within an LLC as ttwu_move_affine.
> It's a lot easier to do that when you process schedstats data,
> whether you want to treat all wakeups in LLC domains as affine wakeups or
> ignore ttwu_move_affine/ttwu_wake_remote stats from LLC domains.


I agree.

I think that having your fix is the right thing, since currently the
move_affine data in schedstats isn't accurate when wake_affine_idle()
or wake_affine_weight() picks the prev_cpu, especially when prev_cpu
and this_cpu are in sched-domains higher than the LLC. Thus today we
overcount affine wakeups which is incorrect.

So,
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.
