Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278C6679E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjAXQGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjAXQGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:06:09 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2EB46D7C;
        Tue, 24 Jan 2023 08:06:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI0Jcj7e1tP8y2DfqHiEellTbbevbE6Hoh5zWYGlMXzPZWtZ/pWxniBc5Z4dpyvPC04Uek/agTFYlFHhSewAx39tJRjK9F5XvO33MQJf+z89t4NHwFe9AiKltYbCRfYHTx3Ku2ca6RZeuHZlKIFnq5kYe25XFPl3XxS61JkKKnP8V2Ee70FKa8Ba2FnmCE36nSqRk0bXj5HQHwR7s/XS9+NAoFSOXBS+aw3PtD4bA6MK+X3UKldG5H7hQ/uVxN1ffSmSzUyhLikSG1hOYQ4a1SKNC35KKYmJjDEoxQ7ej1boU7NuSUUWOkIusGfGTtTlcl2glveO9Uxyi5WDCWm9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/bWAb3wGOpELIGYY45UjR8myKiCmcaDSlhgY7W728w=;
 b=D4WlhNBg6/BB2SZe281Frqaw3m32wVifduPSS/yZNKgjkdnQVbYwR1RsmE74yta8Z7CpIYQIZmglDKcglPTTg4d8lXdkfAmyvOCild+wTQoaoCvycKNbwyA6HfbDoJmMdKQIg547s1xqCnCwR3UaNKZgfiQxYnXGtVThQxXl8PIMZQRzLch85lcR2DFe2mt2fsvS1nXDBmGddE9Qq+k3ejSl9LRrcSTWO8XDylQuyO5jgMPwdEYiC55/V+iNDHbWi9BxCS++PVAAOF+/+DbjXMMLEGBSA1K/fjELH2b8OEWbUpMVVe0eupiEfDzQxxOcqiqSw1pvxydNYRfYPy1FAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/bWAb3wGOpELIGYY45UjR8myKiCmcaDSlhgY7W728w=;
 b=1yJQqiVu1/PQHj2/WdWfdAgVp0EgWWay4iGmVP0jnyaLfgGllT9Q/UQCR/FWJjma2vhH9+SM7OAPEvLHcrtUVyjLKwx3gFza0Wah3/McccVp2Wi4EJg53aim4PeSq1uI/ChVe3iRBWgQDfnQL1eaT2ztHB+jITesWcYZ1o/0D9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 16:06:06 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%9]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:06:05 +0000
