Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BC0708D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 03:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjESB4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 21:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjESB4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 21:56:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65404B1;
        Thu, 18 May 2023 18:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684461373; x=1715997373;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X0nYwAh4ucmjr9gp3czH/2IXkVEvBVBj2SrWznzB5Uk=;
  b=aruQNaYIRhjhcuRtz7G0TI1Nc7tAlAaiWrnDvK4RUaDZRRUTxsHdb347
   lOsKMVmPnQ613Y91FykgJ759aHei5Ne0Y4Q0YXQtPIjb5Y0LHpkHCP3ql
   y9XoNajVhFTMIMM6lKA92skCD9Cc29+d391f8NEqCkT45CnVBz/Nvssiv
   69AKi0/6AWpAFxIBJAuMNBjBVWoj1X1bSFGzusKfdag7Q7CcAXJ3Mt13R
   6WKCKZMySdcj4JR2lBZVfDGjgaKPOiHFer0Do8+iHZBBFhqmdF3bp+FkJ
   iRp3DApieBlqcTgAGoP1n8S/AA8w36LySaRmEnjh6JyYfyiJu/nTTICx9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="332609033"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="332609033"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 18:56:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="846718719"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="846718719"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 18 May 2023 18:56:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 18:56:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 18:56:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 18:56:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 18:56:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+xC9FX6cqywoOglDd9iaSaFpOYbW03AmD+nfK97s/vLWJfKmZbU/35KQSYv4hUsduCt6OPUqEakeoTqiF1OGuDvN50dxt+q7eAYDE6Qv1A/x7zKg5QQ7ACxZoJa1h9HK/S5y/LnDf0q+TbHymGtOrfT/p4v0cP7HocLC6uojdeIx6BqzTsGr/nznmdQ2GaEmJdGtLWKsgdDZ9GwzUR7lT+A1MtCCo/x/Nfeb4GGvNao0uNprlbHzlERLN7DYbY6DbixaIZKp/ma0h7Q4tErjvtcKztoJY0NaOo2iLYVqVxPxeJFD/VIj5RAWCe9VCvsczgZrWM0QWvxe+zGSh9wbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zO2/kAKrbizrnv40KNZ/C3P+Ap99cfn5beoRla/6LbY=;
 b=ZoUQ5ibpHAYNZK9CvAH8FiJHLzUcQhlH/v9V0qmJ+NpRz4mBkcY3ehC5PRBYl+HmzzSXsi6skY7eOtwU0jIUSbI8uykMja/G2nj/tHIG9QtNP3WS5CXEC8RZZGFuwOROst8r07hv62Jn+JfebZROufrO2GsRmN09X5iSp5gD6F3wd5Y2IyKvE13IOud+vj0qifZzDc1yULx5bLN2osSyFw+xFKp7iy+h2FQCgkEGqdSKJE3PeocfQk6YIOd89uva1Zx9G9FrBg9JMz8lOSBLuUyaXg3vYZvgV9faxFyer7QYdjM2x6YRZ1xmRY2JHWNnduDZS7abpgM0gOUpmA/SkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7482.namprd11.prod.outlook.com (2603:10b6:8:14a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Fri, 19 May
 2023 01:56:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.017; Fri, 19 May 2023
 01:56:05 +0000
Date:   Thu, 18 May 2023 18:56:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, <x86@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/numa: Introduce numa_fill_memblks()
Message-ID: <6466d73232712_682c12945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1684448934.git.alison.schofield@intel.com>
 <e365f4dfa7fa974118eb4e59aebc7cc423cf19a1.1684448934.git.alison.schofield@intel.com>
 <8dc725c8-613a-b51b-6cc1-80d2275ca130@intel.com>
 <ZGbCG4gRGow0VCmQ@aschofie-mobl2>
 <f2467d69-882b-3439-b082-bcaf591a9892@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f2467d69-882b-3439-b082-bcaf591a9892@intel.com>
X-ClientProxiedBy: BYAPR01CA0025.prod.exchangelabs.com (2603:10b6:a02:80::38)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf12a40-27a6-4a9f-59e2-08db580c34a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zodWTb7SSyBvg/D/+uurGcfiV5YVOyzC3erHcF/HBeCVZOxB12ubFyol/yB+LEzoRIY0LGrnPV1efJ8tZuTGszxTz38uP2pejYgRN1jqODSI1goKgOdJCRdo0vH7hNXrDCkD377upgYbf+XwTUACuVp9lE8hPdaqdhP7TkVlsx2zPBAmnPT4577vfLx9EB8afVcSJIAzyID0jFY6GfnNQHEVsfTBvePuyvm0G8rjly2E60IksDEyE7eCxgn8gQGM+CRSyfUo2JWyDmdqriFAaEmPi5bj1Q78VBpauEcisA/mz1UDU5SfnMkIpqW9/s5/SbQnVWDmqJPLWbulnNsESlxklMwpUw1dW2V0wKMDELpqzPnw0HS5fAamaZQNSUFMJXhPd0LUDm+Okbu80bvLAzKV7328QSSrxsBTnCE6FmOV4T+Z/c+RQGftYNrvqBsOIJO3S0iZxO5d6eMmpUH0T99EkUVAcd4XvNhGooPwP0ENHNXuwa/9EFUoNrnw75xqRwbnAZL+5diMU3rf6P3osGvNzODjjidWO7lSZYox+lLbRGa1HA7b7uwUWeKSL0Nc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(5660300002)(8676002)(8936002)(7416002)(6506007)(26005)(83380400001)(9686003)(82960400001)(6512007)(53546011)(38100700002)(186003)(66476007)(110136005)(478600001)(66556008)(41300700001)(6486002)(6666004)(86362001)(54906003)(66946007)(4326008)(316002)(6636002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H7QgSeSd0OANrTrZxSjMi7KTHrE+9zLugUD1QYexv7PGFCf1XiDpMc5c6sP7?=
 =?us-ascii?Q?XfZuQqF9u0UGgjPfE7VvVGYYjBXMiXGG5f/kMyLzb5it0J1238xgmoF/gouU?=
 =?us-ascii?Q?G+oJ5sW5KSruiPnevlaiS0Ef9Z3Ji6v1fV1oHSc3lxP6CT3EqJYMmLraaxQv?=
 =?us-ascii?Q?XdU8TMAIdtUDlmBQGL46q/z+kFxi0xaPUggsK3AUKl6Zq0o+0w9mY/SrEauy?=
 =?us-ascii?Q?SNn3KYdSPTHwt9W2qH/zr5zzGXUSttj2BE0cn4k8CGMHccyGhzqk62SLXJll?=
 =?us-ascii?Q?aN+zvBDFown/R2nt3VrrZd76MqUm6/cLEdkoFa81NaHas297h1vm0JNIlW1Q?=
 =?us-ascii?Q?3hcqlQRQIJ/oRtnysF3aMxL2f7MRfTyQs/3NbPU0xA/EPGK6+879VoIwQAEG?=
 =?us-ascii?Q?kXU1FaTmFwYgNaGpOP3zXbM3abJIvjfv2c0JEcp/Y7DZa86wxZZgalgKYuvV?=
 =?us-ascii?Q?35hCRMtx21oe3Mg1H070Nm1TOiV4DX+BsjN6r0ZYw7wwVqtn0WY7P+cRJYHc?=
 =?us-ascii?Q?7RAMpE4uAVoCC26xLm7BcsAEJ3vho+JQ3kJocfqTSdpxgW2PpHeAAeYudZW/?=
 =?us-ascii?Q?sfr8DQFS5FoPOX7ZaNvhrBR7TXQNc1Jn920iOoTC1GB59+LJPdzKG9pUKQVk?=
 =?us-ascii?Q?QtcvH0DTLdtSowVH+FzoABufnh/e4qXsl9wHCgn2M9ld5Mlh0LjNUZH6Z0Dw?=
 =?us-ascii?Q?JOhHA/dDijIbZ+5FsbGVaw39zIyD/Id5wAHNWEWS8byM3jVVv7s7WXp+pzQC?=
 =?us-ascii?Q?HNsgBhhIvN19BG1UOLxodAnFYEYGuiPdKpHrAaEIRAGZ64Iihlu+u6r9bkAp?=
 =?us-ascii?Q?Dmk4cWwdGYeXTIktyPd75elbMHaMpq2NoNaRasMho+5dfMWxRJ7ndIUGtJSH?=
 =?us-ascii?Q?IHu9XFmCUARS5AAWGIwUlgbyjonIVitxrlMIoJlt1m2yIIJZp8Bwb7gTgHYM?=
 =?us-ascii?Q?GKgG7lpwb91IFL8d53rlOajLg9wjLb31jkOqxL/kRMgnb5nSguivJmWsFstb?=
 =?us-ascii?Q?lnOlbJjHRzMuPHZkPP44z6oz0Ai8n3oZoGlYg+rtqg9FxNLdCYV3VNo1KY9j?=
 =?us-ascii?Q?9PYdqoXBx/+mFksjDhjafsnenbizXBObKAo1rlwJ20Rt0GH8XUHgZYwR9vS4?=
 =?us-ascii?Q?3GH40KXp/26t+eH+V2CmBOkTIsVHPYgHq4qAHh2MEbF5DvHnUP66ly4wK3IT?=
 =?us-ascii?Q?8OJkEGv3LqpLOq+g/2P9oQkQmvzzANOtYQl93cHhpvv8ZxN5yr8K7eVtpbrF?=
 =?us-ascii?Q?HW/GC5NO6wA4qqS3VKsHd48YF3M2F0Y9bzkS1kE0BZ72xgsqT4Tio8NW1NNO?=
 =?us-ascii?Q?s6YKTPAYrFobiNh84fvdBuDb0NXjDTqxRyQp3g0uQF/YsQpJRhc1UkIzM/zJ?=
 =?us-ascii?Q?EjE1BhjcBBAycV6PKL8bxztXvEy7ssnqSma2oGtBsxgip1GIDXYY8sHnaUUB?=
 =?us-ascii?Q?Enaq/+u6yAVf/Zg/ihtdSK1Qsfe6cmcG9BgbLvh3fYY60W87IMWKAnoAEGrD?=
 =?us-ascii?Q?cdCYAwoEbXd8phYaDYh8tn6huueps4a9H35v+NcJtyS8DxvLvRi+cVrOmbK2?=
 =?us-ascii?Q?lAve8kXBjJykrdwdQKYWLn1/Q/KG4agB0NlICFTIM6QP9gpvicCKfYkZrynI?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf12a40-27a6-4a9f-59e2-08db580c34a1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 01:56:05.1964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syWASE2RYGqo7EIiTSIdD2z26mcMkXL6pn5AQkfITTtBGdA6E7MWK/Dy9o0YQHHvOklce3hAR5MpxznkkN+K0OhnDXwqTu59El+LSOI4gZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7482
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

Dave Hansen wrote:
> On 5/18/23 17:26, Alison Schofield wrote:
> > On Thu, May 18, 2023 at 05:08:16PM -0700, Dave Hansen wrote:
> >> On 5/18/23 17:04, alison.schofield@intel.com wrote:
> >>> The initial use case is the ACPI driver that needs to extend
> >>> SRAT defined proximity domains to an entire CXL CFMWS Window[1].
> >>
> >> Dumb question time: Why didn't the SRAT just cover this sucker in the
> >> first place?  Are we fixing up a BIOS bug or is there a legitimate
> >> reason that the SRAT didn't cover it up front?
> >>
> > There is no requirement that the BIOS describe (in the SRAT) all the
> > HPA assigned to a CFMWS Window. The HPA range may not actually map to
> > any memory at boot time. It can be persistent capacity or may be there
> > to enable hot-plug. IIUC BIOS can pick and choose and define volatile
> > regions wherever it pleases.
> 
> I understand that it _can_ do this.  I'm trying to get to the reasoning
> of why.
> 
> Is this essentially so that the physical address space doesn't have to
> be *committed* to a single use up front?  For RAM, I guess this wasn't a
> problem because there was only a finite amount of RAM that could get
> hotplugged into a single node.

Right, for RAM the hotplug degrees of freedom was predetermined by the
platform definition.

> But with these fancy schmancy new devices, it's really hard to figure
> out how much space will show up and what performance it will have until
> you actually start poking at it.

It's less "until actually start poking at it" and more the BIOS just
declines to poke at some CXL topologies at boot, and does not poke
post-boot.

> The firmware wasn't _quite_ sure how
> it wanted to burn the physical address space at the time the SRAT was
> created.  But, now it knows, and this is handling the case where the
> firmware only expands an adjacent chunk of physical address space.

For devices that are present at boot the BIOS mostly does the right
thing and just maps them into the EFI memory map and produces all the
other ACPI collateral. For devices that are added after boot, or devices
that fall outside of a configuration that the BIOS is prepared to handle
it just creates a CXL Window with empty capacity and says "OS, you take
it from here. Here's some physical address space you can map things,
good luck!"

Compare that to ACPI hotplug where the platform knows about a
preconfigured amount of memory that might come online later, and can
produce all the relevant ACPI collateral upfront.

In other forums I have advocated against SRAT covering the unmapped
capacity of a CXL window because of the lies that firmware would need to
convey in the HMAT and SLIT for those empty proximity domains. The CXL
specification provides for an architectural way to get all the
information about a memory range that previously had to be packaged up
into an ACPI table.
