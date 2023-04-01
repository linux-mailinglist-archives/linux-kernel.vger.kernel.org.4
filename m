Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B896D2EFE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 10:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjDAIDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 04:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjDAIDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 04:03:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F36C17F;
        Sat,  1 Apr 2023 01:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680336231; x=1711872231;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e1lVFNVx510RnIi8ZZOjJdptv2AMeOCpjyODYWtZBvw=;
  b=Uvl3AZn10Yr/zxTjtKqB2cJnDxYmFJ4Xf8GAAtJTroxxDoED08oLf929
   CLldA3Ex495IkbEWOMWKsk5whxz1OvlyCt1i063j5yxjlhyTu67LfGWs2
   gi1Omm+aQZlr7bPE0tfDL0DzrNrMsxgAs2R0jwZt32l0ekuNlrbviq+xD
   4DrYNoTK1lga+NW/kbSBgeCc1T1/mi06DTCGLzzPFu1q9g1nGzQY+UI5T
   xf70Vl5gPRsWSFEg4HLLtWNvPCXOygbcrun/ZWn2k5iZFp4UgF/pmr13R
   Ax/K1ZpRWXqKuea6wGr5AwO29GMW2MWpYt/ItKHWOF0tY9di1mhAfrAGo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="343311641"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="343311641"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 01:03:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="687958412"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="687958412"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 01 Apr 2023 01:03:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 1 Apr 2023 01:03:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 1 Apr 2023 01:03:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sat, 1 Apr 2023 01:03:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sat, 1 Apr 2023 01:03:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoEJzi2XBkRhWKSZ/MgC+okqcUaqhmcRYi11peEaECCAliqiEQxQPUurpniS7hO5EIJRhOsI1/51/7KGg/GCq3ARi4yq16zCqe6AL1rmqkSFMdLUbT6OQRyyuHfKQnId9jWFNg2S+/hhhItEt4akVT+B1QE6A0HqxLam4hY06dki3/CpqDfekbTQRMU7ZIoI3QE38BCr88jzyTcIQ8Vhw33sZtuxbUlf4X4fknWjViz11GaE0/dm82Q22IOO2I9osvlq+1sKpTFzd2kD26+ZKBfaF9YyYqUt2td8/AMjIRk1wvLWKUWwHvm1bYZvtlCdg461Xob9TelnTef327WtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0SS7WcPjeAT0k/quqQOkH/fUjX1M+ekKiZeJGv9n5k=;
 b=oYcZL2P6OFb8cd6920v/I4hrBjEBun9R2BcDI4RkkljuAx575GN8C60I8V0o6D4nMYKk7aId3m4VbmVe6gl7wU46sRS5Rf0yi2w3HF62sYI7zp/IP1yyqjxIgaoLO8BjlPsTgZKten7DgpsGy2K04vPoAugDoHtDDAiRqdJRjVK1l7fhXzIG+Wi1GZ2g8fITAQnMjj+mErt+QFrBITuX/VbVTbJltTS0FiLgw1+VqKzptsbsWCU8LtA8hUf/dqqVVfyO5amleaCeqHGoRcuLNYmbKw2sNuB7ZjUXtwnNLCexFgUvdH3F2jGksyo/tMAOlWZY+wUja8mD9iZ5LJ8h3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH0PR11MB4774.namprd11.prod.outlook.com (2603:10b6:510:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.31; Sat, 1 Apr
 2023 08:03:48 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6254.023; Sat, 1 Apr 2023
 08:03:48 +0000
Date:   Sat, 1 Apr 2023 16:03:35 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
CC:     Ye Bin <yebin10@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Yifan Li <yifan2.li@intel.com>
Subject: Re: [PATCH] PM: hibernate: Do not get block device exclusively in
 test_resume mode
Message-ID: <ZCflV98lGOSIeF88@chenyu5-mobl1>
References: <20230401154832.320999-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230401154832.320999-1-yu.c.chen@intel.com>
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH0PR11MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d4b4ab-de64-4923-d91e-08db32879f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIrQ/9Pt2rLt47HDi7o9fbDPKjjtOOtOYxP/Wo4tmN5N7cKDDOo+09+/4kkMFszP1BB5LyGzGM7FegwY6eAez0owRfqS6fm5YLxSzYHn+SxTLuiHzpK6J3uQ6yRfgEVHFbHxrawKWKQNTMnx+GR5hGev1kkzBw40hvWvQXcnuz3PWoWFryfERkqedSUXbLgHAsV0PK0GRlTWWKJRIeqwNaIpAtYFGNWOUdVq/oGQltq7BoCIdn9vBJCHh6Bd14YBk31+oH+aJPC2VrKEks5795SFuLeRdmw/lUsxjxg8F2x9p0Et/0Q4dK7AYUrXl5fShQjd73mAwerEMbBk1kii4yYDZEVWeOcUA701B0ixsfI0J6LQzxSCBC8HQmScwg+sBLs5ozevEqLPpCMUevO7csptYEHGhTFPOzT6EjAdhSWcE/qbVEvL4LHFEImC9HSANMG4GFqbrQ10eZbPdhhAVCV/DSw3fZoRZu3PZDEpQugEc6lNYo8Q7U5euf6MS8rHFXbLODLK6D326dPNgVEHZ99WFt7eUbVkjuS9cAAqxz2pbuqj89nX/6BociXxE3Rl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199021)(4326008)(6636002)(316002)(66476007)(66946007)(54906003)(8676002)(66556008)(2906002)(38100700002)(110136005)(478600001)(53546011)(5660300002)(26005)(6506007)(33716001)(6512007)(6666004)(83380400001)(9686003)(86362001)(41300700001)(6486002)(186003)(82960400001)(107886003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gtKN+qqaLEGTEkIVUQScLHJAm1HvNLRtAEBJ+9aWaip40W6aGrLpHwJYWth3?=
 =?us-ascii?Q?cepbJUhv+GroNJ1FA1/8RIURPcQ335jRx5sQoo7Z72Gtniizw7XEUtEGSZGv?=
 =?us-ascii?Q?cSd9+CigqheBhh0zxOAUtY2TbicJKsghqpVQw4rVXKWUlMKxcFxflGghShwh?=
 =?us-ascii?Q?RBWU6K6m/ubWT4Kocx96Zbtjy2lbWnzRfaL2+Z5Sb1A7cENVH4+rjXuKui8r?=
 =?us-ascii?Q?xAj43G6Y79e1ipAL8ciWtbcMXdlmYRY1OgaWG6RAZRZIcMNQIHX5fN7j3l7x?=
 =?us-ascii?Q?YSW5YsgZuweSix3S9ULSwXH+D/fD0JlY9t3j3zCD5d+OOxFsLEKSvmsU6bCE?=
 =?us-ascii?Q?1Oc5GTYd5Pj2AS9Fu5T7+5p1gZAiCWs3dpIM+E/E9dNKpHIdrJE4dI8n4fMw?=
 =?us-ascii?Q?8j0pvcOhFaoSQlMK7XJ9/nyy9zojhQp09LbEmrFHM1OOw+U2RL3Ei6FmAide?=
 =?us-ascii?Q?Qco7vPNMhmHUTaHvs5MXG7URLDMKwQgYs5TzCsryGBCsq4zB+g6IED+SdLcd?=
 =?us-ascii?Q?Jc9cKiqjagqMpUQkuAKpAIzqxHCTHVgw1esHNiyCX+2tmLA4BiQhk3kV5452?=
 =?us-ascii?Q?iNRDJtx3lDOUSuP+UOOkPGniCOztD+b1LXb05Nhv8WpKddXIyo/hAG1zbNub?=
 =?us-ascii?Q?tVceGRoe5Ee8BkNiEtNOCCxsMpuBuWPoJkV+x+O6PFjvFRwitG5wlsKYHdZY?=
 =?us-ascii?Q?UrRIExEeBemD1uJuf5EL03sq+4nBSa6zQckpusTnjsr3Rd4ErVWoBcYPErDP?=
 =?us-ascii?Q?4vx+3kUXvQovbqw7VdXUzYPmoPi0K2TjYDFNxcMSkbDYZvaLYkxR+Zq77w4V?=
 =?us-ascii?Q?HnDLbygYrpiRSjjhPwEkWe8Y1JqHeumACzURXCH43O4CsG2tEgZLqFDwWrQO?=
 =?us-ascii?Q?+PYAjZgFeg+lV4157ffLCMeuXV2SFuu9W4IA0QF70j9cUlzRgfic7f8A8glG?=
 =?us-ascii?Q?Jxndd+oyUidrBDRQ5v+qYTn4C5bmDCeQ7rXNH2sawZAko/8TewikYkEQ/O8i?=
 =?us-ascii?Q?toLN9pULIgswx/yw91z+j2QG35V7TsKyF+Tpf3fNzsAaLTr/QNm1jWi2Ww9P?=
 =?us-ascii?Q?t6dWvpbL/vtCf1p7T82J4CW1X3X64loVCkriSn7VGIAcDDwaKFFMfXDUUPW9?=
 =?us-ascii?Q?prICDH5y/AWJfxN9n5PnEUD8vTbBvmoSon/c8NU6zOV3oxBFcChYsP3buRqB?=
 =?us-ascii?Q?qZfYrFWKc8cyG9i2j6r5vTS6gCchu2ANhe/mbzIOSRrZ32r9ZPp41lcHNnoy?=
 =?us-ascii?Q?OQqAQmpT6bfLLY263w55/BZA345VHhB9hr6p+kIpB+CUHdyYzROT/ck/yIDQ?=
 =?us-ascii?Q?9vLHvg0bMriUbXD21KeIAFqXT/unF8wMmajCVQM+ACwv4AH0U/RF2ElRDswS?=
 =?us-ascii?Q?O4V7EYs1C8sKr+jR9V3Cihf0K8nZ91sbXF1aFAc4Ct2soWz0mowFK9cgE0qp?=
 =?us-ascii?Q?g7q3dUIzDiJ35vnPItdddbUXjmRsZ174O951udZOcid7hAcPrIu1J9xxKoC5?=
 =?us-ascii?Q?A8IqnyjPxkZmaUTbADflQVxz0DDa43NKNgQErLMTaSif9fOHdMAIwxk58yI8?=
 =?us-ascii?Q?wJRMoVybURE2kCaZplYzJcmtEoZMBfdHOCn4BlTb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d4b4ab-de64-4923-d91e-08db32879f0c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2023 08:03:47.5667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KD9k/0ficgpkQKvCdQY85LW3T4g6IML/A8VARAf34Dmu2aIedOXQmMG78fGPdmLl5ElldtSMG8B8ZO0m0SaMvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4774
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

On 2023-04-01 at 23:48:32 +0800, Chen Yu wrote:
> The system refused to do a test_resume because it found that the
> swap device has already been taken by someone else. Specificly,
> the swsusp_check()->blkdev_get_by_dev(FMODE_EXCL) is supposed to
> do this check.
> 
> Steps to reproduce:
>  dd if=/dev/zero of=/swapfile bs=$(cat /proc/meminfo |
>     awk '/MemTotal/ {print $2}') count=1024 conv=notrunc
>  mkswap /swapfile
>  swapon /swapfile
>  swap-offset /swapfile
>  echo 34816 > /sys/power/resume_offset
>  echo test_resume > /sys/power/disk
>  echo disk > /sys/power/state
> 
>  PM: Using 3 thread(s) for compression
>  PM: Compressing and saving image data (293150 pages)...
>  PM: Image saving progress:   0%
>  PM: Image saving progress:  10%
>  ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  ata1.00: configured for UDMA/100
>  ata2: SATA link down (SStatus 0 SControl 300)
>  ata5: SATA link down (SStatus 0 SControl 300)
>  ata6: SATA link down (SStatus 0 SControl 300)
>  ata3: SATA link down (SStatus 0 SControl 300)
>  ata4: SATA link down (SStatus 0 SControl 300)
>  PM: Image saving progress:  20%
>  PM: Image saving progress:  30%
>  PM: Image saving progress:  40%
>  PM: Image saving progress:  50%
>  pcieport 0000:00:02.5: pciehp: Slot(0-5): No device found
>  PM: Image saving progress:  60%
>  PM: Image saving progress:  70%
>  PM: Image saving progress:  80%
>  PM: Image saving progress:  90%
>  PM: Image saving done
>  PM: hibernation: Wrote 1172600 kbytes in 2.70 seconds (434.29 MB/s)
>  PM: S|
>  PM: hibernation: Basic memory bitmaps freed
>  PM: Image not found (code -16)
> 
> This is because when using the swapfile as the hibernation storage,
> the block device where the swapfile is located has already been mounted
> by the OS distribution(usually been mounted as the rootfs). This is not
> an issue for normal hibernation, because software_resume()->swsusp_check()
> happens before the block device(rootfs) mount. But it is a problem for the
> test_resume mode. Because when test_resume happens, the block device has
> been mounted already.
> 
> Thus remove the FMODE_EXCL for test_resume mode. This would not be a
> problem because in test_resume stage, the processes have already been
> frozen, and the race condition described in
> Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> is unlikely to happen.
> 
> Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> Reported-by: Yifan Li <yifan2.li@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>
Please ignore this patch, will send a refined version later. Sorry for the noise.

thanks,
Chenyu 
