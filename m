Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A806EB1A8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjDUSbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjDUSba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:31:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995B319A1;
        Fri, 21 Apr 2023 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682101888; x=1713637888;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZuF1zB2M2N+2GWsXXeJnHjMJrGtu9oUB+S+qZiETIhk=;
  b=IYIMhGqCwJmrB4kz4BDCOSizsdQRDrwtZVhploWeL9cJ5BEw2nc8ZmtP
   b006gZ1PVyfuB8bntHlDeM7vkvf2OUwSzqKm98knolduSvfpf8TAV6BOD
   foPmYNPdy5un8gGsQSHT4UKgwPgNUVLCLgTyI0APg5g0YgYPiu0Rt4ui5
   FaTJJIZb6JHcFi/QOh/+OFLgEz5ZGsGF8U1qefJfX5W9I5S3dPqvlW1FS
   5KAlc8zqDCShvbBazqoHEeAhUZFaGbupe0BHp1Ouu87rxCocveU5LFx8D
   SASB1QJFt43M9TcTn4R+wNHns9gwtnDQGBCjeIBgrFxgBsA3Fr7NvwC6L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="373986859"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="373986859"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 11:31:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="836245440"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="836245440"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2023 11:31:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 11:31:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 11:31:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 11:31:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 11:31:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvmB84ia9jgo2f7WXViZ9cfUZBWtW6NjuQ37IfdLoI4wENkUSslZRyVi1ZFGlFEXM7Bf1cZIz0/tBE466CuTdVPU8yvvhqNFK2JIjN3MT6aZ/mz376U7AxLrdZ8xaVYiKHBa/QOZL5j+/ver68t6/qunGoydrGKtbnjPoxNECx8SQfU50Ok2uEXoGIcus0LEtDDmsQlSRfnj0TWAzhMFlE+ukzdz/YxkjNlXy8+4Ko/o+bUynpcjbtV3Ivr0dZ2H34gC2e/G7Lw1ag+SxYJiMOKJtXX4FB+ompdzHia0fNFDadMqFd7Ux+rRVg2xkJlq4eBqcoIHnLRJ8NWjcyjQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+BVkgyIJ2ockDPkkPOwsgWGnCxVwam4YssuXP6Poxg=;
 b=jkEDu/8oXMXaoKsMg7AVXheN14CMgQSHftML0a2dkQomX3UeILrVuXo646SrGfHO9OEYEgYXuYMXki938jbm+/xVG/o8dprhWz/KbBA+/AlkBCj2z2oQWvN58PBYnYdsy3RFHUCQjh+hJBqkAMkJghILgJ8np1ZlBboQ9/LIs03YzucBo/jkUVG3jrFa31F7y9N1L+KoR2HabrsbXOhgl3PF07EN1v/VCyyIMbXH0sAX/Zhxt6Hgw1mWuaJ0yzYXJGWIv4H22CPsAd+d/xaU4TAD5Tz89fmnOfx/yZEnD1TiyLqfc0a4d+ZJjv3p8BtgfQqwA/Xf42bR4Qj6rYdAUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB5325.namprd11.prod.outlook.com (2603:10b6:5:390::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 18:31:07 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4%3]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 18:31:07 +0000
Date:   Fri, 21 Apr 2023 11:31:03 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>, <david@redhat.com>,
        <patches@lists.linux.dev>, <linux-modules@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <pmladek@suse.com>, <petr.pavlu@suse.com>, <prarit@redhat.com>,
        <torvalds@linux-foundation.org>, <rafael@kernel.org>,
        <christophe.leroy@csgroup.eu>, <tglx@linutronix.de>,
        <peterz@infradead.org>, <song@kernel.org>, <rppt@kernel.org>,
        <dave@stgolabs.net>, <willy@infradead.org>, <vbabka@suse.cz>,
        <mhocko@suse.com>, <dave.hansen@linux.intel.com>,
        <colin.i.king@gmail.com>, <jim.cromie@gmail.com>,
        <catalin.marinas@arm.com>, <jbaron@akamai.com>,
        <rick.p.edgecombe@intel.com>, <j.granados@samsung.com>
