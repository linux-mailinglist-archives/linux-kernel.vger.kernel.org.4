Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775896F0D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245168AbjD0UgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344095AbjD0UgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:36:14 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83C746A5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:35:47 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f0a2f8216fso827221cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682627747; x=1685219747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptBdlJ07v8HdQe+LoZZ45Ny20mkYLWz+prXa/vlPc5g=;
        b=ejGejKzhboVuH/Okkr279d6To4yc4YLxo/pErGIwVBZms1pTi6heNby96nKksTpX3a
         9ZVW2kjRNWY2WNF5IQ7O6q/srqJLqblDuMKQXyTWzx9rUb53h6IeiwdWT8DdiTvvFlnF
         ap59K2vgyFhSDWY7ymCDiaotKITRXEl6Kt//xXgyY9bowPyBNnmDww8lxUpkoxb/4MtX
         yzrPYzVLtrUUMHn6mUxs9CgVgcowuzqlknix5QPRtkcyKv8wsvFTnP59kim9sF5t4wXI
         vJ14wyoK1j9Bzvlhu/Jfaa3TEjEdAsJjGPGTgyyUrB3KSbgpzbJLTBv4J9aB28owmHQs
         PI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682627747; x=1685219747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptBdlJ07v8HdQe+LoZZ45Ny20mkYLWz+prXa/vlPc5g=;
        b=M9gE1c84xZQd35AA9By50giSv8+dW8VfbhX6EBVd9g7tLw9oMU8tt+Ig0/qAJJn901
         0J39b9jmT4UE3mI9Y16+KzqyCk81xFlj+eJ2KG8wcYEFbSVVNBcRmGn4B2l/DIc8doWb
         gboCbjcmT5atSBZUScDmwKTPH8dbwVxgtrRx0LIh09OOtrlgkLFBjOyInuF0Wg98vx8I
         UQ7iI8oaw+WP0AdB4kwEXqXpuxyQHpUT22kA1+1NhQTRymkFEaW0SAxo1fQMu39gL7n+
         vBkXtSG5/fS0o7IRaA/Uuh6mQxRFXC0yLrCn64ay7gKS77i1n+1enurW+H11ZYBRBEhD
         m/3w==
X-Gm-Message-State: AC+VfDy2o5NfR+quigRckvewE0NqEihVG9LaA0pwIewq+3TZdxkYqSN1
        KCTWwQbha0/OMkhRCz5e4YB3SpnWylZXk8HQToN0Qg==
X-Google-Smtp-Source: ACHHUZ6k2Icr8mvB78iBbOp/hEvzjLIV2SDthfJnvHGJz15ZjsD4VFeV8D723c/xR7fRgPMt1L9PXuavlP+NkvgJ2Pw=
X-Received: by 2002:ac8:590f:0:b0:3ef:4319:c6c5 with SMTP id
 15-20020ac8590f000000b003ef4319c6c5mr58453qty.19.1682627746969; Thu, 27 Apr
 2023 13:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230427201112.2164776-1-peterx@redhat.com> <20230427201112.2164776-2-peterx@redhat.com>
In-Reply-To: <20230427201112.2164776-2-peterx@redhat.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 27 Apr 2023 13:35:11 -0700
Message-ID: <CADrL8HWxdTBD5fKiK9BKRUFCghK_nd1oNOkykmh4RYbn4C7UgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/kvm: Setup vcpu_alias only for minor mode test
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Anish Moorthy <amoorthy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 1:11=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> This fixes two things:
>
> - Unbreaks MISSING mode test on anonymous memory type
>
> - Prefault alias mem before uffd thread creations, otherwise the uffd
>   thread timing will be inaccurate when guest mem size is large, because
>   it'll take prefault time into total time.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: James Houghton <jthoughton@google.com>

FWIW, it looks like this fixes this commit[1]. Not sure if it's worth
a Fixes: tag.

[1]: commit a93871d0ea9f ("KVM: selftests: Add a userfaultfd library")


> ---
>  .../testing/selftests/kvm/demand_paging_test.c  | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/tes=
ting/selftests/kvm/demand_paging_test.c
> index 2439c4043fed..9c18686b4f63 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -128,6 +128,7 @@ static void prefault_mem(void *alias, uint64_t len)
>
>  static void run_test(enum vm_guest_mode mode, void *arg)
>  {
> +       struct memstress_vcpu_args *vcpu_args;
>         struct test_params *p =3D arg;
>         struct uffd_desc **uffd_descs =3D NULL;
>         struct timespec start;
> @@ -145,24 +146,24 @@ static void run_test(enum vm_guest_mode mode, void =
*arg)
>                     "Failed to allocate buffer for guest data pattern");
>         memset(guest_data_prototype, 0xAB, demand_paging_size);
>
> +       if (p->uffd_mode =3D=3D UFFDIO_REGISTER_MODE_MINOR) {
> +               for (i =3D 0; i < nr_vcpus; i++) {
> +                       vcpu_args =3D &memstress_args.vcpu_args[i];
> +                       prefault_mem(addr_gpa2alias(vm, vcpu_args->gpa),
> +                                    vcpu_args->pages * memstress_args.gu=
est_page_size);
> +               }
> +       }
> +
>         if (p->uffd_mode) {
>                 uffd_descs =3D malloc(nr_vcpus * sizeof(struct uffd_desc =
*));
>                 TEST_ASSERT(uffd_descs, "Memory allocation failed");
> -
>                 for (i =3D 0; i < nr_vcpus; i++) {
> -                       struct memstress_vcpu_args *vcpu_args;
>                         void *vcpu_hva;
> -                       void *vcpu_alias;
>
>                         vcpu_args =3D &memstress_args.vcpu_args[i];
>
>                         /* Cache the host addresses of the region */
>                         vcpu_hva =3D addr_gpa2hva(vm, vcpu_args->gpa);
> -                       vcpu_alias =3D addr_gpa2alias(vm, vcpu_args->gpa)=
;
> -
> -                       prefault_mem(vcpu_alias,
> -                               vcpu_args->pages * memstress_args.guest_p=
age_size);
> -
>                         /*
>                          * Set up user fault fd to handle demand paging
>                          * requests.
> --
> 2.39.1
>
