Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5857058F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjEPUhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjEPUhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:37:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879D02112
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:37:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-643990c5373so14918532b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684269438; x=1686861438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Mgv2eOlGj/h9MwpBTlxreNYaXJNzFwMprpBEmpknKc=;
        b=TdlKCzKhDFUQTd31/qkSmmjb0xhqD5H36cEE70QK4cpplWptxDkNCZK29F6tr8HEqu
         GdakMB9csehTVAPg9SiLLLNjckM1jm2i9qFgagCLvsbHwAoQaSUztcg4MOEwEh4wnpHQ
         Trz90IS4j3mClG0eYjmpdpBVXP/5g2CEq4lxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684269438; x=1686861438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Mgv2eOlGj/h9MwpBTlxreNYaXJNzFwMprpBEmpknKc=;
        b=mCZ7EWdXCY4/gTrbUfaWmCeBXJ3yO1oLKChXB22dFUjHuRS2i1tZN1dsoBGv1Zvo7O
         +bXw2psYGMEYRk97ecFvNaEBPAR8Hr792jEuJ95p1L3iQZ1FNgT2LtlwdKhPmg5+WTvq
         GdbfJUFVKoc8qC2fGjY22vLOCTXit+xhxN+tWoh+3R0WLMuQUKdYLY0xFdfAyycCYJsO
         RcULPyUkOrWKjSNF4GPEDa6LW91E4hfWV+SU/uBm/jRSFaews3/4zrB3LnoDfOS5ipcE
         oTdlL1AeuooHvRPNeaGh89DNbfHlQjwHu2oVSmOqfMRXbKIh29Ut8/8vkP3O6eEAr7fL
         WAKw==
X-Gm-Message-State: AC+VfDxWWgjFWUJ5J6yndmJPZFBkgwA4jzV+OfdVX4cCcsCRaFPJ1ByX
        0J0lK6cWZyWG5G9BAEC+Eo8itNcEt9l0yFJ16ZQ=
X-Google-Smtp-Source: ACHHUZ5jfYMLOvkx/dOXiqrfkGj2bp4cesBk6e+Y7hEdcYwmUwJUiReJK1XuEvKsidvpAxfkoLesqg==
X-Received: by 2002:a05:6a00:10cd:b0:645:fc7b:63d6 with SMTP id d13-20020a056a0010cd00b00645fc7b63d6mr37919796pfu.6.1684269438040;
        Tue, 16 May 2023 13:37:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b19-20020aa78713000000b00643355ff6a6sm14268576pfo.99.2023.05.16.13.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:37:17 -0700 (PDT)
Date:   Tue, 16 May 2023 13:37:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] vfs: Replace all non-returning strlcpy with strscpy
Message-ID: <202305161331.6BA62FD@keescook>
References: <20230510221119.3508930-1-azeemshaikh38@gmail.com>
 <20230515-seenotrettung-variieren-10995fad7802@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515-seenotrettung-variieren-10995fad7802@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 09:50:25AM +0200, Christian Brauner wrote:
> On Wed, 10 May 2023 22:11:19 +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> > No return values were used, so direct replacement is safe.
> > 
> > [...]
> 
> I sincerely hope we'll be done with swapping out various string
> functions for one another at some point. Such patches always seems
> benign and straightforward but the potential for subtle bugs is
> feels rather high...

Agreed. The long-term goal is to remove "strlcpy"[1] and "strncpy"[2]
completely from the kernel, leaving only "strscpy". From there, I hope
to do a treewide change to scrub the kernel of the pattern:
	strscpy(fixed-sized-dest, fixed-sized-source, sizeof(fixed-size-dest))
and replace it with a much stricter "strcpy" that refuses to work on
dynamically sized arguments. This will get us away from the pointless
exercise of duplicating sizeof() arguments when the compiler can very
happily do it itself.

But doing the return value transitions (and padding checks) for strlcpy
and strncpy need to happen first. It's a long road.

> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.

Thanks!

-Kees

[1] https://github.com/KSPP/linux/issues/89
[2] https://github.com/KSPP/linux/issues/90

-- 
Kees Cook
