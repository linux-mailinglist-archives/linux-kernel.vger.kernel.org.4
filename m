Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CAF628B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbiKNVVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbiKNVVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:21:23 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E9613F96
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:21:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsXKXQikQmgMFHV9PHqFDvllbUmutss8hfu1H39Lufz6MFG+horm50GQGr4wBZlTSgkwr1/itc0dm18CMxH5mOgCsOvtK+xuy/+s2v/BLTaT6oeCu4o0MqpMz8ThM/BGAn1IrmLPNsHV6plZUuUajoHs0SuZx2IwJTrIxrJu/nHYfhkLGfM5+7P/1Ip1Tckgdtr9yA0llM9DcXkHKqvDLVXbVE0N4lBbnOsLUFXtGmOcj1OrrPNUxFA2KJwfHi3nfx/cYkjOOXqHvM5uFSR6dBIeQLC1BaOMNkofYm0p6X2M6Lx1dNeuUzrK6cOrjbwFLcDJBwXr+DRT8Pn8bZpcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzE1v1tUx37vXg/YNjUILJ70OPTgfJKBY+5xT2LFik0=;
 b=RCdGLJKPMeYIs1+xQzMu6qIabZ1ji2qOE8+JZTgt1RYI2itLsXL8U6N5MTYtPdqm0pQYPf9mkAYhzW20I7KxaNaHjg+GRicVF6jL4OB116B6iO6tHmSigW0pXt79sFrrwW3UGQsZNUbRF1mXGBRD+oTuI1PUlxaZzEDtdu1kaoVQUOVgHCKs0ggYcQRKDn5ad/QL0/zHJhiWlzc0C9OuT7e/087VdYeB4QgVeeAyMfIX07KvHwG+wbID8NKSh8Ei7gFSEEcqwPo78hWeIPLTRD1m784yqpoqjWPfcke01wmJkXpwDcrpUeSu356rKip2L7WxCnVcs5HzVSkYDlrC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzE1v1tUx37vXg/YNjUILJ70OPTgfJKBY+5xT2LFik0=;
 b=yxxxTwgwG9vwg7isf/60kInCg6A06VgJh+LDVoy5uCdPir4EG/UNW3V2lfduqQ/0H5GJaHea1juPpVUQbezNMwDG/lwNMRFBpDLHlDY4ubJm6FdF1Bkf92NW6V60QxCJaJXWbyu+4tdwneBTF9w17AJmLOJhVrNRxEGCR6V/YqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 21:21:19 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 21:21:19 +0000
Message-ID: <b332c967-cbe5-891a-3d15-f9fbb514d8e6@amd.com>
Date:   Mon, 14 Nov 2022 15:21:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 4/4] virt: sev-guest: interpret VMM errors from guest
 request
Content-Language: en-US
To:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Peter Gonda <pgonda@google.com>, Borislav Petkov <bp@suse.de>,
        Liam Merwick <liam.merwick@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Haowen Bai <baihaowen@meizu.com>
