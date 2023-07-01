Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760717445D5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 03:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjGABZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 21:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGABZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 21:25:10 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33C63C17
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 18:25:08 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso41047211fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 18:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688174707; x=1690766707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lmQawnZPImWl2SD6T1qGl5AoepWm79fi28WZcuSJ8jI=;
        b=CeeRsZxNqGnlFJT4guVDZstK431AVoetj5Wo0bUwttuvdnpDWCUZiKrL5GXNA0teOQ
         rzEivXMYhoaGjcyv6/7dM76yS+gTa9VWgcjz56Mqjy8ngXvb08ZIWaN97ZRqNG+sgLEc
         9xmRfqJYhyVRx4a5/e2Plnh2V5zvctk3CJQTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688174707; x=1690766707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmQawnZPImWl2SD6T1qGl5AoepWm79fi28WZcuSJ8jI=;
        b=L+FXp/TY8GvjRi/+OgphYRyePmS3lSbXf9CYhBjvgIXUe7GUH0Y1L4a1zR8uCC+gqx
         C/7JzQok4N+0b6P70GcfHIuqVTFX21NrHZYCiTyuNFJXccDlGAxYbGOMr28l047pJTXw
         AmZhFACKa8/Bz89wQFXVWvbi+Z4GICIeaClRBn63zJm/EyvQa4U/pGSiRBHbPg2t2akx
         5mEVI7ZtYM5AU5igwKetIkmW9UsvL+fYxN5Mu5UkcPvUi51HmfduXZnKmkH35mLUud+W
         zFTuryXWhPxYPPMrnQfhBH6hr9BCIpqAa5bOFbAkTZhlIz+saT4qjA7WuatXVTTRjZFd
         bKrg==
X-Gm-Message-State: ABy/qLbuFIs0lgHc7X3/8LGaUHE6HKPG9N8LcLoCrYm/2+8vTGwjq206
        hLhDI+W1RRW6HH6WFLB9Z/9D2ftq0aGDoYDthBfB4RGU
X-Google-Smtp-Source: APBJJlGhd17FeNXgZ/5BCA3JfMMNf/wh2vfIB5cvFkdGtHyKDtmPjQm/I5T7NS64WeX5GNc582bkvw==
X-Received: by 2002:a2e:9350:0:b0:2b6:a0cd:ba6 with SMTP id m16-20020a2e9350000000b002b6a0cd0ba6mr3145974ljh.33.1688174707099;
        Fri, 30 Jun 2023 18:25:07 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id d9-20020a2e3309000000b002b6da1b49c6sm266185ljc.52.2023.06.30.18.25.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 18:25:06 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f122ff663eso4097563e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 18:25:06 -0700 (PDT)
X-Received: by 2002:a05:6512:2010:b0:4f8:e4e9:499e with SMTP id
 a16-20020a056512201000b004f8e4e9499emr2999983lfb.12.1688174706280; Fri, 30
 Jun 2023 18:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net> <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
 <CAHk-=wiN5H-2dh2zCo_jXE7_ekrxSHvQcMw4xfUKjuQs2=BN4w@mail.gmail.com> <fb63ea7b-c44b-fb1b-2014-3d23794fa896@roeck-us.net>
In-Reply-To: <fb63ea7b-c44b-fb1b-2014-3d23794fa896@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jun 2023 18:24:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whh_aUHYF6LCV36K9NYHR4ofEZ0gwcg0RY5hj=B7AT4YQ@mail.gmail.com>
Message-ID: <CAHk-=whh_aUHYF6LCV36K9NYHR4ofEZ0gwcg0RY5hj=B7AT4YQ@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Jason Wang <wangborong@cdjrlc.com>
Content-Type: multipart/mixed; boundary="000000000000b0e4fd05ff62cd63"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b0e4fd05ff62cd63
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Jun 2023 at 15:51, Guenter Roeck <linux@roeck-us.net> wrote:
>
> There is one more, unfortunately.
>
> Building xtensa:de212:kc705-nommu:nommu_kc705_defconfig ... failed

Heh. I didn't even realize that anybody would ever do
lock_mm_and_find_vma() code on a nommu platform.

With nommu, handle_mm_fault() will just BUG(), so it's kind of
pointless to do any of this at all, and I didn't expect anybody to
have this page faulting path that just causes that BUG() for any
faults.

But it turns out xtensa has a notion of protection faults even for
NOMMU configs:

    config PFAULT
        bool "Handle protection faults" if EXPERT && !MMU
        default y
        help
          Handle protection faults. MMU configurations must enable it.
          noMMU configurations may disable it if used memory map never
          generates protection faults or faults are always fatal.

          If unsure, say Y.

which is why it violated my expectations so badly.

I'm not sure if that protection fault handling really ever gets quite
this far (it certainly should *not* make it to the BUG() in
handle_mm_fault()), but I think the attached patch is likely the right
thing to do.

Can you check if it fixes that xtensa case? It looks
ObviouslyCorrect(tm) to me, but considering that I clearly missed this
case existing AT ALL, it might be best to double-check.

               Linus

--000000000000b0e4fd05ff62cd63
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ljjbm8ha0>
X-Attachment-Id: f_ljjbm8ha0

