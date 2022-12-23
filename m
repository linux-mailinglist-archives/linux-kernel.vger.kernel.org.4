Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA28A654E12
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbiLWJGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWJGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:06:36 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DDE63BB;
        Fri, 23 Dec 2022 01:06:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuyTI61xuEHMiwnGOPGQ0TocSWtD5EUOOJGzFKwG0VaDLw3Ki3s59a12rFaTJ4NyP0QUwIpuMqVycHXED7iWoqu0aq/utjgDutDwU018qKqLdVQC8dJKDNkH6rmTLGiebNJqcgVIaxsmsUwH95hJEJ7kMThSlnbo2EtmhciBbMfLNAhuYhVAiQ2vgrwa9K2YE1xxUBHgKcZMWCQZyWYBM0hSSMSI/n1BT8G7w1V+ZMhSuSkIPU6xcYBeg7I8XC7AwtWaavZ2ldxD1BSR4k/Do5TGzowYX6Z8kbHmP4XZ/YIXR/3OyL41i0YvJljTlPneEsfgnDxofoJh0EKWs4iSdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjHIh2isk+aH/LgbL4nlF2mHLZGeVsuVvqqmXT4PpoE=;
 b=dnk0vRHhgmQk3pyZU0cj/y/1Mjklw0TYbjBlqqOAquT2tr+heNcNb/AKSJleinr/+r6fYCd5D6gib/e3stGIb78wcKk3cle72etJnPVdUqkwPuWC/ii3depS48qCuKwc6ScIy0RGAX23l4uR8R55G3M2ByKNnpT52GSAtBS3mKvJdZIEN9sa0LYvYZ+OxAESGEPY5BbmDOODiCqUBE8/oCkkuH8jNWtjJWVAxr45L2hV2PpJwMsWxz9ItP0ceRxEK4nIXDjg7HS2HrS2coznbFyFVExNXhsGrnrREzG9vlHpLgLqmHpLueUIUACkEQ1k06m7BJ+pL+WfHICwQTBxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjHIh2isk+aH/LgbL4nlF2mHLZGeVsuVvqqmXT4PpoE=;
 b=GoDCit3R98jErWWzdp24Ofy05yEuKVq0ANWZdiTzWV/rb3HRuvdTfQVrieZUBpTONFOhMrYS4SEsifgrdK7AmHta/Qzs9SwZjws2POeF/BtmW52NBkcvLSU+FsEGMKCb92XOWKrorIJDBX35NQ4nNg4Sed6dBt7dBTTMYc3uegA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.12; Fri, 23 Dec 2022 09:06:31 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Fri, 23 Dec 2022
 09:06:31 +0000
Date:   Fri, 23 Dec 2022 17:06:09 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 01/13] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Message-ID: <Y6VvgSO8XNBbP4Xw@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-2-perry.yuan@amd.com>
 <Y6UPZgtFvlJm3bVR@amd.com>
 <DM4PR12MB52780405AB9B24BF1E9B62A99CE99@DM4PR12MB5278.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB52780405AB9B24BF1E9B62A99CE99@DM4PR12MB5278.namprd12.prod.outlook.com>
