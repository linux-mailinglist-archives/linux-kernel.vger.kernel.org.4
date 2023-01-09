Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D206632BC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbjAIVVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbjAIVVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:21:07 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5AED103
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:19:40 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id bx6so10348442ljb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8v3FtJ8YbGXwBs9pmZyFUMhZhWI2KQgI+Xbo+peGkY=;
        b=WmTbntIspnBBewndUUiWRRxo++BrKGJr0yatdOo/musAoNRGwESecp4EEilhT/6ZII
         K6YvBRx025nL5RiY33ZRxkv0oPGNT/4T4R+dUYKx38OH6hVEqC5SA2gdkCkn95pDflZl
         PeYJHjWBAkD61cLoIFlkV0TUpUru359UnN8Z4jBkPsJsE1cExq2n1ITENHqqiQiQws6I
         xYpCFeGRQAtNTQhp+Dy0x8SaIwip3jj2x3tFjYIDHLXmxEKFF7zN9X3qjSwC5e/O3tLC
         yoiBvZ9Cw46dH/ZnEnKLWLKlObSU+PSb4c2S6RBal+dYQjbJ/lHlh/JqEPa59jTWo2jt
         iZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8v3FtJ8YbGXwBs9pmZyFUMhZhWI2KQgI+Xbo+peGkY=;
        b=wgjQu0LBOULr7flqS7hsv8N7PBqhdtZ1TuwHp9FOKZ93m+ECR1+LidHcBt3lZcpH/4
         3+LWw49aleu/0vaSEn4qJVn41UFA43DPPlZgoqlHwg/aMhDW7znWqhpgeOZRXuiBeHBC
         jNP/LyODdFBSCo8IWkuD6L6AF4HaTwecQNbq4QiEw50BMYoz+8NdkC93qPOQ3T708ni9
         IOJeuWnnxkxQBVp3sBYJ7kot3c/soa9XSE4qOcb5grgZRxZtx4NvGW0MRmxkdZeOB8vF
         yhClkLbwNR4T0mPSXCYVZXd20eYr+DT+aFETXXdMFdPFQciJlf48WKuVLPw3F2nCQOoK
         qn9w==
X-Gm-Message-State: AFqh2kqCLwyiwlM+vnhaea22Rjaf1+6Qm6aRzQa4cQFj2oFsfHbpalLh
        lgWfOm/iNsP+/qhbokbt3gmgtZpviDY/Vw+cAFgRVA==
X-Google-Smtp-Source: AMrXdXsEfeis99cOsqfiYTmY4E8vRjt+pDtir5gnDqpPcNi879Vrmv8Qb+Q9hunhz5WzBxkMn4UGMsnbRH/l++8crOE=
X-Received: by 2002:a05:651c:19a1:b0:281:71ee:3cdd with SMTP id
 bx33-20020a05651c19a100b0028171ee3cddmr585522ljb.445.1673299178224; Mon, 09
 Jan 2023 13:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20221018205845.770121-6-pgonda@google.com> <diqz3598v4s3.fsf@google.com>
In-Reply-To: <diqz3598v4s3.fsf@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 9 Jan 2023 14:19:26 -0700
Message-ID: <CAMkAt6qh3Wbpe1-8cmm3kbGY5CSjG0Uccw5azyOMd349hajehQ@mail.gmail.com>
Subject: Re: [PATCH V5 5/7] KVM: selftests: add library for
 creating/interacting with SEV guests
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcorr@google.com, seanjc@google.com, michael.roth@amd.com,
        thomas.lendacky@amd.com, joro@8bytes.org, mizhang@google.com,
        pbonzini@redhat.com, andrew.jones@linux.dev, vannapurve@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 2:13 PM Ackerley Tng <ackerleytng@google.com> wrote:
>
>
> > +static void encrypt_region(struct kvm_vm *vm, struct
> > userspace_mem_region *region)
> > +{
> > +     const struct sparsebit *protected_phy_pages =
> > +             region->protected_phy_pages;
> > +     const uint64_t memory_size = region->region.memory_size;
> > +     const vm_paddr_t gpa_start = region->region.guest_phys_addr;
> > +     sparsebit_idx_t pg = 0;
> > +
> > +     sev_register_user_region(vm, region);
> > +
> > +     while (pg < (memory_size / vm->page_size)) {
> > +             sparsebit_idx_t nr_pages;
> > +
> > +             if (sparsebit_is_clear(protected_phy_pages, pg)) {
> > +                     pg = sparsebit_next_set(protected_phy_pages, pg);
> > +                     if (!pg)
> > +                             break;
> > +             }
> > +
> > +             nr_pages = sparsebit_next_clear(protected_phy_pages, pg) - pg;
> > +             if (nr_pages <= 0)
> > +                     nr_pages = 1;
>
> I think this may not be correct in the case where the sparsebit has the
> range [x, 2**64-1] (inclusive) set. In that case, sparsebit_next_clear()
> will return 0, but the number of pages could be more than 1.
>
> > +
> > +             sev_launch_update_data(vm, gpa_start + pg * vm->page_size,
>
> Computing the beginning of the gpa range with
>
> gpa_start + pg * vm->page_size
>
> only works if this memory region's gpa_start is 0.
>
> > +                                    nr_pages * vm->page_size);
> > +             pg += nr_pages;
> > +     }
> > +}
>
> Here's a suggestion (I'm using this on a TDX version of this patch)

Thanks for this catch and the code. I've pulled this into the V6 I am preparing.

>
>
> /**
>   * Iterate over set ranges within sparsebit @s. In each iteration,
>   * @range_begin and @range_end will take the beginning and end of the set
> range,
>   * which are of type sparsebit_idx_t.
>   *
>   * For example, if the range [3, 7] (inclusive) is set, within the
> iteration,
>   * @range_begin will take the value 3 and @range_end will take the value 7.
>   *
>   * Ensure that there is at least one bit set before using this macro with
>   * sparsebit_any_set(), because sparsebit_first_set() will abort if none are
>   * set.
>   */
> #define sparsebit_for_each_set_range(s, range_begin, range_end)         \
>         for (range_begin = sparsebit_first_set(s),                      \
>                      range_end =                                        \
>                      sparsebit_next_clear(s, range_begin) - 1;          \
>              range_begin && range_end;                                  \
>              range_begin = sparsebit_next_set(s, range_end),            \
>                      range_end =                                        \
>                      sparsebit_next_clear(s, range_begin) - 1)
> /*
>   * sparsebit_next_clear() can return 0 if [x, 2**64-1] are all set, and the
> -1
>   * would then cause an underflow back to 2**64 - 1. This is expected and
>   * correct.
>   *
>   * If the last range in the sparsebit is [x, y] and we try to iterate,
>   * sparsebit_next_set() will return 0, and sparsebit_next_clear() will try
> and
>   * find the first range, but that's correct because the condition expression
>   * would cause us to quit the loop.
>   */
>
>
> static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region
> *region)
> {
>         const struct sparsebit *protected_phy_pages =
>                 region->protected_phy_pages;
>         const vm_paddr_t gpa_base = region->region.guest_phys_addr;
>         const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
>
>         sparsebit_idx_t i;
>         sparsebit_idx_t j;
>
>         if (!sparsebit_any_set(protected_phy_pages))
>                 return;
>
>         sev_register_user_region(vm, region);
>
>         sparsebit_for_each_set_range(protected_phy_pages, i, j) {
>                 const uint64_t size_to_load = (j - i + 1) * vm->page_size;
>                 const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
>                 const uint64_t gpa = gpa_base + offset;
>
>                 sev_launch_update_data(vm, gpa, size_to_load);
>         }
> }
