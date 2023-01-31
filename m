Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B0E683193
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjAaPed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjAaPea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:34:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8951E9FE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675179269; x=1706715269;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ppy019kkk85zCfW5O0nYMK8aqWNwQ+mq54dSCTeKFZk=;
  b=FTe8/pCeLtTRtZiApVz2Fj/e/bHM/C10ewIqx3bgdD9IkxirklQXjHhC
   kBs8y7bjxLrdaOJIimJ8bVCekoJrJjSSKlJFdKYELlql0zD4mxEiNE/BN
   SpAXRnokJK9vtuk7hsyIZt5VNYew3kzx3iGZVN0nfOKBwbXSGmZcJ66QX
   mVc+R1osEb8NzLxyauT6ciaUKezLPKlC8zSK8i2XLplFoAguuLY1VoQFT
   VpmmcaQkkmnNoGyPOJYkqzDhMsf9LfM4KHRbAvssOdZbpTBdtJRrxAdRd
   v3fPlMXF6Dcww7ynb+0Yh7L8NQNwRG0MIEm06ZcAvqsshv/Uu6J5nJZsv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="308213651"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="308213651"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 07:33:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="727993117"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="727993117"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jan 2023 07:33:30 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 07:33:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 07:33:29 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 07:33:29 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 07:33:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccJ5w2rWhjXGQblHEV/XrxiU85ApA0fvQYqTijzJGlw0rzWDXqZ08FdpLFe9Sbsu5Kuqwvy4uolnW3GbD0Itx1x/qPXPbOJUtpFrUsGtQau58C9YpQ6tZJRFCEqrK9aW7PHRpmn9MgAcUW8RzeqR1MoIWo7mSi37Ljce+ncEWw4M8gFqXon9iHOLYBGvcpHCyf+zHnmHOayQsWltu3d5ImCenC8ADNwQ/DgABO6ipdrj2hG95exVQyMxpgqDttaXPEgGQeDFGS7o+dJcwxPi1EXXJJP9QQD3f4C79SbAwSY8KaPRLgGu4KFH5Ys0Q2pUqP7RecLDb1YGze8x/8NN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9eq2J2hD9lOe9FGp9m0eIa9nkQm8QzXQ2cgPd9SFLo=;
 b=MrwSMD0WeE2mqoqkZeHLMOP85PdjCgrbvv0YlKXwBW2s7IbkPHAJhkP9Eh3Ukeovt5J07GctFXXTkWIZ9kj7PaWsJy3ealPoRnlEWy2VuriCrMhv1ZwiRfSGgfAn9Xlsf7xnLs+zDGZwV3t/P+1umviJGuqahIXUsYSxLTb6arvALVGiXzhYtKwlzPxORgJmfOMIsjuBrVN7MAXF9CqU6mHqXmqYAjO8zEnDQt+fgg321LzoR5/4o16ftHThotWF49nE4Mv83e0dRh4sTP+pK2/4IPh1PfQh9YYe25KGS2grKll5mSfU83NkdmaXYHFB1yukl0l5eD+/1TAYDMgpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by BY1PR11MB8053.namprd11.prod.outlook.com (2603:10b6:a03:525::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Tue, 31 Jan
 2023 15:33:25 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%5]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 15:33:25 +0000
Date:   Tue, 31 Jan 2023 07:32:49 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch v3 Part2 1/9] x86/microcode: Taint kernel only if
 microcode loading was successful
