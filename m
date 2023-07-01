Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EBA74457D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 02:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGAAUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 20:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGAAUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 20:20:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026D53A9B;
        Fri, 30 Jun 2023 17:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688170810; x=1719706810;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5MBvmA3hGni23DEtMj5j1MCcSREpQT+SEdinTMMCMx8=;
  b=VTYq9nytEhaivHAj9NWLNm3gzUmp6i1+bBmBrEI84nUGEAxb/aPk1VfV
   TR638cZ1jdSiBi4klFLRvglCWWvCiZQj9HVAqWDe/oCy9bVQWk8TUJLCy
   wNUccwHDacAYfunH9j5tB/4h24J9ZsphiwNl4EBSB+FDXsDwYBiGDrbj1
   5hQYOELrljEme0+3a0MRm/FCveNCKKh/69+E6zhzEVeasC72XoOzTlfP6
   xbWThX3LLsIDGj+obQPr5YsxS9hbjpfpeCEKa+ze9nzrWK8wY5iHqZuRY
   X8oyMwa3JX5pfBFPlqnpdee8stI6Wzrla8TzToxsp098GC6X40vFKsPTA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="393254647"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="393254647"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 17:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="831130605"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="831130605"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jun 2023 17:20:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 17:20:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 17:20:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 17:20:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 17:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JB0ksycTQp4Y2YBT+lfs6U2DjXYkUgomyc1BGe976jKQKlhOUJ0Cy8j0ffitPrkOBn9kw7q3ylYj0eb1FaiUmYnlmaQgjSdGBh1mOull3eeUkPqG037hqV/IppTm+7QBUVgUT1B0sYQmKcTyeCKfD6oiLdZVcwNESMsVALji28R3CFWuGKR7o0zkdbvLXhkMGFdhVTZ+dDcl3sXlgz02t5IS5X3ilCEZTbQBum6vAYRJR3U0FwtaFGohbH1kXW4a2ge08TAceVOG0c7jwVyqN+GpvAiZt9Mwvo+C3o8Hfh6HMTobeaMkIIMrC+0IVtuKRpIV8h8AYleUitFki7KA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sL5FHyXQ4oYlHPicza0nJU4+sbt+rlkdTr/2NA06KpM=;
 b=JgXmFHgw3YNdL96QzKSQPymxmSfPKvJwJBGGA0LKcSBygbWVaaef26X4Mg/JTuT3a8qY8iCV85GBvvMMetNXA8C/EtlOzuJEL+OY+iVx1nGEwmDa6NZzLmSKlSrtunvkZpwqbZfzg0jxkDmEVkb75NA6c+j5N0yqKrdZNCPosPeKx3A2kZxmziI3seqX7rPNcMW7kXFNeroQXb/0VhOjvaArCz4YPfB3vNC5cW62RCKke93h5s0RcoMinO//q80IS1IM6QHmzVGdMeBBPEtgUje/OBkmSozlJg+8amFspUvviZ4SSJ9kMvFBK89OAY9/pePQopAX28yVEyK373fJGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM8PR11MB5701.namprd11.prod.outlook.com (2603:10b6:8:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Sat, 1 Jul
 2023 00:20:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sat, 1 Jul 2023
 00:20:06 +0000
