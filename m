Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FF2606F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJUFWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJUFWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:22:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7272D22C467;
        Thu, 20 Oct 2022 22:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbopdmqAC0IwASgeBxkR31baYfTgxGXAjOxxWnA2APEUTucHBpmAWUJK6HOMt8Cc8XAjbu/KcDNvXKC2MTfrus+U9Y/wIQ6GdZuXUy/sfE5GgrHps7uwMpZSyxl2O6by4FVJe6Ceq5VSQjEHK97DgiywQPPgbK43WIgrsYWSQcLEKwRZDn6WT5Qu7+NVxnA/guCLkQoFL3Eo8CPtkkwaya6fQHK6ue+ShMVVaK1wqv/whPwwe5idhdjgwoW60r6Fen+HwXhbmK4irRYK9bKuij2UtWuz0jTKpoYIULR6Guf8aD99zntpLjPuPdRJrySMC0zwd2Q2qVM0pLQMIRNWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DiGJtUCAPkH0fTAhaJexMRlQ+0QP9KJ2+ISWhDI9Uo=;
 b=YaA5M9m9N9rbt9indZ97F+7QzZuoiV5MvlLk96O4OietBqDgi9JhCjMtG4hZOuRxEo98gw3XB8kYnU56l6BxH56rSIkwXHbmSMCFhOSujdB5ilSZW9bErwLlzBM+VOxunsQqAqOPeY/zzEB6NT0Xh2NxKXYD5pRlwopjWMUw1Hc4Wes3FDCICsJdyUaAzQ6JPqpa0EXs6YEBP6pGXaskOwdcsxSljq1o5OG7q4G07atIfm92y+ifKYAzVH6dqhxMxtiZffBtAlzvxx9N2yW2RA8VySLApXF6HqMFBFJjMuNZ4S6rxeAyRUAxPFM6HAfVZVAk2HFDudY7AwXgkYmR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DiGJtUCAPkH0fTAhaJexMRlQ+0QP9KJ2+ISWhDI9Uo=;
 b=5dDbmWVumgLWQxWPYcSWJfEspvQpSEAE/QVlJjn6emyMqjq33eC6IzdPLLVDhnUh1eIoGhvvC34zl5CZwJalbDffctS1gJhFYgtlIqw6I04Oqzmv96Ul43m7iZqZrQSJX4yHi3c1D4Es1gknakL/vafSelzo6zbnM3vqBKFlL7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 05:22:33 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08%7]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 05:22:33 +0000
Date:   Fri, 21 Oct 2022 13:22:11 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Message-ID: <Y1Isg4q9Vsl8zNPe@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-5-Perry.Yuan@amd.com>
 <Y00m6Fm6AKqh65Fr@amd.com>
 <DM4PR12MB527826BF143D69100305B1A79C2A9@DM4PR12MB5278.namprd12.prod.outlook.com>
 <MN0PR12MB610143C5F04927B7408017FCE22A9@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB610143C5F04927B7408017FCE22A9@MN0PR12MB6101.namprd12.prod.outlook.com>
