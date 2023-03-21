Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832036C265F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCUAeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCUAd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:33:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC7D13505
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679358838; x=1710894838;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=efbMFktK1DcBRP/1JQ9EjystULo53BcWWHVXNvhSnmM=;
  b=adJsghvpAKxi8RdpyUAcXb2FdKs7rtkV9e7H0IfGx0bCuBYUB57zr6v+
   Wjg/7ibdlpJCTw+XEgJ0CnnVA8ysJFzS34E4TjJRtTmjXKtDYeLxGAija
   5+TmDIr0WLGUQNhqA0yK6MjLpDQV3rwhtxfanK+FguvLmSfU+5AubBvW6
   1u21XIr5zKKSSBoeyLr6Fm0z1gIiJhWYp6RiAfz/v5a5ZzNr0PhcWYeOm
   poP8hlVttq2UE6MNlJD7TmrIGgUin5PGo79gObKJ4FgVUwuSEbZvOur3T
   UagFW/NJjP270jmZeCxk6tbBcUV0b67yMzefEydC0zL8b0lFbr1HZyl6c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="341170321"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="341170321"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 17:33:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="658567605"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="658567605"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 20 Mar 2023 17:33:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 17:33:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 17:33:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 17:33:55 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 17:33:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsGQL78KZi9+k/oTb9DTM4y58nC1WQQdkBZNpTLrhTf+kl3f8f+44djnCN/ZUfinMeg5GhiMvQf21aPiZh5jix8ZFKWEERuWw7BPOyucxJRLdxZwVBxYBcBWvwFUVRffaixhgnyvoc1RqjFAUvk3B7lhOWnBPZkiKukosZ3nCWPcnCplnp7eAGqUJhRg5yHDYFdJBxniFieV9E47RfMm2LJHHcluCVWaJy4UhObGo6yGX0JN/+Mx5NujMkTXcfJXiitLICN2ElvMGxHSke7TvP65QyaaUPNA8uIeEzG2y4n5doqmea0O5IVbh0F2iKFRQvXR7VkSB1nrfB8hzsN06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWvM85d2gdA4F2qOrog6NXPJwe/6gmK8mppyvaM2iks=;
 b=E3lIbu+dSBimlJT2gXLDFvSPWuwPMDfpV49IgpgyB7HpBFipQ8CePqB7pq1AEyeKJtOxiP9keEmBnkwuEpp76NV7b1lBRLoA16ZxWoHaAPcug9DFB7oZBH9CyhXPikgPc3i8W6lfjOKMtyJBvX3colzZsaBsVhTl6zUC2M7ui0AcRAzhPUZnxi9/96EG7QbRm1d2ZH34sAhbGpy1+Q6MjLeXzPZrpZv9QNA7ppUHs/kdCaWXDNQLc3y86uciT8ZxVhvRabuuhqLW0Eo7XXELZTCjMT1A+HWS5+TAyaNXChGacXXaDpSQRniAvtCV3ZUb+dFJUKF/TvzE0uO5w4tgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB5775.namprd11.prod.outlook.com (2603:10b6:303:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 00:33:48 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 00:33:47 +0000
Date:   Mon, 20 Mar 2023 17:33:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     <outreachy@lists.linux.dev>,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <greybus-dev@lists.linaro.org>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] staging: greybus: remove tabs to fix line length and
 merge lines
Message-ID: <6418fb683bc37_2c7706294e3@iweiny-mobl.notmuch>
References: <ZAusnKYVTGvO5zoi@khadija-virtual-machine>
 <640e75cfd8fc_229a89294a3@iweiny-mobl.notmuch>
 <ZBge/v/K/BOVkl2V@khadija-virtual-machine>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBge/v/K/BOVkl2V@khadija-virtual-machine>
