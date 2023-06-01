Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A59971F082
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjFART1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 13:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjFART0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:19:26 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4059DF2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:19:25 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-bacfc573647so1140170276.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 10:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685639964; x=1688231964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssDpVvbH3HXkVvaZfL5D19DzNcQ2WkA1YRPv1fTXD3U=;
        b=bHrsd01b6klOZTIjg7YjxGbC0EghAcYjS6IhAhpvZ6l1oDQEaHTtz4YOPhKroSwG9y
         NCplpfUf33HzKq98txYCKoI/rk/7s8bnByocET5/4ZuB2ZvPpGj1Qb1h/mNRt3rOPNS0
         G7mC3DVTlSs5LAqnf5YdDp6pW4uKnxDynS/pIpkd2SZbtY4mxA+3G5bOZM1rIoeE2I5S
         0lY/pwaFSDLEHn+HKANILE61awe7ZBhNvAcruC6g0eB6zEWKLrE0ogvDW8XkygQINPbe
         nbAwb4XtYmxc9U0f3JLZznVluKQjFZYGPCdXZtSg69sq1awmJ2VTXmRup71D4fmhHxxs
         x4+A==
X-Gm-Message-State: AC+VfDznGs8CdGTEkGQVzP8qkiuoDITAXMFhDYf0SEY3eQ+SSdxDPNd9
        hU9u3QhHfCPjtJ/unT1UX8fbp+oqKhxQde49DZI=
X-Google-Smtp-Source: ACHHUZ7wG1uiT6t0n4PKQx51l8YGX6XIZ4fYwSbVSRnvTbX5kXUqVOL7cJ0O1FQJlxod0UC2ST++NtbNECa+gebrh1w=
X-Received: by 2002:a25:86c9:0:b0:bab:d9b1:ad63 with SMTP id
 y9-20020a2586c9000000b00babd9b1ad63mr535878ybm.38.1685639964290; Thu, 01 Jun
 2023 10:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230531143533.196835-1-paniii94@gmail.com>
In-Reply-To: <20230531143533.196835-1-paniii94@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Jun 2023 10:19:13 -0700
Message-ID: <CAM9d7chBsVJ=_phHHn4gYcgj6Wn8Ua+gQ62K4rf-edA=8vL9Wg@mail.gmail.com>
Subject: Re: [PATCH] Subject: perf jit: Fix incorrect file name in DWARF line table
To:     elisabeth <paniii94@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
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

On Wed, May 31, 2023 at 7:35 AM elisabeth <paniii94@gmail.com> wrote:
>
> Fix an issue where an incorrect file name was added in the DWARF line table
> due to not checking the filename against the repeated name marker (/xff/0).
> This can be seen with `objdump --dwarf=line` on the ELF file after perf inject.
>
> Signed-off-by: elisabeth <paniii94@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/genelf_debug.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
> index aa5dcc56b2ac..2928b59bb9a5 100644
> --- a/tools/perf/util/genelf_debug.c
> +++ b/tools/perf/util/genelf_debug.c
> @@ -349,6 +349,7 @@ static void emit_lineno_info(struct buffer_ext *be,
>          */
>
>         /* start state of the state machine we take care of */
> +       char const repeated_name_marker[] = {'\xff', '\0'};

Can you please mention that it's from the jitdump format
either by renaming or adding a comment?


>         unsigned long last_vma = 0;
>         char const  *cur_filename = NULL;
>         unsigned long cur_file_idx = 0;
> @@ -363,7 +364,8 @@ static void emit_lineno_info(struct buffer_ext *be,
>                 /*
>                  * check if filename changed, if so add it
>                  */
> -               if (!cur_filename || strcmp(cur_filename, ent->name)) {
> +               if ((!cur_filename || strcmp(cur_filename, ent->name)) &&
> +                       memcmp(repeated_name_marker, ent->name, sizeof(repeated_name_marker)) != 0) {

I think you can just use strcmp().

Thanks,
Namhyung


>                         emit_lne_define_filename(be, ent->name);
>                         cur_filename = ent->name;
>                         emit_set_file(be, ++cur_file_idx);
> --
> 2.34.1
>
