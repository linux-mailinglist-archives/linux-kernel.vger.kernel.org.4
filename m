Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3AB70DB9E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbjEWLlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjEWLli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026E0FA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684842053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8vwN/9ONMx0u75LjIXt1q27M2hiO9w6JZhlO31A3kkY=;
        b=O8phUx42JpsEg9Di4lCBfou8zT2BY3sa+s50K0RMmlABoVoA6p6tpRHzrPhks99ifbOqtw
        vgQViUYlxqnniFCdPqhtNXoe/X339QlWuvwjyVhDwAoMdLFePAIpJXzvhwRBsCrQ64+oZ5
        enzBfFiKwRkZMTK9CF16LpTrD0UnTic=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-jL5MpLu7NHanBbRdoWyPag-1; Tue, 23 May 2023 07:40:52 -0400
X-MC-Unique: jL5MpLu7NHanBbRdoWyPag-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-64ebcb9f300so377147b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684842051; x=1687434051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vwN/9ONMx0u75LjIXt1q27M2hiO9w6JZhlO31A3kkY=;
        b=HCFu+1WlbXdHsFFa/9f32E+ra0L4Q3Xza9vaFBqdaI6tstVYomTNDP4HebOmAFQdzZ
         c4PltcnllZANnwqr+MANsTkxgNoQzid134dkHZbQb2hFJP7u17oNNTXKfY6l11+KpNN5
         VfYmgP44ZKwU2Ow+KHAQmhmIftgYferApn5sLkXyJvy+Vzf2ASAIS2CBw3OBjCOj/fph
         qEZFrapZbsVUsVRialbcBZRTq82e9vxfVF83x1muUjQ+mJGyrJFmmufBiZqtu5Glhh5q
         d0IheXSR2MpbwKsr7TGRQLlvIu4lGnDGea8opULlR6iujmFtaWKhl1E6IipI3gES747Z
         +OPg==
X-Gm-Message-State: AC+VfDwe2UrfJ57BK7xK5eGkKeemPfuLt29QRurMHj02vMC68y5g37aq
        ojoKqjXtjWuYCM7T5obSrL6VQM9JIeyWJqsJLDmqID2owDAzBZBwuhGjwYOMhKMd72NtKT+YphS
        DD47j87XJSl3YzMuXbC4LlocX
X-Received: by 2002:a05:6a00:278d:b0:63d:344c:f123 with SMTP id bd13-20020a056a00278d00b0063d344cf123mr12547069pfb.1.1684842051530;
        Tue, 23 May 2023 04:40:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6KAkmKYimV0HIhjj7YW0o0S1TP50XzDvn3w+bGqWEzOjPBmCXpIIiCMMjpGdQLylkmEBtNuA==
X-Received: by 2002:a05:6a00:278d:b0:63d:344c:f123 with SMTP id bd13-20020a056a00278d00b0063d344cf123mr12547045pfb.1.1684842051182;
        Tue, 23 May 2023 04:40:51 -0700 (PDT)
Received: from [10.66.61.39] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j18-20020aa783d2000000b0064f4aeedaa2sm313004pfn.105.2023.05.23.04.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 04:40:50 -0700 (PDT)
Message-ID: <c1dba172-930b-f3da-c4f3-8ce640297edf@redhat.com>
Date:   Tue, 23 May 2023 19:40:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/5] arm64/sysreg: Convert MDSCR_EL1 to automatic register
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
References: <20230419-arm64-syreg-gen-v1-0-936cd769cb9e@kernel.org>
 <20230419-arm64-syreg-gen-v1-3-936cd769cb9e@kernel.org>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20230419-arm64-syreg-gen-v1-3-936cd769cb9e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 00:22, Mark Brown wrote:
> Convert MDSCR_EL1 to automatic register generation as per DDI0616 2023-03.
> No functional change.
> 
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   arch/arm64/include/asm/sysreg.h |  1 -
>   arch/arm64/tools/sysreg         | 28 ++++++++++++++++++++++++++++
>   2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 4e48bb4dca6a..4ecae92b56b5 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -134,7 +134,6 @@
>   #define SYS_SVCR_SMSTART_SM_EL0		sys_reg(0, 3, 4, 3, 3)
>   #define SYS_SVCR_SMSTOP_SMZA_EL0	sys_reg(0, 3, 4, 6, 3)
>   
> -#define SYS_MDSCR_EL1			sys_reg(2, 0, 0, 2, 2)
>   #define SYS_DBGBVRn_EL1(n)		sys_reg(2, 0, 0, n, 4)
>   #define SYS_DBGBCRn_EL1(n)		sys_reg(2, 0, 0, n, 5)
>   #define SYS_DBGWVRn_EL1(n)		sys_reg(2, 0, 0, n, 6)
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 1699e87bc0b4..a5ae0e19fc9f 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -55,6 +55,34 @@ Field	29	TX
>   Res0	28:0
>   EndSysreg
>   
> +Sysreg	MDSCR_EL1	2	0	0	2	2
> +Res0	63:36
> +Field	35	EHBWE
> +Field	34	EnSPM
> +Field	33	TTA
> +Field	32	EMBWE
> +Field	31	TFO
> +Field	30	RXfull
> +Field	29	TXfull
> +Res0	28
> +Field	27	RXO
> +Field	26	TXU
> +Res0	25:24
> +Field	23:22	INTdis
> +Field	21	TDA
> +Res0	20
> +Field	19	SC2
> +Res0	18:16
> +Field	15	MDE
> +Field	14	HDE
> +Field	13	KDE
> +Field	12	TDCC
> +Res0	11:7
> +Field	6	ERR
> +Res0	5:1
> +Field	0	SS
> +EndSysreg
> +
>   Sysreg ID_PFR0_EL1	3	0	0	1	0
>   Res0	63:32
>   UnsignedEnum	31:28	RAS
> 

-- 
Shaoqin

