Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78426D1DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjCaKWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCaKVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:21:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69A02D44;
        Fri, 31 Mar 2023 03:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfA5yCBEbbAERPPaGzS08KoZu8IMA370vYl+5/uYD09HZ2J1LvwEiaUAsGIRm1IGExc4kxrELlBin9lcb8jn3BQTZak6lnQLkze4Mn+kGWE+mYYmzWM3Yd4tbClHfJAamZWG1xBnI22SDFMhZpM+xp23btoRQplpYbC8s8jg4tu6L3wdjBMCpYqlvu4WWLuIKcQmWo6s+w1YJ2/Gi2XCKc568rN7qdrt/ADHij5C9gq9hhmwNuUriaYNWrgrsFOfLeqVygF/hLVnqtSPCTutVQ5locl/T/K82E16ZOyGtaiLlp8b75TV/hWtYgm+JLfy5HOGfIUXEGAtXzE5l9huYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zs6kRUG3GDOldgYyvK7ZjTymV1riXpxbU5xMrJODhE=;
 b=Z7RVaz7EtPHdSN8Lij7g7nsj1OiSN5twBJu3H0/r9lhOh3n0BCywxYxe/OX4JlgRK9FDgP3whNbsTrQ7L9qP40BKcaoqU5Sv/CQD21dsbYTAIZNk0WzeO7exZaSNkHUKyQ1OcVZbFJB8LD4Ij1KfpZEbGcCeUYh/U1SjcCzpwcU2I0RC1ZQajVX5U8JL8YUI3s6Dik76kAnDu0Uyfw04UfouJr67mHwxUEMuDrO0y6iisjIJ0DHCh7RtgA06I2FdHAX9Wb50qjSXsZHSX19IdtvtLBck1cKJZYC4Aok36H4k3aGLi8exofnwKr1toPOkq0rQQonO3/4QiU6uSYbhbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zs6kRUG3GDOldgYyvK7ZjTymV1riXpxbU5xMrJODhE=;
 b=IxJiIMJ8RYro4XWJECj8K6vhrN0o8w2XbenK/orfTyqamuR5m3kvpT7N+t1mbtppWkDJG6goRHfP4Yxes40VOvOxE50hF0yXwoVZlV3rZ/5e23uAIdgQ3CozlX/2dJWODN5rtuRDUWGVDpfzczRXCjN2b1b0aC5/mV+QtnN2EGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 10:18:45 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::d1cf:3d4a:4882:7fd3]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::d1cf:3d4a:4882:7fd3%4]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 10:18:45 +0000
Date:   Fri, 31 Mar 2023 15:48:28 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     viresh.kumar@linaro.org, ray.huang@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: Re: [PATCH] amd-pstate: Fix amd_pstate mode switch
Message-ID: <ZCazdI9puSXLd0D4@bhagirati.amd.com>
References: <20230330141314.1364083-1-wyes.karny@amd.com>
 <CAJZ5v0jxwuAnTVdnThGmHmptB7qeKc34-keUOdHcugeADYSL+w@mail.gmail.com>
 <ZCZ5zjw+O3gS6trx@bhagirati.amd.com>
 <CAJZ5v0iwmvnTFVKhox11gKxM8UBR+=748zPB0tr_O5mPBbkpiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iwmvnTFVKhox11gKxM8UBR+=748zPB0tr_O5mPBbkpiA@mail.gmail.com>
