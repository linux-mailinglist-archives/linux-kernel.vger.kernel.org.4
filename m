Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7616B6C84
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 00:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCLX0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 19:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCLX0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 19:26:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5831E2943C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:26:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x3so41838558edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678663594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7amGatuf567fWRNk3AylR5pwT0OyOTnaMCjO7lph9w=;
        b=I+hm1Wj25LW1lzjukQhpLqGWXB4x4lnS4GtOm8JZjWKcwuXPGsA0vpAI1zmfUPLYXM
         unOcRfx28HaiKX47cuJNWq3+Z2s10apUCqi4Lw6PO/4Rsm6jSiZZOI8Q3E3iMYIJR5w/
         4IX2iggxJFl8rNGeIIAe2cnRe1JujZmuIT8EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678663594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7amGatuf567fWRNk3AylR5pwT0OyOTnaMCjO7lph9w=;
        b=fS0XzRZbMsfUme06R/S3Gk+suXjpKLzMQi646rTkEyGcRSQZIizG6rDdTE20b9f3Rg
         IYMe+Ss6kDvbuMy9nyuPcSsFPk3XIbonQW4ylBdACcwNmUIMxMlAuXVcn6sgpJjw2kok
         7r8KohNtMbITrxLlTxzk/QFe4FOFe5guWxLmK/2M3khsaki0Em8vM0k/wRTltaF9xBxT
         dwxaSPs2Y8aEWPaKC6c/J8j4LFQbFLOPE6u2gIkfWkBwcWqPAC6eOMrfcr5bYCkb7GYz
         vViGUvi9ZMV04tiPJH4iKtzdA8EYVNnDJPwlBRoEEKe7IGpmmCGUOf7NBR0QQZr75dw8
         XkQw==
X-Gm-Message-State: AO0yUKWoUX3ERz8aSVEMouL9N/9JXeBi2szz6jN53o71lE8jal1QawSL
        x5Ogj/dY5EWKHFevP7ror+e5wbNSkfE0ZF+fXTcW5Q==
X-Google-Smtp-Source: AK7set9Gxg3Hya4lSFrUWQhtb5ltqpUoWCX8yCkv/R47eysUBs1xQ6PnGfzJXajx3t9Dlc32jkxkuw==
X-Received: by 2002:a17:907:962a:b0:92a:3709:e872 with SMTP id gb42-20020a170907962a00b0092a3709e872mr1099137ejc.19.1678663594596;
        Sun, 12 Mar 2023 16:26:34 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906395600b008b2aba5fb22sm2696646eje.206.2023.03.12.16.26.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 16:26:33 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id k10so41801408edk.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:26:33 -0700 (PDT)
X-Received: by 2002:a50:9992:0:b0:4fb:4a9f:eb18 with SMTP id
 m18-20020a509992000000b004fb4a9feb18mr1699488edb.5.1678663593229; Sun, 12 Mar
 2023 16:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230312200731.599706-1-masahiroy@kernel.org>
In-Reply-To: <20230312200731.599706-1-masahiroy@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Mar 2023 16:26:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgL-GspdmghwQ2kXJO1QCKFY+HieU0arYSFDHBLO0dZuA@mail.gmail.com>
Message-ID: <CAHk-=wgL-GspdmghwQ2kXJO1QCKFY+HieU0arYSFDHBLO0dZuA@mail.gmail.com>
Subject: Re: [PATCH 0/6] kbuild: fix some packaging issues, and use
 git-archive for source package
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 1:07=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> This series fixes some bugs, then switch to 'git archive'
> for source package creation as suggested by Linus.

Thanks, looks good.

Shouldn't we also revert e0ca16749ac3 ("kbuild: make perf-tar*-src-pkg
work without relying on git")?

           Linus
