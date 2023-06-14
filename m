Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D262730021
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbjFNNdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjFNNdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:33:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CD01FC4;
        Wed, 14 Jun 2023 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686749623; x=1718285623;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H756GnvTH2vIA46z4gQnq21dgdKIPRLx6c66maEb8Oc=;
  b=mjSLugAFnVjtYPnNlyWJuoaiYOk1V4JkjxSiSldNFYS92TQpbFIgGe5t
   o5p1YoW7mHnA8kqE8jTec2fsFX0YwlhCrUJ7tcRomd3+FK9yvTqq5l5w3
   4PfFufdCkM2Lrn7x0JVIJxU53SsxaD6oZZ1k4Fwv0Bcv1nDGmd6pRKSB+
   VWBWayFMGkmAdoNbv71ByYFNlbiUfbdLwF1eIXxcNzwbP0txqg2iaTjls
   AhCfOPE1BWI3qqo2bOluU5kunNUoccOHj3xyyABbaPdcagtbevfOZRkJ2
   ZvxRdm1d8YXFwlAg9FkHmPFe3FM0VLF51NXiXML6XHXY43ZNPiXt7yFeb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="356103766"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="356103766"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 06:33:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="741841798"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="741841798"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 14 Jun 2023 06:33:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 06:33:42 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 06:33:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 06:33:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 06:33:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4qWQpSjNPZh5FOcxv7YUXvJrvI7/0dPfG7chItEA8l4DJgsjTFU64AI+l6fbCBABbZsk2FTco7D473ZTMzSNbHKDumC3yplg3ugOI0IdSLjWqSyyoKzn+zziP20MqRpvbt+JqlsuAaoiN15g/be5yEYPwo1MdcuwFtj+F2nd+H53asBptC/VaZ8mnZYrSRjdZNB5ZDth6p9R1V/RzPYq0rWM2o2ucZaiVcoltjbuiiA9wUn5iszrEmhdAjEq3nTRsM1fGc4i5qkL+QR7Vu0qBy/0GvNkYK4xiY+EAD9fAh9L2TyHIc+HZ6+3GlVn3A2ZHkKkULwj9EkmiKJaI3C+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsWNHkF6QSVyu9MzKV3TU1XK/hJmT1wh6PzzrBPvDIU=;
 b=HbuOGZpTpWkLq+0BcrKWNwcbZx9KI4S2B/YTXqzbiBSFI2AwxqD4gYA0eKm72ACJsfa/OFhI8fz2UtdqW+kWZ6lwVQt3hTRA4Cvb663SlJCdnnTi++5tzT04brZWrk5fGn3NrZ6Yaaqe/lPOnGmbpEENEJMoTqEdGiw/ry2DUZHI2wm1MZyOLPTKtD54g9WrtGlcD4HmwOePEneacsH/lM0LmbK+yAvK6LnUVg1B3PV5u0mHvWJRZfBMHusvSAr202X4gYZnue0jgpVb3Emw1MT1hFJo9wRu/050hsZaq308btdkP7TTS7ME2k70/RYc3ZxA6mr/n0sOu9olOFzqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6372.namprd11.prod.outlook.com (2603:10b6:208:3ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 14 Jun
 2023 13:33:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 13:33:37 +0000
Date:   Wed, 14 Jun 2023 06:33:34 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Mike Rapoport" <rppt@kernel.org>, <x86@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] CXL: Apply SRAT defined PXM to entire CFMWS window
Message-ID: <6489c1ae90a38_142af82946c@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1686712819.git.alison.schofield@intel.com>
 <20230614083240.GC1639749@hirez.programming.kicks-ass.net>
 <20230614101051.00006602@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230614101051.00006602@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: b074df41-4e13-4ed7-25cd-08db6cdbf521
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: seQi42eTMABbCPWsEFnxmjXeLpTfDd3Sg277DrGty7Z/e8CpyFTYyK2wjptGAE+zvmejg2j1MVtSrHv8fyL2Org40AQ0f2q5oRSyhgyIdDnmwAvEPwtKndiYqmYTDkEgR1mF2Fhj3QeR+tlviatTDTkadn39y/ty3HijkALQ0+E71Fyk7+Gw2KGMidLEfwxX87edOvKkpV8Z1xbWfiz3qkD8OQLQSxwa/I8dnG62k7MDMBD72KleTtvmlvjf+xvgDDKupB4IFHSnbvz5Hx14KzqdT9xujhElWaamKjvzODwTMIMkAbtAMNnnpx/J8CfQqbC58U7DNna5w7KNjp7igcqWhF/TCQNqHe2ilkQCfS2ALPlciY/lkUt0PcQHy+lqxNshkVIj5UF719difCtqEJPVavphrmkoHLpFPwGkUTocr+KCfdU73LjZzzZ4pk+W1I+RErU1xUUbOLJumdWNuAOq0oTK9x1+OuSBa8VMdlQ09pMKton21CZTH9tlQXCsCb7C7a2/BD4GQXjDAD43Q5ygroOMsUzE66suf2XikK4VU56sKxC8MjnRldhMcHRl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(6506007)(6512007)(9686003)(41300700001)(38100700002)(83380400001)(186003)(6486002)(6666004)(26005)(66476007)(66556008)(478600001)(54906003)(110136005)(316002)(66946007)(82960400001)(4326008)(5660300002)(8676002)(7416002)(8936002)(2906002)(4744005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kCeXZHScmdYh4svVjg0+OgGgNy41kYf+RBHWvU8BagkZJf4lGfSy9wZyegtX?=
 =?us-ascii?Q?dwBc8XE1O2K1uyk8cJTDGVW5iblsd/3kZdQVGbmffusL8ahJX2ucT1ypxlh3?=
 =?us-ascii?Q?SxmgInCffSWqwtljYeRgtdPa4Btr8hOdlYUSYGcwmWrLpAPWHImv8Ye6BbOd?=
 =?us-ascii?Q?EQS6JobH0MERU+t42DZRQVPWVWakT8rKwKZOhhn0MbTeOB0KIPU050Bph9hi?=
 =?us-ascii?Q?Jlu6KhBUSaHaMhl1VRRrZfssu6Yt5LB3IAgiys+Ghzwf/lkAw0szq2fZLMD/?=
 =?us-ascii?Q?V6qKDC9V8s6HHhLk4Tu1E0cNUlSW+DFPjOgbHlWP+XUBv/Y7AG2OkOqKMz/8?=
 =?us-ascii?Q?1HICZpBAU6ifw56XgP87iNvAuA6Csw2+RjRRGUOExbUEHZf747Saj1PxJPxf?=
 =?us-ascii?Q?kbGk1hIIypzxZhumxvYLJCMXMDkiYQR7pIpz6pWQFRMVK+NG3XyTLVoFijw+?=
 =?us-ascii?Q?lY81LkYI8dMQG9o9h5geHjKlL3dKR1kI9otCVfdRZadBKjim+tYzpoJliyBN?=
 =?us-ascii?Q?h3KZsFVZs6Ld6UFaBvtF/TyrsTDoaM2N9MziHLshwY7LytFJs3+sd3fQIasQ?=
 =?us-ascii?Q?jMPa62FvaTpf2Nvw9L1POLtuYMrneQTwSJBp+d/773z0tB/sl0lUOgGG4+GX?=
 =?us-ascii?Q?8Q82fL3blm/Rp2NHkz8PbR7iWxPeEM/VolrzF+DP/4/pKA3ypkj2dynlJV/W?=
 =?us-ascii?Q?AblAr2gygGh4jyMz1RkANLJzSVb24KLIHCTwWi9t+aUZusJoMFu9DqC1wXpW?=
 =?us-ascii?Q?f1y0k8tFXCbCV0epdXxSssChadyk0/a9Br8pdnxBLew9rTfX4Z2O++j7zxlx?=
 =?us-ascii?Q?fvfvDkJVEOZ8ovMFVRT+mgxj+u+GmocGjGOQHApMZ+XZIakbl+YEMBtCHFuQ?=
 =?us-ascii?Q?ABFjlQgu/e+csHqYSoR4Rx8p2lg6xCpwiFMO3aA2rSYuq7mbBMIVt+u0k1vU?=
 =?us-ascii?Q?QXRVJA+hDoCoOtXUyBdOdNoB3D7fbuBupBiXjCh4FYjLdXZ2pPMY74vyhtDh?=
 =?us-ascii?Q?Z8rVtxQO7eh8iXgA7fN0taB9kzc/SkpebAFvpU/SpghTdO4wIfjhBCil3SBR?=
 =?us-ascii?Q?eU2Qm8tdf0PXlrU39t643sXDtLw8/rQk/v0tNZt6sVXdDYTtDk7A3h5ol6eA?=
 =?us-ascii?Q?l2zNu1RyFS+lRazHJgmmWn+eUmYxgI50gvBeFolwwxOrswrgulZwLG/1C64u?=
 =?us-ascii?Q?/mbStUjstpl/38Uec+/Pb/lVNUgy1O0+1YfhjwLpVkuA+ErEad3UEvEHJ7YL?=
 =?us-ascii?Q?Tfb8mfY2eG3SLTtC9gmqn877tj68c0zUmI7LCJqE2Zl/LiyiA8j7gXDGqo3n?=
 =?us-ascii?Q?LnPhfySx/mqYZn6kdqcbnVFeH2Z5jxs75y6pHac0PYJg9kZMY2Ka4nZnz915?=
 =?us-ascii?Q?rQu0NP7B8bEVflvrBljweapxVDhClnXBzJw/k8vPMXo1TzSFR0DAofg+irP/?=
 =?us-ascii?Q?G0k0lCORD0ivw46hTOzOsh2hQSHfXu5AybrY7m/NaztJbKVFH88QiuOjNRor?=
 =?us-ascii?Q?xJk/AEa3RiWYMOcm3b+Q6dEKIMTNGAlI7yQ8ms5qr46wfZx/LCjNUDZXTkug?=
 =?us-ascii?Q?Ay6ml0lLPZO30OfFJ87dYW8i8b1MzIo0rXr2+rcDg26LWHz5QV+mbyVch+/l?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b074df41-4e13-4ed7-25cd-08db6cdbf521
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 13:33:37.0877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3wer15YU+a7EbJzAq73dPEoHjL3lZqmwbMOjRKgdDwO9fmYATjxwuIC+CBahSx/MoFi5LYwzZLXd2qkNMeaTS85rsTvTuFnr6P5C34ezxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6372
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 14 Jun 2023 10:32:40 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Jun 13, 2023 at 09:35:23PM -0700, alison.schofield@intel.com wrote:
> > > The CXL subsystem requires the creation of NUMA nodes for CFMWS  
> > 
> > The thing is CXL some persistent memory thing, right? But what is this
> > CFMWS thing? I don't think I've ever seen that particular combination of
> > letters together.
> > 
> Hi Peter,
> 
> To save time before the US based folk wake up.
> 
[..]
> Note there is no requirement that the access characteristics of memory mapped
> into a given CFMWS should be remotely consistent across the whole window
>  - some of the window may route through switches, and to directly connected
>    devices.
> That's a simplifying assumption made today as we don't yet know the full
> scope of what people are building.
> 
> Hope that helps (rather than causing confusion!)

Thanks Jonathan! Patch 1 changelog also goes into more detail.