Subject: Re: [PATCH] module: add debugging auto-load duplicate module support
Message-ID: <wjgsfhr642ec2ly24tsdqb5a3hlhvsyxknyajqql4zziqemrwh@w5rdsmxuownn>
References: <20230418204636.791699-1-mcgrof@kernel.org>
 <2023041951-evolution-unwitting-1791@gregkh>
 <ZEB6DmF+l3LVrpFI@bombadil.infradead.org>
 <ZEDOWi8ifghwmOjp@kroah.com>
 <ZEGopJ8VAYnE7LQ2@bombadil.infradead.org>
 <ZEKn89wPH19r2bM4@kroah.com>
 <bnhskcp6hy6liwlefyjcxumlnvmkmyvhvatkq7ve3kb2zecyxl@c3jq2apjqlcy>
 <ZELKKVJ11LdFsBYo@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZELKKVJ11LdFsBYo@bombadil.infradead.org>
X-ClientProxiedBy: MW4PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:303:8c::32) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c2029d-7706-43c4-ef20-08db42969209
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMJlCAgJYOuowHhX+cQvChJdEDmLiv/jIX5NChGhEInmbzAx06KCaPXsMvOt0FdTjb81WaAUjijsC0gfY8htr343G79qtoQ0cORC+Ui5qEDRPm7vuA6M2Zb4S6eNYRskjuf/MwbpdVEhPhONn+WBa/wJESw493efbGq53JLmxcwNcXn/Kh/gIvfOl6acALUzdlELD1vC04wLKV3bHSKxdVZQQRRs3PGPGqJ5W15O77R+3qAKXx6bfc9iC8tCPaSGdyHd18kOJ8OTrgNrrG7eWDtKupoudUG9amRaebd9bxedEORfdPNi6PdST4TLTUcuQQ8Ttf9J4vgK2f1KlfD2rpTlQIOXNf0sVej6gBLdXa3Elg+7/la4R9oqS2kKpI7fbjCDyi2t5xc1e/m0sql+nbuOb02MnnMTUB4DmjHwKs9vm37VxMZooY9FqNx/9UMuSgcWVsTndVVGqAVBhC6ppv25ARG65VspJYamcNR24lgqL2u+py7PaX8QMtzKFj8GvoPmQm15Lrhm/bvyS2/1tkAyHzopJgGuLcDEJYyBSypBXhcMXUzrxeIE4PauimSgTJetjm4yxG8OkXIfwkdbmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(39850400004)(376002)(346002)(136003)(451199021)(66476007)(38100700002)(2906002)(8936002)(8676002)(7416002)(86362001)(5660300002)(33716001)(41300700001)(6486002)(6666004)(6512007)(6506007)(9686003)(966005)(26005)(478600001)(83380400001)(186003)(316002)(82960400001)(66946007)(66556008)(4326008)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sp440M20qOlt9rQuhsyql0l5bWqeIl6xmoY28fGe7U6J3eJzX1ONocLGSVI3?=
 =?us-ascii?Q?OR5z6blIsSNVZjZMsHaQvTBovpglALFQdFtUqsPfwV6Z/USGd+TLXXGBdILY?=
 =?us-ascii?Q?CQtU1e24S46Ra5Gzlg//XQyRmhjFUf19I+ubHqAI3D0CCd0xnMsMIBu/qOim?=
 =?us-ascii?Q?DnlrBGr1/jDec3ZsJjAztxUaMtg7WzjrlffrU7ZAlxlktCnoF96zcuUPnP69?=
 =?us-ascii?Q?AJY0+G2PyJTxz2xdD883YKH36Ox/JjcQsv1k7NTp3CL60sAzOw7DFS1DQ10Q?=
 =?us-ascii?Q?TPASdMgbyXWbTb5r2BvOrBN5MKZvwupRaKho6VhHFxQiUmCXn7ZDdkgG8qAl?=
 =?us-ascii?Q?JVA5MalWHaCMGQkPrB+C9EekrXFHcq8MKEcWBfa++Xj+wCPhcqO+nNjTllXY?=
 =?us-ascii?Q?O4tOnzkY8lsPDKcyo8wserfy6u9i7q+TTFjnUAVBMljBNXuAjpqkQrueQlOb?=
 =?us-ascii?Q?t6gt6KZ++7TNmRHNGE53+FZ64P8Ll2+3VQ9vaF/9ibeij+xgr8tagF7VLi64?=
 =?us-ascii?Q?S1OXP5ZH7M1J0RuX20vfczF9Ftfgrf0DYBU3Y6n0308jmMQje1amthN0dqrD?=
 =?us-ascii?Q?FnzAu4XYivvEgCsMimIR9B9A4g3C22isJb0BCj5X8yJ/CD3ClTs2VJcwVkiE?=
 =?us-ascii?Q?5NbfYGskpG9gQCCM5dtAEWOVBB2Iw75P+zS1h1+RIQbzoW4BSwnW5k/TrQcj?=
 =?us-ascii?Q?W2PZSchT5VpV/2ck3Zi8CRj/NI+6K7LgYxwfRZx5n6CJYDQzpwV3eqtnwaDc?=
 =?us-ascii?Q?LpDtzTARNVotusUZTAd5FWA/VrXfc5UyDi7pDCZZsUtUinNzvHiqD008unXI?=
 =?us-ascii?Q?IihDYdR1VPIBrpshjVuc6ZsE8mkcTeTRnPmcIFGuP4EOYSb0WDjYwxwXi7Mq?=
 =?us-ascii?Q?TVElAZbkO0d5FJbKbJ0ZrzvTnkR6T/hZiBpcHphSSrZchMKYhnXN0S4Ak8UX?=
 =?us-ascii?Q?3Oy4QwVIhQtQFlphc6kv5kvdUp/igitOeK6Uu+RJoYHKhKfVsp3lVM6wgQtw?=
 =?us-ascii?Q?wpYkUxzGWLM88/4Es95ZbU+dgrESHLZh1hKUrHKbGRAEryEeq5etYdfAMota?=
 =?us-ascii?Q?PPCT0Y1LGVyK0VjygM+C3CTE9I17eSpPJXgvf0esbukkT/LLlh62+7nBOmEg?=
 =?us-ascii?Q?UCPWcqw8+D8axLYK1n3tsocqPDe52FKSQEz+IcY3LAdnZuTG8MnwErVPeP1z?=
 =?us-ascii?Q?2aqraxQx8gisCA8UvSyoZUb+a02De90cVKXppO4m+ZK5D1BnQ7xNlxTIG9h8?=
 =?us-ascii?Q?Wr2lf+PznLN4dH/9vnb35nLBcZ6liY+rhVoqWVfPxZ93FuIHOe5fE5XUwGYg?=
 =?us-ascii?Q?qYc86MHIegeMmZjbJym04oChscdmGnac6uW7OpS0Gf8g6v6c59lM1xOjgxPe?=
 =?us-ascii?Q?ayAMk2DAofpTGhqP7//UXRZD0xV0sHYgV++Pgu5O7mc2XIBDXATjJiD2vhft?=
 =?us-ascii?Q?0wPwwHfITUpXqabt4POxPAWeXtKlBYUxVzJoxnt0TzCCFHFQcdGuBXPeMV/f?=
 =?us-ascii?Q?pMoL9QnVm1TM9UFY8aUSe+hLsWYnPHHIX/vGGRclpP1Hys03ZT+khA0s1tNg?=
 =?us-ascii?Q?mgVv+EhptSB07S28rZSAJknL3X0yNppT3R5h7+vO9G/JgG7pxIKVsYItn4DF?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c2029d-7706-43c4-ef20-08db42969209
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 18:31:06.8740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XU6IljLSBrNruBnr+kkPUh+s9IF/DAv7AxLkHLGoNSvOjuilW+UZHCSMvsoRPslZprgsGZSCX4fB7194PU4fuqRT1h4Lysw/dHbNb1qYHrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5325
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

