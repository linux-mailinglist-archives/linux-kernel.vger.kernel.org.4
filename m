Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF94A7362C7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 06:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjFTEt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 00:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFTEto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:49:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B599C10FE;
        Mon, 19 Jun 2023 21:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTQtmWtEvBPMXsNPm1EZxKElMk5rQbM2TDEA0vVo3606mq3pxsjq24IXzpXi7j1M9015H8F4AWkgWpJynScNO0NYOIBA7NF97yOpuQFLFKFxFEnbd93wwMlPC9VWZYg1E6PPAM8Ev1yt5ANaTpcR2xkeTi2LVxwyujiTkbxuNOgnOE481lDzhlYLkwgPTeMnnXMsFlZxl4Xt+WXnC+gWq9wl6O1kCjTy46+vivOZPb8dKCuz/WURn4ZsZE5FKk2o0gMhEy1axeczfSsXzYGwuG6GP9KPfJ9x8tA+knx2n+hT9w9i9qHU6NGdEm6KxfAkMWj0U80BK7i+4FQI6xAKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBeLYJLYXWa3bAW4Up/bnpNa1QMy8qk4Uc4XM2NLmpc=;
 b=IP/rrYXkGq21hZ1NhXRVkvFt0ePW+N+wX6F36gyMVv1QNttYPWOKeelRJiN38lT0RyPEJQfD0dKxgpSydoVOQIUkUq7XBFpU5oJrXPTckryyPAkWZgAO7QGWjb88yy1a4lF2a3opPmbRo5EwqBX0eNz95waB9+ib8dN4OfqjYl0qGCLwff2nFOwJynmtGx9QBLJEfX7w/M5lvXd/us3Xw/eYgLFz9ErYVMwnQPVPWM1DBnOm6NpuQfcfwg5dAkXjvAHnyT7uD81bV0b9WjyeqzqfG7rQA2BrIq23ACpd5IPwXp1NgwMICvDZP+7Hg42xB8wHXjvkDxBC9MNt2q9jhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBeLYJLYXWa3bAW4Up/bnpNa1QMy8qk4Uc4XM2NLmpc=;
 b=Mifr6uju1XMaQ/UeRJIMvzGQMmjBPVRJqu43lt2H6dR4mMXZMh+eqaQBCoW19MSynsuWxVkTOpEZu2bdTcGd/+GbF9S2lMZBAhvaJVTl23KpKKp/Li6tnolw861Qmtp+deCOuusxm35gj8a50S4J1rClXWdk7CaYt31zYEZQmA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 04:49:39 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 04:49:39 +0000
Date:   Tue, 20 Jun 2023 10:19:23 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [PATCH v3 5/5] cpupower: Add turbo-boost support in cpupower
Message-ID: <ZJEv05RNDS07x7VI@BLR-5CG13462PL.amd.com>
References: <20230619190503.4061-1-wyes.karny@amd.com>
 <20230619190503.4061-6-wyes.karny@amd.com>
 <CYYPR12MB865590E3567FC552308B75549C5CA@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CYYPR12MB865590E3567FC552308B75549C5CA@CYYPR12MB8655.namprd12.prod.outlook.com>
