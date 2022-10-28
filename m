Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E3F611514
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJ1OsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiJ1Orf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:47:35 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96351202715
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4vDdNBeKlGLOgojVE8MQ+C5CsDa7k6Xd/0fQfOMLSmDKPI1iY3CoIzDaHVSPgtQMrNAgjsLfd74vzZ4Dy4K2DsiW1syJgQsZHzuF5Qq55q5sS93NzfFO+4D6kHDoxlLZyfEJQBJ//mOgMvoiFH6OMbJUBnedos3iSLuJ6Je7TtocmFxoVY13+Uz9UIbRTUX6W0r3MMTA+0tMjVZuybTQbt9XP+h5aDjWDPikQkp7uZJPLVytIOVknjpezZ0rR7uA+9e2jOkasYg8FRjMinAyJzq5KnxtWWSTyHTpLLJ4ys5q9gTciuIWme3DgZgyr+A7EB12zlU6OeySOLhKOJ2Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfoYsk2W3eFiDpgF0fyFAWdQTSue6FhhM2j9Zwcqlh4=;
 b=LlP22KiXHcJv1tmSI7CDHRikzwXJCCel/Pog5AuMyy0FyyIZLkcIAM9mSJB4x+pw8x1Az0j+5RahUZpskkfDWpGT4iqr6qggk/Hz6CywG0Hdn8C0bdsYeMlu+NO2VYHUr7aBtFLN/PG6HWzhE7CunVoEkTyK7V8AG4X2+nwh2nZ3hpO4DNFl4pH14lUh4V/eMfK2utMUYgdEIWPRyBvE1fVvBKGdeYNEWi9n4NFVVLC/t0osIhMucyVeuzbS54X3kQfO1WlNyT1IwN52eXnYEmFUoWz0UJPTv2TTePxEnoWbd19vpUL/I+rjBYwsVa8GF00pZMu0eHn693DHJmjc1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfoYsk2W3eFiDpgF0fyFAWdQTSue6FhhM2j9Zwcqlh4=;
 b=YJ51ucCkwL5ijrE0u98e4BsViEhQiSMWQh6izYboU5UaX1GypSVBsUqbBJNI5yFpdoTpK7O6SK6EztPG6hSKfM46CeKEB3eBF3yx+Z3yptyaVfu1lXBwzpK+QectCm/biRALsgwCLT6cRzSR5PRGeGYD+7oTvuq2yo09WC0ladY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Fri, 28 Oct
 2022 14:46:46 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 14:46:46 +0000
Message-ID: <63024b41-3725-a6b8-bed9-b755d5b7eba8@amd.com>
Date:   Fri, 28 Oct 2022 09:46:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 3/4] virt/coco/sev-guest: Remove err in
 handle_guest_request
