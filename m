Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0728C6EFB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbjDZTiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjDZTis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:38:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D543198C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 12:38:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9536df4b907so1419484566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682537925; x=1685129925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFQA6ltmpMBru5G5YdgB88Q73RhVYiSbzEcgxUrcch8=;
        b=dxwkfVxax/XQN9pj1Ll3nTKdox1n0nRTq+qFYGFawVpzwp45IvmoIg1k8+kNw/6asZ
         UAVA71MfBQ079w/Y7xeUiZjAr0Ur8xxK+02OWLABSyYKbG8gKs7ootJDcoOVByLgWWD4
         /hVpSdv8zPyHMF/yfXWUGv0U1cLr+Uxmvv27s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682537925; x=1685129925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFQA6ltmpMBru5G5YdgB88Q73RhVYiSbzEcgxUrcch8=;
        b=bcArKggXOvI43aLckJuzSU0hemNuVGjq72MmQocjKNVPSYgdwVQsnlFGGKXz8XTlcp
         u7eBUNjjkTtfT5zdI0fEpd94ycE1MjOVTbc2Cq+uKjlghrOtwhlWndvFfKoirkynsaWJ
         Ai51sZcp2TWcVGOVIVGw2kE7FxKo38Bi8OG/SmizyGdfouwqunfnyaDSbGo7uMpVS00i
         83Kp3m7QanwDuXLoUqxLQHW2cOwcn5mrLM9T0XrdXBbhnwAoeO3yVH6HzGpQTniEC/eh
         DShZvMrqT+EQam158jiXS0Em/XPQmiy/qBfkfnT7WaxG6esPChSZ1eDUQYTcZRUhW/qV
         vLFA==
X-Gm-Message-State: AC+VfDxXdQf9yDej+RD0WuYGYBZDOPIAnQ2RD7uiZsbC8sHtImh1M7rZ
        SENdXEyRkBhFKQdKWKAq4Q/rCSCtG5O0aCUams3cdA==
X-Google-Smtp-Source: ACHHUZ6Ess+GiM1112VU+JbirOc840UfhJfxpu/RXt4N4QCn8ksw3Ycx7wLFQWwYL5W2tQaq8lTn9w==
X-Received: by 2002:a17:907:9b88:b0:958:801b:9945 with SMTP id kq8-20020a1709079b8800b00958801b9945mr3278044ejc.31.1682537924660;
        Wed, 26 Apr 2023 12:38:44 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id g13-20020a170906348d00b0095337c5da35sm8727022ejb.15.2023.04.26.12.38.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 12:38:43 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-956ff2399b1so1343706066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 12:38:43 -0700 (PDT)
X-Received: by 2002:a17:906:c416:b0:953:37eb:7727 with SMTP id
 u22-20020a170906c41600b0095337eb7727mr17746802ejz.43.1682537923395; Wed, 26
 Apr 2023 12:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu> <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <ZEl3QmF1PYXKaBTz@casper.infradead.org>
In-Reply-To: <ZEl3QmF1PYXKaBTz@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Apr 2023 12:38:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOEAjUfjoL0UEv1uMV4YoE+3tEFktaBb51T_TUbSem2w@mail.gmail.com>
Message-ID: <CAHk-=wjOEAjUfjoL0UEv1uMV4YoE+3tEFktaBb51T_TUbSem2w@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dan Carpenter <error27@gmail.com>
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

On Wed, Apr 26, 2023 at 12:11=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> Unfortunately, I don't know that we have any buildbots that run smatch,
> and most developers don't, so it'll always be an after-the-fact patch

Yeah. The advantage of compiler warnings really is that they get
caught quicker and developers will react to them much better. They
might cause the code to be properly re-organized or rewritten to be
much nicer, for example.

The "trivial tree" kind of fixups for random other issues that get
noticed separately tend to be much more about "work around issue". It
might be the proper fix, of course, but it didn't end up being taken
into account when writing the code, so it often ends up being just a
"papering over the warning" kind of fix. Particularly since the person
trying to fix the problem generally isn't the main developer of that
code.

         Linus
