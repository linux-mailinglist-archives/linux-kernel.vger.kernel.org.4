Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0076F712C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242465AbjEZSd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbjEZSdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:33:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F971B3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:33:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96fb1642b09so156749666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685126023; x=1687718023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ptC6d5EWrHkNhGZSpOw3bJ7cmTKxwB6ClWZ/+djSvzY=;
        b=eYFz6zqj/vwbgy7UP5WJImuZ4iYtRRI4LjBh1R0qJ3PKOuE1/Y0pGxopCwTNwQo8ou
         yn5Hqd8FSTbBVJMzgnuvYl34BK+PP4ReYcxPgNEAzZ4N94bdAjrjVAq6WWp40kbqzVm0
         z9yftudF/WuyICoR9+XvIyLE3n02IHeoTZdlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126023; x=1687718023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptC6d5EWrHkNhGZSpOw3bJ7cmTKxwB6ClWZ/+djSvzY=;
        b=hWxyZuC8fjjbtBLgDC7wrMVqLpP3s54gknIb18x/A1s+3n45LHhACDjn+reVG/DOwA
         e/MvfcJXl6kAPc+V9vDAdDu5dhKYSIXA82FFNoOJqAPzyvSOaFTRYEst5AuiXCp9K5J9
         Av1GIvylvmge/e+lcW2/PEZ0lc4ZeyBm+6Sq1SPNfhUcfi/OFZSHsH4NnPebBtvvPc4L
         1WuCp5rEYtrBKlyuLxPFyOzGUlOEFa4qts/I4bDMbdScLHgXi4d4meFnrS+SNFS4lI+a
         rWFmL7KC30yIzAkEUKCF3ctSpuyi041FLLT5MmQZ2SzDxZ+p9o3w1JvDO+0e4ez7q3Lj
         lMag==
X-Gm-Message-State: AC+VfDwiulvQegXmpwUuBL76OVHddWyQuhl5sz7FU/unG2AJBEHq78H0
        YDZ11HuBVMjtr7QxTpURSKz10qEQyUqdiYESkHD9X6uK
X-Google-Smtp-Source: ACHHUZ77OnlZvXqx5MM6BJ+Aepwpe7lYbE/rFis1yMXoG1aIyerI7wUsQT6OhXVrF9PpVHlnfpd53Q==
X-Received: by 2002:a17:907:9411:b0:973:9857:b9b7 with SMTP id dk17-20020a170907941100b009739857b9b7mr2768029ejc.40.1685126023535;
        Fri, 26 May 2023 11:33:43 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id sa24-20020a170906edb800b0096595cc0810sm2457901ejb.72.2023.05.26.11.33.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 11:33:42 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51440706e59so1522681a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:33:42 -0700 (PDT)
X-Received: by 2002:a17:907:80b:b0:96f:9962:be19 with SMTP id
 wv11-20020a170907080b00b0096f9962be19mr2508836ejb.31.1685126022260; Fri, 26
 May 2023 11:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKUbyrJ=r2+_kK+sb2ZSSHifFZ7QkPLDpAtkJ8v4WUumA@mail.gmail.com>
 <CAHk-=whqNMUPbjCyMjyxfH_5-Xass=DrMkPT5ZTJbFrtU=qDEQ@mail.gmail.com>
 <CANn89i+bExb_P6A9ROmwqNgGdO5o8wawVZ5r3MHnz0qfhxvTtA@mail.gmail.com>
 <CAHk-=wig6VizZHtRznz7uAWa-hHWjrCNANZ9B+1G=aTWPiVH4g@mail.gmail.com>
 <CAHk-=whkci5ck5Him8Lx5ECKHEtj=bipYmOCGe8DWrrp8uDq5g@mail.gmail.com>
 <CAHk-=whtDupvWtj_ow11wU4_u=KvifTqno=5mW1VofyehjdVRA@mail.gmail.com>
 <CANn89i+u8jvfSQAQ=_JY0be56deJNhKgDWbqpDAvfm-i34qX9A@mail.gmail.com>
 <CAHk-=wh16fVwO2yZ4Fx0kyRHsNDhGddzNxfQQz2+x08=CPvk_Q@mail.gmail.com> <CANn89iJ3=OiZEABRQQLL6z+J-Wy8AvTJz6NPLQDOtzREiiYb4Q@mail.gmail.com>
