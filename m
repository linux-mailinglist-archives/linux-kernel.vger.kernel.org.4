Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC7A6D52FE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjDCVBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjDCVBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:01:42 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7160535A0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 14:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XblBkaWTo4Y71cC83WsaPzNbRXOr9Fxh3tS2Mu7+O4ajQ1FvE2edkijyniJn/Bk4vOV0PZShz7AI+ahPKuccF10BVgA5PTSEPPN4umrvN+/ZTvwQz3+I0vEIMBDzi/jbwPn9hYD5P4sGJsvIaosyT7l5MQXbentOk+VRoAqXRPlqfYGFk9wQMVcDuHv5QlHl9lKVrJXZUvJr+HZGRMB6ILVJggHpMfnYIY1XglzFLILkmCaEFUhIFiEQf8B6GFyo21bCd1T2yh3cXdnEiY088WcvczDA9HGvtkivuYqECb7JGnTWKSb3osHkJz47E0XOm7Extao/olGEGw+pLS+Wjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5pf/fxT1b6QlvLaFRSBEHVqaI0cXNiFhUStLdJuFrA=;
 b=iKgPem6CDhf0OHdEz5uU2kbwHrS0VscUxEXgNaYXr1Psbv+6GK6/poMFFsnN6YqaH74G4FtXRRh3ytf+j25+OW4G5k1xibzQKJRynyTYMktKhICoyGLw7CAIuFIDZk4x8OkOYFnt+v0DbJvDYVFJNDgPnykthB3Yt0yozVhF0mnimq8mxIGgLtkU2jw1MjMxob/ePWW3gIE2UkXKE1hfCK9hUQE730s1I4JHzCcIhVRkVdV55YkYAPO35j3m8GAaDbrCrNucWbsRlqxkVD3+uMvhQCdZcabJALqCOFLUjIlzvxt5rAIG6FmPrHLpNEMvGQsHIFJmiiUmAL/2NsTlkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5pf/fxT1b6QlvLaFRSBEHVqaI0cXNiFhUStLdJuFrA=;
 b=0GqKOZo6HNsZ3EUwufWzQ/qsxqLYsA3cjhQD632I8Dts9PVIzLHMUnmrYfa0wkKrnUHKSKas8CCUTQjmSFtm+zKXM687y7JK/HDBv9pqxkS2ilPzQKWGrXiQPwqXh/HM91SrXBSaQbd9yzul/jTCDpzIFZRC4tpS1ugkG8DOwV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 21:01:32 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 21:01:31 +0000
Message-ID: <409aca23-d2e5-b8e4-b6f1-a23e92c49b83@amd.com>
Date:   Mon, 3 Apr 2023 16:01:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 05/11] x86/sev: Move and reorganize sev guest request
 api
