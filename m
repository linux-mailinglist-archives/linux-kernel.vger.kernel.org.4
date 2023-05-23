Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AB970D072
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjEWBXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjEWBW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:22:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897398E
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:22:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f8d485ef3so494830766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684804976; x=1687396976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brU7RQ+GWstmWehtBp5kHdxVU+aQOyCqzRRA2KYgsys=;
        b=RRV+ShNnaIytj43cNL5DxFfWwXEiYfEI7QHTDKpHRkbSd1GQcbSL1FqifpijmGHxdJ
         SrgtyBtpHkWrdbZ4Nl2Fy/ELKSGOjjdnpPfyDdYG4znYVFyjcGYUumQrWTsvWXLErY6K
         Ru8DVX4ruvl2p8ryeViFmKk0jtnpz0bsFgrpC8GQLCt67Z1AhS/UuGd4E3EdX9o7i2ZJ
         GgpxXz28uGthrYFU2BpA0fqoNJKB7U9M0spjC9wBRj0Paw3KkDY+G4bzGsSqUqLrXkAy
         LGEHY0/vSJw8cd/HMCe/AF95cH9B7LY2UviFcrp2pgnEZyZGesPvN09Ll5lNEbSZmpvI
         PMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684804976; x=1687396976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brU7RQ+GWstmWehtBp5kHdxVU+aQOyCqzRRA2KYgsys=;
        b=XvRPLkTMffp5ydTn3gMTRh8btYSgpZz4QqQ7fmGb3LZV0oYcqczWr+NqmRc6G/DWCQ
         xev8qngS2BOOlKur8PrHxmsTHMj4LCn/XAn2kN1mgpmGPh5WuCzJ6FT3THX9Cz1nZSG3
         5Z/02hU7DVQBOemalmcnlkYmAPLdFkF2krQ8ZQWyOS5MzTINhR4MjV1mcqlgXsrEgofK
         G4gHG/OHROMr1Gby7ymob1n0phbYYY5GkueKXo/XDIJsrjDRnTLZedmfWZhtLRYcKdbC
         XKgwylxf0P+fUXicW2yzBq3KHsU81DRJUXgaXNSVkxVBDkMYKlxHU0Ds7jcQ33StOD2L
         xj0w==
X-Gm-Message-State: AC+VfDzBacChPUPsloSI2yShHdf0ILqyUlWr2QeDbq95TmcCOIsQkYEn
        T2/s1U7M2WvItvosLhlMlp9PuakwvEQR66Zpx8U1NA==
X-Google-Smtp-Source: ACHHUZ4y4eYO3dT+yBTX+IfB46arPDMcmuSL1VHTRV+iyzATjKCFPYc6PESatSozz+jwgsS3NuvXDsBv0svGb0jc50k=
X-Received: by 2002:a17:907:7e9c:b0:96f:7483:529c with SMTP id
 qb28-20020a1709077e9c00b0096f7483529cmr12197989ejc.30.1684804975982; Mon, 22
 May 2023 18:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230522070905.16773-1-ying.huang@intel.com> <20230522070905.16773-2-ying.huang@intel.com>
In-Reply-To: <20230522070905.16773-2-ying.huang@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 22 May 2023 18:22:19 -0700
Message-ID: <CAJD7tkYUOHWFOTouv6WsGnzsBhJzm7OHi--RgujWH0ZabZwqHw@mail.gmail.com>
Subject: Re: [PATCH -V2 1/5] swap: Remove get/put_swap_device() in __swap_count()
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
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

On Mon, May 22, 2023 at 12:09=E2=80=AFAM Huang Ying <ying.huang@intel.com> =
wrote:
>
> __swap_count() is called in do_swap_page() only, which encloses the
> call site with get/put_swap_device() already.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> ---
>  mm/swapfile.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 274bbf797480..8419cba9c192 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1432,16 +1432,10 @@ void swapcache_free_entries(swp_entry_t *entries,=
 int n)
>

nit: I would add a comment here that the caller needs get/put_swap_device()=
.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

>  int __swap_count(swp_entry_t entry)
>  {
> -       struct swap_info_struct *si;
> +       struct swap_info_struct *si =3D swp_swap_info(entry);
>         pgoff_t offset =3D swp_offset(entry);
> -       int count =3D 0;
>
> -       si =3D get_swap_device(entry);
> -       if (si) {
> -               count =3D swap_count(si->swap_map[offset]);
> -               put_swap_device(si);
> -       }
> -       return count;
> +       return swap_count(si->swap_map[offset]);
>  }
>
>  /*
> --
> 2.39.2
>
>
