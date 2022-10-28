Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC1E6115A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiJ1PQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJ1PQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:16:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5BE1C208C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSyqIiKKirnhsspKrDgcGJkgY4uuwmxsMFycUbR5WDB/tQiGu+44ms4pnmwhCrzhqtrGgohEptmqJNROSVwF0BlWSDjIf2zko4xPGiUsq+pv4r8S4XZDqNyg7c4t74ovHDT2x4BSSwVpsT4Ids3tCxi6UqswU8gwxxGwUmoY/yla97rLAm0QhvE3YsRY1EtZQAdOB3rzFioCYM50deaLlQ2/E7jh6HfBLIBnLjPYjYAlVnGSRl4IPFik6iMEnaiUYDcaLV+zBRaUvSaeAIDk7WLYY7EtTzes41APjxjWKGldFDvzKXvVA9ls1oaUVNRPT48VzaN90SaUzsvgCU3NVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfpRuk2K6IUi9t4vNqLZJ5zKQ74+iQg+UYPd2/e1guQ=;
 b=AcFS+ZjyzivS9PFZWcuJqLZsTaqDIMQmdDiDOzWczgcPUSomUyTcnE3gayxKW3iW0zL90yEvlR1jhQu7erp+yQvM9eAJUIxv2whRb2oU7OTV/gXQxw0uGegIeqj2WmuIaT+IIVVCCSdx6fAlqO5mV8dqFz4yWj7XVq4QMxP/ZsPBt2p73lgmDNfy+o9uCgArD375Vix5zOy011MMwj/6Pj2ONd+sUdTrH1Z1p5nuLL2IRfPah4pxfZmSyqlA0UDoFum5vaTaJPxEbN8ReGtK891CEyHxEigxOnNsJRygbhA1JZZfUkoarn9uqpLxW6DFR68wsfajA2xm6+YblFcGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfpRuk2K6IUi9t4vNqLZJ5zKQ74+iQg+UYPd2/e1guQ=;
 b=gtqrFJXu40Z362Lv3ryx/m44zRuDQeqI2hUSGQSmt3C93bwO+P3bXgbgx/sFuWrNm/68eLjOifHESEkBetVFZyUzyMk5ce2V7gvKplty95+8dEWCFh9dnK8QJsEDDgH43RLJqdWO75FX2D8/SNmB7+WiCQvZbu0mewZOo36XyRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 15:15:35 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 15:15:34 +0000
Message-ID: <31d7bd35-6b26-b7b8-0903-09c3d260d801@amd.com>
Date:   Fri, 28 Oct 2022 10:15:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 4/4] virt/coco/sev-guest: interpret VMM errors from
 guest request
