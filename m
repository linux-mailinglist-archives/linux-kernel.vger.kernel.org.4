Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335395EEE38
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiI2HAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbiI2HAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:00:30 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262049E886
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG+yDkn31hz9l8pPZJOqvn8LlolT+3pQfptY2Pv1hbBX77N1Z/QUbMqs1ZpOokA7oos/18rHpM81kMHwH/JfxsJY85SYH4Biy0m7I3QnoEtIdb2RkaITz8vhRrYNVwwgEYwulgKUSVBZe8NUzJ6Hm7ddGpmj1uu4cIyPvdT0Pu2m6Rh7zAVY57fZu5IGsv0OaTba51eL4Buoh/7qXrBS3/DQDn7QhhW0gTlCJgpKJrBPdr5SNJU2ux79byab90WgzqMfNDhIRZn3mGS/DImGrFrAZ/tYH8EpGU4ezYZ1XHSTWe9qAOSFArDSoh4XgQOGI/oAFi7TKUYB2riFUMUSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeT8wbqDtlxYtCsYpIEHSuCg6FNx5F134deTi7tPgHg=;
 b=NYf3hl+EXur1fzxJkOYVdI2ocqwZDaul+XQ6oqdWK4jf/PWR8uwGEBD1cPmSZpFI2S7sXXlYuWeP4VpNrbIhxM1E4JODAYSvjHkh1pti77mkGHK1Nna+cnEhB2sA8KnfBqiyFhp4DwslBgOOfo9Kqqe0ATXbQQ7fKybZTnNqCwqvfQWdrgv2qlFkXvAf6+qDO1LX/9FQCalkeQ17Ev1gzcfMcFrm17tpGroPSZFt+MMZKnQmlC0Tj8h//okulrlhcHSSuwO9XaHZm4fRRs4PXi26Ker2GuC+qMiVVcwXLFEttFt2utib1pf1YpNphG900P4XuK24BEYwqN+72ZrNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeT8wbqDtlxYtCsYpIEHSuCg6FNx5F134deTi7tPgHg=;
 b=nVLPzBgt+mFjJ9Uk/8YNg30/OItnAcytGDDSOhUx+GdY0f4pIZRWDoyHuUkVoOzU7GVSqi746mL6yk+Orh47s+1iFayVQoEb0kMX1wyHcAddDaQnRasffUeja8vz3vg4Fb1LvhMyg2sCHI8nayHketZNG3wHd+irAhgYZ2rL4Go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Thu, 29 Sep
 2022 07:00:23 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::aff2:40f5:fbfb:5f37]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::aff2:40f5:fbfb:5f37%5]) with mapi id 15.20.5654.014; Thu, 29 Sep 2022
 07:00:22 +0000
