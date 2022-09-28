Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583325EE03C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiI1PZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbiI1PYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:24:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E5CCBADC;
        Wed, 28 Sep 2022 08:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCgeGzpwUM5JH9DXTWR9qZzYyHreMQ8pLcOFm9Ew9f6nVVBoWMJWq8RLYzyCieNFfXVEa33exa6cEsCJ8X7iog+jYGtahb6eCLTR7ucl322HVzCxLoCC4dz5NsvrxbpdWHrJAAl3TY7BGnpNyaUxPAEcinu0oWmEbhKnPTTkLnvdT9Dbzd9M9qxG28DA5i5zzQyUTS7y7H7eQOUdwJM4Ul4IwyA1Toa9BZ10HtkYtGhVGe0b4TOZaZd6pPzdoxxxcQF8x1cjbtthcAdmelgWWV6QQr04j5J6ESRkbxD2I94CWJz30piD2pIlJQkYRmRcj3kZir1+lgZj3wymLBn0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeWEIaOqrpSqRh3N2V81M4jCG/KRvDHupubxLVfpyNw=;
 b=NzL9FL2r6UDPXU2Uiq/0+cyGvRrJ+bhE7UOouPNPJJA70IuUBUY5ZHlNOCVEvMgX4jaWna2JAo2noMWVSOqK1IUzyefi+1Lby45SAr0ccKSDWSha2MUacXrQE0RPP4hOaKwXvngj5vEPD+igJSv+uiY3jDjlgPkkT9D8+/zRk+82N+sZYLUp+oiA8ybBptH9tcloPdCfRSZN1mEvhLS7cY6lxrPdIu69B+O4gC4zoa/jNxMmbMzzHDZxgdChaVISaPckGNeMqubQpQq+nCuj8oCbWfQU0nTZ7q4mOgDp2zhbn/lKQVB7QqmUECxul6WQDCcGneBZffgX4MWQIjwqQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeWEIaOqrpSqRh3N2V81M4jCG/KRvDHupubxLVfpyNw=;
 b=Ul3f8i/Ka9xsCnwqTpMgbrjEIOIFbTpqNRL9TZTu1Zoa6FS2QOosks3nYg9M/dDVrjEOMX9e1avlX07AHN7/1aXnNNES5QLttjBg4HmF8nkrI7lQ4oYedA9KSq/VFHqsmQ2tbOYSkE3gmdwLOjK3yTTcP+enTHW7woP64Cqsf+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 15:23:35 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e%3]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 15:23:35 +0000