In-Reply-To: <CANn89iJ3=OiZEABRQQLL6z+J-Wy8AvTJz6NPLQDOtzREiiYb4Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 May 2023 11:33:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZ23EHnBG4ox9QpHFDeiCSrA2H1wrYrfyg3KP=zK5Sog@mail.gmail.com>
Message-ID: <CAHk-=whZ23EHnBG4ox9QpHFDeiCSrA2H1wrYrfyg3KP=zK5Sog@mail.gmail.com>
Subject: Re: x86 copy performance regression
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000f5c99605fc9cf9b1"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f5c99605fc9cf9b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 10:51=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Hmmm
>
> [   25.532236] RIP: 0010:0xffffffffa5a85134
> [   25.536173] Code: Unable to access opcode bytes at 0xffffffffa5a8510a.

This was the other reason I really didn't want to use alternatives on
the conditional branch instructions. The relocations are really not
very natural, and we have odd rules for those things. So I suspect our
instruction rewriting simply gets this wrong, because that's such a
nasty pattern.

I really wanted my "just hardcode the instruction bytes" to work. Not
only did it get me the small 2-byte conditional jump, it meant that
there was no relocation on it. But objtool really hates not
understanding what the alternatives code does.

Which is fair enough, but it's frustrating here when it only results
in more problems.

Anyway, I guess *this* avoids all issues. It creates an extra jump to
a jump for the case where the CPU doesn't have ERMS, but I guess we
don't really care about those CPUs anyway.

And it avoids all the "alternative instructions have relocations"
issues. And it creates all small two-byte jumps, and the "rep movsb"
fits exactly on that same 2 bytes too. Which I guess all argues for
this being what I should have started with.

This time it *really* works.

Famous last words.

                Linus

--000000000000f5c99605fc9cf9b1
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_li4whxwl0>
X-Attachment-Id: f_li4whxwl0

IGFyY2gveDg2L2xpYi9jb3B5X3VzZXJfNjQuUyB8IDEwICsrKysrKysrKy0KIDEgZmlsZSBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9saWIvY29weV91c2VyXzY0LlMgYi9hcmNoL3g4Ni9saWIvY29weV91c2VyXzY0LlMKaW5kZXgg
NGZjNWMyZGUyZGU0Li4wMWM1ZGU0YzI3OWIgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2xpYi9jb3B5
X3VzZXJfNjQuUworKysgYi9hcmNoL3g4Ni9saWIvY29weV91c2VyXzY0LlMKQEAgLTcsNiArNyw4
IEBACiAgKi8KIAogI2luY2x1ZGUgPGxpbnV4L2xpbmthZ2UuaD4KKyNpbmNsdWRlIDxhc20vY3B1
ZmVhdHVyZXMuaD4KKyNpbmNsdWRlIDxhc20vYWx0ZXJuYXRpdmUuaD4KICNpbmNsdWRlIDxhc20v
YXNtLmg+CiAjaW5jbHVkZSA8YXNtL2V4cG9ydC5oPgogCkBAIC0yOSw3ICszMSw3IEBACiAgKi8K
IFNZTV9GVU5DX1NUQVJUKHJlcF9tb3ZzX2FsdGVybmF0aXZlKQogCWNtcHEgJDY0LCVyY3gKLQlq
YWUgLkx1bnJvbGxlZAorCWphZSAuTGxhcmdlCiAKIAljbXAgJDgsJWVjeAogCWphZSAuTHdvcmQK
QEAgLTY1LDYgKzY3LDEyIEBAIFNZTV9GVU5DX1NUQVJUKHJlcF9tb3ZzX2FsdGVybmF0aXZlKQog
CV9BU01fRVhUQUJMRV9VQSggMmIsIC5MY29weV91c2VyX3RhaWwpCiAJX0FTTV9FWFRBQkxFX1VB
KCAzYiwgLkxjb3B5X3VzZXJfdGFpbCkKIAorLkxsYXJnZToKKzA6CUFMVEVSTkFUSVZFICJqbXAg
Lkx1bnJvbGxlZCIsICJyZXAgbW92c2IiLCBYODZfRkVBVFVSRV9FUk1TCisxOglSRVQKKworICAg
ICAgICBfQVNNX0VYVEFCTEVfVUEoIDBiLCAxYikKKwogCS5wMmFsaWduIDQKIC5MdW5yb2xsZWQ6
CiAxMDoJbW92cSAoJXJzaSksJXI4Cg==
--000000000000f5c99605fc9cf9b1--
