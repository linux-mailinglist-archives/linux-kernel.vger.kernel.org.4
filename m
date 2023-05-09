Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADA96FCC76
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjEIRNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjEIRNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:13:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE84111D;
        Tue,  9 May 2023 10:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgOeY9g/3+Zx5vOLvjBW20XDMrRV4SYN8nprgxH6zt4bJj+Vk4bCg7gSmss8zaYrpNrPS+9hB5j2LK+htFrnbWw5mfKWWO8OF3/BGsFPcw298KtZZ1IcrjzrjQpERvvyuUJG0LsMVxpWqD6VMvFmLSvEaXC+ewmGW56pBPrKERpFUgj+0CFINRsCouZvZC6xTAqL2OX8rPvYi9zxhKXOygpzv21oWt4QQJvSOrBX1O3HxUV/qLzVO2t+3ed3NTGnVEcl7NThh5F8bVrKG/4IRXoWc0Q8x63c4O3PaEBe/JDOsYhs5I0D14vloq+z5tb1xnHZF8VwKANyDYxx+3y8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUcVpShuq4Vg1EiFn1oE60IOp0A1q5k8/OMOgWLWEpY=;
 b=Mka6sCkw1vsuO0SqfpFDngd7kGvvBqxtvmwhRhS5V4B9dcF1+eTkfH69Ly6pFcfHU3tBAIw8gKG43anJ38ZhMCfduk4BBuBs2JTQdr9wPr9OpEuoPobu3KFs1/dXlW/Z+nyWsnXPMIvW+9FfDj/2IlPGerhuvEhxYSsOwty/I+FV9nRyEjSw3bvlTN/DKaky+JgNFZqfFgrih1laR7RrhMHN7WoQQR39ZDokNKYE2WI0Sy44dbpRlMxwnjDr+nXmrWFewetQfy/fE8UJfBhVOzFqXg6kauhIA+965zWTPZBEX7XgWTwjth05RyT1wEXHrBANIv5apaLf5nbtXlx64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUcVpShuq4Vg1EiFn1oE60IOp0A1q5k8/OMOgWLWEpY=;
 b=I32ZMq3A3qZ8u1PAEtpkKJGghwYfnXH1A1SO35NUWzrLkxHO86mvqBqVZLx/6MLnA/+Ev0hBNrtPR/kBuceMVgWjnQdhteSSaLFKAfOeYFrQ/RiPHoVp1SVDjOGF7UqUESnYEOpNLdFNi/F6qlRtf+VwrMl8d8iIqLFKQCt+Z/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 17:13:43 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::25d0:8212:2ae3:2aec]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::25d0:8212:2ae3:2aec%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 17:13:43 +0000
