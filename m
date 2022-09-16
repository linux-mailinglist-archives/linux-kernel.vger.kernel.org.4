Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DDD5BB1E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIPSQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiIPSQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:16:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1795B6D27;
        Fri, 16 Sep 2022 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663352200; x=1694888200;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uh5ABC9XP7/8hQ137c/8jQKiOQXACpQnFe8uVHsUyWs=;
  b=A8m/NSbBeoaFf8ErZ0+53KGxQIAkXv0SU6jNHS+eahhUT1OpV9FYYDEN
   FRV25MRncMZf+kqC4O8mODVVWn0m/BBWmBWkQmtT7fXqz6tuN8OhIlnZy
   QlWaKl8H3jvIsl6+Be0mgebVHLf5tIlJ9pRLgG9JGelrVspDINIooYcyT
   FhLOItDU2YsuDebjLsbnOdM4Bk3H1ZtuGT68lYh/qlY9n/MhINOppNfU+
   GgdmwrCIqUV/dilb3p8jSNcVowwpeVPnn3fmnKotPcDQvEGrpvwxCic0j
   Y+HkI8nEpxh/pieb55Ve9IS5VL4TESNKhNnFT1jx/Su33GbTXAl/fFU4P
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="296636371"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="296636371"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 11:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="706836312"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Sep 2022 11:16:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 11:16:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 11:16:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 11:16:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 11:16:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEOOxBes1SWijhvNK9fvs8FUh0h5w8glI5RPRzW5IP03Strz+572sL93K8mjcr3sUvahAOWg6RVKN9ewQKqg29ACZFZzSuOCdvtdkOQ+1GJxvnaWiPw6nJVwkuAhxywkRzlM5Olgr8/MGnLsBwSLz99Qd7nYH0bivFP8rs8l3vr+H6xzweP/YMxrwCm4goGeM54UDx/0pnZ1mpeRcTI4CjMJq7IGGgqj35rPkNwWKrVRsObKrfswffKJmx72XhpS86Vcwapv/hty7ZAtDWnrRDnPbKxhVxn/i8r9ujkyVDJ/p5XwHscaBYYIHrgzcaMSULHCOFac/dN0muMHvJ0Sqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKwMQsgfWoVJNjXaXBvY8tz4paoFHSj8yQ7tQP2UJWc=;
 b=A+ft5Btr3DDrc6GkEzCdx08nP4rQw3ZXZahdGe0uRqHHU+0Qjb8fWOtSegFoJIS6NoHv7S7oqzCRyadC2APS/a2H6ieEP+qUV6oSqQHHyyIu9IMXeb1HsVIPxRAq6k3AxMnBtx3uZEkDh46bxjE+nObMKGraoZGWQG7ol+BA8lUfWMcmyacpZDz4aKZ+8mxAPjs3K2PPYIXt+AKA9SCqQibhboolJj1+jWWWZMTwcHLBPHjoQwcdHGaF1DJ+4mLBsqasgoSf3KnBPpFecqwcSp74grwGLilISt2JzeCxGn7ULKU7yU7bxtDM5ha/SQNxGgr/DB37k611xNOlT/301A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB6945.namprd11.prod.outlook.com
 (2603:10b6:806:2a8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 18:16:34 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 18:16:34 +0000
Date:   Fri, 16 Sep 2022 11:16:31 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH 00/15] cxl: Add support for Restricted CXL hosts (RCD
 mode)
