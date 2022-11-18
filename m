Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C383562FBCB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiKRRkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241447AbiKRRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:40:19 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8A220BF1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:40:17 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id b29so5503319pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B57T8uZs4kSEK7BZka3aDp/YZY01b3mwy/c7O4ofLxM=;
        b=iS1EU+k/Ez8kCgR9jL46V+OCbHucz4zMezoWTCKlYrd8FXkX+Pjv3zNnz6phAqfuMN
         u9EdWMAO+0aGG+7wXvNtWvEn7aCxk3mBjoG5maDdYcWQGsT82es6CTa6OQ8LNSHMMD8Y
         ke+dhjLZwJ4iG+x/bMJa2INjB3Obart5TQmUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B57T8uZs4kSEK7BZka3aDp/YZY01b3mwy/c7O4ofLxM=;
        b=07P6RHzyFtwjhsyGqcdy30igmNiqrVJGOn1vs8SRd8n67NdiU1bZgywCphu7JeJGD3
         4ydY2CYw50yEwrm0MGSgYb4xENiuUb/SKJPD06X224flz/Djlz6xLPiloemVnCRwPLHz
         YKUEtjwIqwftzsAF7qWCp4e5ozRUXv8TLvZa7c/HJF4sqi6FDFGhUtiPdhV8Z1h52s2+
         zt6ww237eBGRfdI6bFjNpblJJHec9fQyucCED51H/bTrAkgxdai9I5+7D+5RTWgCtt65
         413scBMxhezFzjFrNEJKoqY4IsQObv2PRrjHkKt0znF/qsLeFyPmF7n6Xuj96/fwFEiW
         ZB5g==
X-Gm-Message-State: ANoB5pmHrhJe5cjE4xM3k+Hqnqhc2xZ8DGaya29tRZi7WDmBbIlfR6NF
        QO0v9s2cAfsE8Me/NaR4AE3Tnw==
X-Google-Smtp-Source: AA0mqf4X1RIiE+117/z5tT4zIbvkcA//TYvYG/AUDdQvRWDbDhLF366Jq7IVJU5l9njz8oo6JGboiA==
X-Received: by 2002:a63:1760:0:b0:470:580a:c8a with SMTP id 32-20020a631760000000b00470580a0c8amr7093994pgx.505.1668793216867;
        Fri, 18 Nov 2022 09:40:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w11-20020aa79a0b000000b0056bad6ff1b8sm3416073pfj.101.2022.11.18.09.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 09:40:16 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     nathan@kernel.org, alison.wang@nxp.com, stefan@agner.ch
Cc:     Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev,
        trix@redhat.com, samitolvanen@google.com, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ndesaulniers@google.com
Subject: Re: [PATCH] drm/fsl-dcu: Fix return type of fsl_dcu_drm_connector_mode_valid()
Date:   Fri, 18 Nov 2022 09:40:01 -0800
Message-Id: <166879319846.2080862.8296193513373990861.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102154215.78059-1-nathan@kernel.org>
References: <20221102154215.78059-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 08:42:15 -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] drm/fsl-dcu: Fix return type of fsl_dcu_drm_connector_mode_valid()
      https://git.kernel.org/kees/c/96d845a67b7e

-- 
Kees Cook

