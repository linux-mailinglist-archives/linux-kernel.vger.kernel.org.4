Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B27D60C04C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJYA7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiJYA7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:59:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C17275DDA;
        Mon, 24 Oct 2022 16:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666655457; x=1698191457;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RVlEuu/XS3kQZk95/3ShZ2k4FJdY72BuT/wRsv+2vW8=;
  b=iTtlcpO7x5ifXPtJezQRgTJogMvap5qSWUBZQCjde9cbBOMotGhZRFzF
   n2yf/dITg8nUCokD7pZG43uJjUN7mpbT1wqtGts6zxiHkroRg5s+Ll5DS
   Ciz55nQNHxeOyOlmbSpkdmp58IOTbEPSFGtqEeOnBotlUM4N/aQUXwUhm
   t6GMiS/LmlNtLxXhMdJ6dH0XFqnbd58ikRQnVo6xdT78TePfZmIHTiebE
   G13hNt1u15Fna17PfVkXQ9ht6KLcaHNNNasBkuaFnDIa56IIXZHhmjnUn
   VC3ZRJHG28nCLE39++4DGNR0HA5j3SehkwwcUlWjBZA/p/Jhcftu3c+Yd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="308640891"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="308640891"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 16:50:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="756745135"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="756745135"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 24 Oct 2022 16:50:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 16:50:38 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 16:50:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 16:50:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 16:50:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htqiaZjbX9cPxipg2cmk7wkrhCNpZlHsuZvW+uKrsHaAIVCAX/AlbN57CEyai9QTgGXKLELibxRpOwWPl57fd6S0ZOj57tOnsQIb5VH6wcMHhJWJXHdOpjFqCfnAyVbfYsOwg67Nh2rkn6HhFB9uLx9aTRVrH4QYwJkJ+t1qT9kynQTqJAG8T+s0tJ+vhp3Yz8YlXDKoZ9uy16E0f2eow9lmKbjIYuK/Dsf3QuWtBUNFwCWyVc3mWJvmEaqzvN7CTaAx+80bn9AH0EyUqvYCUgn7xqUli9frSwnQYaWuLmKOD0VYLs2lhUKKvMTkfwzWObXK2x16dH5rXJNfVYBukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwiGGcJbxNiyYQHmk9TvjJhtzDx6Iz3QkuodivcoiaA=;
 b=jNio8bG3Apo1ZQMva7sz9Hcop/PYwVpWrtdubx9v/uhX/al7iVIc5zoqZH17lS9ldHEyJJfVteiYRQR142WITrIPMdPhhACqS1MBC1wJ+kKUlsbarueVQafbsrutgxOhLBeFdC4JucNO/kubxe4pOgxTPeCLYclDldUP1+NN+xK9wb9tvHVxnC2AgBbegsfN2cr7wOty7D4Nkg84KbTn2s2CR5gI/biVVLvj4nM/fVrp0RZUJb4Slsf2G62g42V0xLjB9yE1EE3dfKQOrVKnf7lyYUpLbmaddq7zXRPipsxloMLFMeZatK7L7Y2hWPeVsigVBjkm88Tu1mMkBBAszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Mon, 24 Oct
 2022 23:50:35 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5746.027; Mon, 24 Oct 2022
 23:50:35 +0000
