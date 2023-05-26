Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AC5712B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjEZRAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjEZRAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:00:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB7ABC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:00:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5147a478c38so1104922a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685120441; x=1687712441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOgQ0laylSsSXUxakhP+bdUPB6O0yALSW2XM6n3Lc/w=;
        b=hliNns/chJslYVsVGRU+ritAEJisLgPdTxqVtavxwK8qQ2f0id+NYmHbVOalnhRN9X
         6RLID1TER8bJA8RJsoegGq3v8W5Uck5q3lDYkVgJ4XsG6tru4e7g+BKvd58o/nz/QR5g
         sL/n0rAKWopq/dG1onDOdKTLqCwetL6Czhh7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685120441; x=1687712441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOgQ0laylSsSXUxakhP+bdUPB6O0yALSW2XM6n3Lc/w=;
        b=GpDU1W9cbxAKMEh3XulQHkEIjNMA6H8JWZJooo9CsIe3/fR/CUBt+zXOeEytYN9kOS
         VeLVwek+iPre4RJ2AYba61BsNWjZj4JCmTsZJdFwQ/R23EfFkI+rTHTZiIBc65fIL3UW
         a1GlZzlDGPaJJx0IuLAOCMIfHbohCnd6rFV9qkRX1TzDVIrbtZS9imB2ZWeqGj6FHpEK
         slqSlYmfySohp5MkGFn/6YqpRJb2U2TudR+LXrC6W1Ds/H/ryYHpZRdJmCaB0I3IPbzw
         DMQS673nqwM9+Bm1nZZ5xAI0orQHb4VV30ON3f1m9JoxXABwm36FEELdHexBksu+yeIN
         1NEg==
X-Gm-Message-State: AC+VfDx+0fjfLlRcQbgiSiuaKRFhAuGXIYeSkoDwgqwq2BLoy6La7Ig5
        LUdndLsQ4HYqD9ZPQMPniCl85Yeh/6Weq6WmiJhihMIv
X-Google-Smtp-Source: ACHHUZ5PmoBaJEhw3SuIvdzsoPDpBW++xrYH36vVcpWyQKBeqfSNOIiyrA/UYFQRL/sATKhC0wK8Gg==
X-Received: by 2002:a17:907:3f8d:b0:966:61b3:f630 with SMTP id hr13-20020a1709073f8d00b0096661b3f630mr3191578ejc.9.1685120440661;
        Fri, 26 May 2023 10:00:40 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id c7-20020a170906154700b00965ec1faf27sm2358483ejd.74.2023.05.26.10.00.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 10:00:39 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso994870a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:00:39 -0700 (PDT)
X-Received: by 2002:a17:907:94c9:b0:968:db2f:383 with SMTP id
 dn9-20020a17090794c900b00968db2f0383mr2744712ejc.53.1685120439249; Fri, 26
 May 2023 10:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKUbyrJ=r2+_kK+sb2ZSSHifFZ7QkPLDpAtkJ8v4WUumA@mail.gmail.com>
 <CAHk-=whqNMUPbjCyMjyxfH_5-Xass=DrMkPT5ZTJbFrtU=qDEQ@mail.gmail.com>
 <CANn89i+bExb_P6A9ROmwqNgGdO5o8wawVZ5r3MHnz0qfhxvTtA@mail.gmail.com> <CAHk-=wig6VizZHtRznz7uAWa-hHWjrCNANZ9B+1G=aTWPiVH4g@mail.gmail.com>
In-Reply-To: <CAHk-=wig6VizZHtRznz7uAWa-hHWjrCNANZ9B+1G=aTWPiVH4g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 May 2023 10:00:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkci5ck5Him8Lx5ECKHEtj=bipYmOCGe8DWrrp8uDq5g@mail.gmail.com>
Message-ID: <CAHk-=whkci5ck5Him8Lx5ECKHEtj=bipYmOCGe8DWrrp8uDq5g@mail.gmail.com>
Subject: Re: x86 copy performance regression
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
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

On Fri, May 26, 2023 at 9:56=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ahh, I tested it in an allmodconfig build, but only building that one
> file, and not trying to link it. And gas was apparent;y perfectly
> happy just leaving that undefined feature as a relocation.

Oh, never mind. Even with that fixed, objtool is very unhappy about my
hack, because it knows about short jumps, and despite me encoding it
as a sequence of bytes, objtool will just decode it anyway and say
"that's not right".

Grr, I tried so hard to get the exact asm I wanted, but our
sanity-checking catches my cleverness and stops me in my tracks.

Let me go look at it some more. I *really* didn't want to make the
code worse for ERSM.

             Linus
