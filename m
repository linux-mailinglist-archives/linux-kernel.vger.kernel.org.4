Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D1B6870E9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjBAWUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjBAWUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:20:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7F051C48
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 14:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675290022; x=1706826022;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kNDQnCuM3Ilurfd7+VGfP/S/gBiM8oY7Cj/dBXJG9KA=;
  b=TPa4wsiakO1HHDUvBaJje6CSODvUyrZBrjGcvgsUscpzpFVyqIk2X7VX
   5JJWfPQ6fSVGM9kjEViILX2hqzQgkdVa8IVMD6yufoH5HFPSWVL19TZjG
   UoXnp/RbDDHuEhOMrBMsGlTRH+3W+EyQiVMqRu228Tk8h0jG8lDnQ90M6
   IsmrQ2SDamxT4Jwt0o6ZUcSIt5IsdJ3eXyWvzSCxVtRstyV/pI2mnzMO/
   HT+sMMbavsrdqWkK7Y++dhcczooBt3uj4dOvIzY5G5r4qwjftH6R/XoY8
   +sg9DlZksk/7pQpDMzyWNEY7X3vwA1mgjZTSXTn1Y/b67vk1ElMHJF+Ub
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355624531"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="355624531"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 14:20:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="807732437"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="807732437"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2023 14:20:21 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 14:20:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 14:20:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 14:20:20 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 14:20:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjHF7NcYo0M4VhHOg1TVOb+IuKohCmT1qYQE3Ymw8Jp3iaE8K1mEAkVHMviGU9Szi6I83BW2OL3SY3PZ+CHaALZBkjsakNeUgamo34We43OsVhYHePXRD+qGRkYLSA/osBkgzb9f9XtOct3jno4IXL9Y6CyANed6/55fKdW2GYRG3d/OEBf9MCNslVfNxrf/ExfSSuJSTKxTv4JtulI9CEgcNr3o8Lnw1LL2bX6heU9IEQ0eZ1ErHqfkKiPUBN5VLIQ6YZyo08q3UxKUFGT8SKeWRVM6bKiS8m615AMjKyut1Ty8+W+FTKfu8XJVorKCDT3v0jGDmEt4sk0iHQ+A4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqUmF5kPmH9YvUHCH/zedCL0CQuh1VFV2au1RFAaQfA=;
 b=kdTwGS2Xyky/UqtEdeJuV84zQomdl7uVpGYbpy/qkHaWbRCvMI4utfK2udFG8u7HPiAgg8zQseQyfqKdtggYB4kZDSl32/7/+I2wPT7dXF38eqXLY0MRsX8QwbgPNtWcqO/oeBmQ8P9dj377qjh5lbV4uRyA4CQgzlSXdZkthkHZt+c2+Mc0MPVhz3NV2Fu5KGZ3eOoTgIpi3nn1gzJWYQ5DyGlnKBEDtSvGmRNWs+ogA0fO5zXx7w3/NYnCCD7m7Rg1n3kMgA4iGIhBHTgikrhf9rR9+9PzQGx2cHhmj/nPTzTaPwdJOt5MPN2zE1eGvTxuGTXF+rSMdy82NE0J4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 22:20:18 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%5]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 22:20:18 +0000
Date:   Wed, 1 Feb 2023 14:19:43 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        "Li, Aubrey" <aubrey.li@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch v3 Part2 1/9] x86/microcode: Taint kernel only if
 microcode loading was successful
Message-ID: <Y9rlfzcVlH/AMgvj@a4bf019067fa.jf.intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-2-ashok.raj@intel.com>
 <Y9kAlKFfdek2rq6g@zn.tnic>
 <Y9lHDWjjnqdletL3@a4bf019067fa.jf.intel.com>
 <Y9l4FdvytLqMc3jm@zn.tnic>
 <Y9mcCxYK/VPB0ATM@a4bf019067fa.jf.intel.com>
 <Y9perwfaheZqAJWl@zn.tnic>
 <Y9reDitxHgzcrsOY@a4bf019067fa.jf.intel.com>
 <Y9riTY4KOK+6tMt5@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9riTY4KOK+6tMt5@zn.tnic>