Message-ID: <99bfbeac-1454-a453-a2ef-36eee2aea34c@amd.com>
Date:   Wed, 28 Sep 2022 10:23:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 12/12] Documentation/x86: Update resctrl_ui.rst for new
 features
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431042060.373387.8454967155095795574.stgit@bmoger-ubuntu>
 <YzPMorJQFKPY+n4d@debian.me>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <YzPMorJQFKPY+n4d@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:208:2be::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 94be0cb2-2947-44d5-dcd7-08daa165691c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05wAqNPWyVvP9ZusbSylrakQmBMYVTjVZeXIsYPMk3PrmSWPMNqvhSeL/gQeCVOZtGJIaYWAO5d0ZpF3DV9OYkw+hhDTr7SIOrsOBzIeLs4RcAwMZKRfqAzr/NwWNBN4jIB6czdvGh8clJlN4X25IABJCtfgXvQwz+ZOJmkdp2KRyllZpK5G7olXxTm7oszk15vXb5f5BgdvFOJC6wxmsUlSnJjCl0sIn1Y7j35C6wKMU776d0LYUdygccJWyPm8k0rkllzCtA7OrAw2JBGoF5LP/w9dzBUWTY9sZiz9fDV2OWYeOpaDrjcTG9789+KZpOhlm1w6cOHe/zvkrhSXJA5PIVmBohflUTmdpNHI/PFwue8D2ZwFnxkkhepDufjZhAF/AJmDQTp7pKZ++FzbRkD2yM0qUbN44EP6b1LFWVdDenbCEKWW8cU7q1I+8+YRshURgcz/g6mZPoxSYFnSdMGpYUf/C4pXzE/12/w4wAHzAQHs8gKF0iaY0HAEJND1kBdd05/Ss5CfMIjeURZBqJ8RxL5OPjLHso2+bYZ7+ePzJUOzgtYDVG92KKJMHiUaI9kaPV9E0Hrg+OPPFF8M3vlXVGMF5jY2tiff+/thN6wM/JBsD92q90HMN7twhytK1LHrmE13AP6EysYTgBtK7KgZS57JqZEhxYazBLsUj7mH4LIrBP02SHF0VA0dQRCVFDH9MiTMeN9MjhFnTjqhkBJHryu5A3ggV9JtYmEN0NEcmYXExHtVlx1TK8xx8vosYicBYf2ssNjid3uy3xoZw13DYzoGFiM0IwdIsQo+n0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(2906002)(26005)(6512007)(31686004)(6506007)(6666004)(8936002)(7416002)(3450700001)(53546011)(41300700001)(186003)(316002)(66946007)(4326008)(8676002)(66476007)(66556008)(5660300002)(38100700002)(6916009)(83380400001)(478600001)(86362001)(36756003)(31696002)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHA5QXNycTBQNGhHU0VwVldGZlFoVThPUTZDT2JUQnAvZ3F0WkVjRzBBdlZa?=
 =?utf-8?B?QkxrRmlzcXU2YkFZQXZhc3IxTTV1bmlKaG9kSzRoZHZxZW9LRysrY0xIdmtx?=
 =?utf-8?B?VnRwaFdjTVF6MkljN3FXU2Zra1JTMDFoL3ZPVVQvZ2dBS01LUW5UWjJ4VzZX?=
 =?utf-8?B?VjZNNUJ6cG1BZFRncWMyLzVMVFMwdjBVSGEwYWtHeHI4V1lBVm1kWERjYTZ4?=
 =?utf-8?B?dlREdzQ3c2M5ajh2SThrbUREbSt6R2VUTFdEeEZ5MTMzZkExNDhTUFp3cDEr?=
 =?utf-8?B?aHc5dHJWcThkL3FNN1ZFS3RwUzJoS3duT0Zic2Y0R1g3OVRUVWVleUlzak4x?=
 =?utf-8?B?SFpNcTRhdmZUMWpmUmFNQURzZmhrNVRIYmRWbnFDMk94U2hVZy9UVnhXc25i?=
 =?utf-8?B?ZU5lWHJEalBDcG1VZXl0YnRuLzVnMzhBazRxU3o0cENjOXZqK0o4cjhjYnF1?=
 =?utf-8?B?TkxkYmwrOU5Pei95WnU4MGtyTmJjc0xhMXk0b1pHd2NBTDkrVXVjMlJMRkFI?=
 =?utf-8?B?aU5SSXZUZkhxODFyZ3MvVjFBV3pEMnhRbW10U3paZWpLL052d3F4SmhnS1FB?=
 =?utf-8?B?U1NwZTVsV1lQSFdlNHRNOXhTaVBFRUJzZUtKR0dRaTMyYmtGOUdraDdycGw1?=
 =?utf-8?B?VllmcHJScmJBbnlSdHF6SndTQ0QyQnhqS0l0ZnExSTNXSVF6QU54dFcxTnJ6?=
 =?utf-8?B?cUd3Q3F0NGNJOTNHUlM5ckJSb1U1TGROcmEvSXZYSGswRzA2ZDlMbUE5VXBH?=
 =?utf-8?B?WHoxdGxVdEh1dlByT2wyUEFHQmRtVW5yUDd0dENXWWcveHBNb3ZqS3dwZHRL?=
 =?utf-8?B?TDUyTnk2amdwbzNWMmxmckprVmNvUWJZRWhJR1FSajJpbDNINjB4UTZRbUpX?=
 =?utf-8?B?bXdtbUxkUGNVMjFMcFBBb1lzVW5IWkY5UU4yT3lmM01MbTFFQ3J6RFdpV1B3?=
 =?utf-8?B?LzFoM0tlOEdiZVNTazE2aUgwYjlOOUtDNlhidFJoZGZsUFd6aHQ4UmE5Tnhu?=
 =?utf-8?B?VkQ3MTRwTXNoVTJBaFd6ZmpkOGo3eXk5Mkt3L0FqWkJ2dUpPYjBZWFFzQjZl?=
 =?utf-8?B?VG84QVRWNFFpSHcwOTRzT0lKY3QxWFRpOUNsa2Yyc1R6c1ZYY2wvR3pjcmNU?=
 =?utf-8?B?U1NRVGVIVEJ6NzE1Zms0a1I4N1c4Q1BpOHpmd1VKTENkbDdDY0I2bjFicXFX?=
 =?utf-8?B?TjcwUHgycmdnNjZLN1pRWGV2NWRmM1Vmc3d5S1dJQ0JmVUptSld2VDVQeG9L?=
 =?utf-8?B?dHN1Vm1mRDZNQnY2QzZEQWJmeVZXalpKVy9qSVF1YUQ0aDA4TGRoM0NlQXlj?=
 =?utf-8?B?eDlSYUNwTjNHYVFRdXFWMEVJdnRoMVVRN2ttMWM2bS9yV0JxdXU4TDRYZi85?=
 =?utf-8?B?cFdzdkFIUjY4N3FnelQzM1kreWxrbUs4MnZ2YXFlMlR0dmRRekJkbkVZL2J4?=
 =?utf-8?B?WE5jS1NiY29aM0hWOEx2eUo3SU80MThqamQwNWxVeUptUFJ4Y05nOFlLMDNH?=
 =?utf-8?B?OHg5OVhSYTlkOWlKZXJxWUhVSGoxN3c1YXNPRDVnQmsrUVVBSUJGTUlibE0z?=
 =?utf-8?B?VTFtY0dWM1dTeVpoMW1IUU54eUJmVWNTandlWXZTUFU5MlZsTzh6YjlmSXRw?=
 =?utf-8?B?T1pCNW12Smh5TGx1WHp4cVJqdEoyb3B5andSSFVoYnVhTHI2R2xCQzdKeGNE?=
 =?utf-8?B?S0pLRzRVMDB2TmVHMWxnZVVWblJNT3FXcGRkWG9tS2dIQXhXYmcvWUkybUh0?=
 =?utf-8?B?Mm9ta0lkSnhjanVCOU9TOWRma04zM2hNUTQyK0xyb1hiYkZ3ZXJ1b2o0eXBK?=
 =?utf-8?B?OWh3L2plVW0raTlWdWNQdU1CR2s3Z3Arb3Y0cmdiODNxUjhjbTlONy9GL1R6?=
 =?utf-8?B?SnNsdUZ6Qm50M3I3bDVaM1BzU3Y2NnFoRWsveE1aZjg4aGswMmRIWHZOREpv?=
 =?utf-8?B?WjRVWFJLbERWNXpSYjhVZld4eXlXeEYzTHQ4NW9DRVNFS0R3d1Z1OHp0TmRK?=
 =?utf-8?B?WDZ1a0p5VDBGUm9FcDFoZlB6RGJCSG9NekFrOXUxYlJvSDRwakQ3bUt2dWEw?=
 =?utf-8?B?c3NTdzFEZG04ejhna0ttd1ltT3NPZGpIa0IxS0xoQzQweGlOSkRLM2k4ZzNr?=
 =?utf-8?Q?MvKnlva3PCgoC4nWkYYTV90Cx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94be0cb2-2947-44d5-dcd7-08daa165691c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 15:23:35.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fanooIKYOmj6uOYYcbLDnj3ROUeBEQ4KTiHK95b3eXWpdxfgxD/h+dVviMWJapkC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sanjaya,


