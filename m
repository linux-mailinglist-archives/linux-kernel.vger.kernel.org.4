Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C659574E2B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGKAm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjGKAmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:42:53 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287A0A0;
        Mon, 10 Jul 2023 17:42:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-262dc1ced40so3724175a91.3;
        Mon, 10 Jul 2023 17:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689036172; x=1691628172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k68Ut8PHB5gxL0IDowPNH7dg2dW+Rmk/0PtqyCTd1NQ=;
        b=e4jlusCcMCV7+BkUO2FzbepFRFyFtElyzMALPFlALaKrv2sP+ytjsE0oRYTP3Xg4lT
         pJvLGP8804mhShhJGO7lINYsZ9bddCyobLRyNaaEDJ7B6YJ6qZT0TedtxfUmr6RxGeiU
         gbFHYtrVSoiStLksZ346zHw21Vj9/aSpLerH4K62KMe4tlTmWe/kLptE3MI0MRd6rigY
         20ygw/w3ybhGLGwS/Fib5yMpQIa+Z7N/ilqP861+UxtfW1xX1YMJmm/k+YYghFdY1vO4
         gCNxDLbdxJrvJRn6zXnAEyke0w6mMMoUNeeGC+01JzCzvXVeDdRjzy3frrsgALebflmi
         VmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689036172; x=1691628172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k68Ut8PHB5gxL0IDowPNH7dg2dW+Rmk/0PtqyCTd1NQ=;
        b=JDbZAp0d4CbQ0aQE1+JmSjYLCZe5ZK7ZFHLwyzB2A0+S37dCG0JmVGqKij11mEN8Dx
         R2BwPJ8ZscCdbw41feyPyqhfkBETp0GG1VApshMud8ZzMGdunHN1uiI9/gu9UEeZjd3O
         QW/qAghKq30SYhVa9trL/6Efm9BE2qmYKAkCjuRZWzhUlPWXE2iVdoaajO8rq0xvMru1
         xDJkJxYmJQvSz/ba5wQ2JGva6BZCStb9a8LGtIRzjxMbNzWtya1CCSQnU0dbYSXJJAVi
         xhAhBoVsVU5PElNO5HRlUWgJn919gm082hT6gOB5WUscdj4EvcGzOLiUaxU1pMu2c16J
         BP+g==
X-Gm-Message-State: ABy/qLYN3xqmsQ3AW+DAFivDf7ggHZ0SAu+lM4CsxhCtvLz+PFJbrv9d
        cvtNQMz5yyiVBbW/w+kqCXF8cdIxSjc=
X-Google-Smtp-Source: APBJJlEi0RzKpIFVtgo7FwUOBO5jd5NH0n7fWfx4yGxNRBu4NaR6kAdGyNSWcgKIwCsuxhnhTn1mzA==
X-Received: by 2002:a17:90a:74c6:b0:262:ff86:ac2d with SMTP id p6-20020a17090a74c600b00262ff86ac2dmr14601850pjl.46.1689036172466;
        Mon, 10 Jul 2023 17:42:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:96bf:7e77:39eb:7a23])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090adc0500b002630c9d78aasm544174pjv.5.2023.07.10.17.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 17:42:52 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:42:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] Input: nomadik-ske-keypad - Convert to use devm_*
 api
Message-ID: <ZKyliRefKiualqO1@google.com>
References: <20230705052346.39337-1-frank.li@vivo.com>
 <20230705052346.39337-8-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705052346.39337-8-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 05, 2023 at 01:23:44PM +0800, Yangtao Li wrote:
> @@ -305,7 +288,7 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
>  	error = clk_prepare_enable(keypad->pclk);
>  	if (error) {
>  		dev_err(&pdev->dev, "Failed to prepare/enable pclk\n");
> -		goto err_clk;
> +		return error;
>  	}
>  
>  	error = clk_prepare_enable(keypad->clk);

We should not mix managed (devm) and normal resources, because doing so
wrecks the order of resource unwinding. Lucklily we have
devm_clk_get_enabled() now, so I switched the driver to use it and
applied the patch.

Thanks.

-- 
Dmitry