X-ClientProxiedBy: SJ0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::9) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c8d0b1-39ff-4b5d-9c13-08db04a27fc0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJZe2sHuv6c8bAEzj/E7oQkJgUYQxkgKT/rldssStpEPJGdax6oXm21lUFNu+mLkcyoarZKkfB4M3xZ688llRGJpxX5zUwarilHhwF4yL/LagJtZ+JHStFwBL+yC4Bq4n/9DrZzM8/s7vbrXz0zxrR4Th2AJ2CNJVyniKgkT9ByKsLdFS9hctMo3vcPumKj9vnYdZ+3OYOM/pOiE2Vxn4d+tLhN4QVfz+iqoNjLHphnt2AXUxxa/ert0t0hxuK0CmSDuV9k0ekWSSauNfdL7zGFmEyOIYDicJNOv+whdiRbC2o6u1LxIK7gn8qWylLNp6yKwDXk9tJrXByta8AUhxbDzgMsgalNRVGVfj1iNZUz8PzEMv59GQJir3BPhuCbGJex4bOmbWl2mMUc2rbEUCqtHKxDhMVK70icMNjREYLRy8axrG2Em/Lwj8ZllblRNNQ2iblrK6KevSSPsUYk6CkccKVV5WpYmj/tyqxwGOp+nrkog2xPBQFUtzx5P+QZPg+Le9L1PmlCHheo4gw39eDmfNkC08yh1KHOj6wmN+KD53n6Br2h3uerc+iHmVrwyY2e4+n1yLJRPi+FAg6b8Yug+llkisElOSh/zlkikfi2dpkeg42vyeI/dTtl8bcOVPme1Ex/8NQBgkcBVlCA/7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199018)(6486002)(478600001)(107886003)(8676002)(6916009)(54906003)(66946007)(66476007)(66556008)(41300700001)(4326008)(6666004)(316002)(8936002)(26005)(186003)(6512007)(6506007)(4744005)(5660300002)(7416002)(44832011)(38100700002)(86362001)(82960400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6HXtF5VOnKIGuNbrFD4skdKFcbjpKEGKEtdUV+5+hUZR0T6BG6HYduGHUVq3?=
 =?us-ascii?Q?FWzm9SoftVVqP5Y3wFwwEPtm7iZSBSnEMI73wOnVbnvcaF0snbjL6OMrOXdw?=
 =?us-ascii?Q?eZ7EzNpsaGJwIVkDxOjpTOneQSejggCC51U/9rP9uWRT91jODOAJeOQBlHjG?=
 =?us-ascii?Q?Vqrw/XUwRww65cHXf453wnPH8nsg0itOFYJhhQjtXZkaC+WjBr59xI2uYJDS?=
 =?us-ascii?Q?cO95tJpg9Y0juMuoR0alG7UbAqd7+EUXeX6WwWUhSZw7sPgu2CaRhsRp8Ob4?=
 =?us-ascii?Q?C0EVHQRgON+WcP9TW4ex82a5JpFdjjNm8QyYtdvkNJ2ddGF2gDJ1s0e88YU0?=
 =?us-ascii?Q?aB2UwA777fe95xckQ2HRbGgp7wrhgo2rx56CuLn84xzBzkPk+kpbEBcIlv8D?=
 =?us-ascii?Q?HLuxTKY3nmvP7k+3vxvnrrmCOM8Cvu+RFidQvBUx04FhVox+m61gCk+eno9C?=
 =?us-ascii?Q?IQeB7iWk3E7vF1c9R87YQ5/ZEbhPPbPQQIKZS3QKkQdh+Ce/4fWa7vAqAYTi?=
 =?us-ascii?Q?G8kPKHConaoa/9R//mI+onkBLeMrwa28fD4qy9IwQWCVcc8+KTpA3e1R2uwq?=
 =?us-ascii?Q?9BsSJ0ML7+YFxTVbfVY//wvPS/QgVaFzddNdafkIhzprhOib5wz+WonUReTy?=
 =?us-ascii?Q?U0oUIZ8psikdV//6ewiDS7tML2GXP0KjznJ5mhlkikPKGIusq6zEJD4bBGjl?=
 =?us-ascii?Q?iMSYM/wKzlJYX+XCUT3sFZe75P0kKtdXRS8OGSIUPpJmUJFlWrtsAUryvhkr?=
 =?us-ascii?Q?pXkE2xlTUPVaSuGZsk7Yt5CJ+uHPbZ37efbRyR4HAurYlaUiyv0aK0B44DQx?=
 =?us-ascii?Q?CQPHa5sTseUU3kcWUgTZCroiVekkkYqyQlCTWt+GDEelyY2l7xTyl3CqLP1T?=
 =?us-ascii?Q?SpaMj3MWsu6xdb9Kp6VybuZ7z3NjTAw6lIVgX9ht5ZDyl6gkaW97/5fU+l8m?=
 =?us-ascii?Q?oLLbtkVedtTy+RGFtEJOwJg7nQSV5CJJhwwVpA9Llhu36CuezltlE/ocvrLC?=
 =?us-ascii?Q?tqRy5P2lLUR8EiklUUM7EzHhS8RDP6h2Hxebk6rUXI3ssoPxD6y/Evfw2S0U?=
 =?us-ascii?Q?Ak2s4LTWL57HwLBAPx0RXn/jg9L31GnAp45dpexoNg9pvb5Yhb+oiLT5ndEZ?=
 =?us-ascii?Q?xfmoQA3yCwj6Q8y+1IpV9JfOZaW5H3ZLuKIc8VsD7Y626vhd+L+Nfhq/oljY?=
 =?us-ascii?Q?9Hd+uN5CDZ/nxsiqe8JNpPR09QUQ4NTo9Ys2fE9KfB2cXGtzvfxzojs1FEn8?=
 =?us-ascii?Q?Xu9Rk7Hm7oHzs/lo0a/ESxtzOE6DpDoSgOybNp6DiC/LSBOQlqrCL4E0kUUK?=
 =?us-ascii?Q?K8eb1fzJHkL1ig2b4FUEZwKKC0jNtgVj7EUcbemRrmsywjfriF9ZDtHpUUwA?=
 =?us-ascii?Q?Ek/uioO0XoRcn8V7hJX44eXaVs6WuSmxY9SL9F8iTGHD9a+8qjx+oryE2bSD?=
 =?us-ascii?Q?WgN/SIybyH01Uni5yKHzhI2gzVyeLbMMEEuGUR8+yHkZCRulpMuh9aMiiwUj?=
 =?us-ascii?Q?MMszOnmFMQIYOGzIcSLCA4vKcn+/m1r4c8w9WbVVBd1FEKJgZ6mmpasyT4Gx?=
 =?us-ascii?Q?63si+g6N2Q6JVFmZ8tyAhwRO8mr3r53WPV/scEuCQRMqW3iijvUT7U5d2CB+?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c8d0b1-39ff-4b5d-9c13-08db04a27fc0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 22:20:18.0255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mzk9ekgPukOXTeolZFLeorQOZNXVj7BTTpXD6CyUrVLTkC16SHg8OeboEkA7Wd/d+JmxFiExIOwUdfLu5zq8Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 11:06:05PM +0100, Borislav Petkov wrote:
> On Wed, Feb 01, 2023 at 01:47:58PM -0800, Ashok Raj wrote:
> > While reworking I thought while at this, there is a chance to fix other
> > things.
> 
> Your call. The more you're "fixing" other things, the longer it takes
> for your minrev thing.

My original patch for minrev was 4 patches :-)

But when Thomas finds all the other cleanups, it turned into 9. And now
stuck in review.. 

I expected the change from apply_microcode() -> collect_cpu_info() to
be straight forward..



