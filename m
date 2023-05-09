Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558696FCD8A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjEISP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEISPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:15:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1537D1704
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 11:15:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9659c5b14d8so1010734966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 11:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683656119; x=1686248119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EBLRqUTI3YRxNZNQbD5na+DuAKKebUdiFgLeM9h3u4E=;
        b=Enhra61vQM0Pxs/bbJDdTV9AcJK04sYaNR5RuUhzrIOOFA+KFH6ly5oOFDU2xIcRpM
         aQW1+P/0trn4oyU5Sq0hd9lIKq10rmRcwyshT41ALIBLuqfyXs9HpPK0gMZTB4G9gbhQ
         WoFRmKTpN7ZfVmx8/+jMrtPc4BOc1RGDDJvsXlIDyKFAdo592iHO7R9X2RLccKLfd+z/
         60Dq0WZlaPGVOaYVB/FO5h3ts7WGudcO82QIFqivCh/9+Y/O7FbsMhmgFo82AxXu8lZ3
         PntPtPKG0LmcpZ7l6yL5i13X32vC942xHZ0+GnajqvqtEB8FPgeF4hm7VB2ZiTbVgoUi
         AQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683656119; x=1686248119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBLRqUTI3YRxNZNQbD5na+DuAKKebUdiFgLeM9h3u4E=;
        b=Btk7yOFr7In423X/Ul6ywBaO3c73X1SDhb3q74Wc89Huc29ZFZ+0pXCKCHO3SB7yKn
         6O4ZhllnLZxOvAoq/VS/ec4RB6iKu4tHGYZ0QrjUHuBcm3Bxwv6W/653SLXrlsASO4Yj
         uf6s4xQOvgWPqe0KjyNXwERbXwriFbi0Q1C4aKIvZiHoq+ntLOuELzIfxYe8f7+gqFvv
         cRqnyVLeck1LzmExHvgFrmD0+iv4vDi6QyOHJh/8+3qCQzNL37fPSN6zUERq9lQTQ3pD
         AyAyMCscX6Wyj/xPjaMTHf0AjqHgeIoNmZVAFbJAUmcyoTWZwkeq74c0EictTxNLFom0
         90yg==
X-Gm-Message-State: AC+VfDxzT+DKVvMCaijE+GN/l+6oNqNv1X/S1qwG8Mplo4mrifElwZHp
        hIXepO9j0sj3rgYDB1XjI70zDA==
X-Google-Smtp-Source: ACHHUZ4qSdLlwvCLz0M39OPhK+vxNmklm//uyCu0D7s1NjNqPo8OF+VZezVtjt0W8pfa0TYfDAo43A==
X-Received: by 2002:a17:907:940e:b0:94d:69e0:6098 with SMTP id dk14-20020a170907940e00b0094d69e06098mr13890130ejc.45.1683656119542;
        Tue, 09 May 2023 11:15:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id hy27-20020a1709068a7b00b0094f1fe1696bsm1581079ejc.216.2023.05.09.11.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 11:15:18 -0700 (PDT)
Message-ID: <685218fb-d852-b6f6-928d-c9cfae2af762@linaro.org>
Date:   Tue, 9 May 2023 20:15:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 13/13] ARM: dts: exynos: Add Samsung Galaxy Tab 3 8.0
 boards
Content-Language: en-US
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230501195525.6268-1-aweber.kernel@gmail.com>
 <20230501195525.6268-14-aweber.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230501195525.6268-14-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2023 21:55, Artur Weber wrote:
> Introduce support for the Galaxy Tab 3 8.0 series of boards:
> 
>  - Samsung Galaxy Tab 3 8.0 WiFi (SM-T310/lt01wifi)
>  - Samsung Galaxy Tab 3 8.0 3G (SM-T311/lt013g)
>  - Samsung Galaxy Tab 3 8.0 LTE (SM-T315/lt01lte)
> 
> What works:
> 
>  - Display and backlight
>  - Touchscreen (without touchkeys)
>  - GPIO buttons, hall sensor
>  - WiFi and Bluetooth
>  - USB, fuel gauge, charging
>  - Accelerometer and magnetometer
>  - WiFi model only: light sensor
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Thank you for your patch. There is something to discuss/improve.

> ---
> Changed in v3:
>  - Addressed review comments
>  - Removed rtc node (RTC is provided by PMIC)
>  - Added CPU thermal node
>  - Fixed dtb_check warnings
>  - Added common changes from next/dt
> 
> Display panel bindings are added by a separate patchset:
> "[PATCH 0/3] Add Samsung S6D7AA0 panel controller driver"[1]
> 
> LP855X node is adapted to changes from a separate patchset:
> "[PATCH 0/4] video: backlight: lp855x: modernize bindings"[2]
> 
> [1] https://lore.kernel.org/all/20230501185103.25939-1-aweber.kernel@gmail.com/
> [2] https://lore.kernel.org/all/20230429104534.28943-1-aweber.kernel@gmail.com/

New failures:

arch/arm/boot/dts/exynos4212-tab3-3g8.dtb: rtc@10070000: clocks: [[5,
346]] is too short

