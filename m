Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D670DB7D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbjEWLcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjEWLcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:32:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89990FA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684841520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqvkKPpeyvJC3LKAlZdrdd0G6ZskzvSyTK5XVg14pug=;
        b=aTsMOHIx8B51/uMELwLQtjuOSnRqre/9pxZnvFN2gHo6tPNfMeIUp25uYF6AIpgv5mbu/v
        LyrzF4QP3NGtR//vS/vHUgunXOrJK8GjSowOGdzYH0hMXWd6Go/t1O6Vy6BscWQdIjugxK
        M2/VNqsye0VG0YZzStCZaXNZxfVXQGQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-nnnVNEZLOhe19j9LHpcmGg-1; Tue, 23 May 2023 07:31:59 -0400
X-MC-Unique: nnnVNEZLOhe19j9LHpcmGg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-64d2e1db9e6so354455b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684841517; x=1687433517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqvkKPpeyvJC3LKAlZdrdd0G6ZskzvSyTK5XVg14pug=;
        b=bMpDgLAFHj1OGk6irsG6ZaEl25pBmtQ4MawSBOUkKSzE2DdSkhd36hpBy51T862Pj6
         z33ZkM7DWRG6oxNM40lHwdyjLa9kYfa6g1LC8lE01+oS8mKYQidPIDJuJLe1W09oFcTU
         iB6Y2Ar32lx4qzSlAngek2d0mYehXVI+SNIJ/wIjcbIad2HobOidHDAMTuindgz/0CGG
         4aArAGaMKKGHXlTzrRu9AEWeecxP715Ql8S8YHO8v3iw2hNZe7TJH97IOmU2w8nS3Ioh
         UeiT0/kO0jVYl2AlB7ESS1js6ts0JhhsWb+YL6MpZIWRUs7zUfJQ0GNrXUVGaDigo20I
         MJVA==
X-Gm-Message-State: AC+VfDxHKBSnerOmqqc3vCIq4/zAGgo04yu2yweFEjsJz7uD8X4aQnmD
        3XzJQnH4NrJbeLmVF/Evd+bmNfw94cig9AsT+ufsWKaF8cqACpESCVCaEVgccnq+9QdaIio2wWa
        JridtNkjFuLYl6PCjE2Q9f0jY
X-Received: by 2002:a05:6a00:1c91:b0:63d:2d6a:47be with SMTP id y17-20020a056a001c9100b0063d2d6a47bemr13311106pfw.2.1684841517222;
        Tue, 23 May 2023 04:31:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7FgAilTzoSI89QW4N0Hm/4MD2G7X0a1vaxsB7MtNKFBw0Ak3fCBuMJI+YnvZGSlxGyzUBaug==
X-Received: by 2002:a05:6a00:1c91:b0:63d:2d6a:47be with SMTP id y17-20020a056a001c9100b0063d2d6a47bemr13311094pfw.2.1684841516938;
        Tue, 23 May 2023 04:31:56 -0700 (PDT)
Received: from [10.66.61.39] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g17-20020aa78751000000b0063b89300347sm5768361pfo.142.2023.05.23.04.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 04:31:56 -0700 (PDT)
Message-ID: <e2660ce1-7ac1-8413-8ef7-284592cce708@redhat.com>
Date:   Tue, 23 May 2023 19:31:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/5] arm64/sysreg: Remove some unused sysreg definitions
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
 <20230419-arm64-syreg-gen-v1-1-936cd769cb9e@kernel.org>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20230419-arm64-syreg-gen-v1-1-936cd769cb9e@kernel.org>
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
> Since there are no references to OSDTRRX_EL1 or OSECCR_EL1 in the code
> just remove the definitions rather than converting to automatic
> generation.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   arch/arm64/include/asm/sysreg.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 9e3ecba3c4e6..6505665624d4 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -134,11 +134,8 @@
>   #define SYS_SVCR_SMSTART_SM_EL0		sys_reg(0, 3, 4, 3, 3)
>   #define SYS_SVCR_SMSTOP_SMZA_EL0	sys_reg(0, 3, 4, 6, 3)
>   
> -#define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
>   #define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)
>   #define SYS_MDSCR_EL1			sys_reg(2, 0, 0, 2, 2)
> -#define SYS_OSDTRTX_EL1			sys_reg(2, 0, 0, 3, 2)
> -#define SYS_OSECCR_EL1			sys_reg(2, 0, 0, 6, 2)
>   #define SYS_DBGBVRn_EL1(n)		sys_reg(2, 0, 0, n, 4)
>   #define SYS_DBGBCRn_EL1(n)		sys_reg(2, 0, 0, n, 5)
>   #define SYS_DBGWVRn_EL1(n)		sys_reg(2, 0, 0, n, 6)
> 

-- 
Shaoqin

