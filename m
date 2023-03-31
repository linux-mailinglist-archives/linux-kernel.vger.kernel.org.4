Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7F66D1725
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCaGM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCaGMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:12:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6161024E;
        Thu, 30 Mar 2023 23:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl8tmJuh56iHsMsJ4GQEkVzFkcM/PGBC++NyjvG2HkRrT3Ixaz9PSvkrFMzPUuMNC3oIQF5kcdAyzxfGK7SpgtC+D/plLHcmst9XclDtEqscV3aw5Uypup3KAY7JsjBbjiw7S7iBZAqjnat0YuLqk91glyUzzBlrAegTJ11W3H/+zV9CKqbb75j4fTAKLhye6zJIlO4O3b1TIFTDC5YU6L2Zvczb5yBAU0CSw1HDAGUeDHIXWwhywhJgjQr/29Q2ucViPmcIxsbOjwuWpILsjukkK4rIU/lFZbPW4lHG5zEk7powG1yM/BrxyS/0r1Sd/9QOVQ30hxQS3vj14XbX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrCicnQt+flnlXzBufrXWnlEhdzbKTCYHLOxC8ud5tY=;
 b=PynGdJezEnrULp03F2eb6cvBz9aPIaCgbpHJXjeqAy/8XHlSaCcf6IsToBOzMh2QMlWJy6DcWECyhpVjZrdCrVHRqb7r4RNAsyMAmQknXjEvUB4pYj8EuUytpXCkuUFkiDh3SfI8S7vaPR1N9vrt3eMLb24+9dIYyn8uBCOLJTmezkj/nmT9onbt0LHkt6xM2ogM4BLWwn3WpPNwqV9aQ8t443eATCzpQlw38XeRT8taxxTlaSi/N6VlHvxhKTXZzLUvMhl++IS6B4AOqfGcuHZ855kGZXhvRwaiQNrCZBuMfK84nMU+QShlirM4h+IdK3/1J43OI/ZfWmWvAp8BcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrCicnQt+flnlXzBufrXWnlEhdzbKTCYHLOxC8ud5tY=;
 b=vfqp3J8uYNxTKX8sT3KVRjP/xcUX6hoLW73dyLrdhpNgOyXOTqCENqnOlFN3yDjK1OSI0OdU+Bk1UTiReCcHqh0V0/c1chOBA7l3mUdv1UePliAuQoGMn4TH3gByCyJPV79p5wPuOUJ/0QySTw0n8TNodnYUYpA+gmVXYpGFvY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Fri, 31 Mar
 2023 06:12:46 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::d1cf:3d4a:4882:7fd3]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::d1cf:3d4a:4882:7fd3%4]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 06:12:46 +0000
Date:   Fri, 31 Mar 2023 11:42:30 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     viresh.kumar@linaro.org, ray.huang@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: Re: [PATCH] amd-pstate: Fix amd_pstate mode switch
Message-ID: <ZCZ5zjw+O3gS6trx@bhagirati.amd.com>
References: <20230330141314.1364083-1-wyes.karny@amd.com>
 <CAJZ5v0jxwuAnTVdnThGmHmptB7qeKc34-keUOdHcugeADYSL+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jxwuAnTVdnThGmHmptB7qeKc34-keUOdHcugeADYSL+w@mail.gmail.com>
