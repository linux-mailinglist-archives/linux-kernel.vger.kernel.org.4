Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF86272E727
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242772AbjFMP0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241165AbjFMP0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:26:39 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C2F171F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:26:38 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1a6860fa9ffso2112569fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686669997; x=1689261997;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sP5idTvIDCNhphFxgMYPrqA/v5X6PDGt+hLyjhHCuqc=;
        b=l33Kcibkx3maWuZGuU6K37uh3DEojYwaVDf/g/Fb7RX90PfwCiHwEjBIqfI9qzRFxF
         wx8oO4o7PNhBPw3C7eia6LgEALKqi7chYkMHYHQOl8RWFhvdK9hyUdvGFpRjPJSY56H/
         L6zSuEgRgahgnb3Q0BJEP/I7jlOE/wIDajstk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686669997; x=1689261997;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sP5idTvIDCNhphFxgMYPrqA/v5X6PDGt+hLyjhHCuqc=;
        b=AIMPmfxQbt4l9EiyCBNxLRoSVy800lzZ0vtmi8XWT2MhwgtFseffaEuDOzCmmUa22t
         0ciianO989pjLNckN6CGOc49i0CKOlp4IC1clcXnSHznK3eZZyy0PTMhkM3G5/e9xIVW
         4h/v7wssxiCrwWNTakdrz6LRZmhv79hGEzbzub2p5RjiLVFUEFLD1bbVilUI9rMrgXkU
         CTjYCS+0tECjqPdMZlORuUS3jeGnAikAziJtM9Nr8PVsb6VEqxx5KffROaMe4g1h0AC5
         UG/ZerbAjI5JaVWYs3FdupiUR5OOk3ipNzUFN61ngo5Vsi3B79KLFh0p+Xjm03oFY6sP
         XWhQ==
X-Gm-Message-State: AC+VfDxafaK/ok1O4eLj1tHrc8vkPe0d9OmQp0UIbozMr1Gw8ndbvHuH
        pk7lvi4Bjjr9kImaJhgFVZKOwoJKj0QIzocRlSD8Tg==
X-Google-Smtp-Source: ACHHUZ6fWfqaRgyeuAlfhObZcz+fl/jaJIo8cHxCVuOOLS2LfFbaG61hvKxfM+YFR8TTX3pD36RCVkmrqUha7HxHk/g=
X-Received: by 2002:a05:6870:e905:b0:19a:2178:ee94 with SMTP id
 l5-20020a056870e90500b0019a2178ee94mr9499419oan.26.1686669997691; Tue, 13 Jun
 2023 08:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <CABi2SkWx_BnEHzGqqqbDMJi+vi-5a7XkQUCkyesN5PUtk23SgQ@mail.gmail.com>
In-Reply-To: <CABi2SkWx_BnEHzGqqqbDMJi+vi-5a7XkQUCkyesN5PUtk23SgQ@mail.gmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Tue, 13 Jun 2023 08:26:26 -0700
Message-ID: <CABi2SkXw6ZD-M1ZrcXNL7abtM=RzQXv716PPM_k=1Tay=5rUFA@mail.gmail.com>
Subject: Re: inconsistence in mprotect_fixup mlock_fixup madvise_update_vma
To:     linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        Liam.Howlett@oracle.com, peterx@redhat.com,
        zhangpeng.00@bytedance.com, akpm@linux-foundation.org,
        koct9i@gmail.com, david@redhat.com, ak@linux.intel.com,
        hughd@google.com, emunson@akamai.com, rppt@linux.ibm.com,
        aarcange@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ more ppl to the list.

On Mon, Jun 12, 2023 at 6:04=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> Hello,
>
> There seems to be inconsistency in different VMA fixup
> implementations, for example:
> mlock_fixup will skip VMA that is hugettlb, etc, but those checks do
> not exist in mprotect_fixup and madvise_update_vma. Wouldn't this be a
> problem? the merge/split skipped by mlock_fixup, might get acted on in
> the madvice/mprotect case.
>
> mlock_fixup currently check for
> if (newflags =3D=3D oldflags || (oldflags & VM_SPECIAL) ||
> is_vm_hugetlb_page(vma) || vma =3D=3D get_gate_vma(current->mm) ||
> vma_is_dax(vma) || vma_is_secretmem(vma))
>
> Should there be a common function to handle VMA merge/split ?
>
> Best
> -Jeff
