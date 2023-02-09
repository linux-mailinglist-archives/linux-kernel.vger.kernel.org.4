Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3668FFE7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBIFcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBIFcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:32:19 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D04301B5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 21:32:18 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r2so615597wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 21:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w6z3lxwnln7Ypie34pRxdCgfXQDUlJU7iUw2s4xeNCQ=;
        b=hbv+iUmy8sb7UTevXZXSzxz4aaIUDG/plNczLQrgAbId4wPVrQ+MkUcq3aY+CY5S+3
         rjawt/atll9AOMzPTfCwmorE8mJ0IW4ExC+pOffnmttwon2NgCXsQXAHNH70+CqH4Yet
         b6oLh+gnKxDrXWJ+sVkEhlEAuMsgo82g7kQbD0bRtom8ONxlwBf6CsHrI8kEQQPSr8cE
         02FslNpxxsQJnKXlRV77g9pOv1nepBqVy0+lQY1q5jHCyV3MZ1/poYrNBSof/aw2ifvB
         XBsmv3sQsOevFgU/eI4a8Lch+EluHrUqqffry2uORieqI42qXv+KNAZGRuXumHYaK8Mh
         FeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6z3lxwnln7Ypie34pRxdCgfXQDUlJU7iUw2s4xeNCQ=;
        b=qCwSorlHd7zBXEmQ9X9s0yUpoDCQ2iW0qTJSgVP4/o7JdCKVICY8ogd3rDzeffvteU
         9Yq0qh0BGH644vlHU85tf8V1fXNy0d1tg6wIJaRAWuNPZM/Q+xaQmBElihOprlBI7mP2
         eHT3rWSr5jVXuPKIyTrm0V8fyw3sGZIIGE0jiUlrgpbmUMC7N6ufT+1M8PBApeoVfNMu
         MYK+QKcdp70u1jD1WB6P9t+ofkO+vxHuwBd/HdvWJIRHE/W/N7ZPBC9irx9bNXKbNsOx
         8YC550KrrGNaVOZDl/2rAZNusFl1iR4t2aNxIQ2ms2xAtbY1e1cM7LEHDoN78zN7XGg1
         fXSw==
X-Gm-Message-State: AO0yUKVFYdKEkkB536HAT4hECzyXBt1ZlVYjmBDcFdioQj7si5AMzgeX
        EZm6WYNU/0tJMwIQdRPyNaw/eppi1Wi3/ks/7PHuIg==
X-Google-Smtp-Source: AK7set9YGa7NCNq2wHzwRqe7rRW1StB4rmp4kgxLGJELsL8k4ez/VaGVQujKbNDfKlqQkG5awGCGVr1ELO1GQ8rpFMA=
X-Received: by 2002:a5d:4247:0:b0:2bf:b264:6bf7 with SMTP id
 s7-20020a5d4247000000b002bfb2646bf7mr251486wrr.427.1675920736829; Wed, 08 Feb
 2023 21:32:16 -0800 (PST)
MIME-Version: 1.0
References: <20221219055431.22596-1-ashimida.1990@gmail.com>
In-Reply-To: <20221219055431.22596-1-ashimida.1990@gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 8 Feb 2023 21:32:03 -0800
Message-ID: <CAMn1gO6hwaSDCqigwoH981ffVbU8OvgJhrGh997kGseCSbpAJA@mail.gmail.com>
Subject: Re: [RFC/RFT 0/3] Add compiler support for Control Flow Integrity
To:     Dan Li <ashimida.1990@gmail.com>
Cc:     gcc-patches@gcc.gnu.org,
        Richard Sandiford <richard.sandiford@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
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

On Sun, Dec 18, 2022 at 10:06 PM Dan Li <ashimida.1990@gmail.com> wrote:
>
> This series of patches is mainly used to support the control flow
> integrity protection of the linux kernel [1], which is similar to
> -fsanitize=kcfi in clang 16.0 [2,3].
>
> I hope that this feature will also support user-mode CFI in the
> future (at least for developers who can recompile the runtime),
> so I use -fsanitize=cfi as a compilation option here.

Please don't. The various CFI-related build flags are confusing enough
without also having this inconsistency between Clang and GCC.

Peter
