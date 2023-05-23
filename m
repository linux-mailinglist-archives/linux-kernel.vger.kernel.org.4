Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9288070DB87
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbjEWLen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjEWLel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA6913E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684841636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ehB1kA3QCKYDFVWvQAE46/PlE+fxP/22RPCQdy4evVc=;
        b=iqyg0mt1USxsHFBKDVrl+rJqFMzYMheYF8QBmEpvSwv2BbzBROHEHptFtfHbJNrbU7xKkl
        IDAJGxzFbWGWWUuVrAW6r+XxpHv00+SYcv9Qi0ViMZjdYcoMLHTD0BNq0dQ/CrfRlnzEvB
        xYeozQzl1u2Bsz40OEq1+twV1YJYPTk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-YuUxmh2FMmqMUmu5TJM8Pw-1; Tue, 23 May 2023 07:33:55 -0400
X-MC-Unique: YuUxmh2FMmqMUmu5TJM8Pw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-25387965738so701889a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684841634; x=1687433634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehB1kA3QCKYDFVWvQAE46/PlE+fxP/22RPCQdy4evVc=;
        b=OgrTyWvbgdzxISnNwq+nfZbEOa4vrmFRyJs7We+qM1Ir1nC/n8OuwnOxSZnwDKCYzK
         XlECV4rvHfuI7+iCQ26gVtt/TxYfVp8sA2CE2ShIwo6MdL4/cM6fKRF0ZhFr1URGFXnH
         98TLlDMH93Bd69mjmV/WB2zKYbsATXhoc2t3pAO+s85gpV3hOZGa/1ltDwHsN+t5XNkA
         kajkXS3Aq2mKqP5S/DaS8iB49uKUoTTRzqvK/6WWHO6wU6LQhCPIJVk0HZhllle1becy
         uLccDk3xoiKWnRafIag5QJN90WXX6/0QyGF84scblI0xtEbhLsPk4W2CBUvdysS0wGez
         tAmw==
X-Gm-Message-State: AC+VfDyur1KtKm4ouc7gjm/q2rin5ZWHCVPtJHK2vIUh7cp3swj1oNTr
        8Y5TC09cE7iW/vmjp634/kin3p0icUKhwHqjsTye1kt7DXFlCowRyl1GjH+eg5dGvmaQZmaxY3X
        DlzYyTd0EIR+RdcA17DzL1YLn
X-Received: by 2002:a17:90b:4b01:b0:252:a208:1fef with SMTP id lx1-20020a17090b4b0100b00252a2081fefmr15867112pjb.0.1684841634081;
        Tue, 23 May 2023 04:33:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70EiJXkadtssWOOH57ohFJYqxPsHrWwT93SBF1z24r/VkGglOw5cF28YNW99xTD/Cv5+86Jw==
X-Received: by 2002:a17:90b:4b01:b0:252:a208:1fef with SMTP id lx1-20020a17090b4b0100b00252a2081fefmr15867093pjb.0.1684841633785;
        Tue, 23 May 2023 04:33:53 -0700 (PDT)
Received: from [10.66.61.39] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bj19-20020a17090b089300b00246b7b8b43asm5578174pjb.49.2023.05.23.04.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 04:33:53 -0700 (PDT)
Message-ID: <93a7fa53-7a62-395a-ea92-392475ed2d48@redhat.com>
Date:   Tue, 23 May 2023 19:33:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/5] arm64/sysreg: Convert MDCCINT_EL1 to automatic
 register generation
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
 <20230419-arm64-syreg-gen-v1-2-936cd769cb9e@kernel.org>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20230419-arm64-syreg-gen-v1-2-936cd769cb9e@kernel.org>
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
> Convert MDCCINT_EL1 to automatic register generation as per DDI0616
> 2023-03. No functional change.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   arch/arm64/include/asm/sysreg.h | 1 -
>   arch/arm64/tools/sysreg         | 7 +++++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 6505665624d4..4e48bb4dca6a 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -134,7 +134,6 @@
>   #define SYS_SVCR_SMSTART_SM_EL0		sys_reg(0, 3, 4, 3, 3)
>   #define SYS_SVCR_SMSTOP_SMZA_EL0	sys_reg(0, 3, 4, 6, 3)
>   
> -#define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)
>   #define SYS_MDSCR_EL1			sys_reg(2, 0, 0, 2, 2)
>   #define SYS_DBGBVRn_EL1(n)		sys_reg(2, 0, 0, n, 4)
>   #define SYS_DBGBCRn_EL1(n)		sys_reg(2, 0, 0, n, 5)
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index dd5a9c7e310f..1699e87bc0b4 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -48,6 +48,13 @@
>   # feature that introduces them (eg, FEAT_LS64_ACCDATA introduces enumeration
>   # item ACCDATA) though it may be more taseful to do something else.
>   
> +Sysreg	MDCCINT_EL1	2	0	0	2	0
> +Res0	63:31
> +Field	30	RX
> +Field	29	TX
> +Res0	28:0
> +EndSysreg
> +
>   Sysreg ID_PFR0_EL1	3	0	0	1	0
>   Res0	63:32
>   UnsignedEnum	31:28	RAS
> 

-- 
Shaoqin

