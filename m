Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E86D69DA33
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 05:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjBUExz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 23:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjBUExx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 23:53:53 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAAD2310A;
        Mon, 20 Feb 2023 20:53:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqkIOIIoFdG9lmcsAmyzQSyc0qHuHnGdJStCm8LhGyNhGeXj1o7t+8l9NnooJn3bpYe1cCiM6ttC73qSwuHNyRGaZcJADhCA6wubUSXg1iVda+CHnvv22+GO/JUP2u7/qPjKKtstTVnPwBGZ42iwKqZ+hgmXGeB5tVaqmc5t1cTqLprKTjQfnqleX97a7DKWbyXomzpARhYkgopHPv6xkvDRxhQ2K2z12xUo3pOexUKeZRN2h/GUnD2nNMhk89g0p5EEyTt0vyoWDviNsHQ/fumK4RB9C5fXS1vZAo+1iCV54UUg5OfBo4LKAjvT2y7y7ydwFaZwWhfMy9f/ugFYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNKTuKXAw3mKZz2i6yLVzA2dFTWj6dmUoA7ip9aF0XA=;
 b=lPCG81nWZ1W5ZfDphi7gCIQ7tglC0r3K1evuor6qbMG9+tUeaRfhX+d6yj00vzUWsQ8+0PTxAFiPVwgtXxE/yP4DgSWftA22VZqZS2kcUzolRMXTUDWey+DrL0L5YIrB+KOZvOMIOyo7+NNA5qpv1RchD9z2Z8TwxUuCk1LXBKTbXPFtrRGsOkv7+xKr8D3cELwYB7VY3+aTvGzjR0hiIKI0cxh8CAFShNBHJoCvIT5snrg2xlYx8b0jkUs2ecj+5nsD8Gi+WNyQF6U/M8+jZofYdj79eIqPYh+VFt527lkJZd5c4VCBxWXfPJsdfDiW3UbF5lFET/V6XYvYUEr/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNKTuKXAw3mKZz2i6yLVzA2dFTWj6dmUoA7ip9aF0XA=;
 b=WAr66kKyr/H8UdZl/3eXdO7MdQo7AYOKgy725SZivFDErWV0BUM93UP2znEOc94PBIAPO0EI5o1hd6+zXUIz1oSyg4e0zk1QERHC1F2aiGod6PLJhG0uz3yCIrCoqyuxJrREePh7Sw0TW3x8/h9G1Tmdaw6fELiWj066Q229g6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Tue, 21 Feb
 2023 04:53:49 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.6111.019; Tue, 21 Feb 2023
 04:53:49 +0000
Date:   Tue, 21 Feb 2023 04:53:34 +0000
From:   Wyes Karny <wyes.karny@amd.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
        ananth.narayan@amd.com
Subject: Re: [PATCH] perf/x86/rapl: Enable Core RAPL for AMD
Message-ID: <Y/ROTsCSCFtrwwTK@beas>
References: <20230217161354.129442-1-wyes.karny@amd.com>
 <Y/NdUjLiQu+D0q7b@hirez.programming.kicks-ass.net>
 <CABPqkBTU_gnTr9ayvg220T4pO5NAguvu_UJAkZO2RUATWuMJ3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPqkBTU_gnTr9ayvg220T4pO5NAguvu_UJAkZO2RUATWuMJ3A@mail.gmail.com>
