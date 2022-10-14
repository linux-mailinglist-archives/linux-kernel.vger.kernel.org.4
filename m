Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA575FE65A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJNAhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJNAho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:37:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AC215F905
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665707864; x=1697243864;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wZ88CDI7QFOpvUJIGhVwLUy+bGBtiS6dNaNK+oOLf+Y=;
  b=dHnremEk4H2Tf6R5/KpsvMxUnuWPTKj4vhP0ZvXCyhVUmKKimrAdZkd/
   FwlkiwIT7VSUSwHeP87w3kSxRzSS8QRJddV/0794EjNu8FU6K8BRThgmY
   2NWBDOaDYVPhyjcOeJ1TKwqUf7Gwdy53LWYvYxIwaJEIecFOm4fEY5Wkh
   2cs580ovOoEbb7+W2f4CYgT0X93kadBAPKlEhVF6EkWCIpyPeID0mtx4W
   WU6eHNnjw2w7ITjUMOYH/ugAplhlxPtdMsDaOEG35xPjsKnOnhA/8sri/
   k9Fz/xhKW6dq0I4eJDMOA1EFp7ZlgToqaBIeXYO1dfVsrYXLXeROhTtQX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="391550446"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="391550446"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 17:37:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="627380910"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="627380910"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2022 17:37:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 17:37:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 17:37:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 17:37:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 17:37:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XETZdtMSgnwRRG6d87PAgg2Yo5HxPRol7dsULJ5MYVpnQBqtKMahlWqX9RL4wOmqfm4MWJqaAcwNEQDz7WJucTH47VJBUKTjDGg+yzQLMn6N+vgmT9VYyW0yC70O/L1sg4RFZswJneEk2yiI0yOCHUAl19loRcC98hg1RNijbHteikAqRf14aN44S8guFKSyuGx0iBd6ANdIxJf+oJ5jcLanmgyB1btOwEz0e5yOQJ+LxQliHGWYyMikWlOJ27xqHpJpwr2sn15EQFWFg0xXIJx4CLTYGc0sYZ+YYT2JDFMvS2RZD/YkBWaJCDyMd8gGINPlRi7RiueFDOpUriYq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RpbrnXtKRzsYD7hmb8LJCkr+fXYzzIK7jS7OWIyzkA=;
 b=glYtoOuGk8TaUXKTPKtyR8bBMfv0gPAcqgOL6rdZQaP2/oZHva6oVz0pUv/kKTyfNvQPH5PjAGWzSs4bbiceVHBqBJm+OAip7lIcZrKYSergtSbZ7rP4u5NKU2mPh/BPXo2LtVucJeya+/QWBeiRD+6fr/mlOMVwVJNawdHw/+7tsGGFPEPmYjusgILvuUBN1U3fvWPSQTqaggUMYrn56qM5i53TB7JpWA15WJF70GUuXl/cSHkAsq4IU4xBUQE6QRvcsHp056NSfBq29QrflTn8Fwjj2Og0Hmkcua6JZT04kU+v/ma9qRLYNymRuo/baf174Y5JISeiH+AZ30617A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH0PR11MB5561.namprd11.prod.outlook.com (2603:10b6:610:d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 00:37:38 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.022; Fri, 14 Oct 2022
 00:37:38 +0000
Date:   Fri, 14 Oct 2022 08:37:18 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
        <tim.c.chen@intel.com>, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>
Subject: Re: [PATCH v2] x86/tsc: Extend watchdog check exemption to 4-Sockets
 platform
Message-ID: <Y0ivPhN/BgLZXKmu@feng-clx>
References: <20221013131200.973649-1-feng.tang@intel.com>
 <a4860054-0f16-6513-f121-501048431086@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a4860054-0f16-6513-f121-501048431086@intel.com>
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CH0PR11MB5561:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6a72d1-7c6f-4e07-f5e1-08daad7c4ba2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7EITV06G3C0AB4gBD8+NINT6X3Qjmbj7e1pAOiiEgCnzWtHpTnOQg/xZxJWOwsLS2QJOl/XNAZ1QTwnohVRZs7jhEmb1TxcrNP7+tptwDuxVVjUBLkV7KzVAPhm3UeAd/iGMt0jR+CSRwCIf4yuuX8AmF66Fmii9J5U8lQ/yztqX0hhtTazM+85f1cdn/+9iVF5R8qmf4ratPdf42Btz95VhNPRHuX3dteCgRJvSRxh22xg84DB6QsVp4i/bK0sif35EGFwK+Hm5IoU9WD6FyTcNO0uEJTuzku0vEJRLN54keiG8vTygGO0biAy8ZvI9iGmXVeqr/M6y3CpJFynKOcwV8HHFwA0HNcUo4+SWdFij36t4MuiVaTVCS9f+Ydv6cSN0bRGTqXghEZcE1WDev3qGNMt7wk4MzWdvGTwAOhkPv01WP9Mhers/PeJeM52PQaMjddAqSOGy2XVJd3qpw3Afgz1Jl+4aypSE54vlWzH7zfTjg/T/IZVjQhpCqHRwmntl7+wtJo/ojt3u8uHzyvvW8CahQKGVUvXcYb1gX/CrOrtY5bF6tU+704xI3YSh5Fup3BEBbKSI7LUlF/S7ofZ4L6KvCYhacdOMrdYRd2NcxYVUzIsnvAlHp6dx2DQ+pLHtc+ufFb8ODx+LpeZXHH4hfZkA0X957yhukbYslrZbL8nZCFQxSFrDB41N1dUG/XU65MEnusKiEV6BPAnBNgZLS14GCEHr+OpnGtwXCeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199015)(33716001)(8936002)(2906002)(66476007)(66556008)(66946007)(8676002)(41300700001)(44832011)(38100700002)(4326008)(966005)(6486002)(86362001)(478600001)(6636002)(316002)(54906003)(5660300002)(6862004)(82960400001)(186003)(26005)(6666004)(53546011)(83380400001)(6506007)(6512007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xr29JEyYXPtEKeRiUuf+iEZo0HgDedno4d0f12TAGI6uWqb0/QwItZKQ2DhJ?=
 =?us-ascii?Q?F8ydI/8PPb1gXob/uZKjxWMzo0BVPP1fRKB5hLV69Bxs0oTuywrwIo3f/6G3?=
 =?us-ascii?Q?LassJSVSRnWIS3FnFS9HWP7xYanp1enscAi3Rm/MW2F32SJr9cvwvUQs+pPU?=
 =?us-ascii?Q?X3wef3rC0MKsjNui8xqVg+WvR45CN5KpvBKdi22/c+piqKhKtwUTGeK+LYWZ?=
 =?us-ascii?Q?o5LTu1RR0+E53b3l0/GJEyLywivOz78TYCs3g2mj9Ii0ew6xyQ3Y9LB+LsLb?=
 =?us-ascii?Q?7pqEM5Ud7FR2TJzJ6FoQH5+HRNvjGoEOLRXdJUbwyCnRw0grDxNb6x+HtA4K?=
 =?us-ascii?Q?cUaoDYpfa9FtBfls3kqB6wpgsVGV4+ICWWAib75E7y1uvSCdpo4F4N3MgbZc?=
 =?us-ascii?Q?KpMnixOyZuFkQ1Tb64t4mBjwbMiN7FkW7z6J5bi21xZF2qlJWmz8y0TJ3Pct?=
 =?us-ascii?Q?W3CL/6V6OYJzI3sGcPzWFv9WofFsNN0+51Fi2eyvsuKRn0rRfP8dGiunPr3D?=
 =?us-ascii?Q?0ifH/dol+WutOOXe5t6GcB0ZTxUDFe42YJ+OOu/leIc51ESPZlJAzIIoqMrW?=
 =?us-ascii?Q?AWpUlN9G43XqPNB7Qr0533dmNWuz2qKvi4lIJUt/ljEngwjL62RLlIr5OKmX?=
 =?us-ascii?Q?AsyR0+wbim1QAo2P7WOnKK8uoMuPBBIhc5XNWyTohmDGbTvjAznOxpFXNAq/?=
 =?us-ascii?Q?gbr9rhWMpP9JWkEnsPhXf/J+XIEoNrMMXSYvexlcf+B6f8nzkbCB82KL4DZ8?=
 =?us-ascii?Q?l2pUKqWw3sLO+QZNnwCasiZ2W8QN9KiWEt2wuYTNrG/mhEs2KnAX8moHTjJC?=
 =?us-ascii?Q?0KNT8Tf8ZNqYhb2GCQrbB/vgZstUB1bX1TpKCSxLC/oVZfCxeOYcFORC5UYc?=
 =?us-ascii?Q?a+XxSHroAX+doq1myEMqzKTmAhFDNjXDy517WBmrH/1Rntk3wlb6SD/HFw36?=
 =?us-ascii?Q?6Uo05bFFb4plhXyDHZBfooqRVkRCxtNBwXE43DXW26KKb6UclfmO9pUwzUlM?=
 =?us-ascii?Q?NswrWwkbZdUPMykMqffwfo4wE7jOJzHMqwsu04IzDTh0xxRe5bQj+4EFFFHm?=
 =?us-ascii?Q?d+SCpMuiRxf989bkx5OSsIlb5bDU49o+uP39E+UoncVEM7lqTfWIcpj6rD/K?=
 =?us-ascii?Q?ge6DwTKXCwttW8QXbgtBEBCU9ORDOus2vxoBmiNvo6Tv4LRtoySqnDNOOZdY?=
 =?us-ascii?Q?uipucVew1L7UePbpUvb03U8JqXhspsrEdxEFEOkXv4Uwq9HWzV7Alho7gEKG?=
 =?us-ascii?Q?tE1yZrXfo9V/sJg3eAuWrgNiQPLEt0CipYhH1K9quZ+ESTGd4hFrKyySApnJ?=
 =?us-ascii?Q?DshnEn6aU3ugn5agS7NMgWAyRWthMXYMvS+p0vxqCW7pp01/UKhRCIjqiTC0?=
 =?us-ascii?Q?B/BuXoDv9a2bQVvKwFISV+9PNdZUd0HQZUr78vg+YrJ9aA2kVTi4tiW5/Llz?=
 =?us-ascii?Q?7sLiVMFLC39ohq/RIxbAIr9HCHDaWgu9uowFSa+/Yp3jzwGhbJJS3Iu6lGif?=
 =?us-ascii?Q?hMgBDQBN3Xi6L/cNjc+yrNI529RwOtfArpmeDrBKIkYpLsLJvEZt1HXzB+0x?=
 =?us-ascii?Q?rSIyJyrEvY40dgv84kOKu+OCIx2tg6aLT0IeFT0/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6a72d1-7c6f-4e07-f5e1-08daad7c4ba2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 00:37:38.4273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JdsjtebjpD0bS9HniVmZcXo2vNPDQNzHe5bAeiYpisO5xwbus/PPgpNstUvNkdjMr6o+2jt/5smXgQ99XGVkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5561
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 09:02:43AM -0700, Dave Hansen wrote:
> On 10/13/22 06:12, Feng Tang wrote:
> > @@ -1217,7 +1217,7 @@ static void __init check_system_tsc_reliable(void)
> >  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> >  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> >  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> > -	    nr_online_nodes <= 2)
> > +	    nr_online_nodes <= 4)
> >  		tsc_disable_clocksource_watchdog();
> 
> I still don't think we should perpetuate this hack.
> 
> This just plain doesn't work in numa=off numa=fake=... or presumably in
> cases where NUMA is disabled in the firmware and memory is interleaved
> across all sockets.
> 
> It also presumably doesn't work on two-socket systems that have
> Cluster-on-Die or Sub-NUMA-Clustering where a single socket is chopped
> up into multiple nodes.

Yes, after you raised the 'nr_online_nodes' issue, Peter, Rui and I
have discussed the problem, and plan to post a RFC patch as in 
 https://lore.kernel.org/lkml/Y0UgeUIJSFNR4mQB@feng-clx/

Which can cover:
 - numa=fake=... case
 - platform has DRAM nodes and cpu-less HBM/PMEM nodes

and 'sub-numa-clustering' can't be covered, and the tsc will be
watchdoged as before.

For numa=off case, there is only one CPU up, and I think lifting this
watchdog for tsc is fine.

Thanks,
Feng