On Fri, Apr 21, 2023 at 10:38:49AM -0700, Luis Chamberlain wrote:
>On Fri, Apr 21, 2023 at 09:42:39AM -0700, Lucas De Marchi wrote:
>> On Fri, Apr 21, 2023 at 05:12:51PM +0200, Greg KH wrote:
>> > On Thu, Apr 20, 2023 at 02:03:32PM -0700, Luis Chamberlain wrote:
>> > udev is just the transport to kmod here, it's not in the job of
>> > filtering duplicate messages.
>>
>> udev nowadays use *lib*kmod. It's udev who has the
>> context it can operate on.
>>
>> Also, those module loads will not use the path this patch is changing
>> call_modprobe is not the path that triggers udev to load modules.
>> /me confused
>
>This patch prooves that module auto-loading (request_modue() calls) and
>so the /sbin/modprobe calls are *not* the issue. That is why udev was
>the next candidate consideration.

that makes more sense.

>
>> What can be done from userspace in the udev path
>>
>> 1) udev to do the ratelimit'ing. Define a time window,
>> filter out uevents in systemd/src/udev/udev-builtin-kmod.c
>>
>> 2) libkmod to do the ratelimit'ing with a similar approach, but udev
>> needs to tell libkmod what is the window it wants to use
>>
>> 3) libkmod to act on the context it has from the *kernel*. It used
>> to be cheap with the call simply blocking early on the syscall in
>> a mutex... or we didn't have that many calls. So libkmod
>> simply calls [f]init_module() again regardless of the module's
>> state being in a "coming" state.  Is this the case here?
>
>I only got so far as to also confirm libkmod is used, so if libkmod
>does that check then this is already done, but the issue I think is
>that I think that the races are so much that you still get duplicates.
>So even if the check is done there are so many parallel calls that
>the check doesn't help as the module won't be loaded for a while.
>
>> I haven't seen this data.
>
>Just build a modules-next [0] kernel with the new CONFIG_MODULE_STATS
>and after boot cat /sys/kernel/debug/modules/stats. Then increase
>the number of CPUs on the system by 2 and try again. Then enable
>the new MODULE_DEBUG_AUTOLOAD_DUPS which I just pushed to modules-next
>and see how many duplicates you see. If you don't see many then that
>means the other source for duplicates should be udev.
>
>[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next
>
>> This is done to avoid a) the toctou implied and b) to
>> provide the correct return for that call - libkmod can't know if the
>> previous call will succeed or fail.
>
>Just as with the kludge-of-concept I posted for kread [0], userspace
>also should have similar issues in mapping module name to arbitrary
>file names given:
>
>  o a module can be in different paths and libkmod could for
>     example at one point load a module in one path, then userspace
>     removes it, and the next path is used.

