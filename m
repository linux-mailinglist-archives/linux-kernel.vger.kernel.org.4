Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB9365DC00
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjADSSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240206AbjADSGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:06:54 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B7713CC5;
        Wed,  4 Jan 2023 10:06:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLMVb0bxQMTng4YQ1zPH9OIxjqOp1FX8JZ/WdIg7hLiB8sBd1pV1SVN7bQAY3mRMWqA3jCWEsjKXVKFEJcEod9vMa8zjLHZZoajsKjHPEl+NE3f236er1Mytsk9bxds3adYuhcxvs00qTUl/7uXUf5fsr4VAjfL9Oj72xLiCiYrPXDYY4gMWnQNy1IB5g+aZNBinCJga3nOge6a4uO6pSlcJ2k/UHOITLGdlhpr1Ocw1E4/kB7cE69qwF3s3CFc+4KpxOoe+ZPfYgUQoR8Tr93JuS7tozFrORtXiY6CvFB23x4lbn5F4D1nxPRXFWcY8X4nDo7/lW/oG7K6BQLOJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKt39Yc7poS8Sq7Q929cVWckDfPgdF07zC0dE6/74qk=;
 b=AEXiVA+QF4fynfiZ/OsxK2ZXEbJlAjANRC5sqTlZ49ejAtGK+qlFrru8ZA2y0y1TKJ5SpB6OaCXvNy1ftFZR+dtROzRgmWUVX7zN/NwLP6o6Ct4zumQfxmYGDIZ+S2r6DjXEYc6dnZ4mZxGNwUwERWziajevweXDuePY4evuppijhwkn3FI/GrUMj7l2hW+29A+rJLu9o7m3SVE0ZPXWX0deGbiRDQMmuojqdjBxojfI8mHSGF/V4ZFHixwWJ9cZZafozZYyX3THIjr+PDKt1u6f/FY+2MmxmO0nC0Fk4Ch3SxVPcxvRQP06TEPArUeyeRWVnwYzQs34kjNfOW1lYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKt39Yc7poS8Sq7Q929cVWckDfPgdF07zC0dE6/74qk=;
 b=LdJfSfgDGfUCXHPu1XzAXJme6Y0dp8k9y/+6OXgslGjAwrrp0dURLU2MMgD5JNGm4FoNKNwpglhs91N1A2i/OaUfVmRwKY31I2RKsTWOsRTxc69ZnLHTlKH8IEaScSej1wqts9EjUQpHue0krPTpAvD+y77jy+8Gyjh0wLE6Q20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB5277.namprd12.prod.outlook.com (2603:10b6:5:390::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 18:06:48 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 18:06:48 +0000
Message-ID: <ba3be1f7-53ee-e794-700a-a9d5314b9c11@amd.com>
Date:   Wed, 4 Jan 2023 12:06:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH 2/3] x86/resctrl: Move the task's threads to the group
 automatically
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, eranian@google.com,
        peternewman@google.com
