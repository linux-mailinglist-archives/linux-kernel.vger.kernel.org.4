Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E714F717227
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjE3X5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjE3X53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:57:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E167FB2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:57:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96f5685f902so771885366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685491046; x=1688083046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irawpEcShcOFbqSfMe4v0NPnVegXzVzVnWF9D2giD9s=;
        b=ZvOASTbhIvwRaFys7hANyH9bpyOx4YlDxiR8GHKD9SYbZTnff95bSM5c/KQXM2H1pB
         pdiI1/rqdWnEcFR/zez/MU+STTlT2voj4r3xaA/2uf94J++3dpoeBOT8ohLoxHNOGpSR
         otxvghneVjyn7Z2raNtS0ED12iioF8OOiGRiBvP00Q9PiwRizM88FBSmgJKXQGKHQQk7
         5reQmZ2oSmkYPCdI6on2I8Q1xpl0JB85hFySWjdhm+cooc1a2LLBWQ6ZkLSqaCyZT/Rg
         lgstxpduGP8MkEuqC+k9ezpN1jNnTUkfutoGUcQosE5KBo/xYRaOIOVpm79mYKlCi17v
         pryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685491046; x=1688083046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irawpEcShcOFbqSfMe4v0NPnVegXzVzVnWF9D2giD9s=;
        b=JJ4TIkJBRdYCIcOoL/xeUpW9RqrMzMrSDFOPBuitFEymOb41yygJsxohxwjbu/4v89
         DOr+2RAPJmiCTaiD3a1ZVuMIfmACBOP2OkoheW18toanoboY018NjRte0WBtPhghp8WU
         kuo3LYlejSJ5CSRJJas2F+n5cBef+Szlri1f+R8xqpklfUAGGfqK5fargSp3WSEJNvB7
         leIZ3UgXFUwJFIOWl0cNxvx450faHOROfxGcsHmDxGNKbcQQK76nwmqXkewTPnmRHUW1
         NqpfsYY+7iYQRLxgMvt1gCj+ttKSHhQEW0ul8tgPw+g3vSlboyBaCEOt5BrIJ0liLMhE
         wiMw==
X-Gm-Message-State: AC+VfDwOFu0ZNSjBLZnRaae7r45akJNCfye0rMxd5EwiO6WCp2ysUtB3
        0sqT9xNdUuiOm3d06fhRMJouPSTpHPLlJSqX+7+EAA==
X-Google-Smtp-Source: ACHHUZ5wnBhENC6jyjk3XZkH/KXC4TGcgeaoMvOQcTB4XFx9dIsl7trBs2gAsHt5pOI61mA0Cdl9EGAL2kelSq7e0BQ=
X-Received: by 2002:a17:907:16a3:b0:96a:f688:db6e with SMTP id
 hc35-20020a17090716a300b0096af688db6emr4385611ejc.74.1685491046241; Tue, 30
 May 2023 16:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230530210251.493194-1-yosryahmed@google.com> <20230530235447.GB102494@cmpxchg.org>
In-Reply-To: <20230530235447.GB102494@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 30 May 2023 16:56:49 -0700
Message-ID: <CAJD7tkb3GO7yiYp4NHApyRHyg_kzaPuMQPvkvS0aUzUHkPkNzg@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: support exclusive loads
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Tue, May 30, 2023 at 4:54=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, May 30, 2023 at 09:02:51PM +0000, Yosry Ahmed wrote:
> > @@ -216,8 +216,13 @@ int __frontswap_load(struct page *page)
> >
> >       /* Try loading from each implementation, until one succeeds. */
> >       ret =3D frontswap_ops->load(type, offset, page);
> > -     if (ret =3D=3D 0)
> > +     if (ret =3D=3D 0) {
> >               inc_frontswap_loads();
> > +             if (frontswap_ops->exclusive_loads) {
> > +                     SetPageDirty(page);
> > +                     __frontswap_clear(sis, offset);
> > +             }
>
> Somewhat tangential, but is there still a point to the frontswap
> layer? It seems usecases other than zswap have never materialized, at
> least not in tree. Life would be a lot easier if we were to just
> hardcode the zswap callbacks in the swap functions.
>
> It's not the patch's fault, but it highlights the boiler plate the
> indirection causes. ->load() already has the page and could just dirty
> it directly. Instead now both layers have to handle invalidation,
> which is a vector for bugs.
>
> Can somebody think of reasons to keep it? If not, I'd take a stab at
> removing it.

I was intending to eventually remove it as part of the swap
abstraction proposal I am working on, but this will take some time. If
you want to remove it now, even better :)
