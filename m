Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F5967A02B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjAXRao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjAXRal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:30:41 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B69B49411;
        Tue, 24 Jan 2023 09:30:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNWxMSKVjtnyVfBpd9ErkEQYs3f7ES2pRrabVGAE0EVsvIrhvNfrDeeIJwWqH1mdcS719eRE7m5O8Hg99wwTCTOa/lc174+AFpjeyLYs05VXdih69M4XdIgli7qBTVjPLy34vcphufXvlb3nplKlo6BYAu2bRiu5eyojBA/6G16igDWe+4KI5REc+x7kgzfpzwZnkzN/aaq437G8881+kJeYVjO9tNrVFA5yt+qjcnFEyhP0Ys/cN8owhlH5Mmm9Vd7+NA3dGU6S26f36dE/x2q3F3x8gbuQDtCFN6isVE/mx63PexlOufOCEQAI+IW5L7j9zwGT7FYIfCWfp586Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p67DC0kOZDRcI2ojCMWghYseFe7ALBJJrsqCdf7BoFs=;
 b=FLozAOmNoDgOe0rCMWL+RcjqMLtKiFVtz4bz/iu25tFzIf+F8jP9+pDypzWNGsVZXNAahJKBt0dYB4Mzm89VOcTHp2lfptKKlzmeRqeMRX/d9ddGEw63UWPVmFcyBHpPD1GOhYuY5k6Nv7hMQCEPP8/4MgDQo+rHOLWBSxve2HODSA84KGk6qglUNvuD6msAWrsZt3ysYxCwN4frklgyQcn0dcBEP68BARLT5WdK5nPg1IJOiamJ3s9twfyegxhcvnulfdRTJI3b9NSCu9r9dIfoZ201egKG1RG3SLpr81hQ+XeJEtQWfph98aMr8h80mpEy9/plxk9o4bdmto6wDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p67DC0kOZDRcI2ojCMWghYseFe7ALBJJrsqCdf7BoFs=;
 b=u/itdHUvj7OMdZszb8MT8cC1gWscTwgj9VB5KrQwIYzXCVpovlRkN4b+uR+MrSuNF0dH1VFq7ALUfnajRsU7/r6VHGlCwBQlHe01SrcU7L61FXfEqNZKXoDChiDoX5JIGoQREqgBbQdl1gewVgq9F7mgBbue9si+RZjn0VolcbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 17:30:37 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%9]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 17:30:37 +0000
