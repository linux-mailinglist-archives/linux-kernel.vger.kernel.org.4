Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB28560E9B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiJZUAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiJZUAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:00:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7D2DE88;
        Wed, 26 Oct 2022 13:00:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHdUDwmoFmbSpjw6OITOpSkA2gFO1BRyKpyTMW9ddkWWuhNEirf+EYEeueaqeeZEVt1nmGXkNHoq5upXvhJramE7mFRL+3YT+EgVK46rWWVoC5M4OL6Rp2QV151dvac//YrI15CS7mxZ28KMFEY+zegeX2YqFB6gCcml4ITwmuTBVAkwRNUCqchNR/guTVBDc+a1WFK7gryN57jwp3BgWK6/jhIg4r3ws/Ur3vvsPR0fTcb8R3wuuZpE6af2tExw2oU8BeE0VREW18o6UprC8kpRoapUneHltNArWAsPMWNBXx47NjDBxIoh3B2WJ7rbPYgMsTDKrKtlaCR/P/NEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxO7TJ0CnbXCfHDneXzZ1AEFHkb9zouBZ7xvoE9WEY8=;
 b=Tq1bbOCnjlcB2dlb+AWz25WZw5Lygo6zuA2QcWh08G8AmOAQ5xyv7Zpxf53NE1OEUxoPTxVP/raKcs23gN1AQb4R8qVNCXcuRg1LV3fm9618nQ+xgRPe1zBY7y1y7cKttD00MbMjjK/1vIZM0KOJjzZb9XXyuNCMWIuDrlWagiMNW7Q5k4KYhGO4MPZU59TT2r+Ki6aOdl4Gdf8MIx+l1b8q/WeBVS5zu9nFi0dipQl3GtgwF2Fln5y9HOeR4iSiJVYGwM06fO6YPiFMD76wyWRe7M37m3Kb1WyLbxk1mH1ba2gQwZaoJWKk6UQmt98Dd+uwkA682ths89qB6zFsKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxO7TJ0CnbXCfHDneXzZ1AEFHkb9zouBZ7xvoE9WEY8=;
 b=PZ8ZrWBjVS0Ekv0HZwWnz/h1stW7OoyQUZ3qtqCiTtZW5UYocz/ASbuyoyEoSnrxJr46GjGrZXmld+1pEFaapm65qp10Q7emuOZJw/EgW7+aTtsn8xdkmTPQYRI2JYOxeW3dHO3pEJOjc4e3eoOgDRMurnEnRYkwiyWOBsodVos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 26 Oct
 2022 20:00:43 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b%9]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 20:00:43 +0000
