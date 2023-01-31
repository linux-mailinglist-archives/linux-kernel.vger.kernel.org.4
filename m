Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0201F6839B6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjAaWyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjAaWyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:54:43 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46DF58281
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675205681; x=1706741681;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OO/x/ylHiLR43frm90FJfRCS//n3KNUbMjOhG04feJk=;
  b=H8cUVZmwHZ7pqI3R1AwMtQ0dZXz/rHHYsJNYitQ+sf4aCD8vcGwCj/UG
   c2A0uQSVwykk5w0fJAl4jATKJsX0WsOuBDosgwAEs+RQnHL9Yp4xCUVA3
   q8Uy0es9jzOb60v3vJ98KOLfK2nNIrXyqYRPk66QmK1ZUlMTFIjCrRzBC
   qbC+/g7Lonb4VfWJ9cVikqu68bquRIthIuesrIlFKMQpcU8CxMMF9aaaO
   2BSZYowWyWzYs57b8cdYf7CnyNguTJZkqVDOQanIgF5VdGEM+hXHV1qak
   jsx9YBy0JMWANtPXP6br+/2PodbspMbzXsdqf7anM7Cu8o9SHjPRRRQcV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="311607649"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="311607649"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:54:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="695122525"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="695122525"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 31 Jan 2023 14:54:40 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 14:54:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 14:54:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 14:54:39 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 14:54:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mz+cqbFySdLawexrAHUAOBCmqnqJtDVpkEIF3G6TjaEeDq01/P+9rm1fs8Zkqnxm+F+br9s5ai/ADu0njDilNT9p7MPN9RRHKzzo1g2G0L4X2pbq4fAqeTOuvw2hYUJbV8g/QeLgaN2AHwgtemGtNvWiwZ5DasK7QuTC+0CICT080XGoGrXn98I6so/6mwc5HjLQcFJcx2bQLDgmry97l8kr/nc3MahWl4YZHSZelSUCXNn7fa/NtgFzFDLa/xOVL0hnRRnsxH2ll0pNr0Grv3ocxretDtIDn1VJ4UhuhQvdfl9OvJn24VbtsT/n+808GJHQq4X3JfLFuhu8oAiIlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znQWY0/0HYx+RRL8dIjqm9rI63PWQl7m8jFfNWD+9Wo=;
 b=exWhe+CWz01aHJbLEzZWmw/TO+gk2kB4AyXGjjoMTIuW5++15zLkpviU7KSdWoiCIx5F7iyZRx0RhxEPEeYCyrgXtS+4BYVLO6uYv+0CC1Gh0yHjIVtWriZHcNYPSagXn+qsgdutswtf1Ng3DeB0dXJ4THXsrIqo754QUQBpr3cwsyF0Qy4Oq+ASoTO1FyoIVn8bzO3ynrOSp9ujIA2K0jtR5K/0v5k44U4yKUfPAvxdyPa3nhwbDP7pfEF6owqZodUnOlPTMzAMJbT+zs0qJHlqTSmuqrqxgQnYJKhUYqB4XThyPoZsFEOmggzZJVvlU2VpyqA2CVZYqKPsRmCnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SJ0PR11MB6768.namprd11.prod.outlook.com (2603:10b6:a03:47f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 22:54:36 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%5]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 22:54:36 +0000
Date:   Tue, 31 Jan 2023 14:54:03 -0800
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
Message-ID: <Y9mcCxYK/VPB0ATM@a4bf019067fa.jf.intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-2-ashok.raj@intel.com>
 <Y9kAlKFfdek2rq6g@zn.tnic>
 <Y9lHDWjjnqdletL3@a4bf019067fa.jf.intel.com>
 <Y9l4FdvytLqMc3jm@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9l4FdvytLqMc3jm@zn.tnic>
