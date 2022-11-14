Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6062770E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiKNIFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiKNIFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:05:16 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337D1193DA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668413115; x=1699949115;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rK64uFLUu4BQS6wSHuvkmtb0UELNOv6QwJzha/wurBY=;
  b=CUCunCM479v3gaS+XENeHWXPNnieTzKhQQFo5UriS2zo6sYx1eZG7Lrr
   d9bvt4pZm8gwuO5cC2t3LYPj0kMGL8k4iUQPIOwljUI4QRDlavip1rBDo
   xs0gtbOjuHMoX6CMYhG67uLcAfHUqE0g0JHLCn1qrLK9pZzmcXnB82iJK
   m3Ph3BhOcDMXewW1Rsd6AiX15KguhUggSzSt+ROLMkDFnjDaUcKgGHTog
   z9rpnL+yBZFGjRk6B6ForEgxfmWFeNfZyqCPNGn1hfOVTjb3kcX6cdSLm
   PidVogglplYk07pRl0H1ff1BEVl9n0jOKIMOaTQjzLfA9/nVWjBveKrjU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="313055998"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="313055998"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 00:05:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="967472615"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="967472615"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 14 Nov 2022 00:05:14 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 00:05:14 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 00:05:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 00:05:13 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 00:05:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCtDHjWFIsM6VBRBijRzz0/lQ7ZkdKDhV+SgaAYgjA7lHxDDJxQ/h0tgBPRe6ehnkrBMLkoW+ph6V/uWkBy9J6Pa1SBWRh5GCEzE3XYygS7g5SKoooow8lzhpc9qHf0SE997sHsj75K2F6MRJmWZc8ivdA36ZTqyqNfwbZE1G/CSV+XaSbiDDwWBicB4hR6K+gR3JM6Z9Srm3JJZjFShZCmVIj07xrVvBLNBIJl0q2yrB6EES1r3uJ4hnFHOAlOAGzZuJOzinCAO62ewflbGtHnxlTTYbesX1OIup2gTkPDAyYJM5EbRuR6IN6rShU8lLFDPjh74WzJghfypInOKcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IPuFUDnNDukgX/Tk3iy0IplDcpMFcURg5aJE2ox4/o=;
 b=m1e/XUP9aimvEpH3K9sgV54tAaKr+0lbsJ0PXRRzV2KpQaRTLvUR73+tg2uztHD5x89BQ1HR1EJHyIHQ3OwsFN92QOGOdykSQHsYm0cHDMpGSMc9hiIMtoLuYoWCqTPqFaTWn6a5FUZIrX4YSkj2aA6yg8kiu5i4nx6dnOr0t0K5gIn3EP4p92LovC/N1epvTa3FkdEN1GtwdCoEJljHAY2p6n9H3j4syY0l3whKShtDvSbQBtnUAbw+sEWy1DpWzpLfXVbEGjEchglVka7O3CtgJrc9bAUi4RVfXiJM+LSzN1SUlyWCogOThc3+byttyWTeXwifxjAQOI8B93c01w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18)
 by MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 08:05:10 +0000
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::296e:d1c9:648b:2aa9]) by SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::296e:d1c9:648b:2aa9%2]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 08:05:10 +0000
Date:   Mon, 14 Nov 2022 16:14:25 +0800
From:   Fei Li <fei1.li@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <dave.hansen@intel.com>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <Yu1.Wang@intel.com>, <conghui.chen@intel.com>,
        <fengwei.yin@intel.com>, <junjie.mao@intel.com>
