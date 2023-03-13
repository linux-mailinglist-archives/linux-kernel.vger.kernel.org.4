Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37116B7804
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjCMMu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCMMuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:50:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F13C62D9D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hub/aGc4OE4pKL0BLErTSj7jzQZ4QQU1mByY8+0ktTtZbdsGKuDwkKqK5xI3juIPwe67mU6/4NK4t5OIsrSXFeOIMAbn7UdjKzsQsagn+lEIGWNaabzjSP9xwGWKi40MCFLE0B7k8fY1ffhAShF9F6qa/iK2aRYpIAYJw9fAxt9wbiRKKpPuGUBa+EB4uqPokaPYKkI+oPZrO806hImMNj+70EvbTqaGxBXuyJwguwQ8sJp82yGPWLXFpoygSwIxRh9C4IO/cXhJsT8zxzhnqYAunYBlOIiBVfX7CWbJKuwf6B1C0d24aB88wCF8Y97rp0UPg4/ugvaEKbf963vaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DQwqJHtPAdtpmQmG1xY3Py0BxoT4RPpTE2kky5amp0=;
 b=IfEF8EHnN/SXZT1q6Z9Zza3HShn5/v79oS6xL5R9q+G3KhufCxF+PjpOxFUzKh787pC0jZzW3uleozZMq2LtKI5uYZg1A9un+iUQQsEiuBeG1OfuD1qN6nKSvLh07v59Z0fvkdUK4nXgaN1SY2ezj5ELljPEY0d6at/+Q7c1Y3hzqQeIzhvRvOo7UmgRL2yhdmB7xsqOGvCjzJcHoNhhh9siVgLWfptJa7Oq76fQeqgrJRBfk2MvD8pGkyPUmm4YoKqxqWrQ/T9l23eei3WzLLPAS45RgPbIlF92LTOanKl1S7+1ScWbux7RyuWZG1Os7G9QEOO/GW2Xmx9w+g7yXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DQwqJHtPAdtpmQmG1xY3Py0BxoT4RPpTE2kky5amp0=;
 b=tZnG30E2tdSI8TTL6tXUq6yjyOpcFDO0y4iuinMFBkxljfFbC1ZhQ708SgqS/1y8O5h0TAkGUDUL/i3t6OXyZDTFYD6m5QNAm/8UgiaWWPx5HoC2XtJv7iPL0hYH171pbT7ddLD7lrTHFc0WlwvvalCsm8uaEG3B5ZPE0wlikJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 12:49:39 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 12:49:39 +0000