> ---
>  arch/arm/boot/dts/Makefile                  |    3 +
>  arch/arm/boot/dts/exynos4212-tab3-3g8.dts   |   29 +
>  arch/arm/boot/dts/exynos4212-tab3-lte8.dts  |   44 +
>  arch/arm/boot/dts/exynos4212-tab3-wifi8.dts |   26 +
>  arch/arm/boot/dts/exynos4212-tab3.dtsi      | 1171 +++++++++++++++++++
>  5 files changed, 1273 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos4212-tab3-3g8.dts
>  create mode 100644 arch/arm/boot/dts/exynos4212-tab3-lte8.dts
>  create mode 100644 arch/arm/boot/dts/exynos4212-tab3-wifi8.dts
>  create mode 100644 arch/arm/boot/dts/exynos4212-tab3.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index efe4152e5846..e5f63b636637 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -217,6 +217,9 @@ dtb-$(CONFIG_ARCH_EXYNOS4) += \
>  	exynos4210-smdkv310.dtb \
>  	exynos4210-trats.dtb \
>  	exynos4210-universal_c210.dtb \
> +	exynos4212-tab3-3g8.dtb \
> +	exynos4212-tab3-lte8.dtb \
> +	exynos4212-tab3-wifi8.dtb \
>  	exynos4412-i9300.dtb \
>  	exynos4412-i9305.dtb \
>  	exynos4412-itop-elite.dtb \
> diff --git a/arch/arm/boot/dts/exynos4212-tab3-3g8.dts b/arch/arm/boot/dts/exynos4212-tab3-3g8.dts
> new file mode 100644
> index 000000000000..6d890353ae76
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos4212-tab3-3g8.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's Exynos4212 based Galaxy Tab 3 8.0 3G board device tree
> + * source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + */
> +
> +/dts-v1/;
> +#include "exynos4212-tab3.dtsi"
> +
> +/ {
> +	model = "Samsung Galaxy Tab 3 8.0 3G (SM-T311) based on Exynos4212";
> +	compatible = "samsung,t311", "samsung,tab3", "samsung,exynos4212", "samsung,exynos4";
> +	chassis-type = "tablet";
> +};
> +
> +/* Pin control sleep state overrides */
> +&sleep0 {
> +		PIN_SLP(gpb-5, INPUT, UP);

Too much indentent.

> +};
> +
> +&sleep1 {
> +		PIN_SLP(gpl0-0, OUT0, NONE);

Same here.

> +		PIN_SLP(gpl1-0, OUT0, NONE);
> +		PIN_SLP(gpl2-4, OUT0, NONE);
> +		PIN_SLP(gpm3-3, OUT1, NONE);
> +};
> diff --git a/arch/arm/boot/dts/exynos4212-tab3-lte8.dts b/arch/arm/boot/dts/exynos4212-tab3-lte8.dts
> new file mode 100644
> index 000000000000..c5ec68c292b0
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos4212-tab3-lte8.dts
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's Exynos4212 based Galaxy Tab 3 8.0 LTE board device tree
> + * source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + */
> +
> +/dts-v1/;
> +#include "exynos4212-tab3.dtsi"
> +
> +/ {
> +	model = "Samsung Galaxy Tab 3 8.0 LTE (SM-T315) based on Exynos4212";
> +	compatible = "samsung,t315", "samsung,tab3", "samsung,exynos4212", "samsung,exynos4";
> +	chassis-type = "tablet";
> +};
> +
> +/* Pin control sleep state overrides */
> +&sleep0 {
> +		PIN_SLP(gpa0-4, INPUT, UP);
> +		PIN_SLP(gpa0-5, INPUT, UP);

Same.

> +
> +		PIN_SLP(gpb-5, INPUT, UP);
> +
> +		PIN_SLP(gpc0-0, PREV, NONE);
> +		PIN_SLP(gpc1-3, INPUT, NONE);
> +
> +		PIN_SLP(gpf1-6, INPUT, NONE);
> +		PIN_SLP(gpf2-2, PREV, NONE);
> +};
> +
> +&sleep1 {
> +		PIN_SLP(gpl0-0, PREV, NONE);
> +
> +		PIN_SLP(gpl1-0, PREV, NONE);
> +
> +		PIN_SLP(gpl2-1, INPUT, DOWN);
> +		PIN_SLP(gpl2-2, INPUT, DOWN);
> +		PIN_SLP(gpl2-4, OUT0, NONE);
> +		PIN_SLP(gpl2-5, PREV, NONE);
> +
> +		PIN_SLP(gpm3-3, OUT1, NONE);

...

> +			buck5_reg: BUCK5 {
> +				regulator-name = "VMEM_1.2V_AP";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt	= <1200000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				op_mode = <1>;
> +			};
> +
> +			buck6_reg: BUCK6 {
> +				regulator-name = "CAM_ISP_CORE_1.2V";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				op_mode = <1>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +
> +		s5m8767_osc: clocks {
> +			compatible = "samsung,s5m8767-clk";
> +			#clock-cells = <1>;
> +			clock-output-names = "en32khz_ap",
> +						 "en32khz_cp",
> +						 "en32khz_bt";

Are these aligned with opening "?

> +		};
> +	};
> +};


Best regards,
Krzysztof

