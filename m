Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E367A717161
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjE3XLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjE3XLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:11:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CAC11C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:10:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so3728475b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488249; x=1688080249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFt7XEHQNVyt2Kkuqvp1ttAPdqoItbGL7ZFzJEOFPcc=;
        b=fEJERwCS1muZJt/0tLW3EeCHdYYkVKDT4LrAe4vr4csJ8isGZs2Ym2ErvyQtVm+yy8
         CAseRLNzHZwAk+vMX+FosS3Y/H7EQxj+P2LP+3ekkQI78il/xx36MiAov8mPqDFcd3PX
         zgyD/j3Yge+bGUeqFUvhd2IqreyEYr3kyN56A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488249; x=1688080249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFt7XEHQNVyt2Kkuqvp1ttAPdqoItbGL7ZFzJEOFPcc=;
        b=HRBvDYnkvdsta8kbfESZmucHSTHpLM8S34FjUnibAvHpnYpUllnoNFX8hM7oi/1CI/
         AlaxKi2VdjZABIDBzZTd498pwD2b/Q4yduGzcHqeY2N/4OJLlOFfrlnn5payF5qwIw5a
         DlLRWp75zWlBLcFaNeZzsXew3N3VBrq3K/TRXHlp5GkTH6Bw/K0BQpV80Yh5cJzTQ9FT
         IcDdwqQn5g5Nl+PUKFmAdY02ucC+c4VMoI6XH3sLFLmBUG8KLoJUPzK9VXkJToFUwgeL
         xBOMiDxII6glI2cD3U7RH8FsJdl+2VEtbktAMW8y5LkNIJ5n0rW/fFkAt8S3K2aV5+4e
         cxeg==
X-Gm-Message-State: AC+VfDxMZ9/zcOMUNDM/vSrI6LV7jGxrTnMUebOBJCQUBm0c6vwJHvOS
        jU5GYW1D+ihv9rw0+jgklEDLDg==
X-Google-Smtp-Source: ACHHUZ7Ep9eGlgq+ZC7KwohdPVI674U39THUkxr8KHBC5JcJtUmkFRHkFBzDykqYBWL9NITzTnN54w==
X-Received: by 2002:a05:6a20:12cc:b0:110:7edc:fb50 with SMTP id v12-20020a056a2012cc00b001107edcfb50mr4923350pzg.9.1685488248858;
        Tue, 30 May 2023 16:10:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b11-20020a63cf4b000000b00513973a7014sm9165279pgj.12.2023.05.30.16.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:10:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        glider@google.com
Cc:     Kees Cook <keescook@chromium.org>, nathan@kernel.org,
        dvyukov@google.com, elver@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        ndesaulniers@google.com
Subject: Re: [PATCH v2] string: use __builtin_memcpy() in strlcpy/strlcat
Date:   Tue, 30 May 2023 16:10:46 -0700
Message-Id: <168548824525.1351231.6995242566921339574.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530083911.1104336-1-glider@google.com>
References: <20230530083911.1104336-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 10:39:11 +0200, Alexander Potapenko wrote:
> lib/string.c is built with -ffreestanding, which prevents the compiler
> from replacing certain functions with calls to their library versions.
> 
> On the other hand, this also prevents Clang and GCC from instrumenting
> calls to memcpy() when building with KASAN, KCSAN or KMSAN:
>  - KASAN normally replaces memcpy() with __asan_memcpy() with the
>    additional cc-param,asan-kernel-mem-intrinsic-prefix=1;
>  - KCSAN and KMSAN replace memcpy() with __tsan_memcpy() and
>    __msan_memcpy() by default.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] string: use __builtin_memcpy() in strlcpy/strlcat
      https://git.kernel.org/kees/c/cfe93c8c9a7a

-- 
Kees Cook

