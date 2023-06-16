Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9187328CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbjFPHZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjFPHZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:25:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F4B18D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686900338; x=1718436338;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LstOKWW3YnwX2YTF7JwyvOoTW5KKPS0DYa71OLB9/kU=;
  b=cDskqLPNsAhf36U2xBWBx94IBWx+gR65fGebaA43P5ApdwhwkvySRbsO
   HpMFxmR2byk2SfSghojW55RBH4ejdj6jJmLL1cjHFSv9x+fhME3oI4I7U
   MMeZDMhrchmkNO9EyF7QwKq7cXyvU2FWI3HC9GbhRrbvmxzYRbTWWWOSb
   MqsnB8/iGu1Nehc2KNonw4zv29bgq16pZcAIDnArKuCYT+Qm8nI7s1VL8
   X0ErTEe6Yl1SQHD4iQxHCWE5/zAZI1t+6s4dNWCdV2H7PID555yy4BZpm
   /YqqaREea8qjbpv82pgS8b3iVSx25RROf7sN+EU0EEhy2YHsmWRiqEo3e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425085910"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425085910"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 00:25:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="836923499"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="836923499"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 16 Jun 2023 00:25:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 00:25:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 00:25:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 00:25:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 00:25:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfOb8H+3YPq6FX/X2f99dVmkopFOQMf7dcE+3kBFZeCUw1gLW4u73OMFHXVAOd1NL07T94bZGvbRePX/OurwyoYCwvQy4DyJQwp830UnObDb5jkk83/QLfxZpAIW3cz1xIeQ44o458buVa53lSHLCCOtK9RJj6PwbhOeBwrf7PiviND8ats8Mo4SyAsOxOvClpit2NXvi53DCEfWmSbJL6nrsmP9GxFgoZQIwKAiY9qy+DYNES3v0Khgn/OpN4i4st1nkB859/dfYtS/EV6KcQ1pkSymPpXPxl3gaS7uX/ZWFP+wDIGjtDKrSwN5aCSDVTjoAJbBNhO6A8Ydk1F/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHRaRTQ7wneJ4FSDMHJASU02kitGnT/P4dJK7Y6qsbA=;
 b=XHx+XMDbiG4BVbPa5FSJ6QvMPY5uu5tu4OCmyNz7lXaGdR7B78H/s6IowS0psOAQY53mKGk6CVbWdng05tOjKqwOkYSkC+t9nlJbYghVYUN/rmPFUvXz56IzA3XjSiDqqvrTwxWf0evl2ladWeoiy+XOF3jLjUr7zLWZQin9UqLYmqJcXltxnG18ntYkRwVbzBC5tS3JfrUmqzKlgognT3Ez6Ow+Tc1BIsImhseQtEKo7QH8OybWOC71T0fkzZLbNR1d8WCcZaavKPv41UgSun0hht8EAmMCL78bCRz5Mqt1mMEnLfTVQaFbzUQS6zbHhraavY7Zf8J96Mdnf3Euag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA2PR11MB4905.namprd11.prod.outlook.com (2603:10b6:806:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 07:25:34 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::b691:df38:dc96:30a7]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::b691:df38:dc96:30a7%4]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 07:25:34 +0000
Date:   Fri, 16 Jun 2023 15:18:10 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
        <tim.c.chen@intel.com>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Message-ID: <ZIwMstkB7CG3pDYu@feng-clx>
