Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDC6744238
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjF3S3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjF3S3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:29:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3C21B5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:29:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-262e66481c4so1151568a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688149771; x=1690741771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZJJetuBbyHmtx8DbYztgxxDQeL5eYQA+7KCOoIY7rU=;
        b=NTgXSX4MGPhVE5xJegfe7GAIBLJ+GvIVJ7Wml0XsL2a75vwQmUVfExZ2I06bGaGF9O
         v//z0xnkr0vWAc3fDGEBV2jow7KGwqiMkqB9Z5Qa2Cdj/3nTEJaIu1Z1a9ivXbaXXeyF
         U+vxM2e9YP/FAcJMJJwc0PXgLXrCdFk62i3/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688149771; x=1690741771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZJJetuBbyHmtx8DbYztgxxDQeL5eYQA+7KCOoIY7rU=;
        b=c1HsPdR43jRNYchHxpSMFcatzcm/AzIDloUo0pwttNc3MIGkF3uUbDSpKP5wNgV5Px
         JXSU61LZLIaCb1o6ttAmDG5X3mt2zWtGMnREx5IXBuwSf2VHpIn/1HlU4aup0yeatRVn
         Z94ILqIUqGpSrWUQsugZjPAmkTYaLytQyW6rx7teK6NYEMQjg5FJkTyQvl85MqoOmP4Q
         ackLg7/oRGNsoVVlar8G5gBsR4Y3QMguGaoW7XK3b16+XZm+QEyVCMvGC6FgFsUp78s4
         dsvIjHqwCg8eci+PpocDzHdc3w2rSy1MbdbsX8fHyHSxhoQ4AT5AEvo5qKGV3wwasmen
         VTPQ==
X-Gm-Message-State: ABy/qLZLBB3uLOF21DCOgPqtbsqjhI/MibHN0yRqU0gbUt91VWuKFWCm
        QskvdyJ19JipDigxxcYLF8uicg==
X-Google-Smtp-Source: APBJJlHRIfSrA0ELcRqMElCfSir9t+tI7qwmR8a7LbQqmrfHbBBuUV5GDWvDH/xmKUXnXt5EqKOncw==
X-Received: by 2002:a17:90a:f484:b0:262:c414:e0af with SMTP id bx4-20020a17090af48400b00262c414e0afmr2635720pjb.31.1688149771151;
        Fri, 30 Jun 2023 11:29:31 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090a744600b00262d9b4b527sm9935978pjk.52.2023.06.30.11.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:29:30 -0700 (PDT)
Date:   Fri, 30 Jun 2023 11:29:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] riscv: Implement syscall wrappers
Message-ID: <202306301128.E8B5E51B5@keescook>
References: <20230629234244.1752366-8-samitolvanen@google.com>
 <20230629234244.1752366-9-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629234244.1752366-9-samitolvanen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:42:46PM +0000, Sami Tolvanen wrote:
> Commit f0bddf50586d ("riscv: entry: Convert to generic entry") moved
> syscall handling to C code, which exposed function pointer type
> mismatches that trip fine-grained forward-edge Control-Flow Integrity
> (CFI) checks as syscall handlers are all called through the same
> syscall_t pointer type. To fix the type mismatches, implement pt_regs
> based syscall wrappers similarly to x86 and arm64.
> 
> This patch is based on arm64 syscall wrappers added in commit
> 4378a7d4be30 ("arm64: implement syscall wrappers"), where the main goal
> was to minimize the risk of userspace-controlled values being used
> under speculation. This may be a concern for riscv in future as well.
> 
> Following other architectures, the syscall wrappers generate three
> functions for each syscall; __riscv_<compat_>sys_<name> takes a pt_regs
> pointer and extracts arguments from registers, __se_<compat_>sys_<name>
> is a sign-extension wrapper that casts the long arguments to the
> correct types for the real syscall implementation, which is named
> __do_<compat_>sys_<name>.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

This all looks correct to me; though I have not run tested it. I'm glad
to see another arch using this style.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