Message-ID: <Y9k0of7zHCzOgTaD@a4bf019067fa.jf.intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-2-ashok.raj@intel.com>
 <b6e8c90b-08ba-ccf9-8704-97c995722ea5@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b6e8c90b-08ba-ccf9-8704-97c995722ea5@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::18) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|BY1PR11MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba009a5-0e95-44ac-08d0-08db03a07e60
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymIuY06GFTt/J8XZjFXHTDZW12uqfgY7gJ+opIPN1RNRxqKkfixJU2dCE6pPZcTdscN5j1wVobAqEVDFVYyAT+owXa8ot62uH3uYFUrJ5I1X/YVV4owzCki88A9uBmganlfpZO2kxv5m+7x/m2VZXDAdYd8aZ0TwHw7cE8B+1zg/F0rpNz9KEvvZOYaQDkvwB/TPMWMYP/8H5AMO88T2CQSYCb9FevcFkGttJ9czAbA7VlxADl/JcnhTbTpRIYdiK3KRgMU7aXMpiKBCofKm/B3v0NdVxz2jrfN88WdgSoEDrhEVICbFsEn1qi2Brtnyp3glP3/HbnVZzsRYN+7K7GMON4oj5XveYwMdFhth6JUxvx0UMExZQU835GHuAA6dqA3CSzIt5NnY3v2uCWtjEisTx8ZtEtHAqGYyOqWf0JUV6Izv0pPkgtOZwjiy/Bu2DRWfVWQIACMPx7+hlmn04NXqrYKEqo5VxuqoT2copjMYo6f6szz+gQipTUwuBkOIWRHHa8fLD1jIC79k0svyAJ9+5w1zU7wUebPJuDIJaMpwUIRnWOWrr7fHCqwY3mjkpHkhA5VUk9UUV/+RnCcD6HWUzUkdFzV6o2elvE4sc5UCLtfExSCvrePB+aXOyP4MflctQpjcrC4i0kz/b/NJsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199018)(41300700001)(83380400001)(54906003)(8676002)(66476007)(66556008)(6916009)(4326008)(66946007)(316002)(8936002)(5660300002)(7416002)(44832011)(2906002)(86362001)(6506007)(478600001)(53546011)(6666004)(6512007)(186003)(82960400001)(26005)(6486002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a2wElCiIZPxm5oo4pdHllMwjJtnTzCpkAfTZg/5X+mGfcHMio6PCsL9+YsLn?=
 =?us-ascii?Q?h8JEa9RpBzE6uLJhkRqsfY0L9HT7Edbmy5Q7YbkpjjhQZMzTjB/A08yLF3AS?=
 =?us-ascii?Q?HFRdOlHe1kXkvsyR2bBD3B5WI5/T1TeKoWlvSNzrKKKfEBEaQndGCT0RB8M5?=
 =?us-ascii?Q?mT34G7OvQOkhSpNOq8lvuzIq0gubZaZMYQ7fjhLu+xAc5K440Jk4rwKpd+Xv?=
 =?us-ascii?Q?DgAW9bELABvcZzcolfNJh70nhCm4AAnQgeqdUZECCLFzXPmR6L+8dCcjBNIo?=
 =?us-ascii?Q?qGa7T4hnZz5J1r5LAAq8aGQlo4pyP+c06y2Kz2ad1OQj/AS1Nwv6xzm278oR?=
 =?us-ascii?Q?j1ziY9Xhq1YwK6jxXGkP/gsfKCjecvUupsdXdWjJNKXzngP69GKjwqE56MoA?=
 =?us-ascii?Q?EDSWJnd2+qGk7BTKmH12PemiZlVrbdVzmONLvqV2SG/Oruw6VC4dBOMhOLGL?=
 =?us-ascii?Q?tsn3CdvRX5527u0OGZgmTdU8JykxmyTsDJ/nE6pQ68rkeCTCWiE1OSJxImCv?=
 =?us-ascii?Q?xFViV463KMsknG67Lqkvo6+B0nK9AUHFNDSdrX5wNi3yab2FnATFuc+tpKgA?=
 =?us-ascii?Q?dLE2DdEYGL6A0OTgYmThO1rNsSAqen8ZwwC8PKpPp9O0/tZTTwlHrzexozkY?=
 =?us-ascii?Q?mvQUar0+id80QU3k37Zv4h+aU5txzX3WtqWKFwpg4LLRXUzYpY1ZvnWbSRt7?=
 =?us-ascii?Q?y3aElHh36bQZqWGKcJpZ+h+HgxCcSrka47HqJThBZABgXDiaPIEKF+E36TNc?=
 =?us-ascii?Q?KJ7PP7JVgqJv2PHwenoccTeRJbhX5vsihAqIdF1WqKrM8650O0M7ca/izmin?=
 =?us-ascii?Q?nhY6iMEY0MELyc3y/Q004C96YkQsj8ILw76v9X1GFjQ0+rPndnkaYiOKdia1?=
 =?us-ascii?Q?TAKUFu/QucvRn5aDf1wdxJ9lnyZZnvfxJbGzIWFcCxf3KTBrMh6V1ryFm25I?=
 =?us-ascii?Q?iRkJIApPXo2xZrFoFBvdF7SdzU0TY9dwZVCPiHE+oyPMKTI9oav7T464DP6W?=
 =?us-ascii?Q?Yphu0uP0ieCjE2IFajUx+y2rwM6wdlE+rCHKiHp+YtoJpbY44QosDAy992eX?=
 =?us-ascii?Q?X5oJgnaZW9lg+EHyvaKcXbHr2x8AYPacyFUM4jXqQ0VC5DDvKphbd70Jj3lu?=
 =?us-ascii?Q?i5ThOGvhwKZa9i9Cqw8cE1f+SO3d2mBq8+SWx/4gC3BPfhcV/6+BWaETgiFJ?=
 =?us-ascii?Q?9kMozAh4XxLoR5MxSHCPU6mspux+GWtLsTuKn0+BrXSbw/UVHXV+wkKVFemw?=
 =?us-ascii?Q?O/qCpIT85hKaptOAsq8ePPpdKI8AjJ/fT/pcSTtvzdnLMZE/Z5y3gFHLPWRb?=
 =?us-ascii?Q?GiIn0FAPL0CXz9BHHUzWUfxBnTGN1UKRDkLuJSOa2Uf4PHJkwt7Mm6PSWY24?=
 =?us-ascii?Q?rr+Rkfb3/ocj0/9EIxRDHvxUwqgUwcQM3aIdZcHbDOxxJsvFPlUefxZLd2ix?=
 =?us-ascii?Q?M0N44Jrvw7MWbb54eNeHJvMCHU9Po9wQoV/XpSvGwe+w9T74uREXdJbi1/o3?=
 =?us-ascii?Q?atUU1zByOQ2AnC8P3OgrvOUlrpZuQGwdvWy7KLw3571P9E1NdjmVkP4yqecm?=
 =?us-ascii?Q?VL8guU1YlN9Py9/pjgZlWPIdM6qfejtXCfo077xFttdQ16ilaWJsa1Socfza?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba009a5-0e95-44ac-08d0-08db03a07e60
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 15:33:25.5912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozMjMtJRR4H17IHtpGwZYsioEpR06nAspD1efCakmeATGAaNsCHJFMxjuKcjdxJP93FkVtfEBhWxr399BWqddQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8053
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 08:17:25PM +0800, Li, Aubrey wrote:
> On 2023/1/31 5:39, Ashok Raj wrote:
> > Currently when late loading is aborted due to check_online_cpu(), kernel
> > still ends up tainting the kernel.
> > 
> > Taint only when microcode loading was successful.
> > 

[snip]

> > diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> > index 61d57d9b93ee..1c6831b8b244 100644
> > --- a/arch/x86/kernel/cpu/microcode/core.c
> > +++ b/arch/x86/kernel/cpu/microcode/core.c
> > @@ -472,7 +472,8 @@ static ssize_t reload_store(struct device *dev,
> >   	enum ucode_state tmp_ret = UCODE_OK;
> >   	int bsp = boot_cpu_data.cpu_index;
> >   	unsigned long val;
> > -	ssize_t ret = 0;
> > +	int load_ret = -1;
> > +	ssize_t ret;
> >   	ret = kstrtoul(buf, 0, &val);
> >   	if (ret)
> > @@ -488,20 +489,26 @@ static ssize_t reload_store(struct device *dev,
> >   		goto put;
> >   	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
> > -	if (tmp_ret != UCODE_NEW)
> > +	if (tmp_ret != UCODE_NEW) {
> > +		ret = size;
> >   		goto put;
> > +	}
> >   	mutex_lock(&microcode_mutex);
> > -	ret = microcode_reload_late();
> > +	load_ret = microcode_reload_late();
> >   	mutex_unlock(&microcode_mutex);
> >   put:
> >   	cpus_read_unlock();
> > -	if (ret == 0)
> > +	/*
> > +	 * Taint only when loading was successful
> > +	 */
> > +	if (load_ret == 0) {
> >   		ret = size;
> 
> What about if loading was not successful(load_ret != 0)?
> ret has no chance to be returned as size here and we'll run into the endless
> update?

Good catch, we'll need to make that some meaningful return code to stop the
endless wait.
