Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0BF6C6FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjCWSIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCWSIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:08:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407D110402
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679594917; x=1711130917;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i8gXEmH7IX23C4liYW+H3DrXyFtEjQfebIh9z05nznw=;
  b=VNkRoBOCsGej0MdkKo6xPMxEz9Bqo+hkzNPW1GJFfJT4q3QsCsn3iSIz
   r7PASq1Ua+O5KrJtpP7Dm5ahym/btR/thK+S+MYY8iPV7oTdeVFSYwM8X
   kpzh7E7ItXii3OeAdpHqE/r5RgkneS1BExJPWoUz+jfORxwBwdvg1ZxZc
   KuaLh3g8pdo4V81mQgbyIrZlwsrEOopiOK50rCdCve1cL0CrKkA08LiQs
   n+BJE+OL0CjGKJqUUp8110nbjDD28ifLVmNDsjzvP0QKS0Jyf84EBje9p
   EHLCCrXZe5SrrK0Edj54HE9neIltbSzw7HqzKfDJdlOR1OduGOiiKemHh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="341135012"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="341135012"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 11:08:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="928343404"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="928343404"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 23 Mar 2023 11:08:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 11:08:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 11:08:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 11:08:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 11:08:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNeqhMpdWPqIfFbZWf6t6qu/7irKxy8Cfnx37BwTaKbq1d6S09X3ezJaMdiU9xs7f0Qs3nYezGlO5TPSBPC9ajWyuyzTB/EqyEFeXqnP2FaRMEYMdZlsaU4vvvJymJJMkvfTxflk3oUA4od6Hu3OilYnrV03u5KdFMaQB3pZ5HprBv5Z/i7o3IqlNzOQ5hlLyAD8eIE2x63wWo6s5oIi9wV8CtncHemwxh1pAbNBBx+HWs0+IUl04mzPMY+nltom0+zlnAOHJX8tI1EYnwamE4CSN5CFdn5nfiT5tL2lQHfTAz37CKwf15MQvN1Ddfjjn21yZ11xe9U7wWdWYwYaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBaHXqDimIeVWkX1p4cj6B9N47btXLRfVOCSW66F4zQ=;
 b=HUXZNTokH+/uDlxPRo/bVc5MYB1PxIsg79u+5YLurp8X1i+xunyeslbW6n1Ml6+UR3lsTAXA4vJwgzLAlzs8vC6NTO1+XyvMt0cKUbmSiBWOqDVOV2MuWO1qo8ckcXysHD97Rp9Bqyi5jPXKZLKOTemK/ose1dV/r4WnQoG5SGuOhcXTxWHULXi9mQR+RcKdxtZkIws/DMKfnWBEDo3UDcBqBLapSBTEpT67iBZhRkZGUqNsAUUdJzTMxBhSeTQlmiHEJzhpS3XAYxRirNKT9UKipCvKhdzLSGKPFFKSRwncomSRCEMMHykBfqB0Mxk7FN1bEdZGZ2H47IVk4zeVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CYYPR11MB8308.namprd11.prod.outlook.com (2603:10b6:930:b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 18:08:08 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.038; Thu, 23 Mar
 2023 18:08:08 +0000
Message-ID: <4a276e2d-9f56-437d-8284-c95def0d2487@intel.com>
Date:   Thu, 23 Mar 2023 11:08:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 3/3] x86/resctrl: Implement rename op for mon groups
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, <fenghua.yu@intel.com>
CC:     <Babu.Moger@amd.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <gupasani@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <skodak@google.com>, <tglx@linutronix.de>, <tony.luck@intel.com>,
        <x86@kernel.org>
