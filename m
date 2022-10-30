Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FE8612DA2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 23:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJ3Wr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 18:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ3Wr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 18:47:56 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7B2A1A2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 15:47:55 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id e15so7436844qvo.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0uDy81JIlS00RxkvQyiXflyESZuBwGjhJsGtrADkh88=;
        b=ZDYCyZPKiuisYOnqKd9OOo9aCSgQziltL5JGmc+Yx9XO8F9okoDzTYioyCovhztVt+
         PsxdYcEJyWI5ZBpFAkO0NlLVfqbGaYA4r27U5/8YtEPl0MusWmkjMKRs8a3f4GW4tXgY
         BDV6rPkuC8OsTHNGE8Dtujn+3ANJvpOxd6Xog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uDy81JIlS00RxkvQyiXflyESZuBwGjhJsGtrADkh88=;
        b=j9hzNAutzVAV61skkMSrhWKGOaChyWjRVnQJ/ySUksxKsVyEXbme84hEVPYn1UNIuY
         RuZxd9v73IldorSwozt+ADnUdiWA92u7uWKeFgtdRCXQCyMFZKHioNwxaJCKFU4mNrZ+
         TFNKDC1waLQ41+OvZls9MjDC+7AsSyHsIa4IbK7X5LHksfxnsF5vPeX4pVerTxzc8K8X
         AFuRQcP0cBRLdLDzorNRj2TL6VtS4NQWxMi3h7Sk5t5pCoDsSJpRgXWNIfYWqBggOOOo
         rZiFggJud8fyshgPuapt47h4kPtzDNILoptxh4r/6vGjdwNZJdBIGYC7678ZBrn9p5aP
         Lvlw==
X-Gm-Message-State: ACrzQf13xZbRX9LyoyHiNMmHup09qyx2/8XV00w31jEjmaxqp9/cpMNG
        FW2hIaCXVxa2BN9HVM+KNVMdSXhdJG6FbQ==
X-Google-Smtp-Source: AMsMyM6VBCgXQnOqV+M6X0OOVR5jwndlECs4Vpg/kKbJ3s4TXdWTXHdLgJzrL/jo7CjYoUJT4TKUEg==
X-Received: by 2002:a0c:b447:0:b0:4b3:cf2b:92f6 with SMTP id e7-20020a0cb447000000b004b3cf2b92f6mr8705863qvf.79.1667170074600;
        Sun, 30 Oct 2022 15:47:54 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a24cf00b006ef0350db8asm3606426qkn.128.2022.10.30.15.47.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 15:47:53 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-367cd2807f2so93991127b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 15:47:52 -0700 (PDT)
X-Received: by 2002:a0d:c246:0:b0:370:2d8c:81d6 with SMTP id
 e67-20020a0dc246000000b003702d8c81d6mr10193775ywd.112.1667170072503; Sun, 30
 Oct 2022 15:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com> <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net> <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net> <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net> <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com> <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com> <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com> <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com> <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
In-Reply-To: <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Oct 2022 15:47:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
Message-ID: <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="000000000000f406c305ec484700"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f406c305ec484700
Content-Type: text/plain; charset="UTF-8"

On Sun, Oct 30, 2022 at 11:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> We could keep the current placement of the TLB flush, to just before
> we drop the page table lock.
>
> And we could do all the things we do in 'page_remove_rmap()' right now
> *except* for the mapcount stuff.
>
> And only move the mapcount code to the page freeing stage.

So I actually have a three-commit series to do the rmap
simplification, but let me just post the end result of that series,
because the end result is actually smaller than the individual commits
(I did it as three incremental commits just to make it more obvious to
me how to get to that end result).

The three commits end up being

      mm: introduce simplified versions of 'page_remove_rmap()'
      mm: inline simpler case of page_remove_file_rmap()
      mm: re-unify the simplified page_zap_*_rmap() function

and the end result of them is this attached patch.

I'm *claiming* that the attached patch is semantically identical to
what we do before it, just _hugely_ simplified.

Basically, that new 'page_zap_pte_rmap()' does the same things that
'page_remove_rmap()' did, except it is limited to only last-level PTE
entries (and that munlock_vma_page() has to be called separately).

The simplification comes from 'compound' being false, from it always
being about small pages, and from the atomic mapcount decrement having
been moved outside the memcg lock, since it is independent of it.

Anyway, this simplification patch basically means that the *next* step
could be to just move that ipage_zap_pte_rmap()' after the TLB flush,
and now it's trivial and no longer scary.

I did *not* do that yet, because it still needs that "encoded_page[]"
array - except now it doesn't encode the 'dirty' bit, now it would
encode the 'do a page->_mapcount decrement' bit.

I didn't do that part, because needed to do the rc3 release, plus I'd
like to have somebody look at this introductory patch first.

              Linus

--000000000000f406c305ec484700
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l9vxsbj50>
X-Attachment-Id: f_l9vxsbj50

