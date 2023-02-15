Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529C2698288
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBORo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjBORov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:44:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63C83C298;
        Wed, 15 Feb 2023 09:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676483088; x=1708019088;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tncO0kQPchMftI++YegBdRpLQNYFZ/c1qmeFGp9o59w=;
  b=cTv3pRV2DsHBuEgCLWImswA8BrxLQ9ajYMcWNeAnOYbkAlDhMGAkx/6K
   AZCgBVrzT3mDDbJpuo0PSzPTxndwMU4jAqqmqB/C2v2izjzNhRzof/w/2
   Jjsw7dMZG2VarAWqqG+7p+kGcPC2tCf5miJ960HivG6cSiekV4X3xzWxw
   oVmTvgqVuvL2WZ8g0WF5222bm8ReLZNky0aSToDp7SNWJuHCLeF7CMJvN
   1jMQ36H9J0zlJ39XWfx09mb/nwr9AjOwL//t5LbfwcQfcQlzo6m7Y6KaC
   nd68oC75dykxSNnLRHBcXSq5W3oplMkFYPRKkYtz8FEuxcmHh63CP3jMy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="330127442"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="330127442"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 09:44:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="669724101"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="669724101"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2023 09:44:44 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 09:44:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 09:44:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 15 Feb 2023 09:44:43 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 15 Feb 2023 09:44:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZMdUKvMaFvVs6w9wMKjVLyLTNmO0Oq2MtU7VK4FU8SDkJSwsTC9GlvopJo2YhnB9MdZZce57pQebidD6g71SOzk8w+gkND+Jn8Cersv5Ov5Xg8gkiiHm1IiftNZmNDIvA3McsEdN0f9TTXlLHqOO2KFKTjInHjJqzeAXe3IfyA8XoKc/iuIOkETJuS/WmzTHhlSpvrHZDT+QrM6XVOXgWi9ruiM5O5nllU0KAhYxeIP4T1hULxEbPC9shJZzhwC7lKFHlBMjLfflwnDsk85VuQIPoF1XrtKUR1DE0MuM0xN3jRKxcMp6rKMR+oz5VgD0DvmxP+OdWH9aqty3sRMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kp22xg6OPAxVIrcfk/KzXX13mLwYfMCG7nv6a2qjVR4=;
 b=RDxSsvt6NB4b+05mgimB0jBvCaA7BMTPB/2a0NpK1eO+HEctKAIqFE9ioPk/JHqelt6TpKxoGuRa1cu5RJjmMONJ4K5DDPSGuuYg/lhPPiKcA+irKaRe1U8qpYxrra6ucItJzNX3VRujmnmKu/BKAn4jf9fjL979IE1efJAd6EAxpKOk2DuTGjg6uBbu2T3aWpvOdNAYMagj3dK083AJPSU/Q8z1NArs0dc3C3LVwviS5fzjlEYuVbkEUhjP+ObCGV4jfdPG6aAFFUInND1SZpSGKFzCUnBahxU+P/AwIhGCQAHbyjbAoZqpSd9Y9CCxMMS2zMy2OlTZ4vwsl7teBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by PH7PR11MB5888.namprd11.prod.outlook.com (2603:10b6:510:137::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 17:44:42 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72%5]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 17:44:42 +0000
