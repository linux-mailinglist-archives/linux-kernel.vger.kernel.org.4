Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22314732042
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 21:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjFOTFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 15:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFOTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:05:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0B42137;
        Thu, 15 Jun 2023 12:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZw+xuzYpIV+7yKF0aAYMNuTKTjyaKSfZJTDbSlCjtsKEyzD8v290psPdCCmdjrcbUNVNVdIAbHOPD0OYgALhAdJ73/72Q9UDEPXI4vXDWtd88Y5+RqnSz97KXDRUsn1E+hIm4P2cHoAPYVXY4QahGuVPkGgKzO3FAlSsYd1XvXmgzuUyIHb2FHMM5f06D4AsIg4D6W14/f1+GKKhx7Zx4BIQkrsDFBNzvu5awstY0VaGSenVY1kgvFZM9zyA0/CjTbTip+1QwbOa/frN1Dvw5t/4898Y5YqUMXqaI5qcLlOFy8+3hyENaOhcwNsLmdyo9nlhFXj54Bp5n5ZrtYDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SIHScrXhKrZeiy/U3K8olxZKan2QHj7mQffe37XYdo=;
 b=QjuXEOSfsV8ZFCA/O2Lw8gkleVh7nHFWdM7bby2Uck9WZgOZ5qnlV0q6cR5kIlN+4pJ+8MO6ChCykp+0BB/AqLThk7wXBY/+GaY4jaiAeGk35MxQKb80u5gse2zOhyZ3TXpm/BbiABiozg1qZh0SUxmyYJq2cDOTnvn2zfCKnZGqrrHas95ajWzOFS8RHo2h6fx03AQxRAUomhMgCgVdwH/II66kl1sHIqTSZ6U8mq8u9ah5Ngsd4u5ktZLLwaGKmAHlw2TIZJKunQR+Vp7YcyKQhn70WvKESMeyc+TC/jcVy2LbninP/TVMw8Iz6UsdTTNB2bO1wf1iXl7hMtcs6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SIHScrXhKrZeiy/U3K8olxZKan2QHj7mQffe37XYdo=;
 b=AESyWivlQmczdCRNy1rbNT4Em6/qAS4Uhp3FTmq3P4lla/QtillGIKTZBcXKkD/M7oZVMDb3vBjVRu9V4vVRUcRDHNFGtBamdmPT/6g4Fx3xVX5eK65Nndq6MsN9c3LG3Pdd6TkiTvYZAGIWOcafwuykkdbqDrXWOSmFp5bfqhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 19:05:05 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218%4]) with mapi id 15.20.6477.028; Thu, 15 Jun 2023
 19:05:04 +0000
Date:   Fri, 16 Jun 2023 00:34:51 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ray.huang@amd.com, viresh.kumar@linaro.org, trenn@suse.com,
        shuah@kernel.org, gautham.shenoy@amd.com,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/6] amd-pstate: Make amd-pstate epp driver name
 hyphenated
Message-ID: <ZItg07DCRiUet+mj@BLR-5CG13462PL.amd.com>
References: <20230612113615.205353-1-wyes.karny@amd.com>
 <20230612113615.205353-2-wyes.karny@amd.com>
 <CAJZ5v0gfqGj9X=3bdf6X4HqQDxg+gCJN10DXLruYD5p3kZ59Uw@mail.gmail.com>
 <ZItQmjQHe/I9CXJh@BLR-5CG13462PL.amd.com>
 <CAJZ5v0iKokaEo6ANPO1cHUzM2UL3guf3WcWoVbRH0iNo8D_kDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iKokaEo6ANPO1cHUzM2UL3guf3WcWoVbRH0iNo8D_kDQ@mail.gmail.com>