X-ClientProxiedBy: TY1PR01CA0189.jpnprd01.prod.outlook.com (2603:1096:403::19)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 392d03f4-f6fd-418d-560d-08dab324420c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zuBXT3kSHx8lbwVkjk7vCT0ZDi9be6TzepUJCf7mbZ7njiXocRFgqDuHvd57/5NiX89L9wuGqF6HgXOXkxiotBM/W2D7KvPWfUt/gn9NlN5eNrZQPPaE27HmV42eMl1PBjGedMu2jU3OxC0Ygno3PcnHi1lOa09RHah05pZV6pmxGSgLsETUPDMAxMddhgVxbUEdWfCwFuO+ED1V1HilRjeQ63PApPSrC/iHHWV7/2/iH1Eg6ZlBJvUy4rTfkVdmOIfHMh6sjKOJGR/XWnzPyK3uFSSON9fSMnrfmtPXRquy6JicnbJFSkVV1kteydAa/9H1bKgmYQm3A/LgLiB1q7wMWgopdUOxzWVeIM7HbfHy8fTNveDnXHNhrYv6+RCJrcvIlLDAOpe2RAzSrHkBIBKpr9yaMWRPD2j4DQgq/r8LYdKIVCrBSUVEnkKiDebcJ1t9WasBarRAKdxOPJSAWb3oJq1C3ilYgoVl/El76yAG5TnXybv8krJymZiRXxY10vjF2eqx17w12KZtty7yQsSex+u2IU2YeuPviyPEoSggvKWtrw/Vv802PR0KeWs8Do9Mo4XseTFWqhVQ/Cy9FjMNopGrAKGSGZslWOwYB1RFRD2PRdfqj86zTVDGZKCbc6Du17XxD7xhrRQFd5FhTUXWheCyEM+57ej7OhgU31j9e7OWuf/3LWFgXhY0mDWJkTE6J4w+rBq6yIjTwpFtb471049rJiM25Dh5X6xOFEklr0KRs85LH1KfBobgTiPYPHbMiGMt9N+hVFQjnmKw+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(966005)(6486002)(6636002)(4326008)(37006003)(316002)(66476007)(53546011)(66556008)(66946007)(54906003)(478600001)(6666004)(6506007)(8676002)(26005)(5660300002)(8936002)(41300700001)(6512007)(6862004)(186003)(2906002)(2616005)(83380400001)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kJzpDpR9y/aVTEon4jEXvZYPh0ebIyvsvElJKallmi1682RO3IersXRA8w96?=
 =?us-ascii?Q?f8qiwpclhSONOwBab+iIeR4AgamQKX7vOe2vxKTtcNVpI0Fz7Wr3RnfQRCDf?=
 =?us-ascii?Q?XV+xck1dyXhuaXpq5s/PAoNmECglF1fUMF/X8XUk7UwwOVBFeEfhG3gix5GA?=
 =?us-ascii?Q?qqHRCOnx8x6EZXHVy+M3gQXqDXBYPWTlSCUfVxZ74a4TdZb/kNnUTh0C5vXf?=
 =?us-ascii?Q?dwl1bhGAaAcsqSqVbzgVKX1D2mZZjlDK+GxVjTQTSihLX4yx5TkiubQfRkgs?=
 =?us-ascii?Q?RZy27/sUZKBQTKUTLe1svcJPGqGxYXg5IF34oC4xbiMvhJ4YgezJvCK5aAiY?=
 =?us-ascii?Q?XoAFf7daGLXPcw5CakSX6AcL5QgUS2DAkkIa/dXjSYQmwbXjh9uYmzmzprFE?=
 =?us-ascii?Q?weExqJmEHCyG8VhhQaMoij1b4phNZxQd6s0SjKVBpu8vsGMmEWqzb3gbSoJ9?=
 =?us-ascii?Q?Vncjpgykuzu+VtiQWCs2w9xEraEx1C5eiGb7qhAKg35gM5DZCF9QV4e4Rd2Q?=
 =?us-ascii?Q?/x4BMWc+F+yOw00F4wJAyXuRgQZK5zPC3s5APnpYZXC3kj0tRMMSdUSYbaVK?=
 =?us-ascii?Q?5tmBZ4F0pOkPBMEcwEgbEkaRKaZ/5LD2m2WrQQeA5NaGvBdJJ2ASqxlFhT7M?=
 =?us-ascii?Q?9Q0PVJMiJ7Yt366BX/XFE6TaxFl61+bPZrGnfQAdHLrXUYRFp3N2EZi9+dzd?=
 =?us-ascii?Q?kIQKt3U31R4HsqcEoei4uuVDT6mAO3JvXSrKdui1E2Xqb5eL9HtMzN/h8MFh?=
 =?us-ascii?Q?wOwIOIVAt9vztsKlEW2blf6YjqfLVMyoaliB04hVs9C+AcYBUWtB1K6lDOEg?=
 =?us-ascii?Q?hWoIK4/sDl+sL3iTX/UwvPth31LRUIDNoBNJsPTGrURzfAP+fuYWOdTeqdDq?=
 =?us-ascii?Q?F7LOZr5dqqlj7z2ulgkcpm7ak7U4no0B5DKNqJP3D0Qg2KOlqN+Uf9oa6JJv?=
 =?us-ascii?Q?a07Rv5NhZlXgs3o6uFmkXq/FEUMieN4aqGT7q0Jn2yoGomL8fP8LktQy0JYU?=
 =?us-ascii?Q?CijN7IhxVvYVoOg91y6cugcqPpgufHJDT+NMw2MqrUQWSkKfW8/gRCGOvwIU?=
 =?us-ascii?Q?uFGvy3+KZZ8Rr6f3KcVKdL5LvoMtOeIH/Z5EUGMoAW8hKSQXRjr8P8wv5+M1?=
 =?us-ascii?Q?y5gmvxOUuCeSXoEeC/ONN9vborHhidX781y1AOmXuulisa5nERWw+nrpwQ1x?=
 =?us-ascii?Q?PZekeIMCs2PxLde+2rvpRayRokE+yl4aMG4z0uCf8jEF7HISEsw6aX8c/PZx?=
 =?us-ascii?Q?e0H8BEtEHDCAKlhOiel7bGLkB3ERZo9SXL0kIgfk9R3c2YjVySvRKfJJ7loe?=
 =?us-ascii?Q?30dRaTWcxaAoqYfJ+WQuHngmGYKvk56KdoBAgi92rL7VVaay2NAZ3mcJCebX?=
 =?us-ascii?Q?IEgikG342OPtlDBJvSIqq7HDUBAf7643yh8T04wj+sOKSltiU+hnX9a+DVES?=
 =?us-ascii?Q?EfyeJG9nINcA0ndfMqAxLnO2D1xHH37Qat9pJrZEZ+UiTsc2gBpUa+DpN/fO?=
 =?us-ascii?Q?J6X45vfTTEjEl9aUC53NIvcRGTta/UyBi9T/cGB4fVoLIRkhceKrlpOAzoWz?=
 =?us-ascii?Q?IBmZDkFRLcmQW9S+Kle7msG6NAShqkkYrKrZCtxi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392d03f4-f6fd-418d-560d-08dab324420c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 05:22:33.6208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdy/6Z/BmI7ffJXIQTt92rgMc1QXHeq3n7GZ5pg81+4637VkbeysvvOV/94z3dDpa9YldLKN9Cac5G6WA9KV3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Boris,

