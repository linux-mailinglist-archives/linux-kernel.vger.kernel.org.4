Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2225B78D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiIMRvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiIMRud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:50:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B32183F19;
        Tue, 13 Sep 2022 09:49:08 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l10so12408479plb.10;
        Tue, 13 Sep 2022 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=GVXCUV/wOiE0NHoGAs/99JLUBeN3Hj+ppGXrhVQZl+I=;
        b=gAVkJ3PYgu4p8T1V2J1lWmKZxg1ls3m6IbbXhLorzCQZv//M6Ey/tigi2iV1pgT4ot
         rAJiA25gpbOCKOr8qj4r7Y19hDORDOAk6BNI7giYlDhhM6bZUu1fjRgeIVT01qOD+QLA
         SzW0x9sRMlmohBsaim5FCDArnLtSf8pB/z9n7VIqedFeYxING15i/HV56o3eM+M8V7vC
         bNXnJH3aiSCDKOwNivGOhi9JIYlRmhCyTbDlfP3zwcZb95TdL/HrzNcCkz2vTYJ4cIxT
         d4iUyx85Yvp18qUmVstBMWoqKEMGlxkx0FGCxo0gWNdLW4ZdLnhlhIW0fr0Lvkz9n/v5
         gBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=GVXCUV/wOiE0NHoGAs/99JLUBeN3Hj+ppGXrhVQZl+I=;
        b=eKjs6zeBN5/lfviPDR6WwywqVcveMo8VlJsmpVP5S9CIYEUjMioxig/rMV7jYpq85e
         fCV5cpMXsFLg1NEbT5qyScTyvFDTfZMhwMaq8rC7DRJPWexe5WI3MQiuNxmdW7Jdc9CQ
         BW92VmZquKLBAvbIOjiRewI7eNNKHfoQD5OB5VNp8xWa0B/nArJFJZm49AZGNSujOmhr
         7NhFcVEW9Whc1xLiByJkwJoW6GhrYC0JdRuorZPwTrppWoR/URsWC+XGP/tN13FaFMOu
         A3n23Yi8aMtw5P6/EyL9qIRXmVu3ucjg3l9jcAU3IbiSA625MzTvy5ZMsGfuVJK9BwQA
         2qiA==
X-Gm-Message-State: ACgBeo1/Oi8sSbMwu4f5zYsSclu8wCa29f90IKZYgacdJoH4meRS3Q4Q
        vlH8EdifnJVE/0Mt0opr+DI=
X-Google-Smtp-Source: AA6agR4oEFpqoZCjDCo9GNqbqYhIqpX7aUoN53E2h0Ur+D0ovTh2WtvmWB1If2bnWApv7pR5S6jhyw==
X-Received: by 2002:a17:902:7295:b0:176:a0d8:77e3 with SMTP id d21-20020a170902729500b00176a0d877e3mr32386431pll.0.1663087747839;
        Tue, 13 Sep 2022 09:49:07 -0700 (PDT)
Received: from rog ([2a0a:edc0:0:701:a220:c777:e1f2:5de1])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b00176dc67df44sm7255343plg.132.2022.09.13.09.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 09:49:07 -0700 (PDT)
Date:   Tue, 13 Sep 2022 18:48:57 +0200
From:   Philipp Zabel <philipp.zabel@gmail.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        catalin@antebit.com, travisghansen@yahoo.com,
        Shyam-sundar.S-k@amd.com, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 4/6] acpi/x86: s2idle: Add a quirk for ASUS TUF Gaming
 A17 FA707RE
Message-ID: <YyC0eeVzI/MQsOPx@rog>
References: <20220912172401.22301-1-mario.limonciello@amd.com>
 <20220912172401.22301-5-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912172401.22301-5-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, Sep 12, 2022 at 12:23:58PM -0500 schrieb Mario Limonciello:
> ASUS TUF Gaming A17 FA707RE has problems with ACPI events after
> s2idle resume.  It's from a missing call to an ASL method in AMD
> the s2idle calling path. Force the system to use the Microsoft
> Modern Standby calling path instead.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216101
> Reported-and-tested-by: catalin@antebit.com
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Fixup for __init
> ---
>  drivers/acpi/x86/s2idle.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index a9b0f2b54a1c..9ee734e0c3c5 100644
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
> +	{
> +		/*
> +		 * ASUS TUF Gaming A17 FA707RE
> +		 * https://bugzilla.kernel.org/show_bug.cgi?id=216101
> +		 */
> +		.callback = lps0_prefer_microsoft,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming A17"),
> +		},
> +	},
> +	{}
> +};
> +
>  static int lps0_device_attach(struct acpi_device *adev,
>  			      const struct acpi_device_id *not_used)
>  {
> @@ -566,8 +589,9 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
>  	.end = acpi_s2idle_end,
>  };
>  
> -void acpi_s2idle_setup(void)
> +void __init acpi_s2idle_setup(void)

Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ

regards
Philipp
