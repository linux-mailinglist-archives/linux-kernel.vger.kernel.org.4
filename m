Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03C8744ADC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 20:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjGAShl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 1 Jul 2023 14:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGAShk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 14:37:40 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558DE10C0
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 11:37:39 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso2847714276.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 11:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688236658; x=1690828658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmxqSL+nL1200Zl/GGAhW8b2Oo5qBW0sgToPszYqOSw=;
        b=NU+jvkpFyYFddb3rxnFmMs7jSOU7DuRfjVAT4YeLBHxQld7HLX9HiBII3wqB7lLxeX
         PG2NtJ6fN3Rk+J+nPmKemyMsVnvGwHdOKIRblxFgaNXWIcjWCbCZ+JxCr/1XBIzjgjT1
         Wu0Z1I2J58T5I+w/WcTLytvHHMAOslookhgAWD3qlYCUIbkBLMWWysjU6wggDemlN3dJ
         xBv7E5PgY0rmdNwe6f0db5+ZUFkR6O7X39kgOwTRNOZAyLWmBd31heNa1F0aBy9j1q8F
         LvB/qxoK7izRhaQ12s75IGGXr7qS6IlpJkBWPih68oSIfsb8/8/Ij+KQTeMkM5Zak0ze
         p9bA==
X-Gm-Message-State: ABy/qLY8kYadtYENYqTEjayeD7LOMLRHLn0ngMpaMNXtnCAiJ5zQscKZ
        2gBIvS4hYeXMFTqCsmQq4BEWa/SCRq1HKn0cLKtoD/dw
X-Google-Smtp-Source: APBJJlHNzAI/fwzPh+WMmCTPFqeZ/k1wTd/3xqRdt1K3MmCqE/Qz8XnykxePpAWXgBXn+ctgBXRakKPbePlMiNHTgJ4=
X-Received: by 2002:a25:3f44:0:b0:bc8:914b:c83a with SMTP id
 m65-20020a253f44000000b00bc8914bc83amr5208760yba.22.1688236658433; Sat, 01
 Jul 2023 11:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230626222213.366550-1-irogers@google.com>
In-Reply-To: <20230626222213.366550-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 1 Jul 2023 11:37:27 -0700
Message-ID: <CAM9d7ciWOWbR52HyEG-imv1rhctbuY+QaOdkuhRYvDoc+_J9pA@mail.gmail.com>
Subject: Re: [PATCH v1] lib subcmd: Avoid use-after-free when no commands are excluded
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Chenyuan Mi <cymi20@fudan.edu.cn>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 3:22 PM Ian Rogers <irogers@google.com> wrote:
>
> The array shortening may be an unnecessary array copy. Before commit
> 657a3efee43a ("lib subcmd: Avoid memory leak in exclude_cmds") this
> was benign, but afterwards this could lead to a segv.
>
> Fixes: 657a3efee43a ("lib subcmd: Avoid memory leak in exclude_cmds")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/subcmd/help.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> index 67a8d6b740ea..b59ca17e406d 100644
> --- a/tools/lib/subcmd/help.c
> +++ b/tools/lib/subcmd/help.c
> @@ -77,10 +77,11 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
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

I'm not sure I'm following the logic in this function well
but it seems we also need to check the same thing
in the above loop - if (cmp < 0).

Thanks,
Namhyung


> +               }
>         }
>         for (ci = cj; ci < cmds->cnt; ci++)
>                 zfree(&cmds->names[ci]);
> --
> 2.41.0.162.gfafddb0af9-goog
>