X-ClientProxiedBy: PN3PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::19) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cec6108-0742-4e53-b865-08db31aef21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EHrEn2SuNMr0Ld+9+v3oajo1ihsjf3BzSoO5k2+WkCzjboVE3Bs7bp3fEf//eDCHznt+C4CW8yZSh5mf8BtHUTpc1LWXqOm+Js/cQzMXFYEelI02pkSqj8hSgH9uBcXbYVH3IfR2guQKRZ8ArJ6n/Ayw/qOBzqiL2iisRf0+5t8xh2JScfRVnptvOI24/fSXHfVjWE83g09GgpDWLGtEsU3k99OjepXLk6bICelnoKhyvOFepUWhKGGFyuHvXZ17HrIly+f0xF2mV5CRM0AUbA+TVsqZ2QxfiwATD43nc5Fk46YkNduLhdRXfcPH6uaN2czh9nByyAjQk8LjrLKxMP7hS67s5GnhqSphfmxOxrZoDHvrWxxTPOyShf8+z1VWWNdvv9424eoxa4d+5lFqnTlt+RDEwLxi/heR57i8N9d2L6tNxWD85U9VCVqDEbtQivylx8DaR/ue4AJraoHIK2LtYsLsOhWUNn5ZWcuy3tmuswuj3M5fjmtIJ1GkhuPn3O/5+DSWJXhrrJOxCx77t5h1ziSk3bxiZjaTNL7VE2f7PMzEYOe55GQFhBKfdQE0Cn4k6K23L91knyK20G9Uw+O5T98CJrWGkTzzcEfiyPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(478600001)(66476007)(41300700001)(53546011)(5660300002)(186003)(8936002)(6916009)(66556008)(44832011)(66946007)(8676002)(54906003)(6666004)(83380400001)(6486002)(966005)(6512007)(26005)(316002)(4326008)(6506007)(86362001)(38100700002)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWkvUVZaUGNWOVAwTFU4MHdXMHowbzhtdWpZV290bmF4dUEzTWVQSGcyTWpK?=
 =?utf-8?B?Qk96LzlTL2wzcW5JQ0ZBY0ZqWDAwVlRKaWk1QXNTekVTckI1UGZUYkhoZzBj?=
 =?utf-8?B?TkJMQlRjUW1yVGJRTllHWEdmSGRmRlUvak9KTEo3cy8xQ2FSdHZ2TVZFaDk2?=
 =?utf-8?B?bDZvZmtpNmloNEgxSk10NjFFS2hzaENtL1hTa0tHOXgwL1F5QW1UdTVZS2FW?=
 =?utf-8?B?dUcybUllM2QxaFAwNVZzT0lwc0hFbFZPRHN6QlhwemJueUJEV2dmR1U4Q1VK?=
 =?utf-8?B?cFp2RC92Ujc4U1RQSk5xM0NBQ3FqZTdPaTBkVnBOdFkwL3ZBVmdVODV3Q1lL?=
 =?utf-8?B?RkJ2Uzgxc3d1dzIwWk1EbnVnTkhIcVBHK203MmdhaFdISGhSYnRKRmpmdHRm?=
 =?utf-8?B?eUpIeWxnODZYUlc0WklGWUVkRjkzenRUWVhlaGI1Vmd2Y1g4N2s1UGxIa005?=
 =?utf-8?B?Umpickc4RDdva1kvZ01TOHRsZlROSTc2eHA0MjRuUEdLYjU4d0ZBQVZsOTN5?=
 =?utf-8?B?KzBiNlhJTmNUMWNiclkzbmtYNStKSmJrZXJUTFBpTzROUjNOdE1lVlE0V0ZG?=
 =?utf-8?B?d1VCYkhTMnRPM2FWRU9tQUpuZFRuM1d5eFdsSnFoSm9QOWg3RmcxNzNNem9n?=
 =?utf-8?B?eXJXYlcrakRKLzNIcVg5UzdtamlaSS8xVkVGK0c3OWdOWVZmWmRObGdzNzNN?=
 =?utf-8?B?TXlHTUJCdGpqSFcyZWlMVkoxQzVuQ3ZSL09nMXJvM0V6MkpKbGRqSUFEenhZ?=
 =?utf-8?B?Qk9KbktpN1RnVk1xalAvR0ZrL0tQVkh0ejNnTWNsQlhQN2NBOHdTZnZtd09X?=
 =?utf-8?B?elk3MzdHNlh4eW9NNXlLQTVDb0VGNmphd0w2SHZjaEt3VWI0T21tMURUZVR0?=
 =?utf-8?B?UytoSlk2KzljbXBpdUptSWtkOXVLR3FEZzYreFZPWVh4QkdGN3RldGpRSEcy?=
 =?utf-8?B?eVFVNHhxZVBKUk52QVQ2Vm1HWlRpNzI5L2Q3OGJycmhpNHk1YkRLdjNFR3gw?=
 =?utf-8?B?SHlGTzdHUlBUMVBWMytMV21ldEFQRTZGa1NIQjNZMDhzZjNkYnU3T2puMVZp?=
 =?utf-8?B?RzJ2N1hpbExSbzFxclRSbEZyS1JnWE5od21tNHVHODV2SUdGV0lRR3MzcFBK?=
 =?utf-8?B?TDJMNE5RbXJzVTU4cWlMaEN5cUtmNHdlZmhPVzFxVVhya0x1VnRRMkpkcmtJ?=
 =?utf-8?B?K2taZ3lRbmQ3UFRaMHkrNG1GNlRaMkJLVldrR045MUZ4OTJjaUltM2VhT0Jt?=
 =?utf-8?B?SytiT0pLbkRyUG14WWh2ZEN5NC9KYjEydnd6ZmZ1THdpemNnbWdaNjBuNGIx?=
 =?utf-8?B?VEFKMDdPMVgvTXNHMUpXa1FkUlNLV2FTNmFEbmREd2p5cTBpM1RTYW9ZbVhJ?=
 =?utf-8?B?Wkdvc2tpbE41UzZab0xvS0JzQklTa0xIbjlTMlFIcndqV01DZE1BK1JocUxT?=
 =?utf-8?B?bGxxY0VnekI4R2xaNW4yTnc4N0o4Z2pGRkZDR1VoaFhJV0ZYcXRwSmJLV3ZL?=
 =?utf-8?B?R3RFMlJUUFBEck9kU3B2NTRycHhXeExGd2FsbnRoeUE5bktKODhQOU5HNlNT?=
 =?utf-8?B?Q0JhdFo1R2JYbDBRZjZFRGpjZEwwY25QL1FJRGk1ODNERi9aUyt6c2ZxeG1h?=
 =?utf-8?B?dE1sS0R0Z1p3S1MrUVBCV0FpVStOa0RhZ3B0RzRYWjBRQVZscHY2dUFsNmJI?=
 =?utf-8?B?RU1CdEt5bDM4UGhBTzBFSDlXQVZ5VDBYL1hvbUFMTkszUy82bU9ndG1vemtx?=
 =?utf-8?B?R3M4c2Y0WEJtUlVrajczbDZZUmhkRDNxcFYwb2tIc1l0Rm5pZEx3NFdqNWdG?=
 =?utf-8?B?ZzIzTDRlM1FaVDROb0FTcDc2VjhCSVdzaEpKM29yWFBWV3o1QTdkMmtkS1VY?=
 =?utf-8?B?UmlFQSt6NjdZL3RWdy9qc3RhMHBZdktwUE5TeE1PNmtEcTJZQXpQdWw5U2E4?=
 =?utf-8?B?QWtRTG80NUdReHZhdllSSGRxcFBOdmx5L0kwMFhYSzVuQUxJenNOdEhLYzFZ?=
 =?utf-8?B?K3ptNHpKcG5Pa21ZVVJkWEhkeGkwMFZEM2ZCZHFRZ1MwZWROdDg5eStBMnlv?=
 =?utf-8?B?QytTazFla002ZTdVUnBEYisvd1lxdURFK0ZqS2J4RjRuVkd3aUdnWUs3MlJV?=
 =?utf-8?Q?Vx9tXhiVRiGXg2EKub0fxsJi0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cec6108-0742-4e53-b865-08db31aef21e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:12:46.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zChEmoKQGgEG7NnktWr2q9ZW8vDfIhlmYanUKfh09syM2S9iDk+4bwzrHl6wUzPLrgUiqXkNHLUwEvK2YfsJ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 30 Mar 20:19, Rafael J. Wysocki wrote:
