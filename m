Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CFB674B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjATE6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjATE6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:58:02 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F012942C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674190045; x=1705726045;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SBghP9K4zvw1TFJAkywR+x8nQNeab6+OBI4EaFtv0Ns=;
  b=LC9Pbb8FDAdNCH34mCcxN9akQ0WoQo7+cgn6P4Z948e5kDK7SzWx8zZl
   RVmrPAMdycGSlMdT9QZOYW5g5LCq3FNkGqiw85RndCwyA3Ja1qKksqAmc
   hY9VPZRNon5tZykYLVdOg9qMC7w8oHkRnpZ7RPUOYkjqag0QoMD6nzQkB
   4+1TT4/9evtkoB/a8upLn/vZt3WzQrpeKaCvHSKbOd78WOjY+h5YTorYj
   N8TY40fVcgOSOK4SZUqx/bpwXfiOvQgN5YDg/IxN66dUkLX38pEhgrl+t
   ebIDUj24EWQelMIQoz8vW3mtkA2YpV7yTZc76WqB1llI1udVZkIlbn7tG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387855462"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="387855462"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 18:19:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="653639464"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="653639464"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 19 Jan 2023 18:19:17 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 18:19:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 18:19:16 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 18:19:16 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 18:19:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTcEFdKC5mtYNLkcYAVARtu/BgSvzcTlZfNQiUxEJCQcoxnjQNS5qOcRt2WXXtq6FCydp0VIF1KbIPOqTu7pD2c5AqiiwHEWlgFIl19MqaZYOw18kWuBshb80wailxpXigLCgJ3/0OEk60Wm/9CvFWcO/1EAGIrzo63nr/eef/oWIDuV6dPUPRo0Ao4UV5v6rPI49oWqXGIOSZJ3QCrI63EEP0SOuzC1m7hZ6zF+rFvFYie0f3FwTLXZj2cIvhYsEUev9pS3Ub2qA5or9iL4+hZN2jzprc5GMa6w+Fmc7d+3sczRbgRaImj7xKf7jNERyifW4Z5cgt5SfOIpv84hfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uvh9jWyhcTqKkBIJJ7UbJKcYxEW12PvWVjLR3qyq+JM=;
 b=jryX08YGmOSxJvx5C6ByZWzl3V4M1/Y8EQcjGXSqByP7wzEnFvtUU8ilhfgk86XXDad/3DKIxeTT84DT3d002MtEp9dL2QhlI4fFw7LoGqZXha02vogwATiQM/pU6L6C6JDzHXYBsTfCPbdXvadWfhCZ60W77wKy+haTGJfVo/ef20P1lQJ473gp67YjasVSpVTrZpAFlZwvtc99NDsral/80Yah7jvMBNitVs19N0i7fva4zyZ17lG4X4qWeHdhbqVbwt9zD4yt+d2YcqtuM+lBJ/avcKGdvhyT19o/pbYnMzgQ1mZd7A7dsW8x+dMWsZ/yeqWXxH7b+McYi/CmlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH7PR11MB7593.namprd11.prod.outlook.com (2603:10b6:510:27f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 02:19:13 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%9]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 02:19:13 +0000
Date:   Thu, 19 Jan 2023 18:19:07 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
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
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v1 Part2 3/5] x86/microcode: Add a generic mechanism to
 declare support for minrev
Message-ID: <Y8n6G7gyCiQzjIto@a4bf019067fa.jf.intel.com>
References: <20230113172920.113612-1-ashok.raj@intel.com>
 <20230113172920.113612-4-ashok.raj@intel.com>
 <87y1pygiyf.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87y1pygiyf.ffs@tglx>
