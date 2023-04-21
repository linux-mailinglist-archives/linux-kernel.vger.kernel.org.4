Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E663E6EAF60
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjDUQnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDUQnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:43:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15094C16F;
        Fri, 21 Apr 2023 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682095393; x=1713631393;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gMdAN66UnzCbu4uMuRRlJkiDbvN1yU+znW/SywhApNc=;
  b=JJ4KYh3aMj87CyZ5kiah6/p+1rfrAOfds8JGNfVYSt4CoV9XGtvUiMrQ
   3k0lXgqk3NLBSIbCgfJTtJDgWfAPCPFlK8xGYBUh3zGzOI+SpFGy2ro5e
   4OlaHVCu8siHIjKnkdJjX9fXS9SfLvDBy4OoweYc/VYZoB41EJJxmCTuP
   33GJpSEvPN3issY75yNifWTV5pu8e3qxRNCaDhuyu54vM5XV+1W42VjDY
   dX56s7hsIsKJDgaAdzB3ijRHqr6W3z9i89FW5NIdZYjsnGdyyqwzWVvWZ
   JN+TlDhvS2L0ObK8IxMFPTPDjs61ou0hGD66/KkdA/7Pker9ojbwTnCtg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="411300038"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="411300038"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 09:43:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="761628822"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="761628822"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 21 Apr 2023 09:43:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 09:43:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 09:43:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 09:43:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 09:43:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ7UPEnsZt/pez/sDcipkoqmSA3pTAtj6Vk4GvdxmKr8Nm5raYckmmlMmszjFCObbaWsb5mV4yGsiavmulzG1Mf89/6sFAZFrs87PxEnT2B+ZBIlyDd7cksDuXW4goHrbaNbEImaqki8u7mw4BwlW4Hns7X2AI3Ayy4bocvg/Wl3G0LfRTBwcttR1ReN9jvPEduBQzGt87//E5YrW4YU3UgH9/nr4GNwWwrOfz7gLOnpRH4rcPRWvw0KBvobLvJ9orxI9JwFBZxcFztjZX4g1jIWBjbdeMIB5dN1Ty7DvnbuSvdm9NoBlk9ocT/5L0zpFG/Yp+7iy9bw4zXLQ8Y1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UHmkGxow93TaGp/xAW1UdiO5+Fon6lyWWCoUGwQjh8=;
 b=VflXZyMcBO8n4wtf/UTQMtiwwZvs8qogVYcZx97X8kJ6zlmbro318h3JotN/cc+T19ccLRph3KKv4xuZbRasMts3DQ+8g6VtdBZKxs7RrjNvevuPtp/LucXW0zGm8DoMtHCJ7F6IZj5ZcfbZbz53cSCo96LnW0tg5O+4ODyfv/8eRiXPUUIzsJi7ERM8OvgqFDqLyaADaT6cHJlQSiUgzA5CHq6/Bs4ff8AT3VleOD2/JBkthf/IQoAhGPbGCvUcRtBui6XGSXRDj/LC3cpTH8rPxfJS1yYdFillXmxhfTVZYrG8ac/vP9tv7Mmxi7XKwYX8CCF1sNENwAqoK3k9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA1PR11MB6613.namprd11.prod.outlook.com (2603:10b6:806:254::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 16:43:02 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4%3]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 16:43:02 +0000
Date:   Fri, 21 Apr 2023 09:42:39 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>, <david@redhat.com>,
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
Message-ID: <bnhskcp6hy6liwlefyjcxumlnvmkmyvhvatkq7ve3kb2zecyxl@c3jq2apjqlcy>
References: <20230418204636.791699-1-mcgrof@kernel.org>
 <2023041951-evolution-unwitting-1791@gregkh>
 <ZEB6DmF+l3LVrpFI@bombadil.infradead.org>
 <ZEDOWi8ifghwmOjp@kroah.com>
 <ZEGopJ8VAYnE7LQ2@bombadil.infradead.org>
 <ZEKn89wPH19r2bM4@kroah.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZEKn89wPH19r2bM4@kroah.com>
