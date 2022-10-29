Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA56124EB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 20:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJ2ShT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 14:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ2ShR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 14:37:17 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFA136876
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 11:37:15 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i10so5279142qkl.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 11:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=76M6lk7kfgu31CI5okzzmnnwo4O4f75sK07trq47018=;
        b=CMDfFoaVlAqhmO76DDLzJEcQXcOJZ3uiOCX7jQ56KKcSaGzHYi9XHSOiJmUKL3KQl2
         ib56ytK8djxG06UFpH8tLK52Rqwmte8mUYBP8Hh26aH+65xTcJY3/jOecO/pubZwS+0W
         lMJT8vxyWtnItVijfmTm+dkVHgAu2mBxm0oI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76M6lk7kfgu31CI5okzzmnnwo4O4f75sK07trq47018=;
        b=YxsmEwhljyIloL/9mZCeU89uqn9LJxIN00xbojwcppj6OmyyBLJSYX0062/Vr661u9
         /0G2DgEFtI8VRdy/27znL6UtHtfnQ65m1MBe/tBWoxpFMkOaejMPITJOn0Z8/3emacH3
         ybVIyhnO4SIwS7/yn2QW69dWWt4JODLkd/UI+kJgQu7WvirouTLWnpsEsuiUx4n4CByL
         eYdyCDf3/KX3m+VTkzyp8n3/qg4iK9nRtauG+UR6UhPvd3wqePLXpS5ektFn5ZtGq288
         7p6U/mX8aoJatl/WBKV8jRgmTa5qMPwoYI0cVo+FRYTuPj5c0LsFR7Yse+AIVZVLAB49
         TGLA==
X-Gm-Message-State: ACrzQf2aZmsX5brIHJiWTWszhm47TH2eNAwNnMvjHCK5nvlebC5Y329v
        5uw/O+Z1cEWNuhvTIOCRWoEnkQW2T/VLHA==
X-Google-Smtp-Source: AMsMyM442SUEQks1nKTI+woVHPamU4zyxaQI6tvHvpwaDVWdK4/90XsdjQySKeev4r/2lnwmn/4d+g==
X-Received: by 2002:a05:620a:4713:b0:6ee:e87d:d1a5 with SMTP id bs19-20020a05620a471300b006eee87dd1a5mr3836756qkb.589.1667068634224;
        Sat, 29 Oct 2022 11:37:14 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id u21-20020a37ab15000000b006fa1dc83a36sm599529qke.64.2022.10.29.11.37.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 11:37:10 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 187so9557124ybe.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 11:37:10 -0700 (PDT)
X-Received: by 2002:a5b:984:0:b0:6ca:9345:b2ee with SMTP id
 c4-20020a5b0984000000b006ca9345b2eemr4420709ybq.362.1667068629989; Sat, 29
 Oct 2022 11:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com> <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net> <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net> <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net> <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com> <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com> <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com> <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com>
In-Reply-To: <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Oct 2022 11:36:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
Message-ID: <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com,
        Alistair Popple <apopple@nvidia.com>
Content-Type: multipart/mixed; boundary="0000000000008225b205ec30a9c6"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008225b205ec30a9c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 29, 2022 at 11:05 AM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> Anyhow, I am not sure whether the solution that you propose would work.
> Please let me know if my understanding makes sense.

Let me include my (UNTESTED! PROBABLY GARBAGE!) patch here just as a
"I meant something like this".

Note that it's untested, but I tried to make it intentionally use
different names and an opaque type in the 'mmu_gather' data structure
so that at least these bit games end up being type-safe and more
likely to be correct if it compiles.

And I will say that it does compile for me - but only in my normal
x86-64 config. I haven't tested anything else, and I guarantee it
won't build on s390, for example, because s390 has its own mmu_gather
functions.

