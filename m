Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EB76263BE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiKKVjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiKKVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:39:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE8C11C02;
        Fri, 11 Nov 2022 13:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668202776; x=1699738776;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7MKKp+u16Hr/qbNv1gLXD3H28yzd6pneHI4zEDiZWn8=;
  b=erSdm1R1NZTKPoNjC0dDWMLdae823N0g/VZ9yEU6L8seuuGwZ129Bx2o
   OIxARa9Mqrv4tsFV3V9iUj2nmPPdl2OH41vOpZmGmR9329oJa5SDQsUMP
   RcSzN5OnGojXvKIVo4R1kvnI8IhEr0NtSe6pYD70kTQeTTEs7SE4avsBI
   ZrluFpSD36McGAy77u38QkgupKlvjeqG5CpFAiBmNge+sg7RK5o+rUM92
   l4WXz5zaNPZdCvESuNDGSfUyIl+K0ZdKQGUnb2fa0QXltVxMOlRB7GUSx
   7oxhmMLR9k3GQHqEU3nZh68TZRJdhX/Mu1/QPz6orU16R0BggXVsSXCp0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="311673544"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="311673544"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 13:39:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="615591612"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="615591612"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 11 Nov 2022 13:39:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 13:39:35 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 13:39:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 11 Nov 2022 13:39:34 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 11 Nov 2022 13:39:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvHCAcRWBaOR3zp8HQN2Da7uETOqb/DOL5H7XOptr16OpBN3uVK9oA5LTOId4Flg20AiDrLVyQ2v9lr/2EE95L2KUfqoa+k8w7sMiobv/ngP4PCbu6n2GxwiOd2D8og+vK+9xUMaNeV1OdeeoV4aiXbq71oy/NeFgBoRmEueUcDs7duuRfp65Ys5u0Xn4m2WKdY/xsGJHkpE+S1UXDAJOJPszkZGkpAdbJnrKblNq26h2n7TTuCsxRLQAXSp7JzLFLNOHADVKukNSzhQaSnv015a8cULcecw1+Y2cKmQxqF1gKEhaxtFvxh099X0EpIl4Ro2gQAJL1XTdaJz4AT5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpxzhNE4Y8Br4OzJyKFeAisvAyHBhBydJF9E51G5zHk=;
 b=PNh0rrBqbxDg7XNE5Cw3LPRITUzri3N6G1XrFCpvJ4Ii6ZG/IguVv8CHDiwTiq51eztdMz2pVcL04MwVZD9W8tZBLp1CVdoYva/KFpS+bRUTdJlk6lUNwedkX0mitXblRxcnaxHJ4YsPombZU3qU6Li6uFBy2xFLOIksACm/YZClEdmVEgVK7GWN1nktj9h9Q1wieUhTl4cqKBshUPtQdw6WTsKXMku+qmALQMfo+gtbeGr6UCYzOBct77VDSlbJOEQFN/ZulxrIBYkXBoApOhryqpDfjSsp8xFFzgUTmkD3aL68+yLcQUXe2H/sEMyoWJ9/518LuBYONR1Beas7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by PH7PR11MB6747.namprd11.prod.outlook.com (2603:10b6:510:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 21:39:31 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 21:39:31 +0000
Message-ID: <6882a4e7-a733-5ef0-f32c-53763b3c84e0@intel.com>
Date:   Fri, 11 Nov 2022 13:39:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 06/14] x86/microcode/intel: Expose
 microcode_sanity_check()
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
CC:     <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-7-jithu.joseph@intel.com> <Y25dTPMQ5uwBDa9I@zn.tnic>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <Y25dTPMQ5uwBDa9I@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|PH7PR11MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 55af4c9f-a5b6-4bd1-9e40-08dac42d373b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aS88LzL33OT3RFeTtx9JIOrgw9PkOGEpeRr/eOVHnSCYKkNkK7fyQH7a9xwt+sw1ZVydcP3207u056NXuRyDn18nsC90JpoEuS9zfvfWOwjsz6V6bekkXlg36qifPMe6JuIEgiKf/aiJpBBbwObrretIQ9eZ0E0QhCRVE7ibQ77nVhoABq/L0PKERIQ47yFLtusuf6O4K+voyksZ9mUSLVFqwGWi1AipHFQs9789QHG7seemfMhDTn9Mumkh6fSbvgoC8rR5+nZqr12ZBZ8SFxFO2V3t8kzglQv+YxpQM+jUNAEbxngSCyRtTPMV55up0ACU444H3Z/R2X4qeDI1+RmEqk7QB7gmeLpJUZ8mfWnHdjRKarYEPiIEJiDmFY6B0rxapHieQPQsog8m4GLB6nELCbvy1A39iT5Yuy1ckmi4+FdPY4QcRLIQLIQo1p0VbcSg1zNqN4NXvvK531I1LF7GOFom6Zko9WsjaZdPcrx6cOSa+54Vr4xYKdAdPG37H9zBnwYiXQfyQWGqGtwTIDjZXBhJyMNpLItFR+PX7aZyQqE0yFJzznXoI4nTz4+ySe2PqyGXHcpYhH8C/WYbAlDkpyTUfKsyGX87Y9lZuAgJeUMITzMrNuj8gZHEtSUX23RchVewHJtpjLfLIMbuXdckyDBvCPwc7MMgVN0i0IxgZx8ssOOzIPZUXKKhXsQ7F5pBG4L6+vKZMSRa2w+Ntabzl/71XZY3kLqHrBWd1EhqXTcEMmVkccrzaCDL3L/yXvv5GW3VkK5HpP3oZJAeVkXXGWMiMizjwME7olE1nlw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(5660300002)(8936002)(66556008)(66946007)(31686004)(41300700001)(7416002)(38100700002)(82960400001)(8676002)(4326008)(2906002)(66476007)(6512007)(53546011)(86362001)(26005)(6916009)(36756003)(316002)(6506007)(186003)(31696002)(6486002)(2616005)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azgrdnMyeGlxdFhFZGRNMGZSL3J1MEhYQVU2OG41VUJDNlUzcFVTOVhUK3R1?=
 =?utf-8?B?ZmRJMnVNc3BOMGoralZkN0F0YU1JYkFWbWNRQzlWVHJGRVorZnBSOEVZUXl3?=
 =?utf-8?B?L3RvNWpMWFV2bU9UZGtUQ3JVK0IzejVzQ3VPSmRyN3dxdlhoVERQT2hFd1Az?=
 =?utf-8?B?Sm9lQlFEMjB4MWlubmZNeTVkbDljYS95TDYwdy9qQ0RWenBZSzBWcFBMNXU3?=
 =?utf-8?B?Zy80a28xMWcydklxUzFFSzUzSGs1ejlacHdwUlFZbjliK2JUdEkxM1JSNmtz?=
 =?utf-8?B?bDgvYnp1ZGpmUWxqWHV5MXRJK1I0aGQzeUVCMlFrdGE5UW5XNUxGY1FKbXVB?=
 =?utf-8?B?U1dKRFQzQ0RIMkRsTnk2KysrSzA3djZuQVRoaFlNS3h1Z0JuOWhjMGs1YzJI?=
 =?utf-8?B?M295YVVwNXIyRk8zZHdBNnBINVJBYzl3bGt3ZlZmZ2s5SHBwS3VrQW5Nempp?=
 =?utf-8?B?c0h1bXlLRmE4Y0ZvUGNxQm5vUUhkZkdReSs5eUZMYnh1Sk11bHVvRW9LS3pz?=
 =?utf-8?B?ZjNZWmk5UlB2T3I1VmdrTk5oT1M5TCtIY2pSVXJOMko1QzJ5TE41eFBMQlgv?=
 =?utf-8?B?aCtYOVk4aDVRV3JaZkhRTzR6Ri9YN29QWXlRYjRvUVRtTS9wWGhOQVBOblFU?=
 =?utf-8?B?SFFoMnVzMzE1VUJiVEg2QUdKV2REcFJhVzRWcE5yQTNyeXFIRFBESTBaM1NW?=
 =?utf-8?B?dkp0UFpKS3A2V1dBL1ZpWVkvRUlnUk16UURoUW96NC96WENwdkNMVkFRTGN6?=
 =?utf-8?B?UlpaeGlzVDE3b3FLcUhDYlU2ZjFSN243Y3dmN3FsanVsclI2NzNsdVY0cjRH?=
 =?utf-8?B?QTI3ZGMyWVFsL0RORk8vaTJKRzVydWdidlBaNitJMStsVGVhWWV3RG5pRVFa?=
 =?utf-8?B?bnZ2NlNGY093MlR5MEpkTW1reG5kd3N3cm9rSzBHSXA1clpidFdCMjFuVmJp?=
 =?utf-8?B?QlJ2UVZiQWUzSUd3YnZsVjNNN01mYmJDYkJXVEF0NHo0NmlMVmNwNGJtSWQv?=
 =?utf-8?B?bjVJUjNqYWFodVJHMTVROTUzK2FXSkJMWEJ0bW1XSzJ3WWwyQzc2M3ZnRThS?=
 =?utf-8?B?UUIwRVV6cEhsdGtyMWhyd2I5elRJSDZzUmF0TCt3MURpZTVncmdjS2k1a3BF?=
 =?utf-8?B?NXlyMWVlaUljZjdtNzliOWhvWk45YitpYll1MGVucWo2b043SmZ6bkdyZGFN?=
 =?utf-8?B?dUNJN2dEUXNmTWkwTzhtUlNDVlZiVkVQdjZRN2RZUm1tbS9ZVEhuTXpURGdJ?=
 =?utf-8?B?dFRSR2t1T2NhL09ma2J4SkRrSlhhZ3ZrRkZBdCtsMmFMYlQveGUyZmFLdEw2?=
 =?utf-8?B?ZkdQR2V4R1o0OUM3RUE1QTZlN0poeXoxeXI3SGZRQzl2VEdlQzIvRGxkMEo0?=
 =?utf-8?B?a2J6QVRZVVVRcWwvVlNVK2tkMXgyWXgwRmNZTmQ3VmVuYjgyR016UEtSSUJ6?=
 =?utf-8?B?QlpIWitSemNrR09RUlJJeldjdkxOU3RDUGgzVEo3cURFcFFaUFRJRkdndVNi?=
 =?utf-8?B?Z1o3NGttczZRMmdrMnNRdWdMT1ZiQlB5MHMvdGZXYjZwZVN5cHdSYVp4NW1S?=
 =?utf-8?B?K0FZTlNwV3c5RkNnQzB1MnlvbmNHWjdkRElsK2k2ekFwU3NzRkhFWFlEQWFi?=
 =?utf-8?B?ZFRROUdLWCtMMzQzOE9rZ3B5TVhmUW5odHlzVE03SFRjRmNpZ0JTYkE0S3FC?=
 =?utf-8?B?T3R6SHFDSkcvNGQzNlJMVk56emp6UXpwU0NpZ1Mwa2xkNDZoWlZmb3NQUGhz?=
 =?utf-8?B?Y2pwUmgrUmpnTCtKVlg0dHdwR0dueUpOYXo2QXVLT2MwZlVxZFkwZEczRVEz?=
 =?utf-8?B?NlRnOVk0dm5UeG5tL2pxYkxkQ2IvZXd5M09MSDZnRVJOeldJdXhRcTZqSG0w?=
 =?utf-8?B?ek03eGhscVZ2MTBiaVN3LzQ0Nkc4cW1VYUVCUDUxSVdrWitGZ3AyU1E5Rnhh?=
 =?utf-8?B?TW1mbDV5WFcyUEJTcmNwYkNyRzh2d3NQN01iN3JSQW9nM282NS81L1pKS0VI?=
 =?utf-8?B?SlB6UkF4cEVZcVphblJXM01GcTIweXEyM09FWE9oTFl6bElVYmQxNTNYRGNO?=
 =?utf-8?B?ZkppaE8rRVAyclJibWJKMThjSmVrT1daQm85OVdMUTRnMUhkOTFiUExpUnUy?=
 =?utf-8?B?bnRueUtQcmVYZHVsQytrOW5yY25TdzEwS2JXK28xNll5ckRoMjJVNTRFbFhx?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55af4c9f-a5b6-4bd1-9e40-08dac42d373b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 21:39:30.9166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uoifqve0g6olhqhQ4Kpp4KdPi4immo3rf4rdZ8ud9jLpt2idZvJallScHi2by7lAt2e+8ZCoI/eqwI8BBCtrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6747
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2022 6:33 AM, Borislav Petkov wrote:
> On Mon, Nov 07, 2022 at 02:53:15PM -0800, Jithu Joseph wrote:
>> IFS test image carries the same microcode header as regular Intel
>> microcode blobs. Microcode blobs  use header version of 1,
>> whereas IFS test images will use header version of 2.
>>
>> microcode_sanity_check() can be used by IFS driver to perform
>> sanity check of the IFS test images too.
>>
>> Refactor header version as a parameter, move it to cpu/intel.c
>> and expose this function. Qualify the function name with intel.
> 
> Same comments as before.

