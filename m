Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F16714BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjE2OKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjE2OJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:09:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F9B1B1;
        Mon, 29 May 2023 07:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAplPR4ESHDHD1Lsa0DGSNKkDaOd2Vrob5/YtsfxdiIHFTMkEXXh51YJHTnRsvd5YBsnzUjR1hhJSvIJvI2IRxKy98eK4B9nfGDjArTxpgh1eS73aFtVP15fVy7b/CRPF2CCWbWUQ3WO1/yJIM+kf3oEEE/IMmoz03JziZ+MTIWr4LsnOvYs0ITwwUIwgD/CRz1jVW0JYCeU8UrZHfLfDlk4MIhRpfnsoZayCUwHVPkZBWXDfyqTE3nqRniL1KOBIyc5mkgdVXj9FW6SnOmtJeXOpyJFiQNUu3RnB9rU5G8R9WleSqT/FHuM34+21b2LZbc18i1sSKcf9AwN9Qqutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPgn/Lt1Wz2gFEsfGN+N8N/OqClxywbpbevxBzdpz3o=;
 b=ZcadNh2gClVJAZid1Ovu04NQ/G2zzJw36rRPrk483SYGZ1KPooA5QhhI/jHFyx15/LfQe+C+nBceG/s+xlZkZWLWPR5sIDsEXPSnadiRevYYNQvBcMi1XyRwvanlQ6hyXPklJ/3Xn1XkQpR9TQ1gArfKbixYVdp6xda/TT5TdU6AC9G50iM+NtvIM5SpNBeEJia9RYKupkeqgn34NfrQRpTcFugL52PuVxNYFhxvkrHEiAyL6hL3acAXMpagVCWK62vK23CtMpsKgAaB5XQhF91AexrQoA7NhrXvEkrITqkmfb4Ewfm4lAtB/SNh96YV6XqRFPWQ/iMkCVIivXk2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPgn/Lt1Wz2gFEsfGN+N8N/OqClxywbpbevxBzdpz3o=;
 b=Aru7ndmQ0cfgnY0LndUiAbBhvW+WnKLPrRBHoXNHMygOLaEBTfkcdloMyqy1LCYVG+gsyoo9Do6lkmDTJYXYWFdmYbfmofY4vhOJgaUH53lJw04y6/Bp5d2JeFtpeSLLRR+ixg5T5qlD800GJkCNQ9j/azJHxJiducnGM67y53U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 14:08:59 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218%4]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 14:08:59 +0000
Date:   Mon, 29 May 2023 19:38:43 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ray.huang@amd.com, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gautham.shenoy@amd.com
Subject: Re: [PATCH v4 3/3] cpufreq: Return failure if fast_switch is not set
 and fast_switch_possible is set
Message-ID: <ZHSx61V6fgMcXsvh@BLR-5CG13462PL.amd.com>
References: <20230517162817.8538-1-wyes.karny@amd.com>
 <20230517162817.8538-4-wyes.karny@amd.com>
 <CAJZ5v0gte_QAt1MXXXhpGUTEAC3Eo8LCY6N+=uSFi0NRBG-Omw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gte_QAt1MXXXhpGUTEAC3Eo8LCY6N+=uSFi0NRBG-Omw@mail.gmail.com>
