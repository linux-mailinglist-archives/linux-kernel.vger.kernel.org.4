Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287A66EFF52
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 04:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242881AbjD0CWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 22:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242557AbjD0CWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 22:22:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CD43C03
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 19:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682562131; x=1714098131;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VKwpZzRJCzc5A8TQzyZez/1AkYyI3NNJuNr5moWNVoE=;
  b=XG+IOU48dbm5w+6RQd55C8ByNs/3iyFKwKyEAweS4CrM+D7TCBGOiuHp
   W3NEuBRJC6UuX18UnDfLh+iOdIW/52eqFtKvU4ekWtYnsgn/0sqWNCQ34
   S9CJ+PT3+a6pORu70YamoZOOL8vRki8s8utUhU8jdvlX4eaCbOsVTaIVd
   88jkNUMV838UIANxohbjg6Dyra1LmKU/3yojV+N8t5y0hNOr5UcPhRPsv
   0xK0osk1DNtywqy0JRgW+djJoVTotJ+P2lgrBstQsU2WJSXBxZlCHhS/P
   MBdmXwkWozdDoK6wtPjH4YQcRkeTv+8m/asaty9JEUA9znq1OrzuEH1pb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="347315551"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="347315551"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 19:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="696870984"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="696870984"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 26 Apr 2023 19:22:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 19:22:11 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 19:22:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 19:22:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 19:22:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA1bVdaym3x/Wm8XUwr86cX/4fEnJ8WNRNZyim9z8vLqb53o7mWeA6sPZHI5l0//3CMpz0ZVRStzxeqWXSGgyiNci7danb/PIj2kG04GESJi2cdNipEHjPRU3atApsZ+fH9aCGrLRvZd7y2xBzrFFao9qlhdELxdwNiVag6TXnqyyvbKjOlnKoZ4qCdcoPglVyN8I18o5w52hkSwr/6HFi6FS4rFu7MpFVZEIKVxg0w0cAuHf3DJSgb2tzxRZh3OAZ5ZME92q50rqp0a/YeWRWxmYvWaHjmHu2qgbgp51oACboQDBBFGIk+DjQNRFmsv8aC+d6+lB/kV91emzyXkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EQcl38yCIongLimozCwIb/2rxpL41zLMHUXN8LwBds=;
 b=CF+ukvWVsw3i0syUbI8DDeH0Nq2+LDWIiNGWWimt6CkqlcGN8wdJGDyzSkOXiR0B6dgx3IW6kKzya2plo7jh8TuYijYLhsOW9OGcipbjapce8Dl0ZY1jVUpHKCwqVBVyZkz4o1lIAgToVyhARj0Ph1VVEJvroVehOdebgzV2ODRCB24UkKEiZSDiGhLqs6MyBGbX55LYdLh+j4oNWFB3opjQkvuUADe49ldluCaDv/Qblo+02l3qRi2CTPDqHiqfopjVm/NqTk2CACiwINtUpedwfUGnVO2Wog2eouANDr2iUhUTyp4L/g3CQuXAz0eBdLd64LJRgvToBiw7DzYZ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MN0PR11MB6254.namprd11.prod.outlook.com (2603:10b6:208:3c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Thu, 27 Apr
 2023 02:22:08 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 02:22:08 +0000
Date:   Thu, 27 Apr 2023 10:23:49 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <l.sanfilippo@kunbus.com>, <linux-kernel@vger.kernel.org>,
        <jgg@ziepe.ca>, <heng.su@intel.com>, <peterhuewe@gmx.de>,
        <dhowells@redhat.com>, <lkp@intel.com>
Subject: Re: [Syzkaller & bisect] There is WARNING in tpm_chip_unregister in
 upstream patch "tpm: st33zp24: Mark ACPI and OF related data as maybe
 unused"
Message-ID: <ZEnctc4/EKcxOlRi@xpf.sh.intel.com>
References: <ZEjqhwHWBnxcaRV5@xpf.sh.intel.com>
 <1b67d480-d6f1-965f-ccfa-0874eb9a3b6b@linaro.org>
 <af2b2e0246c970d59e67b746eacc9b9a129cfde0.camel@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <af2b2e0246c970d59e67b746eacc9b9a129cfde0.camel@kernel.org>
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MN0PR11MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: f0987935-19c6-4f8f-9027-08db46c63375
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +mOufmpFpJYjbTmKlxIHIoVWEM2lEFclroYbhxvUD608fDdq5pqd46uR5416EmBfMpI9zNw6noauoK3KFVpA0VXSg3uER/o3ufnOPer2IjmnlliNbb/POrfkOB3JROucP7O51av1JLSEUNCk5eCHh/h1lHFaX2fSHqhxDrWp4XvDROF7P8cslQNcyA6ZSAZihr3u7q3GMukNRZGvu1xU2t9uQJ/M+KC1aYMRjm5d55B7ZKltLiG8opZpK9GnLxxrSH7KzhWxGAmCJHIjM4l1x6o2W0rgAnv4rdr8xpYAUYRoK5MjVT5fenLgnG5sw2CotKajSoCS1Y11wDtU/t0jMkDFrJ+S4j1pDkd9XHq2iPbrcr0Fv5KDRI6ttuipGdhTsRIOqHCn9naYHyJ2vq689h/Uz1v/SUQQ6c3T2IeJ2fyZQ4wAUcHFuPf1apkDWrx124OpiWk9zazBI7+c6no1CefLDFM+A2Yt3SotRCoRf8oVtURblLQTo9SipXkRjRdyv9mP1WzrqPMs642uCjRixOxABCI3K+zzEP8Rze8lhtqYnjdYi5FWF9sAEVNaQwuqsVyBlJHabAEt0f1rvZ6EQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199021)(38100700002)(316002)(41300700001)(2906002)(5660300002)(8676002)(44832011)(8936002)(86362001)(6486002)(6666004)(107886003)(6506007)(6512007)(26005)(966005)(478600001)(83380400001)(66556008)(186003)(53546011)(4326008)(6916009)(66476007)(66946007)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0kI6aT4cwSlMfFg7f1aiePS45g7/MyAmttoJGUHIWTGcmLUEdW7iKmOJ+TfI?=
 =?us-ascii?Q?TNBl+Z2zj8UCt/fl2h5YRJafS3P0SCLJhVUfxh81QfuuCI4F9cAerljU6obO?=
 =?us-ascii?Q?CI1T+HK3X1KkY9600lC9xxRv6+wuhuWofaTzzNJZgQykYTe4gIxstdZGXNye?=
 =?us-ascii?Q?FmJqxkyF///EctptZTtobjUMIROwktt1ZkYhe9Rfalt5W+ye+cTvmnTGm4R+?=
 =?us-ascii?Q?NHYwyzq3fjMZQJ0dDKwp+oeQ8p0Wrq9ChX6MYNGgNqY0SvdKttWkzYieUAiM?=
 =?us-ascii?Q?31r2umanMEuC0WUGhQnXkTUGfGa8YksifuzLSJyfqVoW7842hxFkkeaLYcGA?=
 =?us-ascii?Q?fnWReA9MyHwLjdkGCvs4/kR2mCBIib7bNQ6NDLGJrHR99Iz2W5r2v3h6boKD?=
 =?us-ascii?Q?i0UN7aeJQ6/AvAr1pBXA+fW/acH3cySNiKgSV4uCytsiw6ttAHCh0fsGINnd?=
 =?us-ascii?Q?/o32TVg6BFVENpsP5uGOKOzgRl+mN5Oy+asBn3iM/XjI3tFNpJOb8VKkWFZm?=
 =?us-ascii?Q?GKvIC6BmH748L3kngbbtVo4DDespLqRwIOBeeGG/nVSMhXuBA98/dcU8XM86?=
 =?us-ascii?Q?xhXwf8V2Kxx3XGAzUo09fx3MfRaovRofxnDVau8T2zu0egC+k7S5uWbX2W1v?=
 =?us-ascii?Q?ZByZRfRfO0+C1s7CY2x2xC+rr1tbutzq++4CqE1YynOPGSIBEeDACowZpXvQ?=
 =?us-ascii?Q?oKkLmlSWKYKGgBlZd8Q9NF9MNSQm6nCSHRmIUWEiialHNag6mRJDtjjt+DLu?=
 =?us-ascii?Q?MYYU/f1EmkBIwo/FXn9p9gFoYqu2i3+wBs6+/0v8A9srWnmblNt/iBp/xmss?=
 =?us-ascii?Q?mQFvvs9/YlDCnmWyEJt9Z2ZgePtiBCqFN4//H8v1SbGe2rforWUBBYVXDBp9?=
 =?us-ascii?Q?6TIeCiGn3Xu5/eUZXh1eUlUuhbVJMwKL1V5FDEE445FNM1I8uNfAlUZ3zqU/?=
 =?us-ascii?Q?xnzYOQ5jKvKjXIra7Sdr/f3yLBWI5sQx75dsss7GcE8lpcYZuVkz5YBqYQP8?=
 =?us-ascii?Q?K3YRDbQh9kVTW9KTP7ts9nFehZEmTIL/qzZqa1oMGX+yjkZacNQhtyk4HQQx?=
 =?us-ascii?Q?w5bZtmYQyLJ/N81gcanllVWzgermozjO+bBhQSDvAuzJ5WWaSbk6r8b7RKkz?=
 =?us-ascii?Q?IJLnXB6h9TqZCZcOLCx78agOxWCbOEZNHwgfdERVuGdM2J8W4jOfB2VH+8Oa?=
 =?us-ascii?Q?hifMAD8hcJpwnroJMVV/4/LUjRQnxz1QgF10UrEqrCyTJ7HaUWONBePPfZda?=
 =?us-ascii?Q?L5Iqgv18E5KIrUR/WjqHJmL9xThipDtGd/7SCaV2vmZKAZ0QkGZ0E0qEx10w?=
 =?us-ascii?Q?+MmKj3QADgF6CNNdS4D8NhccbjPJBBrpys6a1el+ZOhJvwkuIIyqhZfHGGmM?=
 =?us-ascii?Q?yc+MUVrqXM8ecY1vkefnFk1i2e8jYxXHsKV5dHetHh63Mux/mE6YDnsnIZNB?=
 =?us-ascii?Q?fW/ANKo3wzi9t4elqSQQ5lpgrHjA0MyANvrVO5bQnd7pueL36I4aOO7iQbxR?=
 =?us-ascii?Q?++Q9AK8OGIT4o66iM0DjFG93IaOjElBt3bPg8Oe5/DkHPDjEaDGgKDuBmWrL?=
 =?us-ascii?Q?FB0ScOrzDYPgu7qvHjspYTZDMQMzygDLhMyOnbbw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0987935-19c6-4f8f-9027-08db46c63375
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 02:22:08.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8fpCG5zDlAWiSsZ9ynLxM4j280dy/kaUwbfDPRZVdkl770CGcTLNh3qh0sqz8vpfGztsOkVFuRLS0ygc57wbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6254
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko and Krzysztof Kozlowski,

