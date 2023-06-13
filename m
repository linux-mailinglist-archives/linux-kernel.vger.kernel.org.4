Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F2572EC02
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjFMTcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjFMTb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:31:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2E8E59
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:31:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b4f95833c7so509995ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686684717; x=1689276717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5euzgeiZ5qWr3Kx1p765UIGm0BpE7qlZD/8jcIprGc=;
        b=g4Xdj6IL66L7V4ix9KjnbpfTLfianXbn3R6cC3gdbzRXuEzA4dU+l9DbgpeacZXjBO
         J1mDR4cFc/g8fb58ztIUGKiiLuED3wp9ics2T9egKaEnSCTM4JqXSnaor+C2Xa5a/Tg/
         zBlKNm484JI940uwwzy5upXCEjwV/lfZ97ufE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684717; x=1689276717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5euzgeiZ5qWr3Kx1p765UIGm0BpE7qlZD/8jcIprGc=;
        b=CZXcB1+mx+oIZkjLvsYP11xUScx652aEmQnVFpeWZ1NuE3YhQRb8yFk/HTKA9Wcb8J
         rNov1Nm+az4u+rAu90g5wgSIuBAFk4TcVsKL3bjMHWF6WkS1XqWjL+zdTxEznOd1u3jZ
         2p/JvRmFmgl4eCHJp2mNm8G0WiHEicE/Cx+laaeK0l8RtU5AjOuVHnaL9lzvQRW2UstH
         q6kksFNRbrcJRqebwBRyg+k87w4tdbcwe81tKsycLMRaEK8xwcREXzuRqLwTh0ukikAB
         50FgGVqJ7JQDwasx43HYiJnD38z1z35yHYCTjJPXOllR9YfWWCuZIOkFoooBpPOiZAN2
         1aUw==
X-Gm-Message-State: AC+VfDzlNeXz7T3WRXvzd6v/W6TUO1JEBv1mxJ80/xrQHXsHNwZ/2AXO
        uocjVrKOf+NVI8KCw1qW3rat/pJvw/b3tj5X2bY=
X-Google-Smtp-Source: ACHHUZ48VUIKnVIubqBg9OkadgWv/RDkrdFOjNUm/zcfs1CQ34NnLMg6nLwOgDF8RhZ91vxZlxsydw==
X-Received: by 2002:a17:902:d887:b0:1b0:6541:91c2 with SMTP id b7-20020a170902d88700b001b0654191c2mr9679573plz.63.1686684717178;
        Tue, 13 Jun 2023 12:31:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p7-20020a1709026b8700b001b04b1fae4dsm239374plk.35.2023.06.13.12.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:31:56 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:31:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, Hongren Zheng <i@zenithal.me>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: usbip_host: Replace strlcpy with strscpy
Message-ID: <202306131231.88243CB@keescook>
References: <20230613004402.3540432-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613004402.3540432-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:44:02AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -E2BIG
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  drivers/usb/usbip/stub_main.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
> index e8c3131a8543..a92a284f5abb 100644
> --- a/drivers/usb/usbip/stub_main.c
> +++ b/drivers/usb/usbip/stub_main.c
> @@ -174,8 +174,8 @@ static ssize_t match_busid_store(struct device_driver *dev, const char *buf,
>  		return -EINVAL;
>  
>  	/* busid needs to include \0 termination */
> -	len = strlcpy(busid, buf + 4, BUSID_SIZE);
> -	if (sizeof(busid) <= len)
> +	len = strscpy(busid, buf + 4, BUSID_SIZE);
> +	if (len == -E2BIG)
>  		return -EINVAL;

"len" is never used again, so maybe:

	if (strscpy(...) < 0)
		return -EINVAL;

-Kees

>  
>  	if (!strncmp(buf, "add ", 4)) {
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 
> 

-- 
Kees Cook
