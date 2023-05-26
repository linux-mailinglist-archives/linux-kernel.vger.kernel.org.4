Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2107712B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242600AbjEZRRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbjEZRRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:17:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B78B194
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:17:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-973bf581759so167804666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685121442; x=1687713442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2SDbH8jwxHalkcPD4Gq6t9y7De5VNrdlKn9k4tsGfLw=;
        b=MW/im5IXrVqJSdFDGWSOK84wY4O3RxP+EURvoOQQHBAfvGOrslzA20/mwIm2C4u0kR
         cK1Txc+qhLf5IwZiqNXj9N3x0ArpC7dps9Loty59MDYPLbPFfsjG6ABnRd/nU0jPXleN
         FdPlR7eSep4csAWuqiHcaeA5bnNUKk4HKBh68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685121442; x=1687713442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SDbH8jwxHalkcPD4Gq6t9y7De5VNrdlKn9k4tsGfLw=;
        b=kGFNnTY1wRmf4747n3MfLaheSPvwWI2dx639LP03QVvp0deB1cX5Fuiux6co7Mr8Bd
         XIpHAfbVJMqzMgTvGo+cncRQzaGMilMyHtNxda/yMLY+R+nm4e+VigOoHBmyt9CnZlNW
         skHHYVJfrInto9xqPK3bEGbKXzROTrTyGa9Iwr7sfF0ptOFSxauh/80C+4drqvU2UuC7
         DovuWknQb9OEr9ZMm1ve+wNoHWnY2H1xjaC+7Qb83fNn08NEwflBWwsKGIeTbIEqrPdd
         J9QZt50kAWOwTGTONxnXKQ5K4JP/2IUNt2dAsWadgJXwvg7LJ6pqGiFYhb+lpvuMuyPN
         SBSQ==
X-Gm-Message-State: AC+VfDzvbEzsskapcWWzuBwJvf5Ow1nGmu4+6i97EkQzF29G04NrR6XB
        gnRUxV12V35kiY23t4O9c6bjo0Fdrl1IEyy2EI+0uhfi
X-Google-Smtp-Source: ACHHUZ7z4IbeciTxGpVkWIaypLiWdRUj7/FfdkAvvfqGzg8wUUsg5alvKtDWUio3Azg2AWvgynhGMg==
X-Received: by 2002:a17:907:94cf:b0:973:93d6:189f with SMTP id dn15-20020a17090794cf00b0097393d6189fmr2814275ejc.61.1685121441698;
        Fri, 26 May 2023 10:17:21 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906830f00b009661cf921b4sm2334131ejx.202.2023.05.26.10.17.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 10:17:21 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-973bf581759so167796466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:17:21 -0700 (PDT)
X-Received: by 2002:a17:907:2684:b0:969:e55f:cca2 with SMTP id
 bn4-20020a170907268400b00969e55fcca2mr2526701ejc.38.1685121440670; Fri, 26
 May 2023 10:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKUbyrJ=r2+_kK+sb2ZSSHifFZ7QkPLDpAtkJ8v4WUumA@mail.gmail.com>
 <CAHk-=whqNMUPbjCyMjyxfH_5-Xass=DrMkPT5ZTJbFrtU=qDEQ@mail.gmail.com>
 <CANn89i+bExb_P6A9ROmwqNgGdO5o8wawVZ5r3MHnz0qfhxvTtA@mail.gmail.com>
 <CAHk-=wig6VizZHtRznz7uAWa-hHWjrCNANZ9B+1G=aTWPiVH4g@mail.gmail.com> <CAHk-=whkci5ck5Him8Lx5ECKHEtj=bipYmOCGe8DWrrp8uDq5g@mail.gmail.com>
In-Reply-To: <CAHk-=whkci5ck5Him8Lx5ECKHEtj=bipYmOCGe8DWrrp8uDq5g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 May 2023 10:17:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtDupvWtj_ow11wU4_u=KvifTqno=5mW1VofyehjdVRA@mail.gmail.com>
Message-ID: <CAHk-=whtDupvWtj_ow11wU4_u=KvifTqno=5mW1VofyehjdVRA@mail.gmail.com>
Subject: Re: x86 copy performance regression
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000e02ff905fc9be809"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e02ff905fc9be809
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 10:00=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let me go look at it some more. I *really* didn't want to make the
> code worse for ERMS

Oh well. I'll think about it some more in the hope that I can come up
with something clever that doesn't make objtool hate me, but in the
meantime let me just give you the "not clever" patch.

It generates an annoying six-byte jump when the small 2-byte one would
work just fine, but I guess only my pride is wounded.

              Linus

--000000000000e02ff905fc9be809
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_li4tsaq50>
X-Attachment-Id: f_li4tsaq50

IGFyY2gveDg2L2xpYi9jb3B5X3VzZXJfNjQuUyB8IDEwICsrKysrKysrKy0KIDEgZmlsZSBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9saWIvY29weV91c2VyXzY0LlMgYi9hcmNoL3g4Ni9saWIvY29weV91c2VyXzY0LlMKaW5kZXgg
NGZjNWMyZGUyZGU0Li43ZTk3MjIyNGIwYmEgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2xpYi9jb3B5
X3VzZXJfNjQuUworKysgYi9hcmNoL3g4Ni9saWIvY29weV91c2VyXzY0LlMKQEAgLTcsNiArNyw4
IEBACiAgKi8KIAogI2luY2x1ZGUgPGxpbnV4L2xpbmthZ2UuaD4KKyNpbmNsdWRlIDxhc20vY3B1
ZmVhdHVyZXMuaD4KKyNpbmNsdWRlIDxhc20vYWx0ZXJuYXRpdmUuaD4KICNpbmNsdWRlIDxhc20v
YXNtLmg+CiAjaW5jbHVkZSA8YXNtL2V4cG9ydC5oPgogCkBAIC0yOSw3ICszMSw3IEBACiAgKi8K
IFNZTV9GVU5DX1NUQVJUKHJlcF9tb3ZzX2FsdGVybmF0aXZlKQogCWNtcHEgJDY0LCVyY3gKLQlq
YWUgLkx1bnJvbGxlZAorCWFsdGVybmF0aXZlICJqYWUgLkx1bnJvbGxlZCIsICJqYWUgLkxsYXJn
ZSIsIFg4Nl9GRUFUVVJFX0VSTVMKIAogCWNtcCAkOCwlZWN4CiAJamFlIC5Md29yZApAQCAtNjUs
NiArNjcsMTIgQEAgU1lNX0ZVTkNfU1RBUlQocmVwX21vdnNfYWx0ZXJuYXRpdmUpCiAJX0FTTV9F
WFRBQkxFX1VBKCAyYiwgLkxjb3B5X3VzZXJfdGFpbCkKIAlfQVNNX0VYVEFCTEVfVUEoIDNiLCAu
TGNvcHlfdXNlcl90YWlsKQogCisuTGxhcmdlOgorMDoJcmVwIG1vdnNiCisxOglSRVQKKworICAg
ICAgICBfQVNNX0VYVEFCTEVfVUEoIDBiLCAxYikKKwogCS5wMmFsaWduIDQKIC5MdW5yb2xsZWQ6
CiAxMDoJbW92cSAoJXJzaSksJXI4Cg==
--000000000000e02ff905fc9be809--