X-ClientProxiedBy: PN2PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::33) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: c762d962-7999-4926-c4a4-08db604e3f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YnDFJI1AO+pj0ZM5YeWuL+FIrjnXF2K/87cgWVXjYbUXt1VYFtDSTC+lSsyV3lrVEnl2dp9SRdMxatY3CUvf6WGJBvA3dJPQb0h2a3VkYYZ51zqaNnm0bnCdOHfAVUnYQhxCC+PHC3JjZzAu7aZ+rkenDgU3Cc/bzlYf43HeUPV5MjOc75bAsfcUda0/9tzBCnk6obeTPyVg+R9Bh5MKlUDRBIrb3ax/SjjoOxKHerbKAevJstPEuO8jPCqrgat+yEubo+Fh9f9RAKUJwjHEug0H0GDuQKFY0NLaS4lqQsO5Jra8p0vgMfv0kae49Sfl+6OogoZ/9UFZ5DExRE+dpgxMRFgrs17X2UzwIXfRosJ8sZt3/GreLXSFlpgm1jH6YRSPAo5zzBFZtk/I61hdOXvQyYpoi5kqzITmofsOIGMwhYAf2FqoF8hCAzLYo4O5QYx56itMJIL6bzGyR0SQI0hv1RoYoHuWWcMCpGT0SOU+QO6uZHiyAgMOkIXknbz+ehv69c8p9Qj+O8ipVvIHl4ml2BtL+XK5W0xaxoH1Vr8NXi05Pv46MgwNPz7taGYY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(83380400001)(5660300002)(316002)(6666004)(66946007)(66476007)(66556008)(6916009)(4326008)(8676002)(8936002)(41300700001)(38100700002)(6486002)(86362001)(53546011)(2906002)(6512007)(6506007)(186003)(44832011)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWtNd2hqUklSa041aGM1YkdKQ3NFU0ovTEgwTkpCMU9sakFwbmZlMXBLR25V?=
 =?utf-8?B?blRFREFzczZ1Qm1wUFBQYVc2SCsrRm1DdDA1aUxuSzRiaGNmT21zdkVMYlFG?=
 =?utf-8?B?cDR3OHJ6eCtFSFcwRUc1dENxZXBSdjZyTFh0YVlEbDRwL09xZW5HQXduWDlP?=
 =?utf-8?B?NlpDcTZKZWd1ajVCYXUyZFJsU3dseDQ2bm43NFE5UUhCV1grdVloZk5zenUz?=
 =?utf-8?B?RDkxa2lsQXFGWS9mR0svTEdLUFUrc2VzVzVwbHRwTStwVG92SUN4eHFRR3FK?=
 =?utf-8?B?WHA0b3RyMHR5SGovZkk5YW1XSnoraDBuemoxckxhL242cDlRRlJxcEk0TS9V?=
 =?utf-8?B?QnMvOEllN0c4OFFNRjdaaEJyVmZmajNISVhOckF5a0preW1Sei9KQUMxdEEr?=
 =?utf-8?B?V0pFYkFBRmVEKzZ0K3VWWnErRENQNW5Fa3ovTHV6cERPdTErTEk4ZC9WSWdk?=
 =?utf-8?B?R0V2enQ5dEdXcUtOVGhqKzVTVWNZc1pwbE8wa3Z5aUlJNWtXVmprWXFUUGdK?=
 =?utf-8?B?ZlBmWmtiQzh0bEd3KzJwWXVvYzFoWDlvZit5Q3hzeHRnK2wvUkJSRlNUcUl1?=
 =?utf-8?B?aDBqVk9tVjlsZ0ZKd0xHOUNFWXkvditoekNLeEtKdmdnOEtPcjMrN0tXY0U1?=
 =?utf-8?B?bzVIOStGcXFQNFVJVEpTZHhsVVdxV1RMVmpMZ1ZhVjlkN284dVZuTWJiOGN5?=
 =?utf-8?B?TkxDcTFZMzlzcFNUNGhQeDYvaDUvcWlzaEU1N0ZYZVNJS1VWaUJpTlpsQnIr?=
 =?utf-8?B?L2Q0LzRqejZUSVdxNHhDa2JSZzA4YzFwT1lXZUhGMnNaQ1lsZ2JHRG9Lbm9u?=
 =?utf-8?B?UHJhOFJlSUt1UmNZbDBDaFlkaUk4YS95NGNQSktucWFsL0lNdzdnckRqenNx?=
 =?utf-8?B?RmlxQXl6U2lRc2gwRkh5ZjBSNmhQU0svay85bGZXdXl5ei9jYlF0ekhyUm4v?=
 =?utf-8?B?cnhlTkZuYUtWV3krZVRhYjdqQ2hIUUV6Z0d3STRsdUErckIvaitRNU5WaHEz?=
 =?utf-8?B?YTNGMkJHVFBWNnVCa21wSkxqM3c2V0xFVnlWaGRrSnZ5d0VWK2dFR0Nob01s?=
 =?utf-8?B?Q1BVZmxmZVI2bytaM042ZjZPQ2hvMS9vZVFmRXZnM1VrSiswT1E3cFpTM3ZR?=
 =?utf-8?B?d0twRU9iUVJhaTdpeEI3QzQ2RzN5YmZIZ1NoSmZ5Y0hwYXZNaDJ4MmI1T3Bq?=
 =?utf-8?B?UUFVQmxTYVpKZURWVDRJdUZmOFZpbjVPVDJlN1oxWmIrU20zL0o0b2lJb3M0?=
 =?utf-8?B?MW4rMVo3SldsZHhCMnVxdjdQWjlORmI1Znh6N21kNWNRVGkrMkpuWmhSVEZW?=
 =?utf-8?B?THFwZzliME4xRGVWUGovendnT1I1MFBQQXllM1lSVTd5YjZublEvK2FTWXJS?=
 =?utf-8?B?bDd0VjUyS3lDaFhGaG05dmlEMENNVGNsbTZNY210cmpzSTlITTBqSTl5alZz?=
 =?utf-8?B?dzYrZ1FadVpuM0VHUExDeE5WOFU5cHNGdG5kSUpRTmk2VlBabG5rbGlUc0tC?=
 =?utf-8?B?SFVjZGYwZW1KTkxJRnI4dEZWWXkwSHBBVVJkNFo4K3hmVmpTb2ZLbCs1ZGpx?=
 =?utf-8?B?czNMZDB6MG56SlVTOFVpeGxrVm5wbVptTkpKaEUvVHdGSCt6M3JyR3lMUWdI?=
 =?utf-8?B?VE4vYldnZnZwaW44NGVBUU9WbHVjMElTbGFxNVJiVXBKZ2YrN2tmVld2SEtv?=
 =?utf-8?B?bWRCZFZUajRTNXppL1lJeGFJN2Jvak5Ec1lmNjZyYkE1WFRBQ3l6UDFSZmpQ?=
 =?utf-8?B?NG5xT1g4TkNoOTN0VW5TWEhpcGIxdzc4Nkdzd1JvTHdlcDh3TEYxWjlSY2Jh?=
 =?utf-8?B?ZU96OGY2c0pYTG5aMGdWTitCRHpiVmRXYkh5SWZhdEhMK2lDMkZDaDlodG5Q?=
 =?utf-8?B?ZENnS09Ob3Q0UytISDczQ2JQWFZnUmVIWVpUbzBxSDZhRlJ6SU1vNTBZQzBo?=
 =?utf-8?B?b1hCNTRrNVNTVUFPUC85TjFteUlUMUNCUlpydURVN1FVYW83MFBMSlVESVU1?=
 =?utf-8?B?UUliZCtCdFhrSUhUUGJKMXpsTUhDRGovbysvTGhpbXNremZzTmcvbXBaamhY?=
 =?utf-8?B?M0Y1SzFvV2tzeXJMZ3pwcVc5b3VTZmNsN0VQU29GbXlURk1Ob0JaNWptZC9i?=
 =?utf-8?Q?8Jq/unPsatuNpXnQgzEYOyoo8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c762d962-7999-4926-c4a4-08db604e3f53
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 14:08:59.2633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCdehQQcAnRJzQpRKRAub33/T5iO/4exzfd6k1aohZjNIO+lBhrN3TZCPqp1qLrYMReaUDETxAP7y5qXDwGqxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 24 May 19:44, Rafael J. Wysocki wrote:
> On Wed, May 17, 2023 at 6:30 PM Wyes Karny <wyes.karny@amd.com> wrote:
> >
> > If fast_switch_possible flag is set by the scaling driver, the governor
> > is free to select fast_switch function even if adjust_perf is set.  Some
> > scaling drivers which use adjust_perf don't set fast_switch thinking
> > that the governor would never fall back to fast_switch. But the governor
> > can fall back to fast_switch even in runtime if frequency invariance is
> > disabled due to some reason. This could crash the kernel if the driver
> > didn't set the fast_switch function pointer.
> >
> > Therefore, return failure in cpufreq_online function if fast_switch is
> > not set and fast_switch_possible is set.
> >
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 5 +++++
> >  include/linux/cpufreq.h   | 4 +++-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 6b52ebe5a890..7835ba4fa34c 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1376,6 +1376,11 @@ static int cpufreq_online(unsigned int cpu)
> >                         goto out_free_policy;
> >                 }
> >
> > +               if (policy->fast_switch_possible && !cpufreq_driver->fast_switch) {
> > +                       pr_err("fast_switch_possible is enabled but fast_switch callback is not set\n");
> > +                       ret = -EINVAL;
> > +                       goto out_destroy_policy;
> > +               }
> 
> The driver registration can fail if the driver has ->adjust_perf
> without ->fast_switch.  Then the check above would not be necessary
> any more.

Sure. Will do that.

> 
> >                 /*
> >                  * The initialization has succeeded and the policy is online.
> >                  * If there is a problem with its frequency table, take it
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 26e2eb399484..8cdf77bb3bc1 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -340,7 +340,9 @@ struct cpufreq_driver {
> >         /*
> >          * ->fast_switch() replacement for drivers that use an internal
> >          * representation of performance levels and can pass hints other than
> > -        * the target performance level to the hardware.
> > +        * the target performance level to the hardware. If driver is setting this,
> > +        * then it needs to set fast_switch also. Because in certain scenario scale
> > +        * invariance could be disabled and governor can switch back to fast_switch.
> 
> I would say something like "This can only be set if ->fast_switch is
> set too, because in those cases (under specific conditions) scale
> invariance can be disabled, which causes the schedutil governor to
> fall back to the latter."

Sure. Will update and send the updated patch in-reply-to this.

Thanks & Regards,
Wyes

> 
> >          */
> >         void            (*adjust_perf)(unsigned int cpu,
> >                                        unsigned long min_perf,
> > --
> > 2.34.1
> >
