Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFAA6FCCD1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbjEIRdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjEIRda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:33:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C8240ED;
        Tue,  9 May 2023 10:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLcHMWBhSW+/09vecNSq3/fJQJhmMVoWaPvHuund7kjh7Q/FQYb+SPoPBhXket7QWL7vc4GRqaKiGpkzr5XD0vejwh1WXaddpXKtEpk5LebfieBN8b9hfcR3SQCIS926ltA+D8paukQ+wwADKpdacSlOevEcuJHOYf8n3a+GxwM5XaA+gI7OFewlpWQ/PyEpnySWuolo+7P54TrJbDLv3ebGoSkbdYHQplQ+w8sIbXXg8fZXSPrxiOnPkgPld5VU4lUPntjLXKJnyaODOHomY2UMlRZPSZ4AqSEV40Bw/7Z1668WGqtyq6NB4lIUJRPVtd0HA2gyfkKC1BFr6eJORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRQzII7ENv+1trg5nY7x7hVM9E1Fpz3qSBHPPnMUEKQ=;
 b=ZizGKAtf1djlJ3WQ0MR4AZun0zkSj5IHoQsx+nXLZXy9dSyP6Wn8/w/9Kia2y1I0fU9GA7eg2JFFVgwC/++RfcD5eiD9Cxzxoomz+uu8CiwxwvZXooD+BIZTc5BXcI9P9VoSP+B3zhJ1mtowg3uzbf3CHu+BHXB2NnGkr9iDmkHzkt2ci23l9xX989xKiWdp4NYlZH6uVJDIEneBTW49ACJapVtWAc3BADt0zvAokV6riIINhHeGA0KWGY35hgRbmihBwn6FLz1PXvbj89Q9Uaxa2bzlk9SigCR2ChDVSpRgYpZgDTnqjVHPdWpkrWniNgr8VRt//aRQ/sNkqWavZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRQzII7ENv+1trg5nY7x7hVM9E1Fpz3qSBHPPnMUEKQ=;
 b=ltbbU6djlcn+8IaSKtctWOOcrvIXoOKYP7+cfis+igOXX94zwuAMokfTz1CLLlIQY1EyTmG3YmmiAMRYCQIsorItNUO2IoMOLT3ugjRwXgVjEcFPpxPT0cs1JBVooOZpbUKyc6aqS+EfQoT1YU6ObAHj2szVog6fz12Osehf00w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ0PR12MB5487.namprd12.prod.outlook.com (2603:10b6:a03:301::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 17:33:20 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::25d0:8212:2ae3:2aec]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::25d0:8212:2ae3:2aec%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 17:33:20 +0000