X-ClientProxiedBy: PN2PR01CA0205.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::12) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 3093516b-8cd5-495f-e405-08db31d14f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WCkbwpgA5hgReKzL3aeGgGWtx77OvTRyHfwkisJjGwQGLHCd06ETcLNG5/xLdtutD1A32KZlGrJiOVvHX/PE/35dZcKcFOYu/chYsj+ODh25YAMuxLx0OCtAazQyZMB7qQtokK9qCYv6MnE3ny9GBupppg2GFc4/whO6FGHFhdXk1dIMs+RzUheHyO9U5PVQOLfZQxbv6F1QkwKxrkV7UR0Qwfwt8b8cZa5HiszVWzImbh6upJj4GKKFxhlO8HRbOEbEHGqKYqjWUrSjs12PJilJhTwxgc6WJBFsbR6YHpGtWZRSqVuor0r1HkPcp0/LXpmu2zRudYZ3dQ8L4XUV8AKa5s9XoRrLpzCpPocW1uKqXc9h3kfftxCoNLf8t+Y3hHsfGUWvjwdn7m8RkM1/UpSwiWXYQAudTnTP/iedpWzjeZw5W4t6S1YPBVp7QG6FsdJcPF7XtEIehC5ZMFJpeBDquRJcICHaSIqqoSARBSP2+94u/+ghX1ahfsUr9Z9Co6vClaWq4Zb4945AgGxoR21dt4LBf01MMIzhlpbzzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199021)(44832011)(6666004)(83380400001)(26005)(6512007)(6506007)(53546011)(186003)(86362001)(38100700002)(8936002)(5660300002)(478600001)(966005)(6486002)(54906003)(66556008)(316002)(6916009)(4326008)(8676002)(41300700001)(66476007)(66946007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFJxTGdTMUg4aVhUdEF4Y0pIQmZKamVKQWxrWVRlZWlobUZnY3FUc0NjcWhW?=
 =?utf-8?B?REFudk5EQ081cHVPWkZLbUJPVnJhK1B2YjZWaWlOV3AvYm12OWhIVjJBay9i?=
 =?utf-8?B?Z1FtLy9TeVQvUHF6aW9YMktESllPVXdqQ1NUSnhHYzdJNytpWUNsMCt6UHV5?=
 =?utf-8?B?bjRVV2V2Zit1V2VWVjJBWlQwUDhDZFZqVy9BTkdVYmg0NEp5MFI3N0hzcXVI?=
 =?utf-8?B?UkcyRDh6ZE5mN0JFNnI1dUVrWU44QjNMaGhCZjY2ZDlVbDd2UGdqTGhCN0t3?=
 =?utf-8?B?VHJZbWJDNWJGVWFyOHIvMk03NnlERmUzZFllS1MrRkNrY1VQcEsvamhGT2ZJ?=
 =?utf-8?B?Q2RQbEgzSklLQm9tT0w1Y081VE5BUmRBMUYzQTZQRHNPbVozN2hjblJqVEho?=
 =?utf-8?B?WjlES2l1UVVrVUF3djZDM2V2MGl1UTNyQ0FDSWhEZmtLWWlEWW9KWllwWllX?=
 =?utf-8?B?RWtpVmxVUFYyNnVSTCtLekdJM0llLzFBRUV3N2tld1dVRjNCME15VG16UHNt?=
 =?utf-8?B?VVJTYnR5bjBFU0RwaDljYmVocEtaRkhyMXlkTEU0b1lmVUxHaWpYTkJId21U?=
 =?utf-8?B?ZmJnT1oyZThSRjAxVEsvbVFYaGlFaUV1emRZakp5MnpZREV0elRrYlFQMVlX?=
 =?utf-8?B?S1hTUDJVRkg2UlFsR1dDR0JXQ1ZHSCtvM3hDdlF6Qm9URFpQZStEVzVURmxC?=
 =?utf-8?B?SWxBSnJwK0tYNEZkdzVoNzRlUDNBSzVLaTl3SExRUjA2d3hhbXI5dFNGK1ZR?=
 =?utf-8?B?Z1cvbVdpZWZyMGZQQ3o0TTNBTVdxaXNZY1BYS0g5SCsrWS8xMm9QNHU2dlB6?=
 =?utf-8?B?ekJDejJpQkZIZmJENmVJQ291UFBaSk9uR3ZLZDV4WExDTnc3YlA2RVZzTWkw?=
 =?utf-8?B?WENLRlhkTndQZVZJNzUxZ1k5MWxHbDJJZDdXSFJHS0VvcGZLL1ZReFpSK3RL?=
 =?utf-8?B?cUZqMk9KN0g1YzVLUk9GYS9XRlRwTFRrbjBxNTA1T2ZQZnhrZm1iQnRaSCs0?=
 =?utf-8?B?RVprS1ZWZ2Z3MVZXSnU1WWNnZHpHS3c4QmRMdC9QcDF5UDlaSFhhUkZwYnR6?=
 =?utf-8?B?em9Vdkl5ZlRjNmlweUttdWxhRHJtMUx0djJIYXZCQ3lyUWpHbEtEMTBrSU4x?=
 =?utf-8?B?RmdDQ3B3QW8rcUhENmJPYUZnNFUrR1ZORy8rcmNNV2ViK1c4L0FzamVmNlNI?=
 =?utf-8?B?M2ViOEcxMURsZ0wxQVFNNURVVVIxc1ZlMUZIcDlHbVhUd29DbmphYlh6YTZK?=
 =?utf-8?B?dGtWMS9VTGhOaWlTQXpiYy85WlB6cUw4elNLUzRsUDBqSXFxYW03aUt5WEpz?=
 =?utf-8?B?SXUwaG96Q3FZWGFtaFBsVml5M3lFWjRvaEdseEhGQnA2WTJrbS9OUU83bDVy?=
 =?utf-8?B?Nk5lZzAxbStJeVRXVlIvK1QySEtnVkdZbUEzYjVSd1NqUXdUa1dZZ0tMejRS?=
 =?utf-8?B?bWo3Q2xIN2I3T2x6WFUxcXR3UlM3V1oxaklhUHd0bG5OWWpGYlFhQkZYRGxu?=
 =?utf-8?B?NVR2SFJwTGRLMkxYWlNFc3dTRUoySW9jMDBpUE1LTTlDMVVYNlkzbFdrMUl2?=
 =?utf-8?B?UXBsMFVYVlVzZUhuZ0Q3TnVvYVF4OElkUE5Ecml2TitHZ3FsT0Zlc0prSlIv?=
 =?utf-8?B?N09lZDBPcXVTb0hmeUZkMElMZW5sVjZLeGJwVWFBVFFtWHloUzVzYVAzU2cy?=
 =?utf-8?B?WkoxN1kzbkJtSnI0VHdFTWRzNHpmOGFLcW82RGpKeG9nY0UwaWd1MGhMS2FO?=
 =?utf-8?B?cmpGM0IyT3BXVzFLTDlReVg2TnVZaExIRExpV3Nyem8xakVpenpXMXgzSVpR?=
 =?utf-8?B?cXk1T1MxTGYxaWpqREhLSEROem5PYkJRR1piU0puT0F2dUhoSGJPY1NQU0ZM?=
 =?utf-8?B?Z25XM3Z0NFlRNGxzblR6TzZuS2xicGw1WjZJNHVzRVI1b1ozQkJkampxdVkw?=
 =?utf-8?B?WURKTUlXVnU5cWVQUzYzVE9QMEorQlVOakMrcjNVNzFYMksvNmNTSTdyK09R?=
 =?utf-8?B?R2JOSGpSMjdDZWYyNmJOaXdUWGZ3MXdDSXh3WXBBcm9LMzVJQlRSR05vb3gv?=
 =?utf-8?B?UjlyYmt6aXBhQkR3dTV2blhOWGY3ZlFTRC9NYzYrMnZDRy9MMmlJT1NTQkJ6?=
 =?utf-8?Q?7nvDt+cql7+sBVN4hIuFePkig?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3093516b-8cd5-495f-e405-08db31d14f3f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 10:18:45.2235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yE1NrN05OaKdrdfD+BHW/dLakS1db58hXn5tAsHtaaB2dgzlhit12tVJdSvvznl2CMK76rvQYgOhAe+zgzOnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Mar 11:11, Rafael J. Wysocki wrote:
> On Fri, Mar 31, 2023 at 8:12 AM Wyes Karny <wyes.karny@amd.com> wrote:
> >
> > Hi Rafael,
> >
> > On 30 Mar 20:19, Rafael J. Wysocki wrote:
> > > On Thu, Mar 30, 2023 at 4:13 PM Wyes Karny <wyes.karny@amd.com> wrote:
> > > >
> > > > amd_pstate mode can be changed by writing the mode name to the `status`
> > > > sysfs. But some combinations are not working. Fix this issue by taking
> > > > care of the edge cases.
> > > >
> > > > Before the fix the mode change combination test fails:
> > > >
> > > >  #./pst_test.sh
> > > > Test passed: from: disable, to
> > > > Test passed: from: disable, to disable
> > > > Test failed: 1, From mode: disable, to mode: passive
> > > > Test failed: 1, From mode: disable, to mode: active
> > > > Test failed: 1, From mode: passive, to mode: active
> > > > Test passed: from: passive, to disable
> > > > Test failed: 1, From mode: passive, to mode: passive
> > > > Test failed: 1, From mode: passive, to mode: active
> > > > Test failed: 1, From mode: active, to mode: active
> > > > Test passed: from: active, to disable
> > > > Test failed: 1, From mode: active, to mode: passive
> > > > Test failed: 1, From mode: active, to mode: active
> > > >
> > > > After the fix test passes:
> > > >
> > > >  #./pst_test.sh
> > > > Test passed: from: disable, to
> > > > Test passed: from: disable, to disable
> > > > Test passed: from: disable, to passive
> > > > Test passed: from: disable, to active
> > > > Test passed: from: passive, to active
> > > > Test passed: from: passive, to disable
> > > > Test passed: from: passive, to passive
> > > > Test passed: from: passive, to active
> > > > Test passed: from: active, to active
> > > > Test passed: from: active, to disable
> > > > Test passed: from: active, to passive
> > > > Test passed: from: active, to active
> > > >
> > > > Fixes: abd61c08ef349 ("cpufreq: amd-pstate: add driver working mode switch support")
> > > >
> > > > Acked-by: Huang Rui <ray.huang@amd.com>
> > > > Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
> > > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > > >
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > > > Cc: Perry Yuan <Perry.Yuan@amd.com>
> > >
> > > This is all fine, but you need to tell me how it interacts with the
> > > amd-pstate changes in linux-next.
> > >
> > > Does it affect the code in linux-next at all or is it only for 6.3-rc?
> > >
> >
> > This is only for 6.3-rc.
> > The commit 3ca7bc818d8c ("cpufreq: amd-pstate: Add guided mode control
> > support via sysfs") in linux-next may not apply cleanly after this fix.
> > Please let me know if I need to rebase and send the guided mode patches [1].
> >
> > [1]: https://lore.kernel.org/linux-pm/20230307112740.132338-1-wyes.karny@amd.com/
> 
> Well, instead, you please let me know how to resolve the merge
> conflict between the patch below and your series.
> 
> Can I simply assume that the code added by commit 3ca7bc818d8c
> replaces the code modified by the $subject patch?

Yes, commit 3ca7bc818d8c replaces the whole `amd_pstate_update_status`
function with new implementation.

> 
> > > > ---
> > > >  drivers/cpufreq/amd-pstate.c | 18 ++++++++----------
> > > >  1 file changed, 8 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > > > index 73c7643b2697..8dd46fad151e 100644
> > > > --- a/drivers/cpufreq/amd-pstate.c
> > > > +++ b/drivers/cpufreq/amd-pstate.c
> > > > @@ -840,22 +840,20 @@ static int amd_pstate_update_status(const char *buf, size_t size)
> > > >
> > > >         switch(mode_idx) {
> > > >         case AMD_PSTATE_DISABLE:
> > > > -               if (!current_pstate_driver)
> > > > -                       return -EINVAL;
> > > > -               if (cppc_state == AMD_PSTATE_ACTIVE)
> > > > -                       return -EBUSY;
> > > > -               cpufreq_unregister_driver(current_pstate_driver);
> > > > -               amd_pstate_driver_cleanup();
> > > > +               if (current_pstate_driver) {
> > > > +                       cpufreq_unregister_driver(current_pstate_driver);
> > > > +                       amd_pstate_driver_cleanup();
> > > > +               }
> > > >                 break;
> > > >         case AMD_PSTATE_PASSIVE:
> > > >                 if (current_pstate_driver) {
> > > >                         if (current_pstate_driver == &amd_pstate_driver)
> > > >                                 return 0;
> > > >                         cpufreq_unregister_driver(current_pstate_driver);
> > > > -                       cppc_state = AMD_PSTATE_PASSIVE;
> > > > -                       current_pstate_driver = &amd_pstate_driver;
> > > >                 }
> > > >
> > > > +               current_pstate_driver = &amd_pstate_driver;
> > > > +               cppc_state = AMD_PSTATE_PASSIVE;
> > > >                 ret = cpufreq_register_driver(current_pstate_driver);
> > > >                 break;
> > > >         case AMD_PSTATE_ACTIVE:
> > > > @@ -863,10 +861,10 @@ static int amd_pstate_update_status(const char *buf, size_t size)
> > > >                         if (current_pstate_driver == &amd_pstate_epp_driver)
> > > >                                 return 0;
> > > >                         cpufreq_unregister_driver(current_pstate_driver);
> > > > -                       current_pstate_driver = &amd_pstate_epp_driver;
> > > > -                       cppc_state = AMD_PSTATE_ACTIVE;
> > > >                 }
> > > >
> > > > +               current_pstate_driver = &amd_pstate_epp_driver;
> > > > +               cppc_state = AMD_PSTATE_ACTIVE;
> > > >                 ret = cpufreq_register_driver(current_pstate_driver);
> > > >                 break;
> > > >         default:
> > > > --
> > > > 2.34.1
> > > >