References: <20230613052523.1106821-1-feng.tang@intel.com>
 <20230613052523.1106821-2-feng.tang@intel.com>
 <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA2PR11MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc0d702-89fb-4605-2f79-08db6e3adf17
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q1+KOwZW4uaOK1qXPrEOEDf6cRGIOtpLTwu0WuSDVg5UDUCWoW0TrMxhHTNkFz7A6Yaprk8NL93NdqZIGf3p+PBw4agABywGgXu/fCfdLmpsVGCc4hH37ku7r1H5FzJrso6ruw4hs/tdzq6QJYDgJ0HSrS80OAHpIcTI93yYRlrP1h3BaD4jJfSZoPtoj5qIAptL+mYkwC0esttEZcjc1g2T4y3Mn26WJgPNVbaAA3R0/93b2Fq5qgRyXhhWiAaRV0yTvTVwZLezZEK0zgXwyElAuIUN7wT5zJ4ubPCFAb3P6PcpMQa1kPAEe9NXlTBfQvQyXni2Ialz+2q3V1DqMrMFMUplCSTZL5/qdPvAc57V2eDOlieTAsGaZPhc/mx2UmKpkIT7jhao0NqKxAujE+ntygStylzSRxckzxnQDWy0vG+7uTno3p6GulalkHdDxzuhPw8WdGc3A8OXD2guzJH6LxaiveHZDR8HNDc7CD5SpVbuiyNcbJAAYyVfvWEUjFiPqc95KvqMmfQZMz0zGu0Be6uMjHjv92JwH/uF017VLA7F+XFTIK0+uF6Ku4W/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199021)(5660300002)(478600001)(54906003)(8936002)(41300700001)(316002)(8676002)(6486002)(7416002)(44832011)(186003)(6506007)(4326008)(6916009)(66946007)(66476007)(6666004)(66556008)(26005)(9686003)(6512007)(83380400001)(2906002)(38100700002)(82960400001)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2rT7qBH9Zanrprkvz2MHok2HBTlFeAlclS/4QFIq1e8u+DnwcZ6421IwvnOl?=
 =?us-ascii?Q?NUMZyXI4DQjU01JrssxpBlIRrjAyWZbFwnunhHEil8I8OCU8l8Pccqlkrbab?=
 =?us-ascii?Q?EZQYFX2zo5XEhnTCcB+GgFuoxpS8HNloF38WK9/NvT2TP7Ts4mVQIhFhOaJJ?=
 =?us-ascii?Q?kiEzu8D903Rz4ZW8pRkId9bBodpNGrqhWQ2gHr68ktRu32KlU0dPQJ+eOqBU?=
 =?us-ascii?Q?ToNmUmCxp7xkLLEpmhOIgsKebzXABgWxpAU68Aj4YD6yA6Y/WKfKLIGiRrr4?=
 =?us-ascii?Q?6e+hOd1PDxc9rgWmyvM6Uw4vmdZv96lKiH62DLBJGqwUW/SO673ZvPbXxn2W?=
 =?us-ascii?Q?v735N9FYkOho2CECaq91XbvroD2uLnvjSOtuV75wa9s26cbhPzaeq7qaQ3Vj?=
 =?us-ascii?Q?xQILV5vkjDjTf9RuKdwqBgxpiPh6Xe6pgSoUSSACbL1kIxAgrwi1MbXqo3D6?=
 =?us-ascii?Q?CeZjsdYc4wt3y8NcZbEnblUMK6356AjJpd/OWesZ0vEcddJwW15tKznm1a8K?=
 =?us-ascii?Q?zvEO5EBlXSxMKApMqaJaWxRsB2n4S5tcCwxnOlc7gvLfGsfRKu4pShTe51t2?=
 =?us-ascii?Q?HWAzjQfb63AOl8LA7o6EE8iNhiydOodHz8rDxRb17jbVTeb6KtvxepCvaojV?=
 =?us-ascii?Q?xCZg4b0YGk5ut4eOrUWy3MD1V7LJkXy0sQ2FUTWzXc7cFi26OAtdr+jAcJzL?=
 =?us-ascii?Q?lthOgUV7RapC96Vto/kpPpH9mXL4qJestHphGnFW1wqcU1i+3Qo4+lhxdaZt?=
 =?us-ascii?Q?tong/5AHdUYe5zfeoWYHhEN6Yjk3A4VRvJQzHgRA+IB25SN15/MFah03AWh7?=
 =?us-ascii?Q?zKwLghy1LB71c67KsV3zzjLS2bD8RKnhS8/zNIJFNRQMdL2I2S4KC/OSFC/S?=
 =?us-ascii?Q?Yp3DcGO5mNXcKAuTNZrCcQyDhQpG9F/Y8gcPGjFafViasC3FL2RWtvHE8upE?=
 =?us-ascii?Q?uJOjNsWFi3xCiOIG2Y+k/IELkNj3gatOQUl0zmRGPRL4UAR1xl7cCpvRHPJj?=
 =?us-ascii?Q?0WVOSBXxjnYENQoOoPT/u38ReXcphtZtr23qxr450OOQ6pySsESw6u3GBxPb?=
 =?us-ascii?Q?16J3gt8tQvC28qf+JP3uFoGhQp3DFBG8bVJI0GllyHa+nYPO8YkrvAw49MaV?=
 =?us-ascii?Q?mnJs+J7Bhc8WidlgwfmR69bZYQkv5hoV2Txhj+qT0P0mgWNlIyXkmeULrxdv?=
 =?us-ascii?Q?UOWrIxO8wFSeXVxF78sciVHQvWxDOKT4T9j8mCFFQrPCicRE1GlkQbXZpdHW?=
 =?us-ascii?Q?FF644GYvGH7XsriAxgvKrmLKRFk32oK9aPMMOjVNNjzt816mSLJrSPejdn0j?=
 =?us-ascii?Q?o5oLk2c/PVguaqGAtRGv6TCIxS2LIduH3nOGdP14bcXKNXd5yWI77XXbDuTk?=
 =?us-ascii?Q?A9jgIWeeiZ2Zkf6yNJFICnuGMaGjTFuh7TS0xEzEd+8rKfwKUgrTbJHtS/jV?=
 =?us-ascii?Q?paWTrn3UjlGAC3vcK9N1cGqyAbG1XJwBlmjcQ3ELD+qWRD9KaFB63lapvj7+?=
 =?us-ascii?Q?1KIh7xB9zxyGE/NBdcQvfuiBhIkQbzXHq9DHhdb2UeQ8X6Kuv10zLoDMOcjF?=
 =?us-ascii?Q?na2QuPvhlMFUhbK4V+ISpXLtReDpuYR21WRYw3Bg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc0d702-89fb-4605-2f79-08db6e3adf17
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:25:33.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqveLkMSOJeScL9utarv2dw+9R4VqZyQdv+rJSML0jBnkFejYlFagpQ7ls34eXS+szKg36RiTaQGW911s1Xokg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4905
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