References: <167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu>
 <167278360189.34228.2442698916556329960.stgit@bmoger-ubuntu>
 <21a4f7d7-eec6-f04e-9707-59236c0f937f@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <21a4f7d7-eec6-f04e-9707-59236c0f937f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f784c91-81ed-47a4-e16a-08daee7e727f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UBS4ygi8P+pP2y1UXWCUsXqU8FlWyxIkZS00Jx5F5DeYh5FoihdGF5kmXTE4zXh+FDrvcgB/YutWx5mbEBcGu2tcoPm/MeIG7Mfh0l300Aict0ssKThZWGqfI9t+qRuOzAxwVVsXOZUgBAdcshR4bVgJLDmpio/pCjX+7aokxZ1bgwCZ0rminrKOvFgnNuPtjnkOkyI/Gnqzy0DqMmWKL9PAUuzgz++EachBOQm5jHlXerXidTTPkW1jhEe7B+sGO4uO1puG1pOb+tWSlf13u8w9FtqmRyalESjsGgUOX8cXysiDR05U4H4+afTJFSfzn4hzsofvrU4cc07hZZdN/0uBgURLtEQhvqU6VOfOIfZ4fycQ1ToFq/ZIlUtrWsB7Sgpbv3z8lP3nCCdXuXACU4hG6XqqDma07jWKsKPU9UEUAvQpUyjtMZvhYgHvpyRkiS5eoY7EYwH5KoS1kGmoHEgF9bJEH1+xtuKUVs4sbKU0qVRSCTeBMQp5kB3GkDjOcBBJ2YTKaTUHCNxxUIfQ3JoSpKikVwl+PsI6znHyo0RLVLRCRQzLOLtJp/O5DOLH+HKODeA7JDJT0a23lTymicfkyKTobG4BOcdkGy7+uUuWuWKn4g25KOjRVFv/7JxKQZG4CgmXrWWlTvKovVT+R7NJvoiz5P+/CoJVxG6aEIAlVVAtMf7tbIlzr2EZaI0DRuvBBY9LQ8CPo5NIFFUgzgU1hpPrXgUBUAohHlDEWtQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(53546011)(66476007)(66946007)(66899015)(31686004)(4326008)(66556008)(41300700001)(6506007)(8676002)(86362001)(186003)(2906002)(3450700001)(83380400001)(6666004)(316002)(31696002)(26005)(478600001)(6486002)(6512007)(38100700002)(8936002)(7416002)(36756003)(5660300002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNlT3FYeHd0TGMxVytDaVJ6VnZnYkxjZDVXdGdGVXBlOWRFT0pNZE9NUk9V?=
 =?utf-8?B?b0dGeDRRcWFCRFZ0bnNuTTgrcHY2Q3dSbFE0Y0pid3dVQ2h6VDYxZmd5OHo1?=
 =?utf-8?B?cHBBZ3padWxOTytCbkdaZlRuZGhGa3ZaOUxtV0dJWUxCb1FDNlNCVURYTlBK?=
 =?utf-8?B?WEJOTm80c2o1YWRhME9ZUjR0Mmt4ZnBVelBWQzdhYVprQ2tFOS9wNS9ERE92?=
 =?utf-8?B?VlN2SXAzOGFPb2c1emZVSzFpdG8rT3YvUnp5QlRQNVExdU8zb1dlZW1SajAv?=
 =?utf-8?B?TWYzRSt0SlBzbDRQU2pmd0RFVFkvbzJUQVN2eE5vMXRkUjZjazlPYllvanFP?=
 =?utf-8?B?dW1VS0hGejJ2WGdqd2t3WFB2cktTczUvSlRSZDA4b2tOWWNpaURsOGU0U0ZI?=
 =?utf-8?B?L1Y5ckNpa1BSeWp2MTE2YjZXOWNVUzBzMUprenY0MVQrVDA0dHpJYzNvWElJ?=
 =?utf-8?B?OUNRWDBiNVJGVS9oY05PVDlUQnh5VWhWN0hFVWsrMGJ3d3N6b1pnNUZ2a2pY?=
 =?utf-8?B?U3k5ZVZWc2R0ZTZiZktGSWxCaExwWFNkRHQ4d2NYQXZxV0Y3NEtpS1pLb2Ri?=
 =?utf-8?B?TjNmaGs1TTJhNWFMczBxSkNRL2YrKytOVm0yOEwydENGZnErc0VwQk5GUkFs?=
 =?utf-8?B?WlFKazB5RHovZVp6YldwdEE4TGtNTlUxYVlWTGp2VnNWVVVpT3gzbnliTE43?=
 =?utf-8?B?Y2hVa2V1bHVtTVBOTmpjclVjRUVqbE1rV3M5bEUxQWRlVzQveWVUOHlqVWhr?=
 =?utf-8?B?ZzZLbDY3WUFVbnFMRFBPNzIvNk5ZdldLU3FOYXAzL1k3SnZ3cm9oOVRpb2RG?=
 =?utf-8?B?amNaQWxOaTlwVnJucTkxcHJDOVVQUDdCV08ydG9xS0hOaTJMZ2l0NFI1eVV2?=
 =?utf-8?B?c3YvcEs4MUZCVTduc0lPS2NGa1IwYS9yMVBaR1VxSTN5MUlyZjBZY1lTUGNa?=
 =?utf-8?B?NEMybEJhdTQxZDJxb3ZrZEtuTDdsMWdEMTVEejZhbHplZ2NHdENkQklNWU96?=
 =?utf-8?B?WFM0eDVTeVNBOEFtaVdST256ZzlxYXMxYjMxRFNVWmRia1Y1SXVFL1F6M0Ju?=
 =?utf-8?B?RlFPaFBQbDJmaGhxUWN0WkFXcFBnQWdiektGdEs2aDRPd1ZubGxtYkJoTnZC?=
 =?utf-8?B?QkdiL1l1Wmg3cmRuR3NsQ2V1UWpianlOWkR0TnAyclduWkRrMkt3a0JJY2U4?=
 =?utf-8?B?VC9kRWRIK0k2S0RGRUwwT3J2RERUa1A5a2NpeUNEdVZsbnJjQ1lwaE1oRVY2?=
 =?utf-8?B?YWVGMG9hN3VRTkRBekw2VkZJUjB0cFlnbW45aEd3K1UrQXVqTlBtMEd5NVd3?=
 =?utf-8?B?Q09qK0oxbzMzdDRFT2w0WWhzTUlITStCak9TL3MzMUUrTVFuWldKRGZ4VVZk?=
 =?utf-8?B?dHRPMHVkeVd0Z1BXWkdZbk1qS1lwVEc4SkU3dDNQSTQ3N2pMU3dCOXA0TjQ0?=
 =?utf-8?B?cUhub0FTemxTaUs0dGRKeXBPK1dhajFHQXJ4NWVVdm9ESUlpWllrRGxiSDJX?=
 =?utf-8?B?TWNvb1NXdHByZjhJNnFGRUMxeVRIeHFMcUJFeTBRbHp2ajRLZmdkYkZBNWZX?=
 =?utf-8?B?aVdheUtxWElESXF1T0gzTlZKMGhQbnhydEM0RmtJVHJGTWVnVDhDbGtYU29m?=
 =?utf-8?B?VjgraFVIK0FPSEVXaEdEVWF1SVBrYXFLNHNuV2cwWklEK3dtQXB1UWdpWWMy?=
 =?utf-8?B?VW9ObmdvL3pTWkRTZ1h0Q3ZIZGlVMUJkTWVPRnAram10NmErYmY4clNZWkJT?=
 =?utf-8?B?alRzOXJCcmVpRzhtbXZDZng4aUFZOXlvZHU0WTdTT2NHMVdxNllwVFVWTDMw?=
 =?utf-8?B?U0NJTXZPdTViZXlBekdDNllEeGRJc2xPeDhrRFBjSEppbGpDMlREb053OEU2?=
 =?utf-8?B?RnplV0FRNGV5NHpjSStqaW9ZS1BsdmpsRGpYUGU4eFVkU2JwSlBON0QwWGRP?=
 =?utf-8?B?Ym8xR2FTTmM5em5zVER4b2s3S3VMTUtrd0tBREpEWEp5bC9XOWVOeVF3VDJn?=
 =?utf-8?B?TWsrM0YybFE5N1duN3g1dkRmajUvS0l1eVZMVGRIdk1JUmtsejdTUG5uZHI4?=
 =?utf-8?B?OFc5ZEdhcE5sZDdJOFdPRUlwMWVNYnhwYUJoY3hRWjZ4S21halFSUHlGa2VY?=
 =?utf-8?Q?AW9ySy3f75Ih8orBUFm3N3tNn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f784c91-81ed-47a4-e16a-08daee7e727f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 18:06:48.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvd/YqqNqsOBjXcqfz9TDa2ULrgFPPLcy0ul7bkdYg+DrZ5Fx7CyjQC9KWno/LC5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5277
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 1/4/23 10:43, Reinette Chatre wrote:
> Hi Babu,
>
> On 1/3/2023 2:06 PM, Babu Moger wrote:
>> Some micro benchmarks run multiple threads when started. Monitoring
>> (or controlling) the benchmark using the task id is bit tricky. Users
>> need to track all the threads and assign them individually to monitor
>> or control. For example:
>>   $stream_lowOverhead -codeAlg 13 -nRep 100000 -cores 0 1 2 3 -memMB 32
>>   -alignKB 8192 -aPadB 0 -bPadB 0 -cPadB 0 -testMask 1
>>
>>   $pidof stream_lowOverhead
>>   6793
>>
>> This benchmark actually runs multiple threads underneath on the cores
>> listed above. It can be seen with the command:
>>   $ps -T -p 6793
>>    PID   SPID TTY          TIME CMD
>>   6793   6793 pts/2    00:00:00 stream_lowOverh
>>   6793   6802 pts/2    00:01:25 stream_lowOverh
>>   6793   6803 pts/2    00:01:25 stream_lowOverh
>>   6793   6804 pts/2    00:01:25 stream_lowOverh
>>   6793   6805 pts/2    00:01:25 stream_lowOverh
>>
>> Users need to assign these threads individually to the resctrl group for
>> monitoring or controlling.
>>
>>   $echo 6793 > /sys/fs/restrl/clos1/tasks
>>   $echo 6802 > /sys/fs/restrl/clos1/tasks
>>   $echo 6803 > /sys/fs/restrl/clos1/tasks
>>   $echo 6804 > /sys/fs/restrl/clos1/tasks
>>   $echo 6805 > /sys/fs/restrl/clos1/tasks
>>
>> That is not easy when dealing with numerous threads.
> How about:
>
> # echo $$ > /sys/fs/resctrl/clos1/tasks
> # stream_lowOverhead -codeAlg 13 -nRep 100000 -cores 0 1 2 3 -memMB 32\
>    -alignKB 8192 -aPadB 0 -bPadB 0 -cPadB 0 -testMask 1

Yes, That works. We can use that as a work-around for now.

I will drop this patch for now. I will have to figure out how to handle
failures in the middle of task/thread movement.

Will have to revisit this in the future. Will re-submit patch 1 and 3.

Thanks

Babu


>
> Reinette

-- 
Thanks
Babu Moger

