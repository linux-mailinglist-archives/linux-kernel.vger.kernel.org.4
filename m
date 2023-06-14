Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82A57304D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjFNQV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjFNQVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:21:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36D72125
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:21:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b3e3f33e33so224545ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686759701; x=1689351701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPUtrT0fiELnm68AoWvfnxE4katFET0OQjBAFidn7qU=;
        b=ELeVGt5nDa3D4i0U0B/sV1WRxjReY606KOf09X+Y7uBcTC4++0QuewNRul+2Rdo8zS
         Ti1N3vX7QUKH/iQTJ7Ckf2CETdKLlGzslHAMXT2fJZapzlE5yDZWc7Z+IzubE5cjoaHh
         HJNB2UPFiEwztN2dUVnBewvPacerUibpED6r9JEkT16Y3NQjr/nZGSJfkMQsCS1vt5PM
         XJS2AnbGmVrq8lKfyp5juBW1q3/DoXLunms/FwdLRtHX0YNIyJezk27hPfFLrC4CCv3v
         91BnFBYUsWz1tYAd6X/ljnIqYNHBcmkBo85hOTVyHpsJ/MVXr7bzzNApoAsmGT5l0D/v
         plfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686759701; x=1689351701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPUtrT0fiELnm68AoWvfnxE4katFET0OQjBAFidn7qU=;
        b=h7kw2O2kIjdUQdwknTaXfwOKifCv3miSOeOoyrjF2wjv07ehnbIRFKU1wn9Gn9g1fp
         KYJei/fyBXZhdd0d7A02I6YqT8Q5iMkPaCb34k2SPPtBbxWRhPIVhi7CFjt01oFes2ai
         WuIOkVLq2/yOeZQ6faWujThJzjQF47OOhL2tpaHN1emDom/K5Y2hsmOnBROUMK02Tdmv
         5ZpBih2rSXqH1YGmJZWtS+4oow1o626uCQfaPQBCnW1IGdR5OJC6bg1mcW+vE/OJWTHo
         O9zGxavmHc07hFbHwcG6z9mPE5v/Zf95nKX6yTUYJinZ9PrhyW5VNmTloRMYYrMqmkjM
         3bOA==
X-Gm-Message-State: AC+VfDx2TeEmqQwpqmLTqiuMrWxP8aR/8JgFTo+ro/JFtzrJRgHowIky
        n3oWyGsHNGGT4fHd1PvnRioUcwGGqju4KdsWYii8ag==
X-Google-Smtp-Source: ACHHUZ7JEUXcvsY6VNzSokeg5/wOw4hTAQZEekolk3qugMY924fpq/4OewED1s/BZJ/mlANbEdFAdmULCHH3BgWHTAU=
X-Received: by 2002:a17:902:e88a:b0:1b0:5304:5b6b with SMTP id
 w10-20020a170902e88a00b001b053045b6bmr259310plg.20.1686759700941; Wed, 14 Jun
 2023 09:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230614150118.115208-1-cymi20@fudan.edu.cn>
In-Reply-To: <20230614150118.115208-1-cymi20@fudan.edu.cn>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 09:21:29 -0700
Message-ID: <CAP-5=fWQq9MM-NXL75_a_JoTVEwvS1oy8oKRefsLxU1kyjWKZg@mail.gmail.com>
Subject: Re: [PATCH] perf subcmd: Fix missing check for return value of
 malloc() in add_cmdname()
To:     Chenyuan Mi <cymi20@fudan.edu.cn>
Cc:     acme@redhat.com, namhyung@kernel.org, leo.yan@linaro.org,
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

On Wed, Jun 14, 2023 at 8:01=E2=80=AFAM Chenyuan Mi <cymi20@fudan.edu.cn> w=
rote:
>
> The malloc() function may return NULL when it fails,
> which may cause null pointer deference in add_cmdname(),
> add Null check for return value of malloc().
>
> Found by our static analysis tool.
>
> Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/subcmd/help.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> index bf02d62a3b2b..510a3eccb60f 100644
> --- a/tools/lib/subcmd/help.c
> +++ b/tools/lib/subcmd/help.c
> @@ -16,6 +16,8 @@
>  void add_cmdname(struct cmdnames *cmds, const char *name, size_t len)
>  {
>         struct cmdname *ent =3D malloc(sizeof(*ent) + len + 1);
> +       if (!ent)
> +               return;
>
>         ent->len =3D len;
>         memcpy(ent->name, name, len);
> --
> 2.17.1
>
