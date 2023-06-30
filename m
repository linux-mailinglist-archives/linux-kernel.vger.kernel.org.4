Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9503F74422A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjF3SZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjF3SZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:25:15 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1961B5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:25:14 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a0642e4695so1316362b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688149514; x=1690741514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kyMHPqgFkqrCLjrfJwzZAICfyuA66R9v5BF7rbPVGX0=;
        b=SyByWdPjKThkQ6YM6aYAkTOSoqsI4TPrQQZG2te9zp6qMEaSWKgE8u6CN8kFGQqjsr
         QFbTYn7s23dZdUayOaom4Sub5UQ4VfgDin3H12OOLPtlVUSHaYlULwhd5HgcOZ7Jlf+y
         RwQ/MxRM9sRJeMCCwQIBRTWUlXDhw0g3HMcRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688149514; x=1690741514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyMHPqgFkqrCLjrfJwzZAICfyuA66R9v5BF7rbPVGX0=;
        b=aeh1seYAhxOPiYF5QjvM7hQWDK/zoKsVS7L+0X2BC8q9cbGjOK4Z0UlXzaQJ6aucDI
         IxW/xvHRFZf9bX9LkAveriUQLt07Ke9EoA8kT6UB0Rff7VyM0x41WBb3L9iXg4+LeKAM
         YFT3OM2W1vQ09P2zZKujZcw0Imb1FLAXoNwDkiCZxjR8WmYvpBOBw02rpNN077nxtbnn
         C8qB7G6Dc7Wp4eJ1iaqIlYNB3pfhEg8yDcHBqY3Xiy86Xp6kzePkyk1YSfFaPPqIZ/MK
         2ul/JhSTp8BucDEBcWuRKzTRk9avuTANk+gfVwq/N7WEWDx0ocj6MdYomMPM4VZh3iH7
         Oz+Q==
X-Gm-Message-State: AC+VfDwUICQhwZ00c2xCDA8ujydYvGs6bOopiV9Qs+RPmM9PAuDZntr9
        abHIu0X27godFHefNDVMR9aImw==
X-Google-Smtp-Source: ACHHUZ4eIjI6ILzn5IHdnhn6/8uGaeOlIGsrOXUs9ILUhXM6HRgK78y9vpFuktGOCts3Mvge7PXhPg==
X-Received: by 2002:a05:6808:1b23:b0:3a3:6113:ce79 with SMTP id bx35-20020a0568081b2300b003a36113ce79mr3297214oib.40.1688149513722;
        Fri, 30 Jun 2023 11:25:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fe21-20020a056a002f1500b0066ebaeb149dsm9530556pfb.88.2023.06.30.11.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:25:13 -0700 (PDT)
Date:   Fri, 30 Jun 2023 11:25:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] riscv: Add types to indirectly called assembly
 functions
Message-ID: <202306301125.B58257BE4B@keescook>
References: <20230629234244.1752366-8-samitolvanen@google.com>
 <20230629234244.1752366-10-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629234244.1752366-10-samitolvanen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:42:47PM +0000, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, assembly functions indirectly called
> from C code must be annotated with type identifiers to pass CFI
> checking. Use the SYM_TYPED_START macro to add types to the
> relevant functions.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
