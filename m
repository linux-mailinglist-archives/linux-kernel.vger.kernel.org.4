Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EC4718B73
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 22:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjEaUuQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 16:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjEaUuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 16:50:14 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5874129
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 13:50:13 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-bacf7060678so327627276.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 13:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685566213; x=1688158213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BwXWH09IYFr3ygi1mlaoxaAhmcagOy3rZad8mYQIUk=;
        b=MwYHMeEl/cMatyRjrf928zMI0GRfgTggzsafqN79+SfQ8xBsfE2vlW4emQet1p/sVZ
         Qc6ByF/7/5wrASsVFzboLfYvM5KUmwf+A7fL/psTOVs3IcQxhy3A1urKH1VM+d7JreuI
         Zyc25W9nGKait+BkNOwfCdKTG2F7D20Whf0Ardz/3VLHl5dna5Ujj4qqlxF0TB7vAb5O
         gSSCOI68IhAw7dL3qz9x9ofR5NDjPWZEO7jTGAKbsD9HXVasWEqDaZXCKc/YCtLV4t1l
         +iJdoFx2C0RHvEO4ufp3ROtUySbTlOQFYfw7IZkMbLJhy9zJRmFOcAOdUblGMof5lelj
         beJg==
X-Gm-Message-State: AC+VfDxnG6vuw8k0txs7zNgMwOMoN+PIutmfR7oE4GP0ZsRLmLHAcf9y
        fnPTGM5PolYDAEGPD6VBtNsuyoEFqT4f1Em4k74=
X-Google-Smtp-Source: ACHHUZ4eOIr1HA5GT4gb7klvCENEdhHmYbgoJXt0esyIruR/gsvmc0/aAqcjsrvyjb5vAju8NtjaRV8K3jRjQWiHFnk=
X-Received: by 2002:a25:e7c6:0:b0:b8f:3990:636d with SMTP id
 e189-20020a25e7c6000000b00b8f3990636dmr7082791ybh.23.1685566212951; Wed, 31
 May 2023 13:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230531143533.196835-1-paniii94@gmail.com>
In-Reply-To: <20230531143533.196835-1-paniii94@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 31 May 2023 13:50:01 -0700
Message-ID: <CAM9d7cgsP9cBq_Ui9-53zO0nLzBUK67goO1UcnqZ93Z4E7QcFQ@mail.gmail.com>
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

Hello,

On Wed, May 31, 2023 at 7:35 AM elisabeth <paniii94@gmail.com> wrote:
>
> Fix an issue where an incorrect file name was added in the DWARF line table
> due to not checking the filename against the repeated name marker (/xff/0).
> This can be seen with `objdump --dwarf=line` on the ELF file after perf inject.

I'm not aware of the marker.  Could you please provide a link or something?

Thanks,
Namhyung


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
>                         emit_lne_define_filename(be, ent->name);
>                         cur_filename = ent->name;
>                         emit_set_file(be, ++cur_file_idx);
> --
> 2.34.1
>
