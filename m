Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C7F70A4A6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 04:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjETCej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 22:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjETCeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 22:34:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C771B0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 19:34:36 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-510d9218506so3029360a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 19:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684550073; x=1687142073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh6ejcxyOpbBR//bKhui3rhhiC+Sm3sNdu/qK016ndc=;
        b=BiQEt0Ude24c1CnFVO4D6Bn5EN++lTCIj+JximaVmin9Z7W8IJH/23jnb6+XYmn1ET
         WbsE6k9HStWlf9+ejjqC8fMlnxpbW6zvdxPQBZseh5Uxclv828WmEQlvOuYhHkMfrN+9
         ICJxYb10efTWLg9IMnKL+PLZNiedRPU5vkhs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684550073; x=1687142073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oh6ejcxyOpbBR//bKhui3rhhiC+Sm3sNdu/qK016ndc=;
        b=gspPQggrW7FzWkde6VPxgmBRIznbqCORlDmwez2pnq4d9B7DH0++A0Ha7wqLKFPjH9
         zNgzYfgFs88ZubpkRZOJxwb7/3eaRsIhCdPvzp0710IbELM60coGB19zuwMxWVYsp1Gu
         AaEw6JPeMkIpUMuOc8demjZ/fZSzFs0X7QQuvvb4Np7yfXPKAr74r4nyDktR3A2WMXAC
         Rqtc0V2XeWb3kktJ8qhXnEVtu5G4tV7y9W8d4dT8+akZeh0m6CIWa4md1iNHsrCOV61a
         vXk9SZ1BWSf937ZvUyVKjT4feL4yTaHNWpqkOrQSDh9oId3hsjUsazXdL65Au7FxgwHk
         px/Q==
X-Gm-Message-State: AC+VfDzU1RhzMoJKPLIIllX6iYdiEE9B4PkMENVzi8OoUbu76zB+Iihm
        GNdKhi9pXEBsVWdRsifvO1yDC78v1LuungiocJM/ebOj
X-Google-Smtp-Source: ACHHUZ4WfYcZWuP+ZlyxmhlxYTGoAgJH8nFB6/9W6E0SP376tSEpsA1DWbc0IGG1ED0BTu1DaMlq1g==
X-Received: by 2002:a05:6402:35a:b0:50b:c4d5:3da1 with SMTP id r26-20020a056402035a00b0050bc4d53da1mr4344805edw.8.1684550073333;
        Fri, 19 May 2023 19:34:33 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id q10-20020a50c34a000000b0050bc6c04a66sm370362edb.40.2023.05.19.19.34.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 19:34:32 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-510bcd2d6b8so2990015a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 19:34:32 -0700 (PDT)
X-Received: by 2002:a17:907:6e25:b0:96a:a76c:41d5 with SMTP id
 sd37-20020a1709076e2500b0096aa76c41d5mr3159482ejc.12.1684550072290; Fri, 19
 May 2023 19:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230519190934.339332-1-joel@joelfernandes.org>
 <20230519190934.339332-2-joel@joelfernandes.org> <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
 <CAEXW_YQ4wdGVa5M6jZfi5d-pdJOp1Nu7qTBvWYS=255AnYWZCw@mail.gmail.com>
In-Reply-To: <CAEXW_YQ4wdGVa5M6jZfi5d-pdJOp1Nu7qTBvWYS=255AnYWZCw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 19:34:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9j+puqhe+E-AcG5j-5nP_tQ7DmAcb=Cb6v7n4mpxXjQ@mail.gmail.com>
Message-ID: <CAHk-=wj9j+puqhe+E-AcG5j-5nP_tQ7DmAcb=Cb6v7n4mpxXjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/mremap: Optimize the start addresses in move_page_tables()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 3:52=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
> >
> > I *suspect* that the test is literally just for the stack movement
> > case by execve, where it catches the case where we're doing the
> > movement entirely within the one vma we set up.
>
> Yes that's right, the test is only for the stack movement case. For
> the regular mremap case, I don't think there is a way for it to
> trigger.

So I feel the test is simply redundant.

For the regular mremap case, it never triggers.

And for the stack movement case by execve, I don't think it matters if
you just were to change the logic of the subsequent checks a bit.

In particular, you do this:

        /* If the masked address is within vma, there is no prev
mapping of concern. */
        if (vma->vm_start <=3D addr_masked)
                return false;

        /*
         * Attempt to find vma before prev that contains the address.
         * On any issue, assume the address is within a previous mapping.
         * @mmap write lock is held here, so the lookup is safe.
         */
        cur =3D find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
        if (!cur || cur !=3D vma || !prev)
                return true;

        /* The masked address fell within a previous mapping. */
        if (prev->vm_end > addr_masked)
                return true;

        return false;

And I think that

        if (!cur || cur !=3D vma || !prev)
                return true;

is actively wrong, because if there is no 'prev', then you should return fa=
lse.

So I *think* all of the above could just be replaced with this instead:

        find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
        return prev && prev->vm_end  > addr_masked;

because only if we have a 'prev', and the prev is into that masked
address, do we need to avoid doing the masking.

With that simplified test, do you even care about that whole "the
masked address was already in the vma"? Not that I can see.

And we don't even care about the return value of 'find_vma_prev()',
because it had better be 'vma'. We're giving it 'vma->vm_start' as an
address, for chrissake!

So if you *really* wanted to, you could do something like

        cur =3D find_vma_prev(..);
        if (WARN_ON_ONCE(cut !=3D vma))
                return true;

but even that WARN_ON_ONCE() seems pretty bogus. If it triggers, we
have some serious corruption going on.

So I stil find that whole "vma->vm_start <=3D addr_masked" test a bit
confusing, since it seems entirely redundant.

Is it just because you wanted to avoid calling "find_vma_prev()" at
all? Maybe just say that in the comment.

                  Linus
