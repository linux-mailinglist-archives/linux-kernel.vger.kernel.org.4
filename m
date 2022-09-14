Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4265B899A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiINN7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiINN7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:59:36 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2852D1E8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:59:27 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 78so14371117pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wavsrAyG6NiOWTam0JHv7PKYgavbpXhgMRnb2r58pdo=;
        b=kH4L3gqh4xzjn+C8/0iA1Uc6n5BYUDTf66L2gvMLHiPbaL03lhM8U+vvbFU6sEp7kv
         1mKFE3Mttqx8cGHXnYEBcLO+pObY56ATqdnlLUZWvRYItE2D58jJtYg4lTNIFXn1kw15
         T1KkgtxGGBdDxPkiThQyvg8500khkMUeZL0Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wavsrAyG6NiOWTam0JHv7PKYgavbpXhgMRnb2r58pdo=;
        b=Ccp5zmdzJ50qWdVmPJoZnGwJc1qcYnc0hhUpwpI8+inmzDpfthwJdapnoDrEJ+12zO
         mNnZ2dm/wjk3z+rcwlHMfT30nDT4mf9kOA6MSSdepsw3irR76SIf7JAV0bT1S1r0eF5S
         r8ySL59zhVIudnllkmnnbVP0sVFWZlHaROCQuBIg/4rYEnUZATmHODKWLjFxCFE8m8hx
         qqNg/9IQd4i0bVSAjq3LedjJd0VkLFD9+FjBYO29Q7l0qbQBqPtDnTg11Vw7dC/c5rXr
         0efU1juuKt6hku8l20L85YGuVvQZo1e0SbmhChQIwXvM5Z8J7u9XCY6OVAqIYzMAy6vT
         3a/g==
X-Gm-Message-State: ACgBeo38sr0Xzk07Efe0763GLJRFMrPbNf2aO6o7SdtVXlhYnpEnAWKe
        z45+Z56lyG3b2Q+jx/UqeSQHOA==
X-Google-Smtp-Source: AA6agR6y4ULei98zaMifYBH1DzZDIoH+v39NLO21Q/U5CM0RCjhTsjHyJqiAC+NtcWxFmIgg5xCBFQ==
X-Received: by 2002:a62:5443:0:b0:53b:b934:ee8e with SMTP id i64-20020a625443000000b0053bb934ee8emr38389448pfb.10.1663163966560;
        Wed, 14 Sep 2022 06:59:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b001780cdade11sm10653354pll.51.2022.09.14.06.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 06:59:25 -0700 (PDT)
Date:   Wed, 14 Sep 2022 06:59:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fortify: Adjust KUnit test for modular build
Message-ID: <202209140658.A471548@keescook>
References: <20220913173136.1926909-1-keescook@chromium.org>
 <CABVgOSnSsMxHQJNPs77rzA729wW1k6o17_ERqGvszFVkQ-hv_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSnSsMxHQJNPs77rzA729wW1k6o17_ERqGvszFVkQ-hv_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 06:13:59PM +0800, David Gow wrote:
> On Wed, Sep 14, 2022 at 1:31 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > A much better "unknown size" string pointer is available directly from
> > struct test, so use that instead of a global that isn't shared with
> > modules.
> >
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Link: https://lore.kernel.org/lkml/YyCOHOchVuE/E7vS@dev-arch.thelio-3990X
> > Fixes: 875bfd5276f3 ("fortify: Add KUnit test for FORTIFY_SOURCE internals")
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Whoops! Thanks Nathan! :) This fixes it for your reproducer.
> 
> Ah, this is better than saved_command_line, IMO. I don't think it'd
> necessarily be a _disaster_ to just introduce a new dynamically-sized
> string here, which would be more explicit, but test->name is at least
> obviously related to this file anyway.

Yeah, and I'm trying to explicitly use a string that the compiler won't
immediately be able to see through, so best to get it from an external
source.

> Reviewed-by: David Gow <davidgow@google.com>

Thanks!

-Kees

-- 
Kees Cook
