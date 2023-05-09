Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135706FCE14
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjEISzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjEISyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:54:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C653C20;
        Tue,  9 May 2023 11:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nd82VFkHzABrMzMIzMGOME/WslNRxr2u3Hq/15W8mSIDYslF4Suz6TIt+f+P0QISJ4e35wk/JI2CaeNHNWUxJ4O8XS0qETEiZqPMv6FNN5Jg80uJ94Y+jrC+ieDS8dojbhS9JlQafMK9lhZZazhKHvMXyyy7f0zTpWwTDA+dsx68raDINOxEZTa+9L97Jl1/z1I5Bb34yg/FiVeE+EuIvcJeROQhGZVS0g+bYPZARUxMS4asHYRvDHLVnckGtevnSaMPJTz6J5iuslLeznSTCzMOEe0Ak9eHwCc8eu4DUnEqUaj/6VS8p6sIOloSvPP7mC36RXmzYx8te/aXErONaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqWyhOgLz9aHOX5blGO4Ch4MkplXT4r8563Hn/UmeCM=;
 b=IjlUNjFMyJgGw6KfIEH+vdO2hrRJimBWC6eCRmR9hp8gnI5PyM30Z51zRvEgJ3rGokRBDWw4UJ6RwjhrABTdqFhNApz94vOnKE7KzMJB9sHTiE/HoNvw2+ewW6hVlGmd0K1oy2FiaR9DqfZVjNu6fjW/X/tBFXEaQwqgjjsI/qs8RH5j+vM+9aROzdylVovvIyhnZcoR0soB/KaWwqwszdUQK5doOrJRiYNSrdwHogKH8ixab7iIuNwRBB/gyw5PDv/996+9+t6MN1IQhfGWOup38jjx5fwx3VDTpJuIJOD2GBt/XEKgmID49In/WTKSFPey8ACL+uUcq67DW7ttcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqWyhOgLz9aHOX5blGO4Ch4MkplXT4r8563Hn/UmeCM=;
 b=Eq/vK9cenx+w6NwzqaqxvveStPWcVdNFRqkbMgRzNQgQ6XjcS7bQUlXh71z/myFkXvVd5AbWsBZE1u28+GFqVyral5WshVYFJRh518HjZ/o18zhNx+iCbTNkfahIjosca8wTDGBe14gIl11AkKvHAxMjquT+nGzzNUlmNz1kr7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 18:54:40 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::25d0:8212:2ae3:2aec]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::25d0:8212:2ae3:2aec%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 18:54:40 +0000