X-ClientProxiedBy: TYBP286CA0045.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::33) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: a7323bd6-ae05-4266-bf21-08dae4c4fb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xemsH9GeB+JbpIj8RVQwLSjJhRng4Ku5BB7klKOyzSBRRcdnVJOKHsX0ytLrQxrF1HK19Cu1Gv6mDux5IK/Tm6tt4FYZ9RIrD5VlAgmyDGYgFlzfhIod6YgWqJkBavm1uFXvukOdrvGKLB+L/LzPt2/DjU+LrWlaFZF3S+MekcIHlN0LSA8Ro3cRy3G0aSdjpq72RmBrzALNpJ+gfgkPfSJa7wcogpPB27NsfFUSmeF2J+k+tx/Py6ARfuDS8pJq94N3qYxnQzIBdMK32lp1Ct8jUmEiTCwztAdC9wPvVK8UFBGcPmAP4G2Ci2k2Aq2nJaexTDjkMEaTFFn7JlTOK4cqVd13pyrUjRIMnoH7rPf/H3QSYjt4cIQa1LITAmKS2PuuNELCrmC7uLjolaXiiCQXliTH4bvcPKnQDLSur9F9nVyEFa3muOpA7ffUI82E7kqJYmSqeoA6lRHnMOPhK8sA8QCuzcTyqiJ44bpmzy8AN0VHDYk3s/fHT6pgMWmPE4DT6rdYCB9zWfYh4eEJj9ZcWQK/M09vD9uFwYkrhsjvSTOOe+LvKe6+P0owDHQqGd+SWGYyiimHcX+Gop5sPsw5tFiz52gqOD0O+o/UGPYZGmlQPUJJC2ihXiIch+K5qnK+wAYRVNjFBtb0hSDniQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199015)(54906003)(6636002)(36756003)(8936002)(41300700001)(6862004)(38100700002)(83380400001)(37006003)(8676002)(66556008)(66476007)(66946007)(5660300002)(4326008)(2616005)(316002)(478600001)(6666004)(86362001)(2906002)(26005)(6512007)(186003)(6506007)(53546011)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MLN7RXPgHX4or11DwjIdySkedWWCOH+B//KoGihNY1Z+VSP9t0JhN/XEIWXh?=
 =?us-ascii?Q?kG0d2ZLTpiyPogY9pdubt6ThvJ36Xvj8NQvzage0DxJVWlqdG6yZlMgL5z0O?=
 =?us-ascii?Q?vWYeoHGah6bnmcUdXAkUxtA2mot+4rE6A1fA4LR+mCmVA3qES7RP10p36LGi?=
 =?us-ascii?Q?wrzfjK/n/IywcPOhlDN82i7hQJnXZimqET3xeY6V51zNKmqAvtykm58ylyYM?=
 =?us-ascii?Q?qj4LK+wqwuF0rbAWTwv06VpK97n0nPh5bNrc1O7VrsGuHua8yMwkUo+kxhzb?=
 =?us-ascii?Q?OdU0XirzLXwarJszfO+xuhKBg7RHevQQdEUqFC4KO7t/HKRjc+Bws253V3w6?=
 =?us-ascii?Q?EmgJSxwmTMMhJCG2x57VmuDOmyQJb0FD795qMQqeXsbLw8L7cs6PVSVMWCuY?=
 =?us-ascii?Q?QtuZgOJLKLq/4TB3edKdwdczAXl5Cm8n74igTIjD1+6uAVfuESYzqfAcRrbS?=
 =?us-ascii?Q?bj6uw3gqNjyTjVCBPs9BAKtk/IAq/BBHaJUFtngKXnx99bwOGc1SesHWQE0f?=
 =?us-ascii?Q?bS1uv7XTo4CGeR/J39xP+BOUB501Di+jD4+XVm90CKB/Qqnjj3GvTSzjo5vV?=
 =?us-ascii?Q?U7NJit4uPYMz4gBKvu8G7Kskv/xlotgusrTBs1UP71leD/2ReJXazT/j8v7y?=
 =?us-ascii?Q?3HCJmklm3+AlBsTF5S3IvdIyM1ci/EezmxpxH1swlHRMfsE350wqg6EutSM5?=
 =?us-ascii?Q?HvPW7UocMXyEBgaPFlZKmLSRcn+lE9qZ06rVC9J6dqmp9XnTV9yzwVdq+41f?=
 =?us-ascii?Q?ykwtDDbQsvLuTDJH/JuYLLOxWvCwENEzIg9GBlRXJb72IjKyZ/Wt297Djssk?=
 =?us-ascii?Q?g7wHrzfG2tAfkAQPA8vKTOQ8lD7EyMvFPw8PDnLmj5iW6H6NHbfZB/phi2CG?=
 =?us-ascii?Q?MweW8JCiHRYUYv8c6cqRDAQTPfRet5Vb4naM4RLXCAv8yCgDtGY9mYsgkWI0?=
 =?us-ascii?Q?bVYNSv400tM1Jk2UxjkrVm9f6Y6fxkyCb/rxAaEhgXWHG50hZa/6d261A0Re?=
 =?us-ascii?Q?bV//imk/nC+3p7gcEDxUgzKuhwXax3qrlubg5JNms+BQCID+WFD0JAzrjwtX?=
 =?us-ascii?Q?x8t8HQAuMBT6Bt9dHc9vhkySzK31XY9Ert5paiL70YRihTNvggtcdYCvdqDQ?=
 =?us-ascii?Q?FhXJiq83axzaIufO+LEsjijL3aH3FgwmGIGp6ETfh6N9QSle/IwLJtXUEoEr?=
 =?us-ascii?Q?v1/7dKotOLpmydURfx8CdD9hlnofy3s//6e3B7939JNc4TnPLIM88zewSClQ?=
 =?us-ascii?Q?w/DhQQbkXyaK5dCxpPbnxwpPcR8cfcVbJr4AhhdLtSt+/OXBkKn/tP3s0Ozi?=
 =?us-ascii?Q?PEBeQztynY5Nq36M0Inmubbd5YnwvlGoEKkBW/7uyeb660fK2UmLV0LyueBG?=
 =?us-ascii?Q?wCTGnFw8Iy52QJ2ekSLQpZ/oTSzQYx/flsW3fJshqcqKuf0BUEkvlHRw7tRq?=
 =?us-ascii?Q?+SwQCTY5axEz+NVrnT9oRYeHjLReMLfLl0OdxzOXaAa6676R6pfnWz3mchTA?=
 =?us-ascii?Q?B15RhDKHXy2dUpWtZ4eVIDZl1lC2QmajinCTCbmCcsLfmmd0muWTYoiv4UXP?=
 =?us-ascii?Q?G34ddwVky/SMfjTszgnJFkEK314LXZX0GecnQig4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7323bd6-ae05-4266-bf21-08dae4c4fb96
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 09:06:31.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFwoFkRHiAXm7F71K3rR9/yTxX2PwTzmbknF9htXTUkxzrEFCNg6f10KerqOG3U1ejAEwEq7xhNpEVB9QP9jsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 11:19:57AM +0800, Yuan, Perry wrote:
> [AMD Official Use Only - General]
> 
> 
> 
> > -----Original Message-----
> > From: Huang, Ray <Ray.Huang@amd.com>
> > Sent: Friday, December 23, 2022 10:16 AM
> > To: Yuan, Perry <Perry.Yuan@amd.com>
> > Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> > <Deepak.Sharma@amd.com>; Fontenot, Nathan
> > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> > Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v8 01/13] ACPI: CPPC: Add AMD pstate energy
> > performance preference cppc control
> > 
> > On Mon, Dec 19, 2022 at 02:40:30PM +0800, Yuan, Perry wrote:
> > > From: Perry Yuan <Perry.Yuan@amd.com>
> > >
> > > Add support for setting and querying EPP preferences to the generic
> > > CPPC driver.  This enables downstream drivers such as amd-pstate to
> > > discover and use these values
> > >
> > > Downstream drivers that want to use the new symbols cppc_get_epp_caps
> > > and cppc_set_epp_perf for querying and setting EPP preferences will
> > > need to call cppc_set_epp_perf to enable the EPP function firstly.
> > >
> > > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > > ---
> > >  drivers/acpi/cppc_acpi.c | 76
> > > +++++++++++++++++++++++++++++++++++++---
> > >  include/acpi/cppc_acpi.h | 12 +++++++
> > >  2 files changed, 83 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c index
> > > 093675b1a1ff..81081eb899ea 100644
> > > --- a/drivers/acpi/cppc_acpi.c
> > > +++ b/drivers/acpi/cppc_acpi.c
> > > @@ -1093,6 +1093,9 @@ static int cppc_get_perf(int cpunum, enum
> > > cppc_regs reg_idx, u64 *perf)  {
> > >  	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> > >  	struct cpc_register_resource *reg;
> > > +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> > > +	struct cppc_pcc_data *pcc_ss_data = NULL;
> > > +	int ret = -EINVAL;
> > >
> > >  	if (!cpc_desc) {
> > >  		pr_debug("No CPC descriptor for CPU:%d\n", cpunum); @@
> > -1102,10
> > > +1105,6 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx,
> > u64 *perf)
> > >  	reg = &cpc_desc->cpc_regs[reg_idx];
> > >
> > >  	if (CPC_IN_PCC(reg)) {
> > > -		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> > > -		struct cppc_pcc_data *pcc_ss_data = NULL;
> > > -		int ret = 0;
> > > -
> > 
> > Do you have any specific reason to move this piece out of if-condition?
> 
> Move the declaration ahead of the If conditions like other functions did.
> It looks more reasonable and no functions impact. 
>

If one platform doesn't have any CPC registers, it even won't need define
these variables like pcc_ss_id, pcc_ss_data, and it will save more time.

Thanks,
Ray