X-ClientProxiedBy: PN3PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::8) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f61f47-df4d-4ce8-912a-08db13c79ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FhbZdFQC9jlDlybKSz0HyD+rb2oVXiedR+Il5/q4/OpGUoHfPmHhoWRdrmX1uRa7sCInNm7d5Yp9/+UJ4nNVJdJQZTzgYQjUJ3gpAGPSbH5Gd7J227F39bcir+pSF3QUQnnk56b4xo9pJ8OROgU/95rICcPZmhJflVu9LwDqu3rCKwdcxm4bZPImSMYuBXtE0qD9nNuE0VtT2Vch995LGZrpKeD5V5dzp6CTXkayr/KUBK5WS0AgPOBjKyqGZA0VGb0hpLIZ1i9vWjTHFmSsfYpIm9Ac1jIJrGM6TMKwm6D5mUCEhYYOb+zToDQXu1u4tQGQ4+7P2wKAfllS/oC5im64Nv2pqeLUc2CRsMi4BuF7DKJ3KZIpyfKhdbIZ86aCvJzMgqM8SLmO1ZKuB6+pdCXT0ukUMDx8sfVMqk/dexsL4q22Tzn1cV3Zapnx+8xcVak6e8/4BLClgMnEJyktYQrrKJWRB+bOjr4SBnllJ+uDpkBqah6imCsQYQ8SbVyYI7oqv2nCeastI4EXUHnHJESroUldyf2/eUdnrZRpHGlvhL7IV6xixGBsRF4/jUkWc1WbXm/2JvAiucmRSiUM+eWc37MwkGZkP+rBzTT3LZ4aFpnvDCD95vRFYDRXDvQVPorQV3ZvpXEXSWEQYlyS5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199018)(83380400001)(66556008)(66946007)(8676002)(66476007)(54906003)(478600001)(316002)(6512007)(6506007)(53546011)(33716001)(186003)(9686003)(26005)(8936002)(7416002)(6486002)(6916009)(4326008)(41300700001)(5660300002)(6666004)(38100700002)(86362001)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUFLOVVTVzJqQUlFdGtLamFkbGQyZTc2c0VtMlM1Z3oxdEdYZVZuUFM1Q0Vy?=
 =?utf-8?B?R2UzSFdHbXVNa01TR3R1dGM2N3g1L3RaZzN3Rm9ZZjZBRERJR0pkS1VtdzNP?=
 =?utf-8?B?QzB1VnZYN2wxU3F5ZWp1VDVYa1J1OE13Vng3eUltNmlhUkxKUm8yeDVKeE9p?=
 =?utf-8?B?YzBDYlNJSi8xbDRlWmNOaTVseERMZGlHT0VseGVtNTBTeHAveDRMMUFQMEZC?=
 =?utf-8?B?aWdiQWVxeDdEWU1YTFROZzVicjErbENUOGVibUVJdHl3RWcyWnlVc1dyb2dH?=
 =?utf-8?B?Q3ZobGRLVS9EUVpnZWs3Z3NmcXhNNVlHd05qTHdCWmo1ZnpEbTh2c3VMSytn?=
 =?utf-8?B?Sk9zNHhVZk1LelRoQ0cyRjlha1hsMlRtNjJ6cEhnbnNxUTlXekV4ckpvektB?=
 =?utf-8?B?WHhhNjJNbm9ya1FVNEpON0dscDcvY3JzN0RwNWFRS1hEWFRHMEIwNlVzcXNZ?=
 =?utf-8?B?QUlySkFCSHE1ZGliMWdxeVRZUGRiZzkwV0trU2F5ZXJSaDNaRUtDRExFajBH?=
 =?utf-8?B?WWJNNm51a01seW1iMjU5cHBsZU1MeURvNTZxTWZFU1FNTmJQcGFwUk5ZOUo2?=
 =?utf-8?B?UkpDVm9rWnpiRG5RKzB6eHh0WE4wa0RVVUExQUZLdU05RmVnc2cxVm44QXoy?=
 =?utf-8?B?S1RBcjArNFQ5b1NOTHB2bW9LQms2L0RSeUVFT3VQOWU1N0t2QlRicXFoV3E1?=
 =?utf-8?B?b3pJQ1Mydm44dHhlNlJxc29hLzlwbHRQMWlzYkpLZlZZTGJxaVZaWDdkdTE2?=
 =?utf-8?B?aXMvSFo5c2k1cGYzd0NzdklwTEh2WDI2NVZwVUxrcS9rZmlUZFFnS1FGYWs4?=
 =?utf-8?B?QmMzNlVNaDdldGM5YU1NRVVIVmpPK2RYUmlSN1JxdXJTemNNL2RlSGRobm9U?=
 =?utf-8?B?VldRcXQxWW1vbHpYRVFQbUp0cGxLNzViWFBIOWJabStYNEh5dHcwSkdEQ2sr?=
 =?utf-8?B?T2RENHI1QklhSGN5U1AxS0xZVDFnM3R6a0FOSE9kNTRUWFdNL3lmSGRhS3Nx?=
 =?utf-8?B?NGJyd2g1MG9DUGQ4UGEvT09SMndDeVJnbFFEQkFZTWwzZ0FLU01RUEk0bzVn?=
 =?utf-8?B?TkZiQTRWUE9wU3djVUdUWE4va3lrV2pvNlFVbC9UN1BIZGNxc2JYMkhUTmVp?=
 =?utf-8?B?T3BnallPRm9SSFBDcjY1cVFzb0orSUMxNkJEdHdLbXpLakdna0Z2U0JUV2Y4?=
 =?utf-8?B?alBKdGtyVjJYSzVTZmdUL2ZFQ1dsaGZmMUlEMmJwZlFFdkZXOVF1bVMvSEtH?=
 =?utf-8?B?THlsV0ZDUzREUWRhc28xa1Z5dlZyYUZFUlltL2g0cmVYT3loZUxzcEdGdjh5?=
 =?utf-8?B?ZTloWXFhUFhnSGQ4RXROYlVpT0JtaGs1QUFVYUdhUGlvSUI0ekVtT0d5ZU9w?=
 =?utf-8?B?bHpwc2UzMmlsVUJEdkROcjZtSzdZbmVyalRTeUdWbkVDeFNxSXl4U2xpTmRP?=
 =?utf-8?B?Y2Y4a2hDT3dNV3BDVzY2cUhkbkE4YWZvSUFxNjlsVHloY3hXQ1ZFdlV4VXN4?=
 =?utf-8?B?VXpLS1dCSk9yZS9TZmY5Zk9wZzBuamtTaXFHM2svYVJaeTFiWTBYby95SlE3?=
 =?utf-8?B?dXBIU2cxTUVMSFJqQTJyNGZwc3R3UlpsTHV3OXRocTV1N3RRMDRkR0t4V25X?=
 =?utf-8?B?ZWxJY2tmZzZXc0RBbVpzOElZcmFmbXUrWFRMNmNCOVE1VlJXYzB6cVNRZnVs?=
 =?utf-8?B?R25LMk1mNnJXM3RoWHZLLzVra0lDVGhwMFhtME00WGtIYlh0dXVtTWxtNlc5?=
 =?utf-8?B?anlGQTEyUGZ4NWZLdXVGUmp2N1Bjdzc5dlpEK3d5WEJCTDBVU0lXZDNKNDNX?=
 =?utf-8?B?Nko2SW1tUzFneFVSUVlVS3pVU2txUGpYWUtVeHBjbXlwbk4vcmtQMFU5b0wy?=
 =?utf-8?B?QlZNaXI4bVd6TDBsS2RHbEd6MmNaejR1TnJRUzA4eG0ybmsrZ3FsWGZ4U1Y0?=
 =?utf-8?B?SzlsOGtaWmJSRm83Qi91dEhoNGxUQUZDV1lXTjRWZTNoSmpiVUhhTDU4VG1u?=
 =?utf-8?B?WlBINklPZzJraTFWVUNqeWhHT2xnT3Q2b3B0WkdHUU0rUC9SNXMyVVFYN1Q5?=
 =?utf-8?B?TllweGthZU9KWTFuNXloaldILzNWOHlXVHF3YWpicjhtbTFqUnVkMVg2U05G?=
 =?utf-8?Q?GkhykZd7AmNNSVFh8xtI6SFRR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f61f47-df4d-4ce8-912a-08db13c79ebb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 04:53:48.8537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HOwqPv5hG1gADH4Ei2Qb38GsbZPYVdtzvixoRj0oiGTu2NS245Qu1qpYLWBhlXyClV22UKY/zaaXrIyKWt/KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Feb 13:29, Stephane Eranian wrote:
