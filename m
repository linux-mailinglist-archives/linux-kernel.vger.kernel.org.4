Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92846FBBD9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 02:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjEIAII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 20:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbjEIAIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 20:08:04 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED52049DE
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 17:08:03 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3ef33f12995so28935241cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 17:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1683590883; x=1686182883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmbOgrH0rb5ijhbY2Wor2EVPZmT7RKPzPHW01oN7clM=;
        b=oel6LShhm/iI4Dhey/P2K7T9x4C89z7w74vBuLx6LwncjE6lK1uEj8Ofp7ahI/wflO
         W/rKYfZXgLLXIaXp8uNKfutQ2+UcEqWMGoetRxx2uexEZgHE3Cwy9wVRaBHrlq9ILcRJ
         ZS77AQfGPL7erDtAPnV8y7mTbnNjbTgmqGTjIlLRgThpCo3Y46OnarNGKBwUx5/5QNqW
         yu4bcqFX+pMIzb2klyqZ5YIJXEkW1Tu9dYix+tQzf+ATV7Gv+y8XsOK1zw0SwF1bZMMA
         zzYpFoveqTlVX5vbqYnQl5UnRjTsjwXAoBKRi4d07/CJTZHqfafREiXVD3htxvCC6MYR
         TF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590883; x=1686182883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmbOgrH0rb5ijhbY2Wor2EVPZmT7RKPzPHW01oN7clM=;
        b=Hjwp3nNWLkj0zavjpEBdb4f///9N74lLISVMEO4Z+NGjGpaR6/usY5rev2vjfMpw7B
         fd/meh0r8zQ78DlFWyZUBHP8USdgzo8HveD78hY2LtENFtB5ivlPDWgheuTZONkrEyKD
         1HmUOOr7kNVj1PyCBd5H6uVpeuF+HKhRsRhHD/JwRRQuDEXzNTyhAQ39YAh21IF7nHSw
         nAeZirStoiUHeaAJ8ZvSa28n0BWdgERHrDadg+fuHEAIaQoiPA0CtyZotSt0suzTpXlk
         of2pdFnydkzbGGnc4jvwXG3nkpC9vL5DtXzZ46dMHFo378sf9axFTjQ/S4HrgNr9ubuv
         xINQ==
X-Gm-Message-State: AC+VfDyg5Grb5PXZUVG2+ys13DZqd5S62rCrWMGkLaTWigVcEVqyGqT5
        MNKTHJqPlc3SK6/6PEVLrdaWwZcotcBHIjtNO/AgEQ==
X-Google-Smtp-Source: ACHHUZ7V31jQo9MHkZ1H0Z5NarnpPjrrOBFHuW+TlbkAKUCWg2n3pFrZkPrCkNYVsNuGi2lUpCUhwgnz68eyQoyheHA=
X-Received: by 2002:a05:622a:1c7:b0:3f3:82c2:cffe with SMTP id
 t7-20020a05622a01c700b003f382c2cffemr13152140qtw.17.1683590883147; Mon, 08
 May 2023 17:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000258e5e05fae79fc1@google.com> <20230507135844.1231056-1-lrh2000@pku.edu.cn>
 <CA+CK2bBe2YKYM3rUTCnZ0RF=NFUR9VqO-QYn3ygPsFJWLY1MUA@mail.gmail.com>
 <ZFlrbDft1QfMyIDc@casper.infradead.org> <CA+CK2bDVjovwB9v-Zv4Fn7EUfp5FV2XK36iJKYKY7pYNOFfOGA@mail.gmail.com>
 <ZFlvJEfs1ufh1UUD@casper.infradead.org> <CA+CK2bDC-FVv1tZg9MDn-N735Ak3OAtdZPf+LEYM-JHsO90YcQ@mail.gmail.com>
 <fa1dac7a-406e-30ea-6aba-ded2e0e871fa@redhat.com> <CA+CK2bAHbHHwLUoGJkz8n6mrM5dy7oMojeNksdVOMYn+qFYngA@mail.gmail.com>
 <CA+CK2bD=bv1vPGZaNcxDy-uUFj2ZAKkdPmAtJaweXhgTe91oEw@mail.gmail.com> <366ab078-1101-421c-691d-34f5efe006b5@redhat.com>
In-Reply-To: <366ab078-1101-421c-691d-34f5efe006b5@redhat.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 8 May 2023 17:07:26 -0700
Message-ID: <CA+CK2bBwYGd2_CVQ4Nr87CGEjp7BqVbBeoP++yHB7Cr9_peBOQ@mail.gmail.com>
Subject: Re: usbdev_mmap causes type confusion in page_table_check
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 4:37=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 09.05.23 01:21, Pasha Tatashin wrote:
> >> For normal Kernel-MM operations, vm_normal_page() should be used to
> >> get "struct page" based on vma+addr+pte combination, but
> >> page_table_check does not use vma for its operation in order to
> >> strengthen the verification of no invalid page sharing. But, even
>
> I'm not sure if that's the right approach for this case here, though.
>
> >> vm_normal_page() can cause access to the "struct page" for VM_PFNMAP
> >> if pfn_valid(pfn) is true. So, vm_normal_page() can return a struct
> >> page for a user mapped slab page.
> >
> > Only for !ARCH_HAS_PTE_SPECIAL case, otherwise NULL is returned.
>
> That would violate VM_PFNMAP semantics, though. I remember that there
> was a trick to it.
>
> Assuming we map /dev/mem, what stops a page we mapped and determined to
> be !anon to be freed and reused, such that we suddenly have an anon page
> mappped?
>
> In that case, we really don't want to look at the "struct page" ever, no?

Good point. page_table_check just does not work well /dev/mem. I am
thinking of adding BUG_ON(PageSlab(page); and also "depends on
!DEVMEM" for the PAGE_TABLE_CHECK config option.

Pasha