Message-ID: <e2cd922a-0a5e-c1ef-3fe7-2347f3b062d1@intel.com>
Date:   Wed, 15 Feb 2023 09:44:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 4/7] platform/x86/intel/ifs: Implement Array BIST test
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <rostedt@goodmis.org>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230214234426.344960-5-jithu.joseph@intel.com>
 <a24c65f8-978d-8968-7874-6b83e14b01ba@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <a24c65f8-978d-8968-7874-6b83e14b01ba@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23)
 To BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|PH7PR11MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c14fa2-1024-40d9-17dc-08db0f7c512a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHzZStmK/LkjEgvzvsJb6meiRSSZ7yplHi8IR68QFyovHM3ygmWiTwHdnfoxQk7e1ODzHDXTrkVS20oMMpN3kkjyzPtLPI3+yz0j9eu4eJ9mnIFjLt2g2tgiwlLyiQb/gG+nsfQ+NC2zJWcKHMZv+D6wzA9TrB7/l8ZX/P8rxdsS+Bl2Gr48K/9bB2/V/96A4fNJ9Jw+iVqFtldBqPgRA1mtunIqmk/4fSzk/lXXHAXIZEu7qVE3nRWH1brZPDsTV/PF1k/7Yhzlsc3edjkh7xESkq1xKWRfCaIaVi49BP4eu0YZJLkn8Nv2ZwUF4SqD1CZWxtCFrSu1JcoCFd01c0frm8kUg/9WVo+ryRCRewmq1gtYzBaQGhXXofY/FV72xG23ZcpMh/UYP4X1jXhJtNGv31mVsetewwM9F7tO8Ui64X06OqMy6TGR2MR78OGHz4kA2w/iUWSdfcWg56SuFjtyt2xgyk9DPwML6bvACHnk5+XmPtSykMLjZ+S0TUpc+uIpSpwyW7ig5ILlkBSpjhTreOEBhFwbMAejLzRbT9ReCIbyaVUCFWBGJru6ynbGMJlDh15he+il+lYQCeNF3w+s/ElttwihX+eoL9b42zUnhmTFw2bPIbWCmFZ5MqVhakh3nEeSKbnnWekgZ3bP+ytcz43K5N4L2KH/iTPH5u+AORNhKI/rqfxI4kvc+T8Sg2dKD3HTyO/exlEY6UcGLiFqT3tyBJmVeio+4maDK5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199018)(86362001)(2906002)(31696002)(6506007)(36756003)(478600001)(2616005)(6512007)(26005)(186003)(6486002)(53546011)(5660300002)(8936002)(7416002)(41300700001)(6666004)(316002)(66556008)(66476007)(4744005)(66946007)(8676002)(4326008)(38100700002)(82960400001)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWFybG9mVDB0SHZsVVRZdlU5dGZEMHpFSVdaZFBxK2FGQ21DZFhyNTJJalpa?=
 =?utf-8?B?Mi9tTE5rUFM4NmdkWTVXOTlMMkE5QVZ5RVJsK1I1TC9pVzgvYkh4cVl4YjBr?=
 =?utf-8?B?ZnlYK1ZFT3NaRWdaYVprUGZZVk5ybHovWDR5QW9BdVB4LzJ1MnV5RmtnOVlE?=
 =?utf-8?B?OFhYS0Y2eUhCWkdva1ZoeGlmVGVScEpMMmQ0dEZ3ak5LNnFlU2ovWXF4eWlB?=
 =?utf-8?B?YVhvUUNqOEw2OWFJZ1RGbWlJdmgzRkZYSU9TOHdYVlhHaVpLR092WnhEb2pa?=
 =?utf-8?B?anJQcFl3TDR3bmp1N1Erdnk3bHVQN2xPVTVuSm9hUlNvbEtwTjRhcjVnSG50?=
 =?utf-8?B?MGlZZG5TWlo3K0VsUEp0U0lselZJV1lDT3lvaFcxdGVLWXhsaEd2Q0F6SW9V?=
 =?utf-8?B?cUl5WU1LaXFlRUZ4S3N4dTUzMUFScjlmeWs1cHUrZTdlVHR5enM3L0lSdXpl?=
 =?utf-8?B?a0owMm1LbitCaU40UysvdjN3Z0tMWUtMb0c4TzJNc0wzcGRHTkVxWnFlT21B?=
 =?utf-8?B?Sm5WOGxjcjdpMUVuYXBSOStHUm41VXArSXVsSkN6KzU2R0ZTSHVjQkVGd2xl?=
 =?utf-8?B?VENJbXVMNHk3Rm5mdHRYdVVmOVNuOTE0ZE9hTkQxTkcwSkNqNHc5UzhYNTBS?=
 =?utf-8?B?ZWpSazhIckNHa2RTWXl1bFRtbG1vMFNNc24zS2ZkcnI0NUl4elhiZFhEWEJn?=
 =?utf-8?B?M3BKcjlqYlVCaDB4aDdrVTgwbUNKRXVjN3pIcWhDVGdXenlSdmswQkFWblVS?=
 =?utf-8?B?RHM3VXhCRktRZ0Ztd1lUQ08zcU1BbGJSYytBRE01cFA1c2l0QkhzNUZ0cTJE?=
 =?utf-8?B?YkllZkhjWmtZMk9zdVAxVEVJRk1wa2Nac1NkVURiVUwzZzFEWXdYMHdBUlBz?=
 =?utf-8?B?V21mTGdkcTVXS2NDUUQ4OEFFTnZJY0IybmE0cDZUQ0VidEl3U3hwSGNqNnVH?=
 =?utf-8?B?dWpnNUdFazZGNExORFZDaFArdlVuSG1WY0xHejZPdlJYQjlZeURtTXE2YzNO?=
 =?utf-8?B?U3NDcEkySUY0WU9WM2wrWDgwTk1BMGhBcE5xSWtzTDYyaEprbFM1UHYrSWFZ?=
 =?utf-8?B?YUpyQTExa2NQTlRzbXIwUlQ1ZnBSd2F4ZWFDYXJ0clNRNzlZNUh5M0pyWHVB?=
 =?utf-8?B?djM2N0Q4SkZCWE5nMldvcEdpenROR3FyU1VHYmdVOThKclFrREFHaSt0ZERh?=
 =?utf-8?B?QlFMRkoxQVNINDZ4ODZOTFoyVDgwWkZON3dSQUo0dnRRZ2VFQzZmOHJpT2lp?=
 =?utf-8?B?WThBN25lL2V0c25qSUF4cWU2YUdCMFFubk9zOFEzUWpORTY4d1lKMTBqQStP?=
 =?utf-8?B?SlZqK1E5dXhneVNPWGJzNE4yLzVDQmVBN1hWNlRxSnBFTGxEVHZYS3Q2c3E4?=
 =?utf-8?B?OElDUFFKZ1RXalFXZDBUY3BIbWVmdW52SmxyMWNVTGZpOTRTQTd2RHROdTFU?=
 =?utf-8?B?YXd5eDlZSlBTSnFkNW16MlZrOFpiemZvSTNScW9HY0c1RGdVYmdXS3dMbVZL?=
 =?utf-8?B?THZabzRpR0NNbDAxTGUyK2ppbGdzN3V4UmF3RG5oZTJXcUhNZjMrcGpmdHYx?=
 =?utf-8?B?NUxaYXBkYjZuRzBRVE45VXlRQ0k3SEFveitzbEVkYVhxclNnM3RSazZYT044?=
 =?utf-8?B?dEVkbDZoMitFcXZYS3FPaHBRNCsxUVVoa3FBVHZHL291NStRd2xkeEU5NU52?=
 =?utf-8?B?Z0paNGt6a1FkQzlWNFV3UnZLRU05SjVmS3QreGZ1WlpZVGpua3lrdmlkOGM2?=
 =?utf-8?B?ZGNwYnd4Tk9DZzlIdEt2MTFyVFhZcy9jSEJlK0N6SzNadkRZVHlwMFFiVllR?=
 =?utf-8?B?YjAreDdFdzJ0Uk41aEF5ZlU0V0FUbmlXRXUyb2RwaTBsa3R1ZkphZHBiY25i?=
 =?utf-8?B?UEw2d0VmV2hTMFovRFg5c3dRWGYvY0NoazluQUpwSE9EbHdLRVZRUnovL2Ur?=
 =?utf-8?B?Q2xPbVdXTGxTRGFGNE1wZjluNlZucVYyTFZUSHBKNWh1Nm4vYWNQZXZPdGZ5?=
 =?utf-8?B?eGVkenRUcXFQejg0SEVjQzFrOWlXZjRmRHNuOWVKVDNLNVhreEZQNEpqQWJD?=
 =?utf-8?B?aUxkcUhmcU13VTluVnZqalRvb2l3bnpoVWZlb0o1ekRLV1JxZDNJZmJkTU9I?=
 =?utf-8?B?aW01eUcvNkxIeHhmSnpLNEVqUHZCMHphdkkzU25UNEsxL3pMajlEeGpmY0Jl?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c14fa2-1024-40d9-17dc-08db0f7c512a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 17:44:41.7318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jofk9IfRPInN9mKYuJ7YtjYHOir/wrDZCHAiQICpc9lqRCanM5wmvdRRS8U36aDv/NVuAGwzO/kd1foAFMhBnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5888
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



On 2/15/2023 8:58 AM, Dave Hansen wrote:
> On 2/14/23 15:44, Jithu Joseph wrote:
...
> 
>> +static void ifs_array_test_core(int cpu, struct device *dev)
>> +{
>> +	union ifs_array activate, status = {0};
> 
> So, 'status' here is initialized to 0.  But, 'activate'... hmmm
> 
> Here's 1 of the 4 fields getting initialized:
> 
>> +	activate.array_bitmask = ~0U;
>> +	timeout = jiffies + HZ / 2;
>> +
>> +	do {
>> +		if (time_after(jiffies, timeout)) {
>> +			timed_out = true;
>> +			break;
>> +		}
>> +
>> +		msrvals[0] = activate.data;
> 
> and then the *WHOLE* union is read here.  What *is* the uninitialized
> member behavior of a bitfield?  I actually haven't the foggiest idea
> since I never use them.  Is there some subtly C voodoo that initializes
> the other 3 fields?

Thanks for pointing the mistake Dave. I see the bug w.r.t not initializing activate to
zero.

Thanks Dave for the proposed patch . Let me get back after taking a detailed look

Jithu