Message-ID: <c63414d8-57e1-69d4-a180-746e415289c1@amd.com>
Date:   Thu, 29 Sep 2022 12:30:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] perf/x86/utils: fix uninitialized var in
 get_branch_type()
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ananth.narayan@amd.com, ravi.bangoria@amd.com
References: <20220928184043.408364-1-eranian@google.com>
 <20220928184043.408364-2-eranian@google.com>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20220928184043.408364-2-eranian@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::32) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: b321cf30-1797-4a26-fca7-08daa1e8471c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lpFbvw49ce3ytXd7AKcJjnNGfw67yV0h0/G8Xw/3qx3T5VllG37UwMULpU/1LlfPSRfkImDJRINVWV9rhG7LXJfIY80f0+SdVgc29As9+2sXMWuDlWwu6z/267eMVZ6nSIY+s++EUhNWn2HgXLk0WR0RHlaiVWjcaCQOQl7H4diIaE1dfmeXH5V1TXI6/t5/r8Udfo+TKKZqu3M+vsaByhcXFvLsxQvHbM62a6lLFoMKXHH1E6ns2MkLc4ds4pQN+0MyUxxHKcB8m5T5bq4ZqAi1WfmfkJ9/2iK5K/nO/T9oGCl/wHOgbECiayOD7ME/00Yl8fWleLxivXEpaJXNopaQGtUKsYZ1J4vxBZlMG8UhNnOaZcYDXwERFUK29rGsq0XI6Zu5TaI91ZJOHb6irublb893AF1eOAaotJZo3fToCl8AGC/BHWWRe1joXzMyk7Mwh2zOXS7881p0MBaWdHMQWKrlRm4UbJHZN+a3jmOyrt05qaQdTcW1q+Q9LHYnql/QhpiflSnMlJAcYRm1TIPiWmif/fe6kR+eLt1Aur9Dar793XmzpQ99oaGmUGfQTUmBPlXMXPbcI5FtkVaLxQQGjYM3RcWsl4pTsqDRhN47eiiJ1dBbO8uZak51QHChAXFKO6EeNMzHQeXOktg9az064kKii0yIoeMn2zV+oW3nJOhY9WgUULsPC6RKr8S/1IMBdWS2Gl0G68NE7cHYQZ9oUUu2u1Im14001r9i1AnmHP2KidOhC0pW9shUpkzZInlm9/lJyCTh/rSlacpsV+vcrjG4Is4NWz72qqqNxW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199015)(44832011)(41300700001)(6666004)(8936002)(6512007)(31686004)(6506007)(31696002)(5660300002)(26005)(53546011)(86362001)(38100700002)(316002)(6916009)(66476007)(186003)(6486002)(4326008)(36756003)(8676002)(2616005)(478600001)(66556008)(66946007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDhyTWpCdXVLQnpUYm1HdFJxZ01KRE5IY3FXQVgyT09MWFZXRTJsWDROek5G?=
 =?utf-8?B?U0xlUFplUTdDWXRmQ3JSdENWNG5GamJ6TVdOQXExYmVmenV0ckRKb3N2WXpY?=
 =?utf-8?B?QmY0KzJkU1JSN1A4dmpieEcveVdRWkY1Nm5jY09jS2cyTnNzejJXVTlKMm8r?=
 =?utf-8?B?NVlqTm5QaHBhaXdPY0RtRHdvSGpnOUZ4eE1SN1FLRGljcis1SG9UQ3IwK05i?=
 =?utf-8?B?OCt3c0xUVTlFVTRoZUFyK2F4dXhLUmE4SjExS2p2emF4MDU4SzU1em9NZytN?=
 =?utf-8?B?RGdPeFc5MnVST1N6UXVnSVloZ1MvQW12REVZWGVXcERIMjBsQi9nQ3B1TE5D?=
 =?utf-8?B?RjNNMkpCY0ErL1c1bSt0eEpPc3FZMWZsS2pSZjlGVkV3T3ZLNDlHaGsyQk43?=
 =?utf-8?B?cWJqSXNIVnNOcm80RGxlQzdZcDlQUVJMaFBKVS8wTUwyVncrUGN3U3dmMTg4?=
 =?utf-8?B?Z2VpU0hyRmMySUFiY1RLVzhQcHNaTy9KUzZhcit2a2J3Y1BuRlAvSEp1TGIz?=
 =?utf-8?B?VElJUU5QM2dNVEhEM0xPNkZiMk56NlRMZHQ3YlFZbzNOdWV4S01JZ25yQkVx?=
 =?utf-8?B?VU94cnZUbjVsVHJGU1c5Y0VVNFJmZDFKd1ZqMG5wZ3lvMkY3NHo2MjJWc2JN?=
 =?utf-8?B?dEtUUVg0Umw3T2o0MHlCQWk2ZDZpUERoczRGZXpuMGRSbld1bVlSNDlPMURO?=
 =?utf-8?B?NStsVHJHamU1U09ieGVlMFhZSlpiTllwWDFCanpHdUJZNUdybmhuZVl0dVVB?=
 =?utf-8?B?OFZrRnZOUW5xa2x5TnoxY3NidjYxNWZObTNRL1ZoMFJKT0ppazVCWnh5Ullz?=
 =?utf-8?B?d0JWSzA0cFIxNkdCWlJKaXZkeTdEMWptRXYxNWpMK3dsUlJodExLQTJkRHNr?=
 =?utf-8?B?Sy9VTm83NnJXeTVZbklwU1A0YmtuWmtoQmZQeWZMUWcwRDVQVENxUlRILzlw?=
 =?utf-8?B?N09TS3FYZVFncEI1bEE2YmE1ODZxTjE1MnJMRHpUVktNUjMwZmN6YU9ackd0?=
 =?utf-8?B?T0JoeDhZTm5QZHFySHhvVVNPUy8rUnk3SDFBRnRlLzRPVGpBaWRjcWRaL3E3?=
 =?utf-8?B?UHdLbjNkOHczMzdreDkwcGlHTkZMcHZZbjQ5dlJaOEdiaHFaYzJOSkdrbUdI?=
 =?utf-8?B?QXgzQk5CNk9NZmZVYlhJOC9kd2JPSGdnaEVWTC81V3g2UVViakdZYWhrajgz?=
 =?utf-8?B?aXoremxRTXF5a0xqK25kcmM2UXJGOUhReTdZYUthNlRrVkZDN085Y2w3TUJh?=
 =?utf-8?B?SUVoWmYzaXNQMjB4LzJNdk90WUpScmJnclpad1ZPMlRtVitnM1pOWE1jQXFI?=
 =?utf-8?B?a0lpdDZGcWc4QXdYdE9hQVcrcXZuZ3p1RHg2TVJnWFBrNHdKL2liaXF0Q2pC?=
 =?utf-8?B?R2NIUE4xVDBwMElyeHo4N2phb0xaYmNmbEtFQkV5YVFjdkFBeHBqUkdVSTFF?=
 =?utf-8?B?MFBVbWViRXVJUE1GZ1E5K1YrbFlrTkVxemJuZ094SEJJYnYwU3ZVNXRXd1JY?=
 =?utf-8?B?M3J6R1dsY2NsN3FpNWhoN0V0SS9IRVFqcDRGUTRVTEdub3VDZUYrRUt5Mito?=
 =?utf-8?B?d3FHQkVvZCtQVFMyaGFYVkdERlc3NGRwbTVsUWVzZU41SFFYWEkrd0FsOG1q?=
 =?utf-8?B?RmFqSnI3dWwxS0MzU1Qwd3l2RG1qWnphbDlUK1Y3bzdYdDdCUWcyQ1h1eFlK?=
 =?utf-8?B?NEhIaGhabUNFRTZTWGRVVlhNZnBrK3RDWmhRNGhuL1c0TGdWTzRUbEtKRmhQ?=
 =?utf-8?B?WUdsempPeCtJWFh2WFA1YnBQUTlHRHdYV2xTeDdqUlZnVVFDZzkrWG9kTTBq?=
 =?utf-8?B?N09yTnl3MVJtTThYd2NsK3U5QVltSU1mVXh4VHlYckJZVkhlUlRWSE5QRmo3?=
 =?utf-8?B?MkoxM3QyVGlFc09aWkhCbjVLbGpSNE1SWTdsa1lYWFc1cStaZUtJTFljL2g0?=
 =?utf-8?B?T2xDSDF6bnoxZDNtVzZvcFdtRDdnY0IrWFAwQk1VWnpYZXEyNlFNMm1XSzE5?=
 =?utf-8?B?Sm0vZjVBenM2QmhxcmtYNnMvNXhsZDhObDYvVm42K3NwMi80NTMycVFuMlFy?=
 =?utf-8?B?R2J1SXA3eWJhb1YzYk1EYmliZEQ5ZHRySFF1WXBoZ1A0bWd0dXppUmhJODdM?=
 =?utf-8?Q?GRqlI2LP+2cALYhHG9adkGhWQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b321cf30-1797-4a26-fca7-08daa1e8471c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 07:00:22.7675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6+duoelqBilKG73MMorOpZeoc/vClbX87pKDJKAhpXfkm54bubmy6DO48ovJ+cs4AsnISeb59OogsNV6ABWfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/2022 12:10 AM, Stephane Eranian wrote:
> offset is passed as a pointer and on certain call path is not set by the
> function. If the caller does not re-initialize offset between calls, value
> could be inherited between calls. Prevent this by initializing offset on each
> call.
> This impacts the code in amd_pmu_lbr_filter() which does
>    for(i=0; ...) {
>        ret = get_branch_type_fused(..., &offset);
>        if (offset)
>           lbr_entries[i].from += offset;
>    }
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/x86/events/utils.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/events/utils.c b/arch/x86/events/utils.c
> index 5f5617afde79..76b1f8bb0fd5 100644
> --- a/arch/x86/events/utils.c
> +++ b/arch/x86/events/utils.c
> @@ -94,6 +94,10 @@ static int get_branch_type(unsigned long from, unsigned long to, int abort,
>  	u8 buf[MAX_INSN_SIZE];
>  	int is64 = 0;
>  
> +	/* make sure we initialize offset */
> +	if (offset)
> +		*offset = 0;
> +
>  	to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
>  	from_plm = kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
>  

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

