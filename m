Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB06C65F071
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjAEPtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjAEPsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:48:41 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E59B5AC5D;
        Thu,  5 Jan 2023 07:48:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPB0STTp83iTIxXdPvGLJQmfB2nvj2TZqal1YTRAMa8MU+bb3OD5n6t9LMedX1c/7rjYP+srI35x+aDLAnxkLri9AYoDsXVDw/MSXeZBDIv7w/IjFTA43heORBSMpHqX1REVsbKsU8i+dyCTGMx8z1J5etuO1VPUsGSwmPNpsyLLmSDCl2bRS1Du6gc9df0WriLW6SKMu3ScWxrVn+8gi08wRBvz8ognlM1BR9SydJTaDj7wL5eV7wAduMN5Q2XLtBSRJ1OrAO+ufR5asIAlFAh3uCbXKXYoZvimp7uWDQsIKbXfwPHLwxUU+QVQFPbA2yR7CRFovdjRUK+QMMCwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCB/euLjibZNg6Z/6SrPLV4XZhJqh+94jzKrbPspfvI=;
 b=AwXzw+tGwhUa2myKV19lBfizJdLxNNCj0lJPUSSkKJv0SXj1s7z9EmEpVQ1Cs7hguux7QMxFcMmsVvS9Xe2rpOYsQ4ysb+XuoFzDtHzbeOnyvHfhqAgeRFtUf0Ne+3SF0faY6axGZBdIBI4oTCuDdy2AZYJh7f5thBOA/Nz+iU+i+e7iyelRaOWSqkHH3g62powQGye9viYXLmU05v1G2kYxeKpen/Z97+HpYWFBR/uEcmT17GKn4DtaBkQZadNjkcd3pwVRJbN0L3UARybbtUFRzXru7hhgb1qug7Rqz/DhOSYUfW1SX5aEBKd0jmiqRfnDwOTOpiI2nMNc/l0nrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCB/euLjibZNg6Z/6SrPLV4XZhJqh+94jzKrbPspfvI=;
 b=sHSd5Dd4COw9UYy8cVGixXD+/Oye0WhQiAtKxpA2I4bENqIcL3oHD/SLnmzKmSUl1EkxHNI/pQ35+faEnanGaxVopYp5KbzvedxaUyLP/wUMR+u/veTBhaH+Db4v9namIvTL5fn0X7ADW9rbIbruWIB3cP1SbWoyDJk/75BbgY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:48:38 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:48:37 +0000
