Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2667C714521
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjE2G6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2G57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:57:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8951A3;
        Sun, 28 May 2023 23:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1ANA9ZCFzpnZEkvgPhik7XBojQ2sHub/EjXvyAxZ2ouYOr2s2V+r5Cj60QVtzlGcfTB9YSxvE50LTzXDhXrP7wUgwXvHr1KOJAz/VIaCQIqyR7oaneX4GvVasmgUB5HxlP+TQNhdEcPf+cR2nbq5QoVZFKrGOP8Vet/NUj6kwccxCzr17nlllamYBuk4Ft6jOw96kjr9I77Uv0FeIIDpVysyallh52IeQJdL48mCGPvvMl720nEZek3E7ZZXlK+vmsIEUuOor6DesA6DyF2Yu9FQEAFYLTnKI+4lJ+arZn2+TZxMynz/mpZjcbNDGu1PkFtUElpb11NCgX3QT7g3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSV20EvtYhzIWE9mDr57eH8iKQea7t0Oeo+lAPxo/1k=;
 b=dDPlfaceg48p457scRLPDC+ltn/Axh+APHer6fwz3abSYT2pkiBID2SK5c1pKjROcw1trD0TzaiIsMBFv6tQvIGU9nf5W2dW6Ibt8mebQwLLX8iwJIi4luSm5PCQtkWaFPVEg5iLm8nbKrlwlDm8wuh+lVe97mVtN3xQaDCev2fI9PighaokxjWUU1ScknMPbHyxWQaaz6Tz1eTEuwq0yH/qysFAskw9LkUAOMSGY/mUZDTaUb6g2/cVQg+GIblqAaxWBJ+8j4wsYusO7JeBV5fImls8ydKEClKW/nvWKG7KU2BExNBd6nijFeqJlrLhOSFEK2jkEClXFmKEdnue0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSV20EvtYhzIWE9mDr57eH8iKQea7t0Oeo+lAPxo/1k=;
 b=ArKAOInOvl7/1eytt4uQwxj55pYYU5MfYzMCV8fR8+iUCySgk+VjlzatztD4Pmn4ROw/bZ5DMIbiUgQC/jxPkoaeIN+UPx1G/ErINcPQtb6iqsWotCuMKMQruOS2SZMa/8tZjcS/ascR/wQUZMIT6qqft872uquDi59vY2VGo2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 06:57:54 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218%4]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 06:57:54 +0000
Date:   Mon, 29 May 2023 12:27:35 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ray.huang@amd.com, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gautham.shenoy@amd.com
Subject: Re: [PATCH v4 1/3] amd_pstate: Add ->fast_switch() callback
Message-ID: <ZHRM3x1/Cle1iR2o@BLR-5CG13462PL.amd.com>
References: <20230517162817.8538-1-wyes.karny@amd.com>
 <20230517162817.8538-2-wyes.karny@amd.com>
 <CAJZ5v0h+frxNpTz4GsjQ=OdbXXnTgLB=ufA5P2pNjbDF_FhNUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h+frxNpTz4GsjQ=OdbXXnTgLB=ufA5P2pNjbDF_FhNUQ@mail.gmail.com>