Message-ID: <860b9da6-5b0e-2bd1-1848-0ddde0257b25@amd.com>
Date:   Tue, 9 May 2023 13:54:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 2/7] x86/resctrl: Remove unnecessary rftype flags
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
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
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177445556.1758847.5029687867896978170.stgit@bmoger-ubuntu>
 <4275aa91-5834-2c03-f455-f1d3d666fec7@intel.com>
 <MW3PR12MB4553E65A5D5DE6E27045766595729@MW3PR12MB4553.namprd12.prod.outlook.com>
 <efd45c71-2241-e0b8-e1c0-6fcc1e95b321@intel.com>
 <MW3PR12MB4553C5EF3818F6C54B8BF5B695729@MW3PR12MB4553.namprd12.prod.outlook.com>
 <8acebeed-8c0e-98ac-b7a3-5dd1680fafa3@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8acebeed-8c0e-98ac-b7a3-5dd1680fafa3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:806:20::18) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 6392fa70-cd47-4215-65bf-08db50bed7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: piGOKzNMwCHSwOKLRID56SgnkZTMQBPitAVvanA6aYNRFTZE5MzVTtogqQe6l1JeAeA91BSqY3XiqCLbRpiCN9zQ/LH2bZksJtIClamfYC1z4LoqN6kolCjU7PZgMxhZ3NpMC3uG8xU2jug6bsj/vA1jOp9Evff+B18RsTHksG1OtnRHt+Y4njHpOTghYufgXtChWkN5b/oqgymJyCbuFwHA+WiLIBKi18yNXKUzD+mWHJzVMKxira9YZysQHndiA9i72wmKXWX/zqFHsYeUDlOZCSZdtkmqzrCxeqIfzsErBjN6UnnxcGQrcqkvsmcV9OWZIePh8qy0LcRcDhEZyDfsO/cuh318cRXVq2OZ/A/ePHSXJEiz9GfMWX+2GYW2zskfS+AdEF+LSCxNB+oIm/fd8+K45tfFAUMtcHYZOTkkvPPuirDJX6Q/1zbWVpX1/hx3u+EJEa9IZC0wuAKURUvQDLexj3+uAe/YtfqpgrCoEwninsKp+6Tt6YTdsgbLPUSz3kX6FJDaq+ztzo6x5xhwmqzFXtCJbbUsRUj+Qs0JFaX2VNRhhkwpGLoMGUmmUqckvUqoTNhjxZhTkXtbkvCHTqJyUwL1A3Rufa5pN8b0ELsVXPLeqtuxtOo2iwzv9w0keR335RdtvhA1ZSWhDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(36756003)(83380400001)(53546011)(2616005)(6666004)(110136005)(54906003)(6486002)(478600001)(6506007)(6512007)(26005)(186003)(7406005)(3450700001)(2906002)(7416002)(66476007)(38100700002)(66556008)(4326008)(66946007)(31696002)(41300700001)(8936002)(86362001)(5660300002)(316002)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dko5clFtQ2xLV3JZVmlUdS9iOHh4di9BT2JaQWR0eXQxMXMwRzFNVi9peVEx?=
 =?utf-8?B?c1I2dVhrbllpV0I5TmhDL01yT2l4SkpCTEFmS2FEV3F5Wllsd1UzVTkwclJ4?=
 =?utf-8?B?LzFHUjFXZDR1djM0VnlGOHoxeW1RSWhSclBJd3ptcEpURVhVejFqVlR6TzhS?=
 =?utf-8?B?RjFNL2VZWko3ckdJaE1NYjFSN1ZXcDZNRkJZbldKUTVMMlJhVUVvK3UyU0pt?=
 =?utf-8?B?aHFTVENVdzlxM3krZGVyYjNyM0piQnlrS0hrSlRpNTlqdXB4R1Y0aUs0bytB?=
 =?utf-8?B?b1d6QUdQYUZXM2JWeEpPaVhsLy9Id25TQmJOVUpUajhxUVAycVR3cllsL2Nz?=
 =?utf-8?B?Z2lmN2JIdnpmT1Rqakg3ZEpHTU12MFJRQzBaSFFESHBxc3ZlVWlMWkRVUlNq?=
 =?utf-8?B?a24rYTd1Y2dJUXE5amYray9ZcUhzSXlOYW1yOS9RY3BRS2xNcGViOGJmbVhK?=
 =?utf-8?B?MndtejJ2YmcxbUxmYXhCbVhFcE5RNFZGRnRxRGEwT1BYLy9lZWNXVURsYlBB?=
 =?utf-8?B?ek11VGZMTjFEQmZISmtOZ2R5ampZd3hjNVBObUMybTRGdDNCTDRnaDVGRXJm?=
 =?utf-8?B?Tnh3N3FLenN5SXJXZGJ2MjRvanBXdis3L3R2NDFycFJiSFRGZnlWaXpiWm4v?=
 =?utf-8?B?dWkxZk9tMzNhNTVKZ2FOM2hQdGZMTU5iT0JhUnMwdTc5SCtRSGxtbWxTZXBI?=
 =?utf-8?B?bWRMVDNhN3pNeWRWcFUxZzkzTnhFNmxFekpRY3FpaG9EZEZpWWloWW5RczM3?=
 =?utf-8?B?MHFHU2hIaEoxTFhPcDRNWW1nTmdJcGlsM2tpdzR5VFFwUXpnRWoyRmZXcllz?=
 =?utf-8?B?QnliQ3J2Y3N5UnFQUkJzYUlXbnp2QnJ0UExXcDFJL0tRT2xETHlocmJGMitT?=
 =?utf-8?B?aHp3cVRiU0xVeXg0aDY0a01MK3RNMXNtU2lMOXZ0SEdMdm5FOE9WQ2U0MmQ1?=
 =?utf-8?B?T3FBeG03VnBJNFFVcFBKa2VZS3JrYXBFWkJQRittbG44YUNnMTB5NkgxSE13?=
 =?utf-8?B?THplOFZCN3luSlBnSzZDUWYrZkp1YlZWL3V1L2FKOXlmME1sVTRqUVhvaFRE?=
 =?utf-8?B?VGRqWHN2dzdaUU5pamcweHpLZnZwUFoyTlZMQWt4Qlk1Q2ZtV3huVFgrYUFn?=
 =?utf-8?B?cVJvcUNtdUgxTmRwYTdlZXlDakJROUFLQ241NWFxM2JPVzEwYVRjcHFmM3cx?=
 =?utf-8?B?dUhRU0VFNHRLdFFGZ2VsQ1JtWUdPd2wzZmd1NHlHS2xTQS9XcERFQW0yZmdj?=
 =?utf-8?B?SHdVdENVODhyK3Foa2x4NU1WMFQxK05aZHJuWDZqM1ZrenAvKzlXUTBKczJB?=
 =?utf-8?B?R0YySXdHMldPVU1qTVNkWk4vcld3UmlQTCtSckl1TG1oQU1GbUlOK1hod2N0?=
 =?utf-8?B?Y2NjWXdrOGRvRzlQL1hKY0RzM08va0pTM1M2OWczQ0Fvc0Q1WFB5bEpkc1B5?=
 =?utf-8?B?amJmb1NrQ0t0ME9PbHNxTlUwWjZ4Vk9OUmZGVHVHOHdlVDVvcDZuSSt2UWQ5?=
 =?utf-8?B?djh5ekMrcXZBVElHb2s3UWcza0lrR2ZnMHp1LzRUU0c0K21YSTEvdGFNdCtz?=
 =?utf-8?B?YmlVSzB5NmlKd1o2WlZIZmwrYTV4QWQ1cldicVpqSGU1YWEzenhBYU5iNGcv?=
 =?utf-8?B?TEpNR0NCWWN3a05qVkh4Z1FKT3RsSnlvRlptWFhWSEFFN3A1cWk3OE1VWS9T?=
 =?utf-8?B?YnI3N0gzSGJ6c2lRQklOaDZnT3JWNUNzNUJUeUlreXZkY0dIY2lYOUlDZ2tt?=
 =?utf-8?B?WmhwVzBENW9abFpjSlhtZmNoaldmNjVqTkdUaEd2L0NpYzgvejdIazdlNXd3?=
 =?utf-8?B?L3pVSGtxQUdSQUFYSU11ZzhTYjNKVUtUUGFqTnVoT01qU2NPbUxIckI0eEM4?=
 =?utf-8?B?TndHcEIzRXFRTDl1ZmpKcjdadWZKdnc4YmVDKzRvcVVwV3d5VXFiejVya0tN?=
 =?utf-8?B?Yy9qZEcvQmRnV3o4YzYzUFI0b3NGOXY2cC81UDVCMm9ISnNLWnZZTjRrOGtD?=
 =?utf-8?B?VStMdWtYVDdCblJpQzA0NFZML3NRTDNITmlYRkJYVzNPcko2ZVBQRytOMklX?=
 =?utf-8?B?OUIvZkpWRnR6YUUrZnphRG5tWkVDeW54RlVyTXdnSW03UFByZXVTRm9LaGFz?=
 =?utf-8?Q?xac4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6392fa70-cd47-4215-65bf-08db50bed7f9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 18:54:40.2604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJ2m3tZUliAGQgNzNswblzt6FjX+2cWT3+clkuX/AgvgqYLQye93jA8ITIz+E8V4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 5/5/23 16:28, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/5/2023 12:04 PM, Moger, Babu wrote:
>> [AMD Official Use Only - General]
>>
>> Hi Reinette,
>>
>>> -----Original Message-----
>>> From: Reinette Chatre <reinette.chatre@intel.com>
>>> Sent: Friday, May 5, 2023 1:54 PM
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
>>> Subject: Re: [PATCH v4 2/7] x86/resctrl: Remove unnecessary rftype flags
> 
> (is it possible to trim the headers in your replies?)
> 
You mean Company Header..  Sure.. Will do.

> ...
> 
>>>>> On 4/17/2023 4:34 PM, Babu Moger wrote:
>>>>>> Remove unnecessary rftype flags to avoid multiple indirection.
>>>>>
>>>>> Could you please elaborate what makes these flags unnecessary?
>>>>
>>>> Yea. Probably should not say unnecessary.
>>>> How about this ?
>>>> "rftype flags have two prefixes, RFTYPE_ and RF_. Remove the flag names
>>> with suffix RF_ and avoid indirection."
>>>
>>> I do not think that having a different prefix is a motivation for a flag to be
>>> removed. Having a different prefix could rather be a motivation for a flag to be
>>> renamed to a consistent name.
>>>
>>> Could you please describe the problem being solved?
>>
>> Motivation for these changes.
>> 1. Remove the naming inconsistency
>> 2. Remove the indirection
>> 3. Make it easier for adding new flags
>>
> 
> Could you please create a coherent changelog that follows the guidance
> of the maintainer doc? Some details about why the indirection needs to be
> removed and how this makes it easier to add new flags?

Sure. Will try to address it next revision.
-- 
Thanks
Babu Moger