X-ClientProxiedBy: SJ0PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::25) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH7PR11MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca3f2b3-6e7c-40a7-0534-08dafa8cb90a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXuVd0unzBMSOfGh1cBhlTEHzdAYqZ3qeQKC1B7oAIgJ6qeHoyafFXbs/cH+BxAmnYDoRTJyoGmvQGOVS+1MkHr6Np6qtDWh69yYE/c42RYwP+u/7j8K9xenR69NL6CPUd5Q8EzdZJCwbSIp858jptu1rrL4kp09bw5QWwhQ3VaVWE13AYkg3T6xhFP2lelFYFmYQKnmhBxqVYf4aT96aYB44k7GZZStsSgwJzKFE6UBpN5azGD5UpVbdTzKMNL5KsmZbjyLR0NG8fu0bR2A4Ygj3urp0LiPfJwfkKdXCDeyHSWawQPNKoWje3Pl3Rv+bi7iOl6S6ybZwn8pPxVb7u+OEMZ0EDQoifnoQTtt1KSOxiUGTj0yOP77fVQQwi393Wn6wFosLvOBNW/Ph0MCFjYCNE5XWe2TPrghKjX5ikshgazxMp58TVvVf1/UeXagL291yHWrI7l45vEknpFEoe0H9jw+bPDNkR29cgBGTIPau5nuZqb5IZPWkr0OfLFS0tCrRcLR2qsJnQHQdfRLX2n0smHitpCdxX4fkDNvf6mKv2BH6DrndAeoJGuFD0Q1TJyzkxESW60KkBQJ2sszIbjTk5oPIvOYRtmc6mIwif6a1KbTNMXmwq2AkQJHNh11aOyq4b/NZqX6JV48IwH6DV9XIcAclM47BY/ZltvcMNNkRr72pPo6V5C7ZkU7gMC/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199015)(478600001)(66556008)(66476007)(66946007)(7416002)(2906002)(44832011)(5660300002)(8936002)(82960400001)(38100700002)(316002)(54906003)(6666004)(107886003)(6486002)(6506007)(86362001)(186003)(8676002)(4326008)(6916009)(41300700001)(26005)(83380400001)(6512007)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/VO4w+TfpocN7Y9cTo5GDzfGcqdo7bRJUrkQxR3pB4KRWQvJMS93XHHeFO3X?=
 =?us-ascii?Q?gFpssIO9P70SeEXauH/1IY8ay2xubif7C+b0wrybytoPWrbAICokO5cc31/V?=
 =?us-ascii?Q?3QY8+p9lH5gFgaljdyxmsnrbEQurWkm9K2p3CFGMkZqz8ldkgyMXN2Sc9CYU?=
 =?us-ascii?Q?m862j65p6gc1r15dqabzM3wGY6DQOuh5rMd//H1gToKoQLvpyvWWKSyuJzyz?=
 =?us-ascii?Q?t2YrCQVsH8akWpE50rWdvsOamWHHkUx73gnuf+I8VQz9Dt+ArtNxVvU2c0ia?=
 =?us-ascii?Q?LE3mEbF5UvFSh/k8WEkyFUxVgyL3HftvryWynUsNSnz+EcZRxDu4/6Bzh2sB?=
 =?us-ascii?Q?xJbWvzqxayTSM5LLAuf9dkdQIeDWoTmwbWHNJdvZHiVwu0UtRq14TwHE03e6?=
 =?us-ascii?Q?6CqadwJffoqmEOKgZdvr0sQyoypOz/r1/swlGzZJpGAmwqrXOU/N29udCnpg?=
 =?us-ascii?Q?TabnxtvVHRNv/LmA1ygx42vAovEXJVZQu/IZVb4WiYb/UXxZusLJkaM1n05t?=
 =?us-ascii?Q?QoCMz7+JdSMcaxj505QET4cCrM2+eVzjFsJRDd+t/ZsdrG7VNgv1D2OZM8cJ?=
 =?us-ascii?Q?6x3mLqtDqCiFHv2g42F2ZkJOfQmF8zceE8T5QSG0BeOKwk56TQBp8CWqx2iY?=
 =?us-ascii?Q?FM0p5FvuRk8zDhV0u2sLzfgAxkYYZDAYZ8x2UICKfE2I7BFdlDdz0epj54PY?=
 =?us-ascii?Q?zOzRnc8KJjrmsAWQTsy3lKS8Q6Dlh1vVvN9pzSt8A2aNoLGk0H6LVY839szc?=
 =?us-ascii?Q?B0fzPRhXKhr86liHqLy0JvoqwBdYev/3JVVS2XpG93zl3IvSLLrPB4PPkZ5e?=
 =?us-ascii?Q?hBz9ARyls1HUDLEnem6flcpyw35k9XKiCXrlPa8kaoDXc63F3EpbBVDtiEYn?=
 =?us-ascii?Q?gpvkLFTbOFK92uLE58CmrcVyzqzmqy/OYZejZ+8/ZVIEjrVomNST1hlj0b9z?=
 =?us-ascii?Q?rWF+gwhrKDV9MhnBXs5i+aT3EfmAAV/p/4oNsdniTsojbAOeYVaYs2K2mojB?=
 =?us-ascii?Q?slGTOFR4jT7WFzQX3HosrQ3NqNmMBNddPeIAgjrYQqRyYa/W/33MXrpSRVFO?=
 =?us-ascii?Q?ULdZEM2/E8/rzmfrFeTa3ijK3Z4vJTGRDAVS6ysGMzi+dJjK+BOnRDYULQfe?=
 =?us-ascii?Q?lk0hyNkZa7v77N+lBLIBK9yA6EL50oqEklep+kR8RBwGZqgxjwCPADM3yo2I?=
 =?us-ascii?Q?JSynU7ozvjxkSUN98Z7j4YdLhWrVXJ/KKKypMoz08npUL9CyPY9V8hT2q/VR?=
 =?us-ascii?Q?6KuPbsGuMjZy2bdfd5SZrk10LUmbOcfv/8pPqnVeN2j7HNalZjLNuq1b50BV?=
 =?us-ascii?Q?VnnF+KVZja65+4Bb3pG9u3WVnDzYnCpcbWGPBpo1vWxeFyliM21j5KeN7/a+?=
 =?us-ascii?Q?GXiJQrDBMBrQsQu6GkEvI9GBFLiG899PfTJIVhJsh7VRx00/N1q0Xb3AEznE?=
 =?us-ascii?Q?gSJQcyqcOENJqatG/qXmzGFbGZi1lasMdfmZi2U8rfYa++x30IpBi20ruhA2?=
 =?us-ascii?Q?2oLT9UiZVbdli6bNF2II//UtZ/7Efk2WkoHJ/vmoCg/vYjGqSzB7ZzsmtTYD?=
 =?us-ascii?Q?Ih0Ri9HVdeyZOHZnpCtc73wgWyHAR7WDKhS1bRL7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca3f2b3-6e7c-40a7-0534-08dafa8cb90a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 02:19:13.5496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3JXa1Qw3xF1LARoXAjfuo70GnML9Iit/+6Zr7lEUqUIynQS273wbfOJIpE946mx/97L+/EOyUD/6QPmowoV5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7593
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 01:15:04AM +0100, Thomas Gleixner wrote:
> Ashok!

