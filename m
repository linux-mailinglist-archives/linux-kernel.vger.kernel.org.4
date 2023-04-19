Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED506E7CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjDSOaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjDSO34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:29:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B639E11D;
        Wed, 19 Apr 2023 07:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzwUU2Hj8gWeN3i1d9qczfnP1ax1wHGLzQb3aetEOXqvj1L23XhahIrq6Clgc+Q3wGs9LzYoVxS/+4J1kM5gvNpC8nKer1VzvUDv3+Oz0oE1+iEdDCKSzaGiFxAA9FAC9qFuTfTTdLDdS2VwxU9GK0s7Olb7g3jPFYAmZ5jpuVmUZk6aGrTAAfcivtP7ElCHgYUIq2tN6usZf3QDR8XdBkFN2HbMEjPWLYkKBoL4hRkonNgygiTROoXpByUBydHGwLPcOX710joJWABA2eF1nvSRa4sOcZALKckXkiJ+di14wFCJTS0YU3wEt95GMjSjlDTSpRV586+yngKvVFve6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=besdw75AmfmSYNorhwN6t7sE5iRlo3ONSGwlVUT7+P8=;
 b=eZBjUNnj9rlpPhHvwjkDs5NRBI0958s6pDlWMSFWiqrmlzCgY1zO+/agMkA/o48lldGpnQPk36hzd8nsFYVgx+FWOEo74mL8nkBn6aoSbohH4cx0DEc5N/3X0ALItRAaCXKQlwM9mZq/TX7Rpzw/qQS44X21A+HbvZMcHRWw+GerRyuap5ZBtECcXLKdKiwOEGUuu5FvFmSG2G6rkQT/myyV5KeNR/mSWvdvSChTYRZYvL5bdLUBUEOQi/x+kTj8m19tz98fLeBroRELUGGaTkV7hsV6NPK0Ml3D183oB1vhCCWoSTF7+j+ZvjOVGLR8akRTnqiGT5XkDNPxo0CMkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=besdw75AmfmSYNorhwN6t7sE5iRlo3ONSGwlVUT7+P8=;
 b=wbYc1Fkuh5n+nnh2UOAhIs+q08XevBunTNNU5PIrYAjQIRDQuLPnPrfMxKBndLIhReykQ5ElACcQeIgyPsoT09dTIfoqMJ4qu5RF7xbJIpzGC1j1z5xNNvS5U57Gle9lr48VWkyKF7YHpL/c7b6R/iw6q6+vTyUk3g9SDrtVA1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 14:29:50 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1%7]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 14:29:50 +0000