no, it can't. Unless you are doing out of tree modules and loading them
manually by path. There can only be one module with the same name in kmod's
database. If you have duplicate modules, depmod will use the dir
priority configured by the distro (see depmod.d(5)).

Since we are talking about *udev* it's not a real possibility as
1) the udev requests are serialized
2) there is only 1 kmod ctx, so they use the same configuration, no
funky kmod_new("/another-rootfs", ...) type of thing.

>  o module names may differ from the filename slightly (in the kernel
>    we replace dash with "_", refer to KBUILD_MODNAME

this is taken care by depmod/libkmod too. All the aliases are mapped to
module names and then normalized. See modname_normalize() in kmod.

>
>So the only thing it could do is use the full path of the module used to
>deter duplicates. Then, it could actually converge duplicate requests and
>share the results just as my kludge-of-concept did.

this is assuming you are loading modules by path from random places.
It's not what udev does.

>
>[1] https://lore.kernel.org/all/ZDmAvwi+KNvie+OI@bombadil.infradead.org/T/#md172510af8fdf7e0f76f6caafee9c99f7a8b6de7
>
>> libkmod only skips the call if the module is already in
>> the live state.
>
>It can do better, it can converge requests to avoid a kernel_read*()
>from using vmalloc space. Note that this was not well known before,
>but now it is clear.

in userspace, if using the same context and using init_module() rather
than finit_module(), I **guess** we would have a similar thing due to
the memory pool for modules: we don't read the module again. That is not
true for finit_module() though as we just open and pass the fd.

>
>I realize though that this could mean sharing a context between all
>loads thoughs in udev, and such a change could take significant time
>and review to complete.

But there is only one context. There aren't multiple paralell requests
from multiple sources. Probably need to Cc someone still changing
udev's builtin...  but from a quick look, from what I remember about
that the last time I touched it and without data to prove me wrong,
it seems we are not looking at the right problem space to come up with a
solution.

>
>If we *wanted* to do this in kernel instead, I have already shown it's
>not hard.
>
>> It seems systemd-udev also duplicates the check
>> in src/shared/module-util.c:module_load_and_warn()
>
>Evidence is showing that does not suffice for the races which are
>currently possible.

can you raise the udev verbosity and share? All the kmod-builtin
calls will already be logged there. See
src/udev/udev-event.c:udev_event_execute_run() leading to

	log_device_debug(event->dev, "Running built-in command \"%s\"", command);
	r = udev_builtin_run(event->dev, &event->rtnl, builtin_cmd, command, false);

if you are rather seeing "Running command", ohh... then your udev was
built without libkmod and it will just fork/exec. Not what we want.

>
>> Note that libkmod already spares loading the module multiple times from
>> disk as it uses a memory pool for the modules. It reuses one iff it
>> comes from the same context (i.e. it's only udev involved and not a
>> bunch of parallel calls to modprobe).
>
>If a different context is used its not shared.

see above.

>
>> 4) If all the calls are coming from the same context and it is udev...
>> I'm not sure this is actually the problem - the udev's kmod builtin
>> handler is single-threaded and will handle one request at a time.
>> I don't see any data to confirm it's coming from a single source or
>> multiple sources. Could you get a trace containing [f]init_module and
>> the trace_module_request(), together with a verbose udev log?
>>
>> If this is all coming from a synthetic use case with thousands of
>> modprobe execs, I'm not sure there is much to do on the userspace side.
>
>It's not synthetic, I rested simply increasing the number of CPUs on a
>system, you can use kdevops for that if you want to try.
>
>> > > > Why not
>> > > > just rate-limit it in userspace if your system can't handle 10's of
>> > > > thousands of kmod calls all at once? I think many s390 systems did this
>> > > > decades ago when they were controlling 10's of thousands of scsi devices
>> > > > and were hit with "device detection storms" at boot like this.
>> > >
>> > > Boot is a special context and in this particular case I agree userspace
>> > > kmod could/should be extended to avoid duplicate module requests in that
>>
>> see above
>>
>> > > context. But likewise the kernel should only have to try to issue a
>> > > request for a single module once, if it could easily do that.
>> >
>> > Are you sure that this is happening at boot in a way that userspace
>> > didn't just trigger it on its own after init started up?  That happens
>> > as a "coldboot" walk of the device tree and all uevent are regenerated.
>> > That is userspace asking for this, so there's nothing that the kernel
>> > can do.
>> >
>> > > This does beg the question, why force userspace to rate limit if we
>> > > can do better in the kernel? Specially if *we're the ones*, as you say,
>> > > that are hinting to userspace to shoot back loading modules for us and we
>> > > know we're just going to drop duplicates?
>> >
>> > Maybe error out of duplicate module loading earlier?  I don't know,
>> > sorry.
>>
>> I still don't see what's the source of the problem from the data
>> available. Is the kernel issuing multiple request_module()?
>
>For the cases I saw it only accounted for *one* of the many duplicates.
>So that's not it.
>
>> Or is the
>> kernel sending multiple udev event for userspace to map the alias to the
>> module and load it?
>
>That's what I suspect. Each CPU triggers tons of module loads.

so it seems the easiest thing to do is collect the udev log.

>
>> The mapping alias -> module currently belongs in
>> userspace so if you are de-duplicating, it can't be only on the module
>> name.
>
>That's one way, but it can also do it on the path used too.

path should be irrelevant for the problem we are looking at.

>
>> > > > What specific devices and bus types are the problem here for these systems?
>> > >
>> > > My best assessment of the situation is that each CPU in udev ends up triggering
>> > > a load of duplicate set of modules, not just one, but *a lot*. Not sure
>> > > what heuristics udev uses to load a set of modules per CPU.
>> >
>> > Again, finding which device and bus is causing the problem is going to
>> > be key here to try to solve the issue.  Are you logging duplicate module
>>
>> agreed.
>>
>> If the info I requested above is available on other threads, could you
>> point me to those?
>>
>> thanks
>> Lucas De Marchi
>>
>> > loads by name as well?
>
>The above instructions on using modules-next will let you both see
>what's going on.

hopefully you don't have CONFIG_UEVENT_HELPER_PATH set or anything
mucking /sys/kernel/uevent_helper. Right?

Lucas De Marchi

>
>  Luis
