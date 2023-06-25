Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A55373D2A7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 19:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjFYRJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 13:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFYRJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 13:09:46 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2F2100
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 10:09:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98e1b1d1698so126628466b.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 10:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687712983; x=1690304983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Jw6qaPWuA27aPchL3/WJhyWv6Gf8Myv0Ya6jO1rjVM=;
        b=N5LeUsXoSMuKK6cCsGwPTbLWZsO56nR2QqYv8oK7u695/YO/0O6S96wDhrW3+3ZRLi
         +cfU/Kyha5YDGp+3GSaGKWIBiysVUozDey8DbSBOaiqpFXVcznoqazumrFaAv0vsKa0u
         fIbNDgo4T0/5tfqo/Y58PrCnRqNAlP6mBNDrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687712983; x=1690304983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Jw6qaPWuA27aPchL3/WJhyWv6Gf8Myv0Ya6jO1rjVM=;
        b=It1W7ZUStVGd8lkgFTkV54+hVvUWlGa6EVyvNxH97SMmiWpWwZyaEn+WWPI5p1TvuL
         jNMO8j82vBOKaIcfdVEyMMuJgcHvTdNwDppbdQqG1Olzm1qM91XEA8JuLjTFcyyx3/3/
         i6LfhwmUctMXf5WX9MT1AtKBOZZJ8UJaF8zok6HIBHQnTyoLV6SPgWC0//32z8mYIeh+
         GG0Fp+r9KJadXQaHNqxgM/ohWD7V7Wwi77bv2CEyx0/Wz/OasdQA+cV0sW9+pScjwxJv
         WOrZVZW1dk1HljGPQXjpMV6BzbP3huvvLetdv/MOtBjfkTJfEAGU63sTVgDAINJZI9dI
         xAUQ==
X-Gm-Message-State: AC+VfDx+ZFVcnBZCXo+pFp5BVXJzHYCbhgs8Akh0vLsVx00IriOuviLI
        EUwcNZRrl1LZv47C6x7eH67WqE7lF7KUvDpF3kNeQYKi
X-Google-Smtp-Source: ACHHUZ573nk1nP3EdjayUOoif3GNH1XJdTFobIwFhKanenR1auN4UHyjdQI38vdC/+AYk7Ukb7lHXg==
X-Received: by 2002:a17:906:fe47:b0:989:3690:63e2 with SMTP id wz7-20020a170906fe4700b00989369063e2mr12014986ejb.36.1687712983386;
        Sun, 25 Jun 2023 10:09:43 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id ci8-20020a170906c34800b00988c0c175c6sm2256587ejb.189.2023.06.25.10.09.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 10:09:42 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-991c786369cso6147966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 10:09:42 -0700 (PDT)
X-Received: by 2002:a17:907:2da1:b0:988:7428:2c1a with SMTP id
 gt33-20020a1709072da100b0098874282c1amr21141968ejc.7.1687712982335; Sun, 25
 Jun 2023 10:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230625092842.GBZJgIyqJL/FtKW4nU@fat_crate.local>
In-Reply-To: <20230625092842.GBZJgIyqJL/FtKW4nU@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Jun 2023 10:09:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQsAB-5_9vF3Ok26=Wf55ayNJ80eMVVYtgrLZ-if5BVg@mail.gmail.com>
Message-ID: <CAHk-=wgQsAB-5_9vF3Ok26=Wf55ayNJ80eMVVYtgrLZ-if5BVg@mail.gmail.com>
Subject: Re: [GIT PULL] objtool/urgent for v6.4
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2023 at 02:28, Borislav Petkov <bp@alien8.de> wrote:
>
> - Add a ORC format hash to vmlinux and modules in order for other tools
>   which use it, to detect changes to it and adapt accordingly

Hmm. That "hash" is pretty horrendous. If I read that awk script
right, it will change for things like whitespace changes (or comment
changes) as long as they are around those magic #defines or the
'orc_entry' definition.

I've pulled this, but it all seems pretty random and hacky.

              Linus
