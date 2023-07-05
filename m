Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4987A747AF3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 03:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjGEBXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 21:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGEBXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 21:23:48 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D729310EA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 18:23:46 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4036bd4fff1so369931cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 18:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688520226; x=1691112226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DGyaiEDlH5+qf+loyv/rZwlYAmAsv+G0CG8spxUkzDQ=;
        b=uqNrqz6Vv2wjZCol0sjq+mWtVDbfqXml4SA1b4Itt5Ta6cQ8q0tAnkBPb7Y9L3pyFn
         SlFijflhkZQ9ZER2c8p3pk3GtGkr8oEqVzYvqH//TmGW3wXGJCvMFkCLRcndoZyoUTr8
         IN7FlqeYM0v7FuwXuh5WGBTfg3nKpGvfQ66xVIdp6e5NjDhnd1LKL48/LhAbrGZf8XKE
         T63skeDPUB/fXrwAtBHssqGnfiAJpxDb4Exsgpdi4vQYVJriEA8r4KUqPL6wSx3pqFBm
         h3SOTtsYnqxEEZHQ2cdy78N6Fws5E0j6Tbit3ERhw7v70qrSSFachbbYQYMHWR2IY+3A
         5A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688520226; x=1691112226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGyaiEDlH5+qf+loyv/rZwlYAmAsv+G0CG8spxUkzDQ=;
        b=hKEdYjgdpcESQR5cY9qoSDVYGjDXYdtWchAl1ZFZP/bM2kN19C+EViiWKhjtCnFABY
         q91Erlu+kNzH+WnXWnu/Sm+phgQV7zPmT+XH/0AOBfYVb2PSwTWrxADkPRTvjhPWR1mB
         mj1R525o6V0bLnee7hk9bPr4IsDXqCcRw1HxsKvZN19HqbYzHRo3pLhg4S5iVq0HGVCs
         WGUuDg+Z1eF8S5FHfqCDhrtId75Kkf9hPzTCLKPYDDG7INIRaJS75sw27mZMumBT+N6w
         txYcmNZxhoXVf9YHsvObA5fjHmSKIZe92DrxZUg/DPcN7lXD9JefYrySb8j9VEjA5XAP
         5MQg==
X-Gm-Message-State: ABy/qLZgonvTZ9Fr1+efH3bqbHOx7nMjqKYGxnTYvTxUA+Ijj+DzIYtz
        fkuSSOm4115pzWeIaN9TjW/coJnZUpO2p9utP5ukvw==
X-Google-Smtp-Source: APBJJlGS78CxeK7LA351EB5LlgyG8jCyzMm0kHKbXF8qhmD/ps/zRVZKSlybWZXu7XrOr3nB/KH+BbW3XCpYEtlFswU=
X-Received: by 2002:a05:622a:1310:b0:3f8:175a:4970 with SMTP id
 v16-20020a05622a131000b003f8175a4970mr29582qtk.18.1688520225804; Tue, 04 Jul
 2023 18:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-4-ryan.roberts@arm.com> <ac6802f6-01a2-6b39-38c7-2fe3cea75dde@intel.com>
 <CAOUHufbmv0pZ1h9AxBj-SD7OqRZYudHMtXzQxcwD4ky-sFd8kg@mail.gmail.com>
 <CAOUHufbpCU_Z7g1QPJ0+HzE9sdNpSh=Mzi0EByLPu5TE4S_UcQ@mail.gmail.com> <6d389825-1fc0-5c16-7858-2290fd632682@arm.com>
