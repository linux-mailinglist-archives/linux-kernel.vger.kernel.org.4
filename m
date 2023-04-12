Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6256DFF47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjDLT6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDLT6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:58:30 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07944486
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:58:18 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f11so11214388qka.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1681329498; x=1683921498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgcXxurLSkKjg/BoVCFNrpd/Kbb13VI/vKy5ffh4+LQ=;
        b=fqSp3WNu6KTe4Bst1jHEVLaJ1qgUkDvX6Djr9nQnDM+Trn6CjYm90o+4s1HvE89kIZ
         CaAKRBXeaSaqlhdKB7uZXdtG2z7sgMmhHNRVBK1BXMDtM8bsjH366IPiY5x/wUXjznAF
         KhWS+g2w+G5ljTn8jiBrFOBu+ops4syc3VS96FEjdiOOrGB3KXiaAUNhRpLT+KWJ6YG/
         x7znnDh1KUBVSjgbCfgm1bW6rGlN/i+se0576lryKP2CFiyu88uItYjVjHruupDlS5BH
         4YMGNf+GqN+YWKaaxA0ArnPlO4xHscALtOKAZle4JgS13ARkpzMDOOH4pvxyTUvITpJS
         j5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681329498; x=1683921498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgcXxurLSkKjg/BoVCFNrpd/Kbb13VI/vKy5ffh4+LQ=;
        b=VIwPKGy5cetb82SCVxj+0wqhJ4C2U3nt2Te2LMqfN8f2xfwKNtoQkYciGFL//PpImi
         bDaIHdQ9ae8UjowewZrCFV8Ka3igk6lYqZ0U22s0yOJVV6H8koxsGwPYTo5JMAxjxVHJ
         11x6DNch6BoWlemX3DAkmCyOv4fw5gqYAO1XEIzxjQu7fGgYFnJqVvEO9Br/43BTLhAv
         DSrUZBTkr7RVOhquXZAYJavTHxrcrVw+wRCezK56xkE8mAmZ2OzWfgb20rGTz84IB5Xa
         FM1GFGq6SRcUmU6YLQe17am7g02bSrUfjKsODryxqyYK9kywqEXXIwAXfZv5YhGN5HzF
         huxQ==
X-Gm-Message-State: AAQBX9ff+yHFFMyybE3G0O9A9wROmzVWt1RodMu9J0sd0ey5OcApudWk
        6sDxeq5btFwK74ZTgN9rCDJ2V+J+5TgG90EpqUip35f3tNO6TkcL
X-Google-Smtp-Source: AKy350bA1Nj2erBMaSHUcdOQB+2uDyETm6PUznmWQa7/2EKLnpIWHiHC3NrERYWdeDmitcyWdkX/mEy8lJ5JYZlErJw=
X-Received: by 2002:a05:620a:31aa:b0:743:d508:97ba with SMTP id
 bi42-20020a05620a31aa00b00743d50897bamr4832765qkb.1.1681329497994; Wed, 12
 Apr 2023 12:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230412152337.1203254-1-pasha.tatashin@soleen.com> <63736432-5cef-f67c-c809-cc19b236a7f4@google.com>
In-Reply-To: <63736432-5cef-f67c-c809-cc19b236a7f4@google.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 12 Apr 2023 15:57:42 -0400
Message-ID: <CA+CK2bBEjNjB1+G-WD-jzGqMVB8L99uLUyOXbedyYx+RLK5JKA@mail.gmail.com>
Subject: Re: [PATCH] mm: hugetlb_vmemmap: provide stronger vmemmap allocaction gurantees
To:     David Rientjes <rientjes@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, souravpanda@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 1:54=E2=80=AFPM David Rientjes <rientjes@google.com=
> wrote:
>
> On Wed, 12 Apr 2023, Pasha Tatashin wrote:
>
> > HugeTLB pages have a struct page optimizations where struct pages for t=
ail
> > pages are freed. However, when HugeTLB pages are destroyed, the memory =
for
> > struct pages (vmemmap) need to be allocated again.
> >
> > Currently, __GFP_NORETRY flag is used to allocate the memory for vmemma=
p,
> > but given that this flag makes very little effort to actually reclaim
> > memory the returning of huge pages back to the system can be problem. L=
ets
> > use __GFP_RETRY_MAYFAIL instead. This flag is also performs graceful
> > reclaim without causing ooms, but at least it may perform a few retries=
,
> > and will fail only when there is genuinely little amount of unused memo=
ry
> > in the system.
> >
>
> Thanks Pasha, this definitely makes sense.  We want to free the hugetlb
> page back to the system so it would be a shame to have to strand it in th=
e
> hugetlb pool because we can't allocate the tail pages (we want to free
> more memory than we're allocating).
>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Suggested-by: David Rientjes <rientjes@google.com>
> > ---
> >  mm/hugetlb_vmemmap.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index a559037cce00..c4226d2af7cc 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -475,9 +475,12 @@ int hugetlb_vmemmap_restore(const struct hstate *h=
, struct page *head)
> >        * the range is mapped to the page which @vmemmap_reuse is mapped=
 to.
> >        * When a HugeTLB page is freed to the buddy allocator, previousl=
y
> >        * discarded vmemmap pages must be allocated and remapping.
> > +      *
> > +      * Use __GFP_RETRY_MAYFAIL to fail only when there is genuinely l=
ittle
> > +      * unused memory in the system.
> >        */
> >       ret =3D vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_r=
euse,
> > -                               GFP_KERNEL | __GFP_NORETRY | __GFP_THIS=
NODE);
> > +                               GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GF=
P_THISNODE);
> >       if (!ret) {
> >               ClearHPageVmemmapOptimized(head);
> >               static_branch_dec(&hugetlb_optimize_vmemmap_key);
>
> The behavior of __GFP_RETRY_MAYFAIL is different for high-order memory (a=
t
> least larger than PAGE_ALLOC_COSTLY_ORDER).  The order that we're
> allocating would depend on the implementation of alloc_vmemmap_page_list(=
)
> so likely best to move the gfp mask to that function.

Thank you David. This makes sense, I will send the 2nd version soon.

Pasha