Content-Language: en-US
To:     Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-6-nikunj@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230326144701.3039598-6-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0060.namprd20.prod.outlook.com
 (2603:10b6:208:235::29) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: f2560bcf-ab81-40b8-a88b-08db348699e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SGDfpljT0b349Oel2FxlDq4EXEx+tbOjF3CwnhstCxE20eMRptlWYFt7D4j2QMuQ7W+dnZGRMsqwdWDeg9AanjhWdnS+WmawxsxQxf8X7UWm8VcLd088M1V+oEOJzQ6ZfEX9ztPwpq4vxezxp6uSSpryxyx00JLGC7rA4Vk377pRvsTw7TD5zE4Tt1PYQ5hE4vcMkbymloZ/gdN0RMN8+EKNk659itZHVOlnYCFcKpEkBsl8CBErCuxKmUaJa6j7cqBnUGf6IuB17KxaPot3F3etfOaD/F85mJGfJl9q1/CHPJLgXoICdMY0/bRJURrwxWHHgrW4JDiZLpMGgBKqiNXUXYIli0Ql40+Ng4CgsMsXA5NSk22WAjhb8M+IMPxQQ6Gw3oTvWi3Mw9TcbrxjVYZkuRAUmX5n4So3WQMj7ITCKJrDniaD5rRMUi+5Nb4nqH/Qx7llqKinqH0X1EAtHRH3tGQO1IBmN5RVNAthKOtBaXXO7/4uU7YiLFPHw1NiWgnJxciNXVro17Ylj/+a26hByM3eI7sLJ0CCoevOvlISsqlZYbHFRsmLPLlc98SaY4MwyYu8HLQUF//K2pxeIYWr/2OtzS1AX5p4EZ5kx7Bd9YeLw+m5Is8JVA6oEjQXUMG64KLIkNEP+yXQzBnJ0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199021)(36756003)(86362001)(31696002)(316002)(66946007)(66556008)(66476007)(41300700001)(6486002)(4326008)(8676002)(478600001)(30864003)(8936002)(2906002)(5660300002)(38100700002)(186003)(53546011)(6512007)(6506007)(83380400001)(26005)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzEwdGJFT0l3K0lGSEY5bnJqSE1tSUFrWUVwVmY5aDhxVU9XRGl2U2J0aXA5?=
 =?utf-8?B?dHZqSUxaT0xmMjZOQkd1WmMwZkxjVk1SWDNIcEZqUjA1QWRQNTY2REZ4NTNT?=
 =?utf-8?B?MWNkZlY3eEprTEdzMXoyWVptSVRSZzRra1pzYUQ2djh3YjJCSVVia0ZnSlR5?=
 =?utf-8?B?QzRoY3ZrV3lGdWdkRGpPWnNmSTFiT3g4cXBtZ1JFaTk1RUYyMzg1bnlTcUE2?=
 =?utf-8?B?emEyQW1oN0RTeWxwcUJERUhNUS90ZmRjVTNZbHZ5QXRnRXRhSVJveG9ka1VN?=
 =?utf-8?B?T1hVNHAzQ1lPNFA3aUtaQ2s1QW5GNkZ2b3ZNT2IxSmFIbjVvWVhWM29xczky?=
 =?utf-8?B?WGc4cjVCNG52a3d5RU5KcWRUcmdBRHhoMmg1QUZJZnQ3VVU4bnoyV2s1VmRq?=
 =?utf-8?B?MXR1NEt6WW1wYmUxVTRxZ2hRNWFWaTIyK1lIZWhDYkpjSjZKQXd2OFdXZEw3?=
 =?utf-8?B?aHNadmlYeGVrWDNWRGw0NjFrRERMNmhOQnJaeWtGRk16bEkzNUVoK05NOXUr?=
 =?utf-8?B?QlJ1NUdOT3N1L0J3blJxbWZ1eHY2STMvVmtlMGw4ckVUUGlZdUJJK3YvSW0y?=
 =?utf-8?B?Q2Fpc2RITnM0d3hsZFNXVVJlalZlYnJXczhnRjA2RXRncE1Kc09EVFAySHli?=
 =?utf-8?B?ZjRVcFJ3Q1NWQVlsVTJnVGJYbGlBeVRWdkxnVDV0TEh5TzNuTU9ITCtrZjlI?=
 =?utf-8?B?Zy96S1NmaHQwZmF1M2lXcEhGVU56eVNvUUFPd0hnbVR5WW1LVzZ1YXI1T08r?=
 =?utf-8?B?SjZIdW9zTXVjbVd3WG5LUXJESjB1akdtMXF6eEZ0R2JJQ1AwRXVXVFk5MHpZ?=
 =?utf-8?B?WFhiUHFKVlhJOTd1OXk3NW03SXRjanEvWTVHcVk5SlNXbHU1Z3d3ekFjTE91?=
 =?utf-8?B?NS91YlZGWXp5RmNPSi9NZG1GcTRPczROZDlKWFZSOElzYnIrcjRNZWJHalk5?=
 =?utf-8?B?ZnNscUxjTmxwdmloWFMzeE42QlBFcUtzQ3FHMzN2RjhPeTU3ZzdzSTJVbGVJ?=
 =?utf-8?B?OEV5OWZNWnpwNjJEWlc0b2hNTjdGZEh2VG9ZTVl0TDc0cFJwRTZlQlhIQ2c0?=
 =?utf-8?B?M1MvK2xtUEY2SDYwZ1ZEUVNGQUJxZzlEbThwS0F4Sk9wQWVKM0RhcnlQa3dq?=
 =?utf-8?B?YUxtUXkwUXZ2UkFQa1FnWURpcnNtUWFnTklwK2dNeDU2UFp1RDdCM2ZqdDh6?=
 =?utf-8?B?YUwvRVpwSUY2TG5RMERUM3BIaldsd3RUWHhBdkd3bTZIVVhxK0FuZ1pIM0Na?=
 =?utf-8?B?bWNINUQzMHNwTWx6YlUxNk5xUDZRS1cvVFN4dGVWQ1E0RE0zOTF1SVRIV1lC?=
 =?utf-8?B?M1lQZWNXakVEYlk0a2I2Q0xpd1JwU3JLaWhMNytLOUY1bllvTVFScmVwdDFm?=
 =?utf-8?B?OHlUWWxuNzZVcGp6bTdKcEtMK1BmRFRpOVV5T2d6VFJuNlJSbDRJMm1vWnNE?=
 =?utf-8?B?R3haTGU4TE1WUkZYTFFCTWloMHIrQ1JEQnRLU1k3Rm5zQmVod2Fkb2JQN0k1?=
 =?utf-8?B?enZTNnlhZlZYSk9YQXFXVGVQbGtYREV5enI0YjIzWUFTbHdJVEFvMTRySFdJ?=
 =?utf-8?B?Y3gyTXF5emY5VVVwY3BKeFAwR0JTWGFzNDdoMkFwaVA0Nk5WYlZXY2dERXc0?=
 =?utf-8?B?cGNVMWpERmx4bXdFc3UzS3hiSlRFa0dsQzJWWktKdDhLRWsxdGF5WC9SdEZG?=
 =?utf-8?B?MkhMVmUxSXdpQXBsKzAzV1FMQzBTbTI1MVFVWmk4YlFpYUtlbjdiNnEwOVJy?=
 =?utf-8?B?clFpeUdTUnpsc013TmM4anhnUldiSmJKU0RSekhLb0VvSGxxbHVST05aRFpD?=
 =?utf-8?B?TGRQTXRwcjJoMitxS1QxNWQ3bEZGY1QxdDQrYmQzQWNaRURWeWxEK0NqeUwy?=
 =?utf-8?B?UEw4R1BGSE5WM0pJMlQ2d09Jck1rVVBWS0IyNEVPU3JmOVlramZlMC9hTWJU?=
 =?utf-8?B?SkRxdzlpVjhkeDlSYW53OUV0eEpNSXczTTFKMUdwUnJFaFloVWFXNTQ4cW83?=
 =?utf-8?B?SWloMndmN3ZaaGs0NC9PVlZOdWtVWEU2VzM3eFdlcndrblVKYmtFWDdySnl1?=
 =?utf-8?B?akgwNnNWUEwvWEZRTThNS0FyWU0yUDBsRkVGOTBOU2wzZ0h4SlhwMUhZbzF3?=
 =?utf-8?Q?EvQFPjvcmoryTV+kVRR7CoqS3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2560bcf-ab81-40b8-a88b-08db348699e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 21:01:31.6973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEefv5HZJpBMgjYUdA+OtWZndlIYn8FH8rEzq1nWo5ID5noobo9GehlTvDRZGN9NpVAcRuRC/VTiJiFP46Od+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/23 09:46, Nikunj A Dadhania wrote:
> For enabling Secure TSC, SEV-SNP guests need to communicate with the
> security coprocessor really early during boot. Lot of the required

s/security coprocessor really/AMD Secure Processor/

s/Lot/Many/

> functions are implemented in the sev-guest driver. Move the required

... in the sev-guest driver and therefore not available at early boot.

> functions and provide API to the driver to assign VM communications

s/provide API/provide an API/

s/to assign.*//

