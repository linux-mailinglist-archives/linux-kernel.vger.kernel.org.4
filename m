Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF89674B82
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjATE7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjATE6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:58:42 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C04C926D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674190065; x=1705726065;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dvTF1u9VKTmZ+RtXJHpxihxuM5jfBrdbg2yNRqDv3P8=;
  b=hFXCxq2FVZh51IZpzM+nTeRPXoRKpyUCsj/rbZ2kJZSYzsN+u4gF0u1v
   5yVspbhGqSh5B66WEVIujyGOfujFtemW8TTgRnX7AhYnFJ57v08EhYPKd
   nGsm5mEHlM7Yy4fPzOVRZk/EHrlHDpg4fQbHFyV72skwyZTwxhSpmONhl
   25Ci245kyaMJEqrJ+6ADO3W7oJ06XKbs31GGi34M8Qpk5dtOiwzxln+lr
   v4xkx+4ILQHQsQmr5dMAZRJLGXwMrLib1lGpt/JpT8h4wTaOUsfVwl8Vz
   RRsWsHPCN0LTThmW/RWwfAu8tXKVktN5qNWjcRDfVU/Cf43NbO71jiyyL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="308943141"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="308943141"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 09:59:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="692516309"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="692516309"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 19 Jan 2023 09:59:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 09:59:47 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 09:59:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 09:59:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 09:59:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXQ+6Xhfkag8dxTKhNw29VPa+eK7QKcvitaXtLdMNogb7mDh4wYHkMAEJJdHYB9K/oHgDmjsKgPKDog7UG92XfywpFP5d54T6nOmmfHYVrIylMSHBFRl+aeavDSqV3kFz96S/t+vaUiqBdk9UwSH7zQFf/2O5iqUFViz6tve7Jj0YlRP8VLI1wfld1CtlzANqNML5SR9oUGl/iMd0+Ujs0ytvHYuyx/oasmU2wVG2XLnr2XlA9fEGfDXZjb8cBvdSH1Yab46eHbe8LjTqJ2XiIFKekoe4HmI5KSGf28ryRAzr0T2AShDhX1IRBmu3McobfCjUo66nMCaOeoF6C/o0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kv7k1um0zYsOwiy1aH2TjgC4lw+6ZBYz1O8bxw/KrVw=;
 b=f23HEZ0enoPrBYu/BkwGBEbc0CeR+xCbMwEAB0ehtuIaWacVnFlW9/UZheAkUIg/C/1PKt+Nvaw6qo0Xx40Qi/D//qja0CnvEIEKwTnR9OvCuHrSV8lGY/HOCljX23HpocgTleOs/zdsB7ZGjLt3fGFqJSph9J4pQfXE2WeIsfbRDFNiixleTloS0+HdkSz40+CD+bVqeeIRqhAQl3LFGvy+BkoCJwye4TnUoRLHnvKdYNFd4N5JTpnWIh4xpYXplgOI+zDV+6fW6cWNUulNMhTZK8E2HS+AYiuEuvrZH2GCb2g9+qO2pMukZIVx5bb6VF1/A8+zvrHSExJDMGwggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 19 Jan
 2023 17:59:39 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%8]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 17:59:39 +0000
