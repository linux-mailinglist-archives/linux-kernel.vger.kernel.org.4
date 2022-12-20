Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF246526B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiLTS6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiLTS6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:58:30 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFF31B1ED;
        Tue, 20 Dec 2022 10:58:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQgUrbUYyrxVbLSbc0Ebi/kUVP9TwblLCrLmYk4Zj8yvTEzi32JNNVXzY85KuQotLMHW/EF3ANbXee7CHz5hGXbcKf7OS66KQEbbozy8vxEG5B1tGniBqP4MjrPapXoLofZEA4Vt85BSNjD3TVKF2tb98pL7Yc68GfUiXSVWlVX9yNMB8eul44NyQVOp6C1hHiN12AMwHz1Fy3D8Y/q8/TyI1+lkrmftPy6xk2PCNWLplf4ooHnpCcU7JbS919Ureqx7a77OG8Bg64U652Z/dCj2zydLi7vMGp+gR93Tx/1JHFCjKHWFtvLZQADQQuRzHdRHxl+wiyv4bco52ydHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eku9FNNQMVx+DvSnWMVIqPrWXdbcKOvtGN3yiPJu60=;
 b=Z0rVtvZcSDjL+uanHFp+s1MyWIJrb5tt8p4naKlm75ry1abB+ZzPWGQDnLnH6fzX2LLelZHRnMxLg9DNMWgu1ZPCQQbyqxZuqGj7tc1K1g4b+vxkpsQWLwxLdjnPM6qIIC52ypVyI/E/4GvmVHE2B0hBH3vDkWdwf9BOytQCSHK5AaTgZ0f3TYrvPbWxmbq+LNWRU/Wt4MyoXKwFQnUKmFsR7DnvvY6UBsqVl6Rhidx63jKrD4bTrSx4thvXYJ6KKMhdNjzgo+Ny0/FKGJJq0iU00bEySagDFq5fk0NQ06LO84rEAjiOrghAovnHQWHXCYxEFb6M/n9i9uBWw7NtFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eku9FNNQMVx+DvSnWMVIqPrWXdbcKOvtGN3yiPJu60=;
 b=MHRHsi+j6oExlr6Cv4Cdn1e4mFRPN0o994qrLlJuRvcHc+ckGLMs9iv6iUs8MWcu9IiqhRncC4Vm2wjKrwfQeD3G5KnPml0lGGxWl1wwKPqfI34wZGzRHubk0rdPf4sU//N/EiLLXyh+/WLm6ovklxj64MfK2zdnbh2oPozgbY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 18:58:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 18:58:24 +0000