X-ClientProxiedBy: BYAPR21CA0024.namprd21.prod.outlook.com
 (2603:10b6:a03:114::34) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SJ0PR11MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 27cb75fc-30f5-4ef1-966d-08db03de2033
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jSPBCOg9zLDoBK/Pz+fE6KMIpZVMoFgwspACZCnzRpViBNOXZHMQ0zX7j8FItBqLgBzmy8BwETNXZ4hMwFRLA4hA59BPpHBe0XvhVDkJJE2e3vbyVY+y+DA4rNE7Q2hoY+vLEv27dqhvMRiNOMYe0w1OZbnBvEi9p4j2m9gwKH1P/maXa0SsH+MleJhgpS+GnVSuNFCW79LYSaTB7Mp4ZBm1Nq4/3baWjz6mqQrmGWF/CGgPbV/lPF38huuEaQb/om3xkKFiY5h4KT6NGdAZ+IEvjIavBE+yvcYbzhIf2P2PDnSaqL8NBd3tKhS+N9MrJVEaOYSu/ACUap9x7+iUQ+gpOmc6GOdb8MH8hqpgXoj7ew1t3h7YBrFpwzCyaXH6rvrf//L1GSrFlhL4IUVwSJEa+j6XQAvbfD30ZKzhBPDKXfQhVbNMGl/WRObdkZahviP1OGwrX+8GKlJc1d1DJYFkdgfffo4+3t0rhLA+LZSjVBXUhjl6B1MaWY+eNsM+EdN+medZhjYIVcbeWjD1Wr7oGhWW6LPbfBFD3gcdxoM+AQ7/vpzd4+H45/com9KZXTIHbHJOowPkcVGfwkgP0weM7IVwK2qrkJvdYWILC5KWEF1jMqDtrDtlRcfdEBjS94v/ZsdOAziIcUM8vz+OqZ/bc6aE0Y5YSw9Qrtcn6wwwnfhNYgJyPg/KWSSn8D6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199018)(66946007)(4326008)(66556008)(8676002)(83380400001)(66476007)(86362001)(38100700002)(82960400001)(54906003)(6916009)(107886003)(26005)(6666004)(186003)(316002)(6512007)(966005)(6486002)(6506007)(478600001)(5660300002)(8936002)(44832011)(7416002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?02VLl/x3JHzR1uS2ISlUjGZtUqC5cAtWQPc4+mHX5JK2M/sqod5c6wfK4pgm?=
 =?us-ascii?Q?snjutUxs30lO/5WzUN5qZRrzoUaOsSq5ZogsoqSRzxlpbc6uO8vlQWXYUeat?=
 =?us-ascii?Q?CCATi8nY/xIuVjOigMIp40gJ/nwwSt4ClQE/s487c//AH5dF8+4X7E5VD/fS?=
 =?us-ascii?Q?L8noEyeQ33hh5FBVbkBXvcMcWNvbkxtVcZ1QGztheY8lRwl2725mXWWdR96a?=
 =?us-ascii?Q?uDiUoao28dyM82NmRjObU9DKcb19mnhJ3evlfzp1QaDrDDe/sqOSp422qT7N?=
 =?us-ascii?Q?TrNlVie7S34xWPPGm8fj2HzP0bWY8nkfVvgveqo5nQa6Gy8NHS7JIUNH8mCF?=
 =?us-ascii?Q?lk/IqADrf/ARW4eoh6LaCoV5O1TY84ACOa8hQJ+ktjb2JpqXCo6bBvTShVhy?=
 =?us-ascii?Q?9iLJ60IwD9S9lgnTG5jIsooMBknOjrALAO7TnEDe+eQcjIz00XXzJe/3DVCZ?=
 =?us-ascii?Q?vVt6+HH7vBXWrvqht6AVXD7a7SMe2PD75dTn+wh8c+sewzQ8maBPx5DlWX8c?=
 =?us-ascii?Q?ln015PaQlHzPJ6RQyLDqn+U9FYPhQ9VXyz2Ol+HCSPgaZK5hO5+W63oDaQmf?=
 =?us-ascii?Q?PmBfVOpHmki5CCHPr7ZfWRln3Ee/Y1w4aoNL9HTLYJy+D59ycMyphoCW+rZV?=
 =?us-ascii?Q?8Fjc47cVsOUwSTCjFO0HCeXb1K/Apau4gzyuzILv31+vk5zG4Of8kiA0U9Wl?=
 =?us-ascii?Q?9f/wiH3jb6zGnyE0S05/RITCb9/rDa8L1gC+TeolLm/HCm2CodydGmNNxl7k?=
 =?us-ascii?Q?ZRoMErNH9D5MWeUicrWw3rlYn2bHzU3jQEci0XiLmuypzScUwPhwdzUk1yEt?=
 =?us-ascii?Q?t68IPRgpR7KTGhadhC1TZWJn0qA0LgIA6KEIt4qq+1XutFmbL+3bqu0K3DBh?=
 =?us-ascii?Q?rlhQMts60dczM22HRYJ6hD51lwA4QVIXdWD2qfg+RkMIFBHl1w04SWq3DkB5?=
 =?us-ascii?Q?E83MY4NuIzr90qckvQ7A+aroAEPt9opkptkwop/M1yuTy9lot175L8ujLfyY?=
 =?us-ascii?Q?SqfG/fUguEYO3beN8KF/72XDgrcL59FPma3fLa+zZVHIZrDVfScFnFLKCr7K?=
 =?us-ascii?Q?Yucx8gRJc98uqLmUiC2tWxym7gVkOShCvlXfvsqQ420tr6bYwGRG5EG5ZzKM?=
 =?us-ascii?Q?RJCmnnIfqT0Ik+c2NrlRyC5xROnauktx9z83Sl8/9dLMkTU6B7jARO1fToBV?=
 =?us-ascii?Q?k2Eunu7RePgNRjuSOI7G81iw0zMwaP4Wl1Af039xTelAfkHKhYOWXpAjRY4K?=
 =?us-ascii?Q?tRSHq5OQvusITUb+yDORPwryGd2jaaq6BLfFa5sPm7/3evAioduF+3Rnx48/?=
 =?us-ascii?Q?wluZoWjdwaB+raqQwjO1ZJC43cEem5D2LkCpGciWwBiiM/IGJZmNj/T9V9oM?=
 =?us-ascii?Q?mY7SC8S0K0M78qBjPGzrvISjdr+5IY9nOE+tJ9ukvqaWb4TomNaQ8JM4VBhs?=
 =?us-ascii?Q?LI3SKmR9j3283yOYIAbAwZV2cZYKHIa4J8kvwQc4bDOepIAOrR5WN1sBDxgs?=
 =?us-ascii?Q?SvWvTTJHXtt3nyRuykIQ54WnSada/2oUf/Bx4yATHhe08ykK0iWaL9zWjqsT?=
 =?us-ascii?Q?aVfQwq66iIx04pDHXwkFh4orV3CUYblP1Qc+Fa2x6cYJpYgIk8TYhexJX92R?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cb75fc-30f5-4ef1-966d-08db03de2033
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 22:54:36.3119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC2RbWcGK8KSfmurRsJhrJf5LuB3mZ3mbNUlwEwuc/p9qNsiiVo5w5DkPOHlS6DXAj/OMJLlaVyGYcC+OUUUzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6768
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 09:20:37PM +0100, Borislav Petkov wrote:
> On Tue, Jan 31, 2023 at 08:51:25AM -0800, Ashok Raj wrote:
> > remove ret = 0 during initialization since its cleared right below. (tglx)
> 
> Sure.
> 
> > Need to set ret explicitly to either -EINVAL, or size. Otherwise it will be
> > endlessly waiting for write to complete. (As Aubrey pointed out)
> 
> Then do:
> 
>         tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
>         if (tmp_ret != UCODE_NEW)
>                 return size;
> 
> to signal what it is. It certainly ain't an error if it doesn't find new
> microcode.

