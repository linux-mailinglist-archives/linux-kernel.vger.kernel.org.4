Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2949864E6CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 05:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLPEzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 23:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLPEzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 23:55:11 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCA54044B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 20:55:10 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so4896597pjj.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 20:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0Tj2k/1t7IFFkY/9dHnLGaWG8Wc/rSGoUwoxjZjG0c=;
        b=w/aIbkNZ8GVpY67t83q0gZDEpwPlUa/DEFNFj1k4B142i9zxQXDk7NCxvdpQIAknQm
         BWjMTJf+Solsk8eeHIzQmf5UfsCuHC+K2SWHeEONhtYNf4a0GlFP0/ZGOG4ias6KUzxg
         CKgDHBLcpbUCtMkP42h8ifGqe9rHkgXgKlQhWNXpJXgJfxqhZTACM8TqUf0Cxw51zdMe
         fiq3nwuRFylCxcAMfq/1QIIxl+Akd+jOjVsf552hgkgRcOqvxJXuqdqD0SocmFyg5YHw
         B2zEMQ6zrCkrimzljP2BQS6+wq/xNLrgS/oGLlS1zdsuuVG0QaeSx2Af2HoQAU21ThOB
         fb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0Tj2k/1t7IFFkY/9dHnLGaWG8Wc/rSGoUwoxjZjG0c=;
        b=XxT8M7ZapbWCdX3lVqkwVGXEdnv5N8SITIS1PE6BmVayzXaHKVsqGH8saBlJYKjk5c
         cd7Ynvds71TpQVLCclVvxG/U+WAfQ39kc2JF17NiesrWnWau+BU/hrZjEOvxojZxLffE
         NgYzMVIzfHrFcLICarHSMLiw7+K4uz/kypkF2xesi2DdQ62gB3WsxGMzxWHZdJss05SG
         zYQzHCYzkT8Pd13+S3oN2SaKEcckPnPD7+ZrHnB63sMpS0TjsKggZ3OgIYXxhg5UzYfm
         uVK0YGkc8agXHItAxIexsF4EbJ/F+KuHqf08vhE4YkhaxiXIF8ANUk4l9PeHYr3Bm4qp
         ps0A==
X-Gm-Message-State: ANoB5pnd1nePYnH3YdfcG7BxsLUXl6fsxjRHr/DE+E5TvbjFXxOIHW4q
        C+fV/0IcgB9f+x/sr7iNarlOxw==
X-Google-Smtp-Source: AA0mqf57oecpu1XU54PlDJZcjwZdwR4smxE5Zu9aOaFo5PtlUFwVlK19poM3sY1qyj6L5LO2/x79KQ==
X-Received: by 2002:a17:902:7143:b0:189:5ff6:903a with SMTP id u3-20020a170902714300b001895ff6903amr30167034plm.52.1671166509616;
        Thu, 15 Dec 2022 20:55:09 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902c38600b0017f64ab80e5sm509175plg.179.2022.12.15.20.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 20:55:08 -0800 (PST)
Date:   Fri, 16 Dec 2022 10:25:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Eric Curtin <ecurtin@redhat.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: apple: remove duplicate intializer
Message-ID: <20221216045506.edsjlxkkhma4mh5h@vireshk-i7>
References: <20221215165523.1920672-1-arnd@kernel.org>
 <CAOgh=Fw4BXvGNV0bsTXfSxy+ks09ed=nbJhkOWE+UrT7LW+r6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOgh=Fw4BXvGNV0bsTXfSxy+ks09ed=nbJhkOWE+UrT7LW+r6A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-12-22, 17:10, Eric Curtin wrote:
> On Thu, 15 Dec 2022 at 17:05, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When -Woverride-init is enabled, gcc notices that the .attr
> > field is initialized twice:
> >
> > drivers/cpufreq/apple-soc-cpufreq.c:331:27: error: initialized field overwritten [-Werror=override-init]
> >   331 |         .attr           = apple_soc_cpufreq_hw_attr,
> >       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Remove the first one, since this is not actually used.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Applied. Thanks.

-- 
viresh
