Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054A0745567
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjGCGUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjGCGUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:20:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D68DCE
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 23:20:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992dcae74e0so336219966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 23:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688365236; x=1690957236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=njL/pkqD0wFEARNotrOahHhu0shD1jmNUKbDzIRDOno=;
        b=GDb4pp8vMEFb/sigNCKrU9awqE8pQKtWwQD9Q9WC1hjo1uRuQdZ+uZFV1oP2qvM5Qg
         NGzkrLL1HA+7OJHatNPOm4MAmVyCFb6Rn+kKjOtuSCpnU/LPcfj8gam/geYK86izhaTN
         0UZMaoiW33zh87RmbeH8Uobo3ZQPfJkfUmLMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688365236; x=1690957236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njL/pkqD0wFEARNotrOahHhu0shD1jmNUKbDzIRDOno=;
        b=l00jLX4rB7EV5Lcm7IGaOzFgVA2gQqi1dWMFi8bdYuvfmjt3V4AehbckTMOsf+lB0I
         V64bNRDVV0Q9MQ8qGxPYQDa0N0ja++cJKoW84CLYN8Bugp83gIezUF+/Jz4PeQL9p7ZB
         14JKsixHKb+UBROzOJeYMhkv7sJRqMFeU5buM9rnqb+5fNj/hQnWJSoJp9XSMACM2fsl
         +O200cA8vYQivEkm7m4jHST7KgnWRTEu926NirikvoUS6jHv/Lrn/herO01SnIuoDokX
         XuwgMPQguFaY5GYcJnZtyOYcDY3npAjKJjIXKl4Cv/9/P8LTOlJriE6oX6KijuPJEb/k
         XUPg==
X-Gm-Message-State: ABy/qLYgWrRxkb4prrwT+SrQaV3wv+B4GHcTlIIOkpkZQcoWhy954gw6
        ZMYedr1vS17VQzp7KA3rG4Qi9xHyA/HcKjVEXU7uCxXF
X-Google-Smtp-Source: APBJJlFsv12Xtl3LJFemRxVasaI44wS3xo2v7NFB21itfL304tYNpQZrKJjtU13z1fwY5y/J5rN3tw==
X-Received: by 2002:a17:907:9850:b0:993:3556:b7ed with SMTP id jj16-20020a170907985000b009933556b7edmr3413204ejc.6.1688365235651;
        Sun, 02 Jul 2023 23:20:35 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a12-20020a1709064a4c00b009932337747esm2907142ejv.86.2023.07.02.23.20.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 23:20:34 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51d80d81d6eso4730866a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 23:20:34 -0700 (PDT)
X-Received: by 2002:aa7:c50a:0:b0:51d:b75e:30ee with SMTP id
 o10-20020aa7c50a000000b0051db75e30eemr6196854edq.40.1688365234031; Sun, 02
 Jul 2023 23:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <2023063001-overlying-browse-de1a@gregkh> <0b2aefa4-7407-4936-6604-dedfb1614483@gmx.de>
 <5fd98a09-4792-1433-752d-029ae3545168@gmx.de> <CAHk-=wiHs1cL2Fb90NXVhtQsMuu+OLHB4rSDsPVe0ALmbvZXZQ@mail.gmail.com>
 <CAHk-=wj=0jkhj2=HkHVdezvuzV-djLsnyeE5zFfnXxgtS2MXFQ@mail.gmail.com>
 <9b35a19d-800c-f9f9-6b45-cf2038ef235f@roeck-us.net> <CAHk-=wgdC6RROG145_YB5yWoNtBQ0Xsrhdcu2TMAFTw52U2E0w@mail.gmail.com>
 <2a2387bf-f589-6856-3583-d3d848a17d34@roeck-us.net> <CAHk-=wgczy0dxK9vg-YWbq6YLP2gP8ix7Ys9K+Mr=S2NEj+hGw@mail.gmail.com>
 <c21e8e95-3353-fc57-87fd-271b2c9cc000@roeck-us.net>
In-Reply-To: <c21e8e95-3353-fc57-87fd-271b2c9cc000@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Jul 2023 23:20:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+F8oGK_Hx6YSPJpwL-xyL+-q2SxtxYE0abtZa_jSkLw@mail.gmail.com>
Message-ID: <CAHk-=wj+F8oGK_Hx6YSPJpwL-xyL+-q2SxtxYE0abtZa_jSkLw@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Helge Deller <deller@gmx.de>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John David Anglin <dave.anglin@bell.net>
Content-Type: multipart/mixed; boundary="0000000000000716a505ff8f2a26"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000716a505ff8f2a26
Content-Type: text/plain; charset="UTF-8"