IGluY2x1ZGUvbGludXgvbW0uaCB8ICA1ICsrKy0tCiBtbS9ub21tdS5jICAgICAgICAgfCAxMSAr
KysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW0uaCBiL2luY2x1ZGUvbGludXgvbW0u
aAppbmRleCAzOWFhNDA5ZTg0ZDUuLjRmMmMzM2MyNzNlYiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9s
aW51eC9tbS5oCisrKyBiL2luY2x1ZGUvbGludXgvbW0uaApAQCAtMjMyMyw2ICsyMzIzLDkgQEAg
dm9pZCBwYWdlY2FjaGVfaXNpemVfZXh0ZW5kZWQoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90
IGZyb20sIGxvZmZfdCB0byk7CiB2b2lkIHRydW5jYXRlX3BhZ2VjYWNoZV9yYW5nZShzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCBsb2ZmX3Qgb2Zmc2V0LCBsb2ZmX3QgZW5kKTsKIGludCBnZW5lcmljX2Vy
cm9yX3JlbW92ZV9wYWdlKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCBzdHJ1Y3QgcGFn
ZSAqcGFnZSk7CiAKK3N0cnVjdCB2bV9hcmVhX3N0cnVjdCAqbG9ja19tbV9hbmRfZmluZF92bWEo
c3RydWN0IG1tX3N0cnVjdCAqbW0sCisJCXVuc2lnbmVkIGxvbmcgYWRkcmVzcywgc3RydWN0IHB0
X3JlZ3MgKnJlZ3MpOworCiAjaWZkZWYgQ09ORklHX01NVQogZXh0ZXJuIHZtX2ZhdWx0X3QgaGFu
ZGxlX21tX2ZhdWx0KHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLAogCQkJCSAgdW5zaWduZWQg
bG9uZyBhZGRyZXNzLCB1bnNpZ25lZCBpbnQgZmxhZ3MsCkBAIC0yMzM0LDggKzIzMzcsNiBAQCB2
b2lkIHVubWFwX21hcHBpbmdfcGFnZXMoc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCiAJ
CXBnb2ZmX3Qgc3RhcnQsIHBnb2ZmX3QgbnIsIGJvb2wgZXZlbl9jb3dzKTsKIHZvaWQgdW5tYXBf
bWFwcGluZ19yYW5nZShzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywKIAkJbG9mZl90IGNv
bnN0IGhvbGViZWdpbiwgbG9mZl90IGNvbnN0IGhvbGVsZW4sIGludCBldmVuX2Nvd3MpOwotc3Ry
dWN0IHZtX2FyZWFfc3RydWN0ICpsb2NrX21tX2FuZF9maW5kX3ZtYShzdHJ1Y3QgbW1fc3RydWN0
ICptbSwKLQkJdW5zaWduZWQgbG9uZyBhZGRyZXNzLCBzdHJ1Y3QgcHRfcmVncyAqcmVncyk7CiAj
ZWxzZQogc3RhdGljIGlubGluZSB2bV9mYXVsdF90IGhhbmRsZV9tbV9mYXVsdChzdHJ1Y3Qgdm1f
YXJlYV9zdHJ1Y3QgKnZtYSwKIAkJCQkJIHVuc2lnbmVkIGxvbmcgYWRkcmVzcywgdW5zaWduZWQg
aW50IGZsYWdzLApkaWZmIC0tZ2l0IGEvbW0vbm9tbXUuYyBiL21tL25vbW11LmMKaW5kZXggMzdk
MGIwMzE0M2YxLi5mZGMzOTI3MzVlYzYgMTAwNjQ0Ci0tLSBhL21tL25vbW11LmMKKysrIGIvbW0v
bm9tbXUuYwpAQCAtNjMwLDYgKzYzMCwxNyBAQCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKmZpbmRf
dm1hKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCB1bnNpZ25lZCBsb25nIGFkZHIpCiB9CiBFWFBPUlRf
U1lNQk9MKGZpbmRfdm1hKTsKIAorLyoKKyAqIEF0IGxlYXN0IHh0ZW5zYSBlbmRzIHVwIGhhdmlu
ZyBwcm90ZWN0aW9uIGZhdWx0cyBldmVuIHdpdGggbm8KKyAqIE1NVS4uIE5vIHN0YWNrIGV4cGFu
c2lvbiwgYXQgbGVhc3QuCisgKi8KK3N0cnVjdCB2bV9hcmVhX3N0cnVjdCAqbG9ja19tbV9hbmRf
ZmluZF92bWEoc3RydWN0IG1tX3N0cnVjdCAqbW0sCisJCQl1bnNpZ25lZCBsb25nIGFkZHIsIHN0
cnVjdCBwdF9yZWdzICpyZWdzKQoreworCW1tYXBfcmVhZF9sb2NrKG1tKTsKKwlyZXR1cm4gdm1h
X2xvb2t1cChtbSwgYWRkcik7Cit9CisKIC8qCiAgKiBleHBhbmQgYSBzdGFjayB0byBhIGdpdmVu
IGFkZHJlc3MKICAqIC0gbm90IHN1cHBvcnRlZCB1bmRlciBOT01NVSBjb25kaXRpb25zCg==
--000000000000b0e4fd05ff62cd63--
