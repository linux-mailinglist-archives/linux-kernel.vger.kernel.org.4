Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3225F7BC5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJGQqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJGQq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:46:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359FA78206;
        Fri,  7 Oct 2022 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665161186; x=1696697186;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uKuuxelzxH4zgJcrubjzO9ddAHIrjW30LeIX67e4hbU=;
  b=fwSocW167zgws2e2gu0CrdZHz5DBCUGX4RtUihBTeXpGn504dyC78/+w
   50FbsSXzKOmPEssEacOFpWFo0verfJ299X+h3QYHjAtQP923m0DMlLVOw
   gq1H6z/Z683bHrf3wut/Xh6NLVcojgwGy0w3zkZlHEKa8y1zww1542wZg
   4rxSFaTBxfBgDFjVAf4kMpdzY7yTbxIn3q1f68usHQlO5CcuZ86nA2Y94
   YIjIb6iiAsDvv7x+DrAYx3y67ZUpKMOVUCLW2b2mDQl/Q8gVCJxrYYghT
   c6RA+12gyvu4V5+UEdPZFo/VH61OhKWmqgCu9xmtRX5wygnf45mp0XqPh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="284148699"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="284148699"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 09:46:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="658388817"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="658388817"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 07 Oct 2022 09:46:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 09:46:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 09:46:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 7 Oct 2022 09:46:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 7 Oct 2022 09:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZGNFbEao+cuS8/9edJGjDVImeNzSSSVGe4me1Q+UuJ6FT89dUjuH+EDbA616G9UowttIGu8vY3aWw+GAfAXzmOJWVyPGynxdPDOhtVpKjr6HVuVWSC+dNgGI2mAXdcuc6gxIbEDGMseIHeR9FqLtqfupwxXyt6Z6kk4HeG+alrwtjwLeyHYao0xbGxHlVrqSP04RiHnTvJ40XFLlaE6ooN7xtLeZNKX7fICRCY6wd6eSIIKWf5c/4TgXQzowaOm+s/Iv3lDfNZDsSCulpwTu45TN/7MPdcwvuIHiu6NXfvhboZ/ZmjwmPJ8GQed4+8gCc/JsX0hXaEv6gsuHSg/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrwplUg5jBkq7ezOBNk9bmauho2XfWL58GFaslukZbA=;
 b=nG/UGRi1ABmZpgQ+BwZSx1IF7vbK9yYNqYdA0W4S4nitWjzWtpmanJcyFLVbm+0Y+n+ylBmgFQkVmAoBaS3bmTcg5DNNzqAvOVZ64Kz5geeQp4e0AKjSckeUWPwyOBKrtvC0Ime6BHMivDOtZK8Mg9mkdLkDLT1gW0lr4mg2xg+ILq0UP4UCW9x3YpUg79JTQQF/DuDFCqmSqT4b8j7I21r86cSVtPtEJGeL+rGEBH3/JfEJkiIC4EG9T00TBh37Mp1SDxmZb/OEWuLSZ3bsLd9EGHDgQy3uzddigkV4V51QD7yLM1khHk7kDuvCDBltnGKY4bpdmNw9u6YyNtp6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5409.namprd11.prod.outlook.com (2603:10b6:610:d0::7)
 by DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Fri, 7 Oct
 2022 16:46:01 +0000
Received: from CH0PR11MB5409.namprd11.prod.outlook.com
 ([fe80::54de:6030:7501:b7ae]) by CH0PR11MB5409.namprd11.prod.outlook.com
 ([fe80::54de:6030:7501:b7ae%8]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 16:46:01 +0000
Message-ID: <e0487676-996a-3274-1938-66b3a2b92fe8@intel.com>
Date:   Fri, 7 Oct 2022 19:45:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v13 5/9] drm/i915: Check for integer truncation on
 scatterlist creation
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <mchehab@kernel.org>,
        <chris@chris-wilson.co.uk>, <matthew.auld@intel.com>,
        <thomas.hellstrom@linux.intel.com>, <jani.nikula@intel.com>,
        <nirmoy.das@intel.com>, <airlied@redhat.com>, <daniel@ffwll.ch>,
        <andi.shyti@linux.intel.com>, <andrzej.hajda@intel.com>,
        <keescook@chromium.org>, <mauro.chehab@linux.intel.com>,
        <linux@rasmusvillemoes.dk>, <vitor@massaru.org>,
        <dlatypov@google.com>, <ndesaulniers@google.com>,
        <trix@redhat.com>, <llvm@lists.linux.dev>,
        <linux-hardening@vger.kernel.org>, <linux-sparse@vger.kernel.org>,
        <nathan@kernel.org>, <gustavoars@kernel.org>,
        <luc.vanoostenryck@gmail.com>