X-ClientProxiedBy: BYAPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::16) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA1PR11MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ed257f-6adf-45df-3606-08db42876d81
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDIVEWCYVBK0Vc7+4m+3LaH1NK1BR2ipOnPyWgUpCJhkz1U7mejUMWm4F8cyIi2Qtp3/46YeemMHlrqFlSgwJQpwZ13Oujw0NISsW15hy6NEpXot3yZP0e7HvJF6dAoaADnromnFK9lPI5WaRoP74Em61Qcg4DT0Q9r/+TnM5lOl8FxxQF56/fvAxtGt1tkrBC00BvaaSFCNrZljU+MCDaJ/S5xNgfPTjrciSMCiS8JgYsUYa7RvJyLTAfpGRgjOsFjg5Jw+xls//fTtbveB+7iwK805jNG9QNbUH/zkQ6iaa4qPT4xCFHTi/IOA8O9XdO2eFmw1/aqkYPLsRTqmFw+CWXvzckhFBOzuTbLABZ1QC+4tGPuJJDXct8iLMMvrh4lvQkH01ZznqyEMBZDdqISal/6t1pH4obQS4j64BLgwCO4HHWhd0qgqQSzzekVuNx7DprCryIFhZk0s+8h2qzRn4iY3jSwdmnNXqQ8yRBR74IefLLUCHkKMVRsojK4yVmMB+gqjRJ7CHrWVV6x2D85VKi0r+iIHWsOiGQ6KWh00o3/I7ypQzQTBbyd8vK4b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(86362001)(316002)(478600001)(6916009)(66946007)(66476007)(66556008)(186003)(4326008)(6506007)(2906002)(26005)(9686003)(6512007)(83380400001)(5660300002)(66899021)(38100700002)(6666004)(8676002)(6486002)(33716001)(8936002)(82960400001)(41300700001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+E/II+e9W4JLdV7FRoDqEb3PkUJlFVBA9+wGEbGfEdy8iTZrutpXhX/+6tdV?=
 =?us-ascii?Q?yskrLW5x+jAx2s0IyyVQjatWbU9d2V3ddCDw0GCC2vkv/4WlEihvI6TZUN2W?=
 =?us-ascii?Q?cTrOVh/70iiRoTBCj4iCsvqrHwUz8qZXk9Wb9nXqDQzyNFPHHhKCYtlTYesd?=
 =?us-ascii?Q?SbzweoD77IQcmDaadqJXZuS+5LrFZv00KWffFNNp69ELqim0I7/rr9g2Aumn?=
 =?us-ascii?Q?QOJYgm8W4mb3Z88G5aLYo8cT4DdALkFXN9d6paUnLbH2eKhj4D7vrTdtrndS?=
 =?us-ascii?Q?otsnUFrEjALOC5Azn5BiqJO6epzBprQhlprYw0SNmHPxM9txmM7u5l8hmhz4?=
 =?us-ascii?Q?TJKK2H6YWWqzvmEdUWzEDeefvBT7afowb4siYyquCRTwy7EBkmJNKNaqZggf?=
 =?us-ascii?Q?Q1AzYGb/cYRMAbf+0/4gF1EmHOF8Pylp8J7y0LMWim6NdXIUzx518HaeGWn0?=
 =?us-ascii?Q?j687/LiSotLY/otv04FI1vAGYdraQAPAeGd3awGmeHDoD3NE4ali20qGqTIC?=
 =?us-ascii?Q?7L3FuFLeMeSQCepMj2tavU4FRjSN5gAm10mJGLBOTVqNW52pbHC1h/Z7dZOM?=
 =?us-ascii?Q?xxClIE7a3lMyO5b7SETaSwVSO4fP/UVlVgD3uj9cGeUc4kJs55gIMbvnPRnG?=
 =?us-ascii?Q?4iszrwXAzj8RTC5Qhkm1+OB4cAttHHcCIHKYFMJU85YHIT6ZBVRQ/7IpxRp+?=
 =?us-ascii?Q?vBcSLHRe+mNejWajemnnXN7Osp21sWxelc2ncsr6IsjMFBhFfH/za+tNx/PO?=
 =?us-ascii?Q?PD8nsmnXDepl/VsWvX64aMzuSTPN+PvOITDxMQ0wIDYeqQ++T6AGPs6gx1oK?=
 =?us-ascii?Q?P3940rs2IZsjI2RrxmUJwzaQuQD3qHww1u0VUp84ZgeWNVIaWd/StyCKryXJ?=
 =?us-ascii?Q?dtjtuLPnS67K15Rs7SqUscMzbgC1q4EIAr1do+B0rA0FhCV4oywoa6YrZpqz?=
 =?us-ascii?Q?DFeNJuJTQwtYL7x2/lShvvqoX/v1oaCJh+/v32LoH4nu8mKPCkenU5QVb9g7?=
 =?us-ascii?Q?tVMeRW46/8QmzmSOJCCCIOMK8tKP1tU68jpA6Bs3CBVlnmv2819iTgkj1HQq?=
 =?us-ascii?Q?yzQpiTGm0/4GgPisWOsGLIB4t5kU7Ecwc3LcbJzas9mTFKk3UU/4UTBZPAwB?=
 =?us-ascii?Q?MyQWiId08qVSsTV1jntvm2tIbwFPMniliJrgl7D75NpdYUtwmLGmJ+yhnvQL?=
 =?us-ascii?Q?0+0hUzM9iF7jPDmHNU/fI3GkDVxcAeEqbYFXS55pg01ZxRR7ed7QByPdg883?=
 =?us-ascii?Q?bg2Tm7h9EX8Z18In13MqUKMAPcQH4nVojh2mWp8vFRiFbB4A9+jZNJN2LC0z?=
 =?us-ascii?Q?HjbrXEAMkniOTLm4b36C/ptf2b17+kQXNc1n4zUY6rNIvBPBNrZ+tku3qj6h?=
 =?us-ascii?Q?cmUZ8bS17+bgbcLW8xoADvcA/zbs/O9eFYAkOC9nAGKZf4o8G+HPscmjcPvY?=
 =?us-ascii?Q?QdsJomNWPl8Et6piFd00bg/YQrPGGnKa9FXOchAZJPOs8RoN0i0/k/f8ekwD?=
 =?us-ascii?Q?1fpQu4Zpj3qgcMKM39UPiiJ8mZoGz6HcqZ4Nowz5yo1+SOfQJeRJqPrpe6Og?=
 =?us-ascii?Q?WDeWLb9j2bzzidatD6fINFh61AwIhp1yBC5dOVXtH3hrxBCgO/7Olrx8WzJY?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ed257f-6adf-45df-3606-08db42876d81
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 16:43:02.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3J7gTNB6+Yot+91fSuHhd077xdt6aerw1dj6hc8mfFkbYT34cWULL4pntq/pqcqA2srldoa+z7o+LhwDJQSSsntJsiCrHFBDquLx/3I1FX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6613
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 05:12:51PM +0200, Greg KH wrote:
>On Thu, Apr 20, 2023 at 02:03:32PM -0700, Luis Chamberlain wrote:
>> On Thu, Apr 20, 2023 at 07:32:10AM +0200, Greg KH wrote:
>> > On Wed, Apr 19, 2023 at 04:32:30PM -0700, Luis Chamberlain wrote:
>> > > > It's not "wasted", as it is returned when the module is determined to be
>> > > > a duplicate.  Otherwise everyone will want this enabled as they think it
>> > > > will actually save memory.
>> > >
>> > > I'll change the language to be clear the issue is memory pressure early
>> > > on boot. I'll also add a bit of language to help at least guide people
>> > > to realize that the real value-add for this, ie, I'll have to mention we
>> > > suspect issue is udev and not module auto-loading and that this however
>> > > may still help find a few cases we can optimize for.
>> >
>> > This isn't udev's "problem", all it is doing is what the kernel asked it
>> > to do.  The kernel said "Here's a new device I found, load a module for
>> > it please!"
>>
>> If you believe that then the issue is still a kernel issue, and the
>> second part to that sentence "load a module for it" was done without
>> consideration of the implications, or without optimizations in mind.
>> Given the implications were perhaps not well understood it is unfair
>> for us to be hard on ourselves on that. But now we know, ideally if we
>> could we *should* only issue a request for a module *once* during boot.
>
>But there is no mapping between devices and modules other than what is
>exported in the module info and that is up to userspace to handle.
>
>> Where does the kernel actually say "load a module"?
>
>The driver core says "hey a new device is now present!"
>
>Userspace takes that message and calls kmod with the device information
>which then determines what module to load by looking at the device
>aliases.
>
>> Isn't that just an implied gesture?
>
>Yes.
>
>> > And it's the kmod code here, not udev itself doing all of this.
>>
>> Yes, IMHO kmod could and *should* be enhanced to share a loading context
>> during boot so to avoid duplicates too and then udev would have to
>> embrace such functionality. That's going to take time to propagate, as
>> you can imagine.
>
>udev is just the transport to kmod here, it's not in the job of
>filtering duplicate messages.