Message-ID: <d1e9ca71-f1e8-69fa-c0af-9557484144ec@amd.com>
Date:   Tue, 20 Dec 2022 12:58:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 10/13] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes_config
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
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990903030.17806.5106229901730558377.stgit@bmoger-ubuntu>
 <084224cb-271f-a1c8-6665-1953b2574495@intel.com>
 <MW3PR12MB4553A194B951DAFBA116894995E59@MW3PR12MB4553.namprd12.prod.outlook.com>
 <02d9ecbd-9b08-9777-f93d-0811edc79b6d@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <02d9ecbd-9b08-9777-f93d-0811edc79b6d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0006.namprd05.prod.outlook.com (2603:10b6:610::19)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be70551-8b5e-4ac5-5c0b-08dae2bc2be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBZVEW1neD8MztaXR7NsirkL+hE4TVAmuN2OH8+B12yYaPXYivTDWuwUCt3+XBBbh6H9ew13EYs5mkFKhr7duZdumcThSsSYR6P3XCSxsbeHUBrZA3+T+BaV/PREzEmKjt5JaZ5+5Ef/8lLFMTrGgOIxhRAINzZV05T07oYoXk7LaacLxiOI645Apj0MlEwCHk4j763gV/OQfaFcMsMQI4BcE9CLl3UCB0Y0t3en+mugOPfzyH0NztKlNhgCaRZ1lpctRsMk042l6sjHn8zvkAKJu0Yue7O91yQ9YYANURephxgRembkoPCHdb1Gq68LY3++Xh+4DEGn+v2swgQtfqo4SG84egld4D7A8+PxHdfxOQV8OlbjwZ6eUAgk0D9aiyE6MzU/IoOwFEZprlEzNpih8y+fHUGdaMOD7Kwa0EJpmbFp+2KfzcbMxF0gPnDv+zXRGCIIzNt6sJsoHjtKr+xfRKRkQpUJas9t+OE+TE/QecjqvRfM+acUZQv/fmyLhSgMpjvkcqajjiYzLZjzZXokdT0QCX8xFp3hSeETaK9k4FIYYv1ENymlqP0g2wRrRraUsVdKXBOGqe3bORWdaIT8K23G9J38bRBcz3eaqcXSY60NnQKD4mc2CVtv2K+RxVT3AaX8khoGqeJrszThLs7upjpg2NaL3WbkIa4/6RiXxH2rJjtwDU4FDVEDrqiFoUjfeuDnbTlsCfOMpcIk4Ua9kd0OGoFC7xwtjvPg1T8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(36756003)(110136005)(54906003)(31696002)(316002)(6486002)(478600001)(38100700002)(6666004)(2906002)(7406005)(8936002)(4326008)(3450700001)(66946007)(7416002)(66476007)(66556008)(5660300002)(8676002)(41300700001)(6512007)(26005)(2616005)(6506007)(53546011)(86362001)(83380400001)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1VnSVhqamxlQWlNblFXYVVUVEhackpSbTRVYStSU3FnTjJaRWpPK0tDZUR4?=
 =?utf-8?B?cGhKcXVLeGVCR2NYbGY1WmcrMEJnWDliVm9NMW1WazlaRklBSDZsZ1R2dmxR?=
 =?utf-8?B?RFFMckhvaklRbWtPazc5bWtEbExiWnVOb3l1Z3JZZXRZalZKSXBNaS9pd0gw?=
 =?utf-8?B?NGxMeXJJVHZic01KSTJ2L3JnVUV1MEVtVC9sWDhTOXZHS0pGRUw3b2s0clVY?=
 =?utf-8?B?WmQ2Ry8zS3EyRWxGYU9RZnFUdWppelh3c1A2NWhlZWNtUTdnQ3dPbDd5TWYy?=
 =?utf-8?B?OHk4SndsSFVqLzB1Vm5OaEE1K2VkbmNYNTNxQ1lBR3E0VE5la3hDUjEydUxL?=
 =?utf-8?B?RlkwekxVNmlUTlZFUHlHN3AzTUZLQllvZi9YWTgxVy9TMWY1RTM3SWQ4VWZL?=
 =?utf-8?B?cEFHQ3NwbnVtbUdmOFdnQklCOWo0TXZZZ01MU2JwQkhGOVhDSlVSb3FFQTJB?=
 =?utf-8?B?Z0JjRmMzMTFIbmsrUDk1eWlXamoyelUvNEJnTlZZaDUvSS9heStCdExUMEZJ?=
 =?utf-8?B?OVdpYTdnNHpVbTIxeHB2UmNidzJRUkZ3Q1NFVXI5bXhpM25jYUZsZ21xVlBh?=
 =?utf-8?B?RmlFeXBYaW01Vm1jS21UazhKOUQ1Wm1DY012blJGazBka1ZnMmdQY1hCNHQy?=
 =?utf-8?B?OUpmZzZEZHJnMG9TcE54MitDWlRCaktLL0F2T0JlRnhKUFpIbW5IdXVLZkU3?=
 =?utf-8?B?YjU5ZHQ1NE1ueDdObmhrWVl3MDNwVHh2OFU4ZFlXUEJQMlJFYjQzSHF0azBC?=
 =?utf-8?B?VEFLZiswZE94TEJrRENoUi9SRHU2NGQvZ2ZPcCtpM1JlcW1odTVkY0t3M01q?=
 =?utf-8?B?ano4UkdueWE3bExFK3hXMG1mckZ5Y3FsWUtEWnVWV2lwcWFDVE9tWU5HTGRY?=
 =?utf-8?B?YWxXcE0wOGJ4WWZtZU5kMSs0ZE1PdUV3dXdUZXlSalBrNGppUGtHNmh2Ykpj?=
 =?utf-8?B?RE1OeTV3R1Y4SGNpRGd0ZlJ0Y0JhWUlPSlMzbHc4bjU5V0VnRXdncmhqbmxT?=
 =?utf-8?B?d21iakJFd0tXeC9GQWlZc2FVM3F3UlFvT2I0NC95YTArclN2eUFlRzZWU1M4?=
 =?utf-8?B?SVNyU2VualdsdmtHcE55amxVZjRNTkZLYUFuRDZOZTNOQktkUkV6a1cvQ29n?=
 =?utf-8?B?WTZMMXlrV3JVZ3BIYmt1bXBlaTdUKzVuTlJobmlQYVgxNXZMM2ZuR3pVS3Zq?=
 =?utf-8?B?ZEVtb0JoSHRqQkY4bGI2M0FWaERadXRaaFdLSVlZd3ZlM21qbjRQdFlSdlJE?=
 =?utf-8?B?K1ZqRjBOd2xJY1ZORDZERWthK1grNVN3aEQvRklWWUdJZytSMGh2UHdGZWxo?=
 =?utf-8?B?aVh6OW1USHZ5cWhOeCtBMFFWNlNUQlpRYVBUWi8yZnR6MVNuaVpUQ043eitR?=
 =?utf-8?B?dWc3L2s3UFRVb1lYbEZwTG5tRERmMEh0NUtaM0lNRUxaMys3d3g5Z1lDcVFk?=
 =?utf-8?B?NUdlRmlVV05kaXNLU2U5cXZ3VlNObWd6TlhFM2JwZDNTZGtaNGtaakhiK0xJ?=
 =?utf-8?B?RkJkaWJ2ZDlJU2RKOU80TW4zcGpwNUcvT0dMc2owNnd0ZkVIemxOKzBJV09u?=
 =?utf-8?B?T1gwbTNSV2dLOWlUaWRoSFlUcUQ5K3h1STZBdUdxalk3UXB5ODY5WUxleGZD?=
 =?utf-8?B?K0ZubTY5QmhsbVFpc3pWdXgyMXJ1aHVYMWZWejA5UUhYSlZRbkl1MVR4ejZy?=
 =?utf-8?B?a2hzbHJ1bTN2NzZqSDFubGoyeFpoUGtuaWR6dzdlRzNQWXBUL21BU01VZUdy?=
 =?utf-8?B?aE5Gdk1WSC9NSDEzTUNwU2NXMmlwSGhCUXdXM3pEZk1FVHFmSkRWU3RYdlcr?=
 =?utf-8?B?UHY4TUNwbzBIUWlSaG9LVWRsS3F5MFFkSTFZQ2M3dWcvL3VYVEhxckQxbEs5?=
 =?utf-8?B?bkZaNkMrc1JuL1RML2hXaUhXaXBLUE84SC92VENVRU9OWmRiOG5KY3oySkhP?=
 =?utf-8?B?bEVodGdjUmdsMS9LdUVYOTVZZ2d6UGJQN1JmTGlhR1NLbjlrc0lCQ2hMeHlT?=
 =?utf-8?B?N1d3WDg2QzRLaUlTNGxPaGZOditpYmx2bWcyTVBDZHVlOWVFN3B2b2s2MDhO?=
 =?utf-8?B?MEtNUWRPM0l1ajdvNjRmbnNGd0lKaXBhN0R1cUJWcDR1elltbHE1MGtsTzNv?=
 =?utf-8?Q?sQkg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be70551-8b5e-4ac5-5c0b-08dae2bc2be1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 18:58:24.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8gwZUmUqEyfrJbcqNj9z/xjTyk1NV3X1KC0a4IEJ4wffkxIOW9OPFFyFJQwihkd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 12/20/22 11:32, Reinette Chatre wrote:
