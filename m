Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7D73EC1C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjFZUvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjFZUvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:51:19 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFCEAB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:51:16 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-573491c4deeso39648187b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687812675; x=1690404675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2wVtYa2vqyVKl9o91me/mKW8BTuC3FGzPHOpu6HMUY=;
        b=XgQTFOT6k9V779cjl2JLqY02nPwY/RTzphuzZ2hnOJvfWBTSEj6Kv8I/dTqSSyIr/d
         CbTITKUurWjQjbQpxt5ApsLtUvKk06XAgTDW/j95MHO+8yMbiTmBTHXoe+gIWorLodTs
         QudtoaCOKvUfKMYNGshN6JnrsyqqcAEg6lQGQ1bn+4IFXYOurknO+ZdsU/FgZrw420MF
         8t7VZvr6jEYHYaSO/kwxGK9eyHxaM+rylmII2imP/2sCChe1/jrO5WnEZsFS7RUgfrSW
         2hzkTV8YNXSXG9pBqzohG/S42rHjGh9/R9/BgkSgGypMimxZ+KU9SCjJxrKo0l84ZCoO
         O+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687812675; x=1690404675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2wVtYa2vqyVKl9o91me/mKW8BTuC3FGzPHOpu6HMUY=;
        b=LotgNPVrJ6fJN6BG7xMCOgr3JMY95Edq/VwxFvai78JYfwRZQyudIPz3w/elX0e40H
         +mZo4aAiYI4k9dYVVdvAajFYaH2GJ8GWO+izxdfb+oEl7DjqQrFNHarIBEqs7cEQh2aP
         FUnAQ9gTe25kkmGt0kiqZcDL45Zxv+Fxoouod1+yGqxbO7rTjqGkyiEBhkV4gV3x89t/
         NVWjy3vVoyWbvOoxk5uiUBNf7UYTgS0KXntYMW5bv1e2ZU17uh05WK/gjgdKy2RxmIaj
         2afuHegw9kDVK4jb7VrTbcQePPiYLKMOaowLuyneWvhD/wUfmS3UibM2XygRtI+lfSRB
         w+kA==
X-Gm-Message-State: AC+VfDx1rNstA/5JRaf7tXLmEZcI6OxZyy500g6wAnF9QVU42UyFAmqz
        sz6sA1X2rEj+Cv/y9YIghia4WfPNedX4JAkqjPPdnQ==
X-Google-Smtp-Source: ACHHUZ5jUc5atIflbAoCqP1iuoHBqp5gAGvVJwpi2/6J+5nRNsQlzCeC+4ypWGb7ME7TRoDDEUxDqm4Nd1II1cuOnFs=
X-Received: by 2002:a25:f802:0:b0:ba8:6c1f:f5ad with SMTP id
 u2-20020a25f802000000b00ba86c1ff5admr25085848ybd.29.1687812675044; Mon, 26
 Jun 2023 13:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230620235726.3873043-1-surenb@google.com>
In-Reply-To: <20230620235726.3873043-1-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 26 Jun 2023 20:51:04 +0000
Message-ID: <CAJuCfpHnSEbs9y23jz30okuHZXLXBExWc_ZLvOgtwL3EMab=Ng@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: change vma_start_read to fail if VMA got detached
 from under it
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, torvalds@linuxfoundation.org,
        vegard.nossum@oracle.com, mpe@ellerman.id.au,
        Liam.Howlett@oracle.com, lrh2000@pku.edu.cn, mgorman@suse.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jun 20, 2023 at 11:57=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> Current implementation of vma_start_read() checks VMA for being locked
> before taking vma->vm_lock and then checks that again. This mechanism
> fails to detect a case when the VMA gets write-locked, modified and
> unlocked after the first check but before the vma->vm_lock is obtained.
> While this is not strictly a problem (vma_start_read would not produce
> a false unlocked result), this allows it to successfully lock a VMA which
> got detached from the VMA tree while vma_start_read was locking it.
> New condition checks for any change in vma->vm_lock_seq after we obtain
> vma->vm_lock and will cause vma_start_read() to fail if the above race
> occurs.

Just a friendly ping for feedback.
I know most people were busy fixing the stack expansion problem and
these patches are not urgent, so no rush. If nobody reviews them, I'll
ping again next week.

>
> Fixes: 5e31275cc997 ("mm: add per-VMA lock and helper functions to contro=
l it")
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/mm.h | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 27ce77080c79..8410da79c570 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -639,23 +639,24 @@ static inline void vma_numab_state_free(struct vm_a=
rea_struct *vma) {}
>   */
>  static inline bool vma_start_read(struct vm_area_struct *vma)
>  {
> -       /* Check before locking. A race might cause false locked result. =
*/
> -       if (vma->vm_lock_seq =3D=3D READ_ONCE(vma->vm_mm->mm_lock_seq))
> +       int vm_lock_seq =3D READ_ONCE(vma->vm_lock_seq);
> +
> +       /*
> +        * Check if VMA is locked before taking vma->vm_lock. A race or
> +        * mm_lock_seq overflow might cause false locked result.
> +        */
> +       if (vm_lock_seq =3D=3D READ_ONCE(vma->vm_mm->mm_lock_seq))
>                 return false;
>
>         if (unlikely(down_read_trylock(&vma->vm_lock->lock) =3D=3D 0))
>                 return false;
>
> -       /*
> -        * Overflow might produce false locked result.
> -        * False unlocked result is impossible because we modify and chec=
k
> -        * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock=
_seq
> -        * modification invalidates all existing locks.
> -        */
> -       if (unlikely(vma->vm_lock_seq =3D=3D READ_ONCE(vma->vm_mm->mm_loc=
k_seq))) {
> +       /* Fail if VMA was write-locked after we checked it earlier */
> +       if (unlikely(vm_lock_seq !=3D READ_ONCE(vma->vm_lock_seq))) {
>                 up_read(&vma->vm_lock->lock);
>                 return false;
>         }
> +
>         return true;
>  }
>
> --
> 2.41.0.162.gfafddb0af9-goog
>
