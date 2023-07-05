Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA850748CAC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjGETB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjGETBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:01:53 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDE61BD0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:01:24 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40371070eb7so53431cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688583652; x=1691175652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OITnOvAqfmF3APphO2YPTUuojde3xlf8Wp9Fl9uS9Ho=;
        b=5asZfcaPR/kXVZkfDSDQCAkyj41E7Mn49HEgpWBY4BnkAGfRUpGYpBrFa2d4uRwV81
         AY3J3+kFsiT9Mua58nTONYdK6I6iEWY488PIdm2c2tDK5+ltH2u+X6HQjGr9a9OmonpT
         3yzmh84oQntEmSaY2zHErQktJ9keN/6Se2l18d72s3o7gRpiMWw/7GyRK+ob3WRdfn87
         vrlVxiUdsjgfhrL2ykVWv082vA4ZLWtqhtWFsFlIgunplQ39sVHiX7FfRsqo+S7haXcG
         Q9kUjwDwB87g3LoBN1PskvEm0UPNDyIlFBmpwo6vPb2hrqK8t+ynB0/fGH5RnlPY6dnD
         nYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688583652; x=1691175652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OITnOvAqfmF3APphO2YPTUuojde3xlf8Wp9Fl9uS9Ho=;
        b=DUtrP3WyNzA/HRQglOCP9zDsMi2uoUgiN+429sE5KPBokV47hbFWPdKeOwBS7mghW3
         VuH3wPQ5Bn1/wRI+qHMjyOx17ewv5xmahI5h1lraRTPrhIA4t905ETIOb6QiCzoM/9Zb
         0+KeRaAZU/SlxGWcbwNAgvq3nep4KWWLsZBWSp73oo/QPHEON9H89PUOIAbfBBtgw08g
         aGn14IOp/CqaSFu2VaASKQIf9zqNNozCxyHgftl84maKp3Uq0Q42JGrwtXOBG+66fdlU
         bZtSe4oSg/84EnzI29suJtIhHsAISuI0gW+IYhMfgh3lOdhBj5TrO17mf21JnrzT9z8q
         dIVQ==
X-Gm-Message-State: ABy/qLYOb9rQ8gZXXgp1nZugzAJdkil6cng8n1+1o/+mJLInou5IFYBY
        TOvJQaOQFNf0X64AMIvgzw4Aq4zeoX/p/2W7mTSGgA==
X-Google-Smtp-Source: APBJJlHwBBZvL0fTm8ZASUdxFl+TYSeIVPIclGJHzukG5JdXMnknj8OHvk1ohGrLJ8Lvs4C3J6XKthyh1q4UB/r1j8k=
X-Received: by 2002:a05:622a:1308:b0:3f9:56c:1129 with SMTP id
 v8-20020a05622a130800b003f9056c1129mr9448qtk.5.1688583651513; Wed, 05 Jul
 2023 12:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <CAOUHufYB2kB0r9hhSbzfEzdF85MkXVfWoFOhy3LwLfJ5Qo8H6g@mail.gmail.com>
 <69aada71-0b3f-e928-6413-742fe7926576@intel.com> <CAOUHufYsOdywAJMxdh6W-=uLykD=7JrUwgBvUJWvfWJeQ5XxnA@mail.gmail.com>
 <467afd30-c85a-8b9d-97b9-a9ef9d0983af@arm.com> <449183bd-76ef-2a3a-c3f5-0478a7c574ef@intel.com>
 <CAOUHufZkMbgsTU+MqDVDjPbavvisT6EXfcNnWO8oN4XtK9Bgvw@mail.gmail.com> <700df6bb-8005-21be-f39a-cca6a628887b@arm.com>
In-Reply-To: <700df6bb-8005-21be-f39a-cca6a628887b@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 5 Jul 2023 13:00:15 -0600
Message-ID: <CAOUHufbWS6j+0xNc94DvpOt8Nqrrnm6CtATRwD2fCD7oZbbzcA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Yin Fengwei <fengwei.yin@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: multipart/mixed; boundary="000000000000ba612a05ffc2046c"
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