X-ClientProxiedBy: MA0PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::19) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|BL1PR12MB5286:EE_
X-MS-Office365-Filtering-Correlation-Id: 513c32ae-b7b5-4658-7d05-08db7149c115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8ZI2Y94pYRqsemILZwKqTnB8IZDPS7kXD69EJaKmJ2PSATykfN56LkbfwJVYgbNlFJXSk7h1nX44Rv8MhO0mRHIJHgghRmT8ghv9QwzBcqUk5YqcxKRILjTKpqtTt3+aX4viBrqpl6bJ6dt//WPWhGD9aFvTRaXHnH3TAevxvYUsBuVT8l7TaS93UfH9ufOhItDQvimwnd29h2q5og6w+w1g1DMBELzZxKYbbUAVtxrZcUlmTvE9FFEs0IV62tEIOxnLItTtk+fe1nSkojLpgXP7wIWY/LFMscYZtgjatOB2DNq2EU9wOEkU+ZtAKO6p1tTHiNj9c/QGbHuLAc/VoyO2ZisiNkeU4t5Cr/tMEI0rkqmIthtBD3b+zMoK+kgi+4Ej4gVr62gOyszlSIu4KvWAro9GviecM8JAJw5ofBhbWn6GVp8uoighgUHiFWsG6KyjcHvgEmfoARqOF3P4cBjWpfatjjOPvX92BRtZ08XehMxwX46jyCzPmQuJMOxsyOtdcMjYXqnOZX8EenIY8jVd7ddLH8BSk9du9xDcAEksWFVEzEP33G+K69pM2H6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(6512007)(53546011)(186003)(6506007)(26005)(6486002)(6666004)(478600001)(83380400001)(54906003)(66476007)(4326008)(6636002)(66556008)(66946007)(38100700002)(316002)(41300700001)(44832011)(8676002)(8936002)(6862004)(5660300002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JxJ2jJXaMUwOpx9ka2BHIfSI1gj5qbbprmPi3KjvYRJUiwHtdiZ3WAuxybVc?=
 =?us-ascii?Q?T3M/K/z6dzqBApoy0caNjWLYPwm1rX0CVdvSPJcqY4V+AmrW0MdAH5p6RLbr?=
 =?us-ascii?Q?RLjNZde16OWcDbPaLTcGtljfRnXlUTPpvUqWevFNsI2Ym3+z7C4DgQjHmf1e?=
 =?us-ascii?Q?0rmZc84LIShX8iCVWRvnw/QpLQ49hWYIyuCb5+kxRvYQNDvI8IC4HbafSQKv?=
 =?us-ascii?Q?0c5J9dL1nctCooYsG0PubPV1BoqkDF9f76+lkVKB67nPQjBhiioJgm0skKOy?=
 =?us-ascii?Q?qE+RzCcrDF21wceXFWmoXvTNRjCiIhNjJujGfigfmdZveYnB10FjWqVWlknp?=
 =?us-ascii?Q?AmFwdoT3FjkbwuOMAniHT3JaxXvlN4K5METdReWyFTGFce1fLapBNC8yux04?=
 =?us-ascii?Q?iaH8pRvzqbMtl2cG5HN2ccpksonEcfE0jZt3BtFgJ1wQ3V8CSBNhikVah1yH?=
 =?us-ascii?Q?Ywx/6N0LFLow5HosChy4iLpVaBZmLhwkZQYrYARTQZnbIVd/hc9k2hMns7Kf?=
 =?us-ascii?Q?h1r53/YrT1ydNeTLPjEyu6prjfRdBCiiMsedOleReUITPRakLyzim+9tWDwx?=
 =?us-ascii?Q?XYUSuMSidq4FATDPe+XrnCST7RtS+SAXxejfePHPTW8Yn2nOc9y36xMkzoIM?=
 =?us-ascii?Q?f6V2eSABIcl8wCXKycjkOdJrvHnZ85/FrYt8I7cpR2KZPKYiuqKkTvAP/vOE?=
 =?us-ascii?Q?ABXrkW9VhOT2B+1nWDGJnrmVJiokN7epp+YokcsWaeJTSguETEw5DMhQgFfa?=
 =?us-ascii?Q?ohA3Lp/f9irT0usGzFYF4WN/gGtFB2rUP2TKN+rG5dQuPKQPrLvmgK46SS8D?=
 =?us-ascii?Q?x0Z/Wa2Mr2Pj/VqE+6ycefVQl2DxAz4lltMwfoXDUcN6xIfI3coOMCBaV2v5?=
 =?us-ascii?Q?EaqovmzThUQ0YrydIX8hEFm64mJbXZ+r79EW4+pT7gL4irAQpYCCW7+JC/6i?=
 =?us-ascii?Q?1EflLBIoJaHHkRukHtxvKONlq6+LW6VfxbEwXNpeLR0440MFS7DWxi9UUlLy?=
 =?us-ascii?Q?cn+hYVXKOX2fD/iit4sxeLK6R4V70s9PdPIwr22sBy/lJAbMm8PWxXQb2+vC?=
 =?us-ascii?Q?UZVRGb40uZ/2ytiTsrvyk2bSnXccsWtfVgWh7efFehTYpkLynB6UAoE93TO3?=
 =?us-ascii?Q?jB/49AlkOAc17nw2fFolxYCHmC2S2uey2KUwlVZ3nVkb/iteJgKs1ox/XXTK?=
 =?us-ascii?Q?+8KslXQsbufisTTK9R7BiUbsRUsEr6vlQu2cZwwm2J8PqD+bWUoIqPPdfR4o?=
 =?us-ascii?Q?TxOLfQrPVMggC3x/dMFmLRcQ3t5Fl5qQpDmvZmvwfYSfNPB2cftQyQ4JgapW?=
 =?us-ascii?Q?mkI9sEx6uF/FZ83cdLxAdGRgjdef9/ZIflMS6KvvuT0HNv6jlCiBCgt4GKod?=
 =?us-ascii?Q?sUWnFVD087vI+OdHAEqGaVKPgcJbgC7qAb2PRJ6+c1cJTJ8Cr0yiIiUVPCIE?=
 =?us-ascii?Q?9eHk7+i9r1SmtdNM4ZFKU7a8Q9BQkLxzJKMvUVW5knnUECrxa4ulUInXSmnQ?=
 =?us-ascii?Q?9hx7WB30lrRaKsXXfy+CxGI3TeicSJTywfCbp3n68Tnx1bL4sj0oGcOd13ln?=
 =?us-ascii?Q?iVvdPrG16pHDFCKndwZKrpISunaHyXBgr8vrmVP4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513c32ae-b7b5-4658-7d05-08db7149c115
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 04:49:39.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4+Rnoupysc/qQK64MMg8N8ubwVbeIU7W1Gp6Aw6mX7VdSJ8QYrvjfElYUKAEoHzzLVCICAthG/tGG9aWg07mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jun 08:37, Yuan, Perry wrote:
> [AMD Official Use Only - General]
> 
>  Hi Wyes.
> 
> > -----Original Message-----
> > From: Karny, Wyes <Wyes.Karny@amd.com>
> > Sent: Tuesday, June 20, 2023 3:05 AM
> > To: trenn@suse.com; shuah@kernel.org
> > Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; rafael@kernel.org;
> > Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Yuan,
> > Perry <Perry.Yuan@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>; Huang,
> > Ray <Ray.Huang@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>
> > Subject: [PATCH v3 5/5] cpupower: Add turbo-boost support in cpupower
> >
> > If boost sysfs (/sys/devices/system/cpu/cpufreq/boost) file is present turbo-
> > boost is feature is supported in the hardware. By default this feature should be
> > enabled. But to disable/enable it write to the sysfs file. Use the same to control
> > this feature via cpupower.
> >
> > To enable:
> > cpupower set --turbo-boost 1
> >
> > To disable:
> > cpupower set --turbo-boost 0
> >
> > Acked-by: Huang Rui <ray.huang@amd.com>
> > Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > ---
> >  tools/power/cpupower/utils/cpupower-set.c    | 22 +++++++++++++++++++-
> >  tools/power/cpupower/utils/helpers/helpers.h |  3 +++
> >  tools/power/cpupower/utils/helpers/misc.c    | 18 ++++++++++++++++
> >  3 files changed, 42 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/power/cpupower/utils/cpupower-set.c
> > b/tools/power/cpupower/utils/cpupower-set.c
> > index c2ba69b7ea54..0677b58374ab 100644
> > --- a/tools/power/cpupower/utils/cpupower-set.c
> > +++ b/tools/power/cpupower/utils/cpupower-set.c
> > @@ -20,6 +20,7 @@ static struct option set_opts[] = {
> >       {"perf-bias", required_argument, NULL, 'b'},
> >       {"epp", required_argument, NULL, 'e'},
> >       {"amd-pstate-mode", required_argument, NULL, 'm'},
> > +     {"turbo-boost", required_argument, NULL, 't'},
> >       { },
> >  };
> >
> > @@ -41,10 +42,11 @@ int cmd_set(int argc, char **argv)
> >                       int perf_bias:1;
> >                       int epp:1;
> >                       int mode:1;
> > +                     int turbo_boost:1;
> >               };
> >               int params;
> >       } params;
> > -     int perf_bias = 0;
> > +     int perf_bias = 0, turbo_boost = 1;
> >       int ret = 0;
> >       char epp[30], mode[20];
> >
> > @@ -94,6 +96,18 @@ int cmd_set(int argc, char **argv)
> >                       }
> >                       params.mode = 1;
> >                       break;
> > +             case 't':
> > +                     if (params.turbo_boost)
> > +                             print_wrong_arg_exit();
> > +                     turbo_boost = atoi(optarg);
> > +                     if (turbo_boost < 0 || turbo_boost > 1) {
> > +                             printf("--turbo-boost param out of range [0-
> > 1]\n");
> > +                             print_wrong_arg_exit();
> > +                     }
> > +                     params.turbo_boost = 1;
> > +                     break;
> > +
> > +
> >               default:
> >                       print_wrong_arg_exit();
> >               }
> > @@ -108,6 +122,12 @@ int cmd_set(int argc, char **argv)
> >                       fprintf(stderr, "Error setting mode\n");
> >       }
> >
> > +     if (params.turbo_boost) {
> > +             ret = cpupower_set_turbo_boost(turbo_boost);
> > +             if (ret)
> > +                     fprintf(stderr, "Error setting turbo-boost\n");
> > +     }
> > +
> >       /* Default is: set all CPUs */
> >       if (bitmask_isallclear(cpus_chosen))
> >               bitmask_setall(cpus_chosen);
> > diff --git a/tools/power/cpupower/utils/helpers/helpers.h
> > b/tools/power/cpupower/utils/helpers/helpers.h
> > index d35596631eef..95749b8ee475 100644
> > --- a/tools/power/cpupower/utils/helpers/helpers.h
> > +++ b/tools/power/cpupower/utils/helpers/helpers.h
> > @@ -118,6 +118,7 @@ extern unsigned long long
> > msr_intel_get_turbo_ratio(unsigned int cpu);
> >
> >  extern int cpupower_set_epp(unsigned int cpu, char *epp);  extern int
> > cpupower_set_amd_pstate_mode(char *mode);
> > +extern int cpupower_set_turbo_boost(int turbo_boost);
> >
> >  /* Read/Write msr ****************************/
> >
> > @@ -180,6 +181,8 @@ static inline int cpupower_set_epp(unsigned int cpu,
> > char *epp)  { return -1; };  static inline int
> > cpupower_set_amd_pstate_mode(char *mode)  { return -1; };
> > +static inline int cpupower_set_turbo_boost(int turbo_boost) { return
> > +-1; };
> >
> >  /* Read/Write msr ****************************/
> >
> > diff --git a/tools/power/cpupower/utils/helpers/misc.c
> > b/tools/power/cpupower/utils/helpers/misc.c
> > index 075c136a100c..76e461ff4f74 100644
> > --- a/tools/power/cpupower/utils/helpers/misc.c
> > +++ b/tools/power/cpupower/utils/helpers/misc.c
> > @@ -124,6 +124,24 @@ int cpupower_set_amd_pstate_mode(char *mode)
> >       return 0;
> >  }
> >
> > +int cpupower_set_turbo_boost(int turbo_boost) {
> > +     char path[SYSFS_PATH_MAX];
> > +     char linebuf[2] = {};
> > +
> > +     snprintf(path, sizeof(path), PATH_TO_CPU "cpufreq/boost");
> > +
> > +     if (!is_valid_path(path))
> > +             return -1;
> > +
> > +     snprintf(linebuf, sizeof(linebuf), "%d", turbo_boost);
> > +
> > +     if (cpupower_write_sysfs(path, linebuf, 2) <= 0)
> > +             return -1;
> > +
> > +     return 0;
> > +}
> > +
> >  bool cpupower_amd_pstate_enabled(void)
> >  {
> >       char *driver = cpufreq_get_driver(0);
> > --
> > 2.34.1
> 
> Thanks for the  new commands for pstate driver
> 
> Tested-by: Perry Yuan <Perry.Yuan@amd.com>

Thanks Perry for the tested-by.

Regards,
Wyes