In-Reply-To: <6d389825-1fc0-5c16-7858-2290fd632682@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 4 Jul 2023 19:23:09 -0600
Message-ID: <CAOUHufZY-zN8jjQz+iMzwmqMb2VCh7=N+YxfXobgF7i1zUmTNA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: Default implementation of arch_wants_pte_order()
To:     Ryan Roberts <ryan.roberts@arm.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: multipart/mixed; boundary="00000000000041d5db05ffb340fc"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000041d5db05ffb340fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 4, 2023 at 6:36=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 04/07/2023 04:59, Yu Zhao wrote:
> > On Mon, Jul 3, 2023 at 9:02=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrot=
e:
> >>
> >> On Mon, Jul 3, 2023 at 8:23=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel=
.com> wrote:
> >>>
> >>>
> >>>
> >>> On 7/3/2023 9:53 PM, Ryan Roberts wrote:
> >>>> arch_wants_pte_order() can be overridden by the arch to return the
> >>>> preferred folio order for pte-mapped memory. This is useful as some
> >>>> architectures (e.g. arm64) can coalesce TLB entries when the physica=
l
> >>>> memory is suitably contiguous.
> >>>>
> >>>> The first user for this hint will be FLEXIBLE_THP, which aims to
> >>>> allocate large folios for anonymous memory to reduce page faults and
> >>>> other per-page operation costs.
> >>>>
> >>>> Here we add the default implementation of the function, used when th=
e
> >>>> architecture does not define it, which returns the order correspondi=
ng
> >>>> to 64K.
> >>>>
> >>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>> ---
> >>>>  include/linux/pgtable.h | 13 +++++++++++++
> >>>>  1 file changed, 13 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >>>> index a661a17173fa..f7e38598f20b 100644
> >>>> --- a/include/linux/pgtable.h
> >>>> +++ b/include/linux/pgtable.h
> >>>> @@ -13,6 +13,7 @@
> >>>>  #include <linux/errno.h>
> >>>>  #include <asm-generic/pgtable_uffd.h>
> >>>>  #include <linux/page_table_check.h>
> >>>> +#include <linux/sizes.h>
> >>>>
> >>>>  #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_F=
OLDED) - \
> >>>>       defined(__PAGETABLE_PMD_FOLDED) !=3D CONFIG_PGTABLE_LEVELS
> >>>> @@ -336,6 +337,18 @@ static inline bool arch_has_hw_pte_young(void)
> >>>>  }
> >>>>  #endif
> >>>>
> >>>> +#ifndef arch_wants_pte_order
> >>>> +/*
> >>>> + * Returns preferred folio order for pte-mapped memory. Must be in =
range [0,
> >>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires=
 large folios
> >>>> + * to be at least order-2.
> >>>> + */
> >>>> +static inline int arch_wants_pte_order(struct vm_area_struct *vma)
> >>>> +{
> >>>> +     return ilog2(SZ_64K >> PAGE_SHIFT);
> >>> Default value which is not related with any silicon may be: PAGE_ALLO=
C_COSTLY_ORDER?
> >>>
> >>> Also, current pcp list support cache page with order 0...PAGE_ALLOC_C=
OSTLY_ORDER, 9.
> >>> If the pcp could cover the page, the pressure to zone lock will be re=
duced by pcp.
> >>
> >> The value of PAGE_ALLOC_COSTLY_ORDER is reasonable but again it's a
> >> s/w policy not a h/w preference. Besides, I don't think we can include
> >> mmzone.h in pgtable.h.
> >
> > I think we can make a compromise:
> > 1. change the default implementation of arch_has_hw_pte_young() to retu=
rn 0, and
> > 2. in memory.c, we can try PAGE_ALLOC_COSTLY_ORDER for archs that
> > don't override arch_has_hw_pte_young(), or if its return value is too
> > large to fit.
> > This should also take care of the regression, right?
>
> I think you are suggesting that we use 0 as a sentinel which we then tran=
slate
> to PAGE_ALLOC_COSTLY_ORDER? I already have a max_anon_folio_order() funct=
ion in
> memory.c (actually it is currently a macro defined as arch_wants_pte_orde=
r()).
>
> So it would become (I'll talk about the vma concern separately in the thr=
ead
> where you raised it):
>
> static inline int max_anon_folio_order(struct vm_area_struct *vma)
> {
>         int order =3D arch_wants_pte_order(vma);
>
>         return order ? order : PAGE_ALLOC_COSTLY_ORDER;
> }
>
> Correct?
>
> I don't see how it fixes the regression (assume you're talking about
> Speedometer) though? On arm64 arch_wants_pte_order() will still be return=
ing
> order-4.