Will drop the last para


>> +#define MICROCODE_HEADER_VER_UCODE	1
> 
> "MICROCODE" ... "UCODE" - too much.
> 
> And "header version" sounds wrong when all you wanna say is, this header
> is of this or that *type*. So you simply do:
> 
> #define MC_HEADER_TYPE_MICROCODE	1
> #define MC_HEADER_TYPE_IFS		2
> 
> and that's it.

Will modify

> 
>>  #define get_totalsize(mc) \
>>  	(((struct microcode_intel *)mc)->hdr.datasize ? \
>> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
>> index b6f9210fb31a..f8a5a25ab502 100644
>> --- a/arch/x86/kernel/cpu/intel.c
>> +++ b/arch/x86/kernel/cpu/intel.c
>> @@ -245,6 +245,106 @@ int intel_find_matching_signature(void *mc, unsigned int csig, int cpf)
>>  }
>>  EXPORT_SYMBOL_GPL(intel_find_matching_signature);
>>  
>> +int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_ver)
> 
> This is not how this is done:
> 
> 1st patch: *only* mechanical code move, no semantic or functional changes
> whatsoever.
> 
> 2nd patch: Add semantical/functional changes.
> 
> Also, in the second patch, pls put a kernel-doc comment over the
> function to explain what hdr_type - not hdr_ver - means here.

Thanks for the suggestion above,  will split to 2 patches


Jithu