Message-ID: <4741f088-82dd-3bca-626f-37cb70621f34@amd.com>
Date:   Mon, 13 Mar 2023 07:49:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] x86/mm: Fix use of uninitialized buffer in
 sme_enable()
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230306160656.14844-1-n.zhandarovich@fintech.ru>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230306160656.14844-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0029.namprd19.prod.outlook.com
 (2603:10b6:610:4d::39) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SJ0PR12MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af71c5a-30c3-4cf6-ce74-08db23c1686b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1gy6J3uLKXgeC073tqsU+VYVKLka4WeP2zrlJBl2xe7sP2ERG30o/yJdB5EbXYKDjmakBkJt6eeGsqbjmQCfWpsbJkpxU7NwS7a8keQHM+ONLUnPIVpIDwVz+b1HH03gug8tGVDs0iaiqWIuR2rN0Ex/kLC6KJlqzJ+Qma0tc6BiEnvRXnIoSPYrlVsHHjph1EKFVzMZ8olC41Mjxlw845ItF+toU+UgGPaWGyp1N7hd368IHSI7hipadjLeNho6BlROG36hiYihcsUgiMzcdoYZf5pFXJvc0CTos5pVtyG4muTFXFUu8/F6PFOiBKxACjVkj8G450kyuqBQj74V0+AUAHB5Y8JMvzWUGvJp8N9kcRdNKaJyQEX3y0q8T6uqc3FQ2LDFfqofKjK6Lw/1pZ00sZKNndpLvClIXSiCBQrTVk4e6DgZAY5ZuQCkQEeFwtTRqSbaIBJ2FZ3FdcvZZpuN+fVb9DsoEe7nyrlNnwiud1Wz0TEMpoAlOVAIQXBMV8HxiMSdTj3GQ9Yx6xDuulyMbUJstjj3Zmnb784E2xfsLzedb4/h2iSgisI4ym/fF0VQxqXFem6ZQkkCYa05qTaJ1926VW/wbX98Pwooo9r21Kh/rU6iKPaJc/s5nnIcZBDcngx+IWwBzBJAAOplpmrTLMODnkpwZgy411SQ0b2GiKFnX0ZpiGNwweakQT/4l9n3BgPLNIYeb9+yYAy7TzK+xo01Xc87IBVSmbZGZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(36756003)(86362001)(31696002)(41300700001)(186003)(26005)(6506007)(6512007)(53546011)(5660300002)(7416002)(4326008)(2616005)(8936002)(316002)(54906003)(478600001)(66946007)(110136005)(8676002)(66556008)(66476007)(6666004)(6486002)(38100700002)(83380400001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHFuaWJ2TGp6WUxCMFFHNjJUcGl1dDB4UWFZYzN5Y1dyUENmQTJmR09ZdU11?=
 =?utf-8?B?K3QvZnpwMWszeFJ0cmN4eE9QMlJZNURYUVhZekNEc1NQSUJnYksraWtsdEN1?=
 =?utf-8?B?SFA2aUZTS3JYV1lFdVF4ZU5PbEdWL1l3aXllaUU0TFV6RTROQWlNWGVlNkU4?=
 =?utf-8?B?RTk2QlNCcnBtVkRNTU1DTGkwd1U1MEdVYmszK0ZUN2c1T1JXdlNPSEQ5YWpR?=
 =?utf-8?B?Sm5LdFYrbjZ3RlFUek9zYmhMMjZTUVFrS1M0QTBwMTZwMEVsWUtvblRrRXRE?=
 =?utf-8?B?MlRTL09IVjFnT0c1NjdFT0JlTlBRT1orb1gvM3dIcmp6M1hkUFR1MkhQWVpT?=
 =?utf-8?B?VVVHTlpUVkw3QTZrS3MrZGZBSkdDa2ZiKzl3aC9qSy9OWHVsNjlxckR5cStu?=
 =?utf-8?B?M2IyR1dwbUZYNU40THZlZmEzNlZSWTNyalo3TVRwWTRFZmdTMEs5ZGNLSExI?=
 =?utf-8?B?QWpCZHJhYng0VnlZT2sxL3lFcE9uY1I1K1BqQnNiamNaMlRnTGdFMnFpL0xU?=
 =?utf-8?B?OW1KYjNYTEU5bzc3anU0NHJDUGZQM3lYUGMzOUQwR1lXZWtla3pnUFFQRnVJ?=
 =?utf-8?B?ZjVENndjVi9jbVpYTGI5aU5ySnZWODlsSUdMNGs5SlN6M2ZwbGZRNVBMeFlP?=
 =?utf-8?B?WjV5Nk4yS2JQYjZJNVBySnhqZ2JWRG1jelhTKytHbUZxbjJtbXpKaTJDTVJn?=
 =?utf-8?B?UHI0YkJJa3pST05EeU1maGR5c1VVTmVWVy9vRER0amlYYXhHaCtZSUp1YTJP?=
 =?utf-8?B?empBb2REWWVXMHdZOUVwMENEV0dtMlA4UUpaZXAxWGhqYmlEbnhoeHppNW1m?=
 =?utf-8?B?T0pBeHhyTjdaOUIrZGl5ZGhoaVVkTkRaaEE2am1iN0hqVkczRGhub1VrNnU4?=
 =?utf-8?B?NzBGcWYwN0FsS0JndDZpOE9TaUErdjUvZE9zRGVSL29VVVR6dkZKU1pHVkZr?=
 =?utf-8?B?bnZGUmpQc2czbFRmek0yVHJobDRtMjZCMFQ4N3JUdDZPdlUxUUMyUFlaOVc5?=
 =?utf-8?B?YU9jT2d6MWVtaVg4YXpNOFJ5U283L0E0dWJGOWMyOC9UYk5nWEpRNzFoMXls?=
 =?utf-8?B?dkNhZlBERjJzbSttMXBESXZReWM4WVBzdlByRmtqMFp6b2FYaVAybEpWdmQ4?=
 =?utf-8?B?SitzT1lxRDBZc09DakY0TDQxUEo2c1hsR2Y5a3ZtekoxczVmeUdJQ1RobGRt?=
 =?utf-8?B?K1pLcDZQSWt0U1hEVjZ1SVBrMVNERTZFVEluM1JhbENjVTNJRUszQnNIZ0lC?=
 =?utf-8?B?NFc1SWw0NW9JZFh3Z1J2aEdvT3FHTlFWSVFwcTBSQTlSTjFORkdHdHlTajR1?=
 =?utf-8?B?VzY3cXlWWFZ2b002anUzeGR6K2hkSExOSjlQRlQ3Ukl5bndZUVgxY0ZPdEp4?=
 =?utf-8?B?d1owZnEzVWdBVEdSekgrR2ZyOXNwdXNIV0FEb3YwOGs4Vk0zZ1dVaWVucUVt?=
 =?utf-8?B?N05CQkJvaW90OHN3MkxFbFhDL3ZtVklYRG1XOU16Sk5xMm1ONTZ6WlIwZnYw?=
 =?utf-8?B?bzlDWUV6Ri8zUTlST3MwR2Q5QkZSWm81UlIvUmRPOFF5MncwRUZWWnk4MStn?=
 =?utf-8?B?a2pEZlB1YXltdEp4Nnl4eXdWM0xZemRpUVJTQ0s0SDA4am12Qnh0MXZWUDYr?=
 =?utf-8?B?b0tUUXJYOHNERnVuQWd0akFYNGdPK2dPZ3Jnb3BLQ1h6c1NiMEFrbmRhUE5Q?=
 =?utf-8?B?WmJQaFFtaWxCSjg0RTd4SXJBVmZ2eXJ4RHZZQmljSFpyWUgwOHlsQ05VcDBM?=
 =?utf-8?B?cm5Oa2hWM1krMUlrUnptT0pBZzdTdWk0UDRUMytDQjVaOGZUQzBPc2srcndT?=
 =?utf-8?B?VWtkK2RwNjlZVEE1UTdVb3F3cHRSK1NZNnEzUVZhcnZKSjdUeDJXdW1BK3lN?=
 =?utf-8?B?TGpRQ0FsZzNjOUExNHRlUzdUVW9XM3ZLOExiQ0ZuUjRKRnlraFR4R1JkaGJz?=
 =?utf-8?B?L2xrT1FLWHNHYitEOHdwS2M3V3BIUTFqRFh4RXROaEpxQkFsK28veVkrSDA2?=
 =?utf-8?B?c0ZWRWszd1hRYnUvU2d3M2Z0bk5YUExaM1h3eHpUQkZ4SWVycWhmU28ybjJL?=
 =?utf-8?B?aWNlT2FzRi9LcGZBNmthOFVjVnBXR1QrNFAvYWpRbmx4NG0wZ2t2UkxMbEQ3?=
 =?utf-8?Q?ds7EJ0AuvH/OeJuoxPJ41Wbzu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af71c5a-30c3-4cf6-ce74-08db23c1686b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 12:49:39.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IJuVlG3xFr+RVD7cAiSC8e76OVt1DDpxMMzpSPe+GkiNVWghdplRoEyKsL5FmKToQC89lXK9iNKd8wGKzAM8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 10:06, Nikita Zhandarovich wrote:
> cmdline_find_option() may fail before doing any initialization of
> buffer array. This may lead to unpredictable results when the same
> buffer is used later in calls to strncmp() function.
> Fix the issue by returning early if cmdline_find_option() returns -1.
> 
> Found by Linux Verification Center (linuxtesting.org) with static analysis
> tool SVACE.
> 
> Fixes: aca20d546214 ("x86/mm: Add support to make use of Secure Memory Encryption")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> v2: per Borislav Petkov's <bp@alien8.de> remarks:
> - return early if cmdline_find_options() fails with -1 instead of zeroing out
> buffer;
> - use correct Fixes: commit hash
> 
>   arch/x86/mm/mem_encrypt_identity.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index 88cccd65029d..c6efcf559d88 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -600,7 +600,8 @@ void __init sme_enable(struct boot_params *bp)
>   	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
>   				     ((u64)bp->ext_cmd_line_ptr << 32));
>   
> -	cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer));
> +	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
> +		return;
>   
>   	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
>   		sme_me_mask = me_mask;
