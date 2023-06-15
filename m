Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37682730EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjFOFnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFOFnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:43:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336E119AC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:43:44 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f9e1ebbf31so26424041cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686807823; x=1689399823;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eRrd2SfL4Xq+Qzlde4byl/Mqw4CTwFxn/EHYJGCDi2o=;
        b=2Z7L9X7Cuz2Oyte+IvVcvqPnbKLYUfuY1R9BtMGG0J05LIt9GtujxDwMANNce+H9be
         1z+5fSn5rZbBfwpNBHMCHQTEt7r2ARnJZD4HmYlbiXjep29V5NVaOTCftWc9gkoAhWJa
         uPYbDVoQWXGt21wgmIfd4jJ+zSKMxHNxejY3S9955YhxFpNw8KNOVdBeTBK9VcMzXdSf
         zW63lp/Nu61EnGTo9OCeOBp2j7uYJVihGlKySXjg4jBQHLrqGrUqoqqvFs3XFDuMKL/D
         /4nh40CVn9AErK+sDDluhaEObQY5QmYX3G2ELxb8vXLyXw9UPuCRujZhQgGomIHrlC9p
         H4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686807823; x=1689399823;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRrd2SfL4Xq+Qzlde4byl/Mqw4CTwFxn/EHYJGCDi2o=;
        b=aS8RF7rlAj7YG8jWkNbsqATlg/Cg0pjoTOe3FbYd6jWiiiGWmIAXHV971uLgTSbbQn
         HsQUp/SgHksYSPN85fvAZm9jHYBKh5EfEC81kEtiOMIwA+VwV7cdoN08HeAtwFx6IoAC
         eKbUJU+wKrmqgJGx4SM8UQ9EQYNZF+nuDxBPukzzYmpwYmLLIS8PIy6Xv3wU2J7GA+uk
         UM9rNLmSneiyyeZd1y+xx0dVxpwAO5ARRksbDoPTao/uJfzZ6N9r46Jqkv5h29kBHTpg
         JDDtSEnuS27dQQDQRD3SE6QiHrjGX2DJELc46SDDW4HPpvARuqXnfgI3IWyvJBHFXkmB
         jOzw==
X-Gm-Message-State: AC+VfDx3NWDWj/DwervGYusAFknTg2Hc59EGlQghn6+ppmtgxLF7jS0H
        klPyIqObDdXg8l2TKJj/sr3MEw==
X-Google-Smtp-Source: ACHHUZ6zMyIyOB2jswKUAs88szNyVc0zWzzsUusKENsgVVPW4FW+EMXzWPoYN4vcolCRWWFQ+K0QSA==
X-Received: by 2002:a05:622a:148a:b0:3f9:a73b:57a2 with SMTP id t10-20020a05622a148a00b003f9a73b57a2mr5187181qtx.26.1686807823123;
        Wed, 14 Jun 2023 22:43:43 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k34-20020a25b2a2000000b00bcdb7d2a03bsm1631948ybj.17.2023.06.14.22.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 22:43:42 -0700 (PDT)
Date:   Wed, 14 Jun 2023 22:43:30 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Nathan Chancellor <nathan@kernel.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/23] mips: update_mmu_cache() can replace
 __update_tlb()
In-Reply-To: <f5526f17-9d78-f7ea-427a-7e76bfeb6b8@google.com>
Message-ID: <344a4da-3890-45fd-607e-b5f85ca6ad48@google.com>
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com> <178970b0-1539-8aac-76fd-972c6c46ec17@google.com> <20230614231758.GA1503611@dev-arch.thelio-3990X> <f5526f17-9d78-f7ea-427a-7e76bfeb6b8@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-383800441-1686807822=:3640"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-383800441-1686807822=:3640
Content-Type: text/plain; charset=US-ASCII