Content-Language: en-US
To:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20221024224657.2917482-1-dionnaglaze@google.com>
 <20221024224657.2917482-5-dionnaglaze@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221024224657.2917482-5-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:806:6f::31) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CH0PR12MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce52abc-6446-4113-5636-08dab8f7430a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81LFuRrld0HN9546OdxtHPXOEygEefowm0hXWIlzq1bvu/b4cJBmeWMbFP1wDiwS5T/fmJkPNbxysGeIBJwC0hkKGcrKvrWCq/pn6BnJFOqBSvqXMnYO1Ts3HCPWMoSX7qDFXX3kAi/7yToD2lG1J7um+Xo0v+tO73TudLVGXXlDV2TbemlH7hLpWT2huW0jUVktRGA7oE1lDjRzvdfNO93Hd1uSI3HLn4yIenKQTWvO12s60X3PNvQztoKqEIQfmvspox0vMWqr7PRNaSPKvdA9x1r1oynDZkpylwyf7cU6v3GJpG7D7ky0LzAGdeSoPpRCjOmA/6Atr+1ff+0zqWnX8AixUopbZQzMhnMqsJY/IOQaLXjRXkvTvnlXHknC19ZeXd0CagPhp1hfTvSry9a8f8RQKkCmR+zWCUWcFgU4NZa+n6EsGsA+DCmKK7RTTmzM2NFfNKCYeUHhHHxCcqsRbq2CtRTI8eqGb6sN+jzv2h8COzO/ifgPI26MEC5uFkX/m4Wskl5lOfdfHy6Dly/lqQjZ5LrJj060B0l64C6ha0ju4f8sjtKBqcugdyCz4Ezcj8BH3+BQhXudK4wHM6b+Vqf4jdO73D9evp1oHCdO3ll1FEXizbPK1hnJeJIikxblOBtqF1ITkssucd3arVNUI6JyEUXKoPAhRZ5oCfoH6JRy3aRjMgpVDoEdIkQAHuWUgvqDOovnbB3FbMsK0mj+5xtQC6PFwLgYXeGokskbgR4ta9XrfDhiFDR4w8YYxH0L25wfGvGcySfQQTh7my6D1vliP9R3YM3zWRetIiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(83380400001)(86362001)(38100700002)(2906002)(5660300002)(31696002)(66946007)(4326008)(66556008)(66476007)(8676002)(41300700001)(8936002)(6506007)(26005)(2616005)(186003)(6512007)(316002)(54906003)(53546011)(6486002)(478600001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUlEcVNWaTRUd3VLUE9UcWZ0a2xueVhsMUJsZzJWU0VRTjJhNUdhd2RDVzd0?=
 =?utf-8?B?a3NWcmd3VFpKVVR4VU1mbWxoOEVrR2ZhRFBIU1FEVzhCbjlFOUZVSHFobkpO?=
 =?utf-8?B?OTZ0TkpxaHZDQVc3dzFCUjA2b09EVjIzUFRScWYxZUplQkN1dWtaYThQUlF1?=
 =?utf-8?B?RnVyQ0cvNE9Hb0NGMTZTdzNaZkpVK0FvZzZRR0lYdHAwb0tEWjcwbzBkUkRH?=
 =?utf-8?B?MGtpQ1A4aUZ6a0dwdmFKcE5kaktZcGcwd2J4YjU2VFQwMjIyTi9CMDV0TFI5?=
 =?utf-8?B?Z05EcGplZkxyZFNnU0VwdkVUeWRaYWs4Ris1N2k3cVN3ay9udGlpSFpxbVBB?=
 =?utf-8?B?cWJwd2FPeGVjVWlhRHkvYU4yVVo4ZVR0MjR3SUpldDNyVVV1bTZqc0tKbWNq?=
 =?utf-8?B?WjVIa1hiQmNIRXpPTDQzaVVuc0NFZXZrUDZKTUdTNEdYcHF3M2xJaWh4T1Mz?=
 =?utf-8?B?bW9SY0FEbmhwblloaVgvZUhrVVEwZjB3MzNEemluU1labEprQXVER3hMWldM?=
 =?utf-8?B?czh6MHdwSHRNcUI5aWtOa2NwS3YvOURaSVZxRDJhbW1ZTEx6MktFb3kxNHBN?=
 =?utf-8?B?WGJ1eWFaZ2I5aWVBaXFzajZUYmJIcEd2VkhYQmRQaWZpQVVCeVVsV1hIcXlG?=
 =?utf-8?B?MzdCR1o2Znd3UWRNVDduNEovYzBrVHNzNEFmbEJhL2VsdXZBMDMwQzk4OFNx?=
 =?utf-8?B?MFE1UTBGaCt3eW1hNStOZit5RktHOWJjWXBydWF2Z1pCTXo3RTZ2NjZhVHA4?=
 =?utf-8?B?ZmphUzJ6QWE3VGo0Nk1wQndqQlRDUkw0ejlXKzJORFZPQWdzbzE1eWc1elFQ?=
 =?utf-8?B?WFl2VW83dTI0bkVTYlo1ZXlXTXhiTFgrOERtbFMvcDVDT04ybm1FMnZGNzJ1?=
 =?utf-8?B?T2xUYjFobm1zNCtRaGR3Um16eXBmam5CQ1VWTnc2bW5IZ2djOVQvb0JyZG1W?=
 =?utf-8?B?dkphTldLd2JzYkU0V2F3Ymg0YlZ2ZXdNZWQyaXo1YkNwTEhQNm5ITDY4aW1U?=
 =?utf-8?B?azJtaDJPcjJIbGRyck82WDBHZWdXSEw0ZFA0SkQ1NnlySHFFV0hqV1R5V3lE?=
 =?utf-8?B?Q01zQmRoWStlUTNoTjEwKytUTFZMUXFrQWNuUTRKSndQWGgvQ3VQaVkzclZT?=
 =?utf-8?B?TVFHeGpyZXhQTlRCbGNvYXA0R0RhY3R1d2s2RFdVL2dsc1F3dmJPbDJVMGNw?=
 =?utf-8?B?bXJxL3VROVFRNjlyVG5PQU16dCtrOUNpWTBzaWlleDhOQVJ2MElRaGlXU1N6?=
 =?utf-8?B?ZVUweEZqUU10djJLbVRRYzRjTmdzUkhsVVBVVHZLTXZrZjJ5ZmJhY2FoRjVE?=
 =?utf-8?B?SVFOclFRQjhoU250Yy9WMEdibktOblNJeWdBZURBU3VvNnVTcE1VWi9ZSllr?=
 =?utf-8?B?Wk5XTVAzNE5HeEt5Vm1aNjB0UGtpNDBQaFhhY3loRkxDV1hmRXJ5NkFQanBn?=
 =?utf-8?B?S2dtbVdTams3RzhtbzgrWjROVlZZQlJ0aEJlbnYreEkvYWdCN09qQ2hNSmlj?=
 =?utf-8?B?L3VhUWFtY1JsMlJPLy9jd0gzM21iaHdKc296b3crUmQ3K2dudjZxejEybDBo?=
 =?utf-8?B?ZUY1VzAxaU9oOWFxZXU4ZUFqanUvK0JuYzBibFV4aUdFSGY2K0hUZHpSN1lp?=
 =?utf-8?B?cCtISGtnWUdMK2FtR250QTFGK0F6d2IwZmc2UFBua1NoN3JFb29MdmZDckh6?=
 =?utf-8?B?bGVaK1pNUkZjY1FYZkp6WFp3bm40RkROTXpBWGYyMkYzT2Zyakp6K3BpdVpR?=
 =?utf-8?B?L0pNbHp6Y1R6ZjhtUUtYcWgvTWRWUTFrUW5pSTF0VVNSUDRlZ2ZWRlMxL1Fi?=
 =?utf-8?B?M2FpU0JzTm1BWVIzK1RLK1V2ZnJSOHB1Y3NBU2xFTjB4eURzaHgzRlVPZGVw?=
 =?utf-8?B?KzZmakxsanc0VER0cHo0QU1iM1N5Sy9mOCtKL2tLdUtESzdhNE9SL29FRmxt?=
 =?utf-8?B?MTAraVJEOGE0TnNHNG1UbzJJK3gxanVodUpBYlJKa1I0emFEclllazU5cjFV?=
 =?utf-8?B?cGJwR3ltdUpDOUtCYWJueXFBeE11UWlpL3JjeDNuTzlDQnhwazRDSHl6R3E1?=
 =?utf-8?B?MGp0bERiR3haWEVLTFUvVE1BODFueWtBMCtEcnFzNkt4YkpxOHZvZWZNVFps?=
 =?utf-8?Q?rqL6c9KvcXKh8SYenlHU5kbgH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce52abc-6446-4113-5636-08dab8f7430a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 15:15:34.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3z1qFZsL0/GhgdnoEpselxCZ8SUlLj9kGRlLaQabKcGz2r/5Z+fSOY5ABFw7SPqzIHY7SN0YMo8GNxavf4Xxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 17:46, Dionna Glaze wrote:
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
> again. The ioctl may block indefinitely, but that has always been the
> case when deferring these requests to the host.
> 
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 54 ++++++++++++++++++++++---
>   include/uapi/linux/sev-guest.h          | 18 ++++++++-
>   2 files changed, 64 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 0508c2f46f6b..dfde777933b6 100644
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
> +static int rate_hz = 2;

s/int/unsigned int/ to match uint below.

> +module_param(rate_hz, uint, 0444);
> +MODULE_PARM_DESC(vmpck_id, "The rate limit frequency to limit requests to.");
> +
> +static int rate_burst = 1;

s/int/unsigned int/ to match uint below.

> +module_param(rate_burst, uint, 0444);
> +MODULE_PARM_DESC(rate_burst, "The rate limit burst amount to limit requests to.");
> +
>   /* Mutex to serialize the shared buffer access and command handling. */
>   static DEFINE_MUTEX(snp_cmd_mutex);
>   
> @@ -305,9 +316,12 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
>   				u32 resp_sz, __u64 *exitinfo2)
>   {
> +	unsigned int vmm_err;
>   	u64 seqno;
>   	int rc;
>   
> +	might_resched();
> +

Not sure this is needed. This may call cond_resched() right away, so I 
don't think this is doing what you think it is (as I only see it used in 
scheduler code and spinlock code). Did you mean to use might_sleep()?