Message-ID: <12f98b80-38ce-5912-fa10-33d6b8a2fa81@amd.com>
Date:   Tue, 24 Jan 2023 11:30:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20230109164405.569714-5-babu.moger@amd.com>
 <Y7xjxUj+KnOEJssZ@zn.tnic> <5afd0a7c-3fbe-dfea-f1b4-2fc35fbb4f13@amd.com>
 <Y7yCCNANVBnOOmxM@zn.tnic>
 <SJ1PR11MB608321F26D729A082BFC6FAEFCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ecf0abf0-59fe-3898-762c-d9d883925550@amd.com> <Y7yMbQ8hI9MGl1w3@zn.tnic>
 <MW3PR12MB455384130AF0BDE3AF88BCF095FE9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <Y8/CSrU8Bo298VzO@zn.tnic> <72cdefc5-1601-5c43-9ea4-4b637f5fafa5@amd.com>
 <Y8/07cV+t0PrqWX9@zn.tnic> <4ac38b77-77aa-f2c0-36e4-5e482013091d@amd.com>
 <1e662209-93d7-2247-4212-8c78748c69bd@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <1e662209-93d7-2247-4212-8c78748c69bd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR19CA0024.namprd19.prod.outlook.com
 (2603:10b6:610:4d::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: 41bac11d-d06f-44e2-6d33-08dafe30b48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8KbdBvt4Z0msQLhSLUEhNWKvxg8ZreEuW9ssz3pONdIEuQlEOlAyNIJeqm5z0RaIKlS0XMKD5CifK10/oth9fNj+yzq3MBkRc9ld2061AJ4aqAX/s8D5PhoaB3treyMBtdQGd5qBVEKZBmGcX34qVR8u8AdXEaZVKsd4S5V1cgapcAS6HVQB72U8kHAmsV48ud+mfssDmbIaq++U+pGrf/u6Qn6E9KaHhWponwagKpcwqFQG6mrrjrtFnW8/F6jwN9POnF+mjnYDkHo1AimArUQHQz6ROL3vkuDaGeQAs56aqf4exvvsQyIhEwvioO8PXvRSGHRsaACrz7ybrocEwM8f9ew1yhaUJHwE8/9vXmIukXtInAZkOHovVJptZdAJJNsfVmufOhoBFORJlGKjqdidHAmwYnzwOlRP031qO0EjpD2ojpadEJNpQ4cfVXUrmViRdCmxL/i6kU5Fw/lvZdPKtx++i3Jb55hHV0NHHK2wsW/04/Aay0pNHdgnq/swotWy+Smd7GAkq1uwCYvYFHoN/bbZddvvT+nrQJIKhue/TWrGYxtE81aRxmRIEw6U20G6oJiBLwDwSumGImTk3RzkPujMl52RpZYFsu9R12n0KsggprXytEIfYsQwTO1zydHUZ6zrLDcM5nCIn3lOGgBfTVsDKeSV74n2BSL6r2njyByctI8tVebDSYuztU+H4pyI4cDtE9uQbKOO74U7G6JrM/SRqk516kxWUgtw8aA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(31696002)(36756003)(3450700001)(41300700001)(86362001)(7416002)(5660300002)(8936002)(7406005)(4326008)(2906002)(38100700002)(83380400001)(110136005)(478600001)(6486002)(31686004)(66946007)(53546011)(26005)(6512007)(6506007)(8676002)(186003)(316002)(6666004)(54906003)(2616005)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkJHNGRVK3VtdlR6T3ZNS09iU3FYTTJjQVVKV2x2aUk5Y3Njc0VvRlkvNnhT?=
 =?utf-8?B?bkI3N0NISUhYY3ptNFhUODBVUWpVNm41VUJYellLUTFET0FOaU5UTGZlbmha?=
 =?utf-8?B?ckpQeGRFZE03MkNRUGUvc0YzUUovTm9JT1F2K3ArVC9ya1FjaUpuSjNPbGor?=
 =?utf-8?B?aytlY3dKZDN5ZDRodnVubWRubTAvdzZhTEU4TUdvWmFub1VJSGNndUVHdjh2?=
 =?utf-8?B?VlRVR0JhVmNNQld0bUQzWkJDSTZSQmI2aUdaWkZwekkvQnVuWW0zNzZxU2lt?=
 =?utf-8?B?OEh5TCtWU2hJTmJYK1Z2cEZJenhkZWcydnl2MHRuQWdkNjJlbnNSSmJXZzg5?=
 =?utf-8?B?RTJCZHZ6YkxqOVBnbS8rSEtTUjBRNzNIcUlOVndVRGsvR05OL01lNlJVT0kw?=
 =?utf-8?B?NGNaemVudTJva0VPcThOMXJzV0UzcWdsOVlZd0JYWC96RkQxYTYxZG9PTjZo?=
 =?utf-8?B?NnphS3AvS3ZKNmdWRk5HVWYra29ma1hiM0hsbGpnZ2MzTS9YdHdCRE1HcFhR?=
 =?utf-8?B?bmFuZTZvUkk2dEI2RzhNSjYxYmpTRVVNWWJ4aWxuMEJub3NWVDExb1Mzb0hr?=
 =?utf-8?B?SVZGYmNFdmV6bWRmVHFac2NpRk8vVEcxSTNHbXpPN29PRkltdm44K3h0UjhF?=
 =?utf-8?B?aE1CRUZNN0JkV3B3dDBQUUtQL2NUc1N6OCtWeFdoU3Z6NWRpSGcyd1hPeUpj?=
 =?utf-8?B?dU4wbFFyTGFkOEs3ekpBNFZicThXTFpJQ0lCc2plL0dHN1lYbDhYV2ZlNERx?=
 =?utf-8?B?eXordW1jS05JcG5wOWhncDBJV0NWRHl6QkFpVEpJMVRxRjBWeERNYUZKcm1M?=
 =?utf-8?B?eHdHa0tDOGRHNHhNcEhmSjZrcVBqTzRxQjJ6TmVVSmdGczdWbDZrb094aEVq?=
 =?utf-8?B?SkEycjhsOVllTDRBYzRQMThDSlJVc3ZDZElHTE1NNFpUUGI0aHhhcEt5WnJw?=
 =?utf-8?B?UzVBSnEybWgyZHNYYWhWTDFrN0E2ZHZxdXhIK0NIZzlOaHpwTzlGcm9Kc1V2?=
 =?utf-8?B?bjVaaGZ1VzJVL3BDSmtvL3IyT0ZLUzA3c3lXNExvY1F3OGxPQTduenRGbnlz?=
 =?utf-8?B?SmdWeDhVZm9FUHZMYzJydTBRVmt0YzRmeW1DREtDbHFicjA0TlMxNkkwS1Rx?=
 =?utf-8?B?aXE3VEpWRWsxeXVQSElubHM3UzhLTm44SlNjK25JN2s1UmZqczBQQXoxMnAy?=
 =?utf-8?B?TkxFanB0WVNhMXhHQjlyNnpHSCtwOUZteGUwalI4dmdyOU9jdWlQbDdkdHE3?=
 =?utf-8?B?alpZVHl2SE52M05IWngxbmhiWDQxdTZBL2NTUjBJSWt0RXJQeWtmRzJ2dDNC?=
 =?utf-8?B?akJqZFp0aTBsekhmZVdYcWQvR3N0emtkNlVJMndNR2RkdHhFRjdMMVdoNk1X?=
 =?utf-8?B?WkxsL0VmaVFyWVFBYlBVQ3dyY2VCRi91WmpMclQ3bDY3Ky9NajhrdGpKNXFs?=
 =?utf-8?B?d291ZWNpVFlOc2tSYXpmSldrMXBxL3Z1eGgydHBPZzFzVWZCdnFqSTdtYXJE?=
 =?utf-8?B?cVpRa0laNlZaUUd0NzE4aWY5T1c0bWZKOWJYcm9OSjVhWW9WTFVoWlVucXI5?=
 =?utf-8?B?TDBaYzhoYjcvUGpQWW5XN1kzVDRLOXVtWkdSOE9TTmhjTU9kRXpMd3dDanhz?=
 =?utf-8?B?bjZhY3RmYy9qNFNDTHJveit0NjhmODVaajMvZzBWZ3B2Y2lEK21LVHBRTlho?=
 =?utf-8?B?ZFZoQlNYNUdZWDh6WTBRSXlVUlU1djAwTTVWek45NjkxTjRhWkhBVkQxeWRO?=
 =?utf-8?B?ZlRYaExydkF5WGtMTzFWOG1FNG5CQ3o3cTF5ZWkyWFNVS1NjSlNLZE1YT2ts?=
 =?utf-8?B?Q3AwL1BVUWMyMmliZytueDFhcFVVOGdGeXdSTFBYUzUrRHh6Z1VWa1hibG5G?=
 =?utf-8?B?U2M2Nkp2Y3BHUVA0YWcxdEU4VjkySlE5VmFFckYxREM5V1l4SFVuOENwUmt6?=
 =?utf-8?B?WnZNZ0Z5dDF5N3NML2p6YXBDeXVrSDhtV1Y4dkJTNVBSZ2ZidDhoSSs0akh1?=
 =?utf-8?B?R1ZjOElTZHJQYmF4NUdDYWdjWXFYOEY5blhHMlVhSmlqTCt4NkNtREY2MlVY?=
 =?utf-8?B?RlJTZTl2ZnhEU01BUUJLVmgveVVVQVVud2ovb256cjd4RkUxOW83dVhPSFli?=
 =?utf-8?Q?hd/ejwWZ8UEFbouB4PBm2hEYa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bac11d-d06f-44e2-6d33-08dafe30b48f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 17:30:36.9561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5noZRDXLcneUXnvowoaxGJbkRldxqEDa3D49DcbZYI5zYbKHhp1Iz1NVPNCl1rzx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/24/23 10:59, Reinette Chatre wrote:
> Hi Babu,
>
> On 1/24/2023 8:06 AM, Moger, Babu wrote:
>> On 1/24/23 09:10, Borislav Petkov wrote:
>>> On Tue, Jan 24, 2023 at 08:11:21AM -0600, Moger, Babu wrote:
>>>> Understood. I am planning to add resctrl feature list inside
>>>> /sys/fs/resctrl/info/ in my next series.
>>> Maybe I wasn't as clear as I hoped for:
>>>
>>> so you have a couple of flags in /proc/cpuinfo which are actively being used by
>>> tools.
>> Those flags will be there. Not planning to remove them.
>>> Why would you want to move the flags somewhere else and do the extra work for no
>>> apparent reason?
>> With this series(v12) we have added two new cpuid features(SMBA and BMEC).
>>
>> But these features are not visible in /proc/cpuinfo. Planning to add them
>> in /sys/fs/resctrl/info.
>>
>> So, users can see them here. 
> Could you please elaborate what you are planning to do? 

Yes. It is sort of available. But, I wanted to add them explicit using the
already available function rdt_cpu_has().

Something like.

#cat /sys/fs/resctrl/info/features

 cmt, mbmtotal, mbmlocal, l3cat, mba, smba, bmec


Some of these features can be disabled using boot parameter options. So,
this will show only the features which enabled. 

Thanks

Babu

>
> Existence and support for SMBA and BMEC is already visible to user space
> in your current series:
> * On a system that supports SMBA with the needed kernel support users will
>   find the /sys/fs/resctrl/info/SMBA directory with enumerated properties
>   as well as SMBA within the schemata file.
> * On a system that supports BMEC with the needed kernel support users will
>   find the relevant files listed within /sys/fs/resctrl/info/L3_MON/mon_features.
>
> Reinette

-- 
Thanks
Babu Moger