Here is what I was actually suggesting -- I think the problem was
because contpte is a bit too large for that benchmark and for the page
allocator too, unfortunately. The following allows one retry (32KB)
before fallback to order 0 when using contpte (64KB). There is no
retry for HPA (16KB) and other archs.

+       int preferred =3D arch_wants_pte_order(vma) ? : PAGE_ALLOC_COSTLY_O=
RDER;
+       int orders[] =3D {
+               preferred,
+               preferred > PAGE_ALLOC_COSTLY_ORDER ?
PAGE_ALLOC_COSTLY_ORDER : 0,
+               0,
+       };

I'm attaching a patch which fills in the two helpers I left empty here [1].

Would the above work for Intel, Fengwei?

(AMD wouldn't need to override arch_wants_pte_order() since PTE
coalescing on Zen is also PAGE_ALLOC_COSTLY_ORDER.)

[1] https://lore.kernel.org/linux-mm/CAOUHufaK82K8Sa35T7z3=3Dgkm4GB0cWD3aqe=
ZF6mYx82v7cOTeA@mail.gmail.com/2-anon_folios.patch

--00000000000041d5db05ffb340fc
Content-Type: application/octet-stream; name="fallback.patch"
Content-Disposition: attachment; filename="fallback.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ljp18mlu0>
X-Attachment-Id: f_ljp18mlu0

ZGlmZiAtLWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMKaW5kZXggZjY5ZmJjMjUxMTk4
Li5jMTljYmJhNjBkMDQgMTAwNjQ0Ci0tLSBhL21tL21lbW9yeS5jCisrKyBiL21tL21lbW9yeS5j
CkBAIC00MDIzLDYgKzQwMjMsNzUgQEAgdm1fZmF1bHRfdCBkb19zd2FwX3BhZ2Uoc3RydWN0IHZt
X2ZhdWx0ICp2bWYpCiAJcmV0dXJuIHJldDsKIH0KIAorc3RhdGljIGJvb2wgdm1mX3B0ZV9yYW5n
ZV9jaGFuZ2VkKHN0cnVjdCB2bV9mYXVsdCAqdm1mLCBpbnQgbnJfcGFnZXMpCit7CisJaW50IGk7
CisKKwlpZiAobnJfcGFnZXMgPT0gMSkKKwkJcmV0dXJuIHZtZl9wdGVfY2hhbmdlZCh2bWYpOwor
CisJZm9yIChpID0gMDsgaSA8IG5yX3BhZ2VzOyBpKyspIHsKKwkJaWYgKCFwdGVfbm9uZShwdGVw
X2dldF9sb2NrbGVzcyh2bWYtPnB0ZSArIGkpKSkKKwkJCXJldHVybiB0cnVlOworCX0KKworCXJl
dHVybiBmYWxzZTsKK30KKworI2lmZGVmIENPTkZJR19GTEVYSUJMRV9USFAKK3N0YXRpYyBzdHJ1
Y3QgZm9saW8gKmFsbG9jX2Fub25fZm9saW8oc3RydWN0IHZtX2ZhdWx0ICp2bWYpCit7CisJaW50
IGk7CisJdW5zaWduZWQgbG9uZyBhZGRyOworCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hID0g
dm1mLT52bWE7CisJaW50IHByZWZlcnJlZCA9IGFyY2hfd2FudHNfcHRlX29yZGVyKHZtYSkgPyA6
IFBBR0VfQUxMT0NfQ09TVExZX09SREVSOworCWludCBvcmRlcnNbXSA9IHsKKwkJcHJlZmVycmVk
LAorCQlwcmVmZXJyZWQgPiBQQUdFX0FMTE9DX0NPU1RMWV9PUkRFUiA/IFBBR0VfQUxMT0NfQ09T
VExZX09SREVSIDogMCwKKwkJMCwKKwl9OworCisJaWYgKHZtZl9vcmlnX3B0ZV91ZmZkX3dwKHZt
ZikpCisJCWdvdG8gZmFsbGJhY2s7CisKKwlmb3IgKGkgPSAwOyBvcmRlcnNbaV07IGkrKykgewor
CQlhZGRyID0gQUxJR05fRE9XTih2bWYtPmFkZHJlc3MsIFBBR0VfU0laRSA8PCBvcmRlcnNbaV0p
OworCQlpZiAoYWRkciA+PSB2bWEtPnZtX3N0YXJ0ICYmIGFkZHIgKyAoUEFHRV9TSVpFIDw8IG9y
ZGVyc1tpXSkgPD0gdm1hLT52bV9lbmQpCisJCQlicmVhazsKKwl9CisKKwlpZiAoIW9yZGVyc1tp
XSkKKwkJZ290byBmYWxsYmFjazsKKworCXZtZi0+cHRlID0gcHRlX29mZnNldF9tYXAodm1mLT5w
bWQsIGFkZHIpOworCisJZm9yICg7IG9yZGVyc1tpXTsgaSsrKSB7CisJCWlmICghdm1mX3B0ZV9y
YW5nZV9jaGFuZ2VkKHZtZiwgMSA8PCBvcmRlcnNbaV0pKQorCQkJYnJlYWs7CisJfQorCisJcHRl
X3VubWFwKHZtZi0+cHRlKTsKKwl2bWYtPnB0ZSA9IE5VTEw7CisKKwlmb3IgKDsgb3JkZXJzW2ld
OyBpKyspIHsKKwkJc3RydWN0IGZvbGlvICpmb2xpbworCQlnZnBfdCBnZnAgPSB2bWFfdGhwX2dm
cF9tYXNrKHZtYSk7CisKKwkJYWRkciA9IEFMSUdOX0RPV04odm1mLT5hZGRyZXNzLCBQQUdFX1NJ
WkUgPDwgb3JkZXJzW2ldKTsKKwkJZm9saW8gPSB2bWFfYWxsb2NfZm9saW8oZ2ZwLCBvcmRlcnNb
aV0sIHZtYSwgYWRkciwgdHJ1ZSk7CisJCWlmIChmb2xpbykgeworCQkJY2xlYXJfaHVnZV9wYWdl
KCZmb2xpby0+cGFnZSwgYWRkciwgMSA8PCBvcmRlcnNbaV0pOworCQkJdm1mLT5hZGRyZXNzID0g
YWRkcjsKKwkJCXJldHVybiBmb2xpbzsKKwkJfQorCX0KK2ZhbGxiYWNrOgorCXJldHVybiB2bWFf
YWxsb2NfemVyb2VkX21vdmFibGVfZm9saW8odm1hLCB2bWYtPmFkZHJlc3MpOworfQorI2Vsc2UK
KyNkZWZpbmUgYWxsb2NfYW5vbl9mb2xpbyh2bWYpIHZtYV9hbGxvY196ZXJvZWRfbW92YWJsZV9m
b2xpbygodm1mKS0+dm1hLCAodm1mKS0+YWRkcmVzcykKKyNlbmRpZgorCiAvKgogICogV2UgZW50
ZXIgd2l0aCBub24tZXhjbHVzaXZlIG1tYXBfbG9jayAodG8gZXhjbHVkZSB2bWEgY2hhbmdlcywK
ICAqIGJ1dCBhbGxvdyBjb25jdXJyZW50IGZhdWx0cyksIGFuZCBwdGUgbWFwcGVkIGJ1dCBub3Qg
eWV0IGxvY2tlZC4K
--00000000000041d5db05ffb340fc--