On 2023-04-26 at 21:03:19 +0300, Jarkko Sakkinen wrote:
> On Wed, 2023-04-26 at 15:12 +0200, Krzysztof Kozlowski wrote:
> > On 26/04/2023 11:10, Pengfei Xu wrote:
> > > Hi Jarkko and Krzysztof Kozlowski,
> > > 
> > > Greeting!
> > > 
> > > Platform: x86 platforms
> > > 
> > > There is WARNING in tpm_chip_unregister in upstream patch "tpm: st33zp24: Mark
> > > ACPI and OF related data as maybe unused":
> > > https://lore.kernel.org/lkml/20230424144130.1084795-1-jarkko@kernel.org/
> > > -> https://lore.kernel.org/lkml/20230319141354.22907-1-krzysztof.kozlowski@linaro.org/
> > > 
> > > We tested Intel internal kernel and found that, the above patch caused below
> > > WARNING and then kernel BUG dmesg info. After reverted above commit on top
> > > of Intel internal kernel, this issue was gone.
> > > I checked that internal commit:"c3985d8b9c22 tpm: st33zp24: Mark ACPI and OF
> > > related data as maybe unused" was same as above link patch.
> > > This issue could be reproduced in 155s in VM.
> > > 
> > > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230426_132902_tpm_chip_unregister_warning
> > > Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/repro.c
> > > Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/repro.prog
> > > Syzkaller analysis report: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/repro.report
> > > Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/kconfig_origin
> > > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/bisect_info.log
> > > 
> > > "
> > > [   24.638052] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=329 'systemd'
> > > [   28.731375] cgroup: Unknown subsys name 'net'
> > > [   28.741433] cgroup: Unknown subsys name 'rlimit'
> > > [   35.900833] tpm tpm0: Operation Canceled
> > > [   35.901377] ------------[ cut here ]------------
> > > [   35.901648] refcount_t: addition on 0; use-after-free.
> > > [   35.901986] WARNING: CPU: 0 PID: 4095 at lib/refcount.c:25 refcount_warn_saturate+0xe6/0x1c0
> > 
> > Thanks for the report. I am quite surprised that this commit was pointed
> > as possible cause. The patch does not touch anything related to reported
> > issue... At least I do not see it. Could be some tooling problem in your
> > reproduction steps?
   After checking the bisect detailed info, this issue should be related to
   link https://lore.kernel.org/lkml/ZEibZgi8hjfVIBTE@xpf.sh.intel.com/

   And this email's bisect info commit was wrong.
   Because https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/548eb516ec0f7a484a23a902835899341164b8ea_dmesg.log
   Tested problem commit 548eb516ec which should trigger this issue, but it
   met stuck issue as follow and didn't find the problem dmesg info.
