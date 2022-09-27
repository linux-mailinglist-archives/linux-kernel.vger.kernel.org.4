Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1578B5EB7BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiI0CdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiI0CdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:33:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6543E5125
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:33:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 8-20020a17090a0b8800b00205d8564b11so386484pjr.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=beHOJoLMzhtQvwqCVFQE08wvFbsVkqCmgSaQLkojE3Q=;
        b=GgaqksQNT7cicjmr8VgOSy18SzVIWhA+3pfG4AqV2d7ivrbRQA9jxsvP1pfBShGzj/
         OvNqU5NPFlK+0R9qj3ayrs9rJ3IpaxXlAFgu1tPwntOP5mXcOTCS+Eh7FGqrCC7D5LcR
         2mrrZL+fahvKy6IbegfbZ4MQ1qtychGvEdPHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=beHOJoLMzhtQvwqCVFQE08wvFbsVkqCmgSaQLkojE3Q=;
        b=H80kGQBh1ZVVKqkmOKRPud4L+Z+qh87jYbO4tRN7MUUthF/kCY/xXfscWFuShLm7ql
         BQ2IuI7puM0tLzsx7kgubJii/mH2wBnBefUA5U8YTlVUu6wXpvOGAwct2HEv5vtm9Qjx
         RyRwWvQ2SH0bQwFiQMEbngCJa0H9mk1/Xa9gJ2mmoCEJy3V3kqLaAHzlxX2qlFd9EU0r
         58U+MIQffPh/A3PkV4ZfEXxnEUXdqvszsIzwub1FiWp93cqxDHWSANNR2DNAyKf6g4Ts
         KsgSgxPWV2eh5bh/xOcjaE5DwRwhAbAF4BWUDFpymL5xltgQtpgSxmQ2FM0ldFhCTimG
         lmWQ==
X-Gm-Message-State: ACrzQf216GOXRJ/lpq6NBFgDNelkLQII4eokvjG9UEKeR1KS9PHX8YO0
        AKW2TBuEDk9hkWAZS4OaTYP1Sw==
X-Google-Smtp-Source: AMsMyM5NGw1Q0GfafCgkdr3TRCr4jnFSRQlgeAjDLSIqENbtY3Pu0+GX+M5Sea67UDU9T9u8oKayRQ==
X-Received: by 2002:a17:902:9006:b0:178:b494:c15a with SMTP id a6-20020a170902900600b00178b494c15amr25467224plp.37.1664245991191;
        Mon, 26 Sep 2022 19:33:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902f38900b001783f964fe3sm155268ple.113.2022.09.26.19.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:33:10 -0700 (PDT)
Date:   Mon, 26 Sep 2022 19:33:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: uapi: Replace zero-length arrays with
 __DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261932.F68BBD85@keescook>
References: <YzIzUjUuJKf0mkKg@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIzUjUuJKf0mkKg@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 06:18:42PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new __DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/227
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Some day after the __element_count__ attribute exists, we might want to
consider a __type_select__ attribute to tie union members to a variable
outside the union (like the "type" member here).

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