> key and send guest request.
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
>   arch/x86/Kconfig                              |   1 +
>   .../x86/include/asm}/sev-guest.h              |   6 +
>   arch/x86/include/asm/sev.h                    |  22 +
>   arch/x86/kernel/sev.c                         | 437 ++++++++++++++++-
>   drivers/virt/coco/sev-guest/Kconfig           |   1 -
>   drivers/virt/coco/sev-guest/sev-guest.c       | 455 ++----------------
>   6 files changed, 487 insertions(+), 435 deletions(-)
>   rename {drivers/virt/coco/sev-guest => arch/x86/include/asm}/sev-guest.h (86%)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index a825bf031f49..42c52bfd2bac 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1545,6 +1545,7 @@ config AMD_MEM_ENCRYPT
>   	select INSTRUCTION_DECODER
>   	select ARCH_HAS_CC_PLATFORM
>   	select X86_MEM_ENCRYPT
> +	select CRYPTO_LIB_AESGCM
>   	help
>   	  Say yes to enable support for the encryption of system memory.
>   	  This requires an AMD processor that supports Secure Memory
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.h b/arch/x86/include/asm/sev-guest.h
> similarity index 86%
> rename from drivers/virt/coco/sev-guest/sev-guest.h
> rename to arch/x86/include/asm/sev-guest.h
> index d245578d988e..834cdae302ad 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.h
> +++ b/arch/x86/include/asm/sev-guest.h
> @@ -12,6 +12,9 @@
>   
>   #include <linux/types.h>
>   
> +#define SNP_REQ_MAX_RETRY_DURATION    (60*HZ)
> +#define SNP_REQ_RETRY_DELAY           (2*HZ)
> +
>   #define MAX_AUTHTAG_LEN		32
>   #define AUTHTAG_LEN		16
>   #define AAD_LEN			48
> @@ -72,6 +75,9 @@ struct snp_guest_req {
>   	u8 msg_type;
>   };
>   
> +int snp_send_guest_request(struct snp_guest_dev *dev, struct snp_guest_req *req);
> +bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id);
> +
>   static inline bool is_vmpck_empty(u8 *vmpck)
>   {
>   	char zero_key[VMPCK_KEY_LEN] = {0};
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index ebc271bb6d8e..36868e21c3e0 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -9,6 +9,7 @@
>   #define __ASM_ENCRYPTED_STATE_H
>   
>   #include <linux/types.h>
> +#include <linux/miscdevice.h>
>   #include <asm/insn.h>
>   #include <asm/sev-common.h>
>   #include <asm/bootparam.h>
> @@ -96,6 +97,27 @@ struct snp_req_data {
>   
>   struct sev_guest_platform_data {
>   	u64 secrets_gpa;
> +
> +	void *certs_data;
> +	struct aesgcm_ctx *ctx;
> +	struct snp_guest_msg *req, *resp;
> +	struct snp_secrets_page_layout *layout;
> +	struct snp_req_data input;
> +	u8 *vmpck0;

Isn't this unneeded? You have the vmpck and vmpck_id in the snp_guest_dev 
struct which will be set based on the module parameter, so vmpck0 and 
associated checks shouldn't be needed.

> +};
> +
> +struct snp_guest_dev {
> +	struct device *dev;
> +	struct miscdevice misc;
> +
> +	/* Mutex to serialize the shared buffer access and command handling. */
> +	struct mutex cmd_mutex;
> +
> +	struct sev_guest_platform_data *pdata;
> +
> +	u32 *os_area_msg_seqno;
> +	u8 *vmpck;
> +	u8 vmpck_id;
>   };
>   
>   /*
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 3f664ab277c4..c5ca97aab8c1 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -22,10 +22,13 @@
>   #include <linux/efi.h>
>   #include <linux/platform_device.h>
>   #include <linux/io.h>
> +#include <linux/psp-sev.h>
> +#include <crypto/gcm.h>
>   
>   #include <asm/cpu_entry_area.h>
>   #include <asm/stacktrace.h>
>   #include <asm/sev.h>
> +#include <asm/sev-guest.h>
>   #include <asm/insn-eval.h>
>   #include <asm/fpu/xcr.h>
>   #include <asm/processor.h>
> @@ -982,6 +985,427 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
>   		free_page((unsigned long)vmsa);
>   }
>   
> +static struct sev_guest_platform_data *platform_data;
> +
> +/*
> + * If an error is received from the host or AMD Secure Processor (ASP) there
> + * are two options. Either retry the exact same encrypted request or discontinue
> + * using the VMPCK.
> + *
> + * This is because in the current encryption scheme GHCB v2 uses AES-GCM to
> + * encrypt the requests. The IV for this scheme is the sequence number. GCM
> + * cannot tolerate IV reuse.
> + *
> + * The ASP FW v1.51 only increments the sequence numbers on a successful
> + * guest<->ASP back and forth and only accepts messages at its exact sequence
> + * number.
> + *
> + * So if the sequence number were to be reused the encryption scheme is
> + * vulnerable. If the sequence number were incremented for a fresh IV the ASP
> + * will reject the request.
> + */
> +static void snp_disable_vmpck(struct snp_guest_dev *snp_dev)
> +{
> +	pr_alert("Disabling vmpck_id %d to prevent IV reuse.\n", snp_dev->vmpck_id);
> +	memzero_explicit(snp_dev->vmpck, VMPCK_KEY_LEN);
> +	snp_dev->vmpck = NULL;
> +}
> +
> +static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
> +{
> +	u64 count;
> +
> +	lockdep_assert_held(&snp_dev->cmd_mutex);
> +
> +	/* Read the current message sequence counter from secrets pages */
> +	count = *snp_dev->os_area_msg_seqno;
> +
> +	return count + 1;
> +}
> +
> +/* Return a non-zero on success */
> +static u64 snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
> +{
> +	u64 count = __snp_get_msg_seqno(snp_dev);
> +
> +	/*
> +	 * The message sequence counter for the SNP guest request is a  64-bit
> +	 * value but the version 2 of GHCB specification defines a 32-bit storage
> +	 * for it. If the counter exceeds the 32-bit value then return zero.
> +	 * The caller should check the return value, but if the caller happens to
> +	 * not check the value and use it, then the firmware treats zero as an
> +	 * invalid number and will fail the  message request.
> +	 */
> +	if (count >= UINT_MAX) {
> +		pr_err("SNP request message sequence counter overflow\n");
> +		return 0;
> +	}
> +
> +	return count;
> +}
> +
> +static void snp_inc_msg_seqno(struct snp_guest_dev *snp_dev)
> +{
> +	/*
> +	 * The counter is also incremented by the PSP, so increment it by 2
> +	 * and save in secrets page.
> +	 */
> +	*snp_dev->os_area_msg_seqno += 2;
> +}
> +
> +static struct aesgcm_ctx *snp_init_crypto(u8 *key, size_t keylen)
> +{
> +	struct aesgcm_ctx *ctx;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
> +	if (!ctx)
> +		return NULL;
> +
> +	if (aesgcm_expandkey(ctx, key, keylen, AUTHTAG_LEN)) {
> +		pr_err("SNP: crypto init failed\n");
> +		kfree(ctx);
> +		return NULL;
> +	}
> +
> +	return ctx;
> +}
> +
> +static void free_shared_pages(void *buf, size_t sz)
> +{
> +	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> +	int ret;
> +
> +	if (!buf)
> +		return;
> +
> +	ret = set_memory_encrypted((unsigned long)buf, npages);
> +	if (ret) {
> +		WARN_ONCE(ret, "failed to restore encryption mask (leak it)\n");
> +		return;
> +	}
> +
> +	__free_pages(virt_to_page(buf), get_order(sz));
> +}
> +
> +static void *alloc_shared_pages(size_t sz)
> +{
> +	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> +	struct page *page;
> +	int ret;
> +
> +	page = alloc_pages(GFP_KERNEL_ACCOUNT, get_order(sz));
> +	if (!page)
> +		return NULL;
> +
> +	ret = set_memory_decrypted((unsigned long)page_address(page), npages);
> +	if (ret) {
> +		pr_err("%s: failed to mark page shared, ret=%d\n", __func__, ret);
> +		__free_pages(page, get_order(sz));
> +		return NULL;
> +	}
> +
> +	return page_address(page);
> +}
> +
> +static int snp_setup_psp_messaging(struct sev_guest_platform_data *pdata)
> +{
> +	u64 gpa;
> +	int ret;
> +
> +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +		return -ENODEV;
> +
> +	gpa = get_secrets_page();
> +	if (!gpa)
> +		return -ENODEV;
> +
> +	pdata->layout = (__force void *)ioremap_encrypted(gpa, PAGE_SIZE);
> +	if (!pdata->layout) {
> +		pr_err("Unable to locate AP jump table address: failed to map the SNP secrets page.\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = -EINVAL;
> +	pdata->vmpck0 = pdata->layout->vmpck0;
> +
> +	/* Verify that VMPCK is not zero. */
> +	if (is_vmpck_empty(pdata->vmpck0)) {
> +		pr_err("vmpck id 0 is null\n");
> +		goto e_unmap;
> +	}
> +
> +	ret = -ENOMEM;
> +	/* Allocate the shared page used for the request and response message. */
> +	pdata->req = alloc_shared_pages(sizeof(struct snp_guest_msg));
> +	if (!pdata->req)
> +		goto e_unmap;
> +
> +	pdata->resp = alloc_shared_pages(sizeof(struct snp_guest_msg));
> +	if (!pdata->resp)
> +		goto e_free_request;
> +
> +	pdata->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
> +	if (!pdata->certs_data)
> +		goto e_free_response;
> +
> +	ret = -EIO;
> +	pdata->ctx = snp_init_crypto(pdata->vmpck0, VMPCK_KEY_LEN);
> +	if (!pdata->ctx)
> +		goto e_free_cert_data;
> +
> +	/* initial the input address for guest request */
> +	pdata->input.req_gpa = __pa(pdata->req);
> +	pdata->input.resp_gpa = __pa(pdata->resp);
> +	pdata->input.data_gpa = __pa(pdata->certs_data);
> +
> +	return 0;
> +
> +e_free_cert_data:
> +	free_shared_pages(pdata->certs_data, SEV_FW_BLOB_MAX_SIZE);
> +e_free_response:
> +	free_shared_pages(pdata->resp, sizeof(struct snp_guest_msg));
> +e_free_request:
> +	free_shared_pages(pdata->req, sizeof(struct snp_guest_msg));
> +e_unmap:
> +	iounmap(pdata->layout);
> +
> +	return ret;
> +}
> +
> +static int __enc_payload(struct aesgcm_ctx *ctx, struct snp_guest_msg *msg,
> +			 void *plaintext, size_t len)
> +{
> +	struct snp_guest_msg_hdr *hdr = &msg->hdr;
> +	u8 iv[GCM_AES_IV_SIZE] = {};
> +
> +	if (WARN_ON((hdr->msg_sz + ctx->authsize) > sizeof(msg->payload)))
> +		return -EBADMSG;
> +
> +	memcpy(iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
> +	aesgcm_encrypt(ctx, msg->payload, plaintext, len, &hdr->algo, AAD_LEN,
> +		       iv, hdr->authtag);
> +	return 0;
> +}
> +
> +static int dec_payload(struct aesgcm_ctx *ctx, struct snp_guest_msg *msg,
> +		       void *plaintext, size_t len)
> +{
> +	struct snp_guest_msg_hdr *hdr = &msg->hdr;
> +	u8 iv[GCM_AES_IV_SIZE] = {};
> +
> +	memcpy(iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
> +	if (aesgcm_decrypt(ctx, plaintext, msg->payload, len, &hdr->algo,
> +			   AAD_LEN, iv, hdr->authtag))
> +		return 0;
> +	else
> +		return -EBADMSG;
> +}
> +
> +static int verify_and_dec_payload(struct sev_guest_platform_data *pdata,
> +				  void *payload, u32 sz)
> +{
> +	struct snp_guest_msg *resp = pdata->resp;
> +	struct snp_guest_msg *req = pdata->req;
> +	struct snp_guest_msg_hdr *req_hdr = &req->hdr;
> +	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
> +	struct aesgcm_ctx *ctx = pdata->ctx;
> +
> +	pr_debug("response [seqno %lld type %d version %d sz %d]\n",
> +		 resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version,
> +		 resp_hdr->msg_sz);
> +
> +	/* Verify that the sequence counter is incremented by 1 */
> +	if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
> +		return -EBADMSG;
> +
> +	/* Verify response message type and version number. */
> +	if (resp_hdr->msg_type != (req_hdr->msg_type + 1) ||
> +	    resp_hdr->msg_version != req_hdr->msg_version)
> +		return -EBADMSG;
> +
> +	/*
> +	 * If the message size is greater than our buffer length then return
> +	 * an error.
> +	 */
> +	if (unlikely((resp_hdr->msg_sz + ctx->authsize) > sz))
> +		return -EBADMSG;
> +
> +	return dec_payload(ctx, resp, payload, resp_hdr->msg_sz);
> +}
> +
> +static int enc_payload(struct sev_guest_platform_data *pdata, u64 seqno,
> +		       struct snp_guest_req *req, u8 vmpck_id)
> +{
> +	struct snp_guest_msg *msg = pdata->req;
> +	struct snp_guest_msg_hdr *hdr = &msg->hdr;
> +
> +	memset(msg, 0, sizeof(*msg));
> +
> +	hdr->algo = SNP_AEAD_AES_256_GCM;
> +	hdr->hdr_version = MSG_HDR_VER;
> +	hdr->hdr_sz = sizeof(*hdr);
> +	hdr->msg_type = req->msg_type;
> +	hdr->msg_version = req->msg_version;
> +	hdr->msg_seqno = seqno;
> +	hdr->msg_vmpck = vmpck_id;
> +	hdr->msg_sz = req->req_sz;
> +
> +	/* Verify the sequence number is non-zero */
> +	if (!hdr->msg_seqno)
> +		return -ENOSR;
> +
> +	pr_debug("request [seqno %lld type %d version %d sz %d]\n",
> +		 hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
> +
> +	return __enc_payload(pdata->ctx, msg, req->req_buf, req->req_sz);
> +}
> +
> +static int __handle_guest_request(struct snp_guest_dev *snp_dev,
> +				  struct sev_guest_platform_data *pdata,
> +				  struct snp_guest_req *req)
> +{
> +	unsigned long err = 0xff, override_err = 0;
> +	unsigned long req_start = jiffies;
> +	unsigned int override_npages = 0;
> +	int rc;
> +
> +retry_request:
> +	/*
> +	 * Call firmware to process the request. In this function the encrypted
> +	 * message enters shared memory with the host. So after this call the
> +	 * sequence number must be incremented or the VMPCK must be deleted to
> +	 * prevent reuse of the IV.
> +	 */
> +	rc = snp_issue_guest_request(req->exit_code, &pdata->input, &err);
> +	switch (rc) {
> +	case -ENOSPC:
> +		/*
> +		 * If the extended guest request fails due to having too
> +		 * small of a certificate data buffer, retry the same
> +		 * guest request without the extended data request in
> +		 * order to increment the sequence number and thus avoid
> +		 * IV reuse.
> +		 */
> +		override_npages = pdata->input.data_npages;
> +		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
> +
> +		/*
> +		 * Override the error to inform callers the given extended
> +		 * request buffer size was too small and give the caller the
> +		 * required buffer size.
> +		 */
> +		override_err	= SNP_GUEST_REQ_INVALID_LEN;
> +
> +		/*
> +		 * If this call to the firmware succeeds, the sequence number can
> +		 * be incremented allowing for continued use of the VMPCK. If
> +		 * there is an error reflected in the return value, this value
> +		 * is checked further down and the result will be the deletion
> +		 * of the VMPCK and the error code being propagated back to the
> +		 * user as an ioctl() return code.
> +		 */
> +		goto retry_request;
> +
> +	/*
> +	 * The host may return SNP_GUEST_REQ_ERR_EBUSY if the request has been
> +	 * throttled. Retry in the driver to avoid returning and reusing the
> +	 * message sequence number on a different message.
> +	 */
> +	case -EAGAIN:
> +		if (jiffies - req_start > SNP_REQ_MAX_RETRY_DURATION) {
> +			rc = -ETIMEDOUT;
> +			break;
> +		}
> +		schedule_timeout_killable(SNP_REQ_RETRY_DELAY);
> +		goto retry_request;
> +	}
> +
> +	/*
> +	 * Increment the message sequence number. There is no harm in doing
> +	 * this now because decryption uses the value stored in the response
> +	 * structure and any failure will wipe the VMPCK, preventing further
> +	 * use anyway.
> +	 */
> +	snp_inc_msg_seqno(snp_dev);
> +
> +	if (req->fw_err)
> +		*req->fw_err = override_err ?: err;
> +
> +	if (override_npages)
> +		pdata->input.data_npages = override_npages;
> +
> +	/*
> +	 * If an extended guest request was issued and the supplied certificate
> +	 * buffer was not large enough, a standard guest request was issued to
> +	 * prevent IV reuse. If the standard request was successful, return -EIO
> +	 * back to the caller as would have originally been returned.
> +	 */
> +	if (!rc && override_err == SNP_GUEST_REQ_INVALID_LEN)
> +		return -EIO;
> +
> +	return rc;
> +}
> +
> +int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req)
> +{
> +	struct sev_guest_platform_data *pdata;
> +	u64 seqno;
> +	int rc;
> +
> +	if (!snp_dev || !snp_dev->pdata || !req)
> +		return -ENODEV;
> +
> +	pdata = snp_dev->pdata;
> +
> +	/* Get message sequence and verify that its a non-zero */
> +	seqno = snp_get_msg_seqno(snp_dev);
> +	if (!seqno)
> +		return -EIO;
> +
> +	memset(pdata->resp, 0, sizeof(struct snp_guest_msg));
> +
> +	/* Encrypt the provided payload */
> +	rc = enc_payload(pdata, seqno, req, snp_dev->vmpck_id);
> +	if (rc)
> +		return rc;
> +
> +	rc = __handle_guest_request(snp_dev, pdata, req);
> +	if (rc) {
> +		if (rc == -EIO && *req->fw_err == SNP_GUEST_REQ_INVALID_LEN)
> +			return rc;
> +
> +		pr_alert("Detected error from ASP request. rc: %d, fw_err: %llu\n",
> +			 rc, *req->fw_err);
> +		snp_disable_vmpck(snp_dev);
> +		return rc;
> +	}
> +
> +	rc = verify_and_dec_payload(pdata, req->resp_buf, req->resp_sz);
> +	if (rc) {
> +		pr_alert("Detected unexpected decode failure from ASP. rc: %d\n", rc);
> +		snp_disable_vmpck(snp_dev);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snp_send_guest_request);
> +
> +bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id)
> +{
> +	struct sev_guest_platform_data *pdata = dev->pdata;
> +
> +	if (!pdata || WARN_ON(vmpck_id > 3))
> +		return false;
> +
> +	dev->vmpck_id = vmpck_id;
> +	dev->vmpck = pdata->layout->vmpck0 + vmpck_id * VMPCK_KEY_LEN;
> +	dev->os_area_msg_seqno = &pdata->layout->os_area.msg_seqno_0 + vmpck_id;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(snp_assign_vmpck);
> +
>   static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
>   {
>   	struct sev_es_save_area *cur_vmsa, *vmsa;
> @@ -2247,18 +2671,17 @@ static struct platform_device sev_guest_device = {
>   
>   static int __init snp_init_platform_device(void)
>   {
> -	struct sev_guest_platform_data data;
> -	u64 gpa;
> -
>   	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>   		return -ENODEV;
>   
> -	gpa = get_secrets_page();
> -	if (!gpa)
> +	platform_data = kzalloc(sizeof(*platform_data), GFP_KERNEL);
> +	if (!platform_data)
> +		return -ENOMEM;
> +
> +	if (snp_setup_psp_messaging(platform_data))

This shouldn't be done here (or yet) since you only moving the routines. 
The sev-guest driver should call this regardless of the vmpck_id value.

>   		return -ENODEV;
>   
> -	data.secrets_gpa = gpa;
> -	if (platform_device_add_data(&sev_guest_device, &data, sizeof(data)))
> +	if (platform_device_add_data(&sev_guest_device, platform_data, sizeof(*platform_data)))
>   		return -ENODEV;
>   
>   	if (platform_device_register(&sev_guest_device))
> diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
> index bcc760bfb468..c130456ad401 100644
> --- a/drivers/virt/coco/sev-guest/Kconfig
> +++ b/drivers/virt/coco/sev-guest/Kconfig
> @@ -2,7 +2,6 @@ config SEV_GUEST
>   	tristate "AMD SEV Guest driver"
>   	default m
>   	depends on AMD_MEM_ENCRYPT
> -	select CRYPTO_LIB_AESGCM
>   	help
>   	  SEV-SNP firmware provides the guest a mechanism to communicate with
>   	  the PSP without risk from a malicious hypervisor who wishes to read,
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 4901ebc8fa1a..a011df21c03a 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -24,110 +24,25 @@
>   #include <asm/svm.h>
>   #include <asm/sev.h>
>   
> -#include "sev-guest.h"
> +#include <asm/sev-guest.h>
>   
>   #define DEVICE_NAME	"sev-guest"
>   
> -#define SNP_REQ_MAX_RETRY_DURATION	(60*HZ)
> -#define SNP_REQ_RETRY_DELAY		(2*HZ)
> -
> -struct snp_guest_dev {
> -	struct device *dev;
> -	struct miscdevice misc;
> -
> -	/* Mutex to serialize the shared buffer access and command handling. */
> -	struct mutex cmd_mutex;
> -
> -	void *certs_data;
> -	struct aesgcm_ctx *ctx;
> -	struct snp_guest_msg *request, *response;
> -	struct snp_secrets_page_layout *layout;
> -	struct snp_req_data input;
> -	u32 *os_area_msg_seqno;
> -	u8 *vmpck;
> -	u8 vmpck_id;
> -};
> -
>   static u32 vmpck_id;
>   module_param(vmpck_id, uint, 0444);
>   MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
>   
>   static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
>   {
> -	if (snp_dev && snp_dev->ctx)
> -		return snp_dev->ctx->authsize;
> +	struct sev_guest_platform_data *pdata = snp_dev->pdata;
> +
> +	if (pdata && pdata->ctx)
> +		return pdata->ctx->authsize;
>   
>   	WARN_ONCE(1, "Unable to get crypto authsize\n");
>   	return 0;
>   }
>   
> -/*
> - * If an error is received from the host or AMD Secure Processor (ASP) there
> - * are two options. Either retry the exact same encrypted request or discontinue
> - * using the VMPCK.
> - *
> - * This is because in the current encryption scheme GHCB v2 uses AES-GCM to
> - * encrypt the requests. The IV for this scheme is the sequence number. GCM
> - * cannot tolerate IV reuse.
> - *
> - * The ASP FW v1.51 only increments the sequence numbers on a successful
> - * guest<->ASP back and forth and only accepts messages at its exact sequence
> - * number.
> - *
> - * So if the sequence number were to be reused the encryption scheme is
> - * vulnerable. If the sequence number were incremented for a fresh IV the ASP
> - * will reject the request.
> - */
> -static void snp_disable_vmpck(struct snp_guest_dev *snp_dev)
> -{
> -	dev_alert(snp_dev->dev, "Disabling vmpck_id %d to prevent IV reuse.\n",
> -		  snp_dev->vmpck_id);
> -	memzero_explicit(snp_dev->vmpck, VMPCK_KEY_LEN);
> -	snp_dev->vmpck = NULL;
> -}
> -
> -static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
> -{
> -	u64 count;
> -
> -	lockdep_assert_held(&snp_dev->cmd_mutex);
> -
> -	/* Read the current message sequence counter from secrets pages */
> -	count = *snp_dev->os_area_msg_seqno;
> -
> -	return count + 1;
> -}
> -
> -/* Return a non-zero on success */
> -static u64 snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
> -{
> -	u64 count = __snp_get_msg_seqno(snp_dev);
> -
> -	/*
> -	 * The message sequence counter for the SNP guest request is a  64-bit
> -	 * value but the version 2 of GHCB specification defines a 32-bit storage
> -	 * for it. If the counter exceeds the 32-bit value then return zero.
> -	 * The caller should check the return value, but if the caller happens to
> -	 * not check the value and use it, then the firmware treats zero as an
> -	 * invalid number and will fail the  message request.
> -	 */
> -	if (count >= UINT_MAX) {
> -		dev_err(snp_dev->dev, "request message sequence counter overflow\n");
> -		return 0;
> -	}
> -
> -	return count;
> -}
> -
> -static void snp_inc_msg_seqno(struct snp_guest_dev *snp_dev)
> -{
> -	/*
> -	 * The counter is also incremented by the PSP, so increment it by 2
> -	 * and save in secrets page.
> -	 */
> -	*snp_dev->os_area_msg_seqno += 2;
> -}
> -
>   static inline struct snp_guest_dev *to_snp_dev(struct file *file)
>   {
>   	struct miscdevice *dev = file->private_data;
> @@ -135,236 +50,6 @@ static inline struct snp_guest_dev *to_snp_dev(struct file *file)
>   	return container_of(dev, struct snp_guest_dev, misc);
>   }
>   
> -static struct aesgcm_ctx *snp_init_crypto(u8 *key, size_t keylen)
> -{
> -	struct aesgcm_ctx *ctx;
> -
> -	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
> -	if (!ctx)
> -		return NULL;
> -
> -	if (aesgcm_expandkey(ctx, key, keylen, AUTHTAG_LEN)) {
> -		pr_err("SNP: crypto init failed\n");
> -		kfree(ctx);
> -		return NULL;
> -	}
> -
> -	return ctx;
> -}
> -
> -static int __enc_payload(struct aesgcm_ctx *ctx, struct snp_guest_msg *msg,
> -			 void *plaintext, size_t len)
> -{
> -	struct snp_guest_msg_hdr *hdr = &msg->hdr;
> -	u8 iv[GCM_AES_IV_SIZE] = {};
> -
> -	if (WARN_ON((hdr->msg_sz + ctx->authsize) > sizeof(msg->payload)))
> -		return -EBADMSG;
> -
> -	memcpy(iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
> -	aesgcm_encrypt(ctx, msg->payload, plaintext, len, &hdr->algo, AAD_LEN,
> -		       iv, hdr->authtag);
> -	return 0;
> -}
> -
> -static int dec_payload(struct aesgcm_ctx *ctx, struct snp_guest_msg *msg,
> -		       void *plaintext, size_t len)
> -{
> -	struct snp_guest_msg_hdr *hdr = &msg->hdr;
> -	u8 iv[GCM_AES_IV_SIZE] = {};
> -
> -	memcpy(iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
> -	if (aesgcm_decrypt(ctx, plaintext, msg->payload, len, &hdr->algo,
> -			   AAD_LEN, iv, hdr->authtag))
> -		return 0;
> -	else
> -		return -EBADMSG;
> -}
> -
> -static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
> -{
> -	struct snp_guest_msg *resp = snp_dev->response;
> -	struct snp_guest_msg *req = snp_dev->request;
> -	struct snp_guest_msg_hdr *req_hdr = &req->hdr;
> -	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
> -	struct aesgcm_ctx *ctx = snp_dev->ctx;
> -
> -	pr_debug("response [seqno %lld type %d version %d sz %d]\n",
> -		 resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version,
> -		 resp_hdr->msg_sz);
> -
> -	/* Verify that the sequence counter is incremented by 1 */
> -	if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
> -		return -EBADMSG;
> -
> -	/* Verify response message type and version number. */
> -	if (resp_hdr->msg_type != (req_hdr->msg_type + 1) ||
> -	    resp_hdr->msg_version != req_hdr->msg_version)
> -		return -EBADMSG;
> -
> -	/*
> -	 * If the message size is greater than our buffer length then return
> -	 * an error.
> -	 */
> -	if (unlikely((resp_hdr->msg_sz + ctx->authsize) > sz))
> -		return -EBADMSG;
> -
> -	/* Decrypt the payload */
> -	return dec_payload(ctx, resp, payload, resp_hdr->msg_sz);
> -}
> -
> -static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno,
> -		       struct snp_guest_req *req, u8 __vmpck_id)
> -{
> -	struct snp_guest_msg *msg = snp_dev->request;
> -	struct snp_guest_msg_hdr *hdr = &msg->hdr;
> -
> -	memset(msg, 0, sizeof(*msg));
> -
> -	hdr->algo = SNP_AEAD_AES_256_GCM;
> -	hdr->hdr_version = MSG_HDR_VER;
> -	hdr->hdr_sz = sizeof(*hdr);
> -	hdr->msg_type = req->msg_type;
> -	hdr->msg_version = req->msg_version;
> -	hdr->msg_seqno = seqno;
> -	hdr->msg_vmpck = __vmpck_id;
> -	hdr->msg_sz = req->req_sz;
> -
> -	/* Verify the sequence number is non-zero */
> -	if (!hdr->msg_seqno)
> -		return -ENOSR;
> -
> -	pr_debug("request [seqno %lld type %d version %d sz %d]\n",
> -		hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
> -
> -	return __enc_payload(snp_dev->ctx, msg, req->req_buf, req->req_sz);
> -}
> -
> -static int __handle_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req)
> -{
> -	unsigned long err = 0xff, override_err = 0;
> -	unsigned long req_start = jiffies;
> -	unsigned int override_npages = 0;
> -	int rc;
> -
> -retry_request:
> -	/*
> -	 * Call firmware to process the request. In this function the encrypted
> -	 * message enters shared memory with the host. So after this call the
> -	 * sequence number must be incremented or the VMPCK must be deleted to
> -	 * prevent reuse of the IV.
> -	 */
> -	rc = snp_issue_guest_request(req->exit_code, &snp_dev->input, &err);
> -	switch (rc) {
> -	case -ENOSPC:
> -		/*
> -		 * If the extended guest request fails due to having too
> -		 * small of a certificate data buffer, retry the same
> -		 * guest request without the extended data request in
> -		 * order to increment the sequence number and thus avoid
> -		 * IV reuse.
> -		 */
> -		override_npages = snp_dev->input.data_npages;
> -		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
> -
> -		/*
> -		 * Override the error to inform callers the given extended
> -		 * request buffer size was too small and give the caller the
> -		 * required buffer size.
> -		 */
> -		override_err	= SNP_GUEST_REQ_INVALID_LEN;
> -
> -		/*
> -		 * If this call to the firmware succeeds, the sequence number can
> -		 * be incremented allowing for continued use of the VMPCK. If
> -		 * there is an error reflected in the return value, this value
> -		 * is checked further down and the result will be the deletion
> -		 * of the VMPCK and the error code being propagated back to the
> -		 * user as an ioctl() return code.
> -		 */
> -		goto retry_request;
> -
> -	/*
> -	 * The host may return SNP_GUEST_REQ_ERR_EBUSY if the request has been
> -	 * throttled. Retry in the driver to avoid returning and reusing the
> -	 * message sequence number on a different message.
> -	 */
> -	case -EAGAIN:
> -		if (jiffies - req_start > SNP_REQ_MAX_RETRY_DURATION) {
> -			rc = -ETIMEDOUT;
> -			break;
> -		}
> -		schedule_timeout_killable(SNP_REQ_RETRY_DELAY);
> -		goto retry_request;
> -	}
> -
> -	/*
> -	 * Increment the message sequence number. There is no harm in doing
> -	 * this now because decryption uses the value stored in the response
> -	 * structure and any failure will wipe the VMPCK, preventing further
> -	 * use anyway.
> -	 */
> -	snp_inc_msg_seqno(snp_dev);
> -
> -	if (req->fw_err)
> -		*req->fw_err = override_err ?: err;
> -
> -	if (override_npages)
> -		snp_dev->input.data_npages = override_npages;
> -
> -	/*
> -	 * If an extended guest request was issued and the supplied certificate
> -	 * buffer was not large enough, a standard guest request was issued to
> -	 * prevent IV reuse. If the standard request was successful, return -EIO
> -	 * back to the caller as would have originally been returned.
> -	 */
> -	if (!rc && override_err == SNP_GUEST_REQ_INVALID_LEN)
> -		return -EIO;
> -
> -	return rc;
> -}
> -
> -static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req)
> -{
> -	u64 seqno;
> -	int rc;
> -
> -	if (!snp_dev || !req)
> -		return -ENODEV;
> -
> -	/* Get message sequence and verify that its a non-zero */
> -	seqno = snp_get_msg_seqno(snp_dev);
> -	if (!seqno)
> -		return -EIO;
> -
> -	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
> -
> -	/* Encrypt the userspace provided payload */
> -	rc = enc_payload(snp_dev, seqno, req, snp_dev->vmpck_id);
> -	if (rc)
> -		return rc;
> -
> -	rc = __handle_guest_request(snp_dev, req);
> -	if (rc) {
> -		if (rc == -EIO && *req->fw_err == SNP_GUEST_REQ_INVALID_LEN)
> -			return rc;
> -
> -		dev_alert(snp_dev->dev, "Detected error from ASP request. rc: %d, fw_err: %llu\n",
> -			  rc, *req->fw_err);
> -		snp_disable_vmpck(snp_dev);
> -		return rc;
> -	}
> -
> -	rc = verify_and_dec_payload(snp_dev, req->resp_buf, req->resp_sz);
> -	if (rc) {
> -		dev_alert(snp_dev->dev, "Detected unexpected decode failure from ASP. rc: %d\n", rc);
> -		snp_disable_vmpck(snp_dev);
> -		return rc;
> -	}
> -
> -	return 0;
> -}
> -
>   static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, u8 msg_version,
>   				u8 msg_type, void *req_buf, size_t req_sz, void *resp_buf,
>   				u32 resp_sz, __u64 *fw_err)
> @@ -463,12 +148,14 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
>   
>   static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
>   {
> +	struct sev_guest_platform_data *pdata;
>   	struct snp_ext_report_req req;
>   	struct snp_report_resp *resp;
>   	int ret, npages = 0, resp_len;
>   
>   	lockdep_assert_held(&snp_dev->cmd_mutex);
>   
> +	pdata = snp_dev->pdata;
>   	if (!arg->req_data || !arg->resp_data)
>   		return -EINVAL;
>   
> @@ -492,7 +179,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   	 * the host. If host does not supply any certs in it, then copy
>   	 * zeros to indicate that certificate data was not provided.
>   	 */
> -	memset(snp_dev->certs_data, 0, req.certs_len);
> +	memset(pdata->certs_data, 0, req.certs_len);
>   	npages = req.certs_len >> PAGE_SHIFT;
>   cmd:
>   	/*
> @@ -505,14 +192,14 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   	if (!resp)
>   		return -ENOMEM;
>   
> -	snp_dev->input.data_npages = npages;
> +	pdata->input.data_npages = npages;
>   	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
>   				   SNP_MSG_REPORT_REQ, &req.data,
>   				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
>   
>   	/* If certs length is invalid then copy the returned length */
>   	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
> -		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
> +		req.certs_len = pdata->input.data_npages << PAGE_SHIFT;
>   
>   		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
>   			ret = -EFAULT;
> @@ -522,7 +209,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   		goto e_free;
>   
>   	if (npages &&
> -	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
> +	    copy_to_user((void __user *)req.certs_address, pdata->certs_data,
>   			 req.certs_len)) {
>   		ret = -EFAULT;
>   		goto e_free;
> @@ -583,68 +270,17 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   	return ret;
>   }
>   
> -static void free_shared_pages(void *buf, size_t sz)
> -{
> -	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> -	int ret;
> -
> -	if (!buf)
> -		return;
> -
> -	ret = set_memory_encrypted((unsigned long)buf, npages);
> -	if (ret) {
> -		WARN_ONCE(ret, "failed to restore encryption mask (leak it)\n");
> -		return;
> -	}
> -
> -	__free_pages(virt_to_page(buf), get_order(sz));
> -}
> -
> -static void *alloc_shared_pages(struct device *dev, size_t sz)
> -{
> -	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> -	struct page *page;
> -	int ret;
> -
> -	page = alloc_pages(GFP_KERNEL_ACCOUNT, get_order(sz));
> -	if (!page)
> -		return NULL;
> -
> -	ret = set_memory_decrypted((unsigned long)page_address(page), npages);
> -	if (ret) {
> -		dev_err(dev, "failed to mark page shared, ret=%d\n", ret);
> -		__free_pages(page, get_order(sz));
> -		return NULL;
> -	}
> -
> -	return page_address(page);
> -}
> -
>   static const struct file_operations snp_guest_fops = {
>   	.owner	= THIS_MODULE,
>   	.unlocked_ioctl = snp_guest_ioctl,
>   };
>   
> -bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id)
> -{
> -	if (WARN_ON(vmpck_id > 3))
> -		return false;
> -
> -	dev->vmpck_id = vmpck_id;
> -	dev->vmpck = dev->layout->vmpck0 + vmpck_id * VMPCK_KEY_LEN;
> -	dev->os_area_msg_seqno = &dev->layout->os_area.msg_seqno_0 + vmpck_id;
> -
> -	return true;
> -}
> -
>   static int __init sev_guest_probe(struct platform_device *pdev)
>   {
> -	struct snp_secrets_page_layout *layout;
> -	struct sev_guest_platform_data *data;
> +	struct sev_guest_platform_data *pdata;
>   	struct device *dev = &pdev->dev;
>   	struct snp_guest_dev *snp_dev;
>   	struct miscdevice *misc;
> -	void __iomem *mapping;
>   	int ret;
>   
>   	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> @@ -653,80 +289,48 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   	if (!dev->platform_data)
>   		return -ENODEV;
>   
> -	data = (struct sev_guest_platform_data *)dev->platform_data;
> -	mapping = ioremap_encrypted(data->secrets_gpa, PAGE_SIZE);
> -	if (!mapping)
> -		return -ENODEV;
> -
> -	layout = (__force void *)mapping;
> -
> -	ret = -ENOMEM;
> +	pdata = (struct sev_guest_platform_data *)dev->platform_data;
>   	snp_dev = devm_kzalloc(&pdev->dev, sizeof(struct snp_guest_dev), GFP_KERNEL);
>   	if (!snp_dev)
> -		goto e_unmap;
> +		return -ENOMEM;
>   
>   	ret = -EINVAL;
> -	snp_dev->layout = layout;
> +	snp_dev->pdata = pdata;
>   	if (!snp_assign_vmpck(snp_dev, vmpck_id)) {
>   		dev_err(dev, "invalid vmpck id %d\n", vmpck_id);
> -		goto e_unmap;
> +		goto e_free_snpdev;
>   	}
>   
>   	/* Verify that VMPCK is not zero. */
>   	if (is_vmpck_empty(snp_dev->vmpck)) {
>   		dev_err(dev, "vmpck id %d is null\n", vmpck_id);
> -		goto e_unmap;
> +		goto e_free_snpdev;
> +	}
> +
> +	/* Skip VMPCK0 initialization as the key is already initialized during early boot */
> +	if (vmpck_id && aesgcm_expandkey(pdata->ctx, snp_dev->vmpck, VMPCK_KEY_LEN, AUTHTAG_LEN)) {

See previous comment. The sev-guest driver should be setting up everything 
private to it no matter the vmpck to be used.

Thanks,
Tom

> +		ret = -ENODEV;
> +		goto e_free_snpdev;
>   	}
>   
>   	mutex_init(&snp_dev->cmd_mutex);
>   	platform_set_drvdata(pdev, snp_dev);
>   	snp_dev->dev = dev;
>   
> -	/* Allocate the shared page used for the request and response message. */
> -	snp_dev->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
> -	if (!snp_dev->request)
> -		goto e_unmap;
> -
> -	snp_dev->response = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
> -	if (!snp_dev->response)
> -		goto e_free_request;
> -
> -	snp_dev->certs_data = alloc_shared_pages(dev, SEV_FW_BLOB_MAX_SIZE);
> -	if (!snp_dev->certs_data)
> -		goto e_free_response;
> -
> -	ret = -EIO;
> -	snp_dev->ctx = snp_init_crypto(snp_dev->vmpck, VMPCK_KEY_LEN);
> -	if (!snp_dev->ctx)
> -		goto e_free_cert_data;
> -
>   	misc = &snp_dev->misc;
>   	misc->minor = MISC_DYNAMIC_MINOR;
>   	misc->name = DEVICE_NAME;
>   	misc->fops = &snp_guest_fops;
>   
> -	/* initial the input address for guest request */
> -	snp_dev->input.req_gpa = __pa(snp_dev->request);
> -	snp_dev->input.resp_gpa = __pa(snp_dev->response);
> -	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
> -
> -	ret =  misc_register(misc);
> +	ret = misc_register(misc);
>   	if (ret)
> -		goto e_free_ctx;
> +		goto e_free_snpdev;
>   
>   	dev_info(dev, "Initialized SEV guest driver (using vmpck_id %d)\n", vmpck_id);
>   	return 0;
>   
> -e_free_ctx:
> -	kfree(snp_dev->ctx);
> -e_free_cert_data:
> -	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
> -e_free_response:
> -	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
> -e_free_request:
> -	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
> -e_unmap:
> -	iounmap(mapping);
> +e_free_snpdev:
> +	kfree(snp_dev);
>   	return ret;
>   }
>   
> @@ -734,11 +338,8 @@ static int __exit sev_guest_remove(struct platform_device *pdev)
>   {
>   	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
>   
> -	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
> -	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
> -	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
> -	kfree(snp_dev->ctx);
>   	misc_deregister(&snp_dev->misc);
> +	kfree(snp_dev);
>   
>   	return 0;
>   }