I know I'm in trouble when it starts like this :-(

> 
> On Fri, Jan 13 2023 at 09:29, Ashok Raj wrote:
> > Intel microcode adds some meta-data to report a minimum required revision
> > before this new microcode can be safely late loaded. There are no generic
> 
> s/this new microcode/a new microcode revision/
> 
> Changelogs are not restricted by twitter posting rules.

:-)

> 
> > mechanism to declare support for all vendors.
> >
> > Add generic support to microcode core to declare such support, this allows
> > late-loading to be permitted in those architectures that report support
> > for safe late loading.
> >
> > Late loading has added support for
> >
> > - New images declaring a required minimum base version before a late-load
> >   is performed.
> >
> > Tainting only happens on architectures that don't support minimum required
> > version reporting.
> >
> > Add a new variable in microcode_ops to allow an architecture to declare
> > support for safe microcode late loading.
> > @@ -487,13 +488,22 @@ static ssize_t reload_store(struct device *dev,
> >  	if (ret)
> >  		goto put;
> >  
> > +	safe_late_load = microcode_ops->safe_late_load;
> > +
> > +	/*
> > +	 * If safe loading indication isn't present, bail out.
> > +	 */
> > +	if (!safe_late_load) {
> > +		pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
> > +		pr_err("You should switch to early loading, if possible.\n");
> > +		ret = -EINVAL;
> > +		goto put;
> > +	}
> > +
> >  	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
> >  	if (tmp_ret != UCODE_NEW)
> >  		goto put;
> >  
> > -	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
> > -	pr_err("You should switch to early loading, if possible.\n");
> > -
> 
> Why are you not moving the pr_err()s right away (in 1/5) to the place
> where you move it now?

Could have, didn't occur then. But I can move them to the proper place in
patch1.

> 
> >  	mutex_lock(&microcode_mutex);
> >  	ret = microcode_reload_late();
> >  	mutex_unlock(&microcode_mutex);
> > @@ -501,11 +511,16 @@ static ssize_t reload_store(struct device *dev,
> >  put:
> >  	cpus_read_unlock();
> >  
> > +	/*
> > +	 * Only taint if a successful load and vendor doesn't support
> > +	 * safe_late_load
> > +	 */
> > +	if (!(ret && safe_late_load))
> > +		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> 
> The resulting code is undecodable garbage. Whats worse is that the
> existing logic in this code is broken already.

Yes, I agree, its hard to comprehend. I'll open it up a little to it makes
sense.

if successfully loaded, and !safe_late_load
       add_taint()


> 
> #1
> 	ssize_t ret = 0;
> 
> This 'ret = 0' assignment is pointless as ret is immediately overwritten
> by the next line:

This was existing code, but I can certainly remove the unneeded
initialization.

> 
> 	ret = kstrtoul(buf, 0, &val);
> 	if (ret)
> 		return ret;
> 
> 	if (val != 1)
> 		return size;
> 
> Now this is really useful. If the value is invalid, i.e. it causes the
> function to abort immediately it returns 'size' which means the write
> was successful. Oh well.

Yes, its a bit awkward. This is how its been forever. 

I wasn't sure if the purpose was values other than 1 don't throw error, so
it could be used to accommodate some extended functionality say "echo X"
in the future.

I'm not suggesting such use :-), but thought that maybe the reason to not
report error. 

If its acceptable to return like -EINVAL or something we could do that, so
there is some error user can catch in user space.

> 
> Now lets look at a few lines further down:
> 
> #2
> 
> 	ssize_t ret = 0;
>         ...
>         ret = check_online_cpus();
> 	if (ret)
> 		goto put;
>         ...
> put:
>         ...
> 	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
>         ...
>         return ret;
> 
> Why are we tainting the kernel when there was absolutely ZERO action
> done here? All what check_online_cpus() figured out was that not enough
> CPUs were online, right? That justfies a error return, but the taint is
> bogus, no?

Agree!

This was the code that was introduced in 5.19 when we turned off
late-loading in the kernel. We try to fix it here, i.e only taint if the
loading was successful and safe_late_load wasn't set.

It should change after this patch? Or maybe you meant fix it to not taint
always before doing this change? 

> 
> The next bogosity is:
> 
> 	ssize_t ret = 0;
>         ...
>         tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
> 	if (tmp_ret != UCODE_NEW)
> 		goto put;
>         ...    
> put:
>         ...
> 	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> 
> 	if (ret == 0)
> 		ret = size;
> 
>         return ret;
> 
> IOW, the microcode request can fail for whatever reason and the return
> value is unconditionally 'size' which means the write to the sysfs file
> is successfull.

Loading can fail for some known reasons

- No file found
- File is either same or older rev than loaded

Should we return proper codes? Certainly can, but since this has been
around all this time, I'm worried someone who depends on this working this
way will now see failures when it didn't in the past.

> 
> #3
> 
> Not to talk about the completely broken error handling in the actual
> microcode loading case in __reload_late()::wait_for_siblings code path.
> 
> Maybe more #...

I'll need to stare at it more than I have .. 

If its busted, its not popping out.

It's a path that all CPUs go through for the exit rendezvous.

We let the secondary also do an apply_microcode(), just to update the
revision in the per-cpu structures. I could be wrong, but if we didn't
update the per-cpu rev, /proc/cpuinfo was reporting the old values. I
remember doing this way back in 2018 Spectre time.

Guess a multiple choice might be useful :-).. I'll keep looking though!

> 
> How does any of this make sense and allows sensible scripting of this
> interface?
> 
> Surely you spent several orders of magnitude more time to stare at this
> code than I did during this review, no?

Sadly yes!

> 
> Now instead of noticing and fixing any of this nonsense you are duct
> taping this whole safe_late_load handling into that mess to make it even
> more incomprehensible.

safe_late_loading didn't change any of the old algorithms for late-loading
itself. All I used it was a mechanism to inform the core that the vendor
supports some way to tell the minrev is comprehended. This doesn't change
any of the code paths we take for late-load.

When safe_late_load is supported, 

- we don't issue a warning, or taint the kernel.
- Vendor provides a way to check if the new microcode has the proper
  meta-data and honor that.

Did you have something more in mind?

> 
> If you expected an alternative patch here, then I have to disappoint
> you.

Disappointed .. No.. I'm glad this is coming up after 4 years. The next
Part3 that has the NMI handling sort of has something similar to hold HT
siblings in NMI before the update completes in primary. Better now than
late .. 

Thanks for all the direction.
> 
> I'm not presenting you the proper solution this time on a silver tablet
> because I'm in the process of taming my 'let me fix this for you' reflex
> to prepare for my retirement some years down the road.
> 
> But you should have enough hints to fix all of this for real, right?

Yes, once i can spot all those holes :-)

Cheers,
Ashok
