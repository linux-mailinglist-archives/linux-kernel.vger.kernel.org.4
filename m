Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FA27233A1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjFEXWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjFEXWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:22:08 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D685CF2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 16:22:07 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-626157a186bso38276236d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 16:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686007327; x=1688599327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IcBNQ6wR3BnyA8PbrWmTom6ZPwjcvznG81SfcljO/4=;
        b=jFky+alzcqgF1T47IU4kzurhY1N1HYv6MA9Hwb3JsyWOCBqzweoWR7kYMQYXyLi056
         O7CUA9wIHhNbbXvpcxHQtppUd3uj65/LAxgTaillJVRF0LzqipvPfxEE6aJeWpCZMduu
         43h3Ac8lLmocrFfRXr+Dfrl93MWtBNIR9XS8GUFDYQKPu3I27ONe1ssdYdRtlJzsjSwe
         f4bUabCgX9NjRU7NWKwLPqJ8x2Bs5Ov8Y1MfA2TcgbqecSD3mOYdqy9zw30FM4RyDi34
         c+JnhlH8wM5VYS3yTRg908VHKYw+DB9pA2P9DrwkHaN5JJlO36hgtt3fO8xAH9tvt24D
         95+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686007327; x=1688599327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IcBNQ6wR3BnyA8PbrWmTom6ZPwjcvznG81SfcljO/4=;
        b=JnBhRCGPZiu2Tg4NB2mzoYUB2/s1VWK29AvsZyGyLA1i03Xk6F6V3HvuA7y3K2cpvU
         N61qhC3NewrxURuJV2dhqM1/ebeb5yr/RcplstLIuXwCV+/HTTbN+w9JD6XseO8F5bb4
         4pw7YXBsciU0oM0oMmCXnw1pXeQbBvmmo9BitpXlyKklOOp3l5fwK6fLhGfviMxNI0lL
         3LFOJIgSbVtL9O9iSQSl9UjF852W4+WXIlVrus9bRh+rDHYTUmQnegk9SHIVsdwxFkYW
         txt7YjnAkHZAtbwLb0XIHLD5bJ+ojfaiWtxCV3/A7GTgAZIBiskaOJLiWhX8jQIS3JPS
         H9wQ==
X-Gm-Message-State: AC+VfDwoxpc/TTYrtqM9r5X41R9MgoRH/8++WfMJBwowMkpW4PcRstis
        64j68Pm+l3CpJiRxqanvdwsGpyX9zsqciIGKagk=
X-Google-Smtp-Source: ACHHUZ6DjJKlLf3d9J/0SgsmM5xYo8i9dVEL7Z9se8wUDotMy9DziB59PN5fFOac704sskSTn4fuBcm/hq5sxa/MAhQ=
X-Received: by 2002:a05:6214:27ca:b0:625:86ed:8aab with SMTP id
 ge10-20020a05621427ca00b0062586ed8aabmr498045qvb.14.1686007326794; Mon, 05
 Jun 2023 16:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230605085419.44383-1-cerasuolodomenico@gmail.com>
 <20230605085419.44383-5-cerasuolodomenico@gmail.com> <20230605153718.GB221380@cmpxchg.org>
In-Reply-To: <20230605153718.GB221380@cmpxchg.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 5 Jun 2023 16:21:55 -0700
Message-ID: <CAKEwX=PpG6F9tWjDhEq5PuLecuWx=PLuFzyhxLA3EfwuFfc0kA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] mm: zswap: remove page reclaim logic from zsmalloc
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 8:37=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Mon, Jun 05, 2023 at 10:54:16AM +0200, Domenico Cerasuolo wrote:
> > @@ -884,14 +842,6 @@ static inline bool obj_allocated(struct page *page=
, void *obj, unsigned long *ph
> >       return obj_tagged(page, obj, phandle, OBJ_ALLOCATED_TAG);
> >  }
> >
> > -#ifdef CONFIG_ZPOOL
> > -static bool obj_stores_deferred_handle(struct page *page, void *obj,
> > -             unsigned long *phandle)
> > -{
> > -     return obj_tagged(page, obj, phandle, OBJ_DEFERRED_HANDLE_TAG);
> > -}
> > -#endif
>
> You can actually remove even more here.
>
> The entire concept of deferred_handle is about serializing free with
> reclaim. It can all go: OBJ_DEFERRED_HANDLE_TAG, the member in struct
> link_free, this function here, find_deferred_handle_obj() (declaration
> and implementation), free_handles(), and the deferred handle bits in
> obj_free() including the handle parameter itself.

For more context on this:
https://lore.kernel.org/all/20230110231701.326724-1-nphamcs@gmail.com/T/#u