--000000000000ba612a05ffc2046c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 5, 2023 at 4:16=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 05/07/2023 01:21, Yu Zhao wrote:
> > On Tue, Jul 4, 2023 at 5:53=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.c=
om> wrote:
> >>
> >>
> >>
> >> On 7/4/23 23:36, Ryan Roberts wrote:
> >>> On 04/07/2023 08:11, Yu Zhao wrote:
> >>>> On Tue, Jul 4, 2023 at 12:22=E2=80=AFAM Yin, Fengwei <fengwei.yin@in=
tel.com> wrote:
> >>>>>
> >>>>> On 7/4/2023 10:18 AM, Yu Zhao wrote:
> >>>>>> On Mon, Jul 3, 2023 at 7:53=E2=80=AFAM Ryan Roberts <ryan.roberts@=
arm.com> wrote:
> >>>>>>>
> >>>>>>> Hi All,
> >>>>>>>
> >>>>>>> This is v2 of a series to implement variable order, large folios =
for anonymous
> >>>>>>> memory. The objective of this is to improve performance by alloca=
ting larger
> >>>>>>> chunks of memory during anonymous page faults. See [1] for backgr=
ound.
> >>>>>>
> >>>>>> Thanks for the quick response!
> >>>>>>
> >>>>>>> I've significantly reworked and simplified the patch set based on=
 comments from
> >>>>>>> Yu Zhao (thanks for all your feedback!). I've also renamed the fe=
ature to
> >>>>>>> VARIABLE_THP, on Yu's advice.
> >>>>>>>
> >>>>>>> The last patch is for arm64 to explicitly override the default
> >>>>>>> arch_wants_pte_order() and is intended as an example. If this ser=
ies is accepted
> >>>>>>> I suggest taking the first 4 patches through the mm tree and the =
arm64 change
> >>>>>>> could be handled through the arm64 tree separately. Neither has a=
ny build
> >>>>>>> dependency on the other.
> >>>>>>>
> >>>>>>> The one area where I haven't followed Yu's advice is in the deter=
mination of the
> >>>>>>> size of folio to use. It was suggested that I have a single prefe=
rred large
> >>>>>>> order, and if it doesn't fit in the VMA (due to exceeding VMA bou=
nds, or there
> >>>>>>> being existing overlapping populated PTEs, etc) then fallback imm=
ediately to
> >>>>>>> order-0. It turned out that this approach caused a performance re=
gression in the
> >>>>>>> Speedometer benchmark.
> >>>>>>
> >>>>>> I suppose it's regression against the v1, not the unpatched kernel=
.
> >>>>> From the performance data Ryan shared, it's against unpatched kerne=
l:
> >>>>>
> >>>>> Speedometer 2.0:
> >>>>>
> >>>>> | kernel                         |   runs_per_min |
> >>>>> |:-------------------------------|---------------:|
> >>>>> | baseline-4k                    |           0.0% |
> >>>>> | anonfolio-lkml-v1              |           0.7% |
> >>>>> | anonfolio-lkml-v2-simple-order |          -0.9% |
> >>>>> | anonfolio-lkml-v2              |           0.5% |
> >>>>
> >>>> I see. Thanks.
> >>>>
> >>>> A couple of questions:
> >>>> 1. Do we have a stddev?
> >>>
> >>> | kernel                    |   mean_abs |   std_abs |   mean_rel |  =
 std_rel |
> >>> |:------------------------- |-----------:|----------:|-----------:|--=
--------:|
> >>> | baseline-4k               |      117.4 |       0.8 |       0.0% |  =
    0.7% |
> >>> | anonfolio-v1              |      118.2 |         1 |       0.7% |  =
    0.9% |
> >>> | anonfolio-v2-simple-order |      116.4 |       1.1 |      -0.9% |  =
    0.9% |
> >>> | anonfolio-v2              |        118 |       1.2 |       0.5% |  =
    1.0% |
> >>>
> >>> This is with 3 runs per reboot across 5 reboots, with first run after=
 reboot