Date:   Thu, 19 Jan 2023 09:59:33 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86-kernel <x86@kernel.org>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        David Woodhouse <dwmw2@infradead.org>, <mpohlack@amazon.de>
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Message-ID: <Y8mFBbWmpGvZy9dB@a4bf019067fa.jf.intel.com>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-7-ashok.raj@intel.com>
 <Y8ROaoJtUtj5bPcx@zn.tnic>
 <Y8bI4BBst78qrApD@a4bf019067fa.jf.intel.com>
 <e491fe87-2c2a-e9d2-3cd9-dfc7535f7c27@intel.com>
 <Y8bnEgP6iXCL+QmX@zn.tnic>
 <832b5c6c-cafa-e9e6-6e52-b741315d0865@intel.com>
 <Y8brnyIltcgtUvPn@zn.tnic>
 <Y8cHvmU6pa/rNw8n@a4bf019067fa.jf.intel.com>
 <IA1PR11MB6076660471E9C688E79A2B20FCC69@IA1PR11MB6076.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA1PR11MB6076660471E9C688E79A2B20FCC69@IA1PR11MB6076.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR06CA0042.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::19) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH7PR11MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf71452-0786-49d7-f8a8-08dafa46eecd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8UCKhpGrz0GV+HYiEAZcV+onb7PqPK6Nd3TUFRGCYQcnP2OJRvnd1n47x7FW3T74BwIkyH97oSuj/FIW3YNfATnoqKhhhDwclSENaXiLei2H2ADwCDh9T36W7bfC6cxU+2muuih4YnNaSr9FnS92jSbJR1cE5gIFrK8utwc+xnHKOPU2wASaQPzs+p6Pg7kZMHUkISsh6BPDCfQVEVSRjiSQqpe/Qk0+4Elsubxiyqi/jxNK9udk0NDAIx6InxqTqbzqysHAa793b9BdHfq7lUXBenyQzH91rZIMQPaVbfSt8nncFvoZ6SbDbD3biJK4yPEsbWwCksb4pxYxlt5EoEkuLjA04Eo4roCHQ7oIl2gpBeiFDF4T3e0DSC7Mcbuh6cpd/4NevVy+m1v9FU5dPQSV3CL1xzSAjRpzEox8+WkN9sWfTfWrGIGiBx60YljjGhpDzYk/OPfbnIT7xugIKcHjDmY3AFaCqFNcX5uKiRlKC30dJ57A6ne3hfO5NO8CFGt5z4yxoDF+93zmiC478sBsI9UJDRYsPln76VnR7Kpsa0Md56FzBZaCLAFsUA74v34Pj8+suml/k/JSlsG50qE4Qi3Eh7SEbuuZwzh7L7eqlgYwghNCuT/nGzYb9upkDEitGYUB39nVGq9QbqZm5Uo3KbpiVT6KCzu8bLWpJRkQomdeIC0WALn7gxujWipH+moHgOhRyRVM8ov4qoG9jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199015)(6506007)(41300700001)(66946007)(6666004)(66476007)(4326008)(66556008)(44832011)(6512007)(6862004)(26005)(8936002)(478600001)(186003)(6486002)(83380400001)(5660300002)(966005)(8676002)(316002)(54906003)(86362001)(6636002)(2906002)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aaaFLhhGXoKSxV6oLauvIZEqXAQQdf2ePFaX4pESmKcvXqfSESZFnU7GK2Ax?=
 =?us-ascii?Q?FW/ho42H5oXuSR0D3NGHo3vm3rBo4zHoDhEy52SncjwweybvtVwmBdibITQg?=
 =?us-ascii?Q?uFTJj4OXeiFEjaXkyPBeyEsQ6KmwRKaAQ34a3knpCpLn7ITUIaSjHBs9U4SD?=
 =?us-ascii?Q?wUDoDxIoLGGv15hFGFEcsDKMLkDM5DsMbV+fBukRg884N6HHU6ZTeaXWNu9s?=
 =?us-ascii?Q?J1SUZldSy0S3yCGWusEhtQxA1sz5adcfvQl9kzSgz9iRI+95JX6pPLbzdEYH?=
 =?us-ascii?Q?faS0G8AUES3HwQP/H1mps4zPdxatd7NAtpafr4ZqNDXTial6X4KipTxGY/BQ?=
 =?us-ascii?Q?QTiSybFo4+hRWzNw+e7ePXb24Y5XyZo/VL3OUuPw08Dskl29djP+QxpSWPz4?=
 =?us-ascii?Q?TB3K77B9UGMwHPoZEFY6nl+LMeVWO8KSvLFgPzgc+ZhuPMWYCJV7gSLy0nHf?=
 =?us-ascii?Q?rtIPV1BCgoaCKP1rMJ8YIay3XoYFXczmO3zFKGi4A9H5/SBxjWIeHROyzkF4?=
 =?us-ascii?Q?21H8DoISMLkyJFacjVAtcZzE0ZbQ9vHdir2e6t1JvO1wuPmhkXaA5p+xQwFc?=
 =?us-ascii?Q?IK+A06a5WIfy4xFArwt2H95r1RHM8Z1eGTrS4WPc8WkR9dXphfcjviFmYUxK?=
 =?us-ascii?Q?17z4PfREicdgG5YSwIQvCw+3FUuKKVRQ9YOU9QtwwvBFw/fyumCB8rG7NYRn?=
 =?us-ascii?Q?rP2cPGf0ukMbd6tinNr86O0mWLDOiaVkdR0Vq4Xm3rEgYF0lVAcr9RuC/Wn7?=
 =?us-ascii?Q?3QzWR+U8OprNnLyg2pCndKt4Sa8cl5WVj1bgn+qkmPHSGAwo+r7waoSY1XjY?=
 =?us-ascii?Q?WGYXd4ezJrFFVjJzxyFZRAFbzYtVIHSrJa1/M9kBwrULBZI2pi9jgDGMWGeW?=
 =?us-ascii?Q?T0HCvmiwQwKxEKwL8yLKBw2MktxIDPaCZ1viymsi6ZB/O9j6xSD0iCj9havh?=
 =?us-ascii?Q?sSkJLy/g+vmte4DJkXoxPAYd16LoBN1qn4027e3z06WTKbJi1MNj8jnsCP8g?=
 =?us-ascii?Q?YgD/XZnm7nwMItgB8uzp5saoglEgS7iUbuwsk+6kr109irW1pygtaphQ9aZM?=
 =?us-ascii?Q?RipHHmMUowZEIGIpFeqDPHLZimngWU4wFs31NPt/486AHzFNhDh5rRYECiEI?=
 =?us-ascii?Q?FLCy9gFD7fhpC4SI9xua2BdIZrUFmz8OD8z+znhcDBgv+Q9jL/Id4jCjFqKT?=
 =?us-ascii?Q?ueJIMpk7o9vVEOKAGsnCDeVK+eMScUkg+EU+ssk1ele3Y3Fu8SFFWcS4UAPQ?=
 =?us-ascii?Q?p+yJA5xWmvHp4caJwzEm7swG+FG/iZ1MIawGMzxqeMD4/QTVJVnk2bo9MTNf?=
 =?us-ascii?Q?p2I/uH/RYtULqe/tjhDmkvQNTZYxgSSlgOU6WX+w0KOk7It/h1NL097zCmZA?=
 =?us-ascii?Q?mHv9YropPq0g/dplqquAKtuyrWXuNAJ9qESLc/EByFXE/wYyGcECWfZmk8AW?=
 =?us-ascii?Q?3/7z78SUwoVhRNfZSvlNAcE1j/9r65R5dN88bJxyrkpG6D5LwpM06oNn4Ot9?=
 =?us-ascii?Q?QYU6EzqFxNfTE6G8pZjCceFCS4fL+Oz7NtNRtMvr9f3BenNlDgoPK+NHvndP?=
 =?us-ascii?Q?SURecBkDYKwoY/1XLgdpKt7K50Ql0W4lkujQb8O/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf71452-0786-49d7-f8a8-08dafa46eecd
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 17:59:39.0601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKiNDz5nlJgE3m4dp+QWsn0Z0CSv4GAjxQ7+RN+dz+UXYkqP5TyHIX3fX0iooQqTXyuKGDa4uktLopvkR4veDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5862
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Tue, Jan 17, 2023 at 12:58:12PM -0800, Tony Luck wrote:
> > If there is no microcode, we don't print anything. So what's loaded in the
> > CPU is the latest version. When we have something we can always tell if its
> > successful or not.
> >
> > Its not a microcode file in initrd, but a matching microcode to load. If
> > none is found, nothing to worry about.
> >
> > We just agreed to show both failed and success for late-load. Doing this is
> > consistent with that isn't it?
> >
> > https://lore.kernel.org/lkml/Y7iYLbEJSYnVn+dW@zn.tnic/
> >
> > Ingo's:
> > https://lore.kernel.org/lkml/Y7k9DNz%2F%2FvqBAvZK@gmail.com/
> >
> > Should we treat early loading differently?
> 
> Getting a better set of messages from early microcode update would
> be a "nice-to-have" feature. But if there is no agreement on what those
> messages should look like, perhaps just skip this part for now.
> 
> Then Ashok can move on to the real issue of allowing LATE_LOAD for a
> microcode that supports the new "minrev" header field.
> 
If this is the one blocking this series, as Tony proposed, its not worth
loosing sleep over this.

Would you recommend resubmitting a new set with the fixes for the interim
patch compile failures (for 32bit) and drop this last patch?

If you have any other comments would be great to hear now before I repost a
new series to capture everything that's need to be addressed.

As always you can change commit logs to your satisfaction, I try, but its
still not as perfect as how you like to see them.

Cheers,
Ashok