Message-ID: <e719e506-77c6-a5ae-6c18-98b02b31983a@amd.com>
Date:   Tue, 9 May 2023 12:13:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
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
 <168177444676.1758847.11474266921067437724.stgit@bmoger-ubuntu>
 <51a1b46e-9162-83bc-29df-8a154059f847@intel.com>
 <MW3PR12MB4553BAD1A9390D518D9919A895729@MW3PR12MB4553.namprd12.prod.outlook.com>
 <6ae80709-cf44-43bd-d539-650f72dcd670@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <6ae80709-cf44-43bd-d539-650f72dcd670@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0095.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::36) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 85570b96-ad52-489f-210b-08db50b0bdd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: av1wCu6iMDGvKPeJAMvanpMYCRoAJU5C6iXUNvVag2yeTDN1LpmukiDSJ1JSV4vHZro7nlU315+UavwVZ7B977lSo4lCwcImYu5pGHgIq8Cx4C7eQNDOJ59DPT5tsau2Jl9tEYzu3vYXOSyqZ9+TxIMj7fciOL6D578dc55gJdXajxroHf2VrblPNgUFhJDYqS9V5mXZD7020GW+waGuZ4drnYheSIiSzKr4+mRE+QRFb9CMpUBcEhJDq0ovt0wXRYrTOG16sC46LVdFtBWligBptBB3SgbMhwgqgN1kEQ44OAe2F57nQsEz18XvPmVOnef5+udvNLDX049T6G3hFFeEX/oh45S4hGPCLlLl+db5g2gBboZRkvK/aInBAitOQ1R5rGUbADF2JYVryo4TOtA6UjxVQUU5gHRmRQJGFD5QB3Seb3LbMS0VPn/hF3nSpSFJBy/cyGFzjxmefW3D61KuIG4oq5FwrouedL2fRokjajIi/1YZ2P0m3tC651fqd/KS0XjufwFllC+5g6pBwGgkDXGmUrPu3dztLxO2yzkDeXkoGYpVxyiphWm9riMo8CVGgllTloCbLm2KTyqhFQx2Wn+tukkb+sE6YNbgyTAxsq1rnjsDyapBzApK9+5qCS471roCzYPPY0IZGPT2Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(7406005)(5660300002)(7416002)(110136005)(54906003)(31686004)(6486002)(6666004)(41300700001)(8936002)(316002)(8676002)(53546011)(26005)(66899021)(3450700001)(66476007)(66556008)(66946007)(478600001)(4326008)(6512007)(6506007)(2906002)(83380400001)(2616005)(186003)(86362001)(31696002)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGJPdGQzbllJdnoyc3pWclhFcndpYjVoc1VwS1laSldVVWs5UXNZR1JMa2tv?=
 =?utf-8?B?RVNXZ3dSajZUc05YU003OWpvbElaWmFicGF3cVlaMkhUeHNNV0YrbzNxZThi?=
 =?utf-8?B?cGcrZFBvQXB5SWh6MmlkTXc3dkJOZWIxeUtta3R2WU5PUmNJZk0vK0V5Yy8v?=
 =?utf-8?B?OENmMnJ3VW5BMlhpTmxmY01VVEtMT1pZbHhsNjFFYXlpc2FJcW9XSkFrM0NG?=
 =?utf-8?B?d0hSbmF0dUpFWU13VWpOMEJ5M1Rnb0UvQStIWCt4MWxpcmVLZ2R1WThrcTFO?=
 =?utf-8?B?MnhCYXJjOGNtRlJxTG9ra2ZTRzdtYmVjNTNUMDJsOUpDVDgwR2wvbGg5TTB3?=
 =?utf-8?B?UkY2T1NpRVRoUURmNmhGamY2UkptdkY1QUF6ZlNnRTQxaXF6LzlVNzIxeVRZ?=
 =?utf-8?B?NURRLzNIMjhwbGZUR1VZRmIxMGRBWTlwT3ZqcnVxZklleDYyS0JiczVqZ0FR?=
 =?utf-8?B?Y2MrdmR3NWNRR3pMcmdFc2h2SHBOb2lLalVtTEJoVDlaZjgyaUdCUHNKZ3lJ?=
 =?utf-8?B?UHUxSzVOcjJ6TkRCUVM5R0Q3SjZUdFE4THNvbDVVZlpLVzhRUzE4dnpqMkFn?=
 =?utf-8?B?czlTREJXb3FQR1FnNzA5UkYxVWJDRU9ISHJhK25jR0VJbWdDRFd2b3ltZWVX?=
 =?utf-8?B?cWJTenkxaGpSUVNxRTdJbWZRb2dzZjh1SSsxS0RoakNYZ3hQcTgvVjUzNmpN?=
 =?utf-8?B?UEs4SmN0dTcrTlVXdHdEYW02MGgzdUNmSXJ6bVhHMllnb0puam55eFNhMjFx?=
 =?utf-8?B?d0NEekJRaFZtUERkOEZzdUxnN1EwL0lWbk8zV0szb1R1UlVhRzlUVnhlSXlv?=
 =?utf-8?B?aC9wR2NBTjRnOG1ZR2p1YjUxQkpQZkd3dEZ0UFFTNTFTVlU0bFRHdGdNSito?=
 =?utf-8?B?L0ZwNVZpakZ1ZXBHZmZDQ0REb1dpNHpqM2hDY2RxK3UreXM1aW13QWoxYTdx?=
 =?utf-8?B?SDB3T3FsVEIzeEswS0c2em9mcVgvcU9mYlVsQkpqL2g0RDlRbVduNzRkeVZo?=
 =?utf-8?B?NkhvQ1V3THF3U3FQYXNLUllyOUpjWC9lTW45bkp4VTFhNmJQMHdMbnJLN25p?=
 =?utf-8?B?SmlEQktkODlZcGhCWkFlT0NXTlB0ZlZNN0k4dEhzZkx4Y0JmT2s1am9vdWY3?=
 =?utf-8?B?RS9MaGY5Mk9wZ0NZeDNkY1VXa2M3ZkxsV0lpbC94cmRIYUpoeXNtL05TcVFl?=
 =?utf-8?B?Y2lKTEpPMUM0cmJFRlMrZTFCUzBvTVVDdkx6YmZya0xrbzMzVG9FOEtDSUNh?=
 =?utf-8?B?RVhJU1R1a3grVkpGM0FFdVU2N2ZSTWZsS0xzdCs1alJVcVBzdXZuS21PaGhS?=
 =?utf-8?B?eUdWZEZrdE56TU1DZHRMOTh2VC9WSzdhRU9MN3pVZ3N5WWt4THNib25XeUs2?=
 =?utf-8?B?bGdMUjFQMUxKZHRTYmV1c1kwRTRNR3pPZ1dhRmtadVBIV1VjblR6R0x2L2hP?=
 =?utf-8?B?K0t1VkRWamZVTjd1NHZjSnNCM0ZWVVJ1TDJrUkNRNEdQWXB5bUFvWEhRdHB6?=
 =?utf-8?B?TGI2dlVaNjFMV1owNlYwbVIrQnIwSCsvblhjSk0vdHJYSFUzanBWcFU3dXh4?=
 =?utf-8?B?TVIvdThHc1hWMXZXMUw0eUhYK2lSSWJzbHVTSVkwQWdDbnB2K0VobDg5TFNx?=
 =?utf-8?B?WmVoSGVYVk9aUDU0R1c3QW5ySUlTUE5LOFVjSlZYQmNUb01wTlJEMlZVTFN0?=
 =?utf-8?B?WHlrMHNZNnRMMjVxZTdqU3JQbENSbXB2d1N6RFovcjNlSkoyUzdVSVNLRk5y?=
 =?utf-8?B?dTBaMzFiRmZlZC9ZUnBpNFZNT0RLQnVacHlxYWwrQWdyVlNjaGZ4NUZZdGU2?=
 =?utf-8?B?U0JwOGlDSVJyQ1J3ZTVzekVKWFllUnphY3pNMmxhRUZSMHZQeFNZR25hQUhi?=
 =?utf-8?B?eHNodEV4SWxKU3ZWUjMwVWxhcUorWGo4Z01BM21RQWdud05UZVB4Q1hWN2JS?=
 =?utf-8?B?Ly93MDZDc0xRTDFLc1RTYTgwbDI5b2h3djFCcXlBK1kxbGZ4SXB3QnN5U2E1?=
 =?utf-8?B?TUpqalhNaDBNdGw3NXU2cDZraWtUQUxEVTk0VW5Qd3V1akxlL2tCcW1INCtr?=
 =?utf-8?B?b0FpTE9oNDdwWnlVblRQZ0F0ejRnSHQ1UmNyY2N1c0FWbmN3Ulc2dUU0cTVV?=
 =?utf-8?Q?TXYI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85570b96-ad52-489f-210b-08db50b0bdd1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 17:13:43.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhCRkPIoRATC/t+I2JaCdbXimu4JHmBazdjXx/Iak4cxShffZI2zn5DE5JWtLLLx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
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

