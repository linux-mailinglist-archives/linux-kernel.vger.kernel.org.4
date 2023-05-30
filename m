Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB68C715C50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjE3K4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjE3K4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027C893
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685444118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eiBtAh/D0PsnpjLnM52N86s5X6wpcHIAyqVS4sikzak=;
        b=BTh+1eUDXUCQxEqXOCZl32pBOsRIY7Xw/N+tvUXxUcEtNY7IjkrEhPQ3dOgIcnNiZe95G4
        MUiRFGb0b/2P4scU+WhsXvsdqZ9vM4XNljow41IHqdxPJMKQxUMdo21dcmMBq2Ghxq0Fye
        pUo+Gsxc08gxX0jI7xu8BskE/pjwwRE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-Vt_g4mmiPKCxUREdAA7L1Q-1; Tue, 30 May 2023 06:55:16 -0400
X-MC-Unique: Vt_g4mmiPKCxUREdAA7L1Q-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b01d3c6fe9so4288515ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685444116; x=1688036116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiBtAh/D0PsnpjLnM52N86s5X6wpcHIAyqVS4sikzak=;
        b=cZjdq4tOoaJXID9328s8AzBBhabzRtaLKTlRwP4U48aYsxZ1Zq1f5CDGVm1ZzTmiwH
         yek8VXH+Edqag3b7SorGgEOq8L1ObPAZNgsAIyEcHhYQI/4M/trv6gSNKoR87F9PPa08
         k2/jbhqM2njwR0XcPJyC1T1R35WoFn9q4AzrOh8MmV9em7bEqsnsEuo7BVqT24qGXDSm
         HfsdLsqNho3qBl4l5lcYHmHFY33P/Xr0uiUIPzo+kpp6jyiFgg2y0/w+xX0rDVVFsZ1c
         nUcwXT2Q7GZ86qSZUP9uwR/uLB4ufr9ZVhNwoZCssyGsSovy0dUAa5QDUecPy2Lb2GlP
         osOg==
X-Gm-Message-State: AC+VfDz3eXTlDYtw290BaApA1VuY/srFB5YGtYz93hOx2hqj2H+z9MOc
        9BZFEDWg7TMnZKgPxPhDUzMd+FZ/s9L3uxFYH3Jex9pHhkhug+Eifi+3NMk6Y8wqTqy7RBMe91h
        d/haFtvh7PubZ6ZpNuE2tFHs+
X-Received: by 2002:a17:902:e841:b0:1ae:1364:6086 with SMTP id t1-20020a170902e84100b001ae13646086mr2163552plg.2.1685444115849;
        Tue, 30 May 2023 03:55:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63i9bPDIDLHsXNbID88iB0tQfOX/vDYe4JH76mNdjCwq1KXrg2EyLU27+UhIx9c9bfl/N1Ig==
X-Received: by 2002:a17:902:e841:b0:1ae:1364:6086 with SMTP id t1-20020a170902e84100b001ae13646086mr2163540plg.2.1685444115587;
        Tue, 30 May 2023 03:55:15 -0700 (PDT)
Received: from [10.66.61.39] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ce8c00b0019aaab3f9d7sm9978616plg.113.2023.05.30.03.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 03:55:15 -0700 (PDT)
Message-ID: <07664387-ad45-02ec-8d67-b42f38b86191@redhat.com>
Date:   Tue, 30 May 2023 18:55:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 5/7] arm64/sysreg: Convert OSDTRRX_EL1 to automatic
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
 <20230419-arm64-syreg-gen-v2-5-4c6add1f6257@kernel.org>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20230419-arm64-syreg-gen-v2-5-4c6add1f6257@kernel.org>
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
> Convert OSDTRRX_EL1 to automatic generation as per DDI0601 2023-03, no
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
> index 1901b676d7c6..da954a6eba24 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -134,7 +134,6 @@
>   #define SYS_SVCR_SMSTART_SM_EL0		sys_reg(0, 3, 4, 3, 3)
>   #define SYS_SVCR_SMSTOP_SMZA_EL0	sys_reg(0, 3, 4, 6, 3)
>   
> -#define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
>   #define SYS_OSDTRTX_EL1			sys_reg(2, 0, 0, 3, 2)
>   #define SYS_OSECCR_EL1			sys_reg(2, 0, 0, 6, 2)
>   #define SYS_DBGBVRn_EL1(n)		sys_reg(2, 0, 0, n, 4)
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index b0aefdf9ed34..e4653248dcac 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -48,6 +48,11 @@
>   # feature that introduces them (eg, FEAT_LS64_ACCDATA introduces enumeration
>   # item ACCDATA) though it may be more taseful to do something else.
>   
> +Sysreg	OSDTRRX_EL1	2	0	0	0	2
> +Res0	63:32
> +Field	31:0	DTRRX
> +EndSysreg
> +
>   Sysreg	MDCCINT_EL1	2	0	0	2	0
>   Res0	63:31
>   Field	30	RX
> 

-- 
Shaoqin