On 9/27/22 23:25, Bagas Sanjaya wrote:
> On Tue, Sep 27, 2022 at 03:27:00PM -0500, Babu Moger wrote:
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
>> +        Example::
>> +
>> +            To view the current configuration, run the command.
>> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
>> +            0:0x7f;1:0x7f;2:0x7f;3:0x7f
>> +
>> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
>> +            0:0x15;1:0x15;3:0x15;4:0x15
>> +
>> +            To change the mbm_total_bytes to count only reads on domain 0,
>> +            run the command. The bits 0,1,4 and 5 needs to set.
>> +
>> +            # echo  "0:0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_config
>> +
>> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
>> +            0:0x33;1:0x7f;2:0x7f;3:0x7f
>> +
>> +            To change the mbm_local_bytes to count all the slow memory reads on
>> +            domain 1, run the command. The bits 4 and 5 needs to set.
>> +
>> +            # echo  "1:0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_config
>> +
>> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
>> +            0:0x15;1:0x30;3:0x15;4:0x15
>>  
> Hi Babu,
>
> The description text for each snippets above shouldn't in the code
> block. Also, split the block into three code blocks in the lists:
Did you mean, I need to remove similar texts from code?
>
> ---- >8 ----
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index b4fe54f219b6f3..ec578b069276ce 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -206,25 +206,26 @@ with the following files:
>          all the event types and the mbm_local_bytes configuration is set to
>          0x15 to count all the local memory events.
>  
> -        Example::
> +        Examples:
> +
> +        * To view the current configuration::
>  
> -            To view the current configuration, run the command.
>              # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
>              0:0x7f;1:0x7f;2:0x7f;3:0x7f
>  
>              # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
>              0:0x15;1:0x15;3:0x15;4:0x15
>  
> -            To change the mbm_total_bytes to count only reads on domain 0,
> -            run the command. The bits 0,1,4 and 5 needs to set.
> +        * To change the mbm_total_bytes to count only reads on domain 0
> +          (the bits 0, 1, 4 and 5 needs to be set)::
>  
>              # echo  "0:0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_config
>  
>              # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
>              0:0x33;1:0x7f;2:0x7f;3:0x7f
>  
> -            To change the mbm_local_bytes to count all the slow memory reads on
> -            domain 1, run the command. The bits 4 and 5 needs to set.
> +        * To change the mbm_local_bytes to count all the slow memory reads on
> +          domain 1 (the bits 4 and 5 needs to be set)::
>  
>              # echo  "1:0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_config
>  