udev nowadays use *lib*kmod. It's udev who has the
context it can operate on.

Also, those module loads will not use the path this patch is changing
call_modprobe is not the path that triggers udev to load modules.
/me confused

What can be done from userspace in the udev path

1) udev to do the ratelimit'ing. Define a time window,
filter out uevents in systemd/src/udev/udev-builtin-kmod.c

2) libkmod to do the ratelimit'ing with a similar approach, but udev
needs to tell libkmod what is the window it wants to use

3) libkmod to act on the context it has from the *kernel*. It used
to be cheap with the call simply blocking early on the syscall in
a mutex... or we didn't have that many calls. So libkmod
simply calls [f]init_module() again regardless of the module's
state being in a "coming" state.  Is this the case here? I haven't
seen this data. This is done to avoid a) the toctou implied and b) to
provide the correct return for that call - libkmod can't know if the
previous call will succeed or fail.

libkmod only skips the call if the module is already in
the live state. It seems systemd-udev also duplicates the check
in src/shared/module-util.c:module_load_and_warn()

Note that libkmod already spares loading the module multiple times from
disk as it uses a memory pool for the modules. It reuses one iff it
comes from the same context (i.e. it's only udev involved and not a
bunch of parallel calls to modprobe).

4) If all the calls are coming from the same context and it is udev...
I'm not sure this is actually the problem - the udev's kmod builtin
handler is single-threaded and will handle one request at a time.
I don't see any data to confirm it's coming from a single source or
multiple sources. Could you get a trace containing [f]init_module and
the trace_module_request(), together with a verbose udev log?

