Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CA162CBD4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbiKPVBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239128AbiKPVA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:00:59 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC0E68282;
        Wed, 16 Nov 2022 13:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668632404; x=1700168404;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Mgz8yh17Sr0AEeC4DwjXm8hyqGsithSnoSATj6+ucCk=;
  b=jqooZtm220vg0VZ2iTzFBm+2aoGSaavzC/xWg03VqJY0GQcWPWg0mhIG
   u58iG82ViLccXRywWxGKf2D1BOao+GzchAsqQ3m4BK9SvlEsKm9tTuMbF
   LqtsbiUg2bUnUSYIgqyGgu+0r0caKV+dhvlbUs00XyGk3wdSjjGNkll3F
   JL9UCchxyTGHYXHU4XWAyhfiD9iqxEoIfhRC/nODojCL/v6EwgXlATqvM
   lVXBpfJ7SndEps5l8xIdMEtBsASYB4yNxX/xkOyCcLWvP7jdOy7fYASiH
   bPQAwi83ek0XghnZJvju1sjNqEQC5/vmC8axLM0spcP7n5E1pR9fjzAQ0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="293057425"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="293057425"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 12:55:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="617320382"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="617320382"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 16 Nov 2022 12:55:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 12:55:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 12:55:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 12:55:22 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 12:55:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgEJQVKULE6NQRK2peMqPRKve2GsY8h/AYHhZdKjc+IduTDUCfSqTahgXWrMSdvga1/gN05aX4TdSsLlu42vXgdomzBV2bgDXnuOlo2waRCtCQWH9FwBplb77NrA5PimbBIKzZV78xgQdp9aclaMg3U/zur4ZzZ0lekJUZnvhzPxqaYvTvaCPU48P6XhtSYCwVBXf65EiLLLHO2Yug8sHGVkGPVAXTegIMW7+ePxTUOfEoWgRIwyQWtFkQQriU/VuKq1GNYOYM/i75TjWvbTc9BcVMd/84dzfEvU5PB4BIPq2CIRhx4CDBz9VJeF72P90ANTPBaGAIXPdQ0w7uCdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LFftE9290v1EWbDQyVF8du3dUF7b3DespcESpT7v4I=;
 b=C66Rfbtm0P8dxeeJNjpDjyi0MJsLdFdkRmns5i0p5GtKw2EC/akzJW3Px4MZijkCWM3kEF1utFBaJZPmHXd/3zxXfpMgbzO5AIowAqYvrhXv5y9Z5YB6DDcpwJm3o7vPrHekK6XMDC+DMxg1pyslTjAVWYCePYepehvMEEMkS0TbodhbTdllyiZ19lStzWHudrQU7HWh/NlsYskeDpZJtZ2HIOJ+1c6bBzr9qVIwOnSy9ZuBoWl8e/Hde/lIcfCLuMXOWkox8bqokeSvC/58QwpQssUhr6NQjxoiSqcHdEKBmVtFccwYgCcc1cgtRANQ/nKDJ9XKjp0h7620LRbIJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH7PR11MB5817.namprd11.prod.outlook.com
 (2603:10b6:510:13a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 20:55:19 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 20:55:19 +0000
Date:   Wed, 16 Nov 2022 12:55:16 -0800
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
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH v3 8/9] cxl/pci: Extend devm_cxl_port_enumerate_dports()
 to support restricted hosts (RCH)
