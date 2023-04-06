Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1DE6D95B5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDFLgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbjDFLfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:35:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B867AF0B;
        Thu,  6 Apr 2023 04:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680780826; x=1712316826;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=G6mwBeq8Ai07vU/A23hiLPyRPvHgDuwqgeOaEI7HvtM=;
  b=aQ8sXSQEdjCOrVmiWzBAeUEQNfhB7hQb4KQ16RDIDNb7IyDhxDphTqdG
   UvWu2G2MP/VLSFmPWLWgZJxq+0/4JYNBd+WlZPV7fjv5FmryLzLonvjVD
   HYQciUC5EANRncHhjqAC4/pAfTZDTyg5+2SML+rh3vuWlQFF0EJB9n6hc
   aRqQ+PKB9tP1jWg/KDgQpRav39CsEAdWiMPVaoO0ydpdISgAtUtzURTgQ
   A8fGWJX9FoJB4KyWJdZ8ILyIc0lHB4hXn6GvA/tPAtWhf+CUTmk1WbGTh
   TzTCpqeoHWfX/FfKXY00tudZACt+CXXN5dyY55owDUwCpaNVdsT0AZiJU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="322362844"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="322362844"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 04:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="751611021"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="751611021"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 06 Apr 2023 04:32:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 04:32:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 04:32:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 6 Apr 2023 04:32:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 6 Apr 2023 04:32:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwTVXQvTAaHUUIQ7Hiatp48EfACAHMyo+z4K5lLDFkVBkl1LU/93LRu8moWhIDpUh0RTCrHVCyDWtW/dSwkUHpc3r0YEaK+wMD+Pdh6sQ+TVHdSb6wTOBD5Wx+bhdhE1hpd5BTRfTcANoZTEJ5nALRko4o/2yKoOwBGjb/gInE6corxFV2G4CoNgvXRv6N7ExrGtDc+lmMXyhpUfbL9TGL+31QMLbD/6aRner2mAe1HN/bZi7iLmFZYsTckI3W6xpt68WH3y6C55Z+2TTelUGe4VtePNp0nb0sBUI0n5hCvVPzWKjfo9QER9TkNdq8CxG5yPhcMSICr4OTvDsZeMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RP6t8n8/9G9GwDJrEpdKBk+Ex6GCbOF5IhaurWZq3R8=;
 b=n4Jwj41536/QOktD77ymYmIEFIhnkRhw0/xM2MzQg3Ve5qPYAwGxNsCdDhuorXcvvKsYl9HEVOt+c9U7Iph8XaPjWHWjjZ02ItuuCUlaC+uhCX7AZ79T1b4r9iT3+xoKihLO46Urrps5OtAdyvHl31cC6oY37dNVownjeQh+Sfc2TPxVQz6OoXwSD019qeH5RqwJNlSm/Y5Kkd0Qr32evuRVr4lPxYBxzDRPuPOS16G4J+aeq+pRFr2QBhWEfEr9bw2zlyjWm3CdH9ashqpkTOAOuXrFSxdzHbaXr8pbs3R/D8txwU9teE5dCWk3R7t0yE4bu5ddnJG2/YERJmiymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DM4PR11MB6552.namprd11.prod.outlook.com (2603:10b6:8:8f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Thu, 6 Apr 2023 11:32:47 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 11:32:46 +0000
Date:   Thu, 6 Apr 2023 19:32:34 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Len Brown <len.brown@intel.com>, Ye Bin <yebin10@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yifan Li <yifan2.li@intel.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
Subject: Re: [PATCH] PM: hibernate: Do not get block device exclusively in
 test_resume mode
Message-ID: <ZC6t0ubwcNekbBr1@chenyu5-mobl1>
References: <20230401165540.322665-1-yu.c.chen@intel.com>
 <CAJZ5v0j704JoCPTrDO1jTHwP1+8NVdLk7hym5036uFcfo7YHXQ@mail.gmail.com>
 <ZC4zMv1SCiUMbcqs@chenyu5-mobl1>
 <CAJZ5v0j5PWsF6zCCVMRW59WevYLvWiBk82U4MpxqWdFnAcrqrQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j5PWsF6zCCVMRW59WevYLvWiBk82U4MpxqWdFnAcrqrQ@mail.gmail.com>
X-ClientProxiedBy: SGBP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::13)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DM4PR11MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 70bc3931-e611-46cd-ae73-08db3692a526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvzrUSEvMcDi78x+Vqz1xIGljfx1tNrVm56UgrtfyLWu0QsBYoXj92Nwn10UYBSpCv8v2JYhYeyfNUKfLacMqG9c3nsSnIMARo08BrS1AK40EUL9/VqOgRpeUS/UfIRYUz2sEIx8DMXkp5huOvy5pi2vsHQskPR3z4KMCQ/YX931+EbpMrPTDpGIvVrvC05o4wstQc1Bk7ueWcVis9oEoZxIAlZHgUOhNgE8ByFuCteD/qv42WsG6TlDsZCSCO6QkaI5lxtUGzNTlfPAsyh1fgZeCbrFkTe3xnvKi5X6bWTUy8w2H2zH6/e23l2nBdpsLyccNxTm1J5HKrHk6TmPupxOg9F7Xv+3bhVoaso0VnRo2DwBSJPY5Qh/qOed9QBrAON010vFQDC73fJ61dJH7Azwzn2XmLFWH+G4+SXXgE5rtMixBwY030rHJ4KyiOmpSzBXlppR77kJybONXgbEuu1AawRbNZe1EgSK1tMQmIaIvOIxIB/p6WfhG7vs4kmoSntw/J28j96WRtdmeHZMuR7nKCTipBvxDsp3l+iOXSb4qLyFpwp3zZuOB/Y99qgF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(8676002)(8936002)(5660300002)(6916009)(4326008)(66556008)(66946007)(66476007)(2906002)(33716001)(41300700001)(186003)(83380400001)(53546011)(6486002)(6666004)(9686003)(6506007)(6512007)(86362001)(26005)(38100700002)(54906003)(82960400001)(316002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eng4L2hIWmJVUHBPZUg2TDJ2WTJYd29DYmVHSFNJZm1iUU9ZY2FneGRTdW9X?=
 =?utf-8?B?TFBGVWdDQ1Rvb2dURlllTW9JT0UrbUFNVWdoeDc0cmFWT2trTzFtM2hnbFRI?=
 =?utf-8?B?RWhrSkVDMmNwQW9zVU1CSFVudjd4bWo4RHRyWjE1dDBtV2V2SGkvQzljMWNH?=
 =?utf-8?B?aTF2U2E2S2lrNzQyVmw2L0ZMZ1NrQ096bUZpczk0ekNOakFCdlluUkNOSGZM?=
 =?utf-8?B?MXRnS2NvRFlnUjI4MnRQN2t6bXA1MVRFTGpxUExSUUZaS1J1TCtDV1VrZ1hV?=
 =?utf-8?B?SGtsVWp1dDFiRGFiR3NKRVIrR1A0VEhVRDlkNnltbmo5cEtid1lDU2VicW9m?=
 =?utf-8?B?TGpQQUN4VjNDalB3emxJNEl1NUNuSUp5OStCWUpZcDU3TVdYOXZxOC9EVFMz?=
 =?utf-8?B?WUcwQTFEclcwZ1poVVRwMWJaQmp0dEo0OE1RbnlVRHZ3TnlWNDFOdDd5NGMx?=
 =?utf-8?B?ZHE5MUsxK2k5eU1MTWtxNkxQZjBvNlptTjV4S2t0TmsrelVuRngyMmxJcklz?=
 =?utf-8?B?Y2szeTB5OWVnWDJrZ084TmhYanhIWjdNcUZoY3poejN1bW0ra3FwT0tWZVdr?=
 =?utf-8?B?WXpZdFJJb25LK29aVUdMTnZIV0NNbElzd0xnZWp5L2hTbmMwd3Y0ZEpKcG0y?=
 =?utf-8?B?RG1iTUlweXJabDFaOXI2VU44Vko1V3FKQjNHaVI1ZlZYT2VLcUJyd0hTZVlV?=
 =?utf-8?B?M2FRUmxvTVBJT2c5SXhrWFFmWVV4dDhleFdyaGZhd0FEb2N1WCsxNjdnUlQ4?=
 =?utf-8?B?ZjBBNW1sQ005elFqV2FleXZSY3laaUJZUTdmSUl4QUVqa016eVBMOEtFbmxV?=
 =?utf-8?B?SytmQm9OSmdxU2c2NllJb1FBQTJJbTFlVHU0ZnFhQUJiNjM1Y0pPbVUrNXpN?=
 =?utf-8?B?VXJkRFozRXgwSHNOWmZTRTljRlFZSGludGVhREc1aUw2WXVGWmcray9VU0xI?=
 =?utf-8?B?TWk0ZFM0Q0Y0aGUzTlRaTzZncXVOUm9lUHZ1dGlBS3lKMEJmK3l2SkhwNzRk?=
 =?utf-8?B?ZlF5c0J5d2QvajNROWlHTVpyMmw5aUxmNm5yTzRXcXhoc3hpZ3Z4SUx4b0lR?=
 =?utf-8?B?ODYvRlRMM0ZiZnJwYVhZbVBOcisvTzhMa09VbktwYkdDU1FPWDZnZDhLZTdP?=
 =?utf-8?B?eFZKdVFvTUxta0ZUNFFZeHB1RGJCY2VmbTNjb2JrM2dlajRUTkVHT0JaaDNO?=
 =?utf-8?B?MlNhVHhoUzE1c0hqb1hoQW9jZ2NUT1dTNk5uQi9WYVVjeDlDbUhoRlVBK0xL?=
 =?utf-8?B?REJucFNQNC83dXpOejgvOCtqNEVjdmNXS3NScTY3djY1aDZoQjlpdkI3Q3Zi?=
 =?utf-8?B?UlFPRGg2MjNHZUcrQjcvTlJQcmhZMksxOE9IRUY3OVBNS2ZreE1Eb3hYQS96?=
 =?utf-8?B?TGhldC8vLzdRM0lIR2FBOHpiR0Vxdi8za2k2VWtxZ2o1UTBlaCtKNHY1UG1Y?=
 =?utf-8?B?c3NUUlRtNERqMkkvM0U2bjlpQU9Sbk9VUFcxZDEyRUVHUDlKQjZ5K1F4TWcr?=
 =?utf-8?B?TEdEdGw4Vmllc3Ard21rZG1oWWVxYXl5ZWs1WnIxTENuejZUL3NxdUlXeTha?=
 =?utf-8?B?QTk1MGEwUzBlRmFMYURwY1hrc01VaExhYzEwcUcvN2dEL0oyNk1zQWJMSnVt?=
 =?utf-8?B?QnhHZlVVek5DcXZQL2RnNUNmbmp3QWR0S3YxbGxja1g4WXFmeWM3ZTl4WHdj?=
 =?utf-8?B?dmlyRUxCTjZIdk9xbHlHMDMvWU1MaE9aNDh2TUFZUmZBSm12ang0TGwrSXA0?=
 =?utf-8?B?QlRoYUZzSXhTZVhEVVpWMU41Tjc4a1dKZVl5Mndqci9obzh2ZWkvRzc5YTBK?=
 =?utf-8?B?V1hpUjhhMm4yeWdYbGlNR25udmVaU0RpdWpRRmdJYzBKcGxySEZVRUt3RldS?=
 =?utf-8?B?VXJ1dUxGTTI1SENlNm1XaFJaL0ZOWE1SQjNkL0dOMmVsRi9yM2FmNzR4ejlm?=
 =?utf-8?B?SHhBWEtpdmVuY05WQjkxbG1aSFRHSk1NYThsNnJDaXJGT0N3NFBSNmpWaUt2?=
 =?utf-8?B?R2RiYm9zUmdnVXUwc0hNb0RwNkE2cHRiWnc1WG5TdVYxVWxkL1JtV0pjMWFt?=
 =?utf-8?B?MFFjdHZlNzg0VEtIWWRpQkRZQkNSVlJ4SVQ2dHBVYldyWUtPMmQyZmxNSHFG?=
 =?utf-8?Q?HDG5DYoHcTw5h6ev1A8lpEzad?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bc3931-e611-46cd-ae73-08db3692a526
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 11:32:46.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYlhE4uZBeI6S/bQZ0opd6ZMPlM/MyhLFovjObgbxY4o62YeeSJ7qVae4IxK4pVCzwRxw+ZyKobxl0Io2hFauQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6552
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-06 at 12:02:01 +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 6, 2023 at 4:49 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Hi Rafael,
> > On 2023-04-05 at 20:37:32 +0200, Rafael J. Wysocki wrote:
> > > On Sat, Apr 1, 2023 at 10:59 AM Chen Yu <yu.c.chen@intel.com> wrote:
> > > >
> > > > The system refused to do a test_resume because it found that the
> > > > swap device has already been taken by someone else. Specificly,
> > > > the swsusp_check()->blkdev_get_by_dev(FMODE_EXCL) is supposed to
> > > > do this check.
> > > >
> > > > Steps to reproduce:
> > > >  dd if=/dev/zero of=/swapfile bs=$(cat /proc/meminfo |
> > > >        awk '/MemTotal/ {print $2}') count=1024 conv=notrunc
> > > >  mkswap /swapfile
> > > >  swapon /swapfile
> > > >  swap-offset /swapfile
> > > >  echo 34816 > /sys/power/resume_offset
> > > >  echo test_resume > /sys/power/disk
> > > >  echo disk > /sys/power/state
> > > >
> > > >  PM: Using 3 thread(s) for compression
> > > >  PM: Compressing and saving image data (293150 pages)...
> > > >  PM: Image saving progress:   0%
> > > >  PM: Image saving progress:  10%
> > > >  ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > > >  ata1.00: configured for UDMA/100
> > > >  ata2: SATA link down (SStatus 0 SControl 300)
> > > >  ata5: SATA link down (SStatus 0 SControl 300)
> > > >  ata6: SATA link down (SStatus 0 SControl 300)
> > > >  ata3: SATA link down (SStatus 0 SControl 300)
> > > >  ata4: SATA link down (SStatus 0 SControl 300)
> > > >  PM: Image saving progress:  20%
> > > >  PM: Image saving progress:  30%
> > > >  PM: Image saving progress:  40%
> > > >  PM: Image saving progress:  50%
> > > >  pcieport 0000:00:02.5: pciehp: Slot(0-5): No device found
> > > >  PM: Image saving progress:  60%
> > > >  PM: Image saving progress:  70%
> > > >  PM: Image saving progress:  80%
> > > >  PM: Image saving progress:  90%
> > > >  PM: Image saving done
> > > >  PM: hibernation: Wrote 1172600 kbytes in 2.70 seconds (434.29 MB/s)
> > > >  PM: S|
> > > >  PM: hibernation: Basic memory bitmaps freed
> > > >  PM: Image not found (code -16)
> > > >
> > > > This is because when using the swapfile as the hibernation storage,
> > > > the block device where the swapfile is located has already been mounted
> > > > by the OS distribution(usually been mounted as the rootfs). This is not
> > > > an issue for normal hibernation, because software_resume()->swsusp_check()
> > > > happens before the block device(rootfs) mount. But it is a problem for the
> > > > test_resume mode. Because when test_resume happens, the block device has
> > > > been mounted already.
> > > >
> > > > Thus remove the FMODE_EXCL for test_resume mode. This would not be a
> > > > problem because in test_resume stage, the processes have already been
> > > > frozen, and the race condition described in
> > > > Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> > > > is unlikely to happen.
> > > >
> > > > Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> > > > Reported-by: Yifan Li <yifan2.li@intel.com>
> > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > ---
> > > >  kernel/power/hibernate.c | 18 +++++++++++-------
> > > >  kernel/power/power.h     |  2 +-
> > > >  kernel/power/swap.c      | 10 +++++++---
> > > >  3 files changed, 19 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > > index 793c55a2becb..f50456e72f0a 100644
> > > > --- a/kernel/power/hibernate.c
> > > > +++ b/kernel/power/hibernate.c
> > > > @@ -683,22 +683,26 @@ static void power_down(void)
> > > >                 cpu_relax();
> > > >  }
> > > >
> > > > -static int load_image_and_restore(void)
> > > > +static int load_image_and_restore(bool safe)
> > >
> > > It is not very clear why the argument is called "safe".
> > >
> > > Either this needs to be explained in a comment, or I would just call
> > > it "exclusive" and rework the checks accordingly.
> > >
> > OK, I can change it to "exclusive". Pavan proposed to add a global
> > variable snapshot_testing to indicate that the system is in test_resume mode,
> > and we can check this flag to decide whether to open the block device
> > exclusively or not. Then we don't have to add parameter for load_image_and_restore()
> > nor swsusp_check(). Could you please give advice whether this is applicable?
> 
> Well, in that case, why don't you simply check pm_test_level?
>
Sorry I overlooked the code, the snapshot_testing is already there.
I'll change the code accordingly.

thanks,
Chenyu 
> > If yes I can change the code accordingly, otherwise I can change the "safe"
> > to "exclusive" and add some comments.