Thanks for the diff. I cannot get this right for some reason. I will
probably send the diff before the final series.


>
> Also, there isn't description of mapping from bits from the supported events
> table to the bytes input for mbm_{total,local}_config.

It is already there. Is that not clear?

+        Following are the types of events supported:
+
+        ====    ========================================================
+        Bits    Description
+        ====    ========================================================
+        6       Dirty Victims from the QOS domain to all types of memory
+        5       Reads to slow memory in the non-local NUMA domain
+        4       Reads to slow memory in the local NUMA domain
+        3       Non-temporal writes to non-local NUMA domain
+        2       Non-temporal writes to local NUMA domain
+        1       Reads to memory in the non-local NUMA domain
+        0       Reads to memory in the local NUMA domain
+        ====    ========================================================


>
>> +Slow Memory b/w domain is L3 cache.
>> +::
>> +
>> +	SMBA:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
>> +
> What b/w stands for in the context above?
b/w is bandwidth. I will correct it.
>
>>  Reading/writing the schemata file
>>  ---------------------------------
>>  Reading the schemata file will show the state of all resources
>> @@ -479,6 +567,44 @@ which you wish to change.  E.g.
>>    L3DATA:0=fffff;1=fffff;2=3c0;3=fffff
>>    L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
>>  
>> +Reading/writing the schemata file (on AMD systems)
>> +--------------------------------------------------
>> +Reading the schemata file will show the state of all resources
>> +on all domains. When writing the memory bandwidth allocation you
>> +only need to specify those values in an absolute number expressed
>> +in 1/8 GB/s increments. To allocate bandwidth limit of 2GB, you
>> +need to specify the value 16 (16 * 1/8 = 2).  E.g.
>> <snipped>...
>> +Reading the schemata file will show the state of all resources
>> +on all domains. When writing the memory bandwidth allocation you
>> +only need to specify those values in an absolute number expressed
>> +in 1/8 GB/s increments. To allocate bandwidth limit of 8GB, you
>> +need to specify the value 64 (64 * 1/8 = 8).  E.g.
> s/E.g./For example:/

Thanks

Babu Moger


