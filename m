Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0B07181FB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbjEaNeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbjEaNdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:33:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBD7101
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxRWcg+DTtym8ujlZ5R2XySzlmPyjoD85pdFELoPzbuDmTSTfT6LyJPtIWZhuTx+u2/hT6KPLwLdX8m78P+J1R+1o7jecg1rfUi/pYEEA8vbvanHIfxcXEkh02VlCLw0tYQk9OZmzR+VjY0emMP0pSHoB0UaOxoKfO9x2Hb5w9lKOMhksjHk1u7Ws2AkMzZJOo9Mvd8kgJjblin2WPy3drWo/O5XLfKG5VUcKW/AQ/IP6r8LOOyaolhMzbPR0QJPtvGFyj5VTfzoGA2QIR0sEZ2ESdJuGQKCYJJVjvSXDQqwtF1nljwN8pab99qyvzN7JOlfFgn9VJlWj38TzUZUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEfko/+WQAB3YCQk8dBRiVw4QVF8abUun5QKsdLIBPs=;
 b=gxwWk9F1zAgAv0vI2ENySg0ZL5mrUlP7w/waZS1a8yui3mcvEdn5ClTQZg8KAwMWqCxXwZpzmqc+qlkzgXFl91jUD1Qb4RRJUgS0aGp6tnt6d2CWuF/HkYHkPhvteeTca0876b3F5FhIPhAOeDFvOgA+WEmUE5nNpqiA6l1F24+u9vGKnttg3gWk1G+9lqDpvIEcZ5QwEZR61yqSoLSNFVPk7f2oFjbalq5ss1BQVngsstrWkZAq1ucfz0pyz1SGW4jWL957mYf4A6vDhVp5OVIfNuBBTpfj2lDASahHvG7Dty1GI0ge1rH8dLvWG2cqheOT0Q/ZgFLZUjlg5NQeVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEfko/+WQAB3YCQk8dBRiVw4QVF8abUun5QKsdLIBPs=;
 b=BzJZ+wMkD1gNXC/TsQF/oN4fvf0gbm6xfz3q0SHuzrnLsH4wG830e/Qc1ByvFOGQYu4kFBQvFumz0H8ShGmpsFM64B8zY1RkiqnfjzjTFpoIKIKDo58niJjR7V0h3Er/OkN+KyVTqFaMXZWyfG0tGxBks3E34OJVnLW6WWRS2dM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 13:33:21 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::907f:26e2:673a:2ad2]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::907f:26e2:673a:2ad2%6]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 13:33:21 +0000
