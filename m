Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B5763C7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbiK2THm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbiK2TH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:07:28 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54727A1B1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669748847; x=1701284847;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6HByK68Sa7MYNX9QMetmqZs4kIx4wZe9Lso8wyk+8O4=;
  b=WXvIcA5aZ6jg9bQGAsWTJPNwpAtZIeRclN+EKLZD3ppFC3bzQ2MW7jrn
   bJp/Vd7kH+54BNcWBMy8rE6/iYWY6jaTLnvmWH3iGbtyQ75V1wyLi/sDK
   kW4bLZYar/ceCICw86f91B371B3qLOIrIoPeKLZVFN0XUP370pDzi4LlW
   BtBEd/T4qIJ8fNDQawRyun99mlDlSHg5+fDr7xRVjfCFYx8BSrBUKTkju
   bFWkYyRmKbFAqwPN4PNHw0P80ZaT811u/wc1ggGi9aKIqxgCi4cG8F6q4
   ZAbydSrAuV6OhDTWp8M0Fs5lbCbDxfg625r2avBscpjJK62V2K13ONi+T
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="377365403"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="377365403"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 11:07:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="768544452"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="768544452"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2022 11:07:14 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 11:07:13 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 11:07:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 11:07:13 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 11:07:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDhpsOLVB5+rjg3pFGa6m5CT4JpDP2LOJesmWbUlAwexZ/baEQUDPAUjVzQUOAcnD9XinwHQRuaxIACJi6ggbVgxjqJt2iV1i0Ptf6F7OduVZHpiZ/6EaQa9Fe8O/wrcUQa/Z9STU5H6mxDQRSiDynqPRGCBBsmCt1yzQx3BpxFpdkxq4ObdCxvAZeB8SHfNugUM8gk0zN7LF+KWW0GfW8M3km6nvgm/s7HpxzwNn4AYMPwiy0y4UnaK50yitdGT7Ggl/vlZNGjGpurJ2yKCRuPrjq3E3BN7PbKOqbBOihxDCgE9Xw7byN0/bFc9CkBR8SGfq7zcDynf5VUVLdgO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oBb0ZE70p70DIsTohCbd3jPuB2XNUSgmZLuciRKzWY=;
 b=fym+HeJKhgK8fLLnWGeyI4UpBmxL6P2GwpTUdqaix+/IPZjkYlNBzo6uVQaW/7Da+2aFtPcPzB+SLQTG4HFh8fqoqYJAk0iDN7b2h/sAA1P+yqDHsE0sHdLs89wKybjPY4QeKHoa+1XcnJRBQPvWDJ2uuygG4ODsGkgFNxluxoRXnqL5b7F4OiHkl45l4IEiwZAsTJSl4jdj/X3Q3HIB5DecYjZsbvN/rnBvX4hEuZ84Fi+EDkR57iby4en1BfJbiDnrixlhdOW5D4y9kYqpuYXTfDYQI5oKpi9Fb8vVCzwj6Y6ts3YpoYgEzO9V738cMwmDV9z/z0t6ljBfWZ3QYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DM4PR11MB7397.namprd11.prod.outlook.com (2603:10b6:8:103::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 19:07:12 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680%9]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 19:07:12 +0000
Message-ID: <11e3bb03-ae3f-6522-2a72-23d9f7cc3956@intel.com>
Date:   Tue, 29 Nov 2022 11:06:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] drivers/firmware_loader: remove list entry before
 deallocation
Content-Language: en-US
To:     Michal Lach <michal.lach@samsung.com>,
        <linux-kernel@vger.kernel.org>