On Wed, 14 Jun 2023, Hugh Dickins wrote:
> On Wed, 14 Jun 2023, Nathan Chancellor wrote:
> > 
> > I just bisected a crash while powering down a MIPS machine in QEMU to
> > this change as commit 8044511d3893 ("mips: update_mmu_cache() can
> > replace __update_tlb()") in linux-next.
> 
> Thank you, Nathan, that's very helpful indeed.  This patch certainly knew
> that it wanted testing, and I'm glad to hear that it is now seeing some.
> 
> While powering down?  The messages below look like it was just coming up,
> but no doubt that's because you were bisecting (or because I'm unfamiliar
> with what messages to expect there).  It's probably irrelevant information,
> but I wonder whether the (V)machine worked well enough for a while before
> you first powered down and spotted the problem, or whether it's never got
> much further than trying to run init (busybox)?  I'm trying to get a feel
> for whether the problem occurs under common or uncommon conditions.
> 
> > Unfortunately, I can still
> > reproduce it with the existing fix you have for this change on the
> > mailing list, which is present in next-20230614.
> 
> Right, that later fix was only for a build warning, nothing functional
> (or at least I hoped that it wasn't making any functional difference).
> 
> Thanks a lot for the detailed instructions below: unfortunately, those
> would draw me into a realm of testing I've never needed to enter before,
> so a lot of time spent on setup and learning.  Usually, I just stare at
> the source.
> 
> What this probably says is that I should revert most my cleanup there,
> and keep as close to the existing code as possible.  But some change is
> needed, and I may need to understand (or have a good guess at) what was
> going wrong, to decide what kind of retreat will be successful.
> 
> Back to the source for a while: I hope I'll find examples in nearby MIPS
> kernel source (and git history), which will hint at the right way forward.
> Then send you a patch against next-20230614 to try, when I'm reasonably
> confident that it's enough to satisfy my purpose, but likely not to waste
> your time.

I'm going to take advantage of your good nature by attaching
two alternative patches, either to go on top of next-20230614.

mips1.patch,
 arch/mips/mm/tlb-r4k.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

is by far my favourite.  I couldn't see anything wrong with what's
already there for mips, but it seems possible that (though I didn't
find it) somewhere calls update_mmu_cache_pmd() on a page table.  So
mips1.patch restores the pmd_huge() check, and cleans up further by
removing the silly pgdp, p4dp, pudp, pmdp stuff: the pointer has now
been passed in by the caller, why walk the tree again?  I should have
done it this way before.

But if that doesn't work, then I'm afraid it will have to be
mips2.patch,
 arch/mips/include/asm/pgtable.h |   15 ++++++++++++---
 arch/mips/mm/tlb-r3k.c          |    5 ++---
 arch/mips/mm/tlb-r4k.c          |   27 ++++++++++++++++++---------
 3 files changed, 32 insertions(+), 15 deletions(-)

which reverts all of the original patch and its build warning fix,
and does a pte_unmap() to balance the silly pte_offset_map() there;
with an apologetic comment for this being about the only place in
the tree where I have no idea what to do if ptep were NULL.

I do hope that you find the first fixes the breakage; but if not, then
I even more fervently hope that the second will, despite my hating it.
Touch wood for the first, fingers crossed for the second, thanks,

Hugh
---1463760895-383800441-1686807822=:3640
Content-Type: text/x-patch; name=mips1.patch
Content-Transfer-Encoding: BASE64
Content-ID: <dfc4bf4-a2b3-2391-3c22-48bdb4bf1fe@google.com>
Content-Description: 
Content-Disposition: attachment; filename=mips1.patch

LS0tIGEvYXJjaC9taXBzL21tL3RsYi1yNGsuYw0KKysrIGIvYXJjaC9taXBz
L21tL3RsYi1yNGsuYw0KQEAgLTI5MywxMiArMjkzLDYgQEAgdm9pZCBsb2Nh
bF9mbHVzaF90bGJfb25lKHVuc2lnbmVkIGxvbmcgcGFnZSkNCiB2b2lkIHVw
ZGF0ZV9tbXVfY2FjaGUoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQog
CQkgICAgICB1bnNpZ25lZCBsb25nIGFkZHJlc3MsIHB0ZV90ICpwdGVwKQ0K
IHsNCi0jaWZkZWYgQ09ORklHX01JUFNfSFVHRV9UTEJfU1VQUE9SVA0KLQlw
Z2RfdCAqcGdkcDsNCi0JcDRkX3QgKnA0ZHA7DQotCXB1ZF90ICpwdWRwOw0K
LQlwbWRfdCAqcG1kcDsNCi0jZW5kaWYNCiAJdW5zaWduZWQgbG9uZyBmbGFn
czsNCiAJaW50IGlkeCwgcGlkOw0KIA0KQEAgLTMyMywxMiArMzE3LDggQEAg
dm9pZCB1cGRhdGVfbW11X2NhY2hlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hLA0KIAl0bGJfcHJvYmVfaGF6YXJkKCk7DQogCWlkeCA9IHJlYWRfYzBf
aW5kZXgoKTsNCiAjaWZkZWYgQ09ORklHX01JUFNfSFVHRV9UTEJfU1VQUE9S
VA0KLQlwZ2RwID0gcGdkX29mZnNldCh2bWEtPnZtX21tLCBhZGRyZXNzKTsN
Ci0JcDRkcCA9IHA0ZF9vZmZzZXQocGdkcCwgYWRkcmVzcyk7DQotCXB1ZHAg
PSBwdWRfb2Zmc2V0KHA0ZHAsIGFkZHJlc3MpOw0KLQlwbWRwID0gcG1kX29m
ZnNldChwdWRwLCBhZGRyZXNzKTsNCiAJLyogdGhpcyBjb3VsZCBiZSBhIGh1
Z2UgcGFnZSAgKi8NCi0JaWYgKHB0ZXAgPT0gKHB0ZV90ICopcG1kcCkgew0K
KwlpZiAocG1kX2h1Z2UoKihwbWRfdCAqKXB0ZXApKSB7DQogCQl1bnNpZ25l
ZCBsb25nIGxvOw0KIAkJd3JpdGVfYzBfcGFnZW1hc2soUE1fSFVHRV9NQVNL
KTsNCiAJCWxvID0gcHRlX3RvX2VudHJ5bG8ocHRlX3ZhbCgqcHRlcCkpOw0K

---1463760895-383800441-1686807822=:3640
Content-Type: text/x-patch; name=mips2.patch
Content-Transfer-Encoding: BASE64
Content-ID: <fcb37a0-1034-08e-eaf8-eb90a6338585@google.com>
Content-Description: 
Content-Disposition: attachment; filename=mips2.patch

LS0tIGEvYXJjaC9taXBzL2luY2x1ZGUvYXNtL3BndGFibGUuaA0KKysrIGIv
YXJjaC9taXBzL2luY2x1ZGUvYXNtL3BndGFibGUuaA0KQEAgLTU2NSw4ICs1
NjUsMTUgQEAgc3RhdGljIGlubGluZSBwdGVfdCBwdGVfc3dwX2NsZWFyX2V4
Y2x1c2l2ZShwdGVfdCBwdGUpDQogfQ0KICNlbmRpZg0KIA0KLWV4dGVybiB2
b2lkIHVwZGF0ZV9tbXVfY2FjaGUoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2
bWEsDQotCXVuc2lnbmVkIGxvbmcgYWRkcmVzcywgcHRlX3QgKnB0ZXApOw0K
K2V4dGVybiB2b2lkIF9fdXBkYXRlX3RsYihzdHJ1Y3Qgdm1fYXJlYV9zdHJ1
Y3QgKnZtYSwgdW5zaWduZWQgbG9uZyBhZGRyZXNzLA0KKwlwdGVfdCBwdGUp
Ow0KKw0KK3N0YXRpYyBpbmxpbmUgdm9pZCB1cGRhdGVfbW11X2NhY2hlKHN0
cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KKwl1bnNpZ25lZCBsb25nIGFk
ZHJlc3MsIHB0ZV90ICpwdGVwKQ0KK3sNCisJcHRlX3QgcHRlID0gKnB0ZXA7
DQorCV9fdXBkYXRlX3RsYih2bWEsIGFkZHJlc3MsIHB0ZSk7DQorfQ0KIA0K
ICNkZWZpbmUJX19IQVZFX0FSQ0hfVVBEQVRFX01NVV9UTEINCiAjZGVmaW5l
IHVwZGF0ZV9tbXVfdGxiCXVwZGF0ZV9tbXVfY2FjaGUNCkBAIC01NzQsNyAr
NTgxLDkgQEAgZXh0ZXJuIHZvaWQgdXBkYXRlX21tdV9jYWNoZShzdHJ1Y3Qg
dm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCiBzdGF0aWMgaW5saW5lIHZvaWQgdXBk
YXRlX21tdV9jYWNoZV9wbWQoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEs
DQogCXVuc2lnbmVkIGxvbmcgYWRkcmVzcywgcG1kX3QgKnBtZHApDQogew0K
LQl1cGRhdGVfbW11X2NhY2hlKHZtYSwgYWRkcmVzcywgKHB0ZV90ICopcG1k
cCk7DQorCXB0ZV90IHB0ZSA9ICoocHRlX3QgKilwbWRwOw0KKw0KKwlfX3Vw
ZGF0ZV90bGIodm1hLCBhZGRyZXNzLCBwdGUpOw0KIH0NCiANCiAvKg0KLS0t
IGEvYXJjaC9taXBzL21tL3RsYi1yM2suYw0KKysrIGIvYXJjaC9taXBzL21t
L3RsYi1yM2suYw0KQEAgLTE3Niw4ICsxNzYsNyBAQCB2b2lkIGxvY2FsX2Zs
dXNoX3RsYl9wYWdlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNp
Z25lZCBsb25nIHBhZ2UpDQogCX0NCiB9DQogDQotdm9pZCB1cGRhdGVfbW11
X2NhY2hlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KLQkJICAgICAg
dW5zaWduZWQgbG9uZyBhZGRyZXNzLCBwdGVfdCAqcHRlcCkNCit2b2lkIF9f
dXBkYXRlX3RsYihzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWdu
ZWQgbG9uZyBhZGRyZXNzLCBwdGVfdCBwdGUpDQogew0KIAl1bnNpZ25lZCBs
b25nIGFzaWRfbWFzayA9IGNwdV9hc2lkX21hc2soJmN1cnJlbnRfY3B1X2Rh
dGEpOw0KIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KQEAgLTIwNCw3ICsyMDMs
NyBAQCB2b2lkIHVwZGF0ZV9tbXVfY2FjaGUoc3RydWN0IHZtX2FyZWFfc3Ry
dWN0ICp2bWEsDQogCUJBUlJJRVI7DQogCXRsYl9wcm9iZSgpOw0KIAlpZHgg
PSByZWFkX2MwX2luZGV4KCk7DQotCXdyaXRlX2MwX2VudHJ5bG8wKHB0ZV92
YWwoKnB0ZXApKTsNCisJd3JpdGVfYzBfZW50cnlsbzAocHRlX3ZhbChwdGUp
KTsNCiAJd3JpdGVfYzBfZW50cnloaShhZGRyZXNzIHwgcGlkKTsNCiAJaWYg
KGlkeCA8IDApIHsJCQkJCS8qIEJBUlJJRVIgKi8NCiAJCXRsYl93cml0ZV9y
YW5kb20oKTsNCi0tLSBhL2FyY2gvbWlwcy9tbS90bGItcjRrLmMNCisrKyBi
L2FyY2gvbWlwcy9tbS90bGItcjRrLmMNCkBAIC0yOTAsMTYgKzI5MCwxNCBA
QCB2b2lkIGxvY2FsX2ZsdXNoX3RsYl9vbmUodW5zaWduZWQgbG9uZyBwYWdl
KQ0KICAqIHVwZGF0ZXMgdGhlIFRMQiB3aXRoIHRoZSBuZXcgcHRlKHMpLCBh
bmQgYW5vdGhlciB3aGljaCBhbHNvIGNoZWNrcw0KICAqIGZvciB0aGUgUjRr
ICJlbmQgb2YgcGFnZSIgaGFyZHdhcmUgYnVnIGFuZCBkb2VzIHRoZSBuZWVk
eS4NCiAgKi8NCi12b2lkIHVwZGF0ZV9tbXVfY2FjaGUoc3RydWN0IHZtX2Fy
ZWFfc3RydWN0ICp2bWEsDQotCQkgICAgICB1bnNpZ25lZCBsb25nIGFkZHJl
c3MsIHB0ZV90ICpwdGVwKQ0KK3ZvaWQgX191cGRhdGVfdGxiKHN0cnVjdCB2
bV9hcmVhX3N0cnVjdCAqIHZtYSwgdW5zaWduZWQgbG9uZyBhZGRyZXNzLCBw
dGVfdCBwdGUpDQogew0KLSNpZmRlZiBDT05GSUdfTUlQU19IVUdFX1RMQl9T
VVBQT1JUDQorCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQogCXBnZF90ICpwZ2Rw
Ow0KIAlwNGRfdCAqcDRkcDsNCiAJcHVkX3QgKnB1ZHA7DQogCXBtZF90ICpw
bWRwOw0KLSNlbmRpZg0KLQl1bnNpZ25lZCBsb25nIGZsYWdzOw0KKwlwdGVf
dCAqcHRlcCwgKnB0ZW1hcCA9IE5VTEw7DQogCWludCBpZHgsIHBpZDsNCiAN
CiAJLyoNCkBAIC0zMTgsMTkgKzMxNiwyMCBAQCB2b2lkIHVwZGF0ZV9tbXVf
Y2FjaGUoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQogCQlwaWQgPSBy
ZWFkX2MwX2VudHJ5aGkoKSAmIGNwdV9hc2lkX21hc2soJmN1cnJlbnRfY3B1
X2RhdGEpOw0KIAkJd3JpdGVfYzBfZW50cnloaShhZGRyZXNzIHwgcGlkKTsN
CiAJfQ0KKwlwZ2RwID0gcGdkX29mZnNldCh2bWEtPnZtX21tLCBhZGRyZXNz
KTsNCiAJbXRjMF90bGJ3X2hhemFyZCgpOw0KIAl0bGJfcHJvYmUoKTsNCiAJ
dGxiX3Byb2JlX2hhemFyZCgpOw0KLQlpZHggPSByZWFkX2MwX2luZGV4KCk7
DQotI2lmZGVmIENPTkZJR19NSVBTX0hVR0VfVExCX1NVUFBPUlQNCi0JcGdk
cCA9IHBnZF9vZmZzZXQodm1hLT52bV9tbSwgYWRkcmVzcyk7DQogCXA0ZHAg
PSBwNGRfb2Zmc2V0KHBnZHAsIGFkZHJlc3MpOw0KIAlwdWRwID0gcHVkX29m
ZnNldChwNGRwLCBhZGRyZXNzKTsNCiAJcG1kcCA9IHBtZF9vZmZzZXQocHVk
cCwgYWRkcmVzcyk7DQorCWlkeCA9IHJlYWRfYzBfaW5kZXgoKTsNCisjaWZk
ZWYgQ09ORklHX01JUFNfSFVHRV9UTEJfU1VQUE9SVA0KIAkvKiB0aGlzIGNv
dWxkIGJlIGEgaHVnZSBwYWdlICAqLw0KLQlpZiAocHRlcCA9PSAocHRlX3Qg
KilwbWRwKSB7DQorCWlmIChwbWRfaHVnZSgqcG1kcCkpIHsNCiAJCXVuc2ln
bmVkIGxvbmcgbG87DQogCQl3cml0ZV9jMF9wYWdlbWFzayhQTV9IVUdFX01B
U0spOw0KKwkJcHRlcCA9IChwdGVfdCAqKXBtZHA7DQogCQlsbyA9IHB0ZV90
b19lbnRyeWxvKHB0ZV92YWwoKnB0ZXApKTsNCiAJCXdyaXRlX2MwX2VudHJ5
bG8wKGxvKTsNCiAJCXdyaXRlX2MwX2VudHJ5bG8xKGxvICsgKEhQQUdFX1NJ
WkUgPj4gNykpOw0KQEAgLTM0NSw2ICszNDQsMTMgQEAgdm9pZCB1cGRhdGVf
bW11X2NhY2hlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KIAl9IGVs
c2UNCiAjZW5kaWYNCiAJew0KKwkJcHRlbWFwID0gcHRlcCA9IHB0ZV9vZmZz
ZXRfbWFwKHBtZHAsIGFkZHJlc3MpOw0KKwkJLyoNCisJCSAqIHVwZGF0ZV9t
bXVfY2FjaGUoKSBpcyBjYWxsZWQgYmV0d2VlbiBwdGVfb2Zmc2V0X21hcF9s
b2NrKCkNCisJCSAqIGFuZCBwdGVfdW5tYXBfdW5sb2NrKCksIHNvIHdlIGNh
biBhc3N1bWUgdGhhdCBwdGVwIGlzIG5vdA0KKwkJICogTlVMTCBoZXJlOiBh
bmQgd2hhdCBzaG91bGQgYmUgZG9uZSBiZWxvdyBpZiBpdCB3ZXJlIE5VTEw/
DQorCQkgKi8NCisNCiAjaWYgZGVmaW5lZChDT05GSUdfUEhZU19BRERSX1Rf
NjRCSVQpICYmIGRlZmluZWQoQ09ORklHX0NQVV9NSVBTMzIpDQogI2lmZGVm
IENPTkZJR19YUEENCiAJCXdyaXRlX2MwX2VudHJ5bG8wKHB0ZV90b19lbnRy
eWxvKHB0ZXAtPnB0ZV9oaWdoKSk7DQpAQCAtMzcyLDYgKzM3OCw5IEBAIHZv
aWQgdXBkYXRlX21tdV9jYWNoZShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZt
YSwNCiAJdGxid191c2VfaGF6YXJkKCk7DQogCWh0d19zdGFydCgpOw0KIAlm
bHVzaF9taWNyb190bGJfdm0odm1hKTsNCisNCisJaWYgKHB0ZW1hcCkNCisJ
CXB0ZV91bm1hcChwdGVtYXApOw0KIAlsb2NhbF9pcnFfcmVzdG9yZShmbGFn
cyk7DQogfQ0KIA0K

---1463760895-383800441-1686807822=:3640--
