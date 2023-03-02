Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62246A8BCA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCBW05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCBW0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:26:54 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7732E4AFFE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677796013; x=1709332013;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UC3ZSNwTFC2E4xQ6dK0OezBcshuJQIGTcG9PvEqei50=;
  b=Ja24AIBi32M/GTm/mHvHFQh1BXM4QhcNoJW1p5/kK7lyPzaHzMqSErs8
   x91FD3NlVipkYOcsK7TpVJTJ5cN+3iKMR5podXdkLjAKrLBkzqPWhBbK6
   W9+aNcYrJbv9o+Waok5Kn6W/U0oNiFYmESpdgpm/dudXFkcWTMlXnMBE9
   /Gu/CG8YjBSU1q65dkCXWTcVbSTi4ipft4jlScNzkArM4s5tDcfe80PNg
   ssHRy37bRcXzS3XZjHYAA4yh++uguc/O77VgJsejtvC5kCTFroOSO3Jgn
   loIxrTNrCne6x5zW9Ga1dvhO5uFecp1HtX8IYsdI1FfAKVVtoO8daNrvH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="337187855"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="337187855"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 14:26:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="744019911"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="744019911"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2023 14:26:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 14:26:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 14:26:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 14:26:51 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 2 Mar 2023 14:26:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mn99i6lgqt1g8K+GJ7sBP3QQvkjJ3Rr49I5tdQq76GylfroamwNdXJmF4fxD09vZ9fqYyRMMd5U0hCDPeXSOeX5JHNBpTmOHTYdNwFrg0yY8tOJvuQ8Sw7cMgkxUcUlMI02WmhcAc23qZMNRNcSp8iuFE+wrkKWXU22u/43UAw3DCkEBHNbhiwGDJ6JauVKwiJLDPeOsPn3EBR76uQMA0xf5eujLRjIq6IiIu/oK7iUccuMKW9Qc84za1IE63O2W0ffxpYxcz61N5mXMuBOYCh7QttwWqEMWq05X7q7HmJa8YZxIqV1E0vRliezA18twGwO6hkzGqMnUib8vKLma+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+ZEDshRkZOrIWBlLt5lDPlW6dR5fMUn4KpaiNJMPYc=;
 b=Squu9Ny180m2f5wp0ByWEWO2K7UATVVPgEVv/nOynV5tekmwrzrJWEPeRIYA5FGQo2xN+OAKHn1Gp5DlGUF8SF8eu2Bdd/Qe20ziClP7m4EbeeXqI9b7U8bxoWjA9J0yMxmj9QyMPbesCd9wfkVOa0RmoQ9OQVOQd6UwUi9zXIMVQUfvWPjM1JGqjOBuQMdFpKZoukla+H5ZBigRLgc3CS+VI+g1BXbXEO/1Pon1jY0Q7mW3sykcI6UXYuE6grmiXRoDlTvoeM3+V3D26t/ciyqYxEjZGbe4dyOL4A+8RcZHLJ2OlsmnSeTfulVOx6CkalNWTTGKMc7wlsIEj7w70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH0PR11MB4837.namprd11.prod.outlook.com (2603:10b6:510:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 22:26:44 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 22:26:44 +0000
Message-ID: <2f0abf41-87ba-0eee-03d9-ec3e5062d595@intel.com>
Date:   Thu, 2 Mar 2023 14:26:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.2
Subject: Re: [PATCH v3 3/3] x86/resctrl: Implement rename op for mon groups
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     <fenghua.yu@intel.com>, <Babu.Moger@amd.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <gupasani@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <skodak@google.com>, <tony.luck@intel.com>, <tglx@linutronix.de>,
        <x86@kernel.org>
References: <20230125101334.1069060-1-peternewman@google.com>
 <20230125101334.1069060-4-peternewman@google.com>
 <b14598a8-2ab1-eda2-e1fb-a5f568e869d5@intel.com>
 <CALPaoCgnP0zU4fkDxst9pyY1FrxW2zT-VfMTnJbj_iytQxknjQ@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCgnP0zU4fkDxst9pyY1FrxW2zT-VfMTnJbj_iytQxknjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH0PR11MB4837:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b0350e-f6d3-4263-4487-08db1b6d33dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCTMLCajlmOyoZLQuoftD9ED2DEYqp7+V+4lKQt5Cv5VIZrIm+VfkTHkyLwKfS2fcPP67bEdWL/BqMqaj7su2RHDvOgNr0RutGceP9KheyKuH/bs1Gp2NvwNcVlk31WWI+i4n7BlJyAVrFy6BAjh0yJdk4jelzGhIdvqI/JWgFsz1eZhKmXDpq2MUoRVwJfh5VAqqwTeJOWhAfgXJ7/xmuRhiMthyAYK+MGhlYujtOA/bFbCG/O/S0xOULu4uY+t+CdYtYxzIfRclnn02NAIEM/pREPk76NCHfLhwhAT3TilND35GHcoe1rURvTHpJY/dx1Xm5DtDlfh9DSCfI77CzNirCwLtmHh+nA/Swi3fLL6CX6YUKIAUKPMrs4Y+/hkxmjRsfSAHlC8mZHsTWScrOiDCYY43qx0QQwgJJUi8QYas3MSG860enb2MBhjnqv4Nk92oz/kkbj2p2Ssz8r63Q5VMA6fSX/wX8v1uSnEfV9pXsD6DeDOXetib2eLtu0P4ynPaOOwYvfXB11sV0erxJuBb5XkS7KMe6ieiALIVwB/AiRvgageMJXkBuHJ6qNsXZsibJ52c72GinbLrv3VY8GYqE1vY7/6KIoH4pJbK117tlZvoZz5tTES6QLOfIM0Qxv5q618GcD3mPryzIKfppYMyJ3/ADHcJp4/u/KHBpKvCp0waytC995HewdTQOn3GakwVkIYAbk9cTkjzYkMeESIE2GSgBfmI/aQZm1Fy4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199018)(66476007)(44832011)(7416002)(6916009)(38100700002)(4326008)(186003)(53546011)(26005)(6506007)(8676002)(6666004)(66946007)(31686004)(5660300002)(66556008)(478600001)(2906002)(8936002)(6486002)(82960400001)(36756003)(6512007)(86362001)(31696002)(316002)(2616005)(83380400001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFp4NGhsZUpPV0xWdlVybFRZSXAwVS9KWFpNemNJdU1IcVJFVWFrZVlIbHVy?=
 =?utf-8?B?SEo3NVg3TFE4N1Axb2szR3JKRUdYRU5jMGFOWkxjMDhwY01DQ1dvdVZKK2pS?=
 =?utf-8?B?OWQyM3gweXFMVjBHN0lpQUZTSi9Md0NDVC9mVC92c1ZIZGtlTU1BRjc2WFl0?=
 =?utf-8?B?S1Y4cVc4VmJsdXYwOXNWUkRoNytCeHJheXlrdXFESUg0SWZNVnY1WmhyWmRT?=
 =?utf-8?B?YTBmeXZESE9qM1dOaEk0amlXQmpyNXZETVhxcUhmSzJNMEhueUhZWFBvTk1K?=
 =?utf-8?B?V0RhUzQ5aWFTNmpHV1A2M3NtbU50aUVUQkJ0czBEajg0dWQ3VFQyY2JUY0hP?=
 =?utf-8?B?cjg1NDJvb3hVOGRZeW9GOXhQT0krb0VKN3VzRWlINGFGY3JTVE5RU201ZDFh?=
 =?utf-8?B?TjY0d1BYZ0xxODRvS1Rtc1I2ZnZRMnlLLzF0Qm12ZEZrV0gwaDk0V0RwMWQw?=
 =?utf-8?B?dmI2RVlraktlelM5THUzcjNJaXRFSmo2d21GVE1IZzJPYnpSRFhRTTFWbjk1?=
 =?utf-8?B?bFpkS3BWcEpZNXlTY2xENXd3MWQzalhua1ptVlFMMUdUTXhoS2djRnpmMk5D?=
 =?utf-8?B?YWNhcUg2dlJaOVY1Z2pTeklKMjk3N2JoWFhOSFlxRjk2NE5WdUUxaUtoSkgx?=
 =?utf-8?B?RUVvWUxLL05sckRkWTlqVUxKWXJRL0JXK24zc2hFZDFKRGNoWDNEVENyS2lu?=
 =?utf-8?B?VGdVUWJWTUxmVzFZS3FERDFmU1RDdDl4OTdoS2UreFdoeVMrRStBWXpuV0dz?=
 =?utf-8?B?MlhyaHdwc0RTUGk5OGlsSFl4aEZSSi9SeG9ldzhVRHlWK3VYTVV5QjFCTVoy?=
 =?utf-8?B?Njg3Vk1UWnRRYmdlNUlqRUN3RzcrZFgzaXl0Z0xlOHhPNkpFVGFXaDcxQW1C?=
 =?utf-8?B?VzBwKzlkNS9oRXFuNnRyQjRkakpYQkoxd2psaFNhckVDT084QUZOZHN3bUFK?=
 =?utf-8?B?NXkxRi9GdjNCRUlQRlF3aWRkVi95cVd3VGk5RU8zNmlBK3JHUk5FWWpRdHZm?=
 =?utf-8?B?d3JJWERDVDFzU2VNVzJRR1RlKzBUSFFmeklQQVlyelJlMlQ4RkplY3Y2NEZE?=
 =?utf-8?B?ZFc0ZXAvYUNTNjlWbmFSWHAxUDdsRTBtNXc1ZWY4QmxrOXdQS01EQkJxQzNU?=
 =?utf-8?B?YVJZSHk4dEtNTVl5RzcyeHUxZDlRZ1NpcUtrYjhDSW1DSWEwdkI0V2c3c0Jo?=
 =?utf-8?B?VytvZ1JLVXJoN2ZubUFtOTJSTDF0dGtJRFlEYUVSSkV2Sm4ralN5c0F3RkFZ?=
 =?utf-8?B?RDMwdjA3UFJOa3ZOOWRrMWpjM1BaREkrQThDMjRMQmFLL2dMNlpxQ09uNVB4?=
 =?utf-8?B?TUhyRWlGbEpITStuRVZHOWNYNGxKd0lvRm5nRnMrU0dETnNtMFBKeE5FaS82?=
 =?utf-8?B?MzVLOHdlZVFjbmNERk5MeUZzN25XK1daV3pFb0MyK2R1YTdJQk9IVlRRZ3py?=
 =?utf-8?B?U3Bsalg4aG9pdnVyWG1FVUt2Ym1xajlnNUdzUlgwTWpGVDErZDhycXFLRmdu?=
 =?utf-8?B?dlhkQjFNWHRXdlB5eDM1ZlM4ZEMxTDhWSjZjcWpaUEdQQjA0T1ZTY2kyV0V0?=
 =?utf-8?B?d0VVTVB0eTJmSkpDNUdOWGhHRVcrUEM4RUhUY3diVjBOemRZeStzYUZuckJz?=
 =?utf-8?B?dlJiZUVEVjA4S2x5SDRFUWM5UXU0RWh6MHY2OXBHVXdZZlcyRmIwTTB0cjVu?=
 =?utf-8?B?dll2VWtyQ1FXUzNOVnhjZ3NKT1RwdEpSbFdiQzFTbUhkdzBabmlXZStTNncx?=
 =?utf-8?B?N2FDUlVSZjlLUGp2eGdUd1ZzaHIveU9menpCVVFOZTR4ZFZoNFErTWk1azdK?=
 =?utf-8?B?WlRXdldaU2tJZUNDQVZEUkFwUmR0VlZCUmwrYUo3OXN3TUJzVzJMa3IzeVI3?=
 =?utf-8?B?S2Uram02VmhweXFVamJWdWlmQ0JGWkJERThOQ04wWWhDRWdLSXhZRlUzMjNk?=
 =?utf-8?B?QmZ2YjJXM2NvT0k5YUZxZGhsbnhINnNxREdYNU1GdU5CUGVTWml0Q0QyUFFL?=
 =?utf-8?B?NE1qTGM3OEZBV2xvdnBDQ2xBSXR0Tkp3dU53Y3ZKTVdsT2J1ejdMY0xtZjdU?=
 =?utf-8?B?TThvcmFyaDhKeS9kWnExWkpmUFpCY0VCTldWZ0U3eGhxRmVsMHNSTEdoZFYx?=
 =?utf-8?B?ME90bXFJN1ZpaVVEalZESzJuTkFXaDNzVW5CWW83RFRxZkxUY05vZmRGeEJh?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b0350e-f6d3-4263-4487-08db1b6d33dc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 22:26:44.1328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1P2vKwQNoDZEdxDKHT5+3eitnLxeELRAwqz3ylVhgD6HBfh/Mg85j3Ny+A2n3ElSUy52XknPLMOZIXKU6IetMr7JtXQLtDFCluA3Nmyl1SE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4837
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 3/2/2023 6:26 AM, Peter Newman wrote:
> On Sat, Feb 11, 2023 at 12:21 AM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
> 
>> On 1/25/2023 2:13 AM, Peter Newman wrote:
> 
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -3238,6 +3238,80 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
>>>       return ret;
>>>  }
>>>
>>> +static void mongrp_move(struct rdtgroup *rdtgrp, struct rdtgroup *new_prdtgrp,
>>> +                     cpumask_var_t cpus)
>>
>> Could you please add some function comments on what is moved and how it is accomplished?
> 
> Sure, I think I should also make the name more descriptive. I think
> "move" is too high-level here.
> 
> 
>>> +     for_each_process_thread(p, t) {
>>> +             if (is_closid_match(t, prdtgrp) && is_rmid_match(t, rdtgrp))
>>> +                     rdt_move_one_task(t, new_prdtgrp->closid, t->rmid,
>>> +                                       cpus);
>>> +     }
>>> +     read_unlock(&tasklist_lock);
>>
>> Can rdt_move_group_tasks() be used here?
> 
> As it is today, rdt_move_group_tasks() would move too many tasks.
> mongrp_move() needs both the CLOSID and RMID to match, while
> rdt_move_group_tasks() only needs 0-1 of the two to match.
> 
> I tried adding more parameters to rdt_move_group_tasks() to change the
> move condition, but I couldn't make the resulting code not look gross
> and after factoring the tricky stuff into rdt_move_one_task(),
> rdt_move_group_tasks() didn't look interesting enough to reuse.