Message-ID: <3d081088-fca0-796b-a9f4-dd5e8aaf48e6@amd.com>
Date:   Wed, 26 Oct 2022 15:00:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 12/12] Documentation/x86: Update resctrl.rst for new
 features
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604565437.5345.14867510739122394750.stgit@bmoger-ubuntu>
 <75059026-f5fb-59de-8f68-bb71597d55e6@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <75059026-f5fb-59de-8f68-bb71597d55e6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:208:23d::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: ffef3303-d153-4174-515e-08dab78cc35b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USDVo4Kd4/8XDdrCF99tWV1dsB9TLDqogGKN4ps1nA9TDYn/yGQ5OJIXUn4quxqQkDQZsAmy6tXOMVtfdtoXrYFRFb5nD47WMPbGfqocF4gfClccHkoh2rZoZFnEA64lWIJulwK4cma+XK3IMGN4RbeaIbibIBg/9ZSHV9ev5AAxe0pAZHYv+bbGphQnGuWCHdGh7Bvzi4sb6wvlEUccBMZIimTJ2XLBB03BUfixfhRjC+GF4IXvuE9v5hdu5p6JHhj6W7oRhbfyaMtNxjtJLh1H5MwunqNrRmNKmIg24uvm8UFiZhwaNzLJKGWzxK5Q7kvCkyYz0CZPkPpjMtxfBm6+si4Jwopy7PV0FiT2fDzeCyBpL0TqLWmTiIjS8Do5fOOksp2aAj/MNM2zTeUqj12vwZ6eXRw7MYuyE9XeI/LIwCIChrI7ZtcA155JtmroHnHrv+OT5FBY2wXK67qD53ZQ/O96xCL+7l0psbXGdd7J/mPpA9FccoS1jOGFdRjqgQ8XPLmx8i/sB5JVMnk1YO5Rywc9dZSbWN9MMfZMCD+l8R9oZ59u82d+SfYmSBwu+Xy3Os302ghixZJAp4wKHRCCp2e3BBSLlmOtjSrB5IsEkBZGVi8nyXd4IDoeAtq2cvHLqJ5VAH53yLxcLY+cWycEzLu/eGiqp+BdycU8+CjLMGB6c9IuSfjDkvE+RF++EzMRmemWzDdNLdzH25A12CEn7p3vdiU0bP335i7himGm77aASBJX5sW+tLpeerXEoj0BSxIuLrYIF4kp8pHEIFhjqksx5cByYLWD64FeyfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199015)(2906002)(31686004)(6486002)(478600001)(6666004)(36756003)(4326008)(8676002)(66946007)(66556008)(66476007)(6506007)(26005)(6512007)(53546011)(8936002)(41300700001)(5660300002)(7416002)(31696002)(38100700002)(186003)(86362001)(2616005)(3450700001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHdhT2QraDN4R3BEaU1RMkVyQmtueE5pdXNRNXNTb0NOSkdxZHljc2tMZkk3?=
 =?utf-8?B?VEk2c2Q2WkJkQ2ZWdW53WGk0M1p5M3JnSXF4ZUYrNU9UaVl1R3R3ck1Ja2Y2?=
 =?utf-8?B?THBlRUxFaWpDNGIydnI5K3JyYy9tVEtaSW9ERE51Mm4vUmNqSHE5VUxSRnhn?=
 =?utf-8?B?bnJRRVNpeFQwZVNCQUJEbE83bE1FZ2NsNVhJNlliOTA2VnpyTys4TGhMUTUr?=
 =?utf-8?B?T0JROHpkUXVhcFJDbG9CUktoYkNDV3RWaU1ULzEwVzZiUUhTN1ZsN25zOXpQ?=
 =?utf-8?B?d2ZmS2NlQmZUVGg2ek5KbWNGME1rbXJGa2lydVhQS2tNQ0FXeFJ6RzcvRU9P?=
 =?utf-8?B?TUo3anJYKzRVT2swNjVLOVZBM01wRFhBODBkSzFWbStZQUhzTzZsL2toUWcz?=
 =?utf-8?B?cHgrN3B0WG9rZStFMEZYcGhPK3NPZkhQYXM4UVowRkV2ekFUcXpHYXRIcDNo?=
 =?utf-8?B?OFVlemg0d3BhR0RVemVWRUYwK3JYcGwxbmszdm1vR2h3d1ZoMzBWTERBK2tG?=
 =?utf-8?B?bW10THFlNE5ZM3ZKQXBEeVNLTTlrbWxLZ3h4MVVvN013bUV5RnJYL1d1SVpp?=
 =?utf-8?B?dm9VUjNXQUVaSkVKdFpQVnZsditLRTE3cEdYRkFrMlNhaG9vcUhRWXR2bWVn?=
 =?utf-8?B?T0hIRXkvUW5sbml6cnZ3V3Qrdm9xNlgweTVSZE5KY28ydUtCV1NCUkw4dE1s?=
 =?utf-8?B?WnhQUmQycXZScjk5bk5yaWhYd1Z0WWljeEcwdXVLNlNmWVJuNWcvT2hGWjlS?=
 =?utf-8?B?akhQUVIwaVB2ZXFRcWIva2dXMmRYak1TZ1g2QmplSk8zOXlVTUV3S1FtaGRT?=
 =?utf-8?B?N3VjQ3ZPTUNYekhoa2xZcHd3ckNVQTNVTUh6OWRXTmU2ZjFzSzd1WVZ1UTdQ?=
 =?utf-8?B?R1J0OXFEc0FZVmtCemZCUG1vaERFTXR0SktmcWYzb1MyeWFoQjdRKytFS2pU?=
 =?utf-8?B?Q1NxRHdSZEtCazQvLzRBTFdlM2pmbGcxM1pVMW5ZNVRxVWNVL3gwbUxpQm41?=
 =?utf-8?B?cXFqREcyOUlmdTdidDZzdW9yMXNqWjRua0JLa09PVEFhWGpFUVpuRnZOOTd5?=
 =?utf-8?B?bndNT2F0dVcyWG0wZFVlQlU3THFUeHBiK3NRZHd1U2VqeU1zOGt0UDN6OXNI?=
 =?utf-8?B?NDZvYWR0UEs1RzRkMFVOU2g4aHp6ZlpNL3dHWXFEdTBtRTFFMjNGM0d4cGVY?=
 =?utf-8?B?bGx2Y3haZG1oZVhsbVJ6aXA0dCtlQ1Z5b0ZlcFpkYzJ2S0xIVFNWbVo3YU4x?=
 =?utf-8?B?cmdvMWNNRzdKQmZ6cDh1SkoxamJZMTNwY3JFdVQzanE3d0thQlNmVG9kS0tj?=
 =?utf-8?B?L1d6TmhrMCtLYSt6VXdZSEVTY3dKVTBORWhKbGxPWHUySFI2VCtqOUxXcitK?=
 =?utf-8?B?T1ZuWmxRQUFtM3dpbzlqVUdKeFJqeitwNzFaQmxqZ0VoQTlFSC9wT3NVV0JT?=
 =?utf-8?B?bmxZaUIrZGh1Vkl5SWxHSWoyU1FJZjBHZklrRzJNK1RMR2hkc09yRWw1emNX?=
 =?utf-8?B?STdqM0gweHlqVFdLUkxYckVweXRqUGxoc1Q1L3hGejljUitDTkhyTzI3TzBV?=
 =?utf-8?B?SnBsK0lJTjVJYmNyT09yejRqZDc5OHlnWUt5cndIUVRrWlRUbGhrUTh2cWEw?=
 =?utf-8?B?VnpuTHdCT2FZMlRlZFZXSHRNMzR2aEFwWDl4RmVLQkdtUmVsZzQxaUttUCs4?=
 =?utf-8?B?NjRtNXdvZ3RKQi91b1M1bURid0RESDBXci9TeEtxR0tZazAwU0J4amV0VGls?=
 =?utf-8?B?STNQdlJCWE13YnFkeXRBcUlKS2pPN20vZCtMVlY3dGNJTVhuem9VNnZSRnk1?=
 =?utf-8?B?R3JUclM4RWJHRmJkRFFZbDlVQVpHNG5aWW81cWVCeDRockxObm5oeXdOYzhY?=
 =?utf-8?B?SnFqWXNKaW5kaUJVV21OcVJpOC9Dbmh4SHhvQ3liWTdMaDdZVExIbnFYNzlm?=
 =?utf-8?B?NkFXYjZMM3ViMG1jZWZQcXVvZUNwb1ZRekttYTJERTNQTy9KWXVqdkx3M2JE?=
 =?utf-8?B?R1J1WmFKNWZoZ3VwN09Oc3psNE93UVcxZXFaWlh4bStOWHJpalhyM1Z6ZlZH?=
 =?utf-8?B?OFBXL1dWa3RZYWpVOWFtR1EzWDBKckNZYmZBcDZpc0d0Z3hEeUZ0Y1l2bnVB?=
 =?utf-8?Q?nj5sAq5GmkZ/zLCCVPFBO8wyM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffef3303-d153-4174-515e-08dab78cc35b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 20:00:42.9861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtGmqluk8in3noF++ZhsI0rPk3S/tYiSz9Qy4ScsXhLAcblUMsOLtoRrlqYRUYZw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,


On 10/25/22 18:50, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/17/2022 3:27 PM, Babu Moger wrote:
>
> ...
>
>> +"mbm_total_config", "mbm_local_config":
>> +        These files contain the current event configuration for the events
>> +        mbm_total_bytes and mbm_local_bytes, respectively, when the
>> +        Bandwidth Monitoring Event Configuration (BMEC) feature is supported.
>> +        The event configuration settings are domain specific and will affect
>> +        all the CPUs in the domain.
>> +
>> +        Following are the types of events supported:
>> +
>> +        ====    ========================================================
>> +        Bits    Description
>> +        ====    ========================================================
>> +        6       Dirty Victims from the QOS domain to all types of memory
>> +        5       Reads to slow memory in the non-local NUMA domain
>> +        4       Reads to slow memory in the local NUMA domain
>> +        3       Non-temporal writes to non-local NUMA domain
>> +        2       Non-temporal writes to local NUMA domain
>> +        1       Reads to memory in the non-local NUMA domain
>> +        0       Reads to memory in the local NUMA domain
>> +        ====    ========================================================
>> +
>> +        By default, the mbm_total_bytes configuration is set to 0x7f to count
>> +        all the event types and the mbm_local_bytes configuration is set to
>> +        0x15 to count all the local memory events.
>> +
>> +        Examples:
>> +
>> +        * To view the current configuration::
>> +          ::
>> +
>> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
>> +            0=0x7f;1=0x7f;2=0x7f;3=0x7f
>> +
>> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
>> +            0=0x15;1=0x15;3=0x15;4=0x15
>> +
>> +        * To change the mbm_total_bytes to count only reads on domain 0,
>> +          the bits 0, 1, 4 and 5 needs to be set, which is 110011b in binary
>> +          (in hexadecimal 0x33):
>> +          ::
>> +
>> +            # echo  "0=0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_config
>> +
>> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
>> +            0=0x33;1=0x7f;2=0x7f;3=0x7f
>> +
>> +        * To change the mbm_local_bytes to count all the slow memory reads
>> +          on domain 1, the bits 4 and 5 needs to be set, which is 110000b
>> +          in binary (in hexadecimal 0x30):
>> +          ::
>> +
>> +            # echo  "1=0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_config
>> +
>> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
>> +            0=0x15;1=0x30;3=0x15;4=0x15
>>  
> The code supports modifying multiple domains with one write. To help users
> understand this it may be useful to have one of these examples do so to show
> that and how it can be done.
Sure.
>
>>  "max_threshold_occupancy":
>>  		Read/write file provides the largest value (in
>> @@ -464,6 +539,26 @@ Memory bandwidth domain is L3 cache.
>>  
>>  	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
>>  
>> +Slow Memory bandwidth Allocation (SMBA)
> bandwidth -> Bandwidth?
ok
>
>> +---------------------------------------
>> +AMD hardwares support Slow Memory bandwidth Allocation (SMBA) feature.
> hardware -> hardware?
> bandwidth -> Bandwidth?

Sure. Thanks

Babu