Message-ID: <cff27f42-2cf7-afbe-38eb-eef0a100bb27@amd.com>
Date:   Wed, 19 Apr 2023 09:29:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 3/7] x86/resctrl: Rename rftype flags for consistency
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     corbet@lwn.net, Reinette Chatre <reinette.chatre@intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177446947.1758847.11380042804869155387.stgit@bmoger-ubuntu>
 <6cf118d1-efbb-6c6e-225d-c93a1875eb0@linux.intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <6cf118d1-efbb-6c6e-225d-c93a1875eb0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0031.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 0579a6f8-326e-41ff-b493-08db40e28868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecxp6vH3CV6BugghOHmGy8ZrXNZbxhsoOGtjpXdS8O16lIpMQh7NfTO+UkEj/c8Tv71xqSSsw728XjWSG14HjEhHg8N/aA790rd8o/iX47RBZNGc/Wzh1j2ymv5T8gxHCaWwMPxNDUIg0KViil6QsxNMnAxzLw3JGtbM6BYtNicq5STjmIra4jlEHblPsmMtiZGFe0vg7G86Eiy0fMnT0Ax9UcwtcXA7d0GH5sjcfrw5x0orR1xaflY5zpl7nxUNzaf29aM1h1E+okGzA7yG/lHeBMOS4x/G3ys2n38CUnVD7W9767SWO53XuqCg7UIQUKgvaNaUsFOsAfIj26ajlWn47NBM/hUq8lDNAKVjjWflvYWTjD+dsFdgZX0hBONEfj2zGas8mFZL4825I2x/BSYwyOjOpkjRqqXW24e9+3/+kgqBpvohlTrzCuKhEfYQ45fvQdRsQBoH4DANtMYhHEtJBXyaTVY8eEc85L7aY8d034Xi8uCxejLj7jSQXcxadoeW2aVqb75EdI7zuRDTIXFtjjfnta7JS5T71eljwazZy0KWQmT9sSB2IVzzFSqBfpMf2Ax1mfeM0H7sZwuYN5DTtt9l9lOFFv1CkmT2sCDUcjRYVi0rzPQvu5VAKo7hHX0G0bnDdOi2+obO8Lbmmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(2906002)(3450700001)(8936002)(38100700002)(8676002)(7406005)(7416002)(5660300002)(36756003)(86362001)(31696002)(6486002)(6666004)(6512007)(6506007)(26005)(54906003)(478600001)(2616005)(31686004)(83380400001)(53546011)(186003)(316002)(4326008)(6916009)(66556008)(66476007)(66946007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QThsVFY2U3Z0V1E1blBXV3Z2SjNuMjVpa1NiTHhtKzdEdUwxaXdhSCs4QXN1?=
 =?utf-8?B?L1EvQy9QdUVicnZpeGJUUVlNN2xmY2tZUis3bnVhVmU4V2pvZUV5WW14Q2N5?=
 =?utf-8?B?ZDNXeHY0U0NBVVYwa2wxOUVUMFpVVWdYVGtrWmlRWGtVUklrb1QxMUNXeFBq?=
 =?utf-8?B?QXNROWFyYWVZWGZGL1hFL1pyZnd1cHBMZml5bXVUWjdjSnhNZGpEeWZlbUxQ?=
 =?utf-8?B?K3pFUXZjZWF3b3NZeWo0UnYvNUVHTVF5cmF5QWFERVZBOG96K3RFamFKMTdT?=
 =?utf-8?B?ZzRTQWh1QmFyOGFMbVdCKzR2ajJLa3JQZG1idlRrYnZwOHFOcjMyVVJtSmQr?=
 =?utf-8?B?ZFpnV3oyUDB5L3BNaGVvL2srZzhMR1VnVVFOWjN6ZEUxZUFMdDBwV2ZoQXk0?=
 =?utf-8?B?Q1Z0MFdVZVFqTnVyelJUbVJvQ29mcXRQamNKT1BQd28zbXZFUUMvb3c1bVVI?=
 =?utf-8?B?UEZlL0xpZi83RmZSNFFOL2Z0eFMxamltZEc2eFpXb2F1clZLNEtJWVYzS3lT?=
 =?utf-8?B?b2owVFlVZXcvb3pWblhzNGIwYzl5TUV4QWVwb0UyWTlFRG1SUVYvZEVrZGVP?=
 =?utf-8?B?M0I2WGRpcCtzU1lhZjJra0ZMeHEzbjhCQnJzNURyaDVRN3F0Y3VJZjhFckVB?=
 =?utf-8?B?cXdWVkhOSzhlRWlMZlhlUklTbEFEazZaRXBYMEtyNGJXV3dEaXhMZzc0dE1j?=
 =?utf-8?B?cVRzT2pSb01Fd1lla3JrREZrVWsrWnFiRys5cVUyc2RSMEFkZkg4ZFN6Zk12?=
 =?utf-8?B?Rk5BSVRQUnRHT1ZPVlIvY3N5WklOaXA1U1E1K3NIczErYVo5OVJ1V2tXMERC?=
 =?utf-8?B?di9adWtORW5SUnhiVkFJNHZ4QitjK2N3SjRrSXZkTUcxRlc5QmhsN0g1Qzdi?=
 =?utf-8?B?bXo3TU9TMnBtWHdkY01wSGVhSVpWZzNtUkRpdTFZV2lndlhIdkg3a2JsUlRq?=
 =?utf-8?B?bG0zMjhZNVF2MW5nZzV5TkwwbXRjWDNUd050UnVkdGFkWFgrQjM5c3U1UHEx?=
 =?utf-8?B?NWxyRFlMQVJkUVJkRnQ2VUlaTkxZcVhxb2lBK3IvZjg2cjZUdTUrZkNTTGJz?=
 =?utf-8?B?TE5SVWhXckk3SG5MeG9Ea3M2bE9DZHhobDNLV3FSR1JDdk9MUXZTWTZXSUs5?=
 =?utf-8?B?RjBWbWtHMTZYY2l5R3RzM3VTZXEvNmJYWGpwNzZBWktaVFVuU3c3RG9SQnZO?=
 =?utf-8?B?cjZ4YzdFYWJtaUhIUlM0TzQxYUN0S1FiVEc1R1NxdkhKdDllSkg3dkcrSWxM?=
 =?utf-8?B?NUhyaFgxWU82Zi96Tk1CMm9RSUF0cy8xaDFKbU5jNzdRdW1zemlrN3R2elRC?=
 =?utf-8?B?b2JaVStuY015V21GdmpLN1pnbDd3d3VWeHMwdkpISmRmV3ZxbzRZQTNBSVE2?=
 =?utf-8?B?U0hYY1hLRHpFTVk0S1UwRmpNSU9DL1lpVHd3R09zYmU2NjBodHgrMzBTY1B4?=
 =?utf-8?B?VFdVUUd2cmQvS2VPMmE5ZVp2QVlLUy9yajRDUXQzUEVyMmQrTTdGY1lYRGZI?=
 =?utf-8?B?aktvdGZXQ1Z0azJlNXdnVnpVd2Q0cTdzTnZNZHhhREd4ZEtSTU1ESC9qUU8z?=
 =?utf-8?B?bHhPd3NDT2Q2aTZBclh2Nkg3RGJPdzJ5Mjc2cVB2Ry9Qa2hMcXI0a1pDU3hp?=
 =?utf-8?B?TDhDb2EzZ053MlpCakZqVFBPUWNYY3kxVEVoK0tTN0N6cExPMWc5SjlLVk4r?=
 =?utf-8?B?L1BzSlJlRjZnQm9QNzRZeEN2Zk5HSEhKQndZOG1aQjhreU5XenhpMzBEUzFx?=
 =?utf-8?B?WU5tUTQvcHJaQkJKTUovMXEreUlVbG9rRXdzZm85TFdrbm5Yc2Z5c00vajZu?=
 =?utf-8?B?MEJEdGFMWm1CeUx5MXIyLzZiTkxtVllPQ1VXZ0ZCeExZa3VmbTdzd05Wb05v?=
 =?utf-8?B?d3R4bEwyaDBWTnpoUXJIYkIzN1dIN0U0WjJPTHkwSnNhRkY5TFRQUFpJUXlY?=
 =?utf-8?B?cFlUTlRVaDlLNEEvQStWRjNpRkxZbHhCSzBibi9RdDIxdzdFN2thU3VoM3Vj?=
 =?utf-8?B?bHpHTVl1VWhYSndlS0JLTE53R0NXSjVodFhMOFJyS2p0TlJHcCtaSGxXc2Jq?=
 =?utf-8?B?Qk5mMTIzZXVWWTR0MzEvajJVRmlJNlY3T0tibXB1S0dORm9UbzM5K2Z1N1BK?=
 =?utf-8?Q?N3Mw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0579a6f8-326e-41ff-b493-08db40e28868
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 14:29:50.1609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Oro4roN8I0cbKP5saRVPZ6F35DqLm9pIt8Wxt39wEGJroFO76PvOUVKxW4d6UB+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarvinen,

On 4/19/23 07:44, Ilpo Järvinen wrote:
> On Mon, 17 Apr 2023, Babu Moger wrote:
> 
>> The rftype flags have two different prefixes even though they are used
>> for the same purpose. Change the prefix to RFTYPE_ for all the flags.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |    8 +++---
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   42 ++++++++++++++++----------------
>>  2 files changed, 25 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 62767774810d..c4fc5a1c630c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -248,10 +248,10 @@ struct rdtgroup {
>>  #define RFTYPE_TOP			BIT(6)
>>  #define RFTYPE_RES_CACHE		BIT(8)
>>  #define RFTYPE_RES_MB			BIT(9)
>> -#define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)
>> -#define RF_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
>> -#define RF_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
>> -#define RF_CTRL_BASE			(RFTYPE_BASE | RFTYPE_CTRL)
>> +#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
>> +#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
>> +#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
>> +#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
>>  
>>  /* List of all resource groups */
>>  extern struct list_head rdt_all_groups;
> 
> This needs to be changed as well:
> 
>  * @fflags:  File specific RF_* or RFTYPE_* flags

Yes. Thanks for pointing that. Will correct it in next revision.
-- 
Thanks
Babu Moger