Message-ID: <ec2a2799-9db5-8810-7a41-f9f6ca1b360b@intel.com>
Date:   Mon, 24 Oct 2022 16:50:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 04/14] platform/x86/intel/ifs: Remove image loading during
 init
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <markgross@kernel.org>,
        <hdegoede@redhat.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-5-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221021203413.1220137-5-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0203.namprd05.prod.outlook.com
 (2603:10b6:a03:330::28) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: bce869ee-3a1c-49bc-ee93-08dab61a8b71
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muENDEvTJwVm87gcl+sJa5n6aNNtmddwd2AgQxILNYjmFY4HOWcXz+qRVQcg6ZGWiIXo4gg0NBcza1WLVBtqUvRgitEi2VfxJZDyw4bnG6wjObX4ISnQSQ4HIOvBYK1XQmfwW5nMyzNz1wCMm5c3iKQfFZ/L0F1R+MNDj+xV6t4PyzqxSu0fsb3TmsERJVrCTO8eIl7Ln8znicpC05Uifv1Yh/SndmRC31TiXdYkIA03PA4eZmru/BUpE6UsjYelYQVF/ndb1ZPCSerQ3kfQ0jvi7A1m/caCGCD4eaDcxXi3hBHEcjM+wY6MO5+Ix3CV0lkFlh8xFyf47j59ssv0HcXi8VHR2vcg7yGm2nhu00vFsJ9vVDTe65nn/KjWOzG5uXz4ntbeT47eck2uFTGXSl22Dhij/gTPklM+vaqcKTKrH/S3VYTEbOm/deNU1Xf9z8L/LSWIa3pO1o5ZiEjXB3BD6fz4AqjcSuzQn01AvUV8gfEtPbAyS4y4xAXwNDDE42WLtEEsDFzX0KOnI8BkCuyda4IfMqg5wN5ihur0MEjupCMkDLfL+xuHLNxkXo+umJMQhB1zypwkhod/Rgh25Moo1u2/KKj81vlTVsqtnApOhzttuSFc5w61Xf30gH62w+hZ0MRzM4KHi+KUTCzy7Q8B3M57njUxQbjVD6u2SurBz0S9MTjxdFW5xEKA2PWu/bZclogLfT/PSbCfAMlXdP5QL2kkgLjmEGf8BUIdWcJ94Pmr+RDSO8rWTil6qI/dkgATIW0UV8XaKfhCZ/fPXPPBdGtTV2Q/ixgAoSB6gkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199015)(66946007)(186003)(66556008)(6512007)(6486002)(53546011)(6506007)(37006003)(4326008)(66476007)(316002)(8676002)(44832011)(2616005)(6636002)(36756003)(8936002)(31696002)(5660300002)(86362001)(6862004)(6666004)(2906002)(41300700001)(7416002)(31686004)(26005)(478600001)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWdjdW1YOVk4Y0g4L25QRXg2RzdXdi9MMFRZb3FUUUExTERIQ1pubU9pOXlo?=
 =?utf-8?B?NkRPMUd2SmV3NnVXUnZMeVJLMExqUWpBOHkvUXNWRjhSUXlqNThNL0VnY25D?=
 =?utf-8?B?NDYrYmdOMDdWVTlVRUlwVVBRVXRyTDBFTzlXcTFOVGNYMUhSaDJsNFQ1ajRn?=
 =?utf-8?B?WHhTWE1EVE1pOW5ZTWFFNEJqeEFkTW5yZWsvbElUaFpHUklyOTNEakNENE4y?=
 =?utf-8?B?WEdNSzhZNHdlUHp0Y1B0eGVRTnU1eVZ2VGloTVdQWlFpZzhheDVNK09maFFB?=
 =?utf-8?B?T2ZCcDRIVDVqOGVHYi93RTVBdE9hZnJBK1ZUTVppOENnU0lNbUVtMVhUcC8w?=
 =?utf-8?B?cGtmK1BWSG9CQWo1K3I2cGJuUGwwemZLMnZ4cEZhbmxvb0VCQjFGYnc0RzUr?=
 =?utf-8?B?NC9lR3lNVHIwM1dYUkR2Tzhsc1VLNFEzT0NpZHRabjd1WklpaUV6eGJCL3p4?=
 =?utf-8?B?WDExSTJYMk5IQ1JHdlZmV3liWldrYTE1QXRoZDV1SXV6NVhncjJlT0d1Zjdz?=
 =?utf-8?B?RGxoN0JzdmR0M0xDOStudHBDQjZ5UXZUTDgyTExBRHVKWmNpUXNvU2VwQ1Zv?=
 =?utf-8?B?VmYyMUp4aEErKzdtVTZxeVRWZEdvamFRa3NpZlU5dkZ2Um1hd0tqbXJiSyth?=
 =?utf-8?B?Nkg5bXJZNWZYejNONisxNjByZVV2U0xGQmRMcDhsVnNVK1pMQUNuWmROOURk?=
 =?utf-8?B?NGFsWmIvaGxpN2J4Z1RFRVF4cThJR1FUbWhsMGwyck5wS2t5c0xhRlFhYmtB?=
 =?utf-8?B?cHN6QjcrYmxFQmtSSDl3MjkzekZvOFhFZ3AyRkM3MDhvSTRnU292amgwaldT?=
 =?utf-8?B?Q21qZDFCdnIwcDgyWkxzY3VuaVZZZVRlZXVSNjExVS9lbTkyREk4d0pVeTVC?=
 =?utf-8?B?UTFrclh1NlB6YzE1TUZnZXpEVFk5akdJTVFRZXZaRjczSEIrNDJQTTV1allw?=
 =?utf-8?B?MXZIY1Q3WFFtaVUzMCt1dGZnbHoxT1BCL05keEphd0pWZERzbEdUclZVSmF6?=
 =?utf-8?B?SkN5cHZRbmlFbGk5bUZ4NmhUb2NWNUJzbG5paEU4MjFsbUdNUkxpSXNOT1VO?=
 =?utf-8?B?cjVTMFpwc0Z0akxLTU91dnVHcE9XdFNsRldFYzF5QmRRVzEzTWo0LzhrUGdx?=
 =?utf-8?B?YjZabHhuQjRpTzBhdUFsak90c1hhems3d29YTU5na1pPZ0ttRGt6NHV4QnJ1?=
 =?utf-8?B?SXIwK1Z3dEtoRzJqekpXMXU5TzhoUEVlTEQvVmthNUpVWkFwVHU1TmJ0OEVh?=
 =?utf-8?B?TmpBMUJEU0VLZ0lwSHRObG9mL2NScDdrWCtwbzJmTzM1Z01aRi9mMnRFN3d2?=
 =?utf-8?B?OGhMeVBKSFp3TklkTXBFVDFoaFFxbkdzRFozMzYrSGNsZmgySFh1bURITDc3?=
 =?utf-8?B?NzZoVDMweEtCSzFkNkFwMFEzaENmRUlOZElad0ZiL2pUcXlhelZwZW8yUGhI?=
 =?utf-8?B?eVJXQUlsdTA1WG9ZV3FOKzczUDhiQjVEMzlYbnI1Y3pxbzBDNGpoK2tqaVdE?=
 =?utf-8?B?RW1PU1BsS1Y1WW9KZUtsZlZtQXZYMEp4c2hHb3RzZXZHRFExclUvNktGc2gw?=
 =?utf-8?B?cDcxdHpkUTJSR1pFdmc4dkxHRUZYTTk0bktNWFhQVzNpNVBTclRQYUZNc0dt?=
 =?utf-8?B?NlVZQXdTUmZZTEZYaGY1T01Sb3NtcEJLTHJJSGZBYytyRHRtZGh2VVl5QVN5?=
 =?utf-8?B?KzdyeXI2cUplR0pYN3doQXVjaU0xbVVIZDl1WFdkaU1LeWh0bXgzckp2TktG?=
 =?utf-8?B?bTZDUzRoU3NaZFJCcXdDWVJYU3V5RWh5YTkwa1Bsd21ZNU1tUE9ILzRTNHJM?=
 =?utf-8?B?WXBCcWhiY0YvVkY5SGZvaHkyWGh1MnR5QmI2d3o2M2JHMGhJSVpFWlk0SEFS?=
 =?utf-8?B?WGhITVVLdmJFaDIwQUJtV2txY0NKblJQZitSenJIN25uOS9kQ29WNkdvT3pq?=
 =?utf-8?B?NGVCcmhmM2wyQXRNclVoSldZMk5BSUxLT0ZPTmQ0UmU4TURQY1BiMUJBRU1s?=
 =?utf-8?B?M3liN0dpbHlYanJFdEl0U1BQNkRlNTE5dVozcXo1QWwvOWFNZko1M295Q3JR?=
 =?utf-8?B?dEN5NWVXZWpTMThleGFBa01RZmgvSlBMTlhRTHVodEpBaTA5WGlodDZiT2pN?=
 =?utf-8?Q?Eozq8tShfZkePBZLkZw0Ouz5U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bce869ee-3a1c-49bc-ee93-08dab61a8b71
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 23:50:35.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9Zu+wlcqDY8ZThRX2+Pbnz4F0nL3KMImn7lHNMIqFphxIuXXn42MNc9ajzaZTbJMempfGu+0HbNSBNN6kBQHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6605
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2022 1:34 PM, Jithu Joseph wrote:
> Existing implementation loads IFS test image during the driver
> init flow.
> 
> Dropping test image loading from the init path improves
> module load time.
> 
> Prior to starting IFS tests, the user has to load one of
> the IFS test images by writing to the current_batch sysfs file.
> 