Message-ID: <2404b7f3-a465-a706-8af3-459105f0dc54@amd.com>
Date:   Wed, 31 May 2023 15:33:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Rearrange WREG32 operations in gfxhub_v2_1.c
Content-Language: en-US
To:     ghostfly233 <ghostfly23333@gmail.com>, alexander.deucher@amd.com,
        Xinhui.Pan@amd.com
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@gmail.com, daniel@ffwll.ch
References: <64690ac5.170a0220.92bb3.2e7a@mx.google.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <64690ac5.170a0220.92bb3.2e7a@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca13133-8996-409e-fb2d-08db61db99e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K22KouEQ+jjdzJknDgXWBGDTyyXofwoJSuU7MIkvFxSurAOSbWtqK5yIoSC5q/GzTNbOOr7wezNHHLx1hWr5eFBL/JKpeQl33cxV19++8v4LXtc2yEFVB3Z/eW1fMuZuWdq5zRY7FNlOJ+Kurqc+OzZARb7HFAy2/NzXORt7uomTwOfeXMxAsKT044wHxCamaA32iwK/CK43wny0B4hVzpRCpcfkbQf7lT1Lq8hwBX0SWct+sjM6COfSpEb8X1UIJ2cp7wtJsKDqyOko5gHrJ1mzQ5dMCZP0oBtMVNLreF53I1DXm1/9iANC7ouTO4MZAz9ug1KBN0Uba+TjFiat/V/WtfPfsrtTtOgBb4/Pk/9pVXyudZ053/UapfjPMBUCMECte1Mm/h8CaA+QhBk085OmNMeeAw71xr9VRA66dWDZujg/EjeTDuGUvQuWRxC/9I4FVsU/Cu6qcVwvUv3EGlK9at6ndBFimr+2PORS2m9TuxoEbiVMb8kifxlIjV/tWvrs0ZaFYQgi4ruZyRrDwrbd8Vg/9ZXVDUUT+bszo1hzVW7oR4Tb8eW4g5hN2gpGe/9H11xCLqPSMl62VBXWGWl5cFFf4WSbhEBJ4oj5TVbruL+O0JOFAMhN8YCI8/D3xkI3xyHxLSrIIGj66mS/3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(6512007)(6506007)(31686004)(186003)(2906002)(2616005)(478600001)(83380400001)(31696002)(38100700002)(8676002)(41300700001)(8936002)(6486002)(66556008)(316002)(66946007)(6666004)(66476007)(5660300002)(86362001)(36756003)(4326008)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHhjOGRiTllGdlF4NThwNU8xWGt4dk84YVhzY0ZXajJIUVJGaDF3amFPVU9w?=
 =?utf-8?B?dlc0bzBHMzFKbUQ5TG8yOUdGN1ZYdE1XQUY2blJXTUVDaEhlK1FvNndCRnVO?=
 =?utf-8?B?TmF4Nk9XU3JRV1ROTjJpdXFMNDhzQ0dYMExQWnpma1J2QmJFcEpYdjdtTHN3?=
 =?utf-8?B?QW5pd29nb2pjcU9PMTZud1hhUnh3VGJiUUQyRjlNeDhCNkFSdlowV003azk1?=
 =?utf-8?B?Y1dmczlvOG92UHlmc1F5b2Z2Vmc3T3dCMktoVWNjcS91QUlUWmNFRUhQaFRo?=
 =?utf-8?B?cFhCMEx5eFZIaUpMdkZieFJDd2RURFRuTm1HWGYxYmNGTlBtWXQzQ092UHBm?=
 =?utf-8?B?MndFMklpSnpLRk5Zb1EvMjNHNVNTNlAxYy9rVFp3dU16TjRRMHNNc3VtazFn?=
 =?utf-8?B?MitFTTRqUStmV2tQakM1eWYvSWM3QkNDWGtLak5PK05DSzdMTWZmL0FsWFRv?=
 =?utf-8?B?TUFFV1BmUXZvZ01ocERDUG16RXk5T2hLbVp2VXE5cVQ2eERHQkk1WXhqRVdH?=
 =?utf-8?B?SVVSeDZUNjdGb2FXbWQ5cU0vQm9LekRnWU8rdEw2dExuYnFkc0JRVkY5N3lz?=
 =?utf-8?B?WFdvSkh5QzdnM2VuQ3c4Vmw3RlZsK1ZWUWJWanpuZHFmUm5qTkNlRmlHc1dP?=
 =?utf-8?B?Rk1uTHdkZUt4V1lSbG1EVk9EUUdocWo2U25uREowdzhtb1RvOUpWdFZNWmli?=
 =?utf-8?B?dHh0alZLeVJsaEZKdWYvZHl0RVVid09VdklSbFkyV01LWlc5bFpibUxpeGZ5?=
 =?utf-8?B?L2hzdEUyL1pUeEtyRUprekJyMkRTWWtWMDJib3hYREJ0Y1ZjL2dacFVldHgv?=
 =?utf-8?B?WHVvai82Q1JSNjE4eStjYU9KSnYvd0xLN28wUDRjZkNmTFAzSTRhQ1graEhK?=
 =?utf-8?B?dXNINHVNcE1IMDdtSEhMRDd1R2NwYzV6WTVLUkw1WGZqQUpBdkdIOFY5QWJ5?=
 =?utf-8?B?VGd6RFpZQm5abDA1Yk1reElnZ2lDVys5NGdjNlJHa1dnYTFqeWYzdXJjU0tG?=
 =?utf-8?B?VEtYZlVnY3FJcWVoTkdWaGhiRTVlQnFKMC9nWFI1bi9NdzJpc0JzT3ZWUUhE?=
 =?utf-8?B?SDkxWVQyc2ZvWHE0Z0VFcU1lSzhFVWdqVkswQ1BqZ2huVXlMVHlYZW9WcG9F?=
 =?utf-8?B?ZHk0N3RLSjRiZlVkREJvUnhpL3JxaEovWFVCOWY5VnYzQ3NDRURaekFUZjJw?=
 =?utf-8?B?S2dpdTZOamdsVmxRdk9qY2EwaGtCMFVOeUpZL21wSlFKaituLy9qWU94Ympa?=
 =?utf-8?B?TThsRU9WMjRaN0NGdVk1NytreGVGQXlac3dTREd4SDcvUzYrbGZYelNuREpM?=
 =?utf-8?B?YTNqS2lFeng2bTVuL21yMFMvRlYrU1RleDVvL1cyVWthZnhrL2VrdDliRFV0?=
 =?utf-8?B?WG80YjhiWXhHN2hOTGxWa2VBa0E0emJBdlN4UjJ4N3pSYlBrVUFDVnpSRVE4?=
 =?utf-8?B?VEl6V1VpWStJUmx5N1NzS0hLWmpIWGx1bCt1aTZ0NFBCemdKZ3BQK2I5ZDFG?=
 =?utf-8?B?ckpGT2RxT1dVU2xtd3BFZGRQa0I2YlFPN1Z0OU00UlltUzhrTERZdlhRRmoy?=
 =?utf-8?B?U2xxZGxISmNOKzFsaVg4REJ2VHd4WklUcDd0WWw4SlRpTVJuc1pCbHAxZlYy?=
 =?utf-8?B?ZnJNK3lldGxEZlkvZTZ1MG8vOWZCRzc2Q2tJK0xNRW9TcEEzNjdLcHVzZTRJ?=
 =?utf-8?B?NnlLM1piOWxHTExzWHo0TkdLNDcvZXhoSXBVYjV0cThhTVBtQ0J5RVg0YThw?=
 =?utf-8?B?MVZXSmJhUFZPVHZvdElocHFvU2xaRGRYaUVsNzgvSEFlR1FlbDhGeDNvem5X?=
 =?utf-8?B?Nkc5RzVxZ2pubm1RdHl0cjFURmRpUnh5Z2RYb01wVDdObFJ4Ni9YbGIxNFdZ?=
 =?utf-8?B?Rkw3M1RzQmYzTEpVY1NvdXJOSkI1a05JV3BvY1Q2bWlJZTZ2ZDFyYXJOZlVG?=
 =?utf-8?B?VmJESG1iMTZjZmpUbXBzOU5sUGJKbllXbmE4eXdUUHBiNys0VDJoUW9YQnZi?=
 =?utf-8?B?bmVKSGNQUmhiZkJDUGhKVzl0SE1QQ0lMRXkvQjk0K0p4ZTdvbG9Wd0xpTXh5?=
 =?utf-8?B?a2Izd0xIVkRMVFJxRlZDczdveHB4cFRValY2ZTJnaks3bkFQK3UxRFMxUDh0?=
 =?utf-8?B?WGJLK3Y5eUpyYmtvdmp1aC92L2RxU2hsNmlLRnJ1aE5CV09WVHJjZDFiR1NG?=
 =?utf-8?Q?YXffw0ci6vUNXQfr0NDbDvV+gYmBw1+XFbjojgm/i3yz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca13133-8996-409e-fb2d-08db61db99e0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 13:33:21.3468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5T4DA4XmYt6YVedL4a3o6Aa7DSqXj65rG70WRh8NP8BRUDSCjz6n3MbewhomM7cL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.05.23 um 13:59 schrieb ghostfly233:
> In gfxhub_v2_1_setup_vmid_config(), the GCVM_CONTEXT1_CNTL reg is
> written before related GCVM_CONTEXT1_PAGE_TABLE_START_ADDR and
> GCVM_CONTEXT1_PAGE_TABLE_END_ADDR regs are written, which may
> cause undefined behavior.

In which hw documentation did you found that?

>
> This patch rearranges WREG32 operations in gfxhub_v2_1_setup_vmid_config(),
> so that it can ensure the addresses are initialized before CNTL is enabled
> and reduce the risk of encountering undefined behavior.

I have absolutely no idea how you came to this conclusion, but as far as 
I know this is just bluntly incorrect.

The control register must be written before the other parameters are set 
or otherwise the hw wouldn't know what to do with those values and might 
even block writes to the registers or hang.

Regards,
Christian.

>
> Signed-off-by: Zibin Liu <ghostfly23333@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index 4aacbbec31e2..6d094e7315eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -321,8 +321,6 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
>   				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
>   				    !adev->gmc.noretry);
> -		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
> -				    i * hub->ctx_distance, tmp);
>   		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
>   				    i * hub->ctx_addr_distance, 0);
>   		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
> @@ -333,6 +331,8 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>   				    i * hub->ctx_addr_distance,
>   				    upper_32_bits(adev->vm_manager.max_pfn - 1));
> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
> +				    i * hub->ctx_distance, tmp);
>   	}
>   
>   	hub->vm_cntx_cntl = tmp;