Date:   Fri, 30 Jun 2023 17:20:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v8 00/14] cxl/pci: Add support for RCH RAS error handling
Message-ID: <649f71329689f_14494294cc@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20230630231635.3132638-1-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230630231635.3132638-1-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:303:b4::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM8PR11MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: 50531197-2f25-449d-b795-08db79c8ebce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mo0OMiiNisFKYdpeMH0lrsDzJuQOM2AUfwj9Ut3g1PUwH2smJpJttYyk4Qa0yNkaiJZFpmo/tTIMxheaXMaPu41HHgpjt+NUDUNzb84JdM+NFo3f243MzukhBXk56J98nbzItMAOLO0MFjg/DM8W2v9I6cOYqcOqmVlOPoKVuSESyLpZU9Sk2+UbB4AqOwVhdx7OeePHDVcLFSYehh0EBgr8MpDewrqz+0vD5craKEC93BiV7pdJhimepqruIFnKLrylzskm060ZoCs75IJnajQYAjbHfkIgf6hxFRw21tBzhi1VJwJTsMNZtnpbVoYVfzNtux1+LKCfhd5alTdHS+n5unYKCBd/cVsM79zRNb1ygqW5rkChNkjjQCQhGWZX5E0R5ZzxD9C3XZbL3HhJad27XJnvhbPZHG6SrvaQ3QvA4/q12zysRsa3HokJvivwFmhE7wOVuXxtOTayDIFMMTa80taBx6e+mstNkiFvul2aoPYK5Xo6E7hZZ0/YDF0NAMzqsoGh6XoQOff4jjkJ7yQNumrSJfOmHL03wJtndzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(83380400001)(2906002)(38100700002)(82960400001)(8936002)(8676002)(5660300002)(86362001)(6512007)(41300700001)(66556008)(66476007)(4326008)(66946007)(6666004)(316002)(6486002)(478600001)(186003)(9686003)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tu162WkGC3PKUgInZ/VHhDUJLaI2h8huQYlMkYEP8jVuyIz/N19x01MD7/Tw?=
 =?us-ascii?Q?W0LH4qWX1YRTh6qkxHRv6Ug4k2irvOThG6aZWPhwQCBJ+siCQqKnUV/CUi3H?=
 =?us-ascii?Q?5S6ak2qnkuHbpthFXdugcpf+lW3gWWberjX6D+kSaVy57b/Q/tKNjY+Zb/J4?=
 =?us-ascii?Q?btIrZ4E8bXj3GzAHAXxPeEHw0pPTeU/TGoXWEWqODj5guNlczob3SQDwzkTY?=
 =?us-ascii?Q?+tM512P7PXZrqJ2Gi9nTARfITA7PF84pT5ZoBaPTGjCOk8FRBf0X8KnmKon7?=
 =?us-ascii?Q?8nZCOq6bQ4EeybcM12OixtJdxtBmo8DL1Ly37CdTYverh3rIA6pwe3Bjbj2m?=
 =?us-ascii?Q?0l76cXTYuQPUsE8MRwf9cYpOtwXvTGelGp38PhHKA3cpV1hrSb6NVxsgSd67?=
 =?us-ascii?Q?t5E/T5wc0MY6oNcHIXLeU5JbMp3tpcmdJscfpe5MQHVtPkQkpjOwXp3LzmnT?=
 =?us-ascii?Q?CBGnte/pw85UBrOmO8W2MiusdOZtna1lMOhCSCEDtHVeumzYw7Ax0PpIexy9?=
 =?us-ascii?Q?z4U2P4c2UJ4rlSPEOTl2bstWrqkg9Pgibf8iCrbV2HKrZBkrX/KpFM+/I1nT?=
 =?us-ascii?Q?v9icCYPiefEtFNJn1Cl9wYAmsjGFNIt63ryVVg7H4mcRwP4lpANpeFtGi0dq?=
 =?us-ascii?Q?A8Dw/fAnZUKwcmjK3/bo7BT663qsdNKucgkm85A5bDRe9g4ZjpkfdDKVN1zT?=
 =?us-ascii?Q?jtpqaNp4nKCdNAbMZsp4N5FhWWxYh0i/RnCQITBO/U78fO9l5wyI64R+j42P?=
 =?us-ascii?Q?dYTj7VTQFmoSKe4HEYRN9bHjhuix7ryOuTcj2kbndEw3t4UBh8JizwbxVAfc?=
 =?us-ascii?Q?iyBpoAfNN8vQYzrU9dTWGViOcmlFeAEopdPvGra1atIxZiNj5UYSxZ7hM9vG?=
 =?us-ascii?Q?vUp9nPEo8T4QwI2usi+yLo0DYvt/W0OP7oS62Mhax6hbjidjpUBjV6e5WTsd?=
 =?us-ascii?Q?Ucw7OndbR4VqsU0qgW/FkbvOwaRxfWF6UMRSOR/ZCA9bodbnPR0MRPNNTVxt?=
 =?us-ascii?Q?R3LSkP/rQR74IUqHaYyGqBGfx8sSh5vMms2af9+202RMXEwQ8THhYUK47Plm?=
 =?us-ascii?Q?uJQC7vIhNOQdZSJpc0OGoCcalitZsRvdInlLZ9IQ5tEskFpc0bi9khmyAM+w?=
 =?us-ascii?Q?aM9dQKScaUcryg+jCJfZoTqwbdp4BHqIZZf5VP9W/+Mo1cSgOry11uWlJQaQ?=
 =?us-ascii?Q?ugzgv6PGhzIVkQKTS1aPipf3AoC2FU1HGmw8OZIWaa/7jQZSU5NbjtGVJonz?=
 =?us-ascii?Q?B3noNOLsXTMJib8Veo9Z+vfoQRhd4eeyNvM9eOoQRraDnb3FFqCgXUFF0xvq?=
 =?us-ascii?Q?3zBBy15W4SSLeHXOYdyR0gboT1D5FfoLHHsR7y4JX0QvQf9e78tGgtzdn6rx?=
 =?us-ascii?Q?9PETl/Zj8zkRzxzmKA52pho1V1ezpLp3TCjUoBx5AHVUPZrVnxs/+g/PeVZr?=
 =?us-ascii?Q?eyWJoTnPtrMISY8TlG/4jvYKBYjs7uptaFnk2m/sPNawY6MAsNsMg9+i6Wt6?=
 =?us-ascii?Q?MCOqTuZzqfIx5DD2f43H6QpKSDKb1sD2ZVcXAWDXhljqUYdss4AqOploxZmh?=
 =?us-ascii?Q?piwS5NojL6PLnSmBaxneSogkeuZeDmpHBp6E3SYPw+OLByr86rvnX/tAN5aN?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50531197-2f25-449d-b795-08db79c8ebce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 00:20:06.1126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ay+87+p53Kn5Pmn2UO69L8698a4Ql5Hrd0/LbiqSRNleAOt2hm8o3D0VKz1il89zpGUTqYahY4WmNL4kj+vuvi2PTkRCxI2lGD/PlHE/8sI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5701
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> This patchset enables CXL RCH error handling. This is necessary because RCH
> downstream port protocol error handling is implemented uniquely and not
> currently supported. These patches address the following:
> 
>    * Discovery and mapping of RCH downstream port AER registers.
> 
>    * AER portdrv changes to support CXL RCH protocol errors. 
> 
>    * Interrupt setup specific to RCH mode: enabling RCEC internal
>      errors and disabling root port interrupts.
> 
> Changes in V8:
>   - Rebased onto: commit
>     0c0df63177e3 ("Merge branch 'for-6.5/cxl-rch-eh' into for-6.5/cxl")
>   - cxl/port: Pre-initialize component register mappings
>     - Added patch to pre-initialize component register mappings.
>   - cxl/pci: Remove Component Register base address from
>     - Separated removal of Component Register base address in struct
>     cxl_dev_state to not break functionality.
>   - cxl/hdm: Use stored Component Register mappings to map HDM decoder
>     capability
>     - Implemented a less strict check in devm_cxl_setup_hdm(), be tolerant
>     if HDM decoder registers are not implemented.
>   - cxl/pci: Map RCH downstream AER registers for  logging protocol errors
>     - Fixed uninitialized access of map->dev in cxl_dport_map_regs().
>   - PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem
>     dev handler
>     - Fix typo in patch description.
>   - cxl/pci: Update CXL error logging to use RAS register address
>     - Fix typo in patch description.

Hey Terry, thank you for turning this around so quickly. I will have a
look and see if this is suitable as a follow-up merge for v6.5 next week
since it would be nice to finish this off this cycle, but no promises.
