Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223D76F8AE7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjEEV0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjEEV0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:26:48 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031FD59DE;
        Fri,  5 May 2023 14:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1d2ruCIP1yk3/ZJkg8ziWmOmQJtgwualL6vn75ivhHDO9fLzPAATltJ17z4z/05o6Lhm/VrsyNgxZMEa4xzLKTnpTZRmXUNgSy3SoBfwpDVTt5c/W+BugHB0kbLq2xqe0mKA+GEcWicBhzVUM/ah0LEq3sRIuSsmOFNLMBqOwCnM0NBFhDzqb4X4qsQdje4nHRy/V4OzwMZhW+QDyL78/64Ox/lrsbKWSodsSctRdXTgFNe4YSiiCQkpKtSWM3JNTI3e2qyHyhQWqwMKs0MvgUDPfhynSTP0fnqulfbsvgt0zeArEammCrSl4ViOAp+iTkQ2uebf/lOGy8wdWSnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q38eUfHaYhRgQl2VGO5B7TfumyRTDBuISVuypjoTjMw=;
 b=XKaop8qdXhUPi1jyuN0ipOAuEoYOAc8dga7extoR00pLHY8P6Bt0d3JIaae5j8d7OVgUC30SZjpOojvMR/AHhJwpjmppI/cM8NdMImE3Ax7yqJPXrKH2rm/5/yeW9TuFuwQTTTLrfozoCejM7b1m5aGArnn5hFb2f9Wqul6xXL5gRnqpRlZOhWzP4bY0QxSSojC8Jm/ZkxkErlj39ai/qc3wLU9jvn/7tU8kdPLU/kA98BlpLen1nARTimvhv5/msgJFrJPlPVFrhVairkHvhi5NpS0PAPKEGh2/St0FQ5VbiqW31IWnWxmyn2u8aj+7GEduQH8NtvmW5N01A8KY5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q38eUfHaYhRgQl2VGO5B7TfumyRTDBuISVuypjoTjMw=;
 b=oVwYJpCD9iWEs+32tCA6aF9ftNjelNqetzd9PWE+5jPgxd2iDj9cFAA4k2teDslatCKwyRxs7ApmFIh+2m4SwAhDoihW0zWhcFYRb8lzjg1x8+x//85Vak8dWPe7NsoLcrd6l1hhopTdFO/ZG4/RbztsbtINwABykNk6qUFSkxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 21:26:31 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 21:26:31 +0000