Could it be made readable by adding a compare function as parameter to
rdt_move_group_tasks() that is used to determine if a task should be moved?

>>> +
>>> +     update_closid_rmid(cpus, NULL);
>>> +}
>>
>> I see the tasks in a monitor group handled. There is another way to create/manage
>> a monitor group. For example, by not writing tasks to the tasks file but instead
>> to write CPU ids to the CPU file. All tasks on a particular CPU will be monitored
>> by that group. One rule is that a MON group may only have CPUs that are owned by
>> the CTRL_MON group.
>> It is not clear to me how such a group is handled in this work.
> 
> Right, I overlooked this form of monitoring.
> 
> I don't think it makes sense to move such a monitoring group, because a
> CPU can only be assigned to one CTRL_MON group. Therefore a move of a MON
> group with an assigned CPU will always violate the parent CTRL_MON group
> rule after the move.
> 
> Based on this, I think rename of a MON group should fail when
> rdtgrp->cpu_mask is non-zero.

I think this is fair. Also please write something useful in the last
command status buffer.

>>> +
>>> +static int rdtgroup_rename(struct kernfs_node *kn,
>>> +                        struct kernfs_node *new_parent, const char *new_name)
>>> +{
>>> +     struct rdtgroup *new_prdtgrp;
>>> +     struct rdtgroup *rdtgrp;
>>> +     cpumask_var_t tmpmask;
>>> +     int ret;
>>> +
>>> +     if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
>>> +             return -ENOMEM;
>>> +
>>> +     rdtgrp = kernfs_to_rdtgroup(kn);
>>> +     new_prdtgrp = kernfs_to_rdtgroup(new_parent);
>>> +     if (!rdtgrp || !new_prdtgrp) {
>>> +             free_cpumask_var(tmpmask);
>>> +             return -EPERM;
>>> +     }
>>> +
>>
>> How robust is this against user space attempting to move files?
> 
> I'm not sure I understand the question. Can you be more specific?

This commit adds support for rename to resctrl. I thus expect this
function to be called when user space attempts to move _any_ of
the files and/or directories within resctrl. This could be out of
curiosity, buggy, or maliciousness. I would like to understand how
robust this code would be against such attempts because I do not see
much checking before the preparation to do the move is started.

>>> +     /* Release both kernfs active_refs before obtaining rdtgroup mutex. */
>>> +     rdtgroup_kn_get(rdtgrp, kn);
>>> +     rdtgroup_kn_get(new_prdtgrp, new_parent);
>>> +
>>> +     mutex_lock(&rdtgroup_mutex);
>>> +
>>> +     if ((rdtgrp->flags & RDT_DELETED) || (new_prdtgrp->flags & RDT_DELETED)) {
>>> +             ret = -ESRCH;
>>> +             goto out;
>>> +     }
>>> +
>>> +     /* Only a mon group can be moved to a new mon_groups directory. */
>>> +     if (rdtgrp->type != RDTMON_GROUP ||
>>> +         !is_mon_groups(new_parent, kn->name)) {
>>> +             ret = -EPERM;
>>> +             goto out;
>>> +     }
>>> +
>>
>> Should in-place moves be allowed?
> 
> I don't think it's useful in the context of the intended use case.
> Also, it looks like kernfs_rename() would fail with EEXIST if I tried.
> 

From what I can tell kernfs_rename() will return EEXIST if there
is an attempt to create file/directory with the same name at the same place.
What I am asking about is if user space requests to change the name
of a monitoring group without moving it to a new resource group. This seems
to be supported by this code but if it is supported it could likely be
done more efficiently since no tasks need to be moved because neither
closid nor rmid needs to change.

> If it were important to someone, I could make it succeed before calling
> into kernfs_rename().
> 
> 
>>
>>> +     ret = kernfs_rename(kn, new_parent, new_name);
>>> +     if (ret)
>>> +             goto out;
>>> +
>>> +     mongrp_move(rdtgrp, new_prdtgrp, tmpmask);
>>> +
>>
>> Can tmpmask allocation/free be done in mongrp_move()?
> 
> Yes, but it looked like most other functions in this file allocate the
> cpumask up front before validating parameters. If you have a preference
> for internalizing its allocation within mongrp_move(), I can try it.

Could you please elaborate what the concern is? From what I can tell
mongrp_move() is the only user of the cpumask so it is not clear to
me why it cannot take care of the allocation and free.

When referring to existing code I assume you mean rdtgroup_rmdir(). This
is the only code I could find in this file with this pattern. I looked
back at the history and indeed the cpumask was allocated where it was
used but the flow was changed to the current when support for monitoring
groups were added. See f9049547f7e7 ("x86/intel_rdt: Separate the ctrl bits from rmdir")
I do not see a requirement for doing the allocations in that way.

Reinette