Message-ID: <6324bd7f45899_2a6ded294f5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-1-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::35) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a93203b-8b22-4e98-28b0-08da980f9658
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ezRwuJGePVY09z/xUrWdbk9gCtcZ19az3DBH36mG6MAeiPotQV2BxRbgva04vPp1VzXtuyUUblnp7uxcwDSlUZMN6Lk2Bl9QPAYZ6ibDB36hQjUn9wJYErMeINAcErnFZgI30H0cIOMJOJhvqvgLlBxsNvHWLEHs90kvDEN/2nyucM435d2qXp395GoEg4wvhwGf64eTcO3CThPJ0GvbgwzSvbMXN3wabHIHUxLwu/bMP/fA3ubZAP+mCZR9fv3d4CVpnDrx0KEpSHW0XDhONvXjoW0iZDYyXTh4Q9idqauOBwF8qnOu3UCp9HftoB9GGoxLI0Dcw4wt0RiFdhmxqFiSL7Mwc3Kg4D0pL+K1pQer1H38By/JvmXVv0/USOy6XF0oI07RwEgUEroO8CjY6H4Vvf9vXUdqMdNkTHxFJ1VMAYZgT8680Y0d/rRw6cZlser+6tCZx0zTzowjgQkLn/c/P/uervesdruxxIaxhvRYi3nZV9vIPmlbOevNEnh6PVBTaHK2DxzAwBWdYy3YDrzBEIOu39vu3HRKdLvUINXuW5n6pGCJp7HoxfxGT+0J6IKkDygCV6g7vEurgNp6F2Cs7BNCQDbUqgS0sw9h0vP5AlfHehpuUK/17eIVUG9MeNoDVUyMD7dAExXFVuNx6GdW/C9bt+B6bbnR5wboxElCvBF4BWAsPxC/0wJKEr1ABQJolyt6z6q9ZGfK0e6AYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199015)(6506007)(86362001)(110136005)(83380400001)(6486002)(4326008)(478600001)(41300700001)(8676002)(66476007)(66946007)(38100700002)(6666004)(66556008)(316002)(54906003)(9686003)(26005)(5660300002)(2906002)(6512007)(186003)(8936002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1PZopm2Ssd//I+XMbvCfOgaf7F0JzeGPPLiks3Z1Hru5c1zMN5AzR0TuzPt?=
 =?us-ascii?Q?srl/KSfB/NIbU+xR+aDcmBjXmGJMXSNg/iUHJCumuC/hTLqBXeo2SJZsfpW3?=
 =?us-ascii?Q?NvcJl4jTlOOovzvAxzefVckJiM1xb3+rgMO1uPfOJlhhpLjLj/9fqu/cDx8w?=
 =?us-ascii?Q?FIAVmsvPtL5CVOZmScQdX9gM/g5R8Z0SwhkcEdV3JfgW9iXc1nkP8SZasrsQ?=
 =?us-ascii?Q?lWedGdwNVVqfBvCj+C85BR5ga7lahwBWE0zJcJ0gGY0dbqGxJrfGTsc2UyhG?=
 =?us-ascii?Q?uDycbKSqTpJ0g64qLwLm7iZs5pKIxptAIhzx3Ga4DnySs227DS33jXaXTOiS?=
 =?us-ascii?Q?+422IgiUxFk0ftEattukPxpIrLmx1dnhsa2I23HQGEmkDohnB/68czRHMNkC?=
 =?us-ascii?Q?aM1KidOk1ysPP+rFemuVV8YypDy6p4KZUHeRd67QhdSEnbgugBowETc2HxjT?=
 =?us-ascii?Q?9vIlG01nXH0IwgtR4ou1JLv8gPLIH5o8weT+plity2jT/ygDFrCcGHlMuMTw?=
 =?us-ascii?Q?ZMWP7Fd0MMcKYqF2uFRsDK1tQ6lWDJzoy8263d+fR7igVkq/pRVP6v/6YCDf?=
 =?us-ascii?Q?aKco58t+U1kB1iQ1+zkNU+3N2PqeH7NlK25zfL0qoz3P2j3u+A7LtdtUGuca?=
 =?us-ascii?Q?/LFcvWeuj3NBU2kS0yeunyoOQg5UGbQ7U++28nxFungaVMlLVobZIFD2FGEe?=
 =?us-ascii?Q?iM4g3o1Ci1RLC8bpL80G2kADGTWrr943xGO3Fz84dxtG0DgGDCG4OpVLcJVV?=
 =?us-ascii?Q?aBTdk4Yo2X/9hqBgZlrJj0JGa5xY+GMey0cqSfp0CqieYz1DuD1/DsKaypm6?=
 =?us-ascii?Q?D2U0nH5Bc6XkFo5l7ZEyHQxgkThu2E8SfMus2O+7IvnJUkjwnIoTY1Y/0SmW?=
 =?us-ascii?Q?rtbF8HV8U23yo8k1GnAgFf8LqR+tehuw4YzdLkWCMcho6rzai+UxAuDIftsI?=
 =?us-ascii?Q?/cQUBiQo7FBOH1xb9lJ4PnEQhBCrgccjvHXagmhcPhsBSFaqACR8y/NCe/XO?=
 =?us-ascii?Q?sHcI+sawi6d5/RMQKTHD/fl4V/fdTjNMKkdNRutos0fHag9wUHtA/66dV4/T?=
 =?us-ascii?Q?SlJMKT9rvw75qahCexDyvotaLC+Rs9D/VC+j/W6RT95YC4uWjDj5se8Emz4T?=
 =?us-ascii?Q?kWMfjSg86Jtjk59Vdbum5PiHeNwqpLCGN28EbQix+uKBVV6P/MQqKapTsE2k?=
 =?us-ascii?Q?7ET2LxABN/oUYCEyCO81pCqEDGfIrTYcZNDHjr/xf20b4ohMDYEc9DemD8v9?=
 =?us-ascii?Q?GKnYHSJ/8LXHoXSpYhEYy36aQ272LvCMSmCs1EofZNPYCrpBRGBjWNA5mCBU?=
 =?us-ascii?Q?m5YbJELQZTIZEkefIsee8ZxKYxXUdy+WFqLE3m8/is0bv39g8pra/DlbjlsX?=
 =?us-ascii?Q?Te62xDR4ITFSE/fJuEtq67yGPODTuPIF/rpz3cikc7xUVWvTY2e0NZX2JTjd?=
 =?us-ascii?Q?/hA2MAr+Kun5E7QuvjYXAvAfwppL6op6fxSw4g7UubQA9bHDo73xqN7pqnFN?=
 =?us-ascii?Q?sax4ULgpeP2YAB+e9cY2qxuTenCX0xRmhJkHWag1u71G1aWcd4gPikxIfbsL?=
 =?us-ascii?Q?NhAFudvIcgkt8LZNPvRqV3kYkGYRxx9VGZbaoAVZmzwigJ19quXf5VZM/142?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a93203b-8b22-4e98-28b0-08da980f9658
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 18:16:34.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kc161FtIbDSXELBtvtPIX84r4LlGe+goAegObZpzYzUE740aGqx9RbF0IxqMQzHFKt0W4qM8j4bSlmr9QxoorKMAVR9nGljBnq0A57k5q58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6945
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> In Restricted CXL Device (RCD) mode (formerly referred to as CXL 1.1)
> the PCIe enumeration hierarchy is different from CXL VH Enumeration
> (formerly referred to as 2.0, for both modes see CXL spec 3.0: 9.11
> and 9.12, [1]). This series adds support for RCD mode. It implements
> the detection of Restricted CXL Hosts (RCHs) and its corresponding
> Restricted CXL Devices (RCDs). It does the necessary enumeration of
> ports and connects the endpoints. With all the plumbing an RCH/RCD
> pair is registered at the Linux CXL bus and becomes visible in sysfs
> in the same way as CXL VH hosts and devices do already. RCDs are
> brought up as CXL endpoints and bound to subsequent drivers such as
> cxl_mem.
> 
> For CXL VH the host driver (cxl_acpi) starts host bridge discovery
> once the ACPI0017 CXL root device is detected and then searches for
> ACPI0016 host bridges to enable CXL. In RCD mode an ACPI0017 device
> might not necessarily exist and the host bridge can have a standard
> PCIe host bridge PNP0A08 ID, there aren't any CXL port or switches in
> the PCIe hierarchy visible. As such the RCD mode enumeration and host
> discovery is very different from CXL VH. See patch #5 for
> implementation details.
> 
> This implementation expects the host's downstream and upstream port
> RCRBs base address being reported by firmware using the optional CEDT
> CHBS entry of the host bridge (see CXL spec 3.0, 9.17.1.2).
> 
> RCD mode does not support hot-plug, so host discovery is at boot time
> only.
> 
> Patches #1 to #4 are prerequisites of the series with fixes needed and
> a rework of debug messages for port enumeration. Those are general
> patches and could be applied earlier and independently from the rest
> assuming there are no objections with them. Patches #5 to #15 contain
> the actual implementation of RCD mode support.

Hi Robert,

I did not see a response to some of my feedback but wanted to summarize
where I think the next version of this set needs to go:

1/ ACPI0017 is mandatory. If a BIOS does not provide ACPI0017 it is
explicitly opting the OS out of managing anything other than the CXL.io
side of memory expanders.

2/ Per table 8-22 in CXL 3.0 RCDs are not permitted to have HDM decoders
so that assumption in the driver needs to be reworked.

3/ It's not even clear that the Register Locator DVSEC has any role to
play in an RCD as every register the driver needs should be relative to
the RCRB. So the assumptions in the driver need to consider RCRB located
registers as a first class citizen.
