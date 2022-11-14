Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F676286EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbiKNRWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiKNRW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:22:26 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4BB21E20;
        Mon, 14 Nov 2022 09:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668446544; x=1699982544;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Gv9v0jOQ6CtxhYrRLYw7BcxNZfaT/xYfpXyS+A1CpC0=;
  b=am8nKSStybvV/M7/XcIdYnhXQI+rV49PlaGOvAyXRCtuwCsIva99ia7N
   4MKxbMGF+nGH3KmmqfYs5+YHzYBL1DZLc+Hg0LoJWcofFW74xrOEDZwMX
   dDWft6zBUIJ5i1t8A89zMP7KQ/CwJIh/9uhKS1HO36TY7hdTRpSsZZWj7
   U6upNPNQ4iDFHSjTLXHZzFDpeJI4tP+kFfpqVFTReL6BHmmZaHTE5lyJR
   SY3crv5Q1XzDzdpr/RsTEa82A5UgVoJ3u6VY9486+bUSCS1zHJRnlhoDu
   6Vg7P3jr/xZ7SuLaaq2+8Oado2grTbo9+oWpmGTl3QC1azH1cZR9W+qju
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313835956"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="313835956"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 09:22:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="781007759"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="781007759"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 14 Nov 2022 09:22:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 09:22:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 09:22:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 09:22:22 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 09:22:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mz1MIWfWpgIVwo2lT/AHSRPG3KFVOxtt7uOGUWSpq8UzidWKFJ2SLBXJx280P/SdkulsAnr9ikyjB5d9neCP0W8WAWq9yF5L8GG8v4urFkSvDsuq3HF9NDUEs1uVpMNnc91ZDVHU7SZjFB8MGON0ZWG0wIsfp7VWJ5etvlZqNSZ35u2E8k4wmjWaN3CEkRJLuYNtW0DZ6jQ/T5n/+Tuavb8uTBQLyejCsMKApn3I3xIeuYZ4ZClfj78bW8y+yaxi0y++qW4iyX0JyGyd+C0fWvEKgMi1rED4bLj35+Ku6CmWrls8yYe8P4W39rHVPwCsGgO2rv4+yt5PholJ9sy7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRAvMJQhsKMa7DZJqjehvJuxaiTtRDR39gOQhsmukmo=;
 b=RGEDtIlKtUUzhm8IgQlXGrzYX/ZF7xk40AtV0he5S000rrd0+S+o0oUN1AowukAjEd7biwpxIGcxROY0acfwAkwLdd1fHi3u1UbRVkDJxE7cvVX3z3cnMStyKSBQw3x2A6qQUXt7JR7Gs0VGk1Mg7nCMOmQwqEnBAf/1Ol18mSkkWd7fDDxvNLjbuNfaocNJca6zeLl2fADiZiUIKWkjNdA4D4w7iEWwsCFdCchvHhPNeR7fsOOr0Wg6yWPN1gMSdGL5eAovMgR9T7H0Y3B2fMHlI/GDkbwLEAMsGPjiKPusU8vmHhsFvqjGV7zmvqm4QfRG3c8qwRcSEIK7eZ5EJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 17:22:19 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::22:fdef:cea5:e8f3]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::22:fdef:cea5:e8f3%3]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 17:22:17 +0000