On Thu, Jun 15, 2023 at 11:20:21AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 13, 2023 at 01:25:23PM +0800, Feng Tang wrote:
> > Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
> > on qualified platorms") was introduced to solve problem that
> > sometimes TSC clocksource is wrongly judged as unstable by watchdog
> > like 'jiffies', HPET, etc.
> > 
> > In it, the hardware socket number is a key factor for judging whether
> > to disable the watchdog for TSC, and 'nr_online_nodes' was chosen as
> > an estimation due to it is needed in early boot phase before
> > registering 'tsc-early' clocksource, where all none-boot CPUs are not
> > brought up yet.
> > 
> > In recent patch review, Dave and Rui pointed out there are many cases
> > in which 'nr_online_nodes' is not accurate, like:
> > 
> > * numa emulation (numa=fake=4 etc.)
> > * numa=off
> > * platforms with CPU-less HBM nodes, CPU-less Optane memory nodes.
> > * SNC (sub-numa cluster) mode enabled
> > * 'nr_cpus=' and 'maxcpus=' kernel cmdline parameter setup
> > 
> > Peter Zijlstra suggested 'logical_packages', and it seems to be the
> > best option we have as it covers all the cases above except the
> > last one. But it is only usable after smp_init() and all CPUs are
> > brought up, while 'tsc-early' is initialized before that.
> > 
> > One solution is to skip the watchdog for 'tsc-early' clocksource,
> > and move the check after smp_init(), while before 'tsc' clocksource
> > is registered, where 'logical_packages' could be used.
> > 
> > For 'nr_cpus' and 'maxcpus' cmdline case, the global flag
> > 'package_count_unreliable' will be set to true and the watchdog
> > will be kept as is.
> 
> So I have at least two machines where I boot with 'possible_cpus=#'
> because the BIOS MADT is reporting a stupid number of CPUs that aren't
> actually there.
> 
> So I think I'm lucky and side-stepped this nonsense, but if someone were
> to use nr_cpus= for this same purpose, they get screwed over and get the
> watchdog. Sad day for them I suppose.

Thanks for sharing the info! Now I know one reason why those cmdline
parameters were created.

> I realize there might not be a perfect solution,

Yes. Rui is working on a MADT based parsing which may take a while
before being stable, given all kinds of fancy firmware out there.

> but I'm also struggling
> to see the value of the whole package_count_unreliable thing.

'possible_cpus' and 'nr_cpus' parameters are a little different from
"maxcpus' that they limit the possible cpus during boot, and after
boot user has no ways to online other CPUs beyond that limit.

But for 'maxcpus' case, user can online a small number of CPU during
boot and onlined all CPUs later on, which has a possible under
estimation issue for package number, while the above 2 don't have. 

So how about only keeping the 'package_count_unreliable' check for
'maxcpus' case? 

Thanks,
Feng