References: <20221104230040.2346862-1-dionnaglaze@google.com>
 <20221104230040.2346862-5-dionnaglaze@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221104230040.2346862-5-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:610:38::45) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5eaeb6-e8ac-497a-0219-08dac6862c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0U3iRASZzjossWg4S3JBqFOkcWDej7JWbc//wqCm0yA8xMvonPk5aCTeCYuNW8rq7+j3G6dUdspkJZw+OjeWwwq8yJi8ry1u40GOBCVWOC9QaZ8QzN37qk2dgMo1fr9yG/JYeTq9cgxwEwLvpL/rFNoYluPep2Nl8zoacXS3P/Rkg+wZObV+N0qq1UD+1uazTXPTgUgxaBxOpy9UWmBXxHfYAGWtp35FH9n9NweWox0a/SLpqklEdM6iqCPidf/Tj3UsLYXSVryMd+5yyZdjJ0Vp8nrj0PrQZd0SA0GuHWL9ySrykqxkMsFWq3KvvLo76TAc29qXCo3fJ8EVvbtxIppQH/srtLsUuLaR9SCxFDc3qOYzYk2cDykHB2lrR0D3fBSMvF0yWyC6xl83zfEaYZ7NS4Y7yuwrucG6rnCEXU+0TvhPo+XKn15XT6L8CxPHSjYFMHBysMii8kJPkDGqKvPMbtljnHtzSsZ4ffoAtBtI7tJ5EMIrt2lAogJrfv5dYMA+sSpb/tC+Z2C4oDjs57TV334+rOAvidorLByeOSr+TPDUa8SJ2tWeBQQ7RxYA7RAYNLkkQLtDhhikO2ldVb2BwNtDW0ID7uznCaN9MjrGYzblKHDhB6w7XOt3f04KU0ZvbFoCz8+RTIZdu/+XJS4Yh1cRrBNS/szLuJ/Z689Jyn9CuBu00w7usF4HRMwu9RYEAFP20s0+VBIJjZr5EHx/mN7UkK3tSM7lMVnBJ3XnxEFdVU2QI7rvL9mgnoENJNR+ol2zZ/ZI4iC4KlvadwZcI4QRKANtc6HwfWCj7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(54906003)(83380400001)(86362001)(31696002)(38100700002)(8936002)(41300700001)(2906002)(5660300002)(316002)(53546011)(66476007)(66556008)(26005)(6512007)(6506007)(186003)(478600001)(2616005)(4326008)(66946007)(6486002)(36756003)(31686004)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0lGTkkvQlcyZ1hKOXcvUE5KWWQva0dLTStNOFZMejZxdWFBNWVrSG1YQTBG?=
 =?utf-8?B?bUVkbTJHWUtQYzBCVjhQMWd0SnkxOHpCeTg5cW5ZNVk3SXZIQnlLNmw4RWVL?=
 =?utf-8?B?RlQ5MzVQV2VrWWF6cDRnNzVHOFdYRk52N1dFTDExZzg4bXJiN3FVa2g3b1NR?=
 =?utf-8?B?Q3lseVYxRGZsTE1aMzVtMmZ5NlFSc0ZpMW1RMnRWTGFyYkYxVmZmd3BPU3FD?=
 =?utf-8?B?aXZxZUQ1bFZWNVpOcDZWc01EUi9XdjFyR2xEUUw4akR2U1ZWTCt2VlNrUWN3?=
 =?utf-8?B?NzBOM1BYcVpieEtXZWFsblpsZTBQT3lKWFpac21FTGo2Z0NkS2oyMlVWMmxF?=
 =?utf-8?B?US9jdHlrOVpOMFlYYVFqRW8yZkhSdEh2VU52UFdJQ0FvY2xqWkRxVE1xRnRP?=
 =?utf-8?B?Q2pQRXRKOE9xRU16VHp3bzJXdldydEx4RE5BbkJsYXY0VHljMm01ejc1aExU?=
 =?utf-8?B?YlpuallmU3krTHd2bkUrMjNVb2tKUmx4ZUpjcnJJVmVaaURDazZmWDJKVEV1?=
 =?utf-8?B?MDJXQ2NKemJwZTZ4VHJFa3NWcUViUDRjdjQzNjZ0MXVhNkZOa21McnZrMlEz?=
 =?utf-8?B?ak5SMkpJRVJCZW5VTnpDUitBVWxQWU9OeHNNUGxLdmpacVFqaFR1WWh3Y1NI?=
 =?utf-8?B?aytHSlE0aksxUGhBZGpRN1FZNXczUlhVQi8wN0lySDRlcVFSdDI4MWJuREQw?=
 =?utf-8?B?REl3VldnRkhBSXhnUWJCMmhvZ1B1S2VyRkcrdXJ5eTNwQ1huWVI5ZCsvc3Yv?=
 =?utf-8?B?NDI2REFvcWs4Nkk3ck00eDFheFpabHVEYWZheWx0bzVQK0JGMmJ0d2FYM2Yv?=
 =?utf-8?B?b1lEdzMzOWl6K3ZXRTBkUEZnZ21kQ1hRMXkyQisvdlNVOGhvWlB2K040UHNG?=
 =?utf-8?B?eHAwM2ZheGU2aGpXN3FPZ2cvb29DRkVWbUlsZU9odS9ZKzg3K0RuTFovTUhI?=
 =?utf-8?B?dEdMaFJ2ZmZZZmIzMHdnN0lMYnQ2QUVDbnJXaGNBR3JrelJaMC9HZmZzSHpp?=
 =?utf-8?B?WlVNL2swcGhPVExjWDU5cWkreTd4R2RudHVoSUFUTmx1WXU1eGtzUmJ0Z2gz?=
 =?utf-8?B?SGtYTzRCU1B6c1NCU2xwQllrT05DZzFOQmpRdnNkUmFITEY3SG91ZGZCdW5x?=
 =?utf-8?B?K0gwbzcvNWcydHdQTldUckJXR0JXZHlqMVhIZjZlcGNBcUh2djg4cFVNYUZV?=
 =?utf-8?B?bEE1OFZXbkdLZFVyK3o5dVJyN3A4Qk5CVmNXZmtzcU40dXFFMzZFWWYySU5G?=
 =?utf-8?B?TmxKZGR4Mm5pMC91SEViK0kvVXU5Z2RqYy9iOUR6VFpGUWNuSHRwY1l1K0Mw?=
 =?utf-8?B?V2UxbzBVN1lIM0ExUTQ2clhHM2FsbHJpdmF2NkRNOWdOZWl2MDR4U0lGN1NP?=
 =?utf-8?B?ZHZiWFY1OXNxRmNqMzB6SmlyMStkQ3pSSm82UU1sZWZMYWtGUVZIRFRiZXdj?=
 =?utf-8?B?eGVBdFVBbjZ3YW9mc01Yakw1blczYTYzeHppUFZQUGdDZi9UQWpyVEVIT1dr?=
 =?utf-8?B?V2ZZcGNUYXpGYVJ4bWVSSldac1VZaGpCK0NYc2hIbEdvQTMxaDZXRVlQKzgz?=
 =?utf-8?B?LzBHem1uNFRCWTJobkxzZWFwQkZyZTVQVFB6M3lxbitOVnA2VkRBWUtwQVdU?=
 =?utf-8?B?ZHJzYU10WGcxSjJJdTl1bUc2eXJwV1Rrd0c4OU8wL3o2a3YyaEs5SDN3OEJN?=
 =?utf-8?B?Y3hLaktQTEdvRmVnalU5Y3UxckNqd1ZYMWtwR0VaM0dVWEE1L3FVNzdIU1hs?=
 =?utf-8?B?Umx6TFV0Q0ZpREQ5aVBGTDljbFNKZVQ4UWcxWnVMZ2k4d3FoTFdBMHM3Mmo5?=
 =?utf-8?B?eFlUZzlUUzBFdnZKWlFNK1YvVVZKeXAwVzJCbTJlaGxURmZjR2t4ZFRrcVBl?=
 =?utf-8?B?eUZRS040MGZEWlRmRjlTOTdzSVhuQitwbDFxRzJWVk1JRThlc09kMS9ieXJJ?=
 =?utf-8?B?cTRtWEt5WHlURk5KaXQ1d2l3UzJpVEFtZktOYVNja3VNNHh3Rm9RSmIxR2Jo?=
 =?utf-8?B?Ulh2SFBCaFNteDZkQ29hVzlYN3NjTHpTRUE0L1FqWjhBSjlRQkI0VzdKOWwr?=
 =?utf-8?B?WW12aVBnWTFoUXlERkNQUTlOMW8yUFRJb3dyTjJWeWt0T3JUZlB0cnkyYTJK?=
 =?utf-8?Q?/BwAU0SRxpLi/BW2TYf1H9ku8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5eaeb6-e8ac-497a-0219-08dac6862c3c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 21:21:19.7331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gg48lwG8F/FN+a9AnfTmxpplSAv8mrSHpI7eRljxqkv+9IQEDT+uSYEQkUsdHQ0UE6bJY69W3uUJmJwyuZ0Jtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 18:00, Dionna Glaze wrote:
