Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2745F5FACB3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJKGXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJKGXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:23:07 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3411288DF8;
        Mon, 10 Oct 2022 23:22:32 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id j16so19972362wrh.5;
        Mon, 10 Oct 2022 23:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUmVSog6DafYW00ovmcYQ82S07flTbx/yM+Khtpjc6Q=;
        b=fogBWlSF+F66RMFv6uxgnCTx/XL8mKg6cQwVPd6ZFpBUuM9oQrydY+6+jZmmy7JLaF
         FKQVyZLaQ0B8pM+2mn17QX7IOBTVmGYJ/QA/d6SvnQkr/xxjn8VpxttT/x0HdAmDedQE
         Tz7mwtl2i4avpVsHNvZSMjtYKidgjpMMng2kpKXAb8jpMyPhGBRxf+t1jw3enDW8I5Jq
         Qurc7ZWFxssjh5adJ419g4+8pV9vFDxQqxv9+NCuaiBD9RQW1DD/D1x31K8gMTvi58ZU
         6Q/32GEQl9X+zV8zk1kqal6fdIwgEoeqIgP9WH4PrjJbR1vt+TuL85fWuWhjFc2aEQiN
         iuCA==
X-Gm-Message-State: ACrzQf0gh+zvVyvkNj9G7mKqMEP8z+cpQ9H/LfyNzfxpLftLqL9RI9D/
        9aICjNMb+fbXJMcbBa5C2gU=
X-Google-Smtp-Source: AMsMyM7YsvlisljG56rl4mKbWpZ8mWhhcw6Yxtv533MdMmZZxuLe54/n0F/l5XBSXRmdo4e+D8PzGw==
X-Received: by 2002:a5d:588c:0:b0:231:891c:6fc1 with SMTP id n12-20020a5d588c000000b00231891c6fc1mr522132wrf.25.1665469325767;
        Mon, 10 Oct 2022 23:22:05 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d4591000000b0022e32f4c06asm10301834wrq.11.2022.10.10.23.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 23:22:05 -0700 (PDT)
Message-ID: <2b6804ff-5386-06bd-7c01-4e1cd4ad23f3@kernel.org>
Date:   Tue, 11 Oct 2022 08:22:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v5 5/13] virt: gunyah: Add hypercalls to identify Gunyah
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-6-quic_eberman@quicinc.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221011000840.289033-6-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 10. 22, 2:08, Elliot Berman wrote:
> Add hypercalls to identify when Linux is running a virtual machine under
> Gunyah.
> 
> There are two calls to help identify Gunyah:
> 
> 1. gh_hypercall_get_uid() returns a UID when running under a Gunyah
>     hypervisor.
> 2. gh_hypercall_hyp_identify() returns build information and a set of
>     feature flags that are supported by Gunyah.
...
> --- /dev/null
> +++ b/arch/arm64/gunyah/hypercall.c
> @@ -0,0 +1,71 @@
...
> +/**
> + * gh_hypercall_get_uid() - Returns a UID when running under a Gunyah hypervisor.
> + * @uid: An array of 4 u32's (u32 uid[4];)
> + *
> + * The UID will be either QC_HYP_UID or GUNYAH_UID defined in include/asm-generic/gunyah.h.
> + * QC_HYP_UID is returned on platforms using Qualcomm's version of Gunyah.
> + * GUNYAH_UID is returned on platforms using open source version of Gunyah.
> + * If the uid is not one of the above two UIDs, then it is assumed that the hypervisor or firmware
> + * is not Gunyah.
> + */
> +void gh_hypercall_get_uid(u32 *uid)

So why this isn't u32 uid[4], or u32 uid[static 4] to aid the compiler 
(and limit users)?

> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_hvc(GH_HYPERCALL_CALL_UID, &res);
> +
> +	uid[0] = res.a0;
> +	uid[1] = res.a1;
> +	uid[2] = res.a2;
> +	uid[3] = res.a3;
> +}
> +EXPORT_SYMBOL_GPL(gh_hypercall_get_uid);

...

> --- a/include/asm-generic/gunyah.h
> +++ b/include/asm-generic/gunyah.h
> @@ -71,4 +71,40 @@ static inline int gh_remap_error(int gh_error)
...
> +#define GH_API_INFO_API_VERSION(x)	(((x) >> 0) & 0x3fff)
> +#define GH_API_INFO_BIG_ENDIAN(x)	(((x) >> 14) & 1)
> +#define GH_API_INFO_IS_64BIT(x)		(((x) >> 15) & 1)
> +#define GH_API_INFO_VARIANT(x)		(((x) >> 56) & 0xff)

Use GET_FIELD()?

regards,
-- 
-- 
js
suse labs