Message-ID: <63754e3472a4f_12cdff2949@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-9-rrichter@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221109104059.766720-9-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR05CA0152.namprd05.prod.outlook.com
 (2603:10b6:a03:339::7) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH7PR11MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 833a7ee9-3bf2-49bb-1984-08dac814debd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKshuamMP5JKpdkSnBImivyQzK5zBPc1kzyVespdJ4LF7MNAhx3tOPCLiIbYGlcEuBVh/GONQHiSzIZJr3yx2nmm2qy9e3ZjP4PXomPRzy2jjKQ9yNPNgA8dQzMVnFw5vZza3rWDAl938IKjOAKs7N+AeYVwos1hke2kZFTgSm/27SRVmFB5/JtXl7PaB9EoHlqod3ydquNwJDjh237Ud50F/QGXtmD+6uolte9HZbaFIQsYRbxRnwgOY1WM21jT1WK9oEhrqcso1BlUnrtAtp/XbjAQKJ9dm5gdk4rgDcaB6e7ShjohMVuiB2W8Kh4foZ8SUVuDcSqTFrU5qX7jD1cVK8G6AD1TlkA2z7bzpcOmFPhpoFEQkwWuSIwFjw0AIS7yhQ6IuHb2APKCdbnsgs6nQDzCxs8kQdJ3lbJFVc2x7cN6KBhFqh5la98J2DczOqNrltfhQNstSSk/8LuAx4fKaRoLVoUNO/gZWuSylj1EO3U+KBNqvxtXHRWRKDNynwfvvBD33X4wp375rHBIoute2yvhbrfVkGp9h8Eok9MobLUQmo2l1K+pRINo+0vkYEUVfqUuijqw5tM9mzaGc9lCY7tj/huA3i0ZBJmtg7YSL8IchzHfO4m80RlSMnF9ZZJJbemicRYG3OuHNTRfBQy6I+njuhjv4z7quGtARdm6R6A5a50kiAWgM3AgC71KkUGAzte7t3xC0EjoLrLUEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199015)(2906002)(82960400001)(38100700002)(8936002)(5660300002)(9686003)(6486002)(86362001)(186003)(66476007)(8676002)(66556008)(4326008)(66946007)(41300700001)(478600001)(83380400001)(54906003)(6512007)(6666004)(110136005)(316002)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE9WYUxpeEFWK1BqNjQyeklWeVNzc3cxbHVoVWpEcHN6VmNOam5GaUZNVnh5?=
 =?utf-8?B?bTBJQ1ZIdlpqMEJ0emtpV3RXbU5DUWk1bWVnYkgzL1crdHBRZ3ZiTUhkOEpu?=
 =?utf-8?B?cnFVNkpGelB0ZlVpVndrYk82S1B0N1dwNnd4OUY1WTlsVlRVQlh4NEdTZkZQ?=
 =?utf-8?B?RVZLcTFHQW9OTXAvTzFPUmIzazdudkcxejV3cWVaZkRTcTBvZmJ5SXN4eTRQ?=
 =?utf-8?B?Vktma1MvcUwyT0pEdlBEQmdCbVgwUEV3eU1lWk1ZTzZSRkFNWG1ESUhFRy9M?=
 =?utf-8?B?VEcveG5OL2VYOVpSQXpnU2dmUXlpMU10SFdKaVBOOG5kMWZ6bGo1L3N6WFhk?=
 =?utf-8?B?VktVczZDbERRSnNyZVVwTldrMjk4UXNFM1A4M2NQN0tYRDJBQ285bVhHOS9C?=
 =?utf-8?B?VE1ta2dKalYrWHdDVG5qNitMVEhpTjFEQkFkRE1iNU95VjQ0TStVcWx3clk0?=
 =?utf-8?B?czdqdGRBNHVudnZNVG5sckpFa0tjd0JQaHNITS9NdnY4RVZaSS9KNlRWQm5G?=
 =?utf-8?B?UHRNc0RhTmppMmxXQkpuV2NkL1ErM3YrNW51c3BrMzFTUkZhVjhWTUt6L2Qx?=
 =?utf-8?B?QWt0RTRycHhqbW9TdlhRRFh3Tm9FVUp4MWcyU2dEcWd6UnVPcDA2Rjl5b1pk?=
 =?utf-8?B?eGhoUERxQitRWDhSYXpEblllNGx3VExXdW0wVG9mSlRoL1cyNUU4NFRwMUxt?=
 =?utf-8?B?Ukc2dGdLc3g2WjBoNloxWk02Q0ovM0l1SWxCQzlKSkY2Y3JOSjBSWnRCclRI?=
 =?utf-8?B?T1hPTTIwQ0JIWGpoS0ozaXduVWpldTJtbDJFamhFUHNXZHBSbzcxc1B2MXov?=
 =?utf-8?B?Ykt5ZnFkaXo4aDYvT3JDcmMwcWVCdUhTTDYxYWoxL2VBSCs1dmJpYnY3TWNp?=
 =?utf-8?B?enYwT0o1MVJPT2tWeVJvc0NqejQ1SGFUUjJROHZ1ay9iTzdILzB4RE5raDJy?=
 =?utf-8?B?bE5RWmlMOEtFTjZ1UGJDck5VV0JwN24vQWJuWEk3TmwwbXZYTzg1NDR3TmNM?=
 =?utf-8?B?emJrYXRoM2tNSlkydERMRTlIVUw3Z01HYTd4UjltalBqbFFhYkdhQjc1SlBs?=
 =?utf-8?B?blRXYzc0SlMxRFdCdHNRMGdJZ1RkMlM4WGFTYWlkSU01bForKzZOU0Vxa21N?=
 =?utf-8?B?WXlJWUhic3NBK08xM29WOStsL0IwcVBOaVdmRmlrVTdjWi9VbjdNRW5VNWd4?=
 =?utf-8?B?UFBHWDM0cUt2NndIZWg5UzdyQTliaEEvMnJMQkF0dUlTTytER0JwRHlNYzkr?=
 =?utf-8?B?dGVNMFNGeXVDM2dsejc3NkZFWFBUeUI3VTNwUm5WZjJnaFVWeU1YSGxmUEpM?=
 =?utf-8?B?eVVrblE2OHQ0MUcrMWVuUE5Ed2VNcXJ4V1h0REN5d1BJUWFaYkNyM29EanMw?=
 =?utf-8?B?aGprbTc4dytOdzk1eTU0NzZTK0Y5akJnbXU0a1ZGR2hwTElUVHBLa1FWR2ZT?=
 =?utf-8?B?OXdjMVUrNzViS2VhSHl5Rm5XbDNuMWdCUFAxTjhUUHBiNU5DemtLaXdHc0JF?=
 =?utf-8?B?dWVqUnZiYXNiejFIVDNoYU84cXFzSG9sUGNzd2RsRjlxeG03OHRLSmNqYzVh?=
 =?utf-8?B?cUhmd3A2S0NMRnk1Umh5WmxWTVViVGZ3THlOYStrK1NIbk9CSDVaY0pzWnJv?=
 =?utf-8?B?SmNzekZyYmppTS9PVWpoU3ROcVZwVVNsQ2dQVDg0ck1wUXEyZE5NTk1ZbWVO?=
 =?utf-8?B?YXI5dHBqTzFIRUpXQVNKRDd6SVpKQk83ZWVxVXJDZ2NzaWFzQ2hmQlRJNldm?=
 =?utf-8?B?MkVOSy9FY2VVMDlVbFl5c2VkRnhPSVZuQlFFQzNIeG5QUitDSEZpeG11eHNn?=
 =?utf-8?B?dmdnTi9GZHIzVDE2NXVWVXRpOGdqUm80Tm82RS9Hb3lkejBlUHI2Y1p0K1J3?=
 =?utf-8?B?RnhCM3pWTjllRFB0WURiVTl1T3E1eExKenZRZk0wbWlGSjFtTDhxelJVN2l5?=
 =?utf-8?B?VjdNMHloYmhaQ0hxMkVibTNmZ1Nudzczd0RhbkZ1T1RNSzkyVzQ5VFJXQnhU?=
 =?utf-8?B?SXFyRTRuOGR1SkhZR0NCSlRpbFRRK3FmdEV4U1BueXM5YllFWm5laUlkWnRO?=
 =?utf-8?B?T25jeUh1OG0rVWtVZ2lvL1dYR01PUnE2Q2JBakhZMm5GaUgwSDZlYXlyY0o3?=
 =?utf-8?B?V2ZvS0RWY2FpQWcxd21LajgxVUZKZ1FhQmtKUEdRZ1ExS3BNSC9EbEpXQWdB?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 833a7ee9-3bf2-49bb-1984-08dac814debd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 20:55:18.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67sLo5CYE2wlpOLMGnYgnul74yI9Fim6cX5+uOuhgOhDG/tZZaYjDxDE+8kTtFx0EAgSwfPDFxCx5xs6x8pCOq6fdC0DsQ4+uTZ664kXYM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> The PCIe Software View of an RCH and RCD is different to VH mode. An
