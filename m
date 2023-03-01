Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CCF6A737F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCASeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCASeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:34:19 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6819EEF;
        Wed,  1 Mar 2023 10:34:18 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id g3so2259464eda.1;
        Wed, 01 Mar 2023 10:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677695657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfnaqfos6P+GQrTAkeilyREZz9zpOhjnnfyuK1BArdw=;
        b=CKhgsS3ilqZdiuccQ2BdGu/JArutnjm8hXxIcxHrFVYfqe//YSLr8s4ZwsTv4CnMhN
         +6HFudnaPMNxp8EPj9lEedHhlTRicZ5duHvHE5O694L+ynNh2hgu45dfUiYeLsrUKI9r
         RMia+yEpSUNVSlieAxljxa3urQy2lklPG2ETWBG9t1m7xFK2T0zVve0iH8j5Rp2QXMjd
         +t6yIAKOuVEzFMldE4KBVhnv3UgkjDjv69xB5+GQOb+SBOBzJRTV8QXpPj37Yj1bvCVu
         8Di0526GgLOBatVp6mPztSZldZymX6t3EXV3sfserL33oUHoHEL4CTpPAiaSXan9Pup7
         +WTg==
X-Gm-Message-State: AO0yUKWM3RmvGGNklyybNCbMq/ZRAICzbqiRascvVodEXMrqoCWGLLzn
        pp3RIWjEgoHcsM4CQ3UV0mZgjzxKqlBaN8AhnAk=
X-Google-Smtp-Source: AK7set9KrbCLyVwTTarnOiFnevmYrn0rDMHnu4hmXUstv0WQl5bkfrds9q30Vj+R7GaPIZGYkVXVx/ZUTwAKQrykg3g=
X-Received: by 2002:a50:c007:0:b0:4ab:4933:225b with SMTP id
 r7-20020a50c007000000b004ab4933225bmr4313824edb.6.1677695657192; Wed, 01 Mar
 2023 10:34:17 -0800 (PST)
MIME-Version: 1.0
References: <20230226053953.4681-1-rdunlap@infradead.org> <20230226053953.4681-8-rdunlap@infradead.org>
In-Reply-To: <20230226053953.4681-8-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Mar 2023 19:34:06 +0100
Message-ID: <CAJZ5v0j2rao56aVegCPj=ZM+SJSGyXbbnwyuXz=WPZ9y+7BBMA@mail.gmail.com>
Subject: Re: [PATCH 7/8] thermal: intel: BXT_PMIC: select REGMAP instead of
 depending on it
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Yegnesh S Iyer <yegnesh.s.iyer@intel.com>,
        Bin Gao <bin.gao@intel.com>, Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 6:40 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> REGMAP is a hidden (not user visible) symbol. Users cannot set it
> directly thru "make *config", so drivers should select it instead of
> depending on it if they need it.
>
> Consistently using "select" or "depends on" can also help reduce
> Kconfig circular dependency issues.
>
> Therefore, change the use of "depends on REGMAP" to "select REGMAP".
>
> Fixes: b474303ffd57 ("thermal: add Intel BXT WhiskeyCove PMIC thermal driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yegnesh S Iyer <yegnesh.s.iyer@intel.com>
> Cc: Bin Gao <bin.gao@intel.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/thermal/intel/Kconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff -- a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -73,7 +73,8 @@ endmenu
>
>  config INTEL_BXT_PMIC_THERMAL
>         tristate "Intel Broxton PMIC thermal driver"
> -       depends on X86 && INTEL_SOC_PMIC_BXTWC && REGMAP
> +       depends on X86 && INTEL_SOC_PMIC_BXTWC
> +       select REGMAP
>         help
>           Select this driver for Intel Broxton PMIC with ADC channels monitoring
>           system temperature measurements and alerts.

Applied as 6.3-rc material, thanks!