CC:     <mcgrof@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <ming.lei@canonical.com>, <tiwai@suse.de>
References: <CGME20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9@eucas1p2.samsung.com>
 <20221123111455.94972-1-michal.lach@samsung.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20221123111455.94972-1-michal.lach@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0291.namprd04.prod.outlook.com
 (2603:10b6:303:89::26) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|DM4PR11MB7397:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ff5a51-0b64-4363-5ccc-08dad23ceaf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrOROqZ9zy6fDXpBbHV/IzQJKA8fJZU2wYALkTef6wtz57rJxCVbT3s9XezcAFEaKc7WKO3+3QHNGGqJrzGKE4xxzQ7/BU8R3PVsN8m8FcoEfv/pcy9IsNL1daUXQW+iY/3RH27ez6bwfjO5SvBaBY9/Pyw6srmE9sWybCLwJZntufz4mRh+Ll9nK23/jr70E2W4fIwFyX81W6866f+cF+sE8KzHh9dK8QrwENhbNxejJr4bmZ1nFvDTy4C6554xvFh5Q+J2lHudwa27XYlDFUmezpWvmVeOvO/18DN/5/5yEHJWzGSjuNZg/ycHksWx5gUJY3HTkL7TjGcO9kDorq3CyOsGYmGHt5HjxcK30diBIJ7801PIMKM6Gitk7zupiNHdCKxtZu+byyrGyy7CUBRv2IYpE6NUEoF1snv96TL3eAETALlvA5DKNBFn82ZG3Sv5AsH+DwR6lFg5ZQcWfeMQw/j8XtZo/DeH1T8rQioVjZMy7k3UfeJ5LHJQkznzrm57NQs/9f2gLnIxXC2YIq3PkaAv2U1EHNsMAzLQLCfNb17KKbWYPaXYiC+vRped1t4YcrJ1nsK5ISb1TOk7wP/cgabjFzhYOMKXNnOBedWt0jfmtESRL5KmkOWS2Fn+DhD9HRADfJaBtGQZKDi+LpartQ3u2hU0y7kfylcEENvsEHSTkTtmnwxDNNo0jpy0sIiGkqcw7FZotzMJpbxmTFnhM83hapU2my7ILaCckVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(8936002)(5660300002)(8676002)(36756003)(186003)(66556008)(41300700001)(4326008)(66476007)(6506007)(316002)(38100700002)(82960400001)(83380400001)(2616005)(6666004)(6486002)(26005)(86362001)(6512007)(478600001)(66946007)(53546011)(31696002)(2906002)(31686004)(66899015)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUpBZFJxalp6L1FnUWhaamhyd0hKNzZlVVh2OWhtQm9MOG1wQmtIN2RzaWcy?=
 =?utf-8?B?MmNpUnA2VUdyT2Q2N2NLNlc1TEJPSGl6TXFxUlI2b1hrMm5adzNpL2d0WW5V?=
 =?utf-8?B?U1JCOHZMcW5KTVV3U1lPSTEzdWRteHU5bTg1d3BHWk1VSDEwUVZsV2Q3OGtV?=
 =?utf-8?B?YXptcnNMRUlZOHpSVzNaaFF0YkVLeXdFdnB0M1ppbm1YcnNYRkdIVlNvZk5R?=
 =?utf-8?B?dzRpb0lDMVk4UmJlTXp6dSt2cVN3MnNvdEFmbmplYnE2enc3a1FwcHR0bUxj?=
 =?utf-8?B?ZndjQUdWb3RJSlUvb2UzVUs5Vm9yMG00aHZ5R0xMVVJJa3o4RXpqeS9BMHQ1?=
 =?utf-8?B?NllvdXFvNUJiOHdUd2VTQUl6RVJBQmhURmxqaXNMYm9UQkVSTEdWaEk0WEdj?=
 =?utf-8?B?UXRPNjUzV3RWdEhBS0NyY0ppOWJReU5VVm5HMlhSdHJhZFRXU1VEVjg5WUtO?=
 =?utf-8?B?dXltSldzTnNOc1U3UDlFS1VqSjdrTm5qYndtNXA3YUF0dlBKZnllU1ZGMGkv?=
 =?utf-8?B?UEdscTE5dVY1a2gvcXpOaisxZ24xZFZnVGhPTm9LMGU1dG5xU1V5Q0U2d2dp?=
 =?utf-8?B?UlRVbEJnbFkrRWhqb3h2SVAya2V5cklIODZUVXpjVndnUVNNWEk0N2lmbm9i?=
 =?utf-8?B?cURnZ0dMK25hdGxMWnViUHlwVlB1TUxEUXFKSkVpNWRyTEdHMisyMER3RjI1?=
 =?utf-8?B?WVJoYVBrVjR3eTRoUUNySDB6cXVJWTlRSjlhWGdwTHBvRHlQSjdnY1d4SXFr?=
 =?utf-8?B?NS9INTIrNy93YWxUNWlnbmV2R3lPNllLRStmb3JJY2lmU1I5VEtRcnJEb2R2?=
 =?utf-8?B?amx2VTc5Um9oUFB6QUNnNjRGZlBLcEsxeDdvdWVweHhFQ3REeHY0MThTWlhw?=
 =?utf-8?B?cGV2NHVZMHl4MUIxa1IwQ2o0cmxuaHNMR2E2cURxMkJXK3krWC9RRTA2cm9i?=
 =?utf-8?B?V0FTVVVHNXFmbTJqWUJEVXgwOWN0SHNDMDlRbjFBUGlWWkZyemk0WUNJdy8w?=
 =?utf-8?B?azJlcWFjUExBL0owYm0zNTczMlVDL3VObkZYTjNXaWRKUHExRHVpd2NvRnRt?=
 =?utf-8?B?S1JPa3B6cXlJeTk2ZCt1b3JYd0V3QjBOR3NOL3M1WmxFNDBadnkzK2YxTVo4?=
 =?utf-8?B?bkJOV3FLQlVlck5QNDlWQ2NieFZ1S245bXNhVlRSTlhaZExCUnlEb1JjdTJu?=
 =?utf-8?B?MlRLTm9Rdm1LK2RPNDluQzBQcXF5NzNLdXd5aklQdWVnYXVOK1pFaXFPQjJC?=
 =?utf-8?B?bnQ5anBDZk9vTHZmVlEvdkJhZU1ZRTB1dzQwdGZiVXFzclNWdmxxRzVtOERY?=
 =?utf-8?B?bVJXRmdOenpWbTNaY2lDSUQwcVJ5Zmd6d0YwQk95MFpqdTd4b0Q2bVFwTG10?=
 =?utf-8?B?TjVwT2NSRmZzcTlvV3hXaFV2TkZHVG9ZQzQrR3lUVmdzWXBaMzNlVWZ2bHhU?=
 =?utf-8?B?bVNYY3A2dG02RnM0R2FVa0srbEkxSm9MTHh0Rkl3WXlhM3ZPVFFCbFp2V2ly?=
 =?utf-8?B?WVBWK0hkcU1JQzlGbG9JYWNTZ3BjZ0RzQmVhU0NuMnh6WkNLZXhINDFJWitt?=
 =?utf-8?B?cE9vYXB2TnpIWkVnRkZBcWswODVPdFQyS295RFUycnlYa3JrTkFNSDU0cmJB?=
 =?utf-8?B?eTl4eUY3czl6aHZoMzRJZUN1a0lrWTNQSFZTYUswVmExby9oaytDYUQ2SFZp?=
 =?utf-8?B?Q3B2OVpYV2xwdldqYWx2bUZaU1N1UmdETFVLM0hiWHdBR3pXUXQ1b0lxTFpZ?=
 =?utf-8?B?R0pDeUduT3FaeDZhMXZKcjNpdndRUXp5RkkvUTh4ZWtnRVhSMmQ4MlB6RDUz?=
 =?utf-8?B?UG5CaCtmRnZxMXVram91WXlCTDR3alpaNko3WEcxeTl0MzRBRnZXem5SWFc5?=
 =?utf-8?B?RmFZeXlRYTZiZnlEdkJ3UmhkeTIwQ3ZhTFREa2Zvb1I4RmJzZ2JNM3NmVGVQ?=
 =?utf-8?B?aFhSZG9HLzdPcmxBVkVrcGc4dmxnWEJZZVpRaEIzUjA4bFgwNXdEYk1ZNk1T?=
 =?utf-8?B?QnJscm05ODhyVnl3YlVIZ2pncjZzNkNHMXJjWmoyY0xhQkg1WE9ibEtWcVl4?=
 =?utf-8?B?SkVYM2VlKys4T0oxUm5QM3o5QlE0ODYxQTU3MTBaRzdna1BRL0JQUFUxOEVH?=
 =?utf-8?B?OGJQVFlFWkZ2TXYrdGJQend1cW1OYWp5R2lhSk5jN2dDZFQ2R3FFS2RwbU1z?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ff5a51-0b64-4363-5ccc-08dad23ceaf2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 19:07:11.9062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQmyJC/fZuuhrbW1APx9ME8u+I42r/4SOSNcxuMvT8rrC6sG4ijujO//aU5UsYCWdBNtzbG2x3ebdG9tDZz7vgFKuaCkTNG7ESIKv5yjIek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7397
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/22 03:14, Michal Lach wrote:
> If CONFIG_FW_LOADER_USER_HELPER is enabled, it is possible to interrupt
> the loading process after adding pending_list to pending_fw_list.
> Subsequently, if user calls release_firmware() which deallocates the
> fw_priv structure which pending_list is a member of, the entry in the
> list is not deleted. This causes a use-after-free on further attempts
> to add an entry to the list or on list traversal.
>
> While not problematic in most drivers since this function is mainly used
> in probe or init routines, some drivers expose firmware loading
> functionality via user-accessible functions like write() etc.
> In this case during the sysfs loading process, we can send SIGKILL to the
> thread which is then in kernel, leave the entry in the list and then free
> the structure.
>
> Example kernel panics with CONFIG_DEBUG_LIST turned on:
>
> kernel BUG at lib/list_debug.c:25!
> /* ... */
> Call trace:
>  __list_add_valid+0x7c/0x98
>  fw_load_sysfs_fallback+0xd4/0x334
>  fw_load_from_user_helper+0x148/0x1f8
>  firmware_fallback_sysfs+0xe0/0x17c
>  _request_firmware+0x1a0/0x470
>  request_firmware+0x50/0x78
> /* ... */
>
> or
>
> kernel BUG at lib/list_debug.c:56!
> /* ... */
> Call trace:
>  __list_del_entry_valid+0xa0/0xa4
>  fw_load_abort+0x38/0x64
>  fw_load_sysfs_fallback+0x354/0x468
>  fw_load_from_user_helper+0x17c/0x1c0
>  firmware_fallback_sysfs+0xc0/0x11c
>  _request_firmware+0xe0/0x4a4
>  request_firmware+0x20/0x2c
> /* ... */
>
> Fixes: fe304143b0c3 ("firmware: Avoid deadlock of usermodehelper lock at shutdown")

Reviewed-by: Russ Weight <russell.h.weight@intel.com>

> Signed-off-by: Michal Lach <michal.lach@samsung.com>
> ---
>  drivers/base/firmware_loader/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 7c3590fd97c2..381997c84e4f 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -209,6 +209,10 @@ static void __free_fw_priv(struct kref *ref)
>  		 __func__, fw_priv->fw_name, fw_priv, fw_priv->data,
>  		 (unsigned int)fw_priv->size);
>  
> +#ifdef CONFIG_FW_LOADER_USER_HELPER
> +	list_del(&fw_priv->pending_list);
> +#endif
> +
>  	list_del(&fw_priv->list);
>  	spin_unlock(&fwc->lock);
>  