IGluY2x1ZGUvbGludXgvcm1hcC5oIHwgIDEgKwogbW0vbWVtb3J5LmMgICAgICAgICAgfCAgMyAr
Ky0KIG1tL3JtYXAuYyAgICAgICAgICAgIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysrCiAz
IGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3JtYXAuaCBiL2luY2x1ZGUvbGludXgvcm1hcC5oCmluZGV4IGJk
MzUwNGQxMWIxNS4uZjYyYWYwMDE3MDdjIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3JtYXAu
aAorKysgYi9pbmNsdWRlL2xpbnV4L3JtYXAuaApAQCAtMTk2LDYgKzE5Niw3IEBAIHZvaWQgcGFn
ZV9hZGRfbmV3X2Fub25fcm1hcChzdHJ1Y3QgcGFnZSAqLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KiwKIAkJdW5zaWduZWQgbG9uZyBhZGRyZXNzKTsKIHZvaWQgcGFnZV9hZGRfZmlsZV9ybWFwKHN0
cnVjdCBwYWdlICosIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqLAogCQlib29sIGNvbXBvdW5kKTsK
K3ZvaWQgcGFnZV96YXBfcHRlX3JtYXAoc3RydWN0IHBhZ2UgKik7CiB2b2lkIHBhZ2VfcmVtb3Zl
X3JtYXAoc3RydWN0IHBhZ2UgKiwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICosCiAJCWJvb2wgY29t
cG91bmQpOwogCmRpZmYgLS1naXQgYS9tbS9tZW1vcnkuYyBiL21tL21lbW9yeS5jCmluZGV4IGY4
OGMzNTFhZWNkNC4uYzg5M2Y1ZmZjNWE4IDEwMDY0NAotLS0gYS9tbS9tZW1vcnkuYworKysgYi9t
bS9tZW1vcnkuYwpAQCAtMTQ1Miw4ICsxNDUyLDkgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgemFw
X3B0ZV9yYW5nZShzdHJ1Y3QgbW11X2dhdGhlciAqdGxiLAogCQkJCSAgICBsaWtlbHkoISh2bWEt
PnZtX2ZsYWdzICYgVk1fU0VRX1JFQUQpKSkKIAkJCQkJbWFya19wYWdlX2FjY2Vzc2VkKHBhZ2Up
OwogCQkJfQorCQkJcGFnZV96YXBfcHRlX3JtYXAocGFnZSk7CisJCQltdW5sb2NrX3ZtYV9wYWdl
KHBhZ2UsIHZtYSwgZmFsc2UpOwogCQkJcnNzW21tX2NvdW50ZXIocGFnZSldLS07Ci0JCQlwYWdl
X3JlbW92ZV9ybWFwKHBhZ2UsIHZtYSwgZmFsc2UpOwogCQkJaWYgKHVubGlrZWx5KHBhZ2VfbWFw
Y291bnQocGFnZSkgPCAwKSkKIAkJCQlwcmludF9iYWRfcHRlKHZtYSwgYWRkciwgcHRlbnQsIHBh
Z2UpOwogCQkJaWYgKHVubGlrZWx5KF9fdGxiX3JlbW92ZV9wYWdlKHRsYiwgcGFnZSkpKSB7CmRp
ZmYgLS1naXQgYS9tbS9ybWFwLmMgYi9tbS9ybWFwLmMKaW5kZXggMmVjOTI1ZTVmYTZhLi4yOGI1
MWEzMWViYjAgMTAwNjQ0Ci0tLSBhL21tL3JtYXAuYworKysgYi9tbS9ybWFwLmMKQEAgLTE0MTIs
NiArMTQxMiwzMCBAQCBzdGF0aWMgdm9pZCBwYWdlX3JlbW92ZV9hbm9uX2NvbXBvdW5kX3JtYXAo
c3RydWN0IHBhZ2UgKnBhZ2UpCiAJCV9fbW9kX2xydXZlY19wYWdlX3N0YXRlKHBhZ2UsIE5SX0FO
T05fTUFQUEVELCAtbnIpOwogfQogCisvKioKKyAqIHBhZ2VfemFwX3B0ZV9ybWFwIC0gdGFrZSBk
b3duIGEgcHRlIG1hcHBpbmcgZnJvbSBhIHBhZ2UKKyAqIEBwYWdlOglwYWdlIHRvIHJlbW92ZSBt
YXBwaW5nIGZyb20KKyAqCisgKiBUaGlzIGlzIHRoZSBzaW1wbGlmaWVkIGZvcm0gb2YgcGFnZV9y
ZW1vdmVfcm1hcCgpLCB0aGF0IG9ubHkKKyAqIGRlYWxzIHdpdGggbGFzdC1sZXZlbCBwYWdlcywg
c28gJ2NvbXBvdW5kJyBpcyBhbHdheXMgZmFsc2UsCisgKiBhbmQgdGhlIGNhbGxlciBkb2VzICdt
dW5sb2NrX3ZtYV9wYWdlKHBhZ2UsIHZtYSwgY29tcG91bmQpJworICogc2VwYXJhdGVseS4KKyAq
CisgKiBUaGlzIGFsbG93cyBmb3IgYSBtdWNoIHNpbXBsZXIgY2FsbGluZyBjb252ZW50aW9uIGFu
ZCBjb2RlLgorICoKKyAqIFRoZSBjYWxsZXIgaG9sZHMgdGhlIHB0ZSBsb2NrLgorICovCit2b2lk
IHBhZ2VfemFwX3B0ZV9ybWFwKHN0cnVjdCBwYWdlICpwYWdlKQoreworCWlmICghYXRvbWljX2Fk
ZF9uZWdhdGl2ZSgtMSwgJnBhZ2UtPl9tYXBjb3VudCkpCisJCXJldHVybjsKKworCWxvY2tfcGFn
ZV9tZW1jZyhwYWdlKTsKKwlfX2RlY19scnV2ZWNfcGFnZV9zdGF0ZShwYWdlLAorCQlQYWdlQW5v
bihwYWdlKSA/IE5SX0FOT05fTUFQUEVEIDogTlJfRklMRV9NQVBQRUQpOworCXVubG9ja19wYWdl
X21lbWNnKHBhZ2UpOworfQorCiAvKioKICAqIHBhZ2VfcmVtb3ZlX3JtYXAgLSB0YWtlIGRvd24g
cHRlIG1hcHBpbmcgZnJvbSBhIHBhZ2UKICAqIEBwYWdlOglwYWdlIHRvIHJlbW92ZSBtYXBwaW5n
IGZyb20K
--000000000000f406c305ec484700--