Subject: Re: [PATCH v2] x86/acrn: Set X86_FEATURE_TSC_KNOWN_FREQ
Message-ID: <Y3H44Rdi5ari6fql@louislifei-OptiPlex-7090>
References: <20221101053019.174948-1-fei1.li@intel.com>
 <Y2kkk+XqBP3u6ObI@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2kkk+XqBP3u6ObI@zn.tnic>
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To SJ1PR11MB6153.namprd11.prod.outlook.com
 (2603:10b6:a03:488::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6153:EE_|MN2PR11MB4648:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cac9297-c35c-4424-0972-08dac616f378
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1xDqqPHz8xNsizb7oATxMbiC3FmAov72zcHzobjOfMYNH2LxBmuGdSgClzSWBIKyDQU5WIqo3nG6pOdKeVI4DuM6VpI3Y3HcXZ3701yG4pKbb9znJWDYmnl7JuC9F1YarXJVw0JXDhnEuwO2EKqnztuW9XMunF2ufn1LEN5P7OTcWGsxqnEX+bOfLpW90+muYKnHGe9Zc3E+Td4XBgv5GMjs+//04QzosIdhVYMLcLyBsF5xgKKORLov1v0VPVMmyM25cJ+zfMT48HU41ytx3iGhnnwKQD1RJNKFyLQ6kxB3oW2YCGDORmGYY2JdW/mIlmfC7cX9rfYa79Yp0snb/gEgGC1eXGpwYJWKD4zgTW9du/aipTdBiW4P45kTALMT2jjabmQab+fLyyFtZMAVaxQ9ByZB5uE9PkZm6fKnv3fXBRLaa9voSXt5uoEI+7XOv6o/fsrp+PAuMHYaev+bXoPA358hdSNkRlxpc/RpN2k8J8uOyiK0W68obNk6M2Y8HjLx+3iYOhqg1SP6dqHoT8fmAzmbDOhJG6wD0XtcroKmRXreFxrP1dsxmyudmRAX0y9zE6t2gZ0wOhaPsI45i5c0Z6aem0FARMyUR4KsehfH7Ss7LWqwGw0PLMhuFJTBl7wZ8mbI1XcYtr32AJjUcoOAAovc2fm/JK7ppl3A413oVuvxwliWB0p5k19EaNXnM/m6AmC/iiip/vnN+9ltBIxqlo/11YJoRz6Fkdi6Vk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6153.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199015)(86362001)(82960400001)(38100700002)(33716001)(2906002)(186003)(4326008)(66476007)(66946007)(966005)(8676002)(66556008)(5660300002)(41300700001)(53546011)(316002)(6916009)(6506007)(8936002)(83380400001)(6486002)(26005)(9686003)(6666004)(478600001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?46VMPE8hwgtqYNkHuSobZx96b2Ke56nNVi7d0Vwumv9Fza55JsbPGsMtSGOE?=
 =?us-ascii?Q?Tzf4bTjsltUXt07Ayl+Uzy+xQTnU3iNKo1KILIjWI3H/0yi95yEVHXxydFXT?=
 =?us-ascii?Q?dCDMu1NlaGd3wKon3wXeWIOrxTaVSS3aOVlarimb6qjrth4oXEym8AQrm5kR?=
 =?us-ascii?Q?Yy9Wx5fy8lWJ5GmUE7+JryaFbmtGSftgql/6QhdZ7x6ota4DixuZUSsBiAkp?=
 =?us-ascii?Q?mncnyptHRPsBXu7MIBuJ+UMEHqhJdOyi6CSheab7Ojtk7lhDExesAcr7ImA8?=
 =?us-ascii?Q?yA/F1jKdIWOvOAV8DdJCDS+129zuThCJAEkgtrnjgop1ym2HRouu4KYbeaX1?=
 =?us-ascii?Q?2pNXFba/CAfbVQdnsfdfyGzUVEPHvX7NC32UUxNQXf7eK0BR7ZoWKetYRcdP?=
 =?us-ascii?Q?Ey4IPbCpUHkXUGvGVLTu14oWPMkbjmvu3W3IfbffZuIRVFZUXRVOcseBsEL1?=
 =?us-ascii?Q?s2xHKWh5oeEIQ80TUYVRRKPtJMfqwavzTCiMtECo1dLDefMq1SyV/+1vExzU?=
 =?us-ascii?Q?qNPsKk84rEbRkNp3r8ppJe1pNzA6PRDoe85ghheMJ9IY6d1kUkBr+93BeadQ?=
 =?us-ascii?Q?iF2E3bD6M1720BCL9cjqq258eGoMdnYc1sA+I/pSh8sFpF0anHR7todfh5fv?=
 =?us-ascii?Q?gPMuEub6Y6jSLmr3cvSXNgTOmW5NThfxPMtcVEu7nZQVa0Z25+PD+FBbQ1Cr?=
 =?us-ascii?Q?PK6OBlW7kAYdFPetKEi/3lO7IuqHhP+I8mtEToUN8hP5riKompszq5wLLfWC?=
 =?us-ascii?Q?Y/zbHDKh+u4ZLAnjdKuC1h217H1KUAv7SyEcdFNGXAL9Vgv+Q4zukC4ycRqy?=
 =?us-ascii?Q?Xi25h6crHK7ylJLgRGOT9HhVC36T37yAkN4CkGJGI8/TkBBHPQveXj6b+XUO?=
 =?us-ascii?Q?t1mfwC4w4CQ2VRoypcYSaUTDREOXCpJ7HcUyFqIkwlHdwVoJis9UATnQxF6I?=
 =?us-ascii?Q?pzTJsxIEg7L5WYBBYgPFqvU6X/fQPZfcBLISoNiBFx4aZlRRRGzhpdgSeO28?=
 =?us-ascii?Q?0Y+DppB9QbtIKD6FoN5siBZD2PIUo/jAFDbpEIG08itLUssJTckd2Rk+QYN+?=
 =?us-ascii?Q?LS7DmwOk8MRc5bbGmA5t4pbmCDOUIHz7BGdffi1F3HZi0i0xeYcPWFavXSHH?=
 =?us-ascii?Q?xLDRlShW17ehYWa6XpmP3bgRFBx8v5tCf/+/mtTJc0/IywgPn8qgLTQ29jbc?=
 =?us-ascii?Q?ifUBZcx2x75PMIbClJyaQoedxFk6atY5DaWPk8dJ5TxlQzBi3m4VzSHTL6yf?=
 =?us-ascii?Q?RrASMp0TZ/YSeX6chXQcIIfW+WR9Gdcp9DizuCIKq7Er8I41Yph2EOLShXkC?=
 =?us-ascii?Q?J39sBCYgIJDKXeYh/5RiUeezABQMahuuE2UEpInGFcAqIcJM5h9DFc9el7Zy?=
 =?us-ascii?Q?nWzzbEZ1+DxAwZW0ERu63NURYQtZWpNwZnlp5e+xERNvnz1qE5D6/+RnWkcS?=
 =?us-ascii?Q?UIOkcXLxfn5htLnzSslgVFhmxNmlFsbGoAo70H4RN0m3XxmvsGdGugHKkegw?=
 =?us-ascii?Q?dxZgJvLnpr8NpR3EIC+6U7xKDQSHCZDLawr40mRdKn0W3ZBD9xCY4IJVwKTK?=
 =?us-ascii?Q?LTGuK6oTsnzU1vCyIHivhJStrxKxSBVCDzuu3S/R?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cac9297-c35c-4424-0972-08dac616f378
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6153.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 08:05:10.3906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YRGTD5dlcrIzkOFZG8Gjok7U9j9EBE/BlhU/PoAIcW3ppmgqcoqotK95eRk8wMKe53zZmCX8holLTjrsQlfZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-07 at 16:30:27 +0100, Borislav Petkov wrote:
> On Tue, Nov 01, 2022 at 01:30:19PM +0800, Fei Li wrote:
> > If the TSC frequency is known from the acrn_get_tsc_khz(),
> > the TSC frequency does not need to be recalibrated.
Hi Borislav

Thanks for your comments. So sorry to reply you late.

> 
> What if the HV has unstable TSCs? How do you handle that?
> 
ACRN hypervisor assumes:
a) The TSC runs at a constant rate in all ACPI P-, C-. and T-states (i.e. invariant TSC)
b) The invariant TSC is based on only one invariant timekeeping hardware (called
   Always Running Timer or ART). ACRN main target uses for IoT devices
   which are typically one-socket
c) ACRN lives with temperature influence on TSC frequency

> > Avoiding recalibration by setting X86_FEATURE_TSC_KNOWN_FREQ.
> 
> Pls read section "2) Describe your changes" in
> Documentation/process/submitting-patches.rst for more details on how to
> write your commit message.
OK, will refine the commit message in v3. Thanks.
> 
> > This patch also removes `inline` for acrn_get_tsc_khz() since
> > it doesn't make sense.
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.
OK. Thanks.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