Message-ID: <4ac38b77-77aa-f2c0-36e4-5e482013091d@amd.com>
Date:   Tue, 24 Jan 2023 10:06:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
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
 <Y8/07cV+t0PrqWX9@zn.tnic>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Y8/07cV+t0PrqWX9@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:610:118::32) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 128a1e2f-db40-4474-88a5-08dafe24e5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Q0dqGTLX/WZO5Yb/BVkv0iTKKWzB8TcctK9eOkG8EaFqP7nNUg7/DLCyNvtmq3TkbN6KtF4EVUG8vJlJ/TxhQahd4emdL5msmQ8192NgEdu1Cn+w30sNzF7gfWnxAPrIOVTAPM7YFobIIXOVkptZKosL71CQwNFWTFkZqPsznvDvpqv2f0Q8UC9Rxl3RCC8m9wCtzRmmIima/XMqYHyrwM5kn7/W8Z4Or9lt4T9xhBPR7HY3uV3TNA/SLYHFTyhLN6WcoX+Oio2C4mIuG9Ht3OaIm78CjRXS+cc+RTpZzlBv6+q1fSzBRwChjcTbg5NsC/yTRcxyH3lNJtlz4HU6gHL8+SY9WILuh4EEd75M9J5J842rGSbooTsZSgGpN+G0YHDsg/IBUEwy068Ipc2Df6UAM8tbHqu0C6zYTmi8NPeyUKytxae1NQtQIcA+wGITLMhFFtXQnQUkv6pT1iH1jLdcbDhMlK4XMreZu83YuhESBZruEel1ckGQnQHD4P21oqRR8Yh2JU2ycjqvmU2TijkIxVIz15c552x0lsiTIqHMvTgBjtBYjT/q27ZZnzB7nnNsr9QrMmwCQqv6fMeofwHtiWHYlZ4AMrW8ZXNLxRgHH4FWzjln00jUeA2Vmq9Hyo7c59Ww9fXE2rZCYZgOkYJGicUgG00VuZj2ClRDrrhU/fFsZ7IS4Yi8G0nRCS94O8Y9FFrSlr1eLM6C9nGPtwhYXi/+N+npi7dAKwsC7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(31696002)(36756003)(3450700001)(41300700001)(86362001)(7416002)(8936002)(5660300002)(7406005)(4326008)(4744005)(2906002)(83380400001)(38100700002)(478600001)(6486002)(31686004)(66946007)(53546011)(6512007)(6916009)(26005)(6506007)(8676002)(186003)(316002)(6666004)(54906003)(2616005)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUJLbkZtNkVuZHVLY3BJbWtsbXRhaEVYbUhSWmk5MXBBUDNvWFJnaXgxMlRE?=
 =?utf-8?B?TGdaYWlGQ1lydmdjQ0dHTFhTOUFlK3BkWXNURnBDL2V6M3p4OVVlNGF5SDg0?=
 =?utf-8?B?cDhuY3NTNE8wdm5Nd2VPbTFZcTJ2R2I5ajMxcURJbnRvNkQxeDAyTmhmVXM2?=
 =?utf-8?B?UnNmUVFHbWd1Z1U0UGRjVklTVmNrQy9MbVlmODFLZ2V5NU90RldIb1dMT1Y5?=
 =?utf-8?B?TFhuOURyOGNzUDQzeXlhL3ZRQXlOc3RkSWNQczU4Ykw0bW9yUlpHUkl2OXZD?=
 =?utf-8?B?RlhOeENhWkhNeWxzWVhiZERRQjdlRVVwWHFMS1FCTHowcVA4dU05Sm9RdlZR?=
 =?utf-8?B?WG1lelp6OUJsbVQ3ZzdKWjRJMFF6b2F2VmttMXpaQVBGdkVCYkt4d28vVjM5?=
 =?utf-8?B?SlA5UEdEVXJoWVo3MDI5NFU2dXZvNkc3NUdLUHduQWFXeFhyLzJrTHdRdndz?=
 =?utf-8?B?NHZKTENmK2M3VEdiVkJsT1ZmdlIydU1EZ2tHUUwzMlpXKzg2QWZxd2R3VkI4?=
 =?utf-8?B?dUQ1a1I0eFR4a2NwNTFRWVF1dHRMejA1Ui82L3BLcnRBcVdWYWM2Y3FGbm81?=
 =?utf-8?B?TS9hN2wya2lCVkZ2SDBmNzdXZHhEcGRpcElXamxpNWFKZDFKcTBhUGg4cFpZ?=
 =?utf-8?B?aXdNem5pbDVHa2JOV3g2K05LKzB5dUZ5SlRWc0c5cG1EZ25KcWloaHRUM3No?=
 =?utf-8?B?b2FBNkVuTTFaWEJaQTVYR3JuQVpFVDA2UFdyZTBFRXhBZVdLNEZNbUxHT0da?=
 =?utf-8?B?ZXR3eGpobWExZGFTVEhXYTZBbWhNc3lUcTAxanFQVStmMGhrNWQwUjdXWXUv?=
 =?utf-8?B?Tnp4dDFtajBkSlBLeFhURWxTUzRIV3crSUt2RzVqTS94eE1Od3QrUGZqMjU0?=
 =?utf-8?B?K1RFY1pCMU1NYkVHcGliYVNMVFhlckgyRFVGQ2ZibWFUTmErZmxSM1dNR2gy?=
 =?utf-8?B?MnJoNy9ZNDdOd3FqdlNIaGphM09vY1NsZyt1V3ljTFAwVkdZOHJvbFFlR3Rn?=
 =?utf-8?B?bDM2UVh5WWkyRkZ1ZWR4S1UxNmpqcjhmTFpDc2E2YjFWbDlxb3NvK0tUbkVT?=
 =?utf-8?B?Y01HdkpmR0p0QXc3UWRucUovY2RId1V4dlBpNzdOQW8zQ3dKMlI5cEgvZkY0?=
 =?utf-8?B?Z0s1REJweUpFeC84WXlxWTJsaDlNWkVmWEd4RWI0TXpPYXdWVVRzRUpwRkJU?=
 =?utf-8?B?eDFPMHI0am9YbHpXSEUvY3FZS0EraW9UV1Rsc1RwSjRiSGwvNU9zOG9DSEYr?=
 =?utf-8?B?U3A1ZHJDL243amJrbTVKRk00RFFmWmo2UDNHTm1UNWxGMEVjZ2pZVDBpb2Vz?=
 =?utf-8?B?TzBIU2xLR1IveXhEOWEzVDlnV2p1QVlZZnZidEFSakdwOE9hUVk0Z0ZQam5q?=
 =?utf-8?B?clM2dE00ekhGRnFXb1VNOGJxdVh4ZmpxOTZwK05aYU96eElQeExTRHlGTkJj?=
 =?utf-8?B?S3BMRGswN2JXZnJ6aEZTNUtqK2toV0JFa0gwOXQzcTFCdjhmdEVzMGRlTkN0?=
 =?utf-8?B?dGM2OUVlRERxNzRBMW5iR2RZSVJNUlVrTDF4VS9pa3ZpNUdieG5POEtKK0pQ?=
 =?utf-8?B?dGtIcmptV0dYRTYvMUNueVU1d0twTVVLUGN6N0MvR3k0Q3g2ejJpaGZWQS9k?=
 =?utf-8?B?ZlFFcHVxYTRjdlNjWmx2cU9oSVhrdis4eDJYdG10NHJIcWVGUEViYTFIckZY?=
 =?utf-8?B?NUhXZGFKbC9IOUE1RFRBVEk3cmFycVhvUVJtUEhVQUxxb2V0cGpuRytkR1Ey?=
 =?utf-8?B?cXFHUDlEMG5GU1NrT1Q1eHJYekYvN2oxaWxTeHlGTUNBMm03cW84TnloZE9V?=
 =?utf-8?B?WFhXNmU3bTFkOTRKU1VHQVUvdVlINjBnRy9QakhTdjE4RVhGcWtQY3MwNmwv?=
 =?utf-8?B?RzRibGRwd1BQekRrQVpYd2M5MHIrcjYyYVNtRXg2NGdycFRQc1pNTXhaUEYz?=
 =?utf-8?B?MVNqbGRrN1JNdVBIenRqbW1EdmJ3QllvWWZpdjQyYWZ0VSs2c0kvQ1lxblcv?=
 =?utf-8?B?RmYzb05HWXFybFRlOTBRWXJ2VVRjSWVWMTdOU3psQlAxb2gzbUZNdHhVb0hs?=
 =?utf-8?B?U0lSWXROckJlMXI5elAxYUhXakxSVEs3MmpYSUdoUnlsWlM3TVZxbmwzSTA3?=
 =?utf-8?Q?WENjBxFXEnFRJJOLthCPuMGzy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128a1e2f-db40-4474-88a5-08dafe24e5d6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 16:06:05.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWTer2SA/tXm/FYZDJ4KItNFfBHPeTKl8qFdZpRPsxvLYR7l7dOqY4KBQrRyjB0q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/24/23 09:10, Borislav Petkov wrote:
> On Tue, Jan 24, 2023 at 08:11:21AM -0600, Moger, Babu wrote:
>> Understood. I am planning to add resctrl feature list inside
>> /sys/fs/resctrl/info/ in my next series.
> Maybe I wasn't as clear as I hoped for:
>
> so you have a couple of flags in /proc/cpuinfo which are actively being used by
> tools.
Those flags will be there. Not planning to remove them.
>
> Why would you want to move the flags somewhere else and do the extra work for no
> apparent reason?

With this series(v12) we have added two new cpuid features(SMBA and BMEC).

But these features are not visible in /proc/cpuinfo. Planning to add them
in /sys/fs/resctrl/info.

So, users can see them here. 

>
>> We need to add all the resctrl feature bits in info directory.
> What for?

Same reason as above.

Thanks

Babu