X-ClientProxiedBy: PN2PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::18) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 571b516d-8c02-4640-962e-08db6dd36d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1d+x1LhOSzX/Nn6X5q8SMNDdekmUNAgiJr2RBkPlhYSg83k0pdUVw2WgQ42V5cwFHWI68EHA6Bog2+Q+80RGSX5izOiEnSW2UiVD41b0am/XlcbugSz7MHE1j4eviWV9+ekGmjTSidYFUv00Kw2icYaVYC5561MaMkZzRUyJsNRiTh8Zih+L8ShoctE5kb7jpHlYrcYmELMH6YCTEfXJ1ewIDW0ZrEMv8NTdAk4BjWy1hfbo1HFrO+5vHf1XyPUN1zNy6EcfB5v51PdNbAt3MEG7FKSOEyiqonugBlYy0667EamAT5T6d7r2jCcUxjVl/FjGDRDbp6doaR1EW7XmIVXY0mU3VnpEho9VtU2I0RBiLL/s6DSB7+DFYOvx0m6IxwNcBlFfJlrDoUk7Fu1XSdr0VHKO9XmhW7sxPg3cZnjcEtFX3DHqXspiU59wdcdHGu6W4fPY7yd0NhfRkwAu1Q5eGV/TSSABLwZAFfQP0gtrxRubiV0w878M1EftQygxtQvJ2+J+wVPGQlaUBrMDyFc8EVxr4Tae2uJa2fsXG6TyQ4yAe3jWZMDBfVGSsSYaHpIjj3rSHKyc7b797MrJjHsLmz9d1lKstd4GGe0GXQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(86362001)(186003)(38100700002)(53546011)(26005)(6506007)(6512007)(478600001)(5660300002)(6666004)(8936002)(8676002)(6486002)(44832011)(2906002)(316002)(6916009)(4326008)(66476007)(66946007)(66556008)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzR3OEU2Q2Qwa1JTR1hWU3JjVkd3VEo2YXRjU3RPSU1QOXZHV1BDZXhrT1Z3?=
 =?utf-8?B?SU5PTFIrSCtvM2pKVzJoaUdIRzBDZ2t6YjBKK0RvZWJzTWJQMnd4VkR2blQz?=
 =?utf-8?B?WGRPakRrK1pNc3ZqNmlpakI1WlZHODBDRDhrS0pSZDBRM3dDUGFBZzlVWS82?=
 =?utf-8?B?WTZMY1FxVWtzTWFNSEw5OFpSeUs5dG9Bdnp6QnNrTjhhZVVEbkdPRkFaVWRt?=
 =?utf-8?B?UGJhQ1BrODA5aC9VYVU1ZkxGMTlad2NWVkRpZFN2MDNiRWd0WVJZVGFsdC8z?=
 =?utf-8?B?L2FUajlwdUUxOGg0M1RERENEN2kyS2d4MksySDQvZ04zRTJmNXdTS21naTNN?=
 =?utf-8?B?YW1UUDJ2cHpueHRqN3dVRGNQZ1UzVkdZRnBBR0NoYW5rV3g3V1dHd2crT1Ny?=
 =?utf-8?B?cDFjTXQzdGsyUmlyb1lMYXpDbVd2Z2VlTjJpaFRSajgvc2RCc3hPdi9vM05S?=
 =?utf-8?B?MlZGWTd2dEpkbWpHZHZoVmYwWW1PNmNzbFNKaWk0T2NoUFNDS0N4eng4cFNO?=
 =?utf-8?B?MDF3Q29qajBmUDBTM0pCQ0wvU0F2SnovenEySjhQUzBONFhETE1DWTVHd3JQ?=
 =?utf-8?B?M3VmV3BuRVd2RHUrQ2pwdjJGYXYzeGxxeWRsMkE4WTg1MHNJa0ZUcExRR1F1?=
 =?utf-8?B?UkVBaktydWdISjdmNFA4cE5Mb0ZML05uMVgvaDRqT1k5U00yNDNnbzhaN3NQ?=
 =?utf-8?B?ZUhoam11VzVHcVA4YXV5K1JWTXp2TnM4V0hxRDE1VlhyTkpHVmhMVnZ3Rjdk?=
 =?utf-8?B?VFA4bWdHL1Z3ZlVzanJzaFVpaFpJbkZlWEVMcld0L3phRVVWWDZJdjJEMytn?=
 =?utf-8?B?V3FFTWtWeFV4V0YyRzFMYmxobEtnWjdla0EvWkM0RlF2VmpOSTk0Vi9wZFhF?=
 =?utf-8?B?dUQrVnExZUJHSWl0OGMxUXo4bzc3Z09UZnJqTkxCYUlueEZYdGlUTXY2YlBE?=
 =?utf-8?B?ampYN0hRcE9ubVVpU2ovMmNsNUZHY0JhUlE3dzlWWlg2VXFZUFkrRHhBaGRO?=
 =?utf-8?B?RWs0TTBHblNoYkJiSHAxNm9GVHJkMHdCVUtzS0wraHJ6V1NyaHpLTDdFeHpC?=
 =?utf-8?B?Sy93Wkx1OVJJVHJjNE4rM0YyWU16bnhaQnAyMGVyWTZXVEVPVnR5OTRUQnU3?=
 =?utf-8?B?alArZmpvcHc5RURDYzR4N216b3VlT3dQYU9vRGRzNS9mYzJVTWxMNGlkcHZN?=
 =?utf-8?B?YUJ4S0JlaHJCL28wZGJyaUZTVTRQMmxDdndvd3JxcG5aWDc2TnplY0VuQVdO?=
 =?utf-8?B?dUNZWVE3TFRFRkVTazJrcFY5ZUpiNjMyWjN2VnNWSzhPZlRNSW01OFF3RzhZ?=
 =?utf-8?B?Q3Mzc09nMjRiRlc5bWd0UzQ5SjliTDU4S3RUNkl1RkFOUjdORjErYVRkS2hH?=
 =?utf-8?B?bDhDQW44eXlUOUdQT3RrYUtYdUtlWitwRUIxeDM1SWx2eXFJQ2pFeEtsdk9M?=
 =?utf-8?B?cUwxbmh3b2dIeSs1TjNxSjVIbVJrTGkzQ2ZISkpnakxIeWlreHM1S3kxODBK?=
 =?utf-8?B?SENHYlpoTHJxa0J6KzJkTUoyODRrbDlwV0ZCdjRVRVliSi9YL0laSjg2SFZJ?=
 =?utf-8?B?dEMweENvY2V6THhyaGRVSVM1VG11YlRpU0w1dk5JL0l1TjdiS1p3M2V6NkZz?=
 =?utf-8?B?K0dTaWFhMURWZS9MYVlseSt1MnZCdE9GaUdxcW5yOGNDMzgrR3Z3aWMyMnRt?=
 =?utf-8?B?VFcvb0dpQytyQzdZR2U5Vks0SnU5ZSt1aHdpTmMrUUxPYmh5NDhBZ0Vzb0VQ?=
 =?utf-8?B?K25YNml1QTJQYllMdUpUREpzVVVOb2YxYjBwU2FhN2JLSHhUN1JpMVN1NGNP?=
 =?utf-8?B?ZTZ0S1pFbDFORExTTkdGNEJLc1AzSTZGaFFKZFNLZThCSEJPRE9XMDIwVmI3?=
 =?utf-8?B?SStOZ05yWFpPMlNPWjdLQ0p1a2Z1bVdhY2hETTBFVGpmbTlCZkJWT0Z3UnJ5?=
 =?utf-8?B?Q0NxcStac0E2QkhVMnl2ZlVSUmJEaTBobWpWMXZDUlk5K2dzMFlOT2VNOHV3?=
 =?utf-8?B?Z1plOWdUZ0VGWXRWalQ4aGgrV1JseHdkc2w4NzF2ODdlSGFzcDhyVTZ3TmZF?=
 =?utf-8?B?T21jdktGanhvOExVSmVJakcrVHpMTTMvOU43WjQ0ZVp3dmpGL20wN1UweEhO?=
 =?utf-8?Q?kyOZ9qtpW8efhRWizP2LT6dk8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571b516d-8c02-4640-962e-08db6dd36d76
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 19:05:04.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/rAbRAUPVpjIuobg4gOZo5ATyhbFYTr0JH4aWl3ARuOi8aRS0JQrroeJsZbBZ58BlLl++Z9IzsV5hxgBdVVwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jun 20:30, Rafael J. Wysocki wrote:
> On Thu, Jun 15, 2023 at 7:55 PM Wyes Karny <wyes.karny@amd.com> wrote:
> >
> > Hi Rafael,
> >
> > On 15 Jun 19:31, Rafael J. Wysocki wrote:
> > > On Mon, Jun 12, 2023 at 1:37 PM Wyes Karny <wyes.karny@amd.com> wrote:
> > > >
> > > > amd-pstate passive mode driver is hyphenated. So make amd-pstate active
> > > > mode driver consistent with that rename "amd_pstate_epp" to
> > > > "amd-pstate-epp".
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> > > > Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > >
> > > How much does the rest of the series depend on this patch?
> >
> > The rest of the series is independent of this patch.
> 
> So it should have been posted separately as an individual fix.
> 
> Please resend the rest of the series without it to avoid confusion and
> I'll apply it for 6.5 tomorrow.

Sure, I'll send rest of the series separately.

Thanks,
Wyes
