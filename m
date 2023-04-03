Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735C36D4168
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjDCJ5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjDCJ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:57:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B91EAF1B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:57:03 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q16so37262601lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680515821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=71ApqNmMAqc4Lfz0XA+lWiPJaPmbA5X6z6e3Zew4cpc=;
        b=GX3fVIvy58RxfVyJr3T9lH3qWTKv1R3J2cYs2LqG/Pxof1FznaSmJdRQPc54Ygd72w
         He6JnRb0h4tO4BJIDU4u2tX2M1E5Pq7Bhw7ygTGotCWkLt9Xttv/9bnjx8RAK/iOwn7y
         j64ats3imVw54SohsHFdRdUBWZ6EJbd23PW6dzwbZ2Ptpy9/MdM+Gae/hWM95t5BIVUH
         zp+IR7dAS4uh30xMdS7wozo0XmPPdFRmCNXoxfG5Dzeq7LjpE/t7Wocbt3FgxT82hlxb
         FLIcsmTVkDwuS039a+DK2dnbO+2MEPkCoAFm02pFkMbGPRPCAywQ2iry+OoG4EGVRqeb
         22BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680515821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71ApqNmMAqc4Lfz0XA+lWiPJaPmbA5X6z6e3Zew4cpc=;
        b=iiBpshsCgfJ3MuQZ3lBEgizCYHRX5efxosicFm2z1f/9dpbaZiI3YMZ7YODA1NZgnR
         NSef+LW06rnV6OOK+vANyGO6geivf6mrzq0pVKUKIIO/3fnlTrWqySIwI/E0xBN5MY28
         7LAPjj+artwCqyd6Rzzvbk9v/i6DXsgTGe5tKDfMFeFdG8R3i5wXjyUTdMByPnPtsL5G
         lR/facgPpiN6AezgTSxnRpBV9v7SQgYVpiATKFo3lTPic/lAiS5k8KWqOkc+4+z03umz
         kj6W/bn0W8qUUo55qjSBF7rZ/ui2RHd5ihtNmWEak/RqR3uAfrnvFw9Sf6Dq+jTT9VFd
         4INw==
X-Gm-Message-State: AAQBX9fS7v2Lf1nhBD5+8SJmcje5BV/TSNYOxUxJpfecdA6m3JLMONS7
        uPomwS4U6IFxHjg4LIfbKLjUuwN4K/A/T2P8yc9cvA==
X-Google-Smtp-Source: AKy350ZDqdtz9C1mXWSa/Py8A5PSluslkGSalOFUXYA5iXh4JV5QthRrQzvu6VYDcIB1LD9BJTOdIh3v9g5e5BnsyFM=
X-Received: by 2002:ac2:43b3:0:b0:4db:44f9:a641 with SMTP id
 t19-20020ac243b3000000b004db44f9a641mr10124181lfl.6.1680515821272; Mon, 03
 Apr 2023 02:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
 <20230312112612.31869-12-kirill.shutemov@linux.intel.com> <CACT4Y+bnR=v0vUC_wTpd98Kpfd1KK--daPwjgnBL__r+wbHUkw@mail.gmail.com>
 <20230403094419.zl2ncsd4qyd35fex@box>
In-Reply-To: <20230403094419.zl2ncsd4qyd35fex@box>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Apr 2023 11:56:48 +0200
Message-ID: <CACT4Y+Y8ANFPwGd+UALu63mLxWoiiXnp2Z5GXnFhg14DdJUc=A@mail.gmail.com>
Subject: Re: [PATCHv16 11/17] x86/mm/iommu/sva: Make LAM and SVA mutually exclusive
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 at 11:44, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Mon, Apr 03, 2023 at 08:18:57AM +0200, Dmitry Vyukov wrote:
> > Hi Kirill,
> >
> > ARCH_ENABLE_TAGGED_ADDR checks that task->mm == current->mm,
> > shouldn't ARCH_FORCE_TAGGED_SVA check that as well?
>
> Do you a particular race in mind? I cannot think of anything right away.
>
> I guess we can add the check for consistency. But if there's a bug it is a
> different story.

No, I don't have a particular race in mind. Was thinking solely about
consistency and if these things should be set for other processes
(relaxing the check is always possible in future, but adding new
restrictions is generally not possible).

> > Also it looks like currently to enable both LAM and SVA.
> > LAM enabling checks for SVA, but SVA doesn't and both are not mutually
> > exclusive.
>
> For LAM we check SVM with mm_valid_pasid() && !test_bit() in
> prctl_enable_tagged_addr().
>
> For SVM we check for LAM with !mm_lam_cr3_mask() || test_bit() in
> arch_pgtable_dma_compat() which called from iommu_sva_alloc_pasid().

It seems that currently it's possible to both enable LAM and set SVA bit.
Then arch_pgtable_dma_compat() will return true, but LAM is enabled.