Content-Language: en-US
To:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20221024224657.2917482-1-dionnaglaze@google.com>
 <20221024224657.2917482-4-dionnaglaze@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221024224657.2917482-4-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0132.namprd02.prod.outlook.com
 (2603:10b6:208:35::37) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 277e70a3-cfdd-45eb-54f7-08dab8f33c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTOzK6PojlMXPUBI/s+XgvQ7U2EonqkEv9VDd+yD//Fw9IT1oFibZ7v6hTx2kfWZYo3BHYYoBwaVuRoS5qBWk2O+grUzUNNhkXYfuhifN3nblEJygl23wU38HkQmbscC1vlmo0NW2IKApy4uA3J1oh1FbXWW0PNT8t6Fl/k43hOGbsS0NWPWi6BhCxuV4UrOob2kkWklTRVlFIZOxwCrGrJo46YpOEHpYnSPEJCNr0IMxeeukNBv7HSiw8ea3V/p8DLtsaySEc1RfrD3ZWyfCBJ6ZhTVVHfjAQesMt/gClF5yob4IvVdckn5SFTFwHVA1t+Un1dqmX7/DjGpV8jtmGbjZDWlyQd+kSu2toYyrLIez/ZJXrl+uOHQ9GxjphNL3YT8WboUh54bMMajE44ZIJfmo5T7upUB7pzyzzFi/c/DLGv1J2EHekN5dld2rAcK77kdlR2sFqN2OCw4AC/CQHNNtdPyMbep9qWlIhJ+qjNydBLRUAGCMmSloTzLanMKFU0uyYIjmfkvwLb2kjFxxVbiUzzPD7/6lDHzMfbIDejhv6XypP9zbzEtYV6gGe5c6crqu4Yv0uQVlFzmQW3/h1KlXNC/OiqbMQGnMb4cWLfFQm/oe3LGexKiGMyoN5CVj7OL2wM9/NzmGjwbAhBN7ocdoeKn/bZJWYd5CibD0g4UReykGrJLvcvXEz71WUe7kH2qDXndmGicu2FF+PR3Zg6ikhtQKjLccOU6hMrv008Gl5IWorfgzPN7zY2Rb0Hi8MOGElJT8pcqRo0eOiEBVnqM2b0Ks82+Y9ZRV4aXymQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(31686004)(36756003)(66556008)(38100700002)(8936002)(41300700001)(8676002)(66946007)(4326008)(186003)(316002)(31696002)(54906003)(5660300002)(86362001)(66476007)(83380400001)(2616005)(53546011)(6506007)(2906002)(26005)(6486002)(478600001)(6512007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WSthNFhReWx2NEhIenlDTjRHOHU1LzBzUzR1OHF1RWZINTZLS3RtM3dQN3Zi?=
 =?utf-8?B?NVFSODhtNktEOFVKclJMZVNxYjdFYnRvQlFWaXhQN21BSzg0U1g5azhyTnpa?=
 =?utf-8?B?dHM5YTk0MTZXSVdzb005ZitGUmVTbXNpZjdEVjJYeklXTUdzc0xVK3BXdG85?=
 =?utf-8?B?YSs3ZUF3SzVBVzNvRmI1cjdkOGdzU0hCOU82WVBlQmRDWE42VVNOV3lCaUFO?=
 =?utf-8?B?L3B3VFg3UEh6ZGNXdmVkS01qdGZjbnF4ZUNXZ2Y3MEU1T0diSlBOTkNwYWVN?=
 =?utf-8?B?VW84S1djelE0aHVkQzRvNXNyLzB5YXdnR2dBdmxudklNd0FHaGlXc0dKZTU2?=
 =?utf-8?B?NWkwSmJmMU90ajhNL1B6U2FUVzl1VFh1N203TFlLOWtSZGlIN0JwcTBNcnV5?=
 =?utf-8?B?RTMvTUFXcnR1aTZSbnc3dlFMZ2E5QlJ3UlJmaVlNNSt4aTk0OVVWc2xVaFpP?=
 =?utf-8?B?RThyQkRLa3NpQlN4S0RJN05xcm1UMXhPeEgxSll2SFRNNW9oV3ZGTzJ5SlBT?=
 =?utf-8?B?NTlLeVp4MHBnUWhzUjlyaUpDTGpLZERsdkdKT2xqSW42L0dUdzcxL0ZOTlI1?=
 =?utf-8?B?c2Jha1VxT0FIMmR0TTRURUxEeVBldjMzSURZSHlHWVVRSWZrcmNnRGtwc3pN?=
 =?utf-8?B?VUJjZlFPOEZxc051d0x5SmEwWlV5d1p3RzROWFd6Vkw3N0ZJSVJ0eGpqTVk2?=
 =?utf-8?B?TDgrd2x4RmR5dkNHWi9XbjArMlU5N2lTL3NET3hOYWdqWjNnY2Juc2puSU1r?=
 =?utf-8?B?aTdsRGlGOXh2TTRiV2tPdGZXbldmS3QrU1k4QitiV2F3aFVseENlQ0lZdjRw?=
 =?utf-8?B?dU1zVldJRDhQQStqS0VhZFZ0dys3UlJCZmNBRVBkS011VmJkRzJzdWpNNnJT?=
 =?utf-8?B?ejhZQU9jdU1XdVBRYmR5bU1ESEpnZnVSNnVENysvcmg0aEFjTm5KQUFlNEtE?=
 =?utf-8?B?VUtZZDFXZVBPbGNBRUgrTFo4ZUljbXdsRFZ2ZmN1QWhmNzh2RWRaVWYxY3Bu?=
 =?utf-8?B?YTF5YnU4dlVBcVhKL1E1dGFWRjdldzk1SW9aYlpuTWhwNExRQWp4M0pEQTFE?=
 =?utf-8?B?WlpQYVg2MTE0L3IwekI4emlKQlZCYXFQUkU3Y0YrQ0FFU0FRWndqd1pWMzV5?=
 =?utf-8?B?c3gva2Jidkx5eldzaThQTzVaSlk4djhKRmVKaUJudGZIb1Z1SHg4WTg3WGlD?=
 =?utf-8?B?TEluWDJTQ00xVC9GeGRjaFhmMFZTZDJINnhMVjlBcEpBb2I1cmQ2ZVlQNElt?=
 =?utf-8?B?eWltYWhlWlN2R2dUeWZpVEpjOElWbktIRitZL1ZjODdoM254di91cC9CYlBZ?=
 =?utf-8?B?MXE5M0U5WlZNYnZ4WXgyajNyVytpUVE5eHB5ZjJwZk5IVzg4WmV3cFhpV3pB?=
 =?utf-8?B?ZjBsMUo3YmhaR3lNckU1Y1RhaWQ1ZUZjV29BUUtaVExwVEVDck1RanY1dElM?=
 =?utf-8?B?TDg5LzJYWHhyL1ZvdUhqSHNOYjRZVVgyWFUrY29xc0hpd2lmVi90R1dNTTd5?=
 =?utf-8?B?S1ViZ0lkeVNQMnRZa1dOUkRYUkFXQy93TkpoT0U2Smk0azRycDdZOU9vRkNm?=
 =?utf-8?B?MW52RW9qNTRQeThPZ2hyUlhrTWZ4cFphVGFxRENLa3RieVMxZm5GVjcwWjky?=
 =?utf-8?B?QzBTR2V3SHp2NnpqYkVHTk8zZkhzMnBQTzJhbU9kL29OT0lIa1hMRHh3VC92?=
 =?utf-8?B?enFVbXN2YXNxRnhzMm14UFg2K2JFeFBSVjZjaHZDNTJaZVNORVJxYXY4LzdF?=
 =?utf-8?B?aThNYlFEdHlRUmxCMURhRmtQdDRjWjlWZ1lVTUp5bVkvRkFxODJYOU9Ja2RF?=
 =?utf-8?B?RjZuOHJmak4ySWpJdVUra3hJbWZwWVRzSWZ3aGhnUEt3M0JWbVZ3aTk3ZGFw?=
 =?utf-8?B?OFRBZUluaU5ndXJNY2FveGxnQzVEUHRma3RHNXdVVUpqMUNYbmVDamdBVWhU?=
 =?utf-8?B?OUJZeW8xemFXMVN5UWZVWlRKem1WZ1Z2WUpidUg4czVsOGtnS1FBSTRvNkJ5?=
 =?utf-8?B?NENxNUYwQTR3d3NMZFR4RWw2QmV2endtU0phMEU0YkYrRmFEZVhPN3VZeHh2?=
 =?utf-8?B?dzkveEFGaUhtMk4xR01PRElVaWkwSHk4T2pmbmQ3cHl0czdjOVVrckg0b21D?=
 =?utf-8?Q?IGCwZ4vEc60RVyjklyF2ktt7B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277e70a3-cfdd-45eb-54f7-08dab8f33c98
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 14:46:46.0306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSZfwK0gx0eGw5LGtFDGJj8LlvkXz/KGnguPCAGkupe0/iNwi4wOWACkm1XN5YGA6RZJ9Em41qoYplfyMmgJNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
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
> The err variable may not be set in the call to snp_issue_guest_request,
> yet it is unconditionally written back to fw_err if fw_err is non-null.
> This is undefined behavior, and currently returns uninitialized kernel
> stack memory to user space.
> 
> The fw_err argument is better to just pass through to
> snp_issue_guest_request, so we do that. Since the issue_request's
> signature has changed fw_err to exitinfo2, we change the argument name
> here.
> 
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index f422f9c58ba7..0508c2f46f6b 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -303,9 +303,8 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
>   
>   static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
>   				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
> -				u32 resp_sz, __u64 *fw_err)
> +				u32 resp_sz, __u64 *exitinfo2)
>   {
> -	unsigned long err;
>   	u64 seqno;
>   	int rc;
>   
> @@ -322,9 +321,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   		return rc;
>   
>   	/* Call firmware to process the request */
> -	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> -	if (fw_err)
> -		*fw_err = err;
> +	rc = snp_issue_guest_request(exit_code, &snp_dev->input, exitinfo2);
>   
>   	if (rc)
>   		return rc;