>   	/* Get message sequence and verify that its a non-zero */
>   	seqno = snp_get_msg_seqno(snp_dev);
>   	if (!seqno)
> @@ -320,9 +334,35 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
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

This doesn't do any sleeping/delaying, it just returns a 0 or 1, so you 
could still cause a tight spin here. I guess that shouldn't be a problem 
is nothing else is ready to run. But maybe adding an msleep()/usleep() 
here based on the rate limit parameters (half the rate limit?) would be 
good so that the CPU isn't pegged while rating for the ratelimit to be 
satisified?

I'll let others chime in on that and see if it is appropriate.

Thanks,
Tom

> +		cond_resched();
> +		goto retry;
> +	}
>   	/* Call firmware to process the request */
>   	rc = snp_issue_guest_request(exit_code, &snp_dev->input, exitinfo2);
>   
> +	vmm_err = *exitinfo2 >> SNP_GUEST_VMM_ERR_SHIFT;
> +	/*
> +	 * The host may return EBUSY if the request has been throttled.
> +	 * We retry in the driver to avoid returning and reusing the message
> +	 * sequence number on a different message.
> +	 */
> +	if (vmm_err == SNP_GUEST_VMM_ERR_BUSY) {
> +		cond_resched();
> +		goto retry;
> +	}
> +
> +	if (vmm_err && vmm_err != SNP_GUEST_VMM_ERR_INVALID_LEN) {
> +		pr_err("sev-guest: host returned unknown error code: %d\n",
> +		       vmm_err);
> +		return -EINVAL;
> +	}
>   	if (rc)
>   		return rc;
>   
> @@ -375,7 +415,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>   
>   	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
>   				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
> -				  resp_len, &arg->fw_err);
> +				  resp_len, &arg->exitinfo2);
>   	if (rc)
>   		goto e_free;
>   
> @@ -415,7 +455,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
>   
>   	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
>   				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
> -				  &arg->fw_err);
> +				  &arg->exitinfo2);
>   	if (rc)
>   		return rc;
>   
> @@ -477,10 +517,10 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   	snp_dev->input.data_npages = npages;
>   	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
>   				   SNP_MSG_REPORT_REQ, &req.data,
> -				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
> +				   sizeof(req.data), resp->data, resp_len, &arg->exitinfo2);
>   
>   	/* If certs length is invalid then copy the returned length */
> -	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
> +	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
>   		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
>   
>   		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
> @@ -515,7 +555,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   	if (copy_from_user(&input, argp, sizeof(input)))
>   		return -EFAULT;
>   
> -	input.fw_err = 0xff;
> +	input.exitinfo2 = SEV_RET_NO_FW_CALL;
>   
>   	/* Message version must be non-zero */
>   	if (!input.msg_version)
> @@ -546,7 +586,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   
>   	mutex_unlock(&snp_cmd_mutex);
>   
> -	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
> +	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
>   		return -EFAULT;
>   
>   	return ret;
> @@ -696,6 +736,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto e_free_cert_data;
>   
> +	ratelimit_state_init(&snp_dev->rs, rate_hz * HZ, rate_burst);
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
