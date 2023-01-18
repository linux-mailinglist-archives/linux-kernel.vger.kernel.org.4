Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F33767293C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjARUZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjARUZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:25:17 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1597153566
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:25:17 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v10-20020a17090abb8a00b00229c517a6eeso3632634pjr.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46uvpXl2kyYV0aM1iCgQPff7hpPKEZ+B8VHs2uJkR+w=;
        b=dVrLXEcaBgvYU97sVNjHhooNFluRwtCPIzI//8G66FkmP1s40nUOucz3RYYRCmKPEx
         fgAuo93zirmhoRnivzsrrpUlIi7sQ0gBclnpogdyRCed3aYi5zJIfP2UUAlSRaGHu3FY
         EJ/SCqvd85Pez6eZdqkI7PJHIqi08dl2llj6SGz+7m9awA47Z8PY5ht2YfomVwqW/N4c
         o+mLDbKw/NnG/cjzG+m1KedoySUjoabCM0SJm+w3pf8PXQQlL/D4EpRJyOBeZXJZwxKA
         EaO/qCyf3Abk921jr1UjDFVflLUTdJsuOxZSfxhi8yIYOerNOpUxe4hmrjpb0+VxEYJz
         VQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46uvpXl2kyYV0aM1iCgQPff7hpPKEZ+B8VHs2uJkR+w=;
        b=4Eih2pADF8+H6PCxEERGlh3dVrBkKcTD1Q9Jcjo3qOOZPgaZ+SD2Tgj05GyIIjFhyY
         GsKK8JsIioFsShWNNlbHWqV41+2oMN2z8LNAyLMOUhykCvZW/qZohz7cQOdKPBOIvtz2
         PKEQob+Zxrq1BlrDJQ9TyOdZhWJyvAMczEuubGx+phMtquwF+NxgaDlszD4lp2f/BiIC
         GetDC6cmefANjOpNW/NOSqzLfqHKHxKLAiajSezFddwdMUlKtwNJekwXXJLiWbHwHlYx
         RrEeElevgGoCtYQKIVtCEyUT6nB/mY6r5qXlp7uRb9qCy9QRFGNMK9ZPH1DnsEPH91gu
         /L0w==
X-Gm-Message-State: AFqh2krpKHxvbPk6vFWbiELbdvGSFqzww7NUks/RTrj964oaqVPTbFtO
        RSrSNxFf1cV+/70Lw02Dllh1Bw==
X-Google-Smtp-Source: AMrXdXv+7A9LkJCz8hBYplxN02lr9pWgA7TXhelJH2oX4KHqIaP0jqrpEgKUj060wIvjCUHFTudk5w==
X-Received: by 2002:a17:902:ea02:b0:194:8f3c:6fc6 with SMTP id s2-20020a170902ea0200b001948f3c6fc6mr11573013plg.58.1674073516510;
        Wed, 18 Jan 2023 12:25:16 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903244600b0019467381dd6sm11523541pls.33.2023.01.18.12.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:25:16 -0800 (PST)
Date:   Wed, 18 Jan 2023 12:25:16 -0800 (PST)
X-Google-Original-Date: Wed, 18 Jan 2023 12:24:47 PST (-0800)
Subject:     Re: [PATCH] gcc-plugins: Reorganize gimple includes for GCC 13
In-Reply-To: <20230118202355.never.520-kees@kernel.org>
CC:     linux-hardening@vger.kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     keescook@chromium.org
Message-ID: <mhng-8bc81919-3023-4d72-bd44-2443606b4fd7@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 12:24:02 PST (-0800), keescook@chromium.org wrote:
> The gimple-iterator.h header must be included before gimple-fold.h
> starting with GCC 13. Reorganize gimple headers to work for all GCC
> versions.
>
> Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
> Link: https://lore.kernel.org/all/20230113173033.4380-1-palmer@rivosinc.com/
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/gcc-plugins/gcc-common.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
> index 9a1895747b15..84c730da36dd 100644
> --- a/scripts/gcc-plugins/gcc-common.h
> +++ b/scripts/gcc-plugins/gcc-common.h
> @@ -71,7 +71,9 @@
>  #include "varasm.h"
>  #include "stor-layout.h"
>  #include "internal-fn.h"
> +#include "gimple.h"
>  #include "gimple-expr.h"
> +#include "gimple-iterator.h"
>  #include "gimple-fold.h"
>  #include "context.h"
>  #include "tree-ssa-alias.h"
> @@ -85,10 +87,8 @@
>  #include "tree-eh.h"
>  #include "stmt.h"
>  #include "gimplify.h"
> -#include "gimple.h"
>  #include "tree-phinodes.h"
>  #include "tree-cfg.h"
> -#include "gimple-iterator.h"
>  #include "gimple-ssa.h"
>  #include "ssa-iterators.h"

Thanks, not sure how I missed it the first round.  My testing box is 
tied up, but I'v egot the same diff lying around somewhere so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