X-ClientProxiedBy: MA0PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::17) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f38a33-87f3-493e-3c49-08db60120654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuYnrJnuUfSr33yLGOwMNMASsuWPy1vDsX0GLcBTY3iu/JFIicJqUuR+gAvL149JCkL978nj7812fwh4X0/nKU3iPUPFlBMbp3pPaJWjSag6tqs94yu01ppHL0kLnIuS+EkVIRwsgTrZqS3fcna6+JSF6SueAmlpNdWZBZRnb1KpZ0eQ8LL86ZCWl8/syKeFyxW3W0IgQIK1j4d2bYDw98Ouo4iPsU/LeYA0Vj1dreeyxojhzSgtPPkme2twsp3QOeQ3JAj4F+X8bjoH/JFaJfhcxqr3+wLq5yr5Zn++IpktNA9g/C0afodnu5/SoeCdrP6UU6aopFmFZ3XFoWdsJr5dW/3jfERH5/dm36V0/KNiyWpucsabx7au4xZkNR0/cGdpNZoBFFx5+5VR+Aug4++37mnjbQlhlP6kUCa2lmBaOnEENStNT2XJGe5xoa+2w+GMa+n6UwJOYyNGbz+Z2mAF1SknrDMwRHWF61cofqRSKhjEBA/vMncgGw81QRUvAT1T6hEBpXaJ0i1OlilxnKj2lVcEJHOHaNN7hksTjydsvfaUn7P3ymUP0v3/SXRN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199021)(6506007)(6512007)(186003)(44832011)(2906002)(53546011)(478600001)(26005)(83380400001)(86362001)(6486002)(8676002)(41300700001)(38100700002)(8936002)(5660300002)(66946007)(66476007)(66556008)(6666004)(316002)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2FpeU56bi9ZblcySEkrMVQ4UFp4Qll5TUJUYVIzUHNQOTFUZFphMDY0dU11?=
 =?utf-8?B?bWVYRnNFRlNtdWx4TnF5THUydGpLWU9WSUtjR1NDaFJpUVhLOUxNTVZrT2Nm?=
 =?utf-8?B?RXArZmFtS1NtaXUrQnlibmRacU9icm5SZUJrUklvcXN1Y3N1ejVSd1dldUlN?=
 =?utf-8?B?ZXZFVlc1L3NsRHd5RE5TM0FDNFNaWGJIZFg1K1Y5R0l1QzBYdHM4d2tQSC8w?=
 =?utf-8?B?QWc5TFBYWTV3TTNGYW4wQTJXRG1yTjBmYkRrZWx6ZWxIMWJONHo4YTVnaWpy?=
 =?utf-8?B?d2FvNmRkMEoyMGlNYktFRzdXN1FuRDFLRGd4MnhHdk43UTZMWEtPRXAwRTFU?=
 =?utf-8?B?R3lLVWprUmRDbHdnN3I5b0VoeVdFd0laTHdMblY5Q04vR0Q1WmRYQnpPN3Fw?=
 =?utf-8?B?UEhCK1Y4R25JK2xaSEJYOGhQNXl5VTkxK3VNVDJwN2sxVDQwZS9CdGM5STF5?=
 =?utf-8?B?bjgxM3J3eHZ6Z05mVU1GaGpKOXNCOWRFMGV3ajk1bHR3TDg4SHovR3J2R2tr?=
 =?utf-8?B?RWJETlVzOVFsZjRIdnNNcnVWT2tYYVNIQTFsOEhOaDVJaXIvZ1VDQXk1a0pD?=
 =?utf-8?B?Yks2S1RQeDNidHQ3bm1aalQ4WXNaZitsbmNGQ2I0d1UwRWFZemRUUDBUK0w2?=
 =?utf-8?B?NXFyNk5jampEQmpyajhiVlNFNmNJTkpncExOdUQyMHlOMHZpRFNOd2VEMDNk?=
 =?utf-8?B?SitwSkdvMXNaMGFJeksrNndYcnFvRGhaN2UwenFaYURGUDN1eEpVeFFJcEo0?=
 =?utf-8?B?UWtTNjBxb1dkZkxsbU1nZ0tWVC9MY3QyL2VYa2JIU1JhWXQwenMvWVBYTk1G?=
 =?utf-8?B?aWlFUy9pZSt5VnFkc2FDT0tjSkdvallDWXRjNFg2QmdBS0JyWmkxRHN1MFhz?=
 =?utf-8?B?cm9HS3kvQVZUckdVbWJlZm9VSkR1Qkk0MmZiRFFZMTBPay8vajJqV3U4ZGlB?=
 =?utf-8?B?NmdDeFVBNHBrOWZidjNZTXNpcWZKZ09mUU5COU5oZCtYWXU1SXBuZnJXdUVD?=
 =?utf-8?B?MlhTZTVRandla2VNc2dXMllia1ZmelNWb1dhZm53Z21CYnVNdDFaSkVGZHBw?=
 =?utf-8?B?aXhrZXpZcFYyNHlJQmhEakFzY3NXdzNDVjA4b2NvV0V5dDZaclNjcXFUcjRv?=
 =?utf-8?B?eFNtQ2NxTnE2SnlZV0FxczdUbTNBWllvQ2pYdk9xaHYrRklsaWlZSzZSV2Mw?=
 =?utf-8?B?NVM2U1dPUjd5dkFWaXNFK2JHRFVXbFBuMFNyUW1MOHFrRjk5N0lPZTZnQUZF?=
 =?utf-8?B?aXhBeU5rbmRJRHlmOVQ4RVZOVVh4d0JMUHBZbmgxbDhMejk3aHYvQVUxV2tE?=
 =?utf-8?B?V29LdThRQWx6cHpBVEx5OUhxSC9kZHFyRzREeFgwWGw4Y2o3bE80WSs3bjNG?=
 =?utf-8?B?MWt3QVluUG1RanNWK2tMaEkwaDZZRlFpeU1pOXAxTVRiWktRNll4R1VrL1RM?=
 =?utf-8?B?NkVEM2oyb2h0QlhIVWdZY0JEWng4Z3VLTUhwT1JZQ0MwTzVEOXkzbnRsditm?=
 =?utf-8?B?enVqL21pL3F1dmJ1TWRhNkVRLzFYQnFSVlBRdHZDc0lHUDY3bHdFRDE0Y3Jm?=
 =?utf-8?B?ajQ1TlloOVF3Q1ZEVGRaNGFVMTBySVhDWDl6ZmVrUHp0OTBOTkpjOG5OczZU?=
 =?utf-8?B?MU9tRXlZSW5rakFGckZTdWxHMEJESHA0Vm1wb1Y5ZDJYalY3Nm1SM0lkemxw?=
 =?utf-8?B?bGlNQUJialZXYjlBNCtiU096MGh3YW5OeEJ1Q2gvZERyejJoam81NDUrKy83?=
 =?utf-8?B?M29majBRZVEzcFdOWTU2S3VtYVhRY1NLYm5CZlJnb3dqclFjWm1wdEhxTUIx?=
 =?utf-8?B?aWhUZ0xZUSs4V01mZHRtU3NTU21URWkrcytldWgvcXZUZy84d3pUU05peXBQ?=
 =?utf-8?B?aGZub3pLRHF2ZUZKQ3VHSTlNUEhQV05xa0V3anRjZkpTanRiMTF1LzhRcDBw?=
 =?utf-8?B?RmM1aUZLaUdwb1hXMitkaW15UkIxWXlXSm5pRm1YbG9MTm9sUU9pRDJCMEFB?=
 =?utf-8?B?dW15VmVRZ1RMTU5OL3o2NXNzY0xmRDl1cGtFcXRYSkFMZno5bEVZaTBVdkJs?=
 =?utf-8?B?MDBCS0V5cGVXU1VtSXBhRFdhOWdES0V1UHJ0dlN5NjdOcVI3RGxTVFRKcGE0?=
 =?utf-8?Q?+Z4cBXplXWrOfp+8JnveP+RSN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f38a33-87f3-493e-3c49-08db60120654
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 06:57:53.7151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wbni1X62H+DWJ0mBQtkvXQ4+PssfGHXWDUr7MM2WQppp1vDXQwjzCfnZgqgrUHSTNtXqaVhovgG6vF51454u2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 24 May 19:47, Rafael J. Wysocki wrote:
> On Wed, May 17, 2023 at 6:29 PM Wyes Karny <wyes.karny@amd.com> wrote:
> >
> > From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
> >
> > Schedutil normally calls the adjust_perf callback for drivers with
> > adjust_perf callback available and fast_switch_possible flag set.
> > However, when frequency invariance is disabled and schedutil tries to
> > invoke fast_switch. So, there is a chance of kernel crash if this
> > function pointer is not set. To protect against this scenario add
> > fast_switch callback to amd_pstate driver.
> >
> > Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
> >
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 36 ++++++++++++++++++++++++++++++------
> >  1 file changed, 30 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 5a3d4aa0f45a..45711fc0a856 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -444,9 +444,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
> >         return 0;
> >  }
> >
> > -static int amd_pstate_target(struct cpufreq_policy *policy,
> > -                            unsigned int target_freq,
> > -                            unsigned int relation)
> > +static int amd_pstate_update_freq(struct cpufreq_policy *policy,
> > +                                 unsigned int target_freq, bool fast_switch)
> >  {
> >         struct cpufreq_freqs freqs;
> >         struct amd_cpudata *cpudata = policy->driver_data;
> > @@ -465,14 +464,37 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
> >         des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
> >                                      cpudata->max_freq);
> >
> > -       cpufreq_freq_transition_begin(policy, &freqs);
> > +       WARN_ON(fast_switch && !policy->fast_switch_enabled);
> > +       /*
> > +        * If fast_switch is desired, then there aren't any registered
> > +        * transition notifiers. See comment for
> > +        * cpufreq_enable_fast_switch().
> > +        */
> > +       if (!fast_switch)
> > +               cpufreq_freq_transition_begin(policy, &freqs);
> > +
> >         amd_pstate_update(cpudata, min_perf, des_perf,
> > -                         max_perf, false, policy->governor->flags);
> > -       cpufreq_freq_transition_end(policy, &freqs, false);
> > +                       max_perf, fast_switch, policy->governor->flags);
> > +
> > +       if (!fast_switch)
> > +               cpufreq_freq_transition_end(policy, &freqs, false);
> >
> >         return 0;
> >  }
> >
> > +static int amd_pstate_target(struct cpufreq_policy *policy,
> > +                            unsigned int target_freq,
> > +                            unsigned int relation)
> > +{
> > +       return amd_pstate_update_freq(policy, target_freq, false);
> > +}
> > +
> > +static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
> > +                                 unsigned int target_freq)
> > +{
> > +       return amd_pstate_update_freq(policy, target_freq, true);
> > +}
> > +
> >  static void amd_pstate_adjust_perf(unsigned int cpu,
> >                                    unsigned long _min_perf,
> >                                    unsigned long target_perf,
> > @@ -715,6 +737,7 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
> >
> >         freq_qos_remove_request(&cpudata->req[1]);
> >         freq_qos_remove_request(&cpudata->req[0]);
> > +       policy->fast_switch_possible = false;
> >         kfree(cpudata);
> >
> >         return 0;
> > @@ -1309,6 +1332,7 @@ static struct cpufreq_driver amd_pstate_driver = {
> >         .flags          = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
> >         .verify         = amd_pstate_verify,
> >         .target         = amd_pstate_target,
> > +       .fast_switch    = amd_pstate_fast_switch,
> >         .init           = amd_pstate_cpu_init,
> >         .exit           = amd_pstate_cpu_exit,
> >         .suspend        = amd_pstate_cpu_suspend,
> > --
> 
> Applied along with the [2/3], thanks!
> 
> Do you need them in 6.4 or would 6.5 be sufficient?  Also do you need
> them to go into "stable"?

Sorry for late reply.
Thanks for picking this for 6.4 and stable.
I see the patch is not applying to the 6.3-stable tree.
I'll check that.

Thanks & Regards,
Wyes

