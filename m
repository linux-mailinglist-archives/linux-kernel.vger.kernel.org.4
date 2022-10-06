Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE68D5F71C3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiJFX1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiJFX1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:27:34 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB493BBE22
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:27:33 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id v186so3409212pfv.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=t/Fn1rFe9RxUjUPW0aTaKQgk6enalkHXPAMzNv/vI1U=;
        b=h36AdQHIpsJKcKRyXZ5n5CTzbj3vlgx+sHmXkK7a8FzYrQ6K4/LKNSvRvYKl8yLsZd
         pcRrf03MMIjwepNwZ/juPvzY2BuxsXbpG89t2rVxUlnWK1Xk3rNTm5s7Q7dhxzaUPGFm
         ybCZYejJKLX+Q0swAkH5yL5JgQO6HNwRg0mms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=t/Fn1rFe9RxUjUPW0aTaKQgk6enalkHXPAMzNv/vI1U=;
        b=DVZ44gNYKEciQr6fobCEtpjI/yTrv8UPlHxwXkXsKHhYhbe3Y65xSwOs3zS3UZ1UL0
         U+qjkVgPF0Za66pbYP32bA+IzyYBAmXaur63DvErpYE0P4oDuBZ6X58vSIUOA4FJhG9Q
         q5+NBrcUEpJ14Scf4gguy93UpOGFutlUqbCc3cIEpH4Vve9p67SWtf6jMSfpt2pR8lEs
         X8IDtRA/ACP9Dqxs15t2F6gMiLyKgPKfM019dJuoDTSYpfObeP+GWWEtBoIyFAnfbIEQ
         juV8xaumcXifIWEI+3jiWed4SCx3D0FS9MZcsngX/BdmUj3sQ3yBajGMk0tHiBzlAqve
         PMzg==
X-Gm-Message-State: ACrzQf0h9uBHRIc8/KbPTCkDdQOt/G6vKwcuwuexUWDj/pvyDaN/lYm+
        UsPP4WfJ+lnZ7VYiezq0iDi8ng==
X-Google-Smtp-Source: AMsMyM6KpOiGpWMiJKyttq+WaWMVhuLkBx54w+SGG4VVozvmAVPkCZQlcahgrwR5QA3WeIbPneZWvA==
X-Received: by 2002:a05:6a00:3498:b0:562:70d0:1baf with SMTP id cp24-20020a056a00349800b0056270d01bafmr1828092pfb.61.1665098853334;
        Thu, 06 Oct 2022 16:27:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709027e4a00b0017f96581783sm146849pln.223.2022.10.06.16.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:27:32 -0700 (PDT)
Date:   Thu, 6 Oct 2022 16:27:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Subject: Re: [PATCH 1/8] pstore: Improve error reporting in case of backend
 overlap
Message-ID: <202210061627.E29FCDBE1@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-2-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006224212.569555-2-gpiccoli@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 07:42:05PM -0300, Guilherme G. Piccoli wrote:
> The pstore infrastructure supports one single backend at a time;
> trying to load a another backend causes an error and displays a
> message, introduced on commit 0d7cd09a3dbb ("pstore: Improve
> register_pstore() error reporting").
> 
> Happens that this message is not really clear about the situation,
> also the current error returned (-EPERM) isn't accurate, whereas
> -EBUSY makes more sense. We have another place in the code that
> relies in the -EBUSY return for a similar check.
> 
> So, make it consistent here by returning -EBUSY and using a
> similar message in both scenarios.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  fs/pstore/platform.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 0c034ea39954..c32957e4b256 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -562,8 +562,9 @@ static int pstore_write_user_compat(struct pstore_record *record,
>  int pstore_register(struct pstore_info *psi)
>  {
>  	if (backend && strcmp(backend, psi->name)) {
> -		pr_warn("ignoring unexpected backend '%s'\n", psi->name);
> -		return -EPERM;
> +		pr_warn("backend '%s' already in use: ignoring '%s'\n",
> +			backend, psi->name);
> +		return -EBUSY;

Thank you! Yes, this has bothered me for a while. :)

-- 
Kees Cook
