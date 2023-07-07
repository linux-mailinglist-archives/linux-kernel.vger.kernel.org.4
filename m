Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D173274B360
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjGGOzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjGGOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:55:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BF02127
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:54:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso21875965e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688741696; x=1691333696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nCmV7fiGs17vOoW6jQ+gtcQefFmrmAwZGHtezQ7LSc4=;
        b=JuOBcO/9/pHIs2DWjQ8kkQYNIMrKI9j1xsBNroiY2DU36g2Fr+8iQ/p4lTSKvOEXqA
         1rOyNViNDwukx2/yFEac5y27u9s24NUkZI8nkrALQt5YbN+nbLS3SIyUE0H3P+1fT+Lf
         Or5pEBJ+2YCH4LLrI59X03tvu8kr7k6Gdt+sGZolcp5Nntq45VIE36W39tcAIKz4Z7w5
         4AH+IjteCQxliNp7+bVbkOOOnroBCW9r6ZoCsxBOPuKIypmWMXp3ONDuC4HjihV+ZYIY
         Pbx1MXRn5cyPAlFmd+8cdkcjnxfp2c6mYLmYqhMoapJO0N5c/tqZMCUGKX3jbnEIe0Kb
         3unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688741696; x=1691333696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCmV7fiGs17vOoW6jQ+gtcQefFmrmAwZGHtezQ7LSc4=;
        b=LD/Sp7POY+QttlKNfehxu52zmELWoIy43/Ya8weVJyAVGBHruuEnaoXprXUkiFo70z
         IqgK9D1lZF6/GOYOxLAkpI9h4FUPlChy2ETXDDy508Faq9aOXKWJjKM+RlXViztKAkca
         6XDx60evy3R7Tkq1SNl7y4ns94WvVExhTEjSxTYnt0P6UGwgisYmoK2oLmet+q6KUqqt
         2Qkf6kMvKeRfkYPzdEtn1deEtaaFnFIkPnDgIXu8KYSAgv6zqo2xa3He4e0lUpwLaYxp
         PcC9OCesdnPSO2DlbhKwrf3LUM0ZS17Y51y+tj8MRkJ1+K5+QhonKxoX4IpfNsTTC4Kc
         Rzzw==
X-Gm-Message-State: ABy/qLYZbWKlBgv/Fecp82EInFAp0NJdSndqz1oG9hiwvXq2cfgi7Rhl
        Rkrg/4fOmUWWbooVcVKS2OsPIg==
X-Google-Smtp-Source: APBJJlE54HhnEzV14Ro51KZN9jsYR3sloJY7vtXytRjG+Swaa0Wo/wKiHlX+oDAk24UMOg0TTkK6Xw==
X-Received: by 2002:adf:ed8f:0:b0:312:74a9:8262 with SMTP id c15-20020adfed8f000000b0031274a98262mr3881800wro.62.1688741696095;
        Fri, 07 Jul 2023 07:54:56 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d5608000000b003142c85fbcdsm4699004wrv.11.2023.07.07.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:54:54 -0700 (PDT)
Date:   Fri, 7 Jul 2023 17:54:51 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     hexingwei001@208suo.com
Cc:     hdegoede@redhat.com, mchehab@kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        colin.i.king@gmail.com, gregkh@linuxfoundation.org,
        sakari.ailus@linux.intel.com
Subject: Re: [PATCH] soc: ti: smartreflex: void function return statements
 are not generally useful
Message-ID: <e13aa236-45f5-4d29-866a-999c04ef3be2@kadam.mountain>
References: <20230707133447.28102-1-panzhiai@cdjrlc.com>
 <d4b290f08da0c2435f3fa4676e7a5f25@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b290f08da0c2435f3fa4676e7a5f25@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to CC linux-staging@lists.linux.dev.  Use
scripts/get_maintainer.pl to find the appropriate lists.

Your From header doesn't have your name, just your email address.

The subject is too long.  Change it to:

[PATCH] soc: ti: smartreflex: Remove unnecessary return statement

The patch is corrupted.  Take a look at
Documentation/process/email-clients.rst.  Send an email to yourself
first to verify it applies.
> diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
> index 62b2f1464e46..20abfb0b8f26 100644
> --- a/drivers/soc/ti/smartreflex.c
> +++ b/drivers/soc/ti/smartreflex.c
> @@ -955,7 +955,7 @@ static void omap_sr_shutdown(struct platform_device
> *pdev)
>      if (sr_info->autocomp_active)
>          sr_stop_vddautocomp(sr_info);
> 
> -    return;
> +

This introduces two blank lines in a row which is a style violation.  In
fact, there should be no blank lines before the last } closing brace in
a function so delete the other blank line as well.

>  }

regards,
dan carpenter