Date:   Mon, 14 Nov 2022 09:22:14 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Allen Webb <allenwebb@google.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modules: add modalias file to sysfs for modules.
Message-ID: <20221114172214.ilnk5wj3eevpsqts@ldmartin-desk2.lan>
References: <b2d1004d-4a76-ab0b-d369-a38c2d7c1624@csgroup.eu>
 <20221111152852.2837363-1-allenwebb@google.com>
 <Y26UcbviRaoK9a3C@bombadil.infradead.org>
 <CAJzde06b4d065y7KSoGO6qQBgvcVdkUai1WAy_TkrkTCDHS41A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJzde06b4d065y7KSoGO6qQBgvcVdkUai1WAy_TkrkTCDHS41A@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::32) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CH0PR11MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: 895a4244-c9a8-40fc-fd53-08dac664c770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2PEvasPX3X7qtAL8yuSHWu/ptsmjoNTNEl1ix1YEyMcYTE24ylYmkpgzG1NRlaaRT10NnUrLVz5qmSOncqVC2mmW5weXb0Tytnuc8BnQtMJ2mGDy0eyq7T+qGdEhOvx2tOGB4/HURbmt3XdeZ1ntr+mqxGOWHVln+LhjjuO8nuKIeGXs+ZFzLmVUtbvH8H15f50qZzq7YNLBCvqs7svyX85/NGlYwYvh9DWWILqgkmtYwpEbvXQs8LH9Xoe3LUb0vN0fArBWlq436RfXDKfszuYjHcvOpH2Bw7w9zIy/PSwuuKlbYniM+AdvjkcSUGtfQPNkIGLpxgx+hkj3MwxRJf2a/vuRhGEcGPjwJREJX62pXTLb61O97Aeizij9bEvCjdt3bKm5B/mTkUZFzOZsP6VDLceTupfKdL/FmpZaGgwdx9J49eWA50yaP3qeITv0tH6+RWM8U/ncXW/ZOZy7rlRFMhk396Tpo01gJCJ513slS8DT+xw1eEyEjlm7Dpm/FpF4bTQTu6TJHzDsdu/otm+OM+do+p2GClVjtk++3f/JsojuVrgQognMQVVZbG669C479rOapCX6KosFjw9iGdVQkLJMUvY8q7h9LREqszS6vRjK3N986zLPcHNOh2B4oeSf0Af2IA76zE6MOjlx4VmNBtOzUlvZcMiUhdklCiRxsGbrLY94LEz0cOF/TC/W/s2IAfggEkDHTyqnhwC5rM05Jx2kdQj6jaLj1MAiRc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199015)(186003)(9686003)(1076003)(6512007)(478600001)(6486002)(966005)(54906003)(26005)(6506007)(6916009)(36756003)(6666004)(82960400001)(316002)(86362001)(38100700002)(2906002)(8676002)(4326008)(41300700001)(66476007)(66946007)(66556008)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i3F8li3YRjv5UOyj3G2ItX4QXGv7STHAd3ODku1U67lS1usRa2t7MmJTJTL0?=
 =?us-ascii?Q?8vgybbFfXY9AXK4iW2TaJxjaloVpPtc/YwqLsc1oo1dlMcSA85ufGYRBtooD?=
 =?us-ascii?Q?9oKtQ1KkvcJo5c1wK8NN9f/T1lE3XE228R9rhPlU+Lp9c5kadG5VSFUZC6+H?=
 =?us-ascii?Q?BSoXPG90PytRIogbRETh/Cb/s1VG5z6zngR4n6XvNul8XGsMNWWhRZzSnGVr?=
 =?us-ascii?Q?p8Ey9a5lA7QwS0KfbZy8HhLluZbjphzwNSWZrVxALelWvl3q+w/uWsZBJPL8?=
 =?us-ascii?Q?yv96VuzkBvtIipjT0FCbkh+lsQpathhNKv0+GbOPd2QlNBBgjATHUq2wpts4?=
 =?us-ascii?Q?3wNW8DIsUzaF2i2hf0/fOqFLT0gaoNZ0qryeBgNmlThChOmMvFsb48taELtm?=
 =?us-ascii?Q?PakQH1njwLL181/xG6EzwFHolarFAZBaCbGLsCADMvUeAT2vzQ2/guje+xKd?=
 =?us-ascii?Q?MlP/QVkloSJ2j4m8vvx4so4+9CoLjZIu1aLFbleHKOHZV9lCMxt/jajauZns?=
 =?us-ascii?Q?/9CZDnXu+jfMfImC8FWMYSO0QmEaZxjnJQvDrPicsIRJrmHMvGXFdXGKDcp4?=
 =?us-ascii?Q?97BPPCZExNNpHmXSZzQG+PZRYNAuIWHkKtlLgHgaRWssNnO3rCjH1qiBrGGQ?=
 =?us-ascii?Q?6kZWRgpY3KvF0LHKQvel4TnY4FP6l+hn/RTbunX/S0kSrmxpldZE5an5LR93?=
 =?us-ascii?Q?xXqEBC8vmsv8S/1w8ccayDdPvZrny7phXGDekfvzqVfIeqV3lo1a8piOmRNR?=
 =?us-ascii?Q?kFEPgnHk5AJn2tpsHnpLNOhPiaoHFdYkGNB3vmpjKSwQb0rYNKlWieuZjB3R?=
 =?us-ascii?Q?M/X2thTo0LWJzweIXpOlH8ViDPi+9oNpN1Xqpa2Z3vqtzXFUONC+af79JzsZ?=
 =?us-ascii?Q?JuucRpKCTBVuB6vO0TNlz4NSZLq93+SB4zgTtcbyKAptTTQGJnuurDBtytEP?=
 =?us-ascii?Q?ML2f0gpWSPt48x/613H+LCV0NwMOSVYpSKnXdBgvlwQ0+kjdAg3X0XXOpJKe?=
 =?us-ascii?Q?g5h2jAeCj3+xq1OjYp69hZlf2qz9E5pr7C3YteoXG+r2D1R6j7lQWAr4jTf8?=
 =?us-ascii?Q?9tcB5Rln5E4jy9cOHsZiyfXI86wttNmL/0CplY8d8Xkz0Xy2ChJj9P+fYMmS?=
 =?us-ascii?Q?V6UKNAqc+av6N/0e5rX1aEdMKqqV4hevCtmbxYdVS/BOYODJtJGK2Du09vAj?=
 =?us-ascii?Q?0D+A6lhWWjFS3kKuv6/Pg2FY4z4xXotouJwNjSQ1kpwNudd0BlfWq11Hz4qD?=
 =?us-ascii?Q?e6JRAGjssIFKfK4DoXp+P7/r/88bUihXDCAwJ4HBLIeNalqg+83e2WLNwtF6?=
 =?us-ascii?Q?Uo+jn8/BaVWJHAqQwEw2kRsyo4rNxLAAk+z9VITFCW+sBD+drN3AsAznildi?=
 =?us-ascii?Q?kVquS67nDy1HIJ3EHhGWeLsTOSwd4qXfqabU1sk7R9ETX1WgKNTf7Mv/R87C?=
 =?us-ascii?Q?zzHisCv6SnSvnMGbGgJr37Igp80FUiumnjRJqcBHNJ5GbyjqYNxG1fvGz2Ih?=
 =?us-ascii?Q?W98LCXnOjGGUWomPODQN4JPuTSDmDWFt2T7OSJDdbUFavdH4s5jpzWFCV5m5?=
 =?us-ascii?Q?tnjtjVG7dtqDoFZbylzC7AvFvS/L9fKM2HLs1a/C49b4QqZWtGxr3RmRg0Or?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 895a4244-c9a8-40fc-fd53-08dac664c770
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 17:22:17.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXJbVnnl/9ahAQaiQ0CmvEByjxTrO53OuHD3tQCqyElhQlmxi+fwAFYA3lXScou7o0L9y/fVcNqB/sTXsqy0Zs85m2t+GVARnmc2p1leTnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5300
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:42:50AM -0600, Allen Webb wrote:
>On Fri, Nov 11, 2022 at 12:29 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> On Fri, Nov 11, 2022 at 09:28:52AM -0600, Allen Webb wrote:
>> > USB devices support the authorized attribute which can be used by
>> > user-space to implement trust-based systems for enabling USB devices. It
>> > would be helpful when building these systems to be able to know in
>> > advance which kernel drivers (or modules) are reachable from a
>> > particular USB device.
>> >
>> > This information is readily available for external modules in
>> > modules.alias. However, builtin kernel modules are not covered. This
>> > patch adds a sys-fs attribute to both builtin and loaded modules
>> > exposing the matching rules in the modalias format for integration
>> > with tools like USBGuard.
>> >
>> > Signed-off-by: Allen Webb <allenwebb@google.com>
>>
>> Thanks for the patch Allen!
>>
>> I'd rather have something generic though, and it would seem kmod [0] already
>> does this, have you seen the kmod support for builtin.alias.bin
>>
>> Can't that be used?
>
>Probably, but I don't see the builtin.alias.bin in my build. Is it experimental?

no. That is generated by depmod since v27 using modules.builtin.modinfo
generated by the kernel build system. Highly recommend v30 though
as there were fixes in v28 and v29 and some changes to speed up its
generation/use in v30:  See entries mentioning
builtin.alias and bultin.modinfo in
https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/tree/NEWS

libkmod/modprobe/modinfo also have the corresponding changes to lookup that
index when resolving aliases.

Lucas De Marchi


>
>>
>> [0] git://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git
>>
>>   Luis