> On Mon, Feb 20, 2023 at 3:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Feb 17, 2023 at 04:13:54PM +0000, Wyes Karny wrote:
> > > AMD processors support per-package and per-core energy monitoring
> > > through RAPL counters which can be accessed by users running in
> > > supervisor mode.
> > >
> > > Core RAPL counters gives power consumption information per core.  For
> > > AMD processors the package level RAPL counter are already exposed to
> > > perf. Expose the core level RAPL counters also.
> > >
> > > sudo perf stat -a --per-core -C 0-127 -e power/energy-cores/
> > >
> > > Output:
> > > S0-D0-C0           2               8.73 Joules power/energy-cores/
> > > S0-D0-C1           2               8.73 Joules power/energy-cores/
> > > S0-D0-C2           2               8.73 Joules power/energy-cores/
> > > S0-D0-C3           2               8.73 Joules power/energy-cores/
> > > S0-D0-C4           2               8.73 Joules power/energy-cores/
> > >
> > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > > ---
> > >  arch/x86/events/rapl.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> > > index 52e6e7ed4f78..d301bbbc3b93 100644
> > > --- a/arch/x86/events/rapl.c
> > > +++ b/arch/x86/events/rapl.c
> > > @@ -537,7 +537,7 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
> > >   * - want to use same event codes across both architectures
> > >   */
> > >  static struct perf_msr amd_rapl_msrs[] = {
> > > -     [PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, 0, false, 0 },
> > > +     [PERF_RAPL_PP0]  = { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_cores_group, test_msr, false, RAPL_MSR_MASK },
> >
> > Stephane, this was an oversight?
> >
> I think it may depend on the CPU model. I remember it returning either
> 0 or bogus values on my systems. They may have improved that.
> The commit msg does not show which CPU model this is run on.

I've tested this on Zen 2, 3 and 4 server systems.

Thanks,
Wyes
> 
> >
> > >       [PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
> > >       [PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   0, false, 0 },
> > >       [PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   0, false, 0 },
> > > @@ -764,7 +764,8 @@ static struct rapl_model model_spr = {
> > >  };
> > >
> > >  static struct rapl_model model_amd_hygon = {
> > > -     .events         = BIT(PERF_RAPL_PKG),
> > > +     .events         = BIT(PERF_RAPL_PP0) |
> > > +                       BIT(PERF_RAPL_PKG),
> > >       .msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
> > >       .rapl_msrs      = amd_rapl_msrs,
> > >  };
> > > --
> > > 2.34.1
> > >
