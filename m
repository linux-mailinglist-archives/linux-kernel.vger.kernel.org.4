Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED69720C8B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 02:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbjFCALE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 20:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbjFCALC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 20:11:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4285E1BF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 17:11:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96fe88cd2fcso369502466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 17:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685751059; x=1688343059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIfddwJGgEUnwUCFA5IlnKSK6V7h4JvROQevxAQzNhk=;
        b=OBdlPJDuwjSpuZdlD4x/b25JAvw5BWyMAwKwT/nWuWhQf9vP4WDTSfqzu8x561haJZ
         l7FpCRhW8SP8FI/F0l1Qn/F3sNvYhQR1VoYznI7GZN4WUOIXOvpGnv1QRxvZ7IBa6Ld4
         AyxzePI9NTDJSdlSYRECAEyNkH7vdRBYeqYM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685751059; x=1688343059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIfddwJGgEUnwUCFA5IlnKSK6V7h4JvROQevxAQzNhk=;
        b=RK3WkWou0JfWYs1De+UNbzoxnUp4I5TaR8Kh5095WxZHCIkn2daLC7Dkg83pE7H/Oo
         y/UQMuRPAIIin6R4l2kze75cy8UQ0aptNQveJVUBDxqLwFMIcFLa72qSvcF6tXqAV2/s
         DZt93ID/+/Q0Jhf7rbrmJFXwqfgA1NJ9t2lEUyBBm2uNffwpFTLelQEfnImOSJUONt4+
         n5sZcVQeVrnUQ+WqI9jMOAloAfSTm34s8tEllR0h4VvRYuhV/l9IMT/dmsuL0EnLc4gd
         wa1DlSAPfwd7BCC/lB70Q93NEq6vfZ/09qMXdTMUATIdhM6rsbTdrvhkLgPKsjlOPjgL
         nWfg==
X-Gm-Message-State: AC+VfDwnSp9+7KIKCt3R5TYxD/RBZUwUZdAkBun79tJ3B075O50KvQ5h
        cNixfDMF1caStYfEn2jiypMHPd4wy3Lmv7ygpiBwP4b8
X-Google-Smtp-Source: ACHHUZ6QyrkNW2naBQFHjrzAIAoUNU6uHIu6YpXLm5HuDii4Zq7EkVC0fG2xiVtgXEXugUbJyGoOMw==
X-Received: by 2002:a17:907:703:b0:96f:9963:81ee with SMTP id xb3-20020a170907070300b0096f996381eemr93554ejb.50.1685751059521;
        Fri, 02 Jun 2023 17:10:59 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id u12-20020a1709060b0c00b009749b769c95sm1119673ejg.158.2023.06.02.17.10.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 17:10:59 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f6d7abe9a4so25490265e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 17:10:59 -0700 (PDT)
X-Received: by 2002:ac2:52ba:0:b0:4f2:7b65:baeb with SMTP id
 r26-20020ac252ba000000b004f27b65baebmr2458573lfm.53.1685750560415; Fri, 02
 Jun 2023 17:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com> <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
In-Reply-To: <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 20:02:23 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgCUzRNTg4fC8DF=UFnznK0M=mNUBDcsnLt7D4+HP2_1Q@mail.gmail.com>
Message-ID: <CAHk-=wgCUzRNTg4fC8DF=UFnznK0M=mNUBDcsnLt7D4+HP2_1Q@mail.gmail.com>
Subject: Re: [GIT PULL] Asymmetric keys fix for v6.4-rc5
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
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

On Fri, Jun 2, 2023 at 1:38=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The patch re-uses the allocation it already does for the key data, and
> it seems sane.

Ugh. I had to check that it was ok to re-use the key buffer, but it
does seem to be the case that you can just re-use the buffer after
you've done that crypto_akcipher_set_priv/pub_key() call, and the
crypto layer has to copy it into its own data structures.

I absolutely abhor the crypto interfaces. They all seem designed for
that "external DMA engine" case that seems so horrendously pointless
and slow.  In practice so few of them are that, and we have all those
optimized routines for doing it all on the CPU - but have in the
meantime wasted all that time and effort into copying everything,
turning simple buffers into sg-bufs etc etc. The amount of indirection
and "set this state in the state machine" is just nasty, and this
seems to all be a prime example of it all. With some of it then
randomly going through some kthread too.

I still think that patch is probably fine, but was also going "maybe
the real problem is in that library helper function
(asymmetric_verify(), in this case), which takes those (sig, siglen,
digest, digestlen) arguments and turns it into a 'struct
public_key_signature' without marshalling them.

Just looking at this mess of indirection and different "helper"
functions makes me second-guess myself about where the actual
conversion should be - while also feeling like it should never have
been done as a scatter-gather entry in the first place.

Anyway, I don't feel competent to decide if that pull request is the
right fix or not.

But it clearly is *a* fix.

            Linus