References: <20220928081300.101516-1-gwan-gyeong.mun@intel.com>
 <20220928081300.101516-6-gwan-gyeong.mun@intel.com>
 <CAHk-=wivJwvVbMUKma8600F6qaVLZHT=BY90SEnjiHWw2ZUVEg@mail.gmail.com>
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
In-Reply-To: <CAHk-=wivJwvVbMUKma8600F6qaVLZHT=BY90SEnjiHWw2ZUVEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To CH0PR11MB5409.namprd11.prod.outlook.com
 (2603:10b6:610:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5409:EE_|DM4PR11MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6c0eba-b77e-4de3-6a8a-08daa8836a7f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhdgcCXkofQiYxI/d4VdAr6F9Xw5tP8hDJLwPz5n2tB5Me3AtwBaeM4JImRBNTWDcESoNaki5/tyEdAVYbMOaR8yzINEACRc5hs91Gxq7V2g2sEUEyZXCx5C8+SL9oi1RPAMilKvGLl2J8zbPWe5AtnUSgZpxlgggDg/gr3qZA296iOK6B9cnwFXkAOOyRtrUK514Ldm+i7KH0ieXj+Lb4xvO/+YMb11QMLjeJGTNjjt0c101Wd1MOndcWj368FRuMW3fJxYqB97ndgWFEyDeIIg6d8nThA4D/8uIagtGNTEXh6qD+Va2308X/4q35/Rk95dEAriz56l9IwevhWSqrH5PrN76lfZ6cUBeuHBv4JSIVc01Tdjp4ZY+vUrwW9Cc5csXxPAeyq5nWM5GJBXZKfgm8PUM92DyxVqmXIAvPH/HiSDsbwZ0yYZGGp0jU++K2lCr3JoHGTwUbsA6nVFFGoLxH7ap+VoXj3ZUiMvm/0IsmM4W4uKGZzUDH7JXxIbQFoBYHDh8synq6cEOOq/Zrd2MjHYKJ5iXff1UkjvyeQd4MJXp30pCCFsHqmqDEvE5KN8ef0HaAU6aNkm7DF1WnrQSZdO/rAeyyxyjbWQORqCNbZgnf6ACx4BgIp1pvZC1vpH/BE6IipGySmOJRIlScDQWfvaXbeSQLVJxr8wetQNfFkZ8XVGSB8/fLFNJtttl+LQHf8DoifPcBiq5FuTbmSxUvJ+KqJmcYD7VMn+aJKnD4H9d0vEW2ZnvVW1CJuST1fRO+8v67VamZKvtLY4aRfc6KeID+M/wG1qlnLvic8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5409.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(6666004)(66946007)(8676002)(6506007)(66556008)(4326008)(6916009)(66476007)(478600001)(6486002)(316002)(36756003)(38100700002)(53546011)(6512007)(26005)(186003)(86362001)(2616005)(82960400001)(83380400001)(8936002)(31686004)(41300700001)(31696002)(7416002)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bC9mZG5wYmd6YUpQem5LR3d4OTdRTGVYTkNiNzFUL0Npa2E4TDgrblFlYVhO?=
 =?utf-8?B?TXoxK0ZDemFCcmorQ2h4WHpycllRMkpQUjBSR3BUeENkaFNaNjQ3bmVQb05q?=
 =?utf-8?B?bW1qR1FuRWIwR0drTTd2Nkk2ckU2Zmt2VkN4ZjAxcEwvWnJEZkNBSDR5eDhO?=
 =?utf-8?B?cFlDY0tUQ2gxVmF4TU1McnlYT2h2U2ZhTlp3Nm5aQmttRWdyZno4TFlVSnR5?=
 =?utf-8?B?YW5kR0NyMlVpV2FIWlNZMFkwRHdER211ZUZyUkRudHhHQXFPZEpYNWR6ZWQ5?=
 =?utf-8?B?UHUzOG9pOWJxalFJUXVIbmhrbmRyTmV5V0lrelJPRnNSbnpHQWUyeUdBRmZo?=
 =?utf-8?B?YVpOQ0Y0V1NWdzNqN1VLbkVQWGxPdWtTV1dJa2lVclloUEpRdDdQUVdNYWJK?=
 =?utf-8?B?enFpOUtMZEJkT0xVL3RrUDJySlIxV2Z2ckhxaExtc2VZNkxsN3EvRWE1N29t?=
 =?utf-8?B?V2xRaEZpMVNFbnZWcmhESzNZY29sV0RoY0dvWHlEc0FEdC9WYU9VN3BnYmpR?=
 =?utf-8?B?ejMrRnllbG1QV3RPOVF0SjMwZS85TlR4bGJCNCtXU3pGWnlzQUQ1N3hhc3NK?=
 =?utf-8?B?RCtwWHBxN3RoSjlKTnFvZTNFSTZNZ1BEcW9nQTdQbmNnTU92cG0vbUYwKzgy?=
 =?utf-8?B?SzdVK2VWNnl0by9YSDFTZlVNcFFTQUNpTXNWVkRqYnJUT2xBMmlKcDU4TEFr?=
 =?utf-8?B?RlY1THQzZDQ5WkFVcXJhVWtLbUQwVnFOVDcrRklBbWpxbFM5Q2IxZTl5VGRS?=
 =?utf-8?B?dC9LODVjTE5FTndTM0tUKzJxZmVwQnRoZ3E0cWhmMWRBcEtKQjllQzdvZGlk?=
 =?utf-8?B?ZUtwckNpQm5jOGhpdWhVTXMzbXcxcFREd0R5RjN6K0k4a2FxMjVPNjNuWUFZ?=
 =?utf-8?B?bkZJTzI4c0pjK1MyOUNPT29xTk1WMUI4cXE2amgvZUZQamRVeWo3Wmp0OU1y?=
 =?utf-8?B?R0dCaXo1cDdwWElkamRxblpSdUxSQ1FZT29relI5WFZybDFyQndiWVJlbUhX?=
 =?utf-8?B?d1BPZmlEV0dKSVpIekNXOWpXamFDR0U0MUVpSmtSL0NqZjNKV0wyT09BSWts?=
 =?utf-8?B?RWRibWFzVkhsMmFzOU03RCtVSkI5NTJEZnJHNGdCUUEwSEZEV3FpZjc3V2Qr?=
 =?utf-8?B?eFhiTk04QXp0Y29WZlNKaXhoOVRsSGlaUjhhdjUwQ0hqNUZsVE9aS1lJek1Q?=
 =?utf-8?B?UzJHRnhXT0JaRUtnNTcyUG5hVWZaTWZiV3ZFbkkxOHA3Y2lhaDlDN2VidEZt?=
 =?utf-8?B?cFBZQlorNnE1ZWo0T2VRMWFBNjdhTExCWUdHRGp2dEpLYzIzald4NUFhc09T?=
 =?utf-8?B?dUtvMGthYkQyVTA2QllSRERSY0JuSGtKVUlJdkdBd1ZNT3ZyNTJmYjBtNkRC?=
 =?utf-8?B?RFFvSFpBa0hXckgvdUpiV21XTDRITUd4VjRLeC9Zdm1DUTVpOTZVaXBWb2g5?=
 =?utf-8?B?Z3d1b1VxN0l5Ui9Lb0tTbEV6djI3REk3WFdFQnhML1IrTzY4d0RQYlVKbFJE?=
 =?utf-8?B?NTBQT3BmamVjSDA0RzFYL0VWTUdMbG55TUJTWUlmbHFBTFVvR0hNL3BGdk5J?=
 =?utf-8?B?SEdWcHpESm92T04zKzR1N2VKTlc3ZW1oMnNoZEh6d1FCMkV2bnVPWlRXb281?=
 =?utf-8?B?UlRwb0tidDJ2T2M4dmRSaDVHSGsvZWlpMjU0SmJ2VDNqVW9SN1NUajJKMkhR?=
 =?utf-8?B?akFSMmZXOFh0T2drRTVlOFRPU2xvT1EzRlhqalRlUG5mVjRXU3VhcllYb2lr?=
 =?utf-8?B?MjR4cnJyODRNUDVLYWpQL04vUUFTQzRzYTlsUXJxVXcwdStGWDlLVUJjS0ZR?=
 =?utf-8?B?Wkp0bDdIVUxsd3FCVitJUnlMd0djcWZzaC9iblgyZ25hL0wwL3B6Mi94S0px?=
 =?utf-8?B?ejJsWFdjclpUWlZ0cWJEa1pOdXNrbE9HU1AwM2gxWDhvQWU4eE5WM3h1R2VS?=
 =?utf-8?B?VjJtWk5ZWUt4Y3RTK2FJSElHQ0tBMXl0OEYzVmRhRkZiWnhZN0VzdE52NjJS?=
 =?utf-8?B?cnFSbUF1L3AvNE5yMys1KzNvQzFXcUFpcVpFaE5UMWErRTNqWkEwUXIyMHlS?=
 =?utf-8?B?YTM3UkdhVXFPZjdHbDdiY3ZpNGVjUzZnR2ZZL2h5YmtId21FZjF0WHlNTjUy?=
 =?utf-8?B?ek1JNnlEaTB1eHJrV25ZUW1xVlpCRlE2VEFUcFNVbVppVzBzY3NJbUhqRGdG?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6c0eba-b77e-4de3-6a8a-08daa8836a7f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5409.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 16:46:01.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iB5r4Bv2g7jSYkv80qjIAIbuYgTISyfFb25U/MyWh6MJzlLoRz/6abf5LBXy92F7UpQ0UjKr1HUAG6u59DlLk9HlEcvwGc96TK60Qll079s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6189
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/22 8:09 PM, Linus Torvalds wrote:
> On Wed, Sep 28, 2022 at 1:15 AM Gwan-gyeong Mun
> <gwan-gyeong.mun@intel.com> wrote:
>>
>> +       if (check_assign(obj->base.size >> PAGE_SHIFT, &npages))
>> +               return -E2BIG;
> 
> I have to say, I find that new "check_assign()" macro use to be disgusting.
> 
> It's one thing to check for overflows.
> 
> It's another thing entirely to just assign something to a local variable.
> 
> This disgusting "let's check and assign" needs to die. It makes the
> code a completely unreadable mess. The "user" wersion is even worse.
> 
> If you worry about overflow, then use a mix of
> 
>   (a) use a sufficiently large type to begin with
> 
>   (b) check for value range separately
> 
> and in this particular case, I also suspect that the whole range check
> should have been somewhere else entirely - at the original creation of
> that "obj" structure, not at one random end-point where it is used.
> 
> In other words, THIS WHOLE PATCH is just end-points checking the size
> requirements of that "base.size" thing much too late, when it should
> have been checked originally for some "maximum acceptable base size"
> instead.
> 
> And that "maximum acceptable base size" should *not* be about "this is
> the size of the variables we use". It should be a sanity check of
> "this value is sane and fits in sane use cases".
> 
> Because "let's plug security checks" is most definitely not about
> picking random assignments and saying "let's check this one". It's
> about trying to catch things earlier than that.
Linus, but the size check of the object in the i915 is already done at 
the time of creation.
And this patch series is designed to prevent problems that may arise 
from the difference between the data structure used internally by 
drm/i915/ttm (unsigned long) and the data structure provided and used by 
the scatter/getter api (unsigned int).

The current implementation of the i915 uses sg_table / scatterlist to 
manage and use memory resources at a low level.
When creating an object of i915, it is based on drm_gem_object, which is 
the data structure of drm. The size of object is size_t [1][2].
And i915 uses ttm. the ttm_resource_manager manages resources with 
ttm_resource structure [3] for resource management.
When creating sgt with sg_alloc_table()[4] in i915, size of struct 
drm_gem_object[1] and num_pages of struct ttm_resource[3] are used as 
nents arguments.
(Of course, there are places that explicitly use unsigned int variables.)
Even where sg_alloc_table_from_pages_segment() [5] is used, there are 
places where the size of struct drm_gem_object [1] is used as the 
n_pages argument after bit shift operation with PAGE_SHIFT.

As above, when using drm, ttm, sgt infrastructure in i915, there is a 
type mismatch in size in the driver implementation.

Because the types are different, when assigning a value from a large 
type variable to a small type variable, if the overflow check is used as 
a safety guard in i915 before sgt api call, implicit value truncation 
will not occur when a problem occurs. The log output makes it easy to 
detect that a problem has already occurred before sgt apis are called.
When a bug related to this issue occurs, it will not delay the reporting 
of the problem of this issue.

Because the above one is one of a workaround solution, if the types used 
in the scatter/getter api would be changed to such as size_t or another 
configurable type, it would be a more proper solution. But it might 
affect lots of drivers and frameworks. therefore I suggest a current 
solution before the changing of sgt area.


Br,

G.G.


[1]
     struct drm_gem_object {
     ...
         size_t size;
     ...

[2]
     #ifndef __kernel_size_t
     #if __BITS_PER_LONG != 64
     typedef unsigned int    __kernel_size_t;
     #else
     typedef __kernel_ulong_t __kernel_size_t;

     typedef __kernel_size_t        size_t;

[3]
     struct ttm_resource {
         unsigned long start;
         unsigned long num_pages;
         uint32_t mem_type;
         uint32_t placement;
         struct ttm_bus_placement bus;
         struct ttm_buffer_object *bo;

         /**
          * @lru: Least recently used list, see &ttm_resource_manager.lru
          */
         struct list_head lru;
     };


[4] int sg_alloc_table(struct sg_table *table, unsigned int nents, gfp_t 
gfp_mask)

[5] int sg_alloc_table_from_pages_segment(struct sg_table *sgt, struct 
page **pages,
                 unsigned int n_pages, unsigned int offset,
                 unsigned long size, unsigned int max_segment,
                 gfp_t gfp_mask)



> 
> Kees, you need to reign in the craziness in overflow.h.
> 
>                   Linus
