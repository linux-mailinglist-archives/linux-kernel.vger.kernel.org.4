Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5D25FF470
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiJNURG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJNURD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:17:03 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B314F7D1F2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:17:00 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 67so5878693pfz.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d9uRIcoHHJz9/gFQgE1VQpj6K6kcy16s5GCXSPDSWz4=;
        b=HNA6dMTAcvloY9M5J90Db+W0xpQ45C2srAwJ1pL0+gxkF1JbTwXp/LqhGKlbAlzdTY
         60H49gCz+iDQL2gbl+RNuwngV0a+jL6REBC6XYZA9uj4YugIfa1EAIRrq7LuLMxKIPr5
         EADYMgZJgxiiTr+YVX9jbyIxvTOmyEhGq2Qw5NYLz0wi+4xjrukjgsVPfRK+wPIb/Rzr
         eD2FjSLtdx1xgHjxXU9QPMAzO99i1tydmNWzZ0XJ1GE49+EIE2xqDx6IhwxYRCQ5BMpS
         ikxj7fU7hZE59fz0AeWVV6mSRtSYH7O29VZbQMhyyfEqMbbnISu5W8IP5CgSj5OnMCR4
         W6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9uRIcoHHJz9/gFQgE1VQpj6K6kcy16s5GCXSPDSWz4=;
        b=r4zzeXq+cWO6LIVV5LvRC2tccWtiMPYBJNOJ/jJRD+WWSiBxXYq2gAVySBEbkC5u2F
         fKDv1vcQHk4SLht4U0JyVuer13BzHJIOhCoRR2eVjGMVqXUDdZPhtHnr22WGS4dwXntn
         4Cp4/s9rhD7j1W7TDY1Mo1QqhehvMPK9BphdV8L4gh+0ZNgdUFA0Lhth6ZskQ3YTnZdG
         se2eaX7pZkT9chBIXG5dxekxCze9btFEfhvUNhm7PYCH/0rOutPObu5FbzG4W1rcwv7k
         GMeEG49w0W+h6BE+PpCHrhqaJ4iuNCzWxa6nzo9xL9Wj8a5KwgAeQ7FN7aFaBBQOF/M1
         52dw==
X-Gm-Message-State: ACrzQf1EvQ/PS5PvgG2M6qQPWYbm434v75ySBfjyQBkFTPhgzKF0LXye
        +7fsagJmAWSSFuaFxrV6apGUMmGerVrwHNdm7B3zxQ==
X-Google-Smtp-Source: AMsMyM5xfbATi73WYV8RZgnDzrGNO9OZRqJyobu360Isyix61vSg0sq7gKJftcLC4q5SflGLTTLITg/mr1v7HdPS/ic=
X-Received: by 2002:a62:1a97:0:b0:562:5587:12d6 with SMTP id
 a145-20020a621a97000000b00562558712d6mr6952880pfa.37.1665778619944; Fri, 14
 Oct 2022 13:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221014201354.3190007-1-ndesaulniers@google.com>
In-Reply-To: <20221014201354.3190007-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Oct 2022 13:16:47 -0700
Message-ID: <CAKwvOdmio0+hq0wmoxySrGQW8fii860OYiLV-eebcPMkqKNoJw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] pass -march= only to compiler
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 1:14 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> When both -march= and -Wa,-march= are specified for assembler or
> assembler-with-cpp sources, GCC and Clang will prefer the -Wa,-march=
> value but Clang will warn that -march= is unused.
>
> warning: argument unused during compilation: '-march=armv6k'
> [-Wunused-command-line-argument]
>
> This is the top group of warnings we observe when using clang to
> assemble the kernel via `ARCH=arm make LLVM=1`.
>
> Arnd sent a v2 of my previous patch
> https://lore.kernel.org/linux-arm-kernel/20210928154143.2106903-14-arnd@kernel.org/
> I added yet a few more instances I found since then. Nathan pointed out
> a new one too that I've fixed since v3.
>
> Fixing this will allow us to enable
> -Werror=unused-command-line-argument for clang builds.
>
> v3 had an issue wrt. __thumb2__
> https://lore.kernel.org/llvm/CAKwvOdmkd2PxvMUZA=A-72eATGDZkqDj--Bv1W+Xt_K_LWdROA@mail.gmail.com/
> I've incorporated idea from Nathan and Ard on that.

I probably should have made a note: the base of this series is a
little funny.  It's based on today's linux-next (20221014) but with
0a7606a9832ab375a38425a659bda13712ca89ae reverted.  It sounds like
0a7606a9832ab375a38425a659bda13712ca89ae might be dropped from -next
imminently
https://lore.kernel.org/linux-next/CAK7LNARg8OpqLR_71PJV3ZoLuDV8+mz9mphg=CzEeEEMY0G3rw@mail.gmail.com/.
-- 
Thanks,
~Nick Desaulniers
