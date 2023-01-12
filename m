Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9F26667F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbjALAlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbjALAkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:40:35 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD5318B14;
        Wed, 11 Jan 2023 16:40:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/zc4aBqsDTOSEQOqHAwmH3Hh1rDQxC10OBa+1pJfFRXGKyrrZrjz0ElNFhRT5B1bLd2qT2Juc1KGQZo1IbT82+lwN+fnJAJ+Fao+BIRPF38sx2w1s1IOb+P15p+oTAokdfzGHMjGXXmEVp1FMRFlXbzFq9EjC8t3GTBhqUD92ksjXWjSHS0vGpTI1sDIiqy2nADhwQ41Xjr/qrnqaQqixUbvRufrRsysaimurEab8dETmjRj/16b0KMGu7wwmfUxS/oZfyM0lVkwFJwOiOjZ5vtQ0mZNmAdvDR4NFYcaD5MfPv8oQNhHeLz6WGAJCWv8xFmz7tzCOEEUtpyNCmiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14Ez5WJYeJ8GjfbMjtnUuvn7kh8NVujvKbX0UXbDDIM=;
 b=j2X73W/iRy+dzgL+qfoOOFfrLihlCvBUNtJSA71YFBvC6PBQR80NRtg5JOs1yhOOVy1064snMaZkL9Ejo5PM/prhEGNAk6p9zUOE3X+n1Bnn3uWjUnSV4y7E49QIFFhke1TPEalK5gxtEjhOXzxY30Ytic7yLJ9iv+VxyTWb9Aw4V1tj52QadVrKouxvJtI3rk0XtbYmjnvilq5Dz0DXQ3gYj34Up0lpbiDAJjP36/2ZOAfUMI/Zh6mmUZ60dHEnRwd53EU+uskcwHcRHSC/eMmUXIL0q7QwlI53W1unrPuoFReM6ubJ/vOSeEZw4sUqiUaWUgFlkhjbOiBjJIC+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14Ez5WJYeJ8GjfbMjtnUuvn7kh8NVujvKbX0UXbDDIM=;
 b=rN3d08uF7nz8Ldqgi8J7QvowJSkg6K99vCO689mQd2hP6fJVhTUyvv8VMKE+jYWKQk1jLvgnSv/5WfI8zzl/ONEqlq5rN4WmU1abyA7lefgGC5UB/nt5ydPjohDRkdBj5E6RW7i176l+7OlKTQef50tWJ/2361rdwh/M2QMGoyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 00:40:06 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%7]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 00:40:06 +0000
