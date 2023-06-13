Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20D272EBFC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjFMTap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjFMTae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:30:34 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AC81A5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:30:32 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-654f8b56807so5945342b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686684632; x=1689276632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p9zTL6WkhKlD8rEo4R4d64UgNtBnLNYoZuMTJCOlN+o=;
        b=lAMvXmQMui7zMEyr/DPCNp/XJdds6GKxaPeycgssCkQOE9zzABt+B60heDpSUwgub0
         T6bl3aZRtjyB2UGO/F2+mtawwBoFCu/22qjqzmBMJ9z9SsfbQZQbgXgl2OD8h6SxyF2f
         qS0QoHEZtRplgwwONhm390XaklAvofry7DfpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684632; x=1689276632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9zTL6WkhKlD8rEo4R4d64UgNtBnLNYoZuMTJCOlN+o=;
        b=gdiC9mb3yuJtjkADsei3yQe7rJj2jMrec7AIijrO2xdWLeN333mRsUEDGkxsJKD61r
         hebYwr2KIZqv0nglD33HWVItUJvHY/rSXbvlTG+B72pscC//5dLrqHxzGTmBCFnX1ZK6
         9DoeBdmSE5eC7aGwSDWAAbuom8F7QpeYeCV7EXL13Oj0iy3TMyt0uqIoa+WIej9OuvA0
         Dc9NBVioQsfsEe4DXijy4BwBI1OUvb28CW0LGV429x/01/uXd5wnZB4x7WLDCT+HktZQ
         RnnLTrZj68BHVLThoaUEA2ps93ps1BVgIcZcV2AUGkYUMJN/ySQQYaUpP7yHS4h2sVlJ
         31mQ==
X-Gm-Message-State: AC+VfDznsLQsYouHkYUOo7RNDg+0IWI9zMUQhiS1zNr6g8XiaTBpc85p
        8gpyAlnKliviXQoE5XtMc8uARA==
X-Google-Smtp-Source: ACHHUZ6N9gkZEMIB3vFpJ9HaIYshp93Z/o2OR28UTSw5/MCUvWPAgeLhGW714sGpBVb0mutFqUP4Mw==
X-Received: by 2002:a05:6a20:7491:b0:118:c4c1:e0ed with SMTP id p17-20020a056a20749100b00118c4c1e0edmr16540792pzd.30.1686684632312;
        Tue, 13 Jun 2023 12:30:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 31-20020a630a1f000000b005348af1b84csm9761797pgk.74.2023.06.13.12.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:30:31 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:30:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Albert Briscoe <albertsbriscoe@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: Re: [PATCH] usb: gadget: function: printer: Replace strlcpy with
 strscpy
Message-ID: <202306131229.B5F2D9F@keescook>
References: <20230613004341.3540325-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613004341.3540325-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:43:41AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -E2BIG
> is used to check for truncation instead of sizeof(dest).

Perhaps say "PAGE_SIZE" here instead of sizeof(dest)?

> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  drivers/usb/gadget/function/f_printer.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
> index 28db3e336e7d..10dc7c55c25f 100644
> --- a/drivers/usb/gadget/function/f_printer.c
> +++ b/drivers/usb/gadget/function/f_printer.c
> @@ -1211,8 +1211,8 @@ static ssize_t f_printer_opts_pnp_string_show(struct config_item *item,
>  	if (!opts->pnp_string)
>  		goto unlock;
>  
> -	result = strlcpy(page, opts->pnp_string, PAGE_SIZE);
> -	if (result >= PAGE_SIZE) {
> +	result = strscpy(page, opts->pnp_string, PAGE_SIZE);
> +	if (result == -E2BIG) {

I think "< 1" might be a better test here.

>  		result = PAGE_SIZE;
>  	} else if (page[result - 1] != '\n' && result + 1 < PAGE_SIZE) {
>  		page[result++] = '\n';
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 
> 

-Kees

-- 
Kees Cook