> Hi Babu,
>
> On 12/19/2022 11:28 AM, Moger, Babu wrote:
>> [AMD Official Use Only - General]
>>
>> Hi Reinette,
>>
>>> -----Original Message-----
>>> From: Reinette Chatre <reinette.chatre@intel.com>
>>> Sent: Thursday, December 15, 2022 12:25 PM
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
>>> Subject: Re: [PATCH v9 10/13] x86/resctrl: Add sysfs interface to write
>>> mbm_total_bytes_config
>>>
>>> Hi Babu,
>>>
>>> On 12/1/2022 7:37 AM, Babu Moger wrote:
> ...
>
>>>> +	/*
>>>> +	 * When an Event Configuration is changed, the bandwidth counters
>>>> +	 * for all RMIDs and Events will be cleared by the hardware. The
>>>> +	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
>>>> +	 * every RMID on the next read to any event for every RMID.
>>>> +	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
>>>> +	 * cleared while it is tracked by the hardware. Clear the
>>>> +	 * mbm_local and mbm_total counts for all the RMIDs.
>>>> +	 */
>>>> +	resctrl_arch_reset_rmid_all(r, d);
>>> If I understand correctly the expectation is that when user space read counters
>>> (via mon_data files) right after the configuration was changed then this read
>>> will return "Unavailable" and then the next read will return data.
>>>
>>> If this is the case then I think a snippet about this user experience would be
>>> helpful to add to the documentation.
>> Ok.  How about this in the documentation?
>>
>> "When an event configuration is changed, the bandwidth counters for all the RMIDs and the events will be cleared for that domain.
>> The next read for every RMID will report "Unavailable" and subsequent reads will report the valid value."
>>
>>
> Thinking about this more ... why are the counters for all eventids cleared
> when only one eventid's configuration is changed?

Its because of the way U-Bit tracking is implemented. The U-bit is tracked
per RMID basis, not on a Per-Event + Per RMID basis. Therefore, resetting
the U-Bit for 1 will reset it for both.

This is what I got from h/w team.

Thanks

Babu

>
> Reinette
>
>
-- 
Thanks
Babu Moger

