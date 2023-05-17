Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5329A706E59
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjEQQkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEQQkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:40:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0E735A5
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:40:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9659443fb56so146170966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684341600; x=1686933600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUiZh9vX79/8GlRHS85iCL0x+Okzafu2CQZl4ySfqrA=;
        b=hJSArDsACQfgIfZm5gUboXLfaag3Cc98UHAkpAcbwjSjIyOWcTjMzYULTRwkLUsTBc
         Q6moqtReX3RXB65vJn4njVt1VF18bbqLOFraNA9bXXXFXhtZu7AqZ8icPXS/yqMHtGN0
         4E+pzVP7uoj7+5A2t9EcRD7+lOjwJP7YYHZoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684341600; x=1686933600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUiZh9vX79/8GlRHS85iCL0x+Okzafu2CQZl4ySfqrA=;
        b=du8x7E8yMANvF65e3Za1Yedo03RnCKU1MXT/8JsMA7b4dUR09s4tkNScrzeT5VeGR2
         lR1AGvj15krGm04mFx9sL2Gu2HNluTG55Hj1+CnQQj6wIHqwsxfWRnkfb9OzTXE42lHE
         /K2dABbj5RMdJqQ33v9f+1/W5poiBxJ3u2psW2k6ddNhOT/c46D33JuBaUWhqa0p312D
         q94M5lpHwrZxqlqle7OEobOj/kIZNz+BB6IqvC+pVjE7EriI183OSyEJ/6fgsWU7zRJG
         1o/me5mp5XwU+H6IlT1RobJeCr3va3Ar5qC04LHlqAZLRPa0sHQf73XzNT1F5Dki+2V3
         5djw==
X-Gm-Message-State: AC+VfDzRoOoAaw+0LM1G6/tv5Kqcerygh3DJi5GzzAg3hAkt/MMfmECS
        pcmwtuqmf+A5MmzGdzg3roaC8ppP9s8cSb1bAo8xtBAB
X-Google-Smtp-Source: ACHHUZ5rxne+lY6ohHdB6vH2wMqER+MwFFqMhVvH+85eU7d8XbUOqN+gLUMXmGgSnPuIrOLzDmSEsw==
X-Received: by 2002:a17:907:868f:b0:969:f9e8:a77c with SMTP id qa15-20020a170907868f00b00969f9e8a77cmr31038204ejc.64.1684341599898;
        Wed, 17 May 2023 09:39:59 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id d1-20020a170907272100b0094bb4c75695sm12593048ejl.194.2023.05.17.09.39.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 09:39:59 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9659443fb56so146166666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:39:59 -0700 (PDT)
X-Received: by 2002:a17:907:868f:b0:969:f9e8:a77c with SMTP id
 qa15-20020a170907868f00b00969f9e8a77cmr31038132ejc.64.1684341598769; Wed, 17
 May 2023 09:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230517124721.929540-1-arnd@kernel.org>
In-Reply-To: <20230517124721.929540-1-arnd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 09:39:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+129KAcegJqvo2PKPUK3yw5qQwF0LcHofdT0bPbs8iQ@mail.gmail.com>
Message-ID: <CAHk-=wh+129KAcegJqvo2PKPUK3yw5qQwF0LcHofdT0bPbs8iQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: make ftrace_likely_update() declaration visible
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 5:47=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This function is only used when CONFIG_TRACE_BRANCH_PROFILING is
> set, and the declaration is hidden behind this Kconfig symbol,
> which causes a warning if disabled:

That explanation is not very clear.

The problem is that the tracing code itself is built with
DISABLE_BRANCH_PROFILING, in order to not recurse. And that hides the
declaration when the definition is compiled, leading to the problem.

CONFIG_TRACE_BRANCH_PROFILING isn't the problem in itself - *that*
part of the test is consistent (not used, not declared, and not
compiled if it is off).

The problem is that DISABLE_BRANCH_PROFILING case, where it is used
elsewhere, but not declared when it is itself compiled.

I applied the patch, but I tried to reword the explanation to be more
clear. I may have failed.

          Linus