Message-ID: <a32f736a-e488-419d-2595-64c4ccda8d72@amd.com>
Date:   Fri, 5 May 2023 16:26:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 5/7] x86/resctrl: Introduce "-o debug" mount option
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
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
 <168177448739.1758847.17451432454091802068.stgit@bmoger-ubuntu>
 <584e5928-058b-b9ae-f548-ca224323af81@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <584e5928-058b-b9ae-f548-ca224323af81@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:610:e6::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e0960f-ddd2-4902-32a1-08db4daf6509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lew+5VtkLp477cBtTt+sSTzmYKEI9qVjbDFxiMGVj/TcwbqJOAwE/0IqQ95Qk32nMk/Xz+mTLAt3bWwDJ8j0R/TJ9OC4SrLN6NPttsPWcGQzDc75IWpzCNal6gEiYB6tATE9qutduVsSRGZ63MRBd76tSVkoILkiHN+GdfBODw/hGy56DaMbYH94UR/8/3dIwBBeXDpgCyI2bMs+7Tq5F/nlhtw8CLczxK0FXXvpVr2nZTqkyfyZVLP/nengJS/wJaR5JyDXGKInmk6jyziX5DLcngC2lZx0h9EdsiNRmSQIbAlHCF5PIjRN8L/T4/yv07OXZaOT7klwB9b3qSb0S0ueO5USt/3cbRCDnSkbvcIGNz+5Df0ayEjuM9ByyI+k+5qeygMw5stj6ZmH6Sg8wZqoe6kZ7YGJ5LWzq5t30SqRwj2Z32Rj+u9ZD0/uUPyd3HdOXxDgdSr/TbrH72Y7erDxpVj8ZeB27hlk+vw6JojxppXzdxCrno7NxeJKSbYytrvqmicXTG2pYG+V6JQjkgHS5HpEk6M1v5jCGUus72dw+zBdFsTPnVS3eXwHfgsnBsk94Ufyt4Px1sCrvMORGmjdJNleuj4b8O1MBvAI8CJs/Ntc1cew1L71yud1JLgaa5tHi8frsXR19WUcyd+KUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(31686004)(4744005)(2906002)(5660300002)(36756003)(7406005)(7416002)(8676002)(66476007)(8936002)(66946007)(66556008)(41300700001)(31696002)(4326008)(6486002)(316002)(6666004)(110136005)(478600001)(38100700002)(2616005)(53546011)(26005)(6512007)(186003)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFJSTnVveGl1Zk1lY01XTmYyWWpZV0dSaDUxZHFZMndGclBnL3NHWDlzcFVV?=
 =?utf-8?B?VHlkbmtMd3pzWTdYbmFLbkNsZ3NvNnJKNGIxUHB6UTU2SHVPaURRVDFaUXlQ?=
 =?utf-8?B?WTlPRm1HRi8xanNxRWZqZnFmQkVRN3RXYWcwU0xhZG0xd25STmJBcHlJTE1z?=
 =?utf-8?B?UjlOc2gyRnBabk96WnBOcFhJSXEwSTlacFJNZVNGRzBXMkpwWWdreDVPY2Fm?=
 =?utf-8?B?aVJVamtlT2dhd2JRQmF0L0ZnekNFV2tpZFZSYWlCaFdhZ1V6czlGQ1ZkbGtk?=
 =?utf-8?B?RG1EbkNhODdmVEhiVWRzemJFOHNGKy9kQXVZNWF6NjhBSVhuSmx0RFNYbFZp?=
 =?utf-8?B?RkNndmNIRk94dlRpRVhpRGZwWGppODF6a1lyWW9yTkp3eGtDV0dYZHFHbjVn?=
 =?utf-8?B?SjhrcVpxYkNXMWM3S3BNVWt0QkF3TXNGdnFCcHhDTk1mdWFnLysxV2xzbmxF?=
 =?utf-8?B?S1RjRndZV290ekJRQ3ZSRU1tZDZCajRIT1RtWVVtVExDSU95QU9IbjNMQm9L?=
 =?utf-8?B?d2VnakU1TzZOV0g5bXo0bTRQeWY4bHRwVXdtazFjVXNaV3hTMG1qbGc3NUUx?=
 =?utf-8?B?VHpvUjJaMVJIaUZqSy93NHFxS1RMaTNKQit1elcwL0lMVTF0M0kzRE1FM1Zt?=
 =?utf-8?B?ckNKbTBQWWJxWThleUxDWXh1aVFxckJSMGthaHhkSlFnc0NPcUcvMVByYlMw?=
 =?utf-8?B?RnpZNzQ3Mk1ianY3aytpVVhGTmRJZE1iSU5QUDhKUEttTk8xR3dwbW9jNzFh?=
 =?utf-8?B?ZTJsOEtaSW0ybnNyN3phN2hBRUZoOGZqQ3RnelhRM0dJcUtkRG9CWDBXdWFh?=
 =?utf-8?B?cWZ6TUk5R1hLRzBNaTRwTHZVd0JGUDNSOTlwRTBNSGFMaGR3UnlMblUrZ2Vp?=
 =?utf-8?B?SlJhRHFzM1BKVzhRc2cwalhYVWRJU2xIRTl6SG1qb2FwNXFFREpRdEhiUk9i?=
 =?utf-8?B?NzZycVM1L0x1QlFMMWFPL2hLL0lVTitob2RiMkppTW9TcWpKZGJSNFFRb3N6?=
 =?utf-8?B?TGZDaGpOY2xIY0piZXFaem5ZSHU5SzhIKzlUUEt6c0Q1ampMRisvS3dHbTU2?=
 =?utf-8?B?K2U2RUQ3MGliZnBOeVVKM3ZEZWhidXhzUUNQaGJLWUJqdXFZcGF3K3BTWVpr?=
 =?utf-8?B?TytycndJSGs4M2dTTnBqa2dGV21uQ3MwSUlRYzkwd28wcVZsQUVRQVd3bGNi?=
 =?utf-8?B?Y294YWRzK0NPNW9Ta1B6aVhKZDBZcGszYXgrblRKdXF1YUFHYW4rcGMybmNp?=
 =?utf-8?B?aHdUQyt2K1FNMlFUQllNZzJJR0Q2ZjVIT2VFQXpUZnp5STJzV1o4dHZEc05m?=
 =?utf-8?B?SjljL1NxYTU3blIyWlBxT3NJQUFsS2hNNGR0MWFvM3Y3WFZZT09Ec3c3eVU4?=
 =?utf-8?B?SXA2bGxsM0tOZStVYkVsb214T0I3M2ZFL09WY2Nkb09JYVVGd3U3TVlESG5O?=
 =?utf-8?B?Zy9iQUJ2dm5zbkt3QVRObklkc0IrTG9VTFdxaTdJQ20zZG9YT3llMnFGblpy?=
 =?utf-8?B?L0FZWkRvMFJ2cnR6ZW9ZYTdIRTdra09BZFE5Zm5PWG9IMDhFazRzUG9SOEFV?=
 =?utf-8?B?am4wWGpxSnFlaCsrMlhOUmNOVHBwWHZ6WWd1ODNkK3NqVlZRSzllMkNqMTAw?=
 =?utf-8?B?eWxYNnpVQnljaVJpd3Y1WUN1Qng4N3ZZdVpSejNaSzVWa3pEZk1iNG9taDJV?=
 =?utf-8?B?Ry91aGR1Yk05VldlcHR5Vmd6YmN6SVFGL3lOWE1sLzl0SXY1amV0eDhPWmFO?=
 =?utf-8?B?ak94QUZiZXY0bmd0TkVodHFyQ0k4anZvUFRITjRQN3NlcVd0dDltRzk2RkJq?=
 =?utf-8?B?ajYxaWJ6cTFvS2pRTWdLWk82dkN1UEFrR2twRWU4bmhMVmdkZW1qelFTRDVm?=
 =?utf-8?B?a0xpcmdtcG9wQzZxS1J2Q1owcXNzZGZJRzFlemt2UzBuNStsN2R4d1l1VmNR?=
 =?utf-8?B?UFhXU0xkaVZIQ25HeFZCRWgrQ0VTcWpWZzB5MlZXc1FZRC96bjVmc3pkSVhn?=
 =?utf-8?B?ak9SZDR2V0wzYzJlSDVVN0E1Qkt5Q2tYWDNxdW1uYUlwS2pXakhRVS9rbGJ3?=
 =?utf-8?B?clV0bGVjZHpMbnJhNHpDOFBuYW1yZzBzYkZ6cDNmRWJZYUU3eGQyTWFJUFEy?=
 =?utf-8?Q?J9pEt1khqSoevK3j+9V+mwAfP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e0960f-ddd2-4902-32a1-08db4daf6509
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 21:26:31.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIsUL0WsH6g+q64mE9JBBmOU3DqgGHCkbHCvluejgS3+YTtOQjQEbcabedMpMuHx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/4/2023 2:02 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 4/17/2023 4:34 PM, Babu Moger wrote:
>> Add "-o debug" option to mount resctrl filesystem in debug mode.
>> Debug option adds the files for debug purposes.
>>
> Could this changelog please be expanded to explain what "debug mode"
> is, why is it necessary, and what will it be used for?
>
> The changelog mentions "adds the files for debug purposes" but does
> not explain what is meant by "the files" nor what these
> files may look like or what "debug purposes" may be.


Sure. Will add the more details.

Thanks

Babu