On Fri, Oct 21, 2022 at 12:05:21AM +0800, Limonciello, Mario wrote:
> [Public]
> 
> 
> 
> > -----Original Message-----
> > From: Yuan, Perry <Perry.Yuan@amd.com>
> > Sent: Thursday, October 20, 2022 11:01
> > To: Huang, Ray <Ray.Huang@amd.com>
> > Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> > <Deepak.Sharma@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Fontenot, Nathan
> > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> > Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: RE: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for
> > AMD CPPC boost state
> > 
> > [AMD Official Use Only - General]
> > 
> > Hi Ray.
> > 
> > > -----Original Message-----
> > > From: Huang, Ray <Ray.Huang@amd.com>
> > > Sent: Monday, October 17, 2022 5:57 PM
> > > To: Yuan, Perry <Perry.Yuan@amd.com>
> > > Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> > > <Deepak.Sharma@amd.com>; Limonciello, Mario
> > > <Mario.Limonciello@amd.com>; Fontenot, Nathan
> > > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Huang, Shimmer
> > > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> > Meng,
> > > Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for
> > > AMD CPPC boost state
> > >
> > > On Tue, Oct 11, 2022 at 12:22:43AM +0800, Yuan, Perry wrote:
> > > > This MSR can be used to check whether the CPU frequency boost state is
> > > > enabled in the hardware control. User can change the boost state in
> > > > the BIOS setting,amd_pstate driver will update the boost state
> > > > according to this msr value.
> > > >
> > > > AMD Processor Programming Reference (PPR)
> > > > Link: https://www.amd.com/system/files/TechDocs/40332.pdf [p1095]
> > > > Link: https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
> > > > [p162]
> > > >
> > > > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > > > ---
> > > >  arch/x86/include/asm/msr-index.h | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/arch/x86/include/asm/msr-index.h
> > > > b/arch/x86/include/asm/msr-index.h
> > > > index 6674bdb096f3..e5ea1c9f747b 100644
> > > > --- a/arch/x86/include/asm/msr-index.h
> > > > +++ b/arch/x86/include/asm/msr-index.h
> > > > @@ -569,6 +569,7 @@
> > > >  #define MSR_AMD_CPPC_CAP2		0xc00102b2
> > > >  #define MSR_AMD_CPPC_REQ		0xc00102b3
> > > >  #define MSR_AMD_CPPC_STATUS		0xc00102b4
> > > > +#define MSR_AMD_CPPC_HW_CTL		0xc0010015
> > > >
> > > >  #define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
> > > >  #define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
> > > > @@ -579,6 +580,8 @@
> > > >  #define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
> > > >  #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
> > > >  #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
> > > > +#define AMD_CPPC_PRECISION_BOOST_BIT   25
> > > > +#define AMD_CPPC_PRECISION_BOOST_ENABLED
> > > BIT_ULL(AMD_CPPC_PRECISION_BOOST_BIT)
> > >
> > > I had commented the MSR_AMD_CPPC_HW_CTL is duplicated with
> > > MSR_K7_HWCR
> > >
> > > https://lore.kernel.org/lkml/YtX+uF/nAIG0ykHN@amd.com/
> > > https://lore.kernel.org/lkml/YtX586RDd9Xw44IO@amd.com/
> > >
> > > Could you please make sure address the commments?
> > >
> > > Thanks,
> > > Ray
> > 
> > If I rename that the MSR definition string, that will cause lots of driver file
> > change.
> > So I suggest to add one new MSR macro for the CPPC, the MSR_K7_HWCR is
> > mismatching in the CPPC Pstate driver.
> > If you refuse to use this new one, I will reuse that old one.
> 
> To avoid changing too much stuff at once how about if you give an alias?
> IE something like:
> 
> #define MSR_AMD_CPPC_HW_CTL MSR_K7_HWCR
> 

The mainly concern is that HWCR is for legacy ACPI P-State control not for
CPPC. I talked with hardware guys before, it's not suggested to mix them up
together. This register has been defined for a long time even before Zen
processor.

Thanks,
Ray