Message-ID: <41a2523a-6592-0884-4e62-7c8cf598733c@amd.com>
Date:   Thu, 5 Jan 2023 09:48:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v10 01/13] x86/resctrl: Replace smp_call_function_many()
 with on_each_cpu_mask()
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
References: <20221222233127.910538-1-babu.moger@amd.com>
 <20221222233127.910538-2-babu.moger@amd.com>
 <a67ac446-807a-d240-254e-fe8d5596dac1@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <a67ac446-807a-d240-254e-fe8d5596dac1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:208:23d::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 96bc8ace-6e9e-4f5a-0870-08daef344f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXHUcFXD3uHVt6DBBqwhGJlXpl5IDYz7TlaqiXdRKEbsUpwlTDWxbgfJ4MtqEbKUqAdqjmRBLATDFNPsAqatXBR62Zm4oQWeuWVbmkV4xFREQSLgrbUcCpx3sd+fy0WjDx6JhE6xile8uCPE9Qzk0jAr5gvqCjIYwX4NS8ub5cRb655Iu6EckhXq9jYUW+T969MI8ux0Zm7AxeAF6IhCUsGtD1vMxqW1zEzS3XlNY9HBhLvKZlPmgRIJgPymdeT9bvASrJT980tlJgFA/eYLHVDatst9S2oVaKAdmbUHDCt005+XN0y00pNcgMmX+BlxMmZfMNMynXlLSeuj6Mfv3KU5/I5Jwsytb1KCDloQwjyHfPEUunWD2BiaWMQcEwYTnT0TVqZZvOo64O7ygD+lYa4JpOVwjnaFxrhJJVuRAlcyuM0XuqR7n/FTBOiZWZHaP9c2/jfYSxj69k96r346WecY133SmUUDsuqeQMaoKum15b5DV15nWjGS644UQCU0gbAE4UR/0ZD4W+R1/Thgq+oLbMQcNiIMDyXwvplQrOMLL7nJe8yVnl8sLYm2a8ChNtWlMWG83xp8UhVRMDvkprPT0r18+TAaTksiia1lbChNLzVtaDQP+/fNlQtOLMUXmlvovR3NSYIr3jEOEY60X+HPlDXnzET9DMkgIGUvpk5BCPYOtSPD6o2R4WV3o29RsdSe3e64oAYm297wMZVvvTfqQNhclEyOQBghL9DOeNo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199015)(2906002)(4744005)(41300700001)(3450700001)(6666004)(8936002)(7416002)(38100700002)(8676002)(66946007)(66476007)(66556008)(5660300002)(7406005)(31686004)(4326008)(6512007)(478600001)(6486002)(26005)(2616005)(316002)(53546011)(36756003)(186003)(31696002)(86362001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2dmQzhDbFA4WTNNczRMY2lzcTEwUXpUSVowL1JLSE1uckVPdFYwZ3haM29k?=
 =?utf-8?B?bTVjQ2Z6YU9jeHR3ejhqOUVKNmR2TmIwOTU0ZlF2czNnSVEyK2xLZVNoTWhJ?=
 =?utf-8?B?SEM4MkUwRVcxRHVDclk4MHM2bzFLMWxvaEMwSERieElzbHN5MExWc3RGUUVR?=
 =?utf-8?B?THR2WGJLUVdpbE1PcDBBZ0JVRGxDS24yRE5vb2lHMldIZHZCUllya2lLZ1dC?=
 =?utf-8?B?dTJYa3ZrTXJaektZWmRMdU4vMXg2MWlNcE5LVkpyZHlyZ2NIdlFSeHJFSFQr?=
 =?utf-8?B?VzJOOXp6SklSZnorVmk3M0hmNThNTXZadUxIeUpudUNNY3MxbCt0UENUcm91?=
 =?utf-8?B?a1B2UFI1S2dkRUxTV2NQMTE0NW1rRmVCWmEyaVdVaC9iMFRjeThCTzIrdFZ4?=
 =?utf-8?B?UkgyQ1l1TjByMEx2YTUwVHU3V2VINk1mSlpEcmZkRjE4RUtiTGQ3OEhKd1lV?=
 =?utf-8?B?ekRLd2dRbWV1MmtoODNaOXk0WkZCV2QyLzFTVThZNUZTRnlpWHo3M0lTNHp0?=
 =?utf-8?B?SHlpa1dFQ1B1SmhMNFdLQU5ybTB0V08vOHpqb1grcFgxbEFtSmQ3cU5YZ1RK?=
 =?utf-8?B?eU53QTVETFZtWE9vTVNQckhMT0trcWxCcGZIejhMYm13UTh0cjl3dmlyZTBE?=
 =?utf-8?B?QUoxODc4cnV5VGc0bkpuMUQyY3FCQkZkYnFQQy95T3VxdEk3cHZYVVc3QjRY?=
 =?utf-8?B?bktFWFNIaWxubGF1MFh4TWJ3dkNKSGFIaDBnam4wREJSWmIyd1ptWnBZVUxF?=
 =?utf-8?B?TDZqSFRBZ1JGUzF1MCtGMW1iRmhvRVIweDVCQ0NIdHlKdkxlYnp2QnI4Rmtm?=
 =?utf-8?B?TDY1S3ZtMTI4anhzUytBNFoyeTdBZ0YraFcxWnhOMHFJUWZNSVNIajd6Znpa?=
 =?utf-8?B?TmpnVkFyYUpxbFg5RkdTUWoxTWZiTmtDS2IrRmpMRUpFSlhlaXRpSmpkOXNC?=
 =?utf-8?B?VG1vWDdYVC9LVmIzMUtTVWs1WmtXRUdYbFBDZU5CbHNtQXVVOWx3eS9wa0hE?=
 =?utf-8?B?c0hLZ1RsVm95ZDVqR0tlaWVqYmVLMVVQUjVkcnMwVkNDaU56eFpIeFlnNFlt?=
 =?utf-8?B?cVJ4SzcrenFhcnBFNU42Q0gvdHh4eEhSN2VMNTUrNllkQ3JCVW91eGQzdGpR?=
 =?utf-8?B?OHVyME5CclNIaDBLSU95RFVJR3hxMXdKRmZjSDVYcDBsRWoxcnA1RENYUzdZ?=
 =?utf-8?B?TGJOaVFYc1BZWEtNT1BwSS9oQzJxU1VIMEFTK29BeVhoR3BKamJiQ3JwOXJM?=
 =?utf-8?B?N3J3Q294RVpMZmRoQm5RTVh3bzQvcmNjRzdvRFRtZFpqMlV6UzVoZWI1UVBu?=
 =?utf-8?B?OW9kVEZqZXFRQ0ZldmNGUWpCMWs0RjVQTnRwRnJBQ1UwZFoweitsd2RvVWVC?=
 =?utf-8?B?Zm1mODRPQlllK2pzZnNycVcyNVpqWFY1Z080a3VwWThDNzVZL2hiRVpoSmNz?=
 =?utf-8?B?YlVtQ0dTMUtjZUF6Z05hSk9kOHNETkVyWHlLYU5pZXdiR3dUUmNWcXAzNDYv?=
 =?utf-8?B?WC9HM3ptTXRWcTMzc0RzK2cvQ0NOTzFlejZtNXdYVkd3N21GdG5aOGNjVmZ3?=
 =?utf-8?B?RWRsbnNrcU9iUTBFWDV4RnhiTE1rbG50R3hPWlVuTlY4UzFVaHJXdzd5U0tv?=
 =?utf-8?B?REQ1aUZndndBMzJ3WTUyK1FDM1JQMDVLdzh1NzVmejJXdE1RZ20yOFNFdlA3?=
 =?utf-8?B?TnVML01LcEs4YUlRTVB6SWh0ZTc2dDd6cEZkZUNCRGlWYncxV0hVT2UzUmRy?=
 =?utf-8?B?cHJzOFJic2Q5YjZ2WVE2ZWMyWnBQN2EzVSt4T0ticnpFTjdiaHkyMHZUVE9T?=
 =?utf-8?B?N25iMEtlQU5CMVVRN1grb1F3TVU0eWNxYnNYK1lVejM5SjlnL3Fhd2hrdHdr?=
 =?utf-8?B?NHROb09ZbVVqcVNpSWQ4Qkk5WEJsTzZiU3JReG9rME8wK2NWRFVDc3NXOHBr?=
 =?utf-8?B?Skd4ZmlaTzBhdjljd1YyeWtQdDFLUVlWajBreFkrNlo4RUlGbUcvVHM4YVVN?=
 =?utf-8?B?R0d1OU4ra0JVVFRkUk9vc1dYdmhBcFRSYWpqUklaSXRvSE5ueUpwdS8zZVR5?=
 =?utf-8?B?Z2UzdmdpWE1QYnM1YVpLV3ZWNEFmSkc2Si93NlpLdFZYNnJFMXh1WUFCUmxl?=
 =?utf-8?Q?C7WxRw7QLTZj9rGC/31Gk8uUX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bc8ace-6e9e-4f5a-0870-08daef344f4e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:48:37.6884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5vpXiRL4SNTMFzrzPK3dx5uwKjKlmvXbn6hhKT/Dyjcym/AmFydKrrmePP3ayZx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/4/23 18:28, Reinette Chatre wrote:
> Hi Babu,
>
> On 12/22/2022 3:31 PM, Babu Moger wrote:
>> on_each_cpu_mask() runs the function on each CPU specified by cpumask,
>> which may include the local processor.
>>
>> Replace smp_call_function_many() with on_each_cpu_mask() to simplify
>> the code.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> Thank you very much.
>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks

Babu

>
> Reinette

-- 
Thanks
Babu Moger