On Sun, 2 Jul 2023 at 22:33, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Here you are:
>
> [   31.188688] stack expand failed: ffeff000-fff00000 (ffefeff2)

Ahhah!

I think the problem is actually ridiculously simple.

The thing is, the parisc stack expands upwards. That's obvious. I've
mentioned it several times in just this thread as being the thing that
makes parisc special.

But it's *so* obvious that I didn't even think about what it really implies.

And part of all the changes was this part in expand_downwards():

        if (!(vma->vm_flags & VM_GROWSDOWN))
                return -EFAULT;

and that will *always* fail on parisc, because - as said multiple
times - the parisc stack expands upwards. It doesn't have VM_GROWSDOWN
set.

What a dum-dum I am.

And I did it that way because the *normal* stack expansion obviously
wants it that way and putting the check there not only made sense, but
simplified other code.

But fs/execve.c is special - and only special for parisc - in that it
really wants to  expand a normally upwards-growing stack downwards
unconditionally.

Anyway, I think that new check in expand_downwards() is the right
thing to do, and the real fix here is to simply make vm_flags reflect
reality.

Because during execve, that stack that will _eventually_ grow upwards,
does in fact grow downwards.  Let's make it reflect that.

We already do magical extra setup for the stack flags during setup
(VM_STACK_INCOMPLETE_SETUP), so extending that logic to contain
VM_GROWSDOWN seems sane and the right thing to do.

IOW, I think a patch like the attached will fix the problem for real.

It needs a good commit log and maybe a code comment or two, but before
I bother to do that, let's verify that yes, it does actually fix
things.

In the meantime, I will actually go to bed, but I'm pretty sure this is it.

                     Linus

--0000000000000716a505ff8f2a26
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ljmh1mnt0>
X-Attachment-Id: f_ljmh1mnt0

IGluY2x1ZGUvbGludXgvbW0uaCB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW0uaCBiL2lu
Y2x1ZGUvbGludXgvbW0uaAppbmRleCA3NGYxYmU3NDNiYTIuLjJkZDczZTRmM2Q4ZSAxMDA2NDQK
LS0tIGEvaW5jbHVkZS9saW51eC9tbS5oCisrKyBiL2luY2x1ZGUvbGludXgvbW0uaApAQCAtMzc3
LDcgKzM3Nyw3IEBAIGV4dGVybiB1bnNpZ25lZCBpbnQga29ianNpemUoY29uc3Qgdm9pZCAqb2Jq
cCk7CiAjZW5kaWYgLyogQ09ORklHX0hBVkVfQVJDSF9VU0VSRkFVTFRGRF9NSU5PUiAqLwogCiAv
KiBCaXRzIHNldCBpbiB0aGUgVk1BIHVudGlsIHRoZSBzdGFjayBpcyBpbiBpdHMgZmluYWwgbG9j
YXRpb24gKi8KLSNkZWZpbmUgVk1fU1RBQ0tfSU5DT01QTEVURV9TRVRVUAkoVk1fUkFORF9SRUFE
IHwgVk1fU0VRX1JFQUQpCisjZGVmaW5lIFZNX1NUQUNLX0lOQ09NUExFVEVfU0VUVVAgKFZNX1JB
TkRfUkVBRCB8IFZNX1NFUV9SRUFEIHwgVk1fU1RBQ0tfRUFSTFkpCiAKICNkZWZpbmUgVEFTS19F
WEVDICgoY3VycmVudC0+cGVyc29uYWxpdHkgJiBSRUFEX0lNUExJRVNfRVhFQykgPyBWTV9FWEVD
IDogMCkKIApAQCAtMzk5LDggKzM5OSwxMCBAQCBleHRlcm4gdW5zaWduZWQgaW50IGtvYmpzaXpl
KGNvbnN0IHZvaWQgKm9ianApOwogCiAjaWZkZWYgQ09ORklHX1NUQUNLX0dST1dTVVAKICNkZWZp
bmUgVk1fU1RBQ0sJVk1fR1JPV1NVUAorI2RlZmluZSBWTV9TVEFDS19FQVJMWQlWTV9HUk9XU0RP
V04KICNlbHNlCiAjZGVmaW5lIFZNX1NUQUNLCVZNX0dST1dTRE9XTgorI2RlZmluZSBWTV9TVEFD
S19FQVJMWQkwCiAjZW5kaWYKIAogI2RlZmluZSBWTV9TVEFDS19GTEFHUwkoVk1fU1RBQ0sgfCBW
TV9TVEFDS19ERUZBVUxUX0ZMQUdTIHwgVk1fQUNDT1VOVCkK
--0000000000000716a505ff8f2a26--
