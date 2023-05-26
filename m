Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C8D712E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbjEZUhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEZUhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:37:36 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA6134
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:37:35 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96fa4a6a79bso172152866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685133453; x=1687725453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKtb5pF799Vf0zYkpYw5rmcT4zTxO2bOf/EKOzgAhcY=;
        b=BOjN3c0mNuFLGaA8ph4Pbmp3phDLkFpEmpt7ob4g0VlG6IQxJqBcj42Dej6W8LeWYR
         ql3RVtPvRxVf9j9PQKQl4EQewjdi4lBNwKNHhGhgUYmGJWUfOpULkOnvq2WUbMUju49c
         XvBg68bgZ9/uoJaW3x1ZF5yJPaw1gS1utGf6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685133453; x=1687725453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKtb5pF799Vf0zYkpYw5rmcT4zTxO2bOf/EKOzgAhcY=;
        b=aYMP31XBEiNbCYz2c34ao73vL+NiqQ8AWPQs1k52b6I5h5nF/5FLgXIhPGwWM1VVhx
         sFYEWiU/el56UU1fLpYnOcoXaKEW8J12vbVGByVc+6W36GR8QkPA5BA4yrRuakRAgSBc
         kUI5phx6V2iPwYv8BF0EjsDMLjSYsZQAJAVSac5vfQ92Zk6XMthJ54Ed4025NBJ1LcgK
         FQ5NoR8aOJUT8Id+6SyFGbXYwDT/Lo/gW6IBhDv/yYWAUCxycpCQjKwsARCExBCj+Ahy
         r8WCEkdWwdn1C73+Igr96ydF+ivyVUUlFJKEaQb/9/T3CKq46I+/KtoTL99IQFLx1bgG
         55UQ==
X-Gm-Message-State: AC+VfDxJrs/JvEPoscpgM5BybpdPf0iOO0qDxdBEAT/j678nzCUNT5zz
        850MeTIyZ/Xkyeat/GuKS04m1Rw0RjMRHpWiHI1VsFwE
X-Google-Smtp-Source: ACHHUZ4c3J7U84KQkms9BhKCQFvNf5rQjGDOLDczSZHsoJP7pTkwv/m6n06rK5mss7YuR2BvfqkDEw==
X-Received: by 2002:a17:907:6d1d:b0:973:daaa:f3e1 with SMTP id sa29-20020a1709076d1d00b00973daaaf3e1mr393603ejc.39.1685133453682;
        Fri, 26 May 2023 13:37:33 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7d38f000000b005068fe6f3d8sm289651edq.87.2023.05.26.13.37.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 13:37:33 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-96652cb7673so174821266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:37:32 -0700 (PDT)
X-Received: by 2002:a17:907:3f92:b0:94e:dd30:54b5 with SMTP id
 hr18-20020a1709073f9200b0094edd3054b5mr3679061ejc.6.1685133452593; Fri, 26
 May 2023 13:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKUbyrJ=r2+_kK+sb2ZSSHifFZ7QkPLDpAtkJ8v4WUumA@mail.gmail.com>
 <CAHk-=whqNMUPbjCyMjyxfH_5-Xass=DrMkPT5ZTJbFrtU=qDEQ@mail.gmail.com>
 <CANn89i+bExb_P6A9ROmwqNgGdO5o8wawVZ5r3MHnz0qfhxvTtA@mail.gmail.com>
 <CAHk-=wig6VizZHtRznz7uAWa-hHWjrCNANZ9B+1G=aTWPiVH4g@mail.gmail.com>
 <CAHk-=whkci5ck5Him8Lx5ECKHEtj=bipYmOCGe8DWrrp8uDq5g@mail.gmail.com>
 <CAHk-=whtDupvWtj_ow11wU4_u=KvifTqno=5mW1VofyehjdVRA@mail.gmail.com>
 <CANn89i+u8jvfSQAQ=_JY0be56deJNhKgDWbqpDAvfm-i34qX9A@mail.gmail.com>
 <CAHk-=wh16fVwO2yZ4Fx0kyRHsNDhGddzNxfQQz2+x08=CPvk_Q@mail.gmail.com>
 <CANn89iJ3=OiZEABRQQLL6z+J-Wy8AvTJz6NPLQDOtzREiiYb4Q@mail.gmail.com> <CAHk-=whZ23EHnBG4ox9QpHFDeiCSrA2H1wrYrfyg3KP=zK5Sog@mail.gmail.com>
In-Reply-To: <CAHk-=whZ23EHnBG4ox9QpHFDeiCSrA2H1wrYrfyg3KP=zK5Sog@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 May 2023 13:37:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibWdTp-kdCKc-F3d4aVcHO40qqoxoATG+KhVivYE0TqA@mail.gmail.com>
Message-ID: <CAHk-=wibWdTp-kdCKc-F3d4aVcHO40qqoxoATG+KhVivYE0TqA@mail.gmail.com>
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

On Fri, May 26, 2023 at 11:33=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, I guess *this* avoids all issues. It creates an extra jump to
> a jump for the case where the CPU doesn't have ERMS, but I guess we
> don't really care about those CPUs anyway.

Well, I'm obviously wrong, because my very own CPU (AMD Zen 2) doesn't do E=
RMS.

But the extra 'jmp' doesn't seem to appreciably matter, so I guess I
don't care. It does show up in profiles, but only barely.

I've committed and pushed out the fix.

               Linus