> >>> trimmed (it's always a bit slower, I assume due to cold page cache). =
So 10 data
> >>> points per kernel in total.
> >>>
> >>> I've rerun the test multiple times and see similar results each time.
> >>>
> >>> I've also run anonfolio-v2 with Kconfig FLEXIBLE_THP=3Ddisabled and i=
n this case I
> >>> see the same performance as baseline-4k.
> >>>
> >>>
> >>>> 2. Do we have a theory why it regressed?
> >>>
> >>> I have a woolly hypothesis; I think Chromium is doing mmap/munmap in =
ways that
> >>> mean when we fault, order-4 is often too big to fit in the VMA. So we=
 fallback
> >>> to order-0. I guess this is happening so often for this workload that=
 the cost
> >>> of doing the checks and fallback is outweighing the benefit of the me=
mory that
> >>> does end up with order-4 folios.
> >>>
> >>> I've sampled the memory in each bucket (once per second) while runnin=
g and its
> >>> roughly:
> >>>
> >>> 64K: 25%
> >>> 32K: 15%
> >>> 16K: 15%
> >>> 4K: 45%
> >>>
> >>> 32K and 16K obviously fold into the 4K bucket with anonfolio-v2-simpl=
e-order.
> >>> But potentially, I suspect there is lots of mmap/unmap for the smalle=
r sizes and
> >>> the 64K contents is more static - that's just a guess though.
> >> So this is like out of vma range thing.
> >>
> >>>
> >>>> Assuming no bugs, I don't see how a real regression could happen --
> >>>> falling back to order-0 isn't different from the original behavior.
> >>>> Ryan, could you `perf record` and `cat /proc/vmstat` and share them?
> >>>
> >>> I can, but it will have to be a bit later in the week. I'll do some m=
ore test
> >>> runs overnight so we have a larger number of runs - hopefully that mi=
ght tell us
> >>> that this is noise to a certain extent.
> >>>
> >>> I'd still like to hear a clear technical argument for why the bin-pac=
king
> >>> approach is not the correct one!
> >> My understanding to Yu's (Yu, correct me if I am wrong) comments is th=
at we
> >> postpone this part of change and make basic anon large folio support i=
n. Then
> >> discuss which approach we should take. Maybe people will agree retry i=
s the
> >> choice, maybe other approach will be taken...
> >>
> >> For example, for this out of VMA range case, per VMA order should be c=
onsidered.
> >> We don't need make decision that the retry should be taken now.
> >
> > I've articulated the reasons in another email. Just summarize the most
> > important point here:
> > using more fallback orders makes a system reach equilibrium faster, at
> > which point it can't allocate the order of arch_wants_pte_order()
> > anymore. IOW, this best-fit policy can reduce the number of folios of
> > the h/w prefered order for a system running long enough.
>
> Thanks for taking the time to write all the arguments down. I understand =
what
> you are saying. If we are considering the whole system, then we also need=
 to
> think about the page cache though, and that will allocate multiple orders=
, so
> you are still going to suffer fragmentation from that user.

1. page cache doesn't use the best-fit policy -- it has the advantage
of having RA hit/miss numbers -- IOW, it doesn't try all orders
without an estimated ROI.
2. page cache causes far less fragmentation in my experience: clean
page cache gets reclaimed first under memory; unmapped page cache is
less costly to migrate. Neither is true for anon, and what makes it
worse is that heavy anon users usually enable zram/zswap: allocating
memory (to store compressed data) under memory pressure makes
reclaim/compaction even harder.

> That said, I like the proposal patch posted where we have up to 3 orders =
that we
> try in order of preference; hw-preferred, PAGE_ALLOC_COSTLY_ORDER and 0. =
That
> feels like a good compromise that allows me to fulfil my objectives. I'm =
going
> to pull this together into a v3 patch set and aim to post towards the end=
 of the
> week.
>
> Are you ok for me to add a Suggested-by: for you? (submitting-patches.rst=
 says I
> need your explicit permission).

Thanks for asking. No need to worry about it -- it's been a great team
work with you, Fengwei, Yang et al.

I'm attaching a single patch containing all pieces I spelled
out/implied/forgot to mention. It doesn't depend on other series -- I
just stress-tested it on top of the latest mm-unstable. Please feel
free to reuse any bits you see fit. Again no need to worry about
Suggested-by.

> On the regression front, I've done a much bigger test run and see the reg=
ression
> is still present (although the mean has shifted a little bit). I've also =
built a
> kernel based on anonfolio-lkml-v2 but where arch_wants_pte_order() return=
s
> order-3. The aim was to test your hypothesis that 64K allocation is slow.=
 This
> kernel is performing even better, so I think that confirms your hypothesi=
s:

Great, thanks for confirming.

> | kernel                         |   runs_per_min |   runs |   sessions |
> |:-------------------------------|---------------:|-------:|-----------:|
> | baseline-4k                    |           0.0% |     75 |         15 |
> | anonfolio-lkml-v1              |           1.0% |     75 |         15 |
> | anonfolio-lkml-v2-simple-order |          -0.4% |     75 |         15 |
> | anonfolio-lkml-v2              |           0.9% |     75 |         15 |
> | anonfolio-lkml-v2-32k          |           1.4% |     10 |          5 |

Since we are all committed to the effort long term, the last number is
good enough for the initial step to conclude. Hopefully v3 can address
all pending comments and get into mm-unstable.

--000000000000ba612a05ffc2046c
Content-Type: application/octet-stream; name="large_anon.patch"
Content-Disposition: attachment; filename="large_anon.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ljq2kej30>
X-Attachment-Id: f_ljq2kej30

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGd0YWJsZS5oIGIvaW5jbHVkZS9saW51eC9wZ3Rh
YmxlLmgKaW5kZXggNTA2M2I0ODJlMzRmLi4xMTNkMzVkOTkzY2UgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbGludXgvcGd0YWJsZS5oCisrKyBiL2luY2x1ZGUvbGludXgvcGd0YWJsZS5oCkBAIC0zMTMs
NiArMzEzLDEzIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBhcmNoX2hhc19od19wdGVfeW91bmcodm9p
ZCkKIH0KICNlbmRpZgogCisjaWZuZGVmIGFyY2hfd2FudHNfcHRlX29yZGVyCitzdGF0aWMgaW5s
aW5lIGludCBhcmNoX3dhbnRzX3B0ZV9vcmRlcih2b2lkKQoreworCXJldHVybiAwOworfQorI2Vu
ZGlmCisKICNpZm5kZWYgX19IQVZFX0FSQ0hfUFRFUF9HRVRfQU5EX0NMRUFSCiBzdGF0aWMgaW5s
aW5lIHB0ZV90IHB0ZXBfZ2V0X2FuZF9jbGVhcihzdHJ1Y3QgbW1fc3RydWN0ICptbSwKIAkJCQkg
ICAgICAgdW5zaWduZWQgbG9uZyBhZGRyZXNzLApkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LmMgYi9t
bS9tZW1vcnkuYwppbmRleCBjZjRhZTg3YjE1NjMuLjIzOGYxYTJmZmJmZiAxMDA2NDQKLS0tIGEv
bW0vbWVtb3J5LmMKKysrIGIvbW0vbWVtb3J5LmMKQEAgLTQwNTksNiArNDA1OSw4MSBAQCB2bV9m
YXVsdF90IGRvX3N3YXBfcGFnZShzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikKIAlyZXR1cm4gcmV0Owog
fQogCitzdGF0aWMgYm9vbCB2bWZfcHRlX3JhbmdlX2NoYW5nZWQoc3RydWN0IHZtX2ZhdWx0ICp2
bWYsIGludCBucl9wYWdlcykKK3sKKwlpbnQgaTsKKworCWlmIChucl9wYWdlcyA9PSAxKQorCQly
ZXR1cm4gdm1mX3B0ZV9jaGFuZ2VkKHZtZik7CisKKwlmb3IgKGkgPSAwOyBpIDwgbnJfcGFnZXM7
IGkrKykgeworCQlpZiAoIXB0ZV9ub25lKHB0ZXBfZ2V0X2xvY2tsZXNzKHZtZi0+cHRlICsgaSkp
KQorCQkJcmV0dXJuIHRydWU7CisJfQorCisJcmV0dXJuIGZhbHNlOworfQorCisjaWZkZWYgQ09O
RklHX1RSQU5TUEFSRU5UX0hVR0VQQUdFCitzdGF0aWMgc3RydWN0IGZvbGlvICphbGxvY19hbm9u
X2ZvbGlvKHN0cnVjdCB2bV9mYXVsdCAqdm1mKQoreworCWludCBpOworCWdmcF90IGdmcDsKKwlw
dGVfdCAqcHRlOworCXVuc2lnbmVkIGxvbmcgYWRkcjsKKwlzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYSA9IHZtZi0+dm1hOworCWludCBwcmVmZXJyZWQgPSBhcmNoX3dhbnRzX3B0ZV9vcmRlcigp
ID8gOiBQQUdFX0FMTE9DX0NPU1RMWV9PUkRFUjsKKwlpbnQgb3JkZXJzW10gPSB7CisJCXByZWZl
cnJlZCwKKwkJcHJlZmVycmVkID4gUEFHRV9BTExPQ19DT1NUTFlfT1JERVIgPyBQQUdFX0FMTE9D
X0NPU1RMWV9PUkRFUiA6IDAsCisJCTAsCisJfTsKKworCWlmICh2bWZfb3JpZ19wdGVfdWZmZF93
cCh2bWYpKQorCQlnb3RvIGZhbGxiYWNrOworCisJZm9yIChpID0gMDsgb3JkZXJzW2ldOyBpKysp
IHsKKwkJYWRkciA9IEFMSUdOX0RPV04odm1mLT5hZGRyZXNzLCBQQUdFX1NJWkUgPDwgb3JkZXJz
W2ldKTsKKwkJaWYgKGFkZHIgPj0gdm1hLT52bV9zdGFydCAmJiBhZGRyICsgKFBBR0VfU0laRSA8
PCBvcmRlcnNbaV0pIDw9IHZtYS0+dm1fZW5kKQorCQkJYnJlYWs7CisJfQorCisJaWYgKCFvcmRl
cnNbaV0pCisJCWdvdG8gZmFsbGJhY2s7CisKKwlwdGUgPSBwdGVfb2Zmc2V0X21hcCh2bWYtPnBt
ZCwgdm1mLT5hZGRyZXNzICYgUE1EX01BU0spOworCVZNX1dBUk5fT05fT05DRSh2bWYtPnB0ZSk7
CisKKwlmb3IgKDsgb3JkZXJzW2ldOyBpKyspIHsKKwkJYWRkciA9IEFMSUdOX0RPV04odm1mLT5h
ZGRyZXNzLCBQQUdFX1NJWkUgPDwgb3JkZXJzW2ldKTsKKwkJdm1mLT5wdGUgPSBwdGUgKyBwdGVf
aW5kZXgoYWRkcik7CisJCWlmICghdm1mX3B0ZV9yYW5nZV9jaGFuZ2VkKHZtZiwgMSA8PCBvcmRl
cnNbaV0pKQorCQkJYnJlYWs7CisJfQorCisJdm1mLT5wdGUgPSBOVUxMOworCXB0ZV91bm1hcChw
dGUpOworCisJZ2ZwID0gdm1hX3RocF9nZnBfbWFzayh2bWEpOworCisJZm9yICg7IG9yZGVyc1tp
XTsgaSsrKSB7CisJCXN0cnVjdCBmb2xpbyAqZm9saW87CisKKwkJYWRkciA9IEFMSUdOX0RPV04o
dm1mLT5hZGRyZXNzLCBQQUdFX1NJWkUgPDwgb3JkZXJzW2ldKTsKKwkJZm9saW8gPSB2bWFfYWxs
b2NfZm9saW8oZ2ZwLCBvcmRlcnNbaV0sIHZtYSwgYWRkciwgdHJ1ZSk7CisJCWlmIChmb2xpbykg
eworCQkJY2xlYXJfaHVnZV9wYWdlKCZmb2xpby0+cGFnZSwgYWRkciwgMSA8PCBvcmRlcnNbaV0p
OworCQkJdm1mLT5hZGRyZXNzID0gYWRkcjsKKwkJCXJldHVybiBmb2xpbzsKKwkJfQorCX0KK2Zh
bGxiYWNrOgorCXJldHVybiB2bWFfYWxsb2NfemVyb2VkX21vdmFibGVfZm9saW8odm1hLCB2bWYt
PmFkZHJlc3MpOworfQorI2Vsc2UKKyNkZWZpbmUgYWxsb2NfYW5vbl9mb2xpbyh2bWYpIHZtYV9h
bGxvY196ZXJvZWRfbW92YWJsZV9mb2xpbygodm1mKS0+dm1hLCAodm1mKS0+YWRkcmVzcykKKyNl
bmRpZgorCiAvKgogICogV2UgZW50ZXIgd2l0aCBub24tZXhjbHVzaXZlIG1tYXBfbG9jayAodG8g
ZXhjbHVkZSB2bWEgY2hhbmdlcywKICAqIGJ1dCBhbGxvdyBjb25jdXJyZW50IGZhdWx0cyksIGFu
ZCBwdGUgbWFwcGVkIGJ1dCBub3QgeWV0IGxvY2tlZC4KQEAgLTQwNjYsNiArNDE0MSw4IEBAIHZt
X2ZhdWx0X3QgZG9fc3dhcF9wYWdlKHN0cnVjdCB2bV9mYXVsdCAqdm1mKQogICovCiBzdGF0aWMg
dm1fZmF1bHRfdCBkb19hbm9ueW1vdXNfcGFnZShzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikKIHsKKwlp
bnQgaSA9IDA7CisJaW50IG5yX3BhZ2VzID0gMTsKIAlib29sIHVmZmRfd3AgPSB2bWZfb3JpZ19w
dGVfdWZmZF93cCh2bWYpOwogCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hID0gdm1mLT52bWE7
CiAJc3RydWN0IGZvbGlvICpmb2xpbzsKQEAgLTQxMTAsMTAgKzQxODcsMTIgQEAgc3RhdGljIHZt
X2ZhdWx0X3QgZG9fYW5vbnltb3VzX3BhZ2Uoc3RydWN0IHZtX2ZhdWx0ICp2bWYpCiAJLyogQWxs
b2NhdGUgb3VyIG93biBwcml2YXRlIHBhZ2UuICovCiAJaWYgKHVubGlrZWx5KGFub25fdm1hX3By
ZXBhcmUodm1hKSkpCiAJCWdvdG8gb29tOwotCWZvbGlvID0gdm1hX2FsbG9jX3plcm9lZF9tb3Zh
YmxlX2ZvbGlvKHZtYSwgdm1mLT5hZGRyZXNzKTsKKwlmb2xpbyA9IGFsbG9jX2Fub25fZm9saW8o
dm1mKTsKIAlpZiAoIWZvbGlvKQogCQlnb3RvIG9vbTsKIAorCW5yX3BhZ2VzID0gZm9saW9fbnJf
cGFnZXMoZm9saW8pOworCiAJaWYgKG1lbV9jZ3JvdXBfY2hhcmdlKGZvbGlvLCB2bWEtPnZtX21t
LCBHRlBfS0VSTkVMKSkKIAkJZ290byBvb21fZnJlZV9wYWdlOwogCWZvbGlvX3Rocm90dGxlX3N3
YXByYXRlKGZvbGlvLCBHRlBfS0VSTkVMKTsKQEAgLTQxMjUsMTcgKzQyMDQsMTMgQEAgc3RhdGlj
IHZtX2ZhdWx0X3QgZG9fYW5vbnltb3VzX3BhZ2Uoc3RydWN0IHZtX2ZhdWx0ICp2bWYpCiAJICov
CiAJX19mb2xpb19tYXJrX3VwdG9kYXRlKGZvbGlvKTsKIAotCWVudHJ5ID0gbWtfcHRlKCZmb2xp
by0+cGFnZSwgdm1hLT52bV9wYWdlX3Byb3QpOwotCWVudHJ5ID0gcHRlX3N3X21reW91bmcoZW50
cnkpOwotCWlmICh2bWEtPnZtX2ZsYWdzICYgVk1fV1JJVEUpCi0JCWVudHJ5ID0gcHRlX21rd3Jp
dGUocHRlX21rZGlydHkoZW50cnkpKTsKLQogCXZtZi0+cHRlID0gcHRlX29mZnNldF9tYXBfbG9j
ayh2bWEtPnZtX21tLCB2bWYtPnBtZCwgdm1mLT5hZGRyZXNzLAogCQkJJnZtZi0+cHRsKTsKIAlp
ZiAoIXZtZi0+cHRlKQogCQlnb3RvIHJlbGVhc2U7Ci0JaWYgKHZtZl9wdGVfY2hhbmdlZCh2bWYp
KSB7Ci0JCXVwZGF0ZV9tbXVfdGxiKHZtYSwgdm1mLT5hZGRyZXNzLCB2bWYtPnB0ZSk7CisJaWYg
KHZtZl9wdGVfcmFuZ2VfY2hhbmdlZCh2bWYsIG5yX3BhZ2VzKSkgeworCQlmb3IgKGkgPSAwOyBp
IDwgbnJfcGFnZXM7IGkrKykKKwkJCXVwZGF0ZV9tbXVfdGxiKHZtYSwgdm1mLT5hZGRyZXNzICsg
UEFHRV9TSVpFICogaSwgdm1mLT5wdGUgKyBpKTsKIAkJZ290byByZWxlYXNlOwogCX0KIApAQCAt
NDE1MCwxNiArNDIyNSwyNCBAQCBzdGF0aWMgdm1fZmF1bHRfdCBkb19hbm9ueW1vdXNfcGFnZShz
dHJ1Y3Qgdm1fZmF1bHQgKnZtZikKIAkJcmV0dXJuIGhhbmRsZV91c2VyZmF1bHQodm1mLCBWTV9V
RkZEX01JU1NJTkcpOwogCX0KIAotCWluY19tbV9jb3VudGVyKHZtYS0+dm1fbW0sIE1NX0FOT05Q
QUdFUyk7CisJZm9saW9fcmVmX2FkZChmb2xpbywgbnJfcGFnZXMgLSAxKTsKKwlhZGRfbW1fY291
bnRlcih2bWEtPnZtX21tLCBNTV9BTk9OUEFHRVMsIG5yX3BhZ2VzKTsKIAlmb2xpb19hZGRfbmV3
X2Fub25fcm1hcChmb2xpbywgdm1hLCB2bWYtPmFkZHJlc3MpOwogCWZvbGlvX2FkZF9scnVfdm1h
KGZvbGlvLCB2bWEpOworCisJZm9yIChpID0gMDsgaSA8IG5yX3BhZ2VzOyBpKyspIHsKKwkJZW50
cnkgPSBta19wdGUoZm9saW9fcGFnZShmb2xpbywgaSksIHZtYS0+dm1fcGFnZV9wcm90KTsKKwkJ
ZW50cnkgPSBwdGVfc3dfbWt5b3VuZyhlbnRyeSk7CisJCWlmICh2bWEtPnZtX2ZsYWdzICYgVk1f
V1JJVEUpCisJCQllbnRyeSA9IHB0ZV9ta3dyaXRlKHB0ZV9ta2RpcnR5KGVudHJ5KSk7CiBzZXRw
dGU6Ci0JaWYgKHVmZmRfd3ApCi0JCWVudHJ5ID0gcHRlX21rdWZmZF93cChlbnRyeSk7Ci0Jc2V0
X3B0ZV9hdCh2bWEtPnZtX21tLCB2bWYtPmFkZHJlc3MsIHZtZi0+cHRlLCBlbnRyeSk7CisJCWlm
ICh1ZmZkX3dwKQorCQkJZW50cnkgPSBwdGVfbWt1ZmZkX3dwKGVudHJ5KTsKKwkJc2V0X3B0ZV9h
dCh2bWEtPnZtX21tLCB2bWYtPmFkZHJlc3MgKyBQQUdFX1NJWkUgKiBpLCB2bWYtPnB0ZSArIGks
IGVudHJ5KTsKIAotCS8qIE5vIG5lZWQgdG8gaW52YWxpZGF0ZSAtIGl0IHdhcyBub24tcHJlc2Vu
dCBiZWZvcmUgKi8KLQl1cGRhdGVfbW11X2NhY2hlKHZtYSwgdm1mLT5hZGRyZXNzLCB2bWYtPnB0
ZSk7CisJCS8qIE5vIG5lZWQgdG8gaW52YWxpZGF0ZSAtIGl0IHdhcyBub24tcHJlc2VudCBiZWZv
cmUgKi8KKwkJdXBkYXRlX21tdV9jYWNoZSh2bWEsIHZtZi0+YWRkcmVzcyArIFBBR0VfU0laRSAq
IGksIHZtZi0+cHRlICsgaSk7CisJfQogdW5sb2NrOgogCWlmICh2bWYtPnB0ZSkKIAkJcHRlX3Vu
bWFwX3VubG9jayh2bWYtPnB0ZSwgdm1mLT5wdGwpOwpkaWZmIC0tZ2l0IGEvbW0vcm1hcC5jIGIv
bW0vcm1hcC5jCmluZGV4IDBjMGQ4ODU3ZGZjZS4uZmIxMjBjODcxN2VjIDEwMDY0NAotLS0gYS9t
bS9ybWFwLmMKKysrIGIvbW0vcm1hcC5jCkBAIC0xMjg0LDI1ICsxMjg0LDM2IEBAIHZvaWQgcGFn
ZV9hZGRfYW5vbl9ybWFwKHN0cnVjdCBwYWdlICpwYWdlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYSwKIHZvaWQgZm9saW9fYWRkX25ld19hbm9uX3JtYXAoc3RydWN0IGZvbGlvICpmb2xpbywg
c3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsCiAJCXVuc2lnbmVkIGxvbmcgYWRkcmVzcykKIHsK
LQlpbnQgbnI7CisJaW50IG5yID0gZm9saW9fbnJfcGFnZXMoZm9saW8pOwogCi0JVk1fQlVHX09O
X1ZNQShhZGRyZXNzIDwgdm1hLT52bV9zdGFydCB8fCBhZGRyZXNzID49IHZtYS0+dm1fZW5kLCB2
bWEpOworCVZNX0JVR19PTl9WTUEoYWRkcmVzcyA8IHZtYS0+dm1fc3RhcnQgfHwgYWRkcmVzcyAr
IFBBR0VfU0laRSAqIG5yID4gdm1hLT52bV9lbmQsIHZtYSk7CiAJX19mb2xpb19zZXRfc3dhcGJh
Y2tlZChmb2xpbyk7CiAKLQlpZiAobGlrZWx5KCFmb2xpb190ZXN0X3BtZF9tYXBwYWJsZShmb2xp
bykpKSB7CisJaWYgKCFmb2xpb190ZXN0X2xhcmdlKGZvbGlvKSkgewogCQkvKiBpbmNyZW1lbnQg
Y291bnQgKHN0YXJ0cyBhdCAtMSkgKi8KIAkJYXRvbWljX3NldCgmZm9saW8tPl9tYXBjb3VudCwg
MCk7Ci0JCW5yID0gMTsKKwkJX19wYWdlX3NldF9hbm9uX3JtYXAoZm9saW8sICZmb2xpby0+cGFn
ZSwgdm1hLCBhZGRyZXNzLCAxKTsKKwl9IGVsc2UgaWYgKCFmb2xpb190ZXN0X3BtZF9tYXBwYWJs
ZShmb2xpbykpIHsKKwkJaW50IGk7CisKKwkJZm9yIChpID0gMDsgaSA8IG5yOyBpKyspIHsKKwkJ
CXN0cnVjdCBwYWdlICpwYWdlID0gZm9saW9fcGFnZShmb2xpbywgaSk7CisKKwkJCS8qIGluY3Jl
bWVudCBjb3VudCAoc3RhcnRzIGF0IC0xKSAqLworCQkJYXRvbWljX3NldCgmcGFnZS0+X21hcGNv
dW50LCAwKTsKKwkJCV9fcGFnZV9zZXRfYW5vbl9ybWFwKGZvbGlvLCBwYWdlLCB2bWEsIGFkZHJl
c3MgKyBQQUdFX1NJWkUgKiBpLCAxKTsKKwkJfQorCQkvKiBpbmNyZW1lbnQgY291bnQgKHN0YXJ0
cyBhdCAwKSAqLworCQlhdG9taWNfc2V0KCZmb2xpby0+X25yX3BhZ2VzX21hcHBlZCwgbnIpOwog
CX0gZWxzZSB7CiAJCS8qIGluY3JlbWVudCBjb3VudCAoc3RhcnRzIGF0IC0xKSAqLwogCQlhdG9t
aWNfc2V0KCZmb2xpby0+X2VudGlyZV9tYXBjb3VudCwgMCk7CiAJCWF0b21pY19zZXQoJmZvbGlv
LT5fbnJfcGFnZXNfbWFwcGVkLCBDT01QT1VORF9NQVBQRUQpOwotCQluciA9IGZvbGlvX25yX3Bh
Z2VzKGZvbGlvKTsKKwkJX19wYWdlX3NldF9hbm9uX3JtYXAoZm9saW8sICZmb2xpby0+cGFnZSwg
dm1hLCBhZGRyZXNzLCAxKTsKIAkJX19scnV2ZWNfc3RhdF9tb2RfZm9saW8oZm9saW8sIE5SX0FO
T05fVEhQUywgbnIpOwogCX0KIAogCV9fbHJ1dmVjX3N0YXRfbW9kX2ZvbGlvKGZvbGlvLCBOUl9B
Tk9OX01BUFBFRCwgbnIpOwotCV9fcGFnZV9zZXRfYW5vbl9ybWFwKGZvbGlvLCAmZm9saW8tPnBh
Z2UsIHZtYSwgYWRkcmVzcywgMSk7CiB9CiAKIC8qKgpAQCAtMTQzMCw3ICsxNDQxLDcgQEAgdm9p
ZCBwYWdlX3JlbW92ZV9ybWFwKHN0cnVjdCBwYWdlICpwYWdlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1
Y3QgKnZtYSwKIAkJICogcGFnZSBvZiB0aGUgZm9saW8gaXMgdW5tYXBwZWQgYW5kIGF0IGxlYXN0
IG9uZSBwYWdlCiAJCSAqIGlzIHN0aWxsIG1hcHBlZC4KIAkJICovCi0JCWlmIChmb2xpb190ZXN0
X3BtZF9tYXBwYWJsZShmb2xpbykgJiYgZm9saW9fdGVzdF9hbm9uKGZvbGlvKSkKKwkJaWYgKGZv
bGlvX3Rlc3RfbGFyZ2UoZm9saW8pICYmIGZvbGlvX3Rlc3RfYW5vbihmb2xpbykpCiAJCQlpZiAo
IWNvbXBvdW5kIHx8IG5yIDwgbnJfcG1kbWFwcGVkKQogCQkJCWRlZmVycmVkX3NwbGl0X2ZvbGlv
KGZvbGlvKTsKIAl9Cg==
--000000000000ba612a05ffc2046c--