> On Thu, Mar 30, 2023 at 4:13 PM Wyes Karny <wyes.karny@amd.com> wrote:
> >
> > amd_pstate mode can be changed by writing the mode name to the `status`
> > sysfs. But some combinations are not working. Fix this issue by taking
> > care of the edge cases.
> >
> > Before the fix the mode change combination test fails:
> >
> >  #./pst_test.sh
> > Test passed: from: disable, to
> > Test passed: from: disable, to disable
> > Test failed: 1, From mode: disable, to mode: passive
> > Test failed: 1, From mode: disable, to mode: active
> > Test failed: 1, From mode: passive, to mode: active
> > Test passed: from: passive, to disable
> > Test failed: 1, From mode: passive, to mode: passive
> > Test failed: 1, From mode: passive, to mode: active
> > Test failed: 1, From mode: active, to mode: active
> > Test passed: from: active, to disable
> > Test failed: 1, From mode: active, to mode: passive
> > Test failed: 1, From mode: active, to mode: active
> >
> > After the fix test passes:
> >
> >  #./pst_test.sh
> > Test passed: from: disable, to
> > Test passed: from: disable, to disable
> > Test passed: from: disable, to passive
> > Test passed: from: disable, to active
> > Test passed: from: passive, to active
> > Test passed: from: passive, to disable
> > Test passed: from: passive, to passive
> > Test passed: from: passive, to active
> > Test passed: from: active, to active
> > Test passed: from: active, to disable
> > Test passed: from: active, to passive
> > Test passed: from: active, to active
> >
> > Fixes: abd61c08ef349 ("cpufreq: amd-pstate: add driver working mode switch support")
> >
> > Acked-by: Huang Rui <ray.huang@amd.com>
> > Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: Perry Yuan <Perry.Yuan@amd.com>
> 
> This is all fine, but you need to tell me how it interacts with the
> amd-pstate changes in linux-next.
> 
> Does it affect the code in linux-next at all or is it only for 6.3-rc?
> 

