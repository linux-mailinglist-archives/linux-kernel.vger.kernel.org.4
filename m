Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E397673449E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 03:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjFRBUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 21:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFRBUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 21:20:10 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F54BBD
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 18:20:08 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so1432001a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 18:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687051207; x=1689643207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWZSwMXJ9b5IYQZ6KlzYn+1Sxi0W1Opn138UEH5iwQw=;
        b=R7DhVw7gF2xwbDiuqI+kKn5z0pLveaVYOxToKjGVyU0zgF6mt9yjQe/7KqT4CAvd0s
         LlwMcunhwJf6qb3a3qcLIg9qCUG3kJcDE2TKOuvYXMxCUocAtUlc4cmLDswWBts3y4Yq
         UvBplGcotapElBiKrwP2OH73vGJhXE/6kBOVSHynQtTS9UYI6jtp1G/iUCnXa9nRKBcT
         mt8w8L6EirCdxD6qkH98NB2KkCJ9wxqh5uXh4PtxtyFDT7sStDFmts1Lpdm74sGHdiLX
         bX5VY5+h0IrO7KKld/Y3idrhyrys6qI+l06jRGKzydf88si0envnm7TjOqV+kPyB6ZAI
         jqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687051207; x=1689643207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWZSwMXJ9b5IYQZ6KlzYn+1Sxi0W1Opn138UEH5iwQw=;
        b=GdnkjzKeAPj9QA0NhAMKsVHpc5uPgHZTUZUJNqqzjPtjFFZQ+XxMtO75DeoAsCrwQW
         HghdgNh6SU5UMhKh5qbxMGTZCBuWa5vg0Kqlvm8lX8kXSKB+ziUEx8tgkXCiIrzVyLVn
         ij70+Lyi0PxyqqxU3R2S80JhBe0rs43mQ82ZJINE/HqNfdhsF1yen3SPxn4HdEOVkRBF
         IGqkC9KvQis6Pf/Z28GJep1C+heYlgMiefsvUrdHSryP6cTmwNVzIKSagNeLYagaa687
         NOhL4ms8L7gqi0+vs17Xg2cbsEIjcaQ8EcWa/+AWo/qikifoWd9hLWLyVomy8hGwQdLO
         +T6w==
X-Gm-Message-State: AC+VfDyUdgKwP4M2Vo6JnN8aE0tfuQF6ChzIOpACHoiUK+tea5gGApcT
        JOY414xbxUYvAaf+ffzXimcuise1VLuEGjXT7yFQLSG+gXk=
X-Google-Smtp-Source: ACHHUZ7JxgS17IKFHRVnuu5sgncR+m6NNV4RAbWMcGlZLC5C1ZeaxJsmU8vcRfyQ81anB8KJ7LIHdY8FkYPS6gxd+gc=
X-Received: by 2002:a17:90a:5643:b0:25b:de6b:b2d7 with SMTP id
 d3-20020a17090a564300b0025bde6bb2d7mr15659493pji.11.1687051207582; Sat, 17
 Jun 2023 18:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230616070041.GA32700@didi-ThinkCentre-M930t-N000>
In-Reply-To: <20230616070041.GA32700@didi-ThinkCentre-M930t-N000>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sun, 18 Jun 2023 09:19:55 +0800
Message-ID: <CAJhGHyDTQFCA1KJGZjnb9yV-es5f_rz2mvoXm-RuiKuW2fXvcQ@mail.gmail.com>
Subject: Re: [PATCH] workqueue: format pr_warn exceeds line length in wq_numa_init
To:     tj@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, zyhtheonly@gmail.com,
        zyhtheonly@yeah.net
Cc:     tiozhang@didiglobal.com
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

On Fri, Jun 16, 2023 at 3:00=E2=80=AFPM tiozhang <tiozhang@didiglobal.com> =
wrote:
>
> Format this long line which would potentially let checkpatch complain
> "WARNING: line length of 103 exceeds 100 columns".

Hello

This patch hurts the readability actually. A few extra characters exceeding
is Okay for me.

Thanks
Lai

>
> Signed-off-by: tiozhang <tiozhang@didiglobal.com>
> ---
>  kernel/workqueue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 47e7b29df5fe..4375c7190353 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5959,7 +5959,8 @@ static void __init wq_numa_init(void)
>
>         for_each_possible_cpu(cpu) {
>                 if (WARN_ON(cpu_to_node(cpu) =3D=3D NUMA_NO_NODE)) {
> -                       pr_warn("workqueue: NUMA node mapping not availab=
le for cpu%d, disabling NUMA support\n", cpu);
> +                       pr_warn("workqueue: NUMA node mapping not availab=
le for cpu%d, disabling NUMA support\n",
> +                               cpu);
>                         return;
>                 }
>         }
> --
> 2.17.1
>
