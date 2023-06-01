Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F73271F1CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjFASZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFASZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:25:48 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37886123
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 11:25:47 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-651e298be3fso546577b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685643946; x=1688235946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOWrCIIhxQP/v9l3qMkwCSylYdgGBfEpugzVcIgxuXE=;
        b=nuA+3VumfoEo4JKEcQjfZ794l0EgspWV4ZFLh4TQbrXPOesyWBWh5jpk4BCx7GwHHy
         ItoQ5+a/PTklHO+8cKT/U3aXtDQmOEVIbAeIaKI2ju3OTbL/E+G0AZ3e6UQz1cr2u8Nj
         PEhLnevX0o1rauHum1SjTTkN/gqBaTagicX7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685643946; x=1688235946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOWrCIIhxQP/v9l3qMkwCSylYdgGBfEpugzVcIgxuXE=;
        b=TQlPmyhODxKX2PHXaSNO8n1vL0qSrI7b6UR+g4N5b6/+ZFjSyNsIcepdH386tVw4rM
         8nxuA7yTYIpwXB18MHFekLihcz/glKI2EqDAugtu0ZVNP0K+vM0JV50mEhuBY4R90HSC
         QLgMprUM2fvwdCKdGFKvQV954MTMQQ+wZNprJaI3ZmSkhnv0lYQMnfFZAXP3r8BpIv6P
         St3oHM+lHoax63sfGy43iKY8ctpCFuuJv3uHwapKVk/RW9HcF282idxLc5/pJQZ9X6QL
         f5EZm20F/fhb9MfNi1bKMROz6uWRVW4AnM4quIlSP1UZUFR8OpMBWrTngTzfGaOoVvWm
         LVfA==
X-Gm-Message-State: AC+VfDzlyvUilIoKFOzYJJjZRMnp745E5TjkrXv6K+ZGCtIk0E04NFkG
        jPgJa340jFMdV3gpMQ9gVm7O0g==
X-Google-Smtp-Source: ACHHUZ4ZFmMIHRDESy+YKkGQgetI7n6zLXjasm9QSIkdWizL2x1K2PXwhw0KfBdZrVZEzqtVDlVnLw==
X-Received: by 2002:a05:6a20:8f02:b0:10c:6dbc:2806 with SMTP id b2-20020a056a208f0200b0010c6dbc2806mr13586689pzk.46.1685643946705;
        Thu, 01 Jun 2023 11:25:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x18-20020aa784d2000000b0062d859a33d1sm5362906pfn.84.2023.06.01.11.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 11:25:46 -0700 (PDT)
Date:   Thu, 1 Jun 2023 11:25:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     azeemshaikh38@gmail.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: sgi_w1: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202306011125.D66A54586E@keescook>
References: <20230523022023.2406955-1-azeemshaikh38@gmail.com>
 <168548796310.1350188.6990158151809298087.b4-ty@chromium.org>
 <5d9cf207-7984-6dd0-731f-e301aa7b25c2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d9cf207-7984-6dd0-731f-e301aa7b25c2@linaro.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 07:03:41PM +0200, Krzysztof Kozlowski wrote:
> On 31/05/2023 01:06, Kees Cook wrote:
> > On Tue, 23 May 2023 02:20:23 +0000, Azeem Shaikh wrote:
> >> strlcpy() reads the entire source buffer first.
> >> This read may exceed the destination size limit.
> >> This is both inefficient and can lead to linear read
> >> overflows if a source string is not NUL-terminated [1].
> >> In an effort to remove strlcpy() completely [2], replace
> >> strlcpy() here with strscpy().
> >> No return values were used, so direct replacement is safe.
> >>
> >> [...]
> > 
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] w1: sgi_w1: Replace all non-returning strlcpy with strscpy
> >       https://git.kernel.org/kees/c/4e4424b20cc4
> 
> Please drop. This was already fixed and is in linux-next since almost a
> month:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git/commit/?h=for-next&id=5dfd3c73ff81618fee0ef682b6fd7779863f41e4

Thanks! Dropped.

-- 
Kees Cook