References: <20230308131452.383914-1-peternewman@google.com>
 <20230308131452.383914-4-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230308131452.383914-4-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CYYPR11MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b161ab-de71-4158-81a0-08db2bc98e0b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EqUTNdQ5s34w/rfx2OlocMr07tZRgLB0hXGYBf0tY+5CYSGRMdiq2NSI+wtVov+4RkA+flFPo1WvezPDfdDlSRcQsC020UFzKnoixiE4+4ASdPo1XRMuTJ7ii2Mx6Q7UG57oSeyDRPu6TE+H+utYLQJ5xKSOqTxXpZ1tVxOlMPz8XLAwol9dDZIZ0y9/BqylclbakZbKCBZoubj5gksdsFPF6m9HGhLcKlxfJilIrWA4PkvwLBWNX38RoJlxECgmj+XlLYNB3Ll/8xaIWLPVjF7UDyJR7ppcN9WhhVb0JoXa8dbBmwpBbhqz6yQtIm0GmY7EMcUOuHd4jC6LjmAgM78ztdLft57LNKRaOOUIpqOT9I62Pbeu5FNhJQcbjdAFuPbLXQcPbpLcflirtVWy8YJt8iYYZ8ZyuW8BQ2uHkOB59qmekjHMC4oBrNwTcTzP+YlHHpgkT7+iihy2QtPnVNrD8mt8oo8FBgCu4MbxIYqzh27BqEklXU/stW85RUxP/xxdBrtBg+M0ImMnjC4XaiQGPahp/1HijI75dZB+OT1OuuYi2MqzoyK8MN09fr265P6SKvaAN1DPLjuuPMuQlJpzW9YTGkCoBgnJMr8UAXnI+fWQXVZCL2UM9eLqttUOKPIttPF9dxaS9tmIw+bYzhgN3MImwhZWp06DfzGoS2gr1OdczgqTcYjDhfCeC6TdEJyc7Kg8MsRc8OJIN4bLN51zDgNSVyfdTUXJ8T7rBb0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199018)(36756003)(66556008)(8676002)(66476007)(66946007)(4326008)(6636002)(44832011)(41300700001)(7416002)(5660300002)(82960400001)(8936002)(316002)(26005)(53546011)(6512007)(6506007)(6666004)(186003)(478600001)(83380400001)(2616005)(6486002)(86362001)(31696002)(38100700002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3JiTExtZE5KclduTC9ubS9zZGg5MFZ1am44eVIxZWRZcEF0eHc3UmxqdmJo?=
 =?utf-8?B?UnFTSW1pOS9kcERVYXFvL0VzK0ZacVJkakc5dDZoNXlpdHhxNFU5Qjdrbkc3?=
 =?utf-8?B?OXBQOEpIWWRmcnVETzBTL0VxbWhndzl0ckYvcTlQNDA0V1N6dGQxemVQdDZo?=
 =?utf-8?B?ZTNvbHhWQ3lMK3RIKzczV2UwL1crVGQ0TE1iSlJIeUFaempER1lVTmZNVWc3?=
 =?utf-8?B?V1lCOEwwZllhQkRFMTBZdHVINzlDT1RKdW5wME5tMGVZVFRpYzFadkg0Y3I3?=
 =?utf-8?B?ZVorZUUvMzFIQmt6cVU5RnYxSHZYbkpHUGlDNXZqTm5HUGhPdXBOVnNGNTJs?=
 =?utf-8?B?RUFpYWFiYzVZakhlUFdTYXAxa2tpQ0RteWV5S3dDY0RkbTRqc3FtNTRNbkFK?=
 =?utf-8?B?MDlReWJWeGtmblV6bUp0RGR1SkhLRCtEbTUzVTJua2Z3RW9CaG03RTlVYmpE?=
 =?utf-8?B?T1p5SDRqNWhVMkJ0eTZEbEZyKzVIbFp6NEtlZHA5R0QwV1FQbUhjdjJCSlc4?=
 =?utf-8?B?UUtSQ0tJNk0rNE0rVm10N2VWQzVkVEJSVEx0alcraDVxWGRUV2l5ZVBPaFlW?=
 =?utf-8?B?YkIyTVcvVEJDSXZacTN0TEwxcU5udGt2blRmV0xvYW55WDkweTlqemZWdGtu?=
 =?utf-8?B?TWFPcmlydmVpK2lxL2k1MTF4WUxEdTJoNWwrWm1jZ0RmakNsUkRoYkQ1cGxP?=
 =?utf-8?B?UkNUU1orejlpR3pTakwwUVBpS0RpTVN6YklqbGdOYTIyVUZXMEwzdnNpNUlB?=
 =?utf-8?B?bHpPaHRTS05pQWdtSWZzTEVoR0hYMzZWd1JQdFhOek8rdjE1ekhacWxQaktW?=
 =?utf-8?B?SkFrOFdDYTBxKzZDKzVuTUk3Q3h6U0hZK3dBeEI5eU5kZUQ3TWVNOE1GRXU0?=
 =?utf-8?B?aG5PTDNFVWwrZkR3cFJEK3dNYkRFZ3ZNUXBsbUlKdEx4aWVPcDBXT25QRVdY?=
 =?utf-8?B?bS9tQjB4NnlOSm9uVHhIRTlIZHhEUUowZ25kQUJBS2dWUkxpUlAzSDQzSUwy?=
 =?utf-8?B?YllmeFgrc25MSnlLSjJ6MHFLTUphTHJYa0ZnbGNHaFlTNDE1Yk15Z0tqNzU2?=
 =?utf-8?B?OW5EbnJhdFlyVythY3luRTAxVUNmUzNOTTVPOWI2QTFjckYxRC9vbmhYYU9U?=
 =?utf-8?B?ckZMRmtVY0NZb2dzNjE3VXpKY1IrWDFocFJEUW9zSTUyQlIyRXVNeGExNlFr?=
 =?utf-8?B?V0tUTGZhNDlnVmhHRGlmRmpkbVJRTnlaM2dCQ25UeXJmSytyaDdyMWFpcVRz?=
 =?utf-8?B?Tk42aGNuRk5LUGZiWFR5U1pjem9HeVRkK1BqSGZhaktSTWJtcWQ2UEd3TmY5?=
 =?utf-8?B?WkJ4ZnVLQkttS0RkUGhOUDJ5UDFqQkJXYjNhbCtJWHYwUFBrMHlOQzJaRUJL?=
 =?utf-8?B?ZHBlZ29ZWkptZTlNUDJSMnFINVB4WjNNaVFFZkN2S0hRRWlSZlJmbXkzaGJR?=
 =?utf-8?B?YWtxMXBGQTFvS1pQaUNLSFo5bGxnWlBVb0dpdnpMRi9jbVgyeCtGWmlqQkw3?=
 =?utf-8?B?Uk5sd0d1RytYbVUycEk4bE5RM1RHZmZIbG9Dd3lXMzF3UUVValhqSTZRVTli?=
 =?utf-8?B?cThyUTNOTW1OcWN5SmczaldtdFo3NkF4OUFMQklCa0VxMDROc24yeEhmcDFB?=
 =?utf-8?B?L2ZZdDZqWWZ1Q3VMTjFyWStyc3lhSzYzQ2JSRExMSG0zVzFLZ1ZGbnhXeEIy?=
 =?utf-8?B?VGd5RERGSktieWZSM21qbGZBVmJYZm15am0yTXQrTHRoazNDanVzVmRQc1JW?=
 =?utf-8?B?RUVBYmFTL2VscFZrdmJuNWhXWGhTM0lXTFg3MnBDTzlxUmNsWjRpRmQ3aUJh?=
 =?utf-8?B?clZLVGU5QWVTdWY4dzUxODA2SlNWNkdZZUFDLzY2NE82ZW85UE9YU3NscTBZ?=
 =?utf-8?B?MHNEUDJ2YnFzQjY4UHhYOFF0VVl1dFE0cEg0NVBTZEVtb2RrdXNKTnF1dzdT?=
 =?utf-8?B?OUlKN2l6NFAzTGN0amFsSVltdGJQTmJtWkF5RlZFM0ptU0xWaytvNU11UUpn?=
 =?utf-8?B?RXZxWjZIRUpEUzNQTFQ4MldjZU5yaXpzOGlPdlA2SkdIVldjRVgrR0lha1k5?=
 =?utf-8?B?RHlGbXlxRlBRcjBIT1h5UGhiMmVHVEVUS0xJdzJQQ292QTkveTlDWHFkWDZV?=
 =?utf-8?B?cjZNQko5K2dIaCtZZVJZRUZJazhidThBMnFxWFpNOU02bnhLbGhYanVpODV3?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b161ab-de71-4158-81a0-08db2bc98e0b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 18:08:07.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XL/U4X0DIFblfqGRYnTMZ4F9fuSedO21ZN1+oDs/51idCO4wXBHfKHRB3OXnQ0vUC4x5gC+0WBnzRXWJxxs85VlHvF3mXKc+7OJwev8ydyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8308
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 3/8/2023 5:14 AM, Peter Newman wrote:
> To change the class of service for a large group of tasks, such as an

how about "class of service for" -> "resources allocated to" (see later
comment)

> application container, a container manager must write all of the tasks'
> IDs into the tasks file interface of the new control group.
> 
> If a container manager is tracking containers' bandwidth usage by

"is tracking" -> "is additionally"

> placing tasks from each into their own monitoring group, it must first
> move the tasks to the default monitoring group of the new control group
> before it can move the tasks into their new monitoring groups. This is
> undesirable because it makes bandwidth usage during the move
> unattributable to the correct tasks and resets monitoring event counters
> and cache usage information for the group.
> 
> To address this, implement the rename operation for resctrlfs mon groups
> to effect a change in CLOSID for a MON group while otherwise leaving the
> monitoring group intact.

As I understand the main motivation of this work is to change the
resources allocated to a large number of tasks without impacting the
monitoring data. You do mention "changing the class of service" and "change
in CLOSID" but I think a simpler motivation can help to support this work.

Together with the earlier snippets, how about the final paragraph reads:

"Implement the rename operation only for resctrlfs monitor groups to enable
users to move a monitoring group from one control group to another. This
effects a change in resources allocated to all the tasks in the monitoring
group while otherwise leaving the monitoring data intact."

> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 127 +++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 84af23a29612..6d576013fc16 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3256,6 +3256,132 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
>  	return ret;
>  }
>  
> +static bool mongrp_reparent_match(struct task_struct *t, struct rdtgroup *from)