> RCD is paired with an RCH and shows up as RCiEP. Its downstream and
> upstream ports are hidden to the PCI hierarchy. This different PCI
> topology requires a different handling of RCHs.
> 
> Extend devm_cxl_port_enumerate_dports() to support restricted hosts
> (RCH). If an RCH is detected, register its port as dport to the
> device. An RCH is found if the host's dev 0 func 0 devices is an RCiEP
> with an existing PCIe DVSEC for CXL Devices (ID 0000h).

It is not clear to me what this extra dport represents. Here are the
Linux CXL objects I see in a VH vs an RCH topology:

               VH
          ┌──────────┐
          │ ACPI0017 │
          │  root0   │
          └─────┬────┘
                │
          ┌─────┴────┐
          │  dport0  │
    ┌─────┤ ACPI0016 ├─────┐
    │     │  port1   │     │
    │     └────┬─────┘     │
    │          │           │
 ┌──┴───┐   ┌──┴───┐   ┌───┴──┐
 │dport0│   │dport1│   │dport2│
 │ RP0  │   │ RP1  │   │ RP2  │
 └──────┘   └──┬───┘   └──────┘
               │
           ┌───┴─────┐
           │endpoint0│
           │  port2  │
           └─────────┘


              RCH
          ┌──────────┐
          │ ACPI0017 │
          │  root0   │
          └────┬─────┘
               │
           ┌───┴────┐
           │ dport0 │
           │ACPI0016│
           └───┬────┘
               │
          ┌────┴─────┐
          │endpoint0 │
          │  port1   │
          └──────────┘

So in the RCH case the only dport is the dport that root0 targets, and
then that dport is directly connected to the RCIEP endpoint-port.

In the VH case another level of dports are needed to route from root0 to
the fan out across the CXL root ports.