On 5/5/23 13:49, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/5/2023 10:09 AM, Moger, Babu wrote:
>> [AMD Official Use Only - General]
>>
>> Hi Reinette,
>>
>>> -----Original Message-----
>>> From: Reinette Chatre <reinette.chatre@intel.com>
>>> Sent: Thursday, May 4, 2023 1:58 PM
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
>>> Subject: Re: [PATCH v4 1/7] x86/resctrl: Add multiple tasks to the resctrl group
>>> at once
>>>
>>> Hi Babu,
>>>
>>> On 4/17/2023 4:34 PM, Babu Moger wrote:
>>>> The resctrl task assignment for MONITOR or CONTROL group needs to be
>>>> done one at a time. For example:
>>>
>>> Why all caps for monitor and control? If the intention is to use the terms for
>>> these groups then it may be easier to use the same terms as in the
>>> documentation, or you could just not use all caps like you do in later patches.
>>
>> Sure.
>>>
>>>>
>>>>   $mount -t resctrl resctrl /sys/fs/resctrl/
>>>>   $mkdir /sys/fs/resctrl/clos1
>>>>   $echo 123 > /sys/fs/resctrl/clos1/tasks
>>>>   $echo 456 > /sys/fs/resctrl/clos1/tasks
>>>>   $echo 789 > /sys/fs/resctrl/clos1/tasks
>>>>
>>>> This is not user-friendly when dealing with hundreds of tasks.
>>>>
>>>> It can be improved by supporting the multiple task id assignment in
>>>> one command with the tasks separated by commas. For example:
>>>
>>> Please use imperative mood (see Documentation/process/maintainer-tip.rst).
>>>
>>> Something like:
>>> "Improve multiple task id assignment ...."
>>
>> How about:
>> "Improve the assignment by supporting multiple task id assignment in
>> one command with the tasks separated by commas."
> 
> The double use of 'assignment' can be confusing. This is also a
> changelog where a clear context->problem->solution format can help.
> If your changelog is clear regarding the context and problem then it
> can end with brief solution description like:
> 
> "Support multiple task assignment in one command with tasks ids separated
> by commas. For example: " (and also please use a non-x86 term for the group
> name in your example)