X-ClientProxiedBy: SJ0PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 524a68a0-8dfe-40e7-d602-08db29a3ef61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22IzoVbZtLiCtoJsenbGhf4s6loKyB0la+0Yfwyyj5E/Gn9F2ZBtNloXon3/fCij0CzxrmUCpY0maJ+cKlzXb5dDN6pUgXGoTyzxLfnAbmTSXhB7XUSK7A2EXYJPcVUMimL4rSMwkV+7u+QBZ3IUhhhmQ18y+yDeA4ZLft61TqbRIYGf/tE8agxK3YcLM15Ei6igyq8lFtWWcOgIn5YKKpa0Ff60sl56ykFDrq6u4yWrHwqrwhIq4HeQMau4PGBtAFWzktWtiGHvEUk072tx/qnLNsfwLYg6bHesq0nLd+coX87WKFb3wkCV9uoN8vz8mI49Lvdo4Y6wrW9Rd4nu+nfXOXw9xvQ6U1Z/gravUYyFdXTH1GpaoUoRWDOZdTfsp7ySuA2Ryusi+GltbON0rfXVr2pepXBw589gEo6w8bi30KauDJ1bZUFPCIzakkGQbWHCCFllqx51PdOTZ91PMnIg1ScAG+Emyw2dwas+y5HCJjt4846Ao86D3YZO3LrLrrHKgk5yHiphY8Kku71HzAp1nchAx9Gdh4huO2FHMUrUewTTnwQkjenArbf1+fRbpdQIl+jnUjUK70NY5y4eLxHWmB/x91J65BkFi+mUxVJ9FPcbt/79eE8JNX793skKE1IAp50pW7Y6f0KYKz84QtvHOTCq6IFY7rGJscdzHAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199018)(86362001)(83380400001)(66556008)(316002)(4326008)(66946007)(478600001)(8676002)(66476007)(186003)(54906003)(9686003)(6512007)(6506007)(110136005)(966005)(6666004)(6486002)(38100700002)(8936002)(5660300002)(41300700001)(44832011)(82960400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGFDV3N6N0pmU2owTk4xb25ZN2Y0LzZvU1J2ZWFRL3ArcnVGNWljc210czJX?=
 =?utf-8?B?RWFETGxocGw0cXowejkwZ0Y5dmZBeE5SWkFtM0lEN0JpSExEWHR1cmkySm9Y?=
 =?utf-8?B?VEdibWMrUzNMV09VQ2l1VGppNEpneDNucEUwM2VpYUtESk5ocGxKL3hpOUdM?=
 =?utf-8?B?ZTB1Y0twVGJxQk85YW5vR1lQcE5zeGJGeG5FTGNMYnJsU2t4THp5SEl6cDFB?=
 =?utf-8?B?Snd3R2NObTVjeDR0Yy9TTVJlMXEzbkdsZWkzK3JUNENVallZekp3TGhVaURH?=
 =?utf-8?B?SEdxL1NFUkZWZkIwdVdJb2MyZFEzcm1HelFEMEtKTmtadEJsSDZlRCsyak5z?=
 =?utf-8?B?czlJTDlPcjVmOG9TT2F5aFlUelRzdXZMMnpLY0JOQUpqckFoRnRWekZBM2s4?=
 =?utf-8?B?dFpZZzFsM2JlenhzbFQvRW40bEUyZjZ3bGJrVld3OXZyK2VhWGZ0MUxIUzJR?=
 =?utf-8?B?NjB3ZEJGUGlBaXBWNm0vNGRNQkJjNURNcFRmOEpOSnNrbWx6d0lKUkM3OXlC?=
 =?utf-8?B?V3ZTUEVCVGV2R0RSTVloTUpVOTU0Yis5bTRyckp3Y0w4TlFRdGpEcytNUUlJ?=
 =?utf-8?B?ZHpLWFZrYTJQOWJDOVVEN0c0MC9CRjVXTVJkN2NVTEFZNnVVUWNOblBKT0p6?=
 =?utf-8?B?SHdvNk9iTkZoaXl2L1BzUTlHbCt2cVd1OWVXNUg2bFY5REdGWTVUZUFuVEVk?=
 =?utf-8?B?RVhKb1R2dVB6d2U4eEh2dWVLS3hTR1g0c2RQMVpDU2JadGx1ekgzbVFQWnZ0?=
 =?utf-8?B?ZDZuOW9FS3ZyOFFUZVF3MGxVaEJBbEE3K1BRdlpSWkxYODVDRzZINXIzR2ZK?=
 =?utf-8?B?bEhud2VBd3orbG1QZFlIZW94dUU0Rlo3akQ2RHdidkd0cno1bTVKSzFjS0Nw?=
 =?utf-8?B?aUdDWmZSVFhicFRsbE14azM4cnJDbHBrZEl3NDNZNjI2Yklvc09mbEF4czFH?=
 =?utf-8?B?S0RVTGV3UzRWNGVLRXFXTzUrKzlDeWx3YUw0YmVsQzRHU0NTZjhaVHpKTlg1?=
 =?utf-8?B?YnZ0TkkyS09oVEM3RVJaV0JYUHV5Mnk1aWZlTkFicWx3SllEQ2l1V0U5WUdN?=
 =?utf-8?B?MFkweU5NYkNwM3hraVo0dHYvb1lPc2RtS1BweUJDTytwcFZBYVdLU01sOHpW?=
 =?utf-8?B?MXc1TlloVml4Y1J3U2xqRmNhcFl0aXJiL2FpUlJCWWhSU3RYZXNEb1N0T2dX?=
 =?utf-8?B?L2VsajFBYnVSN3NMaVhxaG1QZTVoZ21jamJCcFR0ZXdiYUlwVjFGcFNtblho?=
 =?utf-8?B?U0ZwOWlrbkQxWkw4ZzVYaTNreU5FUXJZYnFmMHNzZG04WWJwbVNldEZPbzVR?=
 =?utf-8?B?UEJBamtKMFRPaGVhK0lBQTlXc0FSaXF4WCtjN1NqOUdaM2x1dThJTFlWTW12?=
 =?utf-8?B?a3dZVk1QWmVaVGZRdkE4QlVFOFRtbVhCcXloY0V1NkMvNWJobnQzOUc3dTFk?=
 =?utf-8?B?bjBTQzlzWDFNOHhialRiK2lybWVCWEZTQWxwWHplRXYrSktrT2kreXdHVkdL?=
 =?utf-8?B?S1FaUG1IQU93Vzc0RkcyZlJ6aTVWanpCTWV1dGRtYVBld0tDMkVqTnRrRVNR?=
 =?utf-8?B?Tzk2SDYxQkFMOE0rRkFjQmpMbU1Xbi9TWG5ZT2V1cGJuUGp2WHRoMC9tYXVk?=
 =?utf-8?B?TjViOGhvNTRNUUZJZjlaNldML0NHNlFJek12OFI1a1F4V244TjAyY1luOFhl?=
 =?utf-8?B?RXRuTjN6NHA3OStKQ2FuWXFBVnNCeXJZVXdhcjc1OU80eFFQbXYxVVlTRExU?=
 =?utf-8?B?R3l1RTFMSHpOY3JUR1NiMi9yWmVCRC9GVTBZTk0rTU5nbDUwNTVoN2l2S09Q?=
 =?utf-8?B?T0JtZElSay94a0RGK251STVYQkpPTDc3WFMvK0loU2hVSzhpc2Y0N3B5WDJa?=
 =?utf-8?B?YzY3WVhLcHpVV3Q3bEVIOHdqRzJsejJBV0VielBNMUxIRy9waG5qYy83TDB4?=
 =?utf-8?B?emluaDVjMVVzeHhMUjJmRHJRZnZsWXF1SXU4WVdRazBya0xscHlVaVRBNTlI?=
 =?utf-8?B?aDdwN0JHZlU0L3ZLak56VUMzR00wcktGUnRkSTUwajAva1VvdmJaQUc2NUlq?=
 =?utf-8?B?eXQ3Und5VzAwb1pWR3U2YjJZcjMrdmZLMm5MbWh1N2t2eGoyamt5b2Q5TGhp?=
 =?utf-8?B?UFBsQXJ4ZGJGQm12dGN2Tit0YktybFFWRUV1TnFsbHFOM2RSbFB5VGVjR1Zh?=
 =?utf-8?Q?dA5G11yS/dOMtZeIUvdYbLWU4rRWXIkdj97EQ73cyZ6f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 524a68a0-8dfe-40e7-d602-08db29a3ef61
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 00:33:47.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1C40T0un3m/sdi/yYKBx7XG2OxhqxBl1IEuALGQLenQkz1g+I8jiJWA1cSarkoYz9GpNZ6+DcPrHosdw7mzSyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5775
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khadija Kamran wrote:
> On Sun, Mar 12, 2023 at 06:01:03PM -0700, Ira Weiny wrote:
> > Khadija Kamran wrote:
> > > In file drivers/staging/greybus/arche-platform.c,
> > > - Length of line 181 exceeds 100 columns, fix by removing tabs from the
> > >   line.
> > > - If condition and spin_unlock_...() call is split into two lines, join
> > > them to form a single line.
> > > 
> > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > 
> > Fundamentally the problem with arche_platform_wd_irq() is that the
> > indentation is too great.
> > 
> > "... if you need more than 3 levels of indentation, you’re screwed anyway,
> > and should fix your program."
> > 
> > 	-- https://www.kernel.org/doc/html/v4.10/process/coding-style.html#indentation
> > 
> > I think a better solution would be to refactor the entire function.  This
> > would make the logic of the function more clear as well IMHO.
> > 
> > Here is another tip to help:
> > 
> > https://www.kernel.org/doc/html/v4.10/process/coding-style.html#centralized-exiting-of-functions
> > 
> > Do you think you could try that?
> 
> Hey Ira!
> 
> Sorry about the late reply. Thank you for your feedback. I have looked
> into the above link. Are you referring to the use of goto statements in
> arche_platform_wd_irq() call?

I'm not quite sure I understand what you mean because currently
arche_platform_wd_irq() does not use gotos.

But I think you are asking if I think it should.  If that is what you mean
then 'yes' I think arche_platform_wd_irq() could use goto's to clean up
the flow.

Ira