"
[   36.521619] tpm tpm2: Operation Canceled
[   36.536390] tpm tpm0: Operation Canceled
[   36.550622] tpm tpm1: Operation Canceled
[   36.597232] tpm tpm3: Operation Canceled
[   36.631157] tpm tpm4: Operation Canceled
[   36.634093] tpm tpm5: Operation Canceled
[   36.639222] tpm tpm6: Operation Canceled
[   36.648086] tpm tpm5: Operation Canceled
[   36.652523] tpm tpm6: Operation Canceled
[   36.660375] tpm tpm5: Operation Canceled
"
  And then the bisect was wrong.

  When do double check step, reverted the commit on top of the kernel, it met
  the same stuck issue accidently again and gave the wrong conclusion:
  https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/591f7c2026cba9889839a16a1a3579c38ad6234f_c3985d8b9c224b359851f0a521ad25a83db6bdca_revert_dmesg.log
"
[   36.813933] tpm tpm0: Operation Canceled
[   36.819376] tpm tpm1: Operation Canceled
[   36.827303] tpm tpm2: Operation Canceled
[   36.832653] tpm tpm2: Operation Canceled
[   36.851290] tpm tpm4: Operation Canceled
[   36.852480] tpm tpm5: Operation Canceled
[   36.868413] tpm tpm5: Operation Canceled
[   36.912134] tpm tpm6: Operation Canceled
[   36.920819] tpm tpm6: Operation Canceled
"
  So the issue was not related to commit: "tpm: st33zp24: Mark ACPI and OF
  related data as maybe unused", sorry for inconvience!
  And the issue was fixed by Jarkko and here is the link:
  https://lore.kernel.org/lkml/20230426185833.289868-1-jarkko@kernel.org/

> 
> I see a critical bug in this commit.
> 
> Because only tpm_tis_core calls tpm_chip_startup(), in effect none of this
> code is ever executd for e.g. tpm_crb and tpm_vtpm_proxy and some other
> drivers that are not based on TIS/FIFO specification.
> 
  Thanks Jarkko's fixed patch!

  Thanks!
  BR.
  -Pengfei

> Lino, can you submit a fix re-enabling non-tpm_tis drivers?
> 
> BR, Jarkko
