Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F41C717188
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjE3XR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjE3XR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:17:26 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAC6107
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:17:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d341bdedcso3721945b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488643; x=1688080643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=On+FQfGbR+8Ii8Eys7nptg115kLyMdrhpZBqAuKx0+A=;
        b=GKpRmVNc9L0TDMOju0I9bvnRlrNJw43AMPsnzVHZeEP1yyQVupwi+w0ysa9vUvyG6/
         wcig/og16wFMUHJjuRIvwyV+SCZK4yqf0UO0xpsIxJtMBpSQynjTHvJNeVrJq+9ElFg/
         +BdB0zomT3Uypxw6HssDmild0/uud4HJtR5zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488643; x=1688080643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=On+FQfGbR+8Ii8Eys7nptg115kLyMdrhpZBqAuKx0+A=;
        b=ZT66zW8gkPGeyuJBP+Ar954MuzjQe6p/7wLkMJAJWzp5ZjsqmfMPav4uxPku2mxqlJ
         I6XOtk6WiUMCF19uNgJIr1oyst1wCRXwqNlKlHT9K3qs9pnEPeKY0XaOhZVGMUF8FE75
         TQwuYKa8Z7KUuOl6bxBOjyktg+G49SPO4K79YlU7UqBVriGn8HSTanM16f0CJh5JQM1d
         okc0MezPLHyJSfdJVVcVUSW1cCi51zjXT+ZcbEUwl+139tC8xlys0PghjF0lmsXpR3Mi
         6BEh/z11j4zGQbbwMFAsqN05j5Kd5lSGH9IdGjkAnzYI3rQNPjp1jOncDOxZZF7BGNLa
         Slhw==
X-Gm-Message-State: AC+VfDyNVSVMWOl7NUM/fzrhSTkN87eArKJ9uzNs5DpuGyic1/IUcrcZ
        pNFQeDEs+a9pDPAIcw8lofttiw==
X-Google-Smtp-Source: ACHHUZ7ko2RUUKseYSndQOTaEGaqJHscWF8CwX3Qf9+d+6/JHqGs0Dfy+X614hMfGmWpEyOaxb/iZA==
X-Received: by 2002:a17:903:32d1:b0:1ac:7260:80a7 with SMTP id i17-20020a17090332d100b001ac726080a7mr4793068plr.43.1685488643322;
        Tue, 30 May 2023 16:17:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y18-20020a1709027c9200b001a9bfd4c5dfsm10741486pll.147.2023.05.30.16.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:17:22 -0700 (PDT)
Date:   Tue, 30 May 2023 16:17:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] ARM: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301617.FD31A8E9B1@keescook>
References: <20230530155501.222213-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530155501.222213-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:55:01PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
