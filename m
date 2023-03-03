Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DA46A9FD6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 20:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjCCTAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 14:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCCTAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:00:38 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E3023859
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 11:00:37 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id h8so3712442plf.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 11:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677870037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/wEZrlLSi3VOukKgvQSnAsQ/5TvalfZllKXsdyYsOA=;
        b=PqyptJaz4kd3Yr8+MT2IiAzBXgf+n0QvvcaWzAO2aRNZlH08cEPV4493ifhKEFqLRL
         bl8OLheeNT3f/+By3Uw+mydB/3RsAmxUFiIN9o9yxJNpmiKi/yL73WZK3mfspZp5LTWs
         k/Cag6H0ihmOlSYqBOYhbTyjr/XQR8di6+SxUbOipX6AcPgG2MvclpHGuzHDWk0I+Q55
         Mf69GR+8lKCmDxwSKnZjR8J1Ap+fKLhWrsSMud3lRoyjBv2sujDyQm0KrhZ+rF4dnYBK
         deMLQUwMm1oG2BzJFg7hwfcWwiZIgevRWeZ4U4ZHINmpk0jj60gLX0DmwTvHmLE9ja5C
         SQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677870037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/wEZrlLSi3VOukKgvQSnAsQ/5TvalfZllKXsdyYsOA=;
        b=VHUSmz9q3KqAudItfynnztCh5nkgJfVV9mJ5sj9CUEtx6lhp9To7aJvPq1LYdrZM8h
         y8kUq5DjTe+JP0HP92Cmgi2oz8BJkVPKD4vTMM0sqs90cimsSfnFETmpdX3zkfzeFT9I
         v4CBMH3IcMgHO2xC534Y+i05Zxd22FMcFmcvu31OnO+wUN5hz63foLwvoR4lpPvpJJeu
         2CIbvFOgNhbadaUSbNFV+3TZP1jDigUubQmh1kE0yMvywKXfKug/ToBUbR0F2rAYhYdP
         nr5NPD7sdP62AXF3YK8tdMp3g6OxdSHcWI+uyvnkp3QX6o1fT6HXOmCvhPWGolTozBLv
         EvTQ==
X-Gm-Message-State: AO0yUKWgUkU/XD3uZ6HFfsKrdNWMb8pvFjpNX/UtRPA9V8YPpCpYWoiA
        B4iSaYg94emXvu8lFkVLx9KwF/4Y8Hu+z0NDhkI=
X-Google-Smtp-Source: AK7set8y3ckSn4MA4cKV+o17bRubw41y2//fbYVNA2teFE1o654FtNxfiGqdgYdoxsQ61B6Py6vTBU6PYWDEo4r4egE=
X-Received: by 2002:a17:90a:14c2:b0:237:c367:edda with SMTP id
 k60-20020a17090a14c200b00237c367eddamr1002911pja.5.1677870036689; Fri, 03 Mar
 2023 11:00:36 -0800 (PST)
MIME-Version: 1.0
References: <20230303151218.311015-1-peterx@redhat.com>
In-Reply-To: <20230303151218.311015-1-peterx@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 3 Mar 2023 11:00:24 -0800
Message-ID: <CAHbLzkog36Ch2Ys8+ZOjbpug68p5XLjt-0Mc1TBVuNAirqRW+A@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Cleanup memcg uncharge for failure path
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Zach O'Keefe" <zokeefe@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 7:12=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Explicit memcg uncharging is not needed when the memcg accounting has the
> same lifespan of the page/folio.  That becomes the case for khugepaged
> after Yang & Zach's recent rework so the hpage will be allocated for each
> collapse rather than being cached.
>
> Cleanup the explicit memcg uncharge in khugepaged failure path and leave
> that for put_page().

Thanks for the cleanup. Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Suggested-by: Zach O'Keefe <zokeefe@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/khugepaged.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 941d1c7ea910..dd5a7d9bc593 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1230,10 +1230,8 @@ static int collapse_huge_page(struct mm_struct *mm=
, unsigned long address,
>  out_up_write:
>         mmap_write_unlock(mm);
>  out_nolock:
> -       if (hpage) {
> -               mem_cgroup_uncharge(page_folio(hpage));
> +       if (hpage)
>                 put_page(hpage);
> -       }
>         trace_mm_collapse_huge_page(mm, result =3D=3D SCAN_SUCCEED, resul=
t);
>         return result;
>  }
> @@ -2250,10 +2248,8 @@ static int collapse_file(struct mm_struct *mm, uns=
igned long addr,
>                 unlock_page(hpage);
>  out:
>         VM_BUG_ON(!list_empty(&pagelist));
> -       if (hpage) {
> -               mem_cgroup_uncharge(page_folio(hpage));
> +       if (hpage)
>                 put_page(hpage);
> -       }
>
>         trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem, add=
r, file, nr, result);
>         return result;
> --
> 2.39.1
>