> Let=E2=80=99s assume that we do not call set_page_dirty() before we remov=
e the rmap
> but only after we invalidate the page [*]. Let=E2=80=99s assume that
> shrink_page_list() is called after the page=E2=80=99s rmap is removed and=
 the page
> is no longer mapped, but before set_page_dirty() was actually called.
>
> In such a case, shrink_page_list() would consider the page clean, and wou=
ld
> indeed keep the page (since __remove_mapping() would find elevated page
> refcount), which appears to give us a chance to mark the page as dirty
> later.

Right. That is not different to any other function (like "write()"
having looked up the page.

> However, IIUC, in this case shrink_page_list() might still call
> filemap_release_folio() and release the buffers, so calling set_page_dirt=
y()
> afterwards - after the actual TLB invalidation took place - would fail.

I'm not seeing why.

That would imply that any "look up page, do set_page_dirty()" is
broken. They don't have rmap either. And we have a number of them all
over (eg think "GUP users" etc).

But hey, you were right about the stale TLB case, so I may just be
missing something.

I *think* the important thing is just that we need to mark the page
dirtty from the page tables _after_ we've flushed the TLB, just to
make sure that there can be no subsequent dirtiers that then get lost.

Anyway, I think the best documentation for "this is what I meant" is
simply the patch. Does this affect your PoC on your setup?

I tried to run your program on my machine (WITHOUT this patch - I have
compiled this patch, but I haven't even booted it - it really could be
horrible broken).

But it doesn't fail for me even without the patch and I just get
"Finished without an error" over and over again - but you said it had
to be run on a RAM block device, which I didn't do, so my testing is
very suspect,.

Again: THIS PATCH IS UNTESTED. I feel like it might actually work, if
only because I tried to be so careful with the type system.

But that "might actually work" is probably me being wildly optimistic,
and also depends on the whole concept being ok in the first place.

So realistically, think of this patch more as a "document in code what
Linus meant with his incoherent ramblings" rather than anything else.

Hmm?

               Linus

--0000000000008225b205ec30a9c6
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l9u9ll4z0>
X-Attachment-Id: f_l9u9ll4z0

IGluY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmggfCAyOCArKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tCiBtbS9tZW1vcnkuYyAgICAgICAgICAgICAgIHwgMTcgKysrKysrKystLS0tLS0tLS0KIG1t
L21tdV9nYXRoZXIuYyAgICAgICAgICAgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgNjMgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tZ2VuZXJpYy90bGIuaCBiL2luY2x1ZGUvYXNt
LWdlbmVyaWMvdGxiLmgKaW5kZXggNDkyZGNlNDMyMzZlLi5hOTUwODVmNmRkNDcgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmgKKysrIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy90
bGIuaApAQCAtMjM4LDExICsyMzgsMjkgQEAgZXh0ZXJuIHZvaWQgdGxiX3JlbW92ZV90YWJsZShz
dHJ1Y3QgbW11X2dhdGhlciAqdGxiLCB2b2lkICp0YWJsZSk7CiAgKi8KICNkZWZpbmUgTU1VX0dB
VEhFUl9CVU5ETEUJOAogCisvKiBGYWtlIHR5cGUgZm9yIGFuIGVuY29kZWQgcGFnZSBwb2ludGVy
IHdpdGggdGhlIGRpcnR5IGJpdCBpbiB0aGUgbG93IGJpdCAqLworc3RydWN0IGVuY29kZWRfcGFn
ZTsKKworc3RhdGljIGlubGluZSBzdHJ1Y3QgZW5jb2RlZF9wYWdlICplbmNvZGVfcGFnZShzdHJ1
Y3QgcGFnZSAqcGFnZSwgYm9vbCBkaXJ0eSkKK3sKKwlyZXR1cm4gKHN0cnVjdCBlbmNvZGVkX3Bh
Z2UgKikoZGlydHkgfCAodW5zaWduZWQgbG9uZylwYWdlKTsKK30KKworc3RhdGljIGlubGluZSBi
b29sIGVuY29kZWRfcGFnZV9kaXJ0eShzdHJ1Y3QgZW5jb2RlZF9wYWdlICpwYWdlKQoreworCXJl
dHVybiAxICYgKHVuc2lnbmVkIGxvbmcpcGFnZTsKK30KKworc3RhdGljIGlubGluZSBzdHJ1Y3Qg
cGFnZSAqZW5jb2RlZF9wYWdlX3B0cihzdHJ1Y3QgZW5jb2RlZF9wYWdlICpwYWdlKQoreworCXJl
dHVybiAoc3RydWN0IHBhZ2UgKikofjF1bCAmICh1bnNpZ25lZCBsb25nKXBhZ2UpOworfQorCiBz
dHJ1Y3QgbW11X2dhdGhlcl9iYXRjaCB7CiAJc3RydWN0IG1tdV9nYXRoZXJfYmF0Y2gJKm5leHQ7
CiAJdW5zaWduZWQgaW50CQlucjsKIAl1bnNpZ25lZCBpbnQJCW1heDsKLQlzdHJ1Y3QgcGFnZQkJ
KnBhZ2VzW107CisJc3RydWN0IGVuY29kZWRfcGFnZQkqZW5jb2RlZF9wYWdlc1tdOwogfTsKIAog
I2RlZmluZSBNQVhfR0FUSEVSX0JBVENICVwKQEAgLTI1Nyw3ICsyNzUsNyBAQCBzdHJ1Y3QgbW11
X2dhdGhlcl9iYXRjaCB7CiAjZGVmaW5lIE1BWF9HQVRIRVJfQkFUQ0hfQ09VTlQJKDEwMDAwVUwv
TUFYX0dBVEhFUl9CQVRDSCkKIAogZXh0ZXJuIGJvb2wgX190bGJfcmVtb3ZlX3BhZ2Vfc2l6ZShz
dHJ1Y3QgbW11X2dhdGhlciAqdGxiLCBzdHJ1Y3QgcGFnZSAqcGFnZSwKLQkJCQkgICBpbnQgcGFn
ZV9zaXplKTsKKwkJCQkgICBpbnQgcGFnZV9zaXplLCBib29sIGRpcnR5KTsKICNlbmRpZgogCiAv
KgpAQCAtNDMxLDEzICs0NDksMTMgQEAgc3RhdGljIGlubGluZSB2b2lkIHRsYl9mbHVzaF9tbXVf
dGxib25seShzdHJ1Y3QgbW11X2dhdGhlciAqdGxiKQogc3RhdGljIGlubGluZSB2b2lkIHRsYl9y
ZW1vdmVfcGFnZV9zaXplKHN0cnVjdCBtbXVfZ2F0aGVyICp0bGIsCiAJCQkJCXN0cnVjdCBwYWdl
ICpwYWdlLCBpbnQgcGFnZV9zaXplKQogewotCWlmIChfX3RsYl9yZW1vdmVfcGFnZV9zaXplKHRs
YiwgcGFnZSwgcGFnZV9zaXplKSkKKwlpZiAoX190bGJfcmVtb3ZlX3BhZ2Vfc2l6ZSh0bGIsIHBh
Z2UsIHBhZ2Vfc2l6ZSwgZmFsc2UpKQogCQl0bGJfZmx1c2hfbW11KHRsYik7CiB9CiAKLXN0YXRp
YyBpbmxpbmUgYm9vbCBfX3RsYl9yZW1vdmVfcGFnZShzdHJ1Y3QgbW11X2dhdGhlciAqdGxiLCBz
dHJ1Y3QgcGFnZSAqcGFnZSkKK3N0YXRpYyBpbmxpbmUgYm9vbCBfX3RsYl9yZW1vdmVfcGFnZShz
dHJ1Y3QgbW11X2dhdGhlciAqdGxiLCBzdHJ1Y3QgcGFnZSAqcGFnZSwgYm9vbCBkaXJ0eSkKIHsK
LQlyZXR1cm4gX190bGJfcmVtb3ZlX3BhZ2Vfc2l6ZSh0bGIsIHBhZ2UsIFBBR0VfU0laRSk7CisJ
cmV0dXJuIF9fdGxiX3JlbW92ZV9wYWdlX3NpemUodGxiLCBwYWdlLCBQQUdFX1NJWkUsIGRpcnR5
KTsKIH0KIAogLyogdGxiX3JlbW92ZV9wYWdlCmRpZmYgLS1naXQgYS9tbS9tZW1vcnkuYyBiL21t
L21lbW9yeS5jCmluZGV4IGY4OGMzNTFhZWNkNC4uOGFiNGMwZDdlOTllIDEwMDY0NAotLS0gYS9t
bS9tZW1vcnkuYworKysgYi9tbS9tZW1vcnkuYwpAQCAtMTQyMyw3ICsxNDIzLDYgQEAgc3RhdGlj
IHVuc2lnbmVkIGxvbmcgemFwX3B0ZV9yYW5nZShzdHJ1Y3QgbW11X2dhdGhlciAqdGxiLAogCWFy
Y2hfZW50ZXJfbGF6eV9tbXVfbW9kZSgpOwogCWRvIHsKIAkJcHRlX3QgcHRlbnQgPSAqcHRlOwot
CQlzdHJ1Y3QgcGFnZSAqcGFnZTsKIAogCQlpZiAocHRlX25vbmUocHRlbnQpKQogCQkJY29udGlu
dWU7CkBAIC0xNDMyLDcgKzE0MzEsOSBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyB6YXBfcHRlX3Jh
bmdlKHN0cnVjdCBtbXVfZ2F0aGVyICp0bGIsCiAJCQlicmVhazsKIAogCQlpZiAocHRlX3ByZXNl
bnQocHRlbnQpKSB7Ci0JCQlwYWdlID0gdm1fbm9ybWFsX3BhZ2Uodm1hLCBhZGRyLCBwdGVudCk7
CisJCQlzdHJ1Y3QgcGFnZSAqcGFnZSA9IHZtX25vcm1hbF9wYWdlKHZtYSwgYWRkciwgcHRlbnQp
OworCQkJaW50IGRpcnR5OworCiAJCQlpZiAodW5saWtlbHkoIXNob3VsZF96YXBfcGFnZShkZXRh
aWxzLCBwYWdlKSkpCiAJCQkJY29udGludWU7CiAJCQlwdGVudCA9IHB0ZXBfZ2V0X2FuZF9jbGVh
cl9mdWxsKG1tLCBhZGRyLCBwdGUsCkBAIC0xNDQzLDExICsxNDQ0LDkgQEAgc3RhdGljIHVuc2ln
bmVkIGxvbmcgemFwX3B0ZV9yYW5nZShzdHJ1Y3QgbW11X2dhdGhlciAqdGxiLAogCQkJaWYgKHVu
bGlrZWx5KCFwYWdlKSkKIAkJCQljb250aW51ZTsKIAorCQkJZGlydHkgPSAwOwogCQkJaWYgKCFQ
YWdlQW5vbihwYWdlKSkgewotCQkJCWlmIChwdGVfZGlydHkocHRlbnQpKSB7Ci0JCQkJCWZvcmNl
X2ZsdXNoID0gMTsKLQkJCQkJc2V0X3BhZ2VfZGlydHkocGFnZSk7Ci0JCQkJfQorCQkJCWRpcnR5
ID0gcHRlX2RpcnR5KHB0ZW50KTsKIAkJCQlpZiAocHRlX3lvdW5nKHB0ZW50KSAmJgogCQkJCSAg
ICBsaWtlbHkoISh2bWEtPnZtX2ZsYWdzICYgVk1fU0VRX1JFQUQpKSkKIAkJCQkJbWFya19wYWdl
X2FjY2Vzc2VkKHBhZ2UpOwpAQCAtMTQ1Niw3ICsxNDU1LDcgQEAgc3RhdGljIHVuc2lnbmVkIGxv
bmcgemFwX3B0ZV9yYW5nZShzdHJ1Y3QgbW11X2dhdGhlciAqdGxiLAogCQkJcGFnZV9yZW1vdmVf
cm1hcChwYWdlLCB2bWEsIGZhbHNlKTsKIAkJCWlmICh1bmxpa2VseShwYWdlX21hcGNvdW50KHBh
Z2UpIDwgMCkpCiAJCQkJcHJpbnRfYmFkX3B0ZSh2bWEsIGFkZHIsIHB0ZW50LCBwYWdlKTsKLQkJ
CWlmICh1bmxpa2VseShfX3RsYl9yZW1vdmVfcGFnZSh0bGIsIHBhZ2UpKSkgeworCQkJaWYgKHVu
bGlrZWx5KF9fdGxiX3JlbW92ZV9wYWdlKHRsYiwgcGFnZSwgZGlydHkpKSkgewogCQkJCWZvcmNl
X2ZsdXNoID0gMTsKIAkJCQlhZGRyICs9IFBBR0VfU0laRTsKIAkJCQlicmVhazsKQEAgLTE0Njcs
NyArMTQ2Niw3IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIHphcF9wdGVfcmFuZ2Uoc3RydWN0IG1t
dV9nYXRoZXIgKnRsYiwKIAkJZW50cnkgPSBwdGVfdG9fc3dwX2VudHJ5KHB0ZW50KTsKIAkJaWYg
KGlzX2RldmljZV9wcml2YXRlX2VudHJ5KGVudHJ5KSB8fAogCQkgICAgaXNfZGV2aWNlX2V4Y2x1
c2l2ZV9lbnRyeShlbnRyeSkpIHsKLQkJCXBhZ2UgPSBwZm5fc3dhcF9lbnRyeV90b19wYWdlKGVu
dHJ5KTsKKwkJCXN0cnVjdCBwYWdlICpwYWdlID0gcGZuX3N3YXBfZW50cnlfdG9fcGFnZShlbnRy
eSk7CiAJCQlpZiAodW5saWtlbHkoIXNob3VsZF96YXBfcGFnZShkZXRhaWxzLCBwYWdlKSkpCiAJ
CQkJY29udGludWU7CiAJCQkvKgpAQCAtMTQ4OSw3ICsxNDg4LDcgQEAgc3RhdGljIHVuc2lnbmVk
IGxvbmcgemFwX3B0ZV9yYW5nZShzdHJ1Y3QgbW11X2dhdGhlciAqdGxiLAogCQkJaWYgKHVubGlr
ZWx5KCFmcmVlX3N3YXBfYW5kX2NhY2hlKGVudHJ5KSkpCiAJCQkJcHJpbnRfYmFkX3B0ZSh2bWEs
IGFkZHIsIHB0ZW50LCBOVUxMKTsKIAkJfSBlbHNlIGlmIChpc19taWdyYXRpb25fZW50cnkoZW50
cnkpKSB7Ci0JCQlwYWdlID0gcGZuX3N3YXBfZW50cnlfdG9fcGFnZShlbnRyeSk7CisJCQlzdHJ1
Y3QgcGFnZSAqcGFnZSA9IHBmbl9zd2FwX2VudHJ5X3RvX3BhZ2UoZW50cnkpOwogCQkJaWYgKCFz
aG91bGRfemFwX3BhZ2UoZGV0YWlscywgcGFnZSkpCiAJCQkJY29udGludWU7CiAJCQlyc3NbbW1f
Y291bnRlcihwYWdlKV0tLTsKZGlmZiAtLWdpdCBhL21tL21tdV9nYXRoZXIuYyBiL21tL21tdV9n
YXRoZXIuYwppbmRleCBhZGQ0MjQ0ZTU3OTAuLmZhNzllMDU0NDEzYSAxMDA2NDQKLS0tIGEvbW0v
bW11X2dhdGhlci5jCisrKyBiL21tL21tdV9nYXRoZXIuYwpAQCAtNDMsMTIgKzQzLDQwIEBAIHN0
YXRpYyBib29sIHRsYl9uZXh0X2JhdGNoKHN0cnVjdCBtbXVfZ2F0aGVyICp0bGIpCiAJcmV0dXJu
IHRydWU7CiB9CiAKKy8qCisgKiBXZSBnZXQgYW4gJ2VuY29kZWQgcGFnZScgYXJyYXksIHdoaWNo
IGhhcyBwYWdlIHBvaW50ZXJzIHdpdGgKKyAqIHRoZSBkaXJ0eSBiaXQgaW4gdGhlIGxvdyBiaXQg
b2YgdGhlIGFycmF5LgorICoKKyAqIFRoZSBUTEIgaGFzIGJlZW4gZmx1c2hlZCwgbm93IHdlIG5l
ZWQgdG8gbW92ZSB0aGUgZGlydHkgYml0IGludG8KKyAqIHRoZSAnc3RydWN0IHBhZ2UnLCBjbGVh
biB0aGUgYXJyYXkgaW4tcGxhY2UsIGFuZCB0aGVuIGZyZWUgdGhlCisgKiBwYWdlcyBhbmQgdGhl
aXIgc3dhcCBjYWNoZS4KKyAqLworc3RhdGljIHZvaWQgY2xlYW5fYW5kX2ZyZWVfcGFnZXNfYW5k
X3N3YXBfY2FjaGUoc3RydWN0IGVuY29kZWRfcGFnZSAqKnBhZ2VzLCB1bnNpZ25lZCBpbnQgbnIp
Cit7CisJZm9yICh1bnNpZ25lZCBpbnQgaSA9IDA7IGkgPCBucjsgaSsrKSB7CisJCXN0cnVjdCBl
bmNvZGVkX3BhZ2UgKmVuY29kZWQgPSBwYWdlc1tpXTsKKwkJaWYgKGVuY29kZWRfcGFnZV9kaXJ0
eShlbmNvZGVkKSkgeworCQkJc3RydWN0IHBhZ2UgKnBhZ2UgPSBlbmNvZGVkX3BhZ2VfcHRyKGVu
Y29kZWQpOworCQkJLyogQ2xlYW4gdGhlIGRpcnR5IHBvaW50ZXIgaW4tcGxhY2UgKi8KKwkJCXBh
Z2VzW2ldID0gZW5jb2RlX3BhZ2UocGFnZSwgMCk7CisJCQlzZXRfcGFnZV9kaXJ0eShwYWdlKTsK
KwkJfQorCX0KKworCS8qCisJICogTm93IGFsbCBlbnRyaWVzIGhhdmUgYmVlbiB1bi1lbmNvZGVk
LCBhbmQgY2hhbmdlZCB0byBwbGFpbgorCSAqIHBhZ2UgcG9pbnRlcnMsIHNvIHdlIGNhbiBjYXN0
IHRoZSAnZW5jb2RlZF9wYWdlJyBhcnJheSB0bworCSAqIGEgcGxhaW4gcGFnZSBhcnJheSBhbmQg
ZnJlZSB0aGVtCisJICovCisJZnJlZV9wYWdlc19hbmRfc3dhcF9jYWNoZSgoc3RydWN0IHBhZ2Ug
KiopcGFnZXMsIG5yKTsKK30KKwogc3RhdGljIHZvaWQgdGxiX2JhdGNoX3BhZ2VzX2ZsdXNoKHN0
cnVjdCBtbXVfZ2F0aGVyICp0bGIpCiB7CiAJc3RydWN0IG1tdV9nYXRoZXJfYmF0Y2ggKmJhdGNo
OwogCiAJZm9yIChiYXRjaCA9ICZ0bGItPmxvY2FsOyBiYXRjaCAmJiBiYXRjaC0+bnI7IGJhdGNo
ID0gYmF0Y2gtPm5leHQpIHsKLQkJc3RydWN0IHBhZ2UgKipwYWdlcyA9IGJhdGNoLT5wYWdlczsK
KwkJc3RydWN0IGVuY29kZWRfcGFnZSAqKnBhZ2VzID0gYmF0Y2gtPmVuY29kZWRfcGFnZXM7CiAK
IAkJZG8gewogCQkJLyoKQEAgLTU2LDcgKzg0LDcgQEAgc3RhdGljIHZvaWQgdGxiX2JhdGNoX3Bh
Z2VzX2ZsdXNoKHN0cnVjdCBtbXVfZ2F0aGVyICp0bGIpCiAJCQkgKi8KIAkJCXVuc2lnbmVkIGlu
dCBuciA9IG1pbig1MTJVLCBiYXRjaC0+bnIpOwogCi0JCQlmcmVlX3BhZ2VzX2FuZF9zd2FwX2Nh
Y2hlKHBhZ2VzLCBucik7CisJCQljbGVhbl9hbmRfZnJlZV9wYWdlc19hbmRfc3dhcF9jYWNoZShw
YWdlcywgbnIpOwogCQkJcGFnZXMgKz0gbnI7CiAJCQliYXRjaC0+bnIgLT0gbnI7CiAKQEAgLTc3
LDcgKzEwNSw3IEBAIHN0YXRpYyB2b2lkIHRsYl9iYXRjaF9saXN0X2ZyZWUoc3RydWN0IG1tdV9n
YXRoZXIgKnRsYikKIAl0bGItPmxvY2FsLm5leHQgPSBOVUxMOwogfQogCi1ib29sIF9fdGxiX3Jl
bW92ZV9wYWdlX3NpemUoc3RydWN0IG1tdV9nYXRoZXIgKnRsYiwgc3RydWN0IHBhZ2UgKnBhZ2Us
IGludCBwYWdlX3NpemUpCitib29sIF9fdGxiX3JlbW92ZV9wYWdlX3NpemUoc3RydWN0IG1tdV9n
YXRoZXIgKnRsYiwgc3RydWN0IHBhZ2UgKnBhZ2UsIGludCBwYWdlX3NpemUsIGJvb2wgZGlydHkp
CiB7CiAJc3RydWN0IG1tdV9nYXRoZXJfYmF0Y2ggKmJhdGNoOwogCkBAIC05Miw3ICsxMjAsNyBA
QCBib29sIF9fdGxiX3JlbW92ZV9wYWdlX3NpemUoc3RydWN0IG1tdV9nYXRoZXIgKnRsYiwgc3Ry
dWN0IHBhZ2UgKnBhZ2UsIGludCBwYWdlXwogCSAqIEFkZCB0aGUgcGFnZSBhbmQgY2hlY2sgaWYg
d2UgYXJlIGZ1bGwuIElmIHNvCiAJICogZm9yY2UgYSBmbHVzaC4KIAkgKi8KLQliYXRjaC0+cGFn
ZXNbYmF0Y2gtPm5yKytdID0gcGFnZTsKKwliYXRjaC0+ZW5jb2RlZF9wYWdlc1tiYXRjaC0+bnIr
K10gPSBlbmNvZGVfcGFnZShwYWdlLCBkaXJ0eSk7CiAJaWYgKGJhdGNoLT5uciA9PSBiYXRjaC0+
bWF4KSB7CiAJCWlmICghdGxiX25leHRfYmF0Y2godGxiKSkKIAkJCXJldHVybiB0cnVlOwo=
--0000000000008225b205ec30a9c6--