Sure.

> 
>>>>   $echo 123,456,789 > /sys/fs/resctrl/clos1/tasks
>>>>
> 
> ...
> 
>>>> +	pid will be logged in /sys/fs/resctrl/info/last_cmd_status file.
>>>
>>> Would it not always print the failing pid (if error was encountered while
>>
>> Not always. In this case it does not print the pid,
>> rdt_last_cmd_puts("Can't move task to different control group\n");
>>                         return -EINVAL;
>>
> 
> What you quote above adds the relevant text to the last_cmd_status buffer ...
> and later (see below) more text is added to the buffer that contains the
> pid, no?

Yes. That is correct.

> 
> ...
> 
>>>>  	struct rdtgroup *rdtgrp;
>>>> +	char *pid_str;
>>>>  	int ret = 0;
>>>>  	pid_t pid;
>>>>
>>>> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
>>>> +	if (nbytes == 0)
>>>>  		return -EINVAL;
>>>> +
>>>> +	buf[nbytes - 1] = '\0';
>>>> +
>>>
>>> This seems like another remnant of the schemata write code that expects that
>>> the buffer ends with a '\n'. Since this code does not have this requirement the
>>> above may have unintended consequences if a tool provides a buffer that does
>>> not end with '\n'.
>>> I think you just want to ensure that the buffer is properly terminated and from
>>> what I understand when looking at kernfs_fop_write_iter() this is already taken
>>> care of.
>>
>> Sure. Will check. Then I will have to change the check below to if (!buf).
> 
> Please check what kernfs_fop_write_iter() does. From what I can tell it does
> exactly what you are trying to do above, but without overwriting
> part of the string that user space provides.
> I thus do not think that the later check needs to change. From what I understand
> it is used to handle the scenario if user space provides a string like "pid,"
> (last character is the separator). Please do confirm that the code can handle
> any variations that user space may throw at it.

Sure. Thanks
Babu
> 
>>>> @@ -716,6 +739,12 @@ static ssize_t rdtgroup_tasks_write(struct
>>> kernfs_open_file *of,
>>>>  	}
>>>>
>>>>  	ret = rdtgroup_move_task(pid, rdtgrp, of);
>>>> +	if (ret) {
>>>> +		rdt_last_cmd_printf("Error while processing task %d\n", pid);
> 
> Note here the pid is added to the buffer that is printed when user space
> views last_cmd_status. I think this is the first time two lines of error may
> be added to the buffer so you could double check all works as expected.
> 
> Reinette

-- 
Thanks
Babu Moger