> The GHCB specification states that the upper 32 bits of exitinfo2 are
> for the VMM's error codes. The sev-guest ABI has already locked in
> that the fw_err status of the input will be 64 bits, and that
> BIT_ULL(32) means that the extended guest request's data buffer was too
> small, so we have to keep that ABI.
> 
> We can still interpret the upper 32 bits of exitinfo2 for the user
> anyway in case the request gets throttled. For safety, since the
> encryption algorithm in GHCBv2 is AES_GCM, we cannot return to user
> space without having completed the request with the current sequence
> number. If we were to return and the guest were to make another request
> but with different message contents, then that would be IV reuse.
> 
> When throttled, the driver will reschedule itself and then try
> again after sleeping half its ratelimit time to avoid a big wait queue.
> The ioctl may block indefinitely, but that has always been the case
> when deferring these requests to the host.
> 
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Liam Merwick <liam.merwick@oracle.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: Haowen Bai <baihaowen@meizu.com>
> 
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

I'm wondering if this should be targeted at stable so that older kernels 
will be able to handle a host that returns a busy indicator without 
destroying the key (Peter's IV re-use patch).

Thanks,
Tom

> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 49 ++++++++++++++++++++-----
>   include/uapi/linux/sev-guest.h          | 18 ++++++++-
>   2 files changed, 56 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 5615d349b378..e8a9c07ea897 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -14,6 +14,7 @@
>   #include <linux/io.h>
>   #include <linux/platform_device.h>
>   #include <linux/miscdevice.h>
> +#include <linux/ratelimit.h>
>   #include <linux/set_memory.h>
>   #include <linux/fs.h>
>   #include <crypto/aead.h>
> @@ -48,12 +49,22 @@ struct snp_guest_dev {
>   	struct snp_req_data input;
>   	u32 *os_area_msg_seqno;
>   	u8 *vmpck;
> +
> +	struct ratelimit_state rs;
>   };
>   
>   static u32 vmpck_id;
>   module_param(vmpck_id, uint, 0444);
>   MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
>   
> +static int rate_s = 1;
> +module_param(rate_s, int, 0444);
> +MODULE_PARM_DESC(rate_s, "The rate limit interval in seconds to limit requests to.");
> +
> +static int rate_burst = 2;
> +module_param(rate_burst, int, 0444);
> +MODULE_PARM_DESC(rate_burst, "The rate limit burst amount to limit requests to.");
> +
>   /* Mutex to serialize the shared buffer access and command handling. */
>   static DEFINE_MUTEX(snp_cmd_mutex);
>   
> @@ -341,9 +352,27 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>   	if (rc)
>   		return rc;
>   
> +retry:
> +	/*
> +	 * Rate limit commands internally since the host can also throttle, and
> +	 * we don't want to create a tight request spin that could end up
> +	 * getting this VM throttled more heavily.
> +	 */
> +	if (!__ratelimit(&snp_dev->rs)) {
> +		schedule_timeout_interruptible((rate_s * HZ) / 2);
> +		goto retry;
> +	}
>   	/* Call firmware to process the request */
>   	rc = snp_issue_guest_request(exit_code, &snp_dev->input,
> -				     &arg->fw_err);
> +				     &arg->exitinfo2);
> +
> +	/*
> +	 * The host may return EBUSY if the request has been throttled.
> +	 * We retry in the driver to avoid returning and reusing the message
> +	 * sequence number on a different message.
> +	 */
> +	if (arg->vmm_error == SNP_GUEST_VMM_ERR_BUSY)
> +		goto retry;
>   
>   	/*
>   	 * If the extended guest request fails due to having to small of a
> @@ -351,21 +380,21 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>   	 * extended data request.
>   	 */
>   	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
> -		arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
> +		arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
>   		const unsigned int certs_npages = snp_dev->input.data_npages;
>   
>   		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
>   		rc = snp_issue_guest_request(exit_code, &snp_dev->input,
> -					     &arg->fw_err);
> +					     &arg->exitinfo2);
>   
> -		arg->fw_err = SNP_GUEST_REQ_INVALID_LEN;
> +		arg->vmm_error = SNP_GUEST_VMM_ERR_INVALID_LEN;
>   		snp_dev->input.data_npages = certs_npages;
>   	}
>   
>   	if (rc) {
>   		dev_alert(snp_dev->dev,
> -			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
> -			  rc, arg->fw_err);
> +			  "Detected error from ASP request. rc: %d, exitinfo2: %llu\n",
> +			  rc, arg->exitinfo2);
>   		goto disable_vmpck;
>   	}
>   
> @@ -518,7 +547,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   				   sizeof(req.data), resp->data, resp_len);
>   
>   	/* If certs length is invalid then copy the returned length */
> -	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
> +	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
>   		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
>   
>   		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
> @@ -553,7 +582,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   	if (copy_from_user(&input, argp, sizeof(input)))
>   		return -EFAULT;
>   
> -	input.fw_err = 0xff;
> +	input.exitinfo2 = SEV_RET_NO_FW_CALL;
>   
>   	/* Message version must be non-zero */
>   	if (!input.msg_version)
> @@ -584,7 +613,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   
>   	mutex_unlock(&snp_cmd_mutex);
>   
> -	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
> +	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
>   		return -EFAULT;
>   
>   	return ret;
> @@ -734,6 +763,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto e_free_cert_data;
>   
> +	ratelimit_state_init(&snp_dev->rs, rate_s * HZ, rate_burst);
> +
>   	dev_info(dev, "Initialized SEV guest driver (using vmpck_id %d)\n", vmpck_id);
>   	return 0;
>   
> diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
> index 256aaeff7e65..8e4144aa78c9 100644
> --- a/include/uapi/linux/sev-guest.h
> +++ b/include/uapi/linux/sev-guest.h
> @@ -52,8 +52,15 @@ struct snp_guest_request_ioctl {
>   	__u64 req_data;
>   	__u64 resp_data;
>   
> -	/* firmware error code on failure (see psp-sev.h) */
> -	__u64 fw_err;
> +	/* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
> +	union {
> +		__u64 exitinfo2;
> +		__u64 fw_err; /* Name deprecated in favor of others */
> +		struct {
> +			__u32 fw_error;
> +			__u32 vmm_error;
> +		};
> +	};
>   };
>   
>   struct snp_ext_report_req {
> @@ -77,4 +84,11 @@ struct snp_ext_report_req {
>   /* Get SNP extended report as defined in the GHCB specification version 2. */
>   #define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_guest_request_ioctl)
>   
> +/* Guest message request EXIT_INFO_2 constants */
> +#define SNP_GUEST_FW_ERR_MASK		GENMASK_ULL(31, 0)
> +#define SNP_GUEST_VMM_ERR_SHIFT		32
> +
> +#define SNP_GUEST_VMM_ERR_INVALID_LEN	1
> +#define SNP_GUEST_VMM_ERR_BUSY		2
> +
>   #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