This is only for 6.3-rc.
The commit 3ca7bc818d8c ("cpufreq: amd-pstate: Add guided mode control
support via sysfs") in linux-next may not apply cleanly after this fix.
Please let me know if I need to rebase and send the guided mode patches [1].

[1]: https://lore.kernel.org/linux-pm/20230307112740.132338-1-wyes.karny@amd.com/

Thanks,
Wyes
> > ---
> >  drivers/cpufreq/amd-pstate.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 73c7643b2697..8dd46fad151e 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -840,22 +840,20 @@ static int amd_pstate_update_status(const char *buf, size_t size)
> >
> >         switch(mode_idx) {
> >         case AMD_PSTATE_DISABLE:
> > -               if (!current_pstate_driver)
> > -                       return -EINVAL;
> > -               if (cppc_state == AMD_PSTATE_ACTIVE)
> > -                       return -EBUSY;
> > -               cpufreq_unregister_driver(current_pstate_driver);
> > -               amd_pstate_driver_cleanup();
> > +               if (current_pstate_driver) {
> > +                       cpufreq_unregister_driver(current_pstate_driver);
> > +                       amd_pstate_driver_cleanup();
> > +               }
> >                 break;
> >         case AMD_PSTATE_PASSIVE:
> >                 if (current_pstate_driver) {
> >                         if (current_pstate_driver == &amd_pstate_driver)
> >                                 return 0;
> >                         cpufreq_unregister_driver(current_pstate_driver);
> > -                       cppc_state = AMD_PSTATE_PASSIVE;
> > -                       current_pstate_driver = &amd_pstate_driver;
> >                 }
> >
> > +               current_pstate_driver = &amd_pstate_driver;
> > +               cppc_state = AMD_PSTATE_PASSIVE;
> >                 ret = cpufreq_register_driver(current_pstate_driver);
> >                 break;
> >         case AMD_PSTATE_ACTIVE:
> > @@ -863,10 +861,10 @@ static int amd_pstate_update_status(const char *buf, size_t size)
> >                         if (current_pstate_driver == &amd_pstate_epp_driver)
> >                                 return 0;
> >                         cpufreq_unregister_driver(current_pstate_driver);
> > -                       current_pstate_driver = &amd_pstate_epp_driver;
> > -                       cppc_state = AMD_PSTATE_ACTIVE;
> >                 }
> >
> > +               current_pstate_driver = &amd_pstate_epp_driver;
> > +               cppc_state = AMD_PSTATE_ACTIVE;
> >                 ret = cpufreq_register_driver(current_pstate_driver);
> >                 break;
> >         default:
> > --
> > 2.34.1
> >