The kernel is still unaware of the 'current_batch' sysfs file. It will 
be introduced in patch 12. You can avoid the reference here.

> Removing IFS test image  loading during init also allows us to
> make ifs_sem static as it is used only within sysfs.c.
> 

Does something like this sound better?

IFS test image is unnecessarily loaded during driver initialization. The 
user has to load one when starting the tests.

Drop image loading during ifs_init() and improve module load time. As a 
consequence, make ifs_sem static as it is only used within sysfs.c

> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index 27204e3d674d..5fb7f655c291 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -51,12 +51,8 @@ static int __init ifs_init(void)
>   	ifs_device.misc.groups = ifs_get_groups();
>   
>   	if ((msrval & BIT(ifs_device.data.integrity_cap_bit)) &&

Is there a reason to store the integrity cap constant in the device.data 
global structure?

.data = {
	.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
},

IIUC, you are basically reading an MSR and testing a bit within? You 
already have an BIT macro (unused) for that.

#define MSR_INTEGRITY_CAPS_PERIODIC_BIST 
BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)



> -	    !misc_register(&ifs_device.misc)) {
> -		down(&ifs_sem);
> -		ifs_load_firmware(ifs_device.misc.this_device);
> -		up(&ifs_sem);
> +	    !misc_register(&ifs_device.misc))
>   		return 0;
> -	}
>   
>   	return -ENODEV;
>   }

Sohil