It's not an error, only when request_microcode() returns UCODE_ERROR, should
it return -EINVAL, if its UCODE_NFOUND, or otherwise the code should treat
as success. 

The diff I attached was: https://lore.kernel.org/lkml/Y9lHDWjjnqdletL3@a4bf019067fa.jf.intel.com/

 	if (tmp_ret != UCODE_NEW)
-		return ret;
+		return (tmp_ret == UCODE_ERROR ? -EINVAL : size);

Does the above look fine? 

> 
> > I think its safe to leave ret as is, since microcode_reload_late() only
> > returns -1, or 0.
> 
> No it doesn't. Hint: stop_machine_cpuslocked().
> 
> > Pull this into the ret == 0, so taint only if the update was successful? 
> 
> Ok.
> 
> > And add a message so its not silent?
> 
> You'd add a printk for every possible operation, wouldn't you?

:-) Not like that.. But looking through most of the cases that does
add_taint() either have some print, or there some big spalt message around
it.

This shouldn't be noisy, but if you think this isn't needed, it can go
away.

> 
> See, the world doesn't revolve around microcode loading. If that thing
> fails, then someone has done a bad job at the CPU vendor testing,
> provided the code does the right thing.
> 

When it fails due to current_rev < min_rev, Isn't it good to add indication
to user space that it didn't succeed? Thomas wanted these return codes, so
someone scripting can get a status after an attempt to load.

Otherwise agree, it shouldn't generally fail.