Message-ID: <46133263-e8d0-24ec-4bfa-b3ffc3566bd0@amd.com>
Date:   Tue, 9 May 2023 12:33:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 4/7] x86/resctrl: Re-arrange RFTYPE flags and add more
 comments
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
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177447844.1758847.17789021842152864417.stgit@bmoger-ubuntu>
 <67e00f1e-bbb2-59b6-fe34-758d5b268324@intel.com>
 <c1a309b0-3d29-151d-b1af-04d524cfbd83@amd.com>
 <8d3cb414-88df-4c89-7dfc-6e598501d722@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8d3cb414-88df-4c89-7dfc-6e598501d722@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0019.namprd11.prod.outlook.com
 (2603:10b6:5:190::32) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ0PR12MB5487:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a532ae-c8b0-4a3a-2b0e-08db50b37b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEgsht2YMXtaYDZjkL1K38QLJzKa0dGJWKd+7rKRm4BagD3/a6KoBcacZHkIWnp5lcqnTeEZP9ImcC6K6XIlsIE2ANth9cV40Tw7JK+/aOgyY1DFRRURVcDqPTA50ioJ5rVvHkctCzdNia/7y0g+o00sbt2EI0+OKaUauDOzoqBGqE74UNHsHJUhsiBh+AvIGwp+K7uAZqgqYNEEGDhtYeG8sO2Czpuz/8GWJO+GnYrDz5tfB6XUBrT1I7UkqHclQ11QVNQxfHLMiUWiBdga3XJNXRuN3UZ3hqpmTYAThkWM0AuU39amxn6M15nXaC6ZD74MUJyj7GQXozgEmfhpMRq9dxb7/DtPHLkJ42D1ZIhFuemzec91DIK9Ul062AiqpqPGXfKZTL0Cg8GCRnmhx895HYzHrQiOmYZUkFuaeCoyCwad1rm1h9OEQXvsS4Bg94TJuCfHdEVCyd9tMPl3lRr6gx+KlrNJCJGpcwTM+oLiQ6FSC1yutzJ77HDb82YEU0bHwHCDaUuk16xpYsfVxLnHz2D+gRE1KYqt1xbyQx/1/PoXfhPIBhd6DW1ZYnBJvdrC1Vgj07KZABJGc2W+BQ30QOwdRct6b0sIVbM6RhZ6YiDDSCPgm7YxY+a9xYiu6B84/1YJONHqD9ARpiKjlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(53546011)(2616005)(6666004)(6486002)(478600001)(6506007)(6512007)(26005)(186003)(2906002)(7406005)(3450700001)(7416002)(36756003)(38100700002)(66556008)(66476007)(66946007)(4326008)(8936002)(5660300002)(41300700001)(31696002)(8676002)(316002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFJ3YmFIaDJYLzBzRmlWQnBoaDFkdnMrbDF2eFFCZDJxZExEQWMzV2VTRVZC?=
 =?utf-8?B?bElFRHplQkh5VXNsdmEyM29UR3BGWXE3RStmNVZFRUpHNzV4Q1pjVUxVd0cx?=
 =?utf-8?B?M1RCSVF6V2N6T09TcTYxTkdzbUNFcXltNjVjdkYzYXc3SHlyanRzS2h0Wmh4?=
 =?utf-8?B?YUZVYXRSMWVzUmw1WkJwbG55S0QyY2g2TnplcnlZZHlmL1Jqbko4UWNjdG44?=
 =?utf-8?B?S2RMc2xBSmJNZWxhekpBdGhDWGt2MVRwQk5sZlFjS3phVWthR1QwOGtIMnFZ?=
 =?utf-8?B?QzZ5SSt2c1kxVTk2Z1JNSmN2d0lucHJycEtlVDZDZm94VmdvcDcvSXZ5WC9q?=
 =?utf-8?B?WHpCT3BUaWZMVE1xUzF4ODFYYWJtUkVyQkJWQVdCUThFV08yS24xdGlZSktG?=
 =?utf-8?B?UE04Z3VWMlN6OHllT082N2RmY3R3SmVvUW5qeXVNdTV2WWJrSjd5T1Q5bnF5?=
 =?utf-8?B?aExsTDc1ZG5wRkF6K1dwZ09JU1JOWHREVlNVUTRpM1YzWlI0eHZ2Nzk0YXAr?=
 =?utf-8?B?Wld1cGkrZDA4NlFIcldkeGFxcURmeU5SN2hpQlNCQnpiRHN3QUE0dkRnTXdE?=
 =?utf-8?B?TWRhdEg3WDhQYWVCZmd6RDRxdlZ5NGlvalc2WVZvWVBvTE5oSHJQNkVEUkZL?=
 =?utf-8?B?QmVaWDBucGJyZjB2TlFHcVJrVWJxOTFJaC9MaDNWY0JxR1piQXBPR2NoRXlN?=
 =?utf-8?B?bzd2K0JGSDNiRUthckRMSzA5cWdlQVFzRHlTMko1UmlSbWpEeW0zS25WbEVn?=
 =?utf-8?B?dFdCdC9mMzd6Qi9hQmN0OWx5QVl4ZGhlZVJCaHNqQTRTMzdOanVnWlQvTTN6?=
 =?utf-8?B?TGs1aWpqa2RKWEltS1E3eklRSTNtMy9XRzlhUytYVS9xd2RCbThQMy9BcFds?=
 =?utf-8?B?dVVpbkZqTnBJcmZjMThzUUN6azlhZkJUeENQTGtwUGREK01DZ0NzU1pwVTM4?=
 =?utf-8?B?QmZNMC9LQ1RCQmNISUpnZ2pNb2FDd3BVYnpKUkxYRjFsUDZYcGxoVnI3Yks4?=
 =?utf-8?B?OWFFSmM2eE5kRzRoNDVxV01zL3RnU0FsV1MrRjRwMUF5dElCd3gwcGw5NTc5?=
 =?utf-8?B?bjVjaXV6NXFWTVlRNkc1bGZ2eEE0NUQ1WGtXdGhLUUp2ZEE1djJ5bUlhYVdR?=
 =?utf-8?B?dHRvRWtRdHVlMm9jWkNEd0lTNVZBK0N4QnJFT0NmSnR5dStTdHpKY1ByUGN3?=
 =?utf-8?B?VHNIL0p6Y3lsWFpMTWhvL1h2NVd2SndqalR0UkZOeTlaKzBWcFNpcVhnV0Jx?=
 =?utf-8?B?cEM2WVJOOVlEbmFXT0pNQWRXUEo5NnNXbm8zVko1WkRsNTdhRkMwUTJuVXo4?=
 =?utf-8?B?U2JnQWVhbFdCRmxTZ0huSElrU2FzcUJWampub2lNYUZuSHVxOVJEMUhlNXZK?=
 =?utf-8?B?YXFwcGdVdGZUYzBBL1cxOWY0YVhLY1R1SUhublRHUXBZTGRxbXpPc0R0UXlO?=
 =?utf-8?B?ZHRsRXJIK3RtNTk0QVB6Snl5NTVtZGlDZGlPZWxFMVZqeXFuQ0U2Z1cxTnF3?=
 =?utf-8?B?cVY0YkoxbUpIQmFBbHNsOWY5Tk55OFNBZkh2MHZYeFkwbEQxSWQxbElsVFJa?=
 =?utf-8?B?Y3Q4VzZVNGxYejJzVEk2OTczbVF3aFBUeHN3MjUzQkNPSlRVbmRzQlFEdUhS?=
 =?utf-8?B?VWZrS1JuRldobFVuejNsSU9RVmdacHdYNmNyMmJZMlZkUTJsQ05BL3ZoSVU5?=
 =?utf-8?B?THZkZXBqeU5zQk5QUUVKUE52aTdoVzNkMjRVaVkvQTk0YVhMenZzUVp4WGZM?=
 =?utf-8?B?dEtYRnFyeEs3ZnY5ZGJFcGdZVDlPWERvcElQUDVBZ2dtc3JadHAxcUdReFVm?=
 =?utf-8?B?eFVKMTB0MXVOcm45c0pCYmJVTE5NMmF3U0JselA0azc1djhlUGh0TGNtTm1Q?=
 =?utf-8?B?Z3J5REpzL0swczNoaHlIYnQrai82cllnd05BYkZMYVAzWWJVR1ZKQURRRzFK?=
 =?utf-8?B?cUZZMmtRbGtZRlpMdmxXQkUzZmNWdDlHd0E5YWxjeklhd0ZFdW9yeXBYQUxE?=
 =?utf-8?B?ckNjM2l3cDJDa0thVlR1UlJDSzRpYUxybHZ1LzA1TEh5ZXQ0QWxvTUwvc0hw?=
 =?utf-8?B?TVJwZE5qY2JpSEIzR2lMUnpteDRjOG13TzJJSjltN25jV2Uxdk92b3VlZWl0?=
 =?utf-8?Q?DlwU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a532ae-c8b0-4a3a-2b0e-08db50b37b23
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 17:33:20.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSN7RKTu9ywCy33Pz3q6b7g0dbPd6cEy9lmzGk9q/+iHAQHoYg+LCrq2E+A0RBmR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5487
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

On 5/5/23 16:24, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/5/2023 1:40 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 5/4/2023 2:00 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 4/17/2023 4:34 PM, Babu Moger wrote:
>>>> Remove gaps in bit definitions of RFTYPE flags and add more comments
>>> Why is it necessary to remove gaps in the bit definitions?
>>
>> Removing the gaps is not necessary definitely. I thought adding
>> comments will help adding new flags in the future.
>>
> 
> I agree that removing the gaps are not necessary.
ok.

> 
>> If you want me to drop this whole patch, I am fine with it.> 
> 
> The comments may be useful. If you decide to keep it please review
> it for consistency. The comments should not increase confusion.
> For example,
> * in one instance you refer to "info" and "base" as components, in
>   another you refer to them as directories, which is confusing since
>   there is a "info" directory but no "base" directory.
> * related to previous item, the comments start by referring to the
>   "info" and "base" components but then the comments switch to
>   describing a "info directory structure and "group structure"
> * the separator (---) is used above a header in one instance and
>   below a header in another
> * in some places you use the syntax:
> 	--> <flag name> (<dir name>, <dir name>)
>   in other places you use:
> 	--> <flag name>
> 	   --> (<dir name>)
> 	   --> (<dir name>)
> 
>
sure. Will address this next revision.

Thanks
Babu
