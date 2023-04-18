Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740DF6E6BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjDRSMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjDRSMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808789EF5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681841491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a2NJ2p6cE8nPnq4qyhSh+ydMCNdO89r7It+YsHhkzyo=;
        b=hRRJ6JFVFO6tjMUJaOFSZwK5SxBVcL+2BpWHyDDL+9r19dmLC0RhMXtadIIbeufM3XR0Y9
        ACTIsJTCE9hGktt2kWtx3tOa5knoHH/8j3a0Hcik6P6Iuad49fm1iuI/nlQgNCD94sS76v
        8Jm7uXoRCT5mZ8GsJecyy0gmP5UERJ4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-9t8L-2fzMu-8qNRq44gxbg-1; Tue, 18 Apr 2023 14:11:24 -0400
X-MC-Unique: 9t8L-2fzMu-8qNRq44gxbg-1
Received: by mail-qt1-f198.google.com with SMTP id s42-20020a05622a1aaa00b003e99419b127so11496508qtc.17
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681841484; x=1684433484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2NJ2p6cE8nPnq4qyhSh+ydMCNdO89r7It+YsHhkzyo=;
        b=LWon9Tr5wmrHuIqH484KHiNEEWomIcwkTmKBU6SNzxkbUgXaKqA78ug9RIGriQBEtr
         JgvjcHBvxDVdvVKJEyAnEv6Oy0cadp1weAuhtY3RnwXLBGVl23x2haPByK8UEMGZWXtU
         ZU0oKVt53GzcEjIEBp7fKlwnvsWP1Oi7rjVNwfy5JUqMRYOlmRI0wdgIp20NtqMPxBw2
         C1sIit3OD8O9hg2cB9C/SmHKSBmnSfvLTHRdJ3X4RpufLEw1L2YwHvGwGaeZKklyhrB0
         3yRxA5TJJCY07MoLFTI7UnQWJH6Jqis3xfkQqRjRQLA+1XJLOzdU5HnKSnV711shB+Is
         CF0A==
X-Gm-Message-State: AAQBX9fwR8vUKMmRNeitcZgYYiIYZ9GaHeTWqfNyLuEd71KaG3+AGz4L
        /bV5ZM5VgB9kNKtLuVXTwDT7j0Rt4Q/4nqUZNbomuu5tpMgj67VIB7OnixqNdnWmJtH/nMNGaEf
        bswB7GTtNWitX6LaQWP9pf1L/
X-Received: by 2002:a05:6214:508b:b0:5e0:7ecb:8ffb with SMTP id kk11-20020a056214508b00b005e07ecb8ffbmr23344899qvb.8.1681841484170;
        Tue, 18 Apr 2023 11:11:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350a3GbO3FdgQzclKEsUIQPHtPQW7EW4y+mIxxoj0/PCOcdeWVYhW6FGqFVxxMO5MsPFGAYyE5w==
X-Received: by 2002:a05:6214:508b:b0:5e0:7ecb:8ffb with SMTP id kk11-20020a056214508b00b005e07ecb8ffbmr23344854qvb.8.1681841483879;
        Tue, 18 Apr 2023 11:11:23 -0700 (PDT)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id kr24-20020a0562142b9800b005eee320b5d7sm3812683qvb.63.2023.04.18.11.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 11:11:23 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:11:26 -0400
From:   Eric Chanudet <echanude@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sa8775p: pmic: add the sdam_0
 node
Message-ID: <20230418181126.yu7ym5acb3x5twex@echanude>
References: <20230417145536.414490-1-brgl@bgdev.pl>
 <20230417145536.414490-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417145536.414490-4-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 04:55:36PM +0200, Bartosz Golaszewski wrote:
> From: Parikshit Pareek <quic_ppareek@quicinc.com>
> 
> Introduce sdam_0 node, which is to be used via nvmem for power on
> reasons during reboot. Add supported PoN reaons supported via sdam_0
> node.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Tested-by: Eric Chanudet <echanude@redhat.com>

> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> index 5abdc239d3a6..3c3b6287cd27 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> @@ -88,6 +88,14 @@ trip1 {
>  			};
>  		};
>  	};
> +
> +	reboot-mode {
> +		compatible = "nvmem-reboot-mode";
> +		nvmem-cells = <&reboot_reason>;
> +		nvmem-cell-names = "reboot-mode";
> +		mode-recovery = <0x01>;
> +		mode-bootloader = <0x02>;
> +	};
>  };
>  
>  &spmi_bus {
> @@ -133,6 +141,19 @@ pmm8654au_0_gpios: gpio@8800 {
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
>  		};
> +
> +		pmm8654au_0_sdam_0: nvram@7100 {
> +			compatible = "qcom,spmi-sdam";
> +			reg = <0x7100>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x7100 0x100>;
> +
> +			reboot_reason: reboot-reason@48 {
> +				reg = <0x48 0x1>;
> +				bits = <1 7>;
> +			};
> +		};
>  	};
>  
>  	pmm8654au_1: pmic@2 {
> -- 
> 2.37.2
> 

-- 
Eric Chanudet