As a follow-up on comments in previous patch, please name the function to reflect
what the does as opposed to what the caller does when using it.

> +{
> +	WARN_ON(from->type != RDTMON_GROUP);
> +
> +	/* RMID match implies CLOSID match. */

I find this comment confusing considering how this function is used. The resource
group's CLOSID was changed and this function is used to find tasks that need their
CLOSID updated. Stating here that the RMID implies a CLOSID match when the
CLOSID is not expected to match in the usage is unclear to me.

> +	return is_rmid_match(t, from);
> +}
> +
> +/**
> + * mongrp_reparent() - replace parent CTRL_MON group of a MON group
> + * @rdtgrp:		the MON group whose parent should be replaced
> + * @new_prdtgrp:	replacement parent CTRL_MON group for @rdtgrp
> + * @cpus:		cpumask provided by the caller for use during this call
> + *
> + * Replaces the parent CTRL_MON group for a MON group, resulting in all member
> + * tasks' CLOSID immediately changing to that of the new parent group.
> + * Monitoring data for the group is unaffected by this operation.
> + */
> +static void mongrp_reparent(struct rdtgroup *rdtgrp,
> +			    struct rdtgroup *new_prdtgrp,
> +			    cpumask_var_t cpus)
> +{
> +	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
> +
> +	WARN_ON(rdtgrp->type != RDTMON_GROUP);
> +	WARN_ON(new_prdtgrp->type != RDTCTRL_GROUP);
> +
> +	/* Nothing to do when simply renaming a MON group. */
> +	if (prdtgrp == new_prdtgrp)
> +		return;
> +
> +	WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
> +	list_del(&rdtgrp->mon.crdtgrp_list);
> +
> +	list_add_tail(&rdtgrp->mon.crdtgrp_list,
> +		      &new_prdtgrp->mon.crdtgrp_list);

Could list_move_tail() be used here?

> +	rdtgrp->mon.parent = new_prdtgrp;
> +	rdtgrp->closid = new_prdtgrp->closid;
> +
> +	/* Propagate updated closid to all tasks in this group. */
> +	rdt_move_group_tasks(rdtgrp, rdtgrp, cpus, mongrp_reparent_match);
> +
> +	update_closid_rmid(cpus, NULL);
> +}
> +
> +static int rdtgroup_rename(struct kernfs_node *kn,
> +			   struct kernfs_node *new_parent, const char *new_name)
> +{
> +	struct rdtgroup *new_prdtgrp;
> +	struct rdtgroup *rdtgrp;
> +	cpumask_var_t tmpmask;
> +	int ret;
> +
> +	/*
> +	 * Don't allow kernfs_to_rdtgroup() to return a parent rdtgroup if
> +	 * either kernfs_node is a file.
> +	 */
> +	if (kernfs_type(kn) != KERNFS_DIR ||
> +	    kernfs_type(new_parent) != KERNFS_DIR)
> +		return -EPERM;

This would be one scenario where the user may attempt an interaction
with resctrl that results in an error while peeking at "last_cmd_status"
will report "ok". This is not the only case in which this may happen and
I think the code is ok. To help users to not need to read the kernel code
to understand what is going on, could a snippet about this feature be added
to the "Resource alloc and monitor groups" section in
Documentation/x86/rescrl.rst. It does not have to be elaborate
but in the area where directory removal is discussed there could be
a snippet that documents this new feature.

> +
> +	rdtgrp = kernfs_to_rdtgroup(kn);
> +	new_prdtgrp = kernfs_to_rdtgroup(new_parent);
> +	if (!rdtgrp || !new_prdtgrp)
> +		return -EPERM;

Can this be ENOENT to be consistent with this error encountered in
existing resctrl interactions? Although I see that rmdir currently
returns EPERM also but it is an outlier with that usage. ENODEV may
work also to match with the mkdir return - I do not know why it
was done differently.

> +
> +	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
> +		return -ENOMEM;

It remains strange to do the allocation here. I understand its usage so maybe
just a comment like: "Perform early allocation as part
of ensuring the later resource group move cannot fail."
 
> +
> +	/* Release both kernfs active_refs before obtaining rdtgroup mutex. */
> +	rdtgroup_kn_get(rdtgrp, kn);
> +	rdtgroup_kn_get(new_prdtgrp, new_parent);
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	if ((rdtgrp->flags & RDT_DELETED) || (new_prdtgrp->flags & RDT_DELETED)) {
> +		ret = -ESRCH;
> +		goto out;
> +	}

Same here, ENOENT?

> +
> +	if (rdtgrp->type != RDTMON_GROUP || !kn->parent ||
> +	    !is_mon_groups(kn->parent, kn->name)) {
> +		rdt_last_cmd_puts("source must be a MON group\n");

Please start the message with a capital letter.

> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	if (!is_mon_groups(new_parent, new_name)) {
> +		rdt_last_cmd_puts("destination must be a mon_groups subdirectory\n");

Also here a capital letter please.

> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * If the MON group is monitoring CPUs, they must be assigned to the

Could this please be specific about what is meant with "they"?

> +	 * current parent CTRL_MON group and therefore cannot be assigned to
> +	 * the new parent, making the move illegal.
> +	 */
> +	if (!cpumask_empty(&rdtgrp->cpu_mask) &&
> +	    (rdtgrp->mon.parent != new_prdtgrp)) {
> +		rdt_last_cmd_puts("cannot move a MON group that monitors CPUs\n");

Also here a capital letter please.

> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Perform all input validation needed to ensure mongrp_reparent() will
> +	 * succeed before calling kernfs_rename(), otherwise it would be
> +	 * necessary to revert this call if mongrp_reparent() failed.
> +	 */
> +	ret = kernfs_rename(kn, new_parent, new_name);
> +	if (ret)
> +		goto out;
> +
> +	mongrp_reparent(rdtgrp, new_prdtgrp, tmpmask);
> +
> +out:
> +	mutex_unlock(&rdtgroup_mutex);
> +	rdtgroup_kn_put(rdtgrp, kn);
> +	rdtgroup_kn_put(new_prdtgrp, new_parent);
> +	free_cpumask_var(tmpmask);
> +	return ret;
> +}
> +
>  static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
>  {
>  	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
> @@ -3273,6 +3399,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
>  static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
>  	.mkdir		= rdtgroup_mkdir,
>  	.rmdir		= rdtgroup_rmdir,
> +	.rename		= rdtgroup_rename,
>  	.show_options	= rdtgroup_show_options,
>  };
>  

This looks good. Thank you.

Reinette
