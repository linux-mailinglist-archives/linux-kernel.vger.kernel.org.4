Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4845715C56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjE3K5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjE3K4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E13D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685444164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7r4Mnem7kmzwqmYPUjeTXwU41wAFR83DgbxuqCZJ8nM=;
        b=V3NylsnVcUKXlon4E5PNzDUEKnboVteO/E19K8veTt7ekBBz4YJFbyKiWjm4+5T/9CjAM7
        M3aAwYnkai5xVjGrVmNexSJlnkFsTE3AYTWh5l0zXW1X6SYxUXpxuozccE+wXj7vGI0wiS
        k66I564gofYrwdFeklhIABCHl85AXfA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-5c_DZ-WlOzGJYjjkTy2o6w-1; Tue, 30 May 2023 06:55:55 -0400
X-MC-Unique: 5c_DZ-WlOzGJYjjkTy2o6w-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-64f383f88dfso1020023b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685444154; x=1688036154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7r4Mnem7kmzwqmYPUjeTXwU41wAFR83DgbxuqCZJ8nM=;
        b=QBAZjleUpjpTXisxmVnM1tAQunVKG4bCA3dznEIO1S9ZNo1sUbNi3o6/Ke46UDG9JS
         burm3Gp0iXzM9kvyjJa+4WEO8vQZrIiC8mZZ/skDGXvY3P3JIPm6cl4fLvwvhMcVdO79
         wSLhmR8N9UZOgo3iktOYvXf3Vtz6DZ7TgQyLv5vX/0KfjZlHbmo6DEy72ke7wi42T+gl
         pf85pmUDMO/WB0vAJKVZpS87IrtANftNdLvTprLdEZBr64DalSA1N2LwDpl3t/8ut4ox
         uHVa1bgi+j8x9f/bMtUf64yxk4pxE3adEvFNQf6PB7l6y89Mb5ndqQc2n9eqVFpvjPgP
         zwpA==
X-Gm-Message-State: AC+VfDwYEWlBy3zjVOZ8IDcl5ihcb/tFT3YWXUN8DHehwc8dcqhTlzT2
        hurrETljXmsmYo5oLqxX5rzsRiUx+FBBMjjcKPavAm0tDykxVMAPMjth5+jhROtNWHsbFYiEDkv
        YN5IK3KNGJuttRatYwV8QA0DL
X-Received: by 2002:a17:902:d2cf:b0:1ad:eada:598b with SMTP id n15-20020a170902d2cf00b001adeada598bmr2094734plc.3.1685444154261;
        Tue, 30 May 2023 03:55:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7CUOUu5tniDT9Anx1jndbJZo9eoV8LSBuK+IXZEX8MBQk8TjG7H9ErpJBB2Mbo63Rdlv0pCg==
X-Received: by 2002:a17:902:d2cf:b0:1ad:eada:598b with SMTP id n15-20020a170902d2cf00b001adeada598bmr2094720plc.3.1685444153998;
        Tue, 30 May 2023 03:55:53 -0700 (PDT)
Received: from [10.66.61.39] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f7d400b001aaed55aff3sm5579270plw.137.2023.05.30.03.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 03:55:53 -0700 (PDT)
Message-ID: <3772ec3f-cafa-6d90-77e4-d1594e4046dd@redhat.com>
Date:   Tue, 30 May 2023 18:55:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 7/7] arm64/sysreg: Convert OSECCR_EL1 to automatic
 generation
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
References: <20230419-arm64-syreg-gen-v2-0-4c6add1f6257@kernel.org>
 <20230419-arm64-syreg-gen-v2-7-4c6add1f6257@kernel.org>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20230419-arm64-syreg-gen-v2-7-4c6add1f6257@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/23 02:37, Mark Brown wrote:
> Convert OSECCR_EL1 to automatic generation as per DDI0601 2023-03, no
> functional changes.
> 
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   arch/arm64/include/asm/sysreg.h | 1 -
>   arch/arm64/tools/sysreg         | 5 +++++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index d9711f1e47b2..23a17da500a4 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -134,7 +134,6 @@
>   #define SYS_SVCR_SMSTART_SM_EL0		sys_reg(0, 3, 4, 3, 3)
>   #define SYS_SVCR_SMSTOP_SMZA_EL0	sys_reg(0, 3, 4, 6, 3)
>   
> -#define SYS_OSECCR_EL1			sys_reg(2, 0, 0, 6, 2)
>   #define SYS_DBGBVRn_EL1(n)		sys_reg(2, 0, 0, n, 4)
>   #define SYS_DBGBCRn_EL1(n)		sys_reg(2, 0, 0, n, 5)
>   #define SYS_DBGWVRn_EL1(n)		sys_reg(2, 0, 0, n, 6)
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index e18ae1df41f4..41462785020b 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -93,6 +93,11 @@ Res0	63:32
>   Field	31:0	DTRTX
>   EndSysreg
>   
> +Sysreg	OSECCR_EL1	2	0	0	6	2
> +Res0	63:32
> +Field	31:0	EDECCR
> +EndSysreg
> +
>   Sysreg	OSLAR_EL1	2	0	1	0	4
>   Res0	63:1
>   Field	0	OSLK
> 

-- 
Shaoqin

