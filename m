Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD5D74BC4C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 07:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjGHFsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 01:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGHFse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 01:48:34 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719FD1BF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 22:48:33 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-401f4408955so67431cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 22:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688795312; x=1691387312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mn+nUOxWSZTxZ7OcyeEWmpBqaocgMenrl66gbGB3Jrs=;
        b=5iIanct8O/4uEsustVHeTjaR+s3tG4eSuSHjxv650mRRhlnGJXKdK9fgu6nNtWsJfk
         vycVqfA7QnZmeRo/mb5s2KQUPW660U1IAId7eZzCprWJPVhQ+IRiJo58uUOpNo4Z/oNL
         T8lPIaYd3LWyOKRiLtpHUVAL17w5a/X3OUT7AdbUbjMasjwUz6kr4ga9ihfMZHfrwYW5
         MWlzLqg5EH7r2kohuAWIdKU4DjblTqEFsRaUkCNU1y/KfLnf8hcoSnXp1euem8BV5uug
         qEE8m0QJxoXORnqDa5XbIujURxM2UPqNmIj4z+CwR5dzvMv4zHuGgtkswnI/bi32ll7K
         Kfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688795312; x=1691387312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mn+nUOxWSZTxZ7OcyeEWmpBqaocgMenrl66gbGB3Jrs=;
        b=Vp4WIAePpQnpouE59wqeI+H6GCUGcWbJ8eLH+5piaJCuRK0vZgN+VIKhYzgdSPiBAG
         CPk8MDDHHy5qnEXMQ8IVsBtr5TPJZMnmwDIaqIZpGuWv/xLxh6n/dkfwZR3LatF+uvDI
         HmsiPDfB4B6EpFLXK6jodCYzW1DdXnTgBKAxtOyTmSM6SiuRgD7mefTsnvoleqSGSTqW
         YcCuEir9o6vP5yg75dxaVDKEo4cUA/H1xLpqhdVjVg8pmr7TFNa9kfImcQCJUc77elIc
         WHGCpUMfKX96eicfd+n/wyYCJFTmLbK5ck6Iz7qjtg66KW8+wcTwuFuxOvznttFMCgn4
         pirA==
X-Gm-Message-State: ABy/qLbYGg/mPiTP1w10sGr8CyN2dbyUvCfL4jL/M37cT2ZgA3OP0hpR
        x5+EyeNUychssK+PCVd4xaJbJKFLHgyG80T7ZzMolw==
X-Google-Smtp-Source: APBJJlEX68/quvwnGwy6yXcayeoj6I+JVV46ymWBkKt45wTcbuReaWuordxMrhOz4yFzAK3DBLqQOkcckGJ3zPAA5l4=
X-Received: by 2002:ac8:5b09:0:b0:3f8:8c06:c53b with SMTP id
 m9-20020ac85b09000000b003f88c06c53bmr120199qtw.0.1688795312491; Fri, 07 Jul
 2023 22:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230707165221.4076590-1-fengwei.yin@intel.com> <20230707165221.4076590-2-fengwei.yin@intel.com>
In-Reply-To: <20230707165221.4076590-2-fengwei.yin@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 7 Jul 2023 23:47:56 -0600
Message-ID: <CAOUHufb=f1KUyXFGm7XjXJu8sp+pYrhUreiTe=ypqMnJbgwGKg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mm: add function folio_in_range()
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com
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

On Fri, Jul 7, 2023 at 10:52=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
> It will be used to check whether the folio is mapped to specific
> VMA and whether the mapping address of folio is in the range.
>
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
>  mm/internal.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index f1276d90484ad..66117523d7d71 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -585,6 +585,32 @@ extern long faultin_vma_page_range(struct vm_area_st=
ruct *vma,
>                                    bool write, int *locked);
>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>                                unsigned long bytes);
> +
> +static inline bool
> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
> +               unsigned long start, unsigned long end)

Is there a caller that's not "folio_in_range(folio, vma,
vma->vm_start, vma->vm_end)"?

If not, then just "folio_within_vma(folio, vma)" or a wrapper on top
of  folio_in_range().
