Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC586F71D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjEDSTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjEDSTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:19:44 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3A265BF
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:19:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaec9ad820so7480525ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683224378; x=1685816378;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kCiTzOmyWHWq8qYHC8k2z/0RZLeYJjOcNKGNfJf663E=;
        b=GZ4UTzeA5rPV9XwB0E1CnGOx5YglTClFyMz9hTyJvxzHxOUfzql1rg3P19Zj9CpvwX
         9slRCElaX7svCTzj0N44LiXURLmmYmIZHvu2PYxX1mOKPmzzW9Ugiacs1CtyHY0zrrZL
         +M+quAB/x/miiUwqRQ5et/eMgXWjkqZTgPqeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224378; x=1685816378;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCiTzOmyWHWq8qYHC8k2z/0RZLeYJjOcNKGNfJf663E=;
        b=Ci//ATYI/f+hQQDFaXMgmM8U55mOe24LT1Hbo1HlWhxR98Qlh38oAgg4k1cDwUjiRv
         EWTHhdtPNfkN8CEjNQM/9fNdD4kUVb7c/1YIJIYPkk5LwSF08w13g6SXHi3V3k9z4f0Q
         asUVH3dHz/51dlFThKpPIKZ+k4msQwD90jNA3i8S/O1TTy6VF5+DktlrkvMVQgCceEXY
         B0QUNC8cNbyqkFJu0ZHP6iwYIuNKvnHJMYs69r++zdgnQ7SBO5EiQui52NCyzb5HAIbM
         MT3spIq+qGZVtjoBsngewJEn+RUJ5/i+iD1JtZWxuVT1ivdnc91fb1zwDv3voduqUrq9
         6BwA==
X-Gm-Message-State: AC+VfDzWycf2gSNxe9RKFxgkPW/bgzxpBMGjm/p3Li/WQ4hG2ZJAlvli
        mJabgfXMgwSQWF63j7WQ+Fhu7g==
X-Google-Smtp-Source: ACHHUZ4IHamXVdmQ6HeS+sI01dLo9Gpa93g9AR/NYoqliF6h0f68F02DqZTKm2CJ9gX7zwc2h8nbkA==
X-Received: by 2002:a17:903:32c9:b0:1a6:8ed5:428a with SMTP id i9-20020a17090332c900b001a68ed5428amr5715553plr.22.1683224378276;
        Thu, 04 May 2023 11:19:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bx15-20020a17090af48f00b00246f9725ffcsm11448930pjb.33.2023.05.04.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 11:19:37 -0700 (PDT)
Message-ID: <6453f739.170a0220.62695.7785@mx.google.com>
X-Google-Original-Message-ID: <202305041118.@keescook>
Date:   Thu, 4 May 2023 11:19:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Bill Wendling <morbo@google.com>, Qing Zhao <qing.zhao@oracle.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Compiler Attributes: Add __counted_by macro
References: <20230504181636.never.222-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504181636.never.222-kees@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 11:16:40AM -0700, Kees Cook wrote:
> In an effort to annotate all flexible array members with their run-time
> size information, the "element_count" attribute is being introduced by
> Clang[1] and GCC[2] in future releases. This annotation will provide
> the CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE features the ability
> to perform run-time bounds checking on otherwise unknown-size flexible
> arrays.
> 
> Even though the attribute is under development, we can start the
> annotation process in the kernel. This requires defining a macro for

And FWIW, I've done a first-pass at this annotation with Coccinelle. There
are plenty more to do:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=devel/counted_by&id=adc5b3cb48a049563dc673f348eab7b6beba8a9b

155 files changed, 158 insertions, 158 deletions

-- 
Kees Cook
