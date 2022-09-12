Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78FA5B5CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiILPAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiILPAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:00:03 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC5C11453;
        Mon, 12 Sep 2022 08:00:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id wc11so6327628ejb.4;
        Mon, 12 Sep 2022 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=TypX0hy1I9U+h9aWraZ8HzxvWEcZdRvmgmYJJqDzGMI=;
        b=EQZ6/J8xBXDPwrOaVHdum403z3TrVfAI/hA++oRpXOtEIZp4BX/b9YlyZwUpYQdY44
         HZ9TBICwN8kaAibWnuO1PYN6IctJel6O5fuUkkdtbi6cR14ZKoUwLL6om87Dqn6j8wAq
         DOS5jwAyL6sbiKSdAF47I0NF9PNtg3z4HibuIJYRdhy0LbB8bwcgOdMpWMScIl/DDMGR
         N+I7LFBgv7LJq8TfScbqDY8LZqFRsHHTDX2vyMwls1GRwHbHjzCtHmmUk7EnSXXs00Vn
         Y3r6Oa/K9uI5P7MbGb7oMBX371MO0rjq7PNxnEb8w4zJb/p/mz351Y/SAfpMwu9iJgWZ
         06/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TypX0hy1I9U+h9aWraZ8HzxvWEcZdRvmgmYJJqDzGMI=;
        b=mCoUf3+BuqnDZpUamWA8DEwfJCwnfg393vA0Hq+OU+V4mEgKL0UzNRoDXBTecFoazR
         H0ui9zQtQjUJ9xgPLEhrrns0NnNIyEvKi4t5CP2Q+dBi2cXvVM6jlRVn8daNwnSvlw24
         C7ePJ6q10XHqaP93UCz6YJIOlbEQvEithqSWs4MbAzfZwFt0+KxXJrAyh2DJcy8RdzNl
         2W8IuTuYWBF5Ao7boC2CVk939MnA2F0av7EJVUO//ZUO58ipy/tKw5ftVM3HxZ4cJmRJ
         dAyepeAzJ47u5oGCdYzb9pvbP0erPMlHdf+gSUOOqpbvZ2qdieclNmNz6CCk8sSIsOJK
         qBDg==
X-Gm-Message-State: ACgBeo3dltmov1x83RHNDmpBNTTJsaYXm9/FDH8IIY8Xckjx6RaIqnt3
        F2qYSKGMu0Tp1FBdwmHuVuHXQwZn3+I=
X-Google-Smtp-Source: AA6agR5LutJeVUXgYmkxAHhwfinzRp8eob8Crv5vSPvXMsQMdEVlQ/bygRpRoCEzJjbmdbMjyqOv+Q==
X-Received: by 2002:a17:907:6d99:b0:770:7e4c:ba15 with SMTP id sb25-20020a1709076d9900b007707e4cba15mr18732502ejc.259.1662994800740;
        Mon, 12 Sep 2022 08:00:00 -0700 (PDT)
Received: from rog (dynamic-046-114-143-092.46.114.pool.telefonica.de. [46.114.143.92])
        by smtp.gmail.com with ESMTPSA id p5-20020a50cd85000000b0043ba7df7a42sm5919964edi.26.2022.09.12.07.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 08:00:00 -0700 (PDT)
Date:   Mon, 12 Sep 2022 16:59:56 +0200
From:   Philipp Zabel <philipp.zabel@gmail.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        catalin@antebit.com, Shyam-sundar.S-k@amd.com,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 4/4] acpi/x86: s2idle: Add a quirk for ASUS TUF Gaming
 A17 FA707RE
Message-ID: <Yx9JbJqHB77GOW3d@rog>
References: <20220909180509.638-1-mario.limonciello@amd.com>
 <20220909180509.638-5-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909180509.638-5-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, Sep 09, 2022 at 01:05:09PM -0500 schrieb Mario Limonciello:
> ASUS TUF Gaming A17 FA707RE has problems with ACPI events after
> s2idle resume.  It's from a missing call to an ASL method in AMD
> the s2idle calling path. Force the system to use the Microsoft
> Modern Standby calling path instead.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216101
> Reported-and-tested-by: catalin@antebit.com
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/x86/s2idle.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index a9b0f2b54a1c..6a2c94fdbeae 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -17,6 +17,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/device.h>
> +#include <linux/dmi.h>
>  #include <linux/suspend.h>
>  
>  #include "../sleep.h"
> @@ -400,6 +401,28 @@ static const struct acpi_device_id amd_hid_ids[] = {
>  	{}
>  };
>  
> +static int lps0_prefer_microsoft(const struct dmi_system_id *id)
> +{
> +	pr_debug("Preferring Microsoft GUID.\n");
> +	prefer_microsoft_guid = true;
> +	return 0;
> +}
> +
> +static const struct dmi_system_id s2idle_dmi_table[] __initconst = {

This caused a build warning ...

[...]
> @@ -568,6 +591,7 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
>  
>  void acpi_s2idle_setup(void)
>  {
> +	dmi_check_system(s2idle_dmi_table);

... since it is used from a non-__init function:

  WARNING: modpost: vmlinux.o: section mismatch in reference: acpi_s2idle_setup (section: .text) -> s2idle_dmi_table (section: .init.rodata)

regards
Philipp
