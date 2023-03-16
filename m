Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E556BDAC5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 22:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCPVVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 17:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCPVV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 17:21:28 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B8F6906A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 14:21:27 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3184514d31eso13185ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679001687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sed8mBQa+lDJxDv12thn4n6WdTH+ovGBkrm+trscL6A=;
        b=HTnshhdiEiXyeKl4aXg09OlYc6L0l5aXKBxe+SSC8s1UqdOiifd5GvbIZKnKLvIpgA
         hmv7dcTXYgl1H4YfNtUB/hCKvG0Gk30ZPmFbvTnOHpDj/rNAwbSYgmpb27mFIlItu8gR
         Q67ZxNxJsXc1x64otXi64FYctPeHvD9uVdlOwF4QSc4xQUYxAatEhAKJbxFKsf2YzalK
         xlroQyV/d4OgufRs+/hfTzoy9gWEKHt7e0UMYMfIJDeVwX6qxIDozSSORu+6XoPsqG8S
         UI58g7w7eOSfEoC3NZz/XiW75sujncvLf402RgG8b+TbJ2xJwEy33cNyYH1RErdF5f0F
         cIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679001687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sed8mBQa+lDJxDv12thn4n6WdTH+ovGBkrm+trscL6A=;
        b=WTjbLo7LDPMntpZA5RjPqEw57DwHR4KljqgakWKjzpJUxxDlSLadmYkdC1zuF9qWeH
         Bwf+mQMiM2mW0F0O3s/67lLzgpwOxIY98bkxETKM5X2FMrs/y8VyXyG8vllSH4wK0Xbq
         XHv+TTeuojy6CjDuyOO+1uYLWO24CwUZHKOkyRpoHQMckblwGB6s0YemTTPMqssUvZfp
         zQC2z0pzR8KU9ttZPAiZEXXyayIuA8h+9fPTrubBmI2yXle5h/IuMrD+WsdmdEGCJmaO
         GhoDOe1y+FH0Em79GnZ2UYdH8OTJxdHAof4Wsf0CW3PeBJUjuyO0DBZ98rtV5MCi30I9
         +Mgg==
X-Gm-Message-State: AO0yUKWbCmn8K9vbYqMdwPz1tg91dEA87ShOTbr8KbRL2Pe2LOQbQX3q
        +RrToHxi7+V9kkJrFyOrNnl/72TYa30a2IdAH42RxStCAbT3veFAYTs=
X-Google-Smtp-Source: AK7set98LyaF+G5c4cnoCd0UiaU3BqlTvVBEFgHA8CSTx/7bwOpAfyueD2HfNo/QxkqsC9+iUNNK8oXMFvgA+KpjHA0=
X-Received: by 2002:a05:6e02:1c8f:b0:322:c06b:50c0 with SMTP id
 w15-20020a056e021c8f00b00322c06b50c0mr33534ill.11.1679001686705; Thu, 16 Mar
 2023 14:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230316194156.8320-1-adrian.hunter@intel.com>
In-Reply-To: <20230316194156.8320-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 16 Mar 2023 14:21:12 -0700
Message-ID: <CAP-5=fV8HsLWzXSV-mov+s1doKNFvAPqpep9dhnoAbS3bdir5A@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf tools: Address fixes
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 12:42=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> Hi
>
> Here are 3 small fixes resulting from a report from a
> kernel test robot:
>
> https://lore.kernel.org/oe-lkp/202303061424.6ad43294-yujie.liu@intel.com
>
> Issues were revealed due to the use of build
> option:
>
>         EXTRA_CFLAGS=3D"-fsanitize=3Dundefined -fsanitize=3Daddress"
>
>
> Adrian Hunter (3):
>       perf symbols: Fix use-after-free in get_plt_got_name()
>       perf symbols: Fix unaligned access in get_x86_64_plt_disp()
>       perf tools: Avoid warning in do_realloc_array_as_needed()

All 3:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/util/symbol-elf.c | 10 ++++++++--
>  tools/perf/util/util.c       |  3 ++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
>
> Regards
> Adrian