If this is all coming from a synthetic use case with thousands of
modprobe execs, I'm not sure there is much to do on the userspace side.

>
>> > Why not
>> > just rate-limit it in userspace if your system can't handle 10's of
>> > thousands of kmod calls all at once? I think many s390 systems did this
>> > decades ago when they were controlling 10's of thousands of scsi devices
>> > and were hit with "device detection storms" at boot like this.
>>
>> Boot is a special context and in this particular case I agree userspace
>> kmod could/should be extended to avoid duplicate module requests in that

see above

>> context. But likewise the kernel should only have to try to issue a
>> request for a single module once, if it could easily do that.
>
>Are you sure that this is happening at boot in a way that userspace
>didn't just trigger it on its own after init started up?  That happens
>as a "coldboot" walk of the device tree and all uevent are regenerated.
>That is userspace asking for this, so there's nothing that the kernel
>can do.
>
>> This does beg the question, why force userspace to rate limit if we
>> can do better in the kernel? Specially if *we're the ones*, as you say,
>> that are hinting to userspace to shoot back loading modules for us and we
>> know we're just going to drop duplicates?
>
>Maybe error out of duplicate module loading earlier?  I don't know,
>sorry.

I still don't see what's the source of the problem from the data
available. Is the kernel issuing multiple request_module()? Or is the
kernel sending multiple udev event for userspace to map the alias to the
module and load it? The mapping alias -> module currently belongs in
userspace so if you are de-duplicating, it can't be only on the module
name.

>
>> > What specific devices and bus types are the problem here for these systems?
>>
>> My best assessment of the situation is that each CPU in udev ends up triggering
>> a load of duplicate set of modules, not just one, but *a lot*. Not sure
>> what heuristics udev uses to load a set of modules per CPU.
>
>Again, finding which device and bus is causing the problem is going to
>be key here to try to solve the issue.  Are you logging duplicate module

agreed.

If the info I requested above is available on other threads, could you
point me to those?

thanks
Lucas De Marchi

>loads by name as well?
>
>thanks,
>
>greg k-h
