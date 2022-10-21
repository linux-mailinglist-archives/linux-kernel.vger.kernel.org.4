Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D387F607BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJUQLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiJUQLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:11:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8A8256412
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:11:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u6so2746005plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fbu+BtEYNl5sIs/Mog6/FA6zFEVlcBHqzE+JmGUwCR0=;
        b=DdQ1BiBjoqSmTVswfdlp0airmxc4umskLl3iwIGVJRvYPXRRMMAIzCYYA3vKczErUq
         VOY8v6ID81YSfVeVsiQ04xjKlhtS5JKd8hbnq5DszRaUbeCtVgtWwPVNGdGfHPaSKfTG
         jABPXflV9sVaswYWEu5UhQTOrhhbDm2UVmGUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbu+BtEYNl5sIs/Mog6/FA6zFEVlcBHqzE+JmGUwCR0=;
        b=bdgpqdZal5iuCNvxkbTLkAgnPoR9dJtpzBXplV0wXlNOY9AqrWdORgcmPawheWQ1WW
         NTRniEeRwC6BVjoH8Ms+EeOGeBBDn1UnanTI31KH7GY5XWZqAl8FqKCmE3+6nGVUBgJO
         t1v6OE4dM7c5EWecuzOjHFIRKmDVy6ZS5Co5BwfZILbtb5eaKA9FCZcxVsYABDbgllCG
         6tDqQFdLspIZkqslnq6zmGcGne9W/a9w5XbC13t16ftno/cErbSFOR2HDpkXVg/tOejJ
         CAFMMjC059v7PlbB09k9lH2z5xvTMI0E4jjCIrsOiSuKH5ubwMk3ZSO7YsxhSJV3GHUs
         wzNg==
X-Gm-Message-State: ACrzQf2KQJkZI/e+dTqu0BgJy0b3YXWcEsn1aq5caS4sqcs7IX2ljNFD
        VeCTgGT0NhCGUAE7YMD0IjqnEQ==
X-Google-Smtp-Source: AMsMyM7uxSBEx56p7aps29xGjxe5tsVm6rBCMecO1QizElDHab1wBnnvTW9klpcyjKGC/h/w10IQpw==
X-Received: by 2002:a17:902:e885:b0:183:dcb7:c4f8 with SMTP id w5-20020a170902e88500b00183dcb7c4f8mr20128229plg.160.1666368671316;
        Fri, 21 Oct 2022 09:11:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g7-20020aa79f07000000b0056ae6db7308sm1288330pfr.137.2022.10.21.09.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:11:10 -0700 (PDT)
Date:   Fri, 21 Oct 2022 09:11:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Dan Li <ashimida@linux.alibaba.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] compiler-gcc: remove attribute support check for
 `__no_sanitize_address__`
Message-ID: <202210210911.1D4B9B23F8@keescook>
References: <20221021115956.9947-1-ojeda@kernel.org>
 <20221021115956.9947-2-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021115956.9947-2-ojeda@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:59:53PM +0200, Miguel Ojeda wrote:
> The attribute was added in GCC 4.8, while the minimum GCC version
> supported by the kernel is GCC 5.1.
> 
> Therefore, remove the check.
> 
> Link: https://godbolt.org/z/84v56vcn8
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
