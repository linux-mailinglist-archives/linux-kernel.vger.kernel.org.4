Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641916D8D98
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 04:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjDFCnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 22:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjDFCnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 22:43:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFF15FE1;
        Wed,  5 Apr 2023 19:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680748998; x=1712284998;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qoq6CHXzbAkQGOmIALe3WlZ2YVNozz+vPfpWYxM6ogQ=;
  b=dIE986x+qyvbmkB2x4b8DnxzijZirY5WCEuAhTnnnA8QiojR522+1YOO
   vw1nBTA3eYMyZRqlagdsw+8IdlSzXymPysw1nzbHQ1w5Uawz6LDoM4rDM
   UQwMJnD7BGmTIarK/uDJybk75AvxPd9gfYSdC4n1e9VkKZ5zeq7JVBf1H
   zrU8T5dBZDpfIm1H457bVJhbUU8vRXPaMx6KKCUeAwhsdS/J4o1d5S5nb
   kqLsWDL2EDODSm5GKj0OjNIPGVGWoFoC+LrXtQjM9E5+gXorC3FWA3ghc
   VDumAKbvluj2NlLu/rYnh5FH9yQ/kqYG4/CZMKELO/1XlPcEGDLcfKLQ5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="370456280"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="370456280"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 19:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="1016700679"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="1016700679"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 05 Apr 2023 19:43:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 19:43:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 19:43:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 19:43:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 19:43:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbLRCI0psiSHgC3CatVSqJ68UJGTX7R6HtSpZ+SwWMwu2Je0bF+XpxUj6aY1zISyIDzjYaSnOEWG2/c4Pg0E+6q7XgVdilSbGwpMQ1xr69irNAc2YqStEvaXNEMTuHk8xBl2mxVHYZex0UIHCWfrwWpU/ZHFsqvXOlvWyW1/e/MVzf6vkcsuDnUXeCo+QFLmcsNqI7GbjmIunDHf62LuA4/R3dKPpDX9H7aJXE/yRTRVh3wO6i9WlU+io9J5A1dvP7IFOuPI0y3t+TIMn1WiB9J/+OU+GmiMV4sqPshOUjJrcm4o4L6K8eo9zoiCxe+ck041B3LcTMGlL3sY44Xoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xxoe3+lanqtjAho2gK0RA8okXJwY5QfHtb+ZSA3zKPk=;
 b=X+Cf1pL8gcBike9vi8dHC2UgqXc7v2GadEg/7XpaUDrTAZb2r053PPIJ5VHbv4MpJnp7mZ/fsUTjIizr7jCgZBIaG+4gqU9EIqluWWpsS1jTv3pJ9MOYMxLH0Hx52dDs1bKVRdZe8HV74qxD4Sw/CDGPlXgdYzTawF9+KrTI7OFpsX5veAfBzJOmy/L4Vd700iwwvNyI9EWeJ0KlVTdZUcjepiT/JvGVMQ/EPxxvWTkeQWEfj/5SCjDOmHdRoPSsaABefRtq0Zo1SqlQuTp+aWkN8lmump3uYg2VUt6lg3dt6h7dtunSjMg0x+C4m0wLpezgUgo+0Bwk9+fI3X+4uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DS7PR11MB6040.namprd11.prod.outlook.com (2603:10b6:8:77::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Thu, 6 Apr 2023 02:43:05 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 02:43:05 +0000
Date:   Thu, 6 Apr 2023 10:42:50 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Ye Bin <yebin10@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yifan Li <yifan2.li@intel.com>
Subject: Re: [PATCH] PM: hibernate: Do not get block device exclusively in
 test_resume mode
Message-ID: <ZC4xqolqS51M9dEH@chenyu5-mobl1>
References: <20230401165540.322665-1-yu.c.chen@intel.com>
 <20230405070000.GA720822@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230405070000.GA720822@hu-pkondeti-hyd.qualcomm.com>
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DS7PR11MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: c3490f9c-b1fa-4586-3f65-08db3648a5f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbaQWHEhVPkQaREfDln3YO40JhgkQ+uKqXe/1Vz3A4XUD29hke0dS/9+VC2/oAaHuzt7kW3Obk1j82kBIym5CKBSeHSJuJUo1e8MHrYmvPPpDDoKGTNWFZYhQ1OlUqC2O+mfO9eH8dkDwlzLlVUb3uBI41vLVz7ZJwC/UsOIsfBFIOeDxoyzpwCRebFBBeXdxMD1B8IjorJxMskV93yajWcjiOJEyfrg4FRRCCHnC5FCyBfTXSPlwgIXnbV+cVvs8b9SMR3AQOqZDX2ZFIH4naUC2ve0h7MkKwRtM8J45gj2NRSvMvCcwT3bBrMSWBHoCiJvw3W4x2qSw0Gk/Rj7WDc3MlQnRDBKenKkJt7z0eQaY6zAY4mjL8GtCRPTB9fBISd015kOX8LTpJZQ6FWpjNwo5OFUnDG4PaUJGAN1cUIo7ewKOKplkO+zzzS+HGYIYDflb+OBv54axEEuNAVoIL7BuHTLJOhzQz8yC5V2zRMc9YF/FK3Zsv6ok82lV59cDFrk+f5MmG9g039CHR6vmUhUE6r3vQq9dWXGfYuALuwJFAj1J4XKXgSvIyVo/yro
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(41300700001)(8936002)(4326008)(6916009)(33716001)(82960400001)(38100700002)(5660300002)(316002)(86362001)(54906003)(66946007)(8676002)(66556008)(66476007)(478600001)(2906002)(83380400001)(6486002)(26005)(6512007)(186003)(9686003)(6666004)(6506007)(53546011)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0XYo8tDwP13SK3RaEXJ8BfKQWpF/q0eJeZbY6YuRFHImbHZqLydtWdI3MPhX?=
 =?us-ascii?Q?SxA8HalLE4pq0GEdXmo5d2cgmAFvMwwaM7IHR2aaaPVgnUh70HXJjBXu7FrU?=
 =?us-ascii?Q?hUEIcNGVZv+EmBDiPtBJnFc+LZ16XsB10BrL7ncV6itOUq0GJmfU/Y8IdA58?=
 =?us-ascii?Q?mTp6fXFrTMBVYUNk/LypJTRmLjc4YHdRXRZ/O2HE4SF0lqCaHJvxOSynQXXG?=
 =?us-ascii?Q?0BgAnQqLbEAHEbEWrjWVaCJJK+0zaMzPLzEHL5wmTmjX18lhFXKTZr21Fm/n?=
 =?us-ascii?Q?0smuCvlDf2vkg29f1F328NXSMfr53UcMnnyYGiHYTz8f35s9kXGJvPrLiqP1?=
 =?us-ascii?Q?vba3HHj/w1Rv9ZEttPEA4YUs2SCEgF2hEs6vqHn7pcrbScBJpyWFgTRaGxnC?=
 =?us-ascii?Q?ZZDHyWWOTaGFLF8GVcg0WSY3uUz1qb5VmtjG71/fJMEmh/IpdjmPuRwfK75H?=
 =?us-ascii?Q?Zd/MYBp12cJ+GJJfpL60+1bj/aiTlGZR8R9ZLhq0uqTJw3EisS+3wVzB1l++?=
 =?us-ascii?Q?fLjq2jGpPN/du8s+M2pVd9QdbkXq+n7XfWnHBKyzLhNW6t9fpCj5Uo+zW8To?=
 =?us-ascii?Q?vFSiBlPN3Hbsk9Amp6Q+1tbFMaj/GsacAzzU9t8jIe3b1KjJj1QELkLA6uG7?=
 =?us-ascii?Q?dy4x5NVecZO7B6ecn3grSfeYa0Ok9Gri1CyvljFnaxhT/dQ13pDTJYgl4pG5?=
 =?us-ascii?Q?Jq/vC9T1nTP8s/rMWtlpb2TSERNJw18SqtCF78hy1xfJVA7nRKfjRyyMHA0K?=
 =?us-ascii?Q?JAOFkhTLlGK8r/fh9z2KgPY7/VGNsFHNAPQaw8zqg+HE8gqPvkcr2ggdqUeP?=
 =?us-ascii?Q?zpb+3QK+3l5ofpdVklXTdsfcqZFZFZAJ2xdMctgKW+e1iv2KzomeJ8fVdFWs?=
 =?us-ascii?Q?DFvKx6RLuzovSD91DWoYarARAVQKPYbzWkwadzzGb+vEy7XS/EWhb0SxuAkH?=
 =?us-ascii?Q?mYN0ZYZbIF8PXVAGBeG8vaxL0B8k4QziN1hQb0DFAFPj/XE1Bmx6h5dkBtiF?=
 =?us-ascii?Q?eqCXzHONizx8+M/U1XITsSIIOUSEeOxYixLEsz4emphUV4A/lg1GIP3cNQ5M?=
 =?us-ascii?Q?P7HIWuEcRV9zgl1fbYQxFNUSUMkKZlLJD117FX+I3KFTJxoeMsnqf7k+CGFm?=
 =?us-ascii?Q?8vT/tr+qD4957SzBWzgg4+A6uFMkdntwP4qGAwF/pNRQY+BMch4IV6q06hBv?=
 =?us-ascii?Q?WIVBiKvwDNu1a7GKi1LSH7xuyuSsWsbxbNGx7gQzT/7Iaab0V9M0S+rI0ynd?=
 =?us-ascii?Q?2PuoPzDanvVZ4oShyRbZNRE/Fl7m/wdokqYu+R1lim54c/1LSpespmwQSWe4?=
 =?us-ascii?Q?oCASceXRw3CkxLCYLUUvf0BNxlbE1231oiMkXvZHpi8q6vsTT6OosNI54y+G?=
 =?us-ascii?Q?n9IynYJRxdgaMOvqUFazrv183+9rVQuxNBkU0Ioi3GFFvxcsu9S6OE9BhxYS?=
 =?us-ascii?Q?8dSF6K7jBLjv2L0k7do2D0CtAFgOYyXeyoGY5VkxFclq9azFR+fnj/HYiUlT?=
 =?us-ascii?Q?AAocG0ZyXumaBjiLENtt6Jfkp7ZPdSSlCxp0EcBRhMuS5cDP5YsUyMC8aOEz?=
 =?us-ascii?Q?0CngrNSafvNf0rHLusFwyN8rEJoceTNDR0BDRmOr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3490f9c-b1fa-4586-3f65-08db3648a5f0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 02:43:05.4814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIYB4sqUp9aWiroQms+eM0wa3FmNG4Xpsl8na6P/SOfF3dJekdJ6VxyELCkznd5xCvK1crr47WbebYCwIQBwmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6040
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,
On 2023-04-05 at 12:30:00 +0530, Pavan Kondeti wrote:
> On Sun, Apr 02, 2023 at 12:55:40AM +0800, Chen Yu wrote:
> > The system refused to do a test_resume because it found that the
> > swap device has already been taken by someone else. Specificly,
> > the swsusp_check()->blkdev_get_by_dev(FMODE_EXCL) is supposed to
> > do this check.
> > 
> > Steps to reproduce:
> >  dd if=/dev/zero of=/swapfile bs=$(cat /proc/meminfo | 
> >        awk '/MemTotal/ {print $2}') count=1024 conv=notrunc
> >  mkswap /swapfile
> >  swapon /swapfile
> >  swap-offset /swapfile
> >  echo 34816 > /sys/power/resume_offset
> >  echo test_resume > /sys/power/disk
> >  echo disk > /sys/power/state
> > 
> >  PM: Using 3 thread(s) for compression
> >  PM: Compressing and saving image data (293150 pages)...
> >  PM: Image saving progress:   0%
> >  PM: Image saving progress:  10%
> >  ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >  ata1.00: configured for UDMA/100
> >  ata2: SATA link down (SStatus 0 SControl 300)
> >  ata5: SATA link down (SStatus 0 SControl 300)
> >  ata6: SATA link down (SStatus 0 SControl 300)
> >  ata3: SATA link down (SStatus 0 SControl 300)
> >  ata4: SATA link down (SStatus 0 SControl 300)
> >  PM: Image saving progress:  20%
> >  PM: Image saving progress:  30%
> >  PM: Image saving progress:  40%
> >  PM: Image saving progress:  50%
> >  pcieport 0000:00:02.5: pciehp: Slot(0-5): No device found
> >  PM: Image saving progress:  60%
> >  PM: Image saving progress:  70%
> >  PM: Image saving progress:  80%
> >  PM: Image saving progress:  90%
> >  PM: Image saving done
> >  PM: hibernation: Wrote 1172600 kbytes in 2.70 seconds (434.29 MB/s)
> >  PM: S|
> >  PM: hibernation: Basic memory bitmaps freed
> >  PM: Image not found (code -16)
> > 
> > This is because when using the swapfile as the hibernation storage,
> > the block device where the swapfile is located has already been mounted
> > by the OS distribution(usually been mounted as the rootfs). This is not
> > an issue for normal hibernation, because software_resume()->swsusp_check()
> > happens before the block device(rootfs) mount. But it is a problem for the
> > test_resume mode. Because when test_resume happens, the block device has
> > been mounted already.
> > 
> > Thus remove the FMODE_EXCL for test_resume mode. This would not be a
> > problem because in test_resume stage, the processes have already been
> > frozen, and the race condition described in
> > Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> > is unlikely to happen.
> > 
> > Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> > Reported-by: Yifan Li <yifan2.li@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > +int swsusp_check(bool safe)
> >  {
> > +	fmode_t mode = FMODE_READ;
> >  	int error;
> >  	void *holder;
> >  
> > +	if (!safe)
> > +		mode |= FMODE_EXCL;
> > +
> >  	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
> > -					    FMODE_READ | FMODE_EXCL, &holder);
> > +					    mode, &holder);
> >  	if (!IS_ERR(hib_resume_bdev)) {
> >  		set_blocksize(hib_resume_bdev, PAGE_SIZE);
> >  		clear_page(swsusp_header);
> > @@ -1547,7 +1551,7 @@ int swsusp_check(void)
> >  
> >  put:
> >  		if (error)
> > -			blkdev_put(hib_resume_bdev, FMODE_READ | FMODE_EXCL);
> > +			blkdev_put(hib_resume_bdev, mode);
> >  		else
> >  			pr_debug("Image signature found, resuming\n");
> >  	} else {
> 
> The patch looks good to me and it works. I have just one
> question/comment.
> 
> What is "safe" here? Because I worked on this problem [1], so I
> understood it. but it is not very clear / explicit. 
I see.
> One approach I thought would be to the codepaths aware of "test_resume" via a
> global variable called "snapshot_testing" similar to freezer_test_done.
> if snapshot_testing is true, don't use exclusive flags.
This looks reasonable, with this change, we don't have to add "safe" parameter to
swsusp_check() and load_image_and_restore().

thanks,
Chenyu
> 
> Thanks,
> Pavan
> 
