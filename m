Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951B86497A9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 02:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiLLB31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 20:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLLB3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 20:29:24 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4ED65A0;
        Sun, 11 Dec 2022 17:29:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOrjdzEKWSlXes/NIIJJvJ3rrwcEPlZZ6PBU3OG5e1yu2D8sGMVMVjkkkng6yd1UI5Gs7XDUKqFG6MYVBh5CguXuCl2TJWaxdBAzhGDFlU/xE2n7SQaptz4Za3Cn1JRZFcaDiYGzHgnxjB/bqt+VJpI4GtqxUs/Krne1o7boAf9AnF3wEkyF8RerZI5isOuHqpfA2A0T0kCUc/04hGNV4hZ6d+Plu1xjn0BCj+viiO3AcitGS24/XTt1pldBDq9j5ash1/Ny76u7t+nt/PRKj647JcteCrj197+GRwaZhZrcWSAaro9LqyV88vDwH4+4KwHQwAmVRzge/g1HiEZAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfUUSlBDuku0o7ju9+02eHfs3hcXdq7SC8XqHFh3Vuk=;
 b=AkFmD1pi7xm4yP0ukmlXb9ruRoSGHcYl6EVSlWduu9fDttxVtt/Cs8BI0LV+Ly/XeDs8sjHT6NN2ykRhPsjKsP0Kz5esIuVYXhh4Lk9tUB7jSRckpgDSrlEVIFYpcpGSHmbifLpkvMVxmNhsngSebMCGH+TzWAg5R/jqn+0Wo6TdSAgZPBg5OivYXjGyT2wtWCwMMYd6xH40XntY/gtuI9e2Z3V1NLS0g2aoR10qng4Vuf0pmc9M51xx8MOo3u+Mkv1DjGql2Kzy+3LiYdnod5Gl3Cx0a3HpGaduLKsDNstS3lFla1SgShjSmW+pkwg2okbkG0v9HQs1Ce2/uDtqyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfUUSlBDuku0o7ju9+02eHfs3hcXdq7SC8XqHFh3Vuk=;
 b=GRW/LZrwn64xpGAjPU2QpCsnlqsrMBwa22IahnAGlS+CsaOydwaanMxfp9iHGx8bOFCgAt0L3SMmE4IzYzuggdjtLszuKp8L/rrQ0qaxXtk8UYl+/dQRgJWwWYyZrcnimzQyiLTn80cySswcMHAOG/7Zi3hn13Gr4j44+HwT500=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SJ2PR12MB8157.namprd12.prod.outlook.com (2603:10b6:a03:4fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 12 Dec
 2022 01:29:17 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Mon, 12 Dec 2022
 01:29:17 +0000
Date:   Mon, 12 Dec 2022 09:28:53 +0800
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
Subject: Re: [PATCH v7 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Message-ID: <Y5aD1YZtDhQcm3H4@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-4-perry.yuan@amd.com>
 <Y5LrVdS9oFKIvC70@amd.com>
 <DM4PR12MB527803DBD30226646B81A7E39C1C9@DM4PR12MB5278.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB527803DBD30226646B81A7E39C1C9@DM4PR12MB5278.namprd12.prod.outlook.com>
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|SJ2PR12MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 3181de45-a660-459d-f5ba-08dadbe04934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6uJ2MKwG73ANS423swGgblhSru/RRrvMWSIcU7UB/3AmIGHHnBT87cBWXDPR9Q7uOAhb26gJN52KmiIiONkPRM1VhlRPn0/5xnsURxROz+C9aia8TLJv98iDcr0qLjVTX9q0USReQMBbN8fd7NCJC7TXCqYditQuJ5JeosK1N+njbDf8B6ADd2rPYJufXz4q3gykHm4+FriN4Ht/jJXCqdIc5tAZpv7D24BvEMsZjwutciQCb0bzRJmk34DB0YeZWIytdmX0byJl2uaI1kQKsosaGDzsk7fUPfYmSwZ/FwelnWzwF9kzayu0QmCsoXmLuDXpg7FqUF+FiuqqKhu+W1FmDjZeii9A6wk1JqWQONW4E5Vw4E8skicUIGQ6T3Y12zyYZMeyRd6v9RXJn7EbwwAgFx/om/Q9jnNZichiYYRs9HF4u9REsx7lyGxYAJ9fGC11cshAEJ+u0yo5OyXi0VGY5mlIsJBEXYbw81j4coLnXYWAj3KSl5/EIDcSR86gv656GY6fu/sm8Za7AVPiDhTyuGAyPu5m5ToDNuQKlQs0oVV45AGzF/N0OZHaD6nPWCcSKDCKht6DRAo3LYyLFHGGzDozK3AZYPgjVKXch29Ps5zSCPp6Kcj9ZFnKveh3/JhRpz+MzD/w8ojWr5B9J+anfYGuaL9ghw/JH3Lu64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199015)(6512007)(478600001)(53546011)(966005)(6506007)(26005)(36756003)(6486002)(86362001)(6862004)(6636002)(186003)(83380400001)(41300700001)(38100700002)(2616005)(8676002)(66476007)(6666004)(66556008)(66946007)(316002)(5660300002)(37006003)(8936002)(4326008)(54906003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D1mgxSBr4Qi8wxB9y3jaYEz8uKFJs7PLV/5K3NEexBRl3hRirLpTU96zRtq+?=
 =?us-ascii?Q?qFOb5r1nZSRzQNWsKncgrvya5CSavI5gh4CL2FDZ/bo9DVvkl7MnuKfBtzl4?=
 =?us-ascii?Q?mawJrWrg2Z4Jm2RbS2en1y8v/v+qKPuOYGq6RfCmPXVPAMGkX5v5iRzMFPYt?=
 =?us-ascii?Q?cm8NCcfMkyM72HBuKGeynyl2mTc3PfqGqX0sD7sytc9xWlaLK+ESLWgoklFb?=
 =?us-ascii?Q?8BM9Zrwt0esNUmCH9ik4zv2Xyyyr/ClW0ULOiPWn2CwYQYvLtWUKYlP9033W?=
 =?us-ascii?Q?qaPEBEnramWlgeU2OBEAdcMl04xj1U7s8XmJrUiAQsU1L+vjUAGMV2AihYgg?=
 =?us-ascii?Q?q5OpvpovijsWcCueHVjFfnVHDP6sQtCmtrdhW/Q2waIiATma+OlkwMjanV36?=
 =?us-ascii?Q?5Ging1mHqYGwNX2x7gI/XSIEQMENW87cyBVUn+dOHGmDCsXTxF0AlF68e/47?=
 =?us-ascii?Q?SVB4+XMMlFwuV5oAQoY0ZsguEA8lbNkIHaC2UKqmshVgPrBs1iN2/D0lRMSz?=
 =?us-ascii?Q?igwOpwPQoQ94KcCM60MsIP4vLcImRkzFw+9pNKtyXhiFU75d2cpM+w7xylSc?=
 =?us-ascii?Q?cXaZ1JTiDOuQU6ZzCqMlL0dv/sIM492xoOl+HrWPSRAh2OqJOngmFu9SSRqc?=
 =?us-ascii?Q?Rr2oQ3hYkQLBN9GkD+IVuMxcnVTg+fbpAj4kaMYHFCDIRSeFTIoPzBY9Etb+?=
 =?us-ascii?Q?/mVW5A4LW6jzYcfY5zuh3ElAhBW7Y8i4GPfAMFUAZCLrRIkUHEHyrAQ6DEP3?=
 =?us-ascii?Q?w3pw/xZqfa/+bVthLxxHs3MnaWWsnXAyDyEsZDLrKvmvNkx2utkRGan15DMs?=
 =?us-ascii?Q?tWNT7wI0xM6m+dVdYwUWMA1jXE9q3AGcz6AcmxFdTYMrUgDRUi6+kNuQeY79?=
 =?us-ascii?Q?DGSA/kTOn9yzYqHFtr0JX/TTQ5NxtOE+9iv6cn7lskhuRcDgklI+EGTgp8sN?=
 =?us-ascii?Q?6gpLUpJ/973GTrzlL4R/XiwHsakHDgfq3bkDRlEOHERSKGyvKU5/WaVdHwf9?=
 =?us-ascii?Q?lUu/UCAUpRI2pK7Jl+RR35EXRHWV7VqHnhYcbbddXa9PjhEWed6IF8i0H0md?=
 =?us-ascii?Q?lBgXb8Qnb3ESGfj899v6SQgRcZdjYpI2p+F13Iqv3fp1KZu7nFyF6SunPSRs?=
 =?us-ascii?Q?3CsagaOs7LccNSBiDruzxyw2NIxNsDxp2bzAa4Gesz+epPVUr8uVzvp9erYD?=
 =?us-ascii?Q?v3gx2tgdZazqhM1Dm5GjOu7ArNXzbX7nhXveSA2yo5ZIzOJ+jrVpy+iVMDO/?=
 =?us-ascii?Q?oElbS5oYsYzVK69qfRln+e1Wmhthzv+WpSbcxuk+dxgjSciR/irOetDHTOHR?=
 =?us-ascii?Q?C9ZWlaBWDd9ZmGi2dNwS6yO6Mq60ELaXu/c3V3LvJVdSU/JZSyvugg2MZgDI?=
 =?us-ascii?Q?XcCtD8pP5XeiqQfYcoJnqbQN5sRw8xgtI8MPAAMYPDdI6B/3pPSAqKFKRCOC?=
 =?us-ascii?Q?rkntuWYo7MP94lDo2dGYg4+6ooftH0QSJjcP2kpxRLVFJNT43FJ2TgmTyb2a?=
 =?us-ascii?Q?nt/PUN1nNRHJRMttLXNOKzzfCgNzQJK74IunYwNPO7qN8qI2S+ORDqOesd5J?=
 =?us-ascii?Q?kj7sNVRJHxzj0aVJrV4BZXVDn35Wy750W1xFNGng?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3181de45-a660-459d-f5ba-08dadbe04934
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 01:29:17.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lW8kAGpXEYVyEydSg/7eMsQa/ZymGtAaB5rZ1TCnShT8aavW5jM8HSWnqfbup3b0vvTdz+/dNbfek1qn/lGvEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 04:54:54PM +0800, Yuan, Perry wrote:
> [AMD Official Use Only - General]
> 
> 
> 
> > -----Original Message-----
> > From: Huang, Ray <Ray.Huang@amd.com>
> > Sent: Friday, December 9, 2022 4:01 PM
> > To: Yuan, Perry <Perry.Yuan@amd.com>
> > Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> > <Deepak.Sharma@amd.com>; Fontenot, Nathan
> > <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> > Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v7 03/13] cpufreq: intel_pstate: use common macro
> > definition for Energy Preference Performance(EPP)
> > 
> > On Thu, Dec 08, 2022 at 07:18:42PM +0800, Yuan, Perry wrote:
> > > make the energy preference performance strings and profiles using one
> > > common header for intel_pstate driver, then the amd_pstate epp driver
> > > can use the common header as well. This will simpify the intel_pstate
> > > and amd_pstate driver.
> > >
> > > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > 
> > Please address the comment in V6:
> > 
> > https://lore.kernel.org/linux-
> > pm/Y43aq2gMKnFRIhxh@amd.com/T/#md503ee2fa32858e6cc9ab4da9ec1b8
> > 9a6bae6058
> > 
> > Thanks,
> > Ray
> 
> Talked with Mario as well, will fix the build failure and get this changed in V8. 
> Thanks for reviewing.
> 

Please make sure you addressed all comment, then send the new version of
series.
