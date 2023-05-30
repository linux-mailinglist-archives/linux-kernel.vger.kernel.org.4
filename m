Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C7E715C54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjE3K4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjE3K40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:56:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068ACA0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685444140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GWivZAPPoTwMn2PqCvk8Vr3Zya+QIDyyBfpmbjsuvGs=;
        b=a3EA1kQvsYovl2xW556yxKSCxKCZgHfAKiUs+OWH6qyt25YnOTb5a98w6PVSkE1Prv+ZTP
        TTG+DNEC+n+l7V50tjmWU8JyfvyTfbnAby60u+cBpYg6oJXeL3l/mN4U9idUfDLqfpEjQ/
        RybVnOEduAlrepVHcfBICnooxf8iezQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-9RfBt6XaMy-cPwsSJ2wbIw-1; Tue, 30 May 2023 06:55:39 -0400
X-MC-Unique: 9RfBt6XaMy-cPwsSJ2wbIw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2563c84927eso456329a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685444138; x=1688036138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWivZAPPoTwMn2PqCvk8Vr3Zya+QIDyyBfpmbjsuvGs=;
        b=RPzJlNFbR0lCk/cL5pmFGdZ/Dd/qbXLA7YFNex1FA+7mNYc6A0wVDVuWN4PiAf2Sxs
         2kof17lUnkfzTFpRH/HiXv1MTqnCbFMH3lVD37tY2e30suqWNH0fWg6jBFHX94/RAKWr
         zMx060WrCLQWQ9eDIHYNs3qB3yadC9Knmp4vM3oHTY4If/z5iuVrIznI8+Te69R/z4If
         ShfirUoI5bDChppKrDqPkuIfRWVwZSv2/1e/gsnsNvbK6C8SN8xTv3b2mAPsztSWgATo
         ZzyVHZtEz2Eg9WUjS4R5n7GFvOMg3qUwyevXiOvenKkvDBuhp+8du6uwNy3OxyRjWzdu
         1WPg==
X-Gm-Message-State: AC+VfDzzqmzMRsksqrxZM6AWPbWQQ51rSb7tnygr/usHexJAXXUTP8FC
        VHOm6leTBnu82eO9ynPRSmMpcASL2wHeccNwwC7LlJOEvFgn2Mh9EZmWlJGVo3Mj/tt8JZh6CmL
        n8AVxR1uJ3TgaIhnoCO1YekqL
X-Received: by 2002:a17:90b:1bd1:b0:256:9095:a368 with SMTP id oa17-20020a17090b1bd100b002569095a368mr2205048pjb.4.1685444138209;
        Tue, 30 May 2023 03:55:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4++9HNsnxqvzJd3BOTRkdURdiR/fa3CDpaKOeW3XErEioJiBnAV6i5XDK0Qq4H+CQo+1hMaw==
X-Received: by 2002:a17:90b:1bd1:b0:256:9095:a368 with SMTP id oa17-20020a17090b1bd100b002569095a368mr2205034pjb.4.1685444137977;
        Tue, 30 May 2023 03:55:37 -0700 (PDT)
Received: from [10.66.61.39] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id mq4-20020a17090b380400b00256c9165e96sm871238pjb.50.2023.05.30.03.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 03:55:37 -0700 (PDT)
Message-ID: <f910e97e-b3cf-335b-95e7-4037ff0e2b97@redhat.com>
Date:   Tue, 30 May 2023 18:55:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 6/7] arm64/sysreg: Convert OSDTRTX_EL1 to automatic
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
 <20230419-arm64-syreg-gen-v2-6-4c6add1f6257@kernel.org>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20230419-arm64-syreg-gen-v2-6-4c6add1f6257@kernel.org>
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
> Convert OSDTRTX_EL1 to automatic generation as per DDI0601 2023-03. No
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
> index da954a6eba24..d9711f1e47b2 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -134,7 +134,6 @@
>   #define SYS_SVCR_SMSTART_SM_EL0		sys_reg(0, 3, 4, 3, 3)
>   #define SYS_SVCR_SMSTOP_SMZA_EL0	sys_reg(0, 3, 4, 6, 3)
>   
> -#define SYS_OSDTRTX_EL1			sys_reg(2, 0, 0, 3, 2)
>   #define SYS_OSECCR_EL1			sys_reg(2, 0, 0, 6, 2)
>   #define SYS_DBGBVRn_EL1(n)		sys_reg(2, 0, 0, n, 4)
>   #define SYS_DBGBCRn_EL1(n)		sys_reg(2, 0, 0, n, 5)
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index e4653248dcac..e18ae1df41f4 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -88,6 +88,11 @@ Res0	5:1
>   Field	0	SS
>   EndSysreg
>   
> +Sysreg	OSDTRTX_EL1	2	0	0	3	2
> +Res0	63:32
> +Field	31:0	DTRTX
> +EndSysreg
> +
>   Sysreg	OSLAR_EL1	2	0	1	0	4
>   Res0	63:1
>   Field	0	OSLK
> 

-- 
Shaoqin

