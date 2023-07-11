Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A5874F74E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjGKRhO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 13:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGKRhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:37:12 -0400
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E61E49
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:37:11 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-45739737afcso1669635e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689097030; x=1691689030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KI4vVyq/o225EnjYmGJ0/PX8RgV9ghoYoSQ/HAeigc=;
        b=eqBkMqq9CZl/jivwdxKVY72hF4DIlLnDx2lR+bOnQeJuCOIMAWFYIUoWhwjEe1HyIh
         oF2uGJJUdqvtzxZlnxFp7BGzzzCNPfF4v4DpO/vYvnnmhuA3BKinUn/P6OCY3fvtQsUx
         FxgTdTijglXcmLYoec0jDs+GpC1AlGl1DyDONOQcwILSW1Nx3XBFouIekDHZwkJoWZWv
         /5zl6VupCefhiJQEUgFy964aiXeKrohEqTdRf9GbUw1NpMiWs8sIrXpCSRTJMVddfA4K
         0Z+yAAt88oMdJs+7ZUmpDSaXHIKDP4Z/1VNjRt9Awbz/bvHDjBIRbzl6uHlqaYa8X5Aa
         TZBA==
X-Gm-Message-State: ABy/qLai1PWljKZETz8qCjQ4oJnsKil+Uu14hojmek6zbjXCy9WSVHei
        Cm/KbbqgUocB+6T7C5s8dkx3vW4M9ZO8/dVbu70=
X-Google-Smtp-Source: APBJJlES2UrsoJ9v97K1u73D2i8+pSWX61ba8QlM8MeqSUdQ1qMwQ66aGyEgaFDm9BrCDwF2jYSucVKoEAmKV/fmjXA=
X-Received: by 2002:a1f:bd58:0:b0:46e:7c85:acb0 with SMTP id
 n85-20020a1fbd58000000b0046e7c85acb0mr5269796vkf.14.1689097030271; Tue, 11
 Jul 2023 10:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230707230926.841086-1-irogers@google.com>
In-Reply-To: <20230707230926.841086-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Jul 2023 10:36:59 -0700
Message-ID: <CAM9d7chqAkLuYYyOSM5n1S-Rzf5ivCCuaqz5Tc1j23a2NsWzFQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib subcmd: Avoid segv/use-after-free when commands
 aren't excluded
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Chenyuan Mi <cymi20@fudan.edu.cn>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 4:09 PM Ian Rogers <irogers@google.com> wrote:
>
> The array shortening may perform unnecessary array copies. Before
> commit 657a3efee43a ("lib subcmd: Avoid memory leak in exclude_cmds")
> this was benign, but afterwards this could lead to a segv.
>
> Fixes: 657a3efee43a ("lib subcmd: Avoid memory leak in exclude_cmds")
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/lib/subcmd/help.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> index 67a8d6b740ea..adfbae27dc36 100644
> --- a/tools/lib/subcmd/help.c
> +++ b/tools/lib/subcmd/help.c
> @@ -68,8 +68,13 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
>         while (ci < cmds->cnt && ei < excludes->cnt) {
>                 cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
>                 if (cmp < 0) {
> -                       zfree(&cmds->names[cj]);
> -                       cmds->names[cj++] = cmds->names[ci++];
> +                       if (ci == cj) {
> +                               ci++;
> +                               cj++;
> +                       } else {
> +                               zfree(&cmds->names[cj]);
> +                               cmds->names[cj++] = cmds->names[ci++];
> +                       }
>                 } else if (cmp == 0) {
>                         ci++;
>                         ei++;
> @@ -77,10 +82,11 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
>                         ei++;
>                 }
>         }
> -
> -       while (ci < cmds->cnt) {
> -               zfree(&cmds->names[cj]);
> -               cmds->names[cj++] = cmds->names[ci++];
> +       if (ci != cj) {
> +               while (ci < cmds->cnt) {
> +                       zfree(&cmds->names[cj]);
> +                       cmds->names[cj++] = cmds->names[ci++];
> +               }
>         }
>         for (ci = cj; ci < cmds->cnt; ci++)
>                 zfree(&cmds->names[ci]);
> --
> 2.41.0.390.g38632f3daf-goog
>