Message-ID: <03b78a30-97e4-07d8-5a09-44eb26b75970@amd.com>
Date:   Wed, 11 Jan 2023 18:39:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 13/13] Documentation/x86: Update resctrl.rst for new
 features
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
Cc:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
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
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-14-babu.moger@amd.com>
 <c7d563ce-13d9-ca6b-a5c9-7e08a3cdc3a9@intel.com>
 <MW3PR12MB45538E045D655C1D6B3BD02C95FC9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <812a0d4d-dfb9-d351-9c9d-01d6943cd72b@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <812a0d4d-dfb9-d351-9c9d-01d6943cd72b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:610:53::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: ea827826-9cb2-441a-9caf-08daf4358cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dves6y014Yj0HGWLrdGH6Co8lDYYzxCWg/mSGpPK+YsNbpGN6Iqt19xXnTHxrRrBl7NR+5oy0edukNAYZ0pR4Czgy2HU/VWI9A8nZLkkQMS7fn8D4SeKiC6CNiGtN/EIkm5UpqIzK4Fft9b1jZIB9VTa7ElwPLt1cXi8qUxzRrtbB50G5z2idxE3z3Mp7gYlSRzhN5u7PISx0gCBEKei6GvPlKFvmx0gHj7tta/b2gRkMS1ll9pwJ0kAF2hyzuom5vgzQ2458Up8mAMDO8ZjOyeTfm0QIeShy4VHRxB5+HM/fbrp+UmfKW91o7Ne6Zd50+4FC7hzIOUsjyY4wWvdvAHftTD/ZMW3HZu1mJFLFslZJAp0ZH4xvnBZLgt77P5RIQ5ouhycWiMBKuhtCIQyCQJHxn4aL2lTm0xXscA2qf7TFha71mmh+82uMDyFjddW6Na4D40kJKiTgLAYbg377YwLuR6fBdx7FaubX/4n8K/s5KVktNdhNRo3ldHmPW9ojpDbywCNuWy+5UtsYLy5OFTULUdETJkq3nErdQDCqBC3NNnOv+8JfME5C/BJzwZv7o7fKHkhOuda8NGq3qkCnE67wUS53nYzzVgrAAnYifnv9fCEKmteS5/c1xOBiHCXn2tER0RyUUkFwtfWv7DOn6kfXJ0WVFMehZQlwoNHhs3AJRU9R/wMmfwwbPy77LR33jbt1jvbDFIJ8+mc7NVmT0h8ATO1I7PwToH/VVTMqle8pGA2PDhgeQjNQ2ygEKA1RvPmYmkH7kzIJo+JondFW2T3Nxof6nHBtMSptfbvAJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199015)(38100700002)(83380400001)(31696002)(5660300002)(7416002)(7406005)(15650500001)(2906002)(4326008)(8676002)(66556008)(66476007)(66946007)(8936002)(41300700001)(6512007)(186003)(26005)(6666004)(6506007)(53546011)(2616005)(110136005)(54906003)(316002)(478600001)(6486002)(966005)(45080400002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmF5YU1zdGpvd0c2bWw2R0o1VVpyUkQvMDNZRGoxUGVlVjJGM1d6LzZIUVgz?=
 =?utf-8?B?cW50aHRlSjc1Szd3WXkrdFgreEJtUk9hN3hnMWhubFphdzJYOFBDdFlJdEdN?=
 =?utf-8?B?T2FRNGlOYjg0NVUxS0lscUFZU0krdU5Tb1dkZ2tDR2NZVlM4cnJ6dCtBcWsx?=
 =?utf-8?B?Y1ZYZnFvSnVNbzBkSFVMSk1oQUE3bTFUTlZWWHFqbGFqT3Q5VFhJQ1dHR0xZ?=
 =?utf-8?B?Z1NoVHY5SzM3MW52R0tmL2ZVMmZyZFhIZVI4Q1l1bGFnK1psWnhZQXlJbk5z?=
 =?utf-8?B?aWpzUXdSMEhhV3RkYXczcktEUER1OWtiN0NsOHZhOFBkaFJPYytlSFNHZW1Q?=
 =?utf-8?B?akM3RzMwOVJVZFc2dU50ZlA2Y1pnMi9wVmpxN0NzZUhFZGlWejZBUEx4UFNW?=
 =?utf-8?B?SlljTE14Z3hxdXFmRW03d3dDMUhRSVMyRGY1QXdXNW9qT3hST0NCV3NQUzBT?=
 =?utf-8?B?S3FoY2tKMnhIdzhXWlE1ek5pVkVHUDV5S1ZoRVk5RGtmaVBYbnZPNW1zY0Nx?=
 =?utf-8?B?ZGpOUEY2dVgxVjY0UUc5VWhteFk1QzdSUXk3TGFLazR0L0wyRDFhU252RWZJ?=
 =?utf-8?B?Tk1lWDJCR0R0WU1RMHcvUEtSeGF2ZmhRbHRNZWpSbVZGVXNDcllMY0wzMWRs?=
 =?utf-8?B?aytFR29Tek5lUERnMUNVVDZFV0VXRW5teUlhb2dwQ29vSm9DTDBILzRjNHlk?=
 =?utf-8?B?ZjVVeVRFUzhoRVg3QlBmK1RLR21xdERGWE5rK2MwbTlyNFZlelZtdXk1Ukw5?=
 =?utf-8?B?U1dLRndNUUVvQ0ZTcFgwNWMxeS84eGlTeVpxdU11aDAwNWlNY2YrSjNINFhG?=
 =?utf-8?B?V05FMFo3b2htQ1lGQkE5YjZUbnNFY21hQnJSNDVHOVUxbzFWdTVIRkJ1NWlo?=
 =?utf-8?B?MXlHRVpGVXNPQ0Z6TzNzVk1vbi9waXFjY2xWekZkdnZ0SzNRM0Ura2dJYThM?=
 =?utf-8?B?QVRadldNNEwyZTdQNmhtYmNuSmZuNGlCMDNFeUkxOTNreFovbTBBVGZ4THNY?=
 =?utf-8?B?SzYxUVEvcjFHeHlCczBUNThMeWFkd1UvVUwyVGkwWmZGaTZ0MXNqemNZU1pL?=
 =?utf-8?B?eEhuTlFnNE1QMy8wT3RGK3JUWWhJbEt2dDdkck5wTjdsY0JVRnI3bTlRYXUy?=
 =?utf-8?B?aHpxVjJ1U1B0ZUtPRWcxVVgweGpBVkVZQXdhWENzdm5VbDkrVzNXbk4wWE5W?=
 =?utf-8?B?RkpURGpyV2FxeTNnT3hUM1RyanRScU93bFNnUHp1ZDk1Zk9HdHZUdWsrZVIw?=
 =?utf-8?B?UUs3MGtZL0p3WUwrSktKaVVZVmxpU05CcjBkSzBSbHpDRDYzKzgzNVR1Sksz?=
 =?utf-8?B?aytoREc4bFUwMlVHSVJSVHVyYjJIMDNtQktxU1J3UGNjT2pKWGh5YVVNVFYz?=
 =?utf-8?B?eS9CS3lHVTB3azZCN2xLSUF2cVZpdElyR0g3cUZWeDNjSEtYaTB1dStoZXl2?=
 =?utf-8?B?cit4V3VTd2hDYkVIS2FOK3NTKzA0eUtXYWZST05DeVJPcFZ5OHBsQkxoZGhy?=
 =?utf-8?B?MFIrYy9QbHhxdnJPOWRtcVlXcG5XcElTanQrZUxLbHhrVGNUR0RuNjlPWUdh?=
 =?utf-8?B?Z2ZiZWRqWWt3S3ZJR09mR1RGSC91eG5Nck91VWdPdVFIVVdVbytWWmdxWGZV?=
 =?utf-8?B?Yndld3RsM3k3S3FYOEkwcC9NZ2NVSzRSZ3NQOHl2eTRwSzVLdlBOU2dybnFr?=
 =?utf-8?B?UGNyOUd4NGJwVXZsenUxNGpUbktrY3dFNk02QWRmNlFPMlYyOXc0eUhkMnpu?=
 =?utf-8?B?aGx3SGhIdnUzeVJwUzBxRFZZQVhZNytKdzVaRzVRYTA3OU1oRWhPU053Zk1M?=
 =?utf-8?B?OGNsOW9CRVM4ajhUKzR0b3p2V3Vtb2RLR3VyU3QwVFpMUHdvcjFHL2Jzc0Jt?=
 =?utf-8?B?RGVLNnFZejRsS0c1aFB4eWJUa1hIeFFDT0t1STc4aWRmSEd1Y3JJek8zYUNF?=
 =?utf-8?B?U21YcXBGcUJBSmk1VXBwbFkvOTlOeVdpVU10QVQzenZ4TFYzTnkzT04wZndz?=
 =?utf-8?B?OWRCQzRSVjZXcFFDc3dwZTc4b2ZXZlAvVHdQVzk5VmVxY3A5OWM2OU54aUJY?=
 =?utf-8?B?R0JOcVJuMEdHNVA5WmhEL1F1cXJMNGdoVjR5cnY4dkcrOGM2T3Y5SitQSitJ?=
 =?utf-8?Q?xnMY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea827826-9cb2-441a-9caf-08daf4358cb2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 00:40:05.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2B3pRn8SOu+rnA+ViOlYyeBbCW1xJfnPVhHlxHIZQIBLWKk03piK4DNJXFk34KUv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 1/11/2023 4:56 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 1/11/2023 2:39 PM, Moger, Babu wrote:
>> [AMD Official Use Only - General]
>>
>> Hi Reinette,
>>
>>> -----Original Message-----
>>> From: Reinette Chatre <reinette.chatre@intel.com>
>>> Sent: Wednesday, January 11, 2023 4:07 PM
>>> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
>>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
>>> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
>>> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
>>> quic_neeraju@quicinc.com; rdunlap@infradead.org;
>>> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
>>> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
>>> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
>>> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
>>> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
>>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>>> bagasdotme@gmail.com; eranian@google.com; christophe.leroy@csgroup.eu;
>>> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
>>> peternewman@google.com
>>> Subject: Re: [PATCH v11 13/13] Documentation/x86: Update resctrl.rst for new
>>> features
>>>
>>> Hi Babu,
>>>
>>> On 1/9/2023 8:44 AM, Babu Moger wrote:
>>>> Update the documentation for the new features:
>>>> 1. Slow Memory Bandwidth allocation (SMBA).
>>>>     With this feature, the QOS  enforcement policies can be applied
>>>>     to the external slow memory connected to the host. QOS enforcement
>>>>     is accomplished by assigning a Class Of Service (COS) to a processor
>>>>     and specifying allocations or limits for that COS for each resource
>>>>     to be allocated.
>>>>
>>>> 2. Bandwidth Monitoring Event Configuration (BMEC).
>>>>     The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes
>>>>     are set to count all the total and local reads/writes respectively.
>>>>     With the introduction of slow memory, the two counters are not
>>>>     enough to count all the different types of memory events. With the
>>>>     feature BMEC, the users have the option to configure mbm_total_bytes
>>>>     and mbm_local_bytes to count the specific type of events.
>>>>
>>>> Also add configuration instructions with examples.
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>>   Documentation/x86/resctrl.rst | 142
>>>> +++++++++++++++++++++++++++++++++-
>>>>   1 file changed, 140 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/x86/resctrl.rst
>>>> b/Documentation/x86/resctrl.rst index 71a531061e4e..2860856f4463
>>>> 100644
>>>> --- a/Documentation/x86/resctrl.rst
>>>> +++ b/Documentation/x86/resctrl.rst
>>>> @@ -17,14 +17,16 @@ AMD refers to this feature as AMD Platform Quality
>>> of Service(AMD QoS).
>>>>   This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86
>>>> /proc/cpuinfo  flag bits:
>>>>
>>>> -=============================================
>>> 	================================
>>>> +===============================================
>>> 	================================
>>>>   RDT (Resource Director Technology) Allocation	"rdt_a"
>>>>   CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
>>>>   CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
>>>>   CQM (Cache QoS Monitoring)			"cqm_llc",
>>> "cqm_occup_llc"
>>>>   MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total",
>>> "cqm_mbm_local"
>>>>   MBA (Memory Bandwidth Allocation)		"mba"
>>>> -=============================================
>>> 	================================
>>>> +SMBA (Slow Memory Bandwidth Allocation)         "smba"
>>>> +BMEC (Bandwidth Monitoring Event Configuration) "bmec"
>>>> +===============================================
>>> 	================================
>>> I expect that you will follow Boris's guidance here and not make these flags
>>> visible in /proc/cpuinfo. That would imply that this addition will have no entries
>>> in the second column. Perhaps this could be made easier to parse by using
>>> empty quotes ("") in the second column to match syntax used in the existing
>>> flags as well as the cpufeatures.h change?
>> Hmm.. I thought we dropped that idea for now. Did I miss understand that?
> I referred to the guidance in https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2FY7xjxUj%2BKnOEJssZ%40zn.tnic%2F&data=05%7C01%7CBabu.Moger%40amd.com%7C900eb41c0e6049dd342208daf4270d2b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638090745842366944%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=%2F5GVOhnxq1%2B3nJwGtlApvLfC%2FeX3X9RDaUZa9R92NiY%3D&reserved=0
> Since the SMBA and BMEC features have never appeared in /proc/cpuinfo there cannot
> be a user space that expects these flags in /proc/cpuinfo and thus no risk of
> breaking user space. User space can get information about SMBA and BMEC
> from the info directory.
ok. Got it.
>
> Later that thread discussed removal of existing resctrl feature flags from
> /proc/cpuinfo - that is what I think we shouldn't do since there are
> user space consumers of those flags. I thus agree that the task described in
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2FMW3PR12MB455384130AF0BDE3AF88BCF095FE9%40MW3PR12MB4553.namprd12.prod.outlook.com%2F&data=05%7C01%7CBabu.Moger%40amd.com%7C900eb41c0e6049dd342208daf4270d2b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638090745842366944%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=kE7d0cFYyJq1n4ZKKeeF%2FC%2FFDDJy0Sc%2Fd5MZ%2Bc56WQw%3D&reserved=0
> can be dropped.
Sure.
> I do not think this is a big change ... just add the empty quotes to the
> two cpufeatures.h patches and a new snippet to the resctrl documentation.


How about this? I want to get this right.. Hopefully next version can be 
final.

diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
index 2860856f4463..7df5889237f4 100644
--- a/Documentation/x86/resctrl.rst
+++ b/Documentation/x86/resctrl.rst
@@ -24,10 +24,15 @@ CDP (Code and Data Prioritization) "cdp_l3", "cdp_l2"
  CQM (Cache QoS Monitoring)                     "cqm_llc", "cqm_occup_llc"
  MBM (Memory Bandwidth Monitoring)              "cqm_mbm_total", 
"cqm_mbm_local"
  MBA (Memory Bandwidth Allocation)              "mba"
-SMBA (Slow Memory Bandwidth Allocation)         "smba"
-BMEC (Bandwidth Monitoring Event Configuration) "bmec"
+SMBA (Slow Memory Bandwidth Allocation)         ""
+BMEC (Bandwidth Monitoring Event Configuration) ""
  =============================================== 
================================

+Historically, new features were made visible by default in 
/proc/cpuinfo. This
+resulted in the feature flags becoming hard to parse by the humans. 
Adding a new
+flag to /proc/cpuinfo should be avoided if user space can obtain 
information
+about the feature from resctrl's info directory.
+
  To use the feature mount the file system::

   # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl


thanks

Babu

