Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CA1720D05
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 03:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbjFCBiO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Jun 2023 21:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbjFCBiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 21:38:12 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1CA1B6;
        Fri,  2 Jun 2023 18:38:10 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-bacf5b89da7so2976561276.2;
        Fri, 02 Jun 2023 18:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685756289; x=1688348289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMdUwU9Lc9+VbG5jbwUz5cd6Cu7tJyrnLtx+vLrmeGI=;
        b=CccsbsUOPQn873uXnKRGFH5EmU6ts6BlklM8F2EbjV59FqDv+24KsbDdy9nBNtmGMH
         XLJoYYRqN+bcwNAyeDFeOqPTXdaisSSvD2ksE3UN6AyLDgKHKB3MUPHI9eTbN/tpy/+4
         wIaly3MA3bYMha22Pp7gokgknauztmXjeTSn0ccdE1Dqm0hWwUCRsCqAl94y+w7LmHlR
         Kp7C/C045SOSQyhvbtnHKch6qWDh8h6BUBdr4x1e9stkXc+ySMKHSswhmtj2SD56bdpE
         qq9HH+WbkF+gexrfTNj3RgVMAUi3jOoR8ohkhwT4iAtqe/qPFM3uUF2F4of86M9PzqMM
         zBkA==
X-Gm-Message-State: AC+VfDw7h+SNGWqAVGs4KiLFlv0EcTmQLwbKpcBvacYvbKtZ5Sd64NaJ
        a+kUeKEmXXEuCyjwalYyS6KKYFODdj7cxDIfWPs=
X-Google-Smtp-Source: ACHHUZ7+wLs1wt8OkA+DRY/aQQwg3NrUU+RlXc7Y8KTZR41Qbd48tFmJQsnYlCRXGNd/tiB0kShwmi8vRUco/8YRlyU=
X-Received: by 2002:a25:d653:0:b0:b9e:5d84:d859 with SMTP id
 n80-20020a25d653000000b00b9e5d84d859mr4613556ybg.46.1685756289232; Fri, 02
 Jun 2023 18:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230602123815.255001-1-paniii94@gmail.com>
In-Reply-To: <20230602123815.255001-1-paniii94@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 2 Jun 2023 18:37:58 -0700
Message-ID: <CAM9d7cixKroe7Bd8dmckngw20dA0gcfb-_sQgRkw5HiN-kPbFQ@mail.gmail.com>
Subject: Re: [PATCH v2] Subject: perf jit: Fix incorrect file name in DWARF
 line table
To:     Elisabeth <paniii94@gmail.com>
Cc:     Elisabeth Panholzer <elisabeth@leaningtech.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

On Fri, Jun 2, 2023 at 5:38 AM Elisabeth <paniii94@gmail.com> wrote:
>
> From: elisabeth <paniii94@gmail.com>
>
> Fixes an issue where an incorrect filename was added in the DWARF line table of
> an ELF object file when calling 'perf inject --jit' due to not checking the
> filename of a debug entry against the repeated name marker (/xff/0).
> The marker is mentioned in the tools/perf/util/jitdump.h header, which describes
> the jitdump binary format, and indicitates that the filename in a debug entry
> is the same as the previous enrty.
> In the function emit_lineno_info(), in the file tools/perf/util/genelf-debug.c,
> the debug entry filename gets compared to the previous entry filename. If they
> are not the same, a new filename is added to the DWARF line table. However,
> since there is no check against '\xff\0', in some cases '\xff\0' is inserted
> as the filename into the DWARF line table.
> This can be seen with `objdump --dwarf=line` on the ELF file after `perf inject --jit`.
> It also makes no source code information show up in 'perf annotate'.
>
> Signed-off-by: Elisabeth Panholzer <elisabeth@leaningtech.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-perf-users@vger.kernel.org

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
> Changes in v2:
>         - Made the commit message more descriptive
>         - Added a comment that mentions the jitdump format
>         - Changed memcmp() to strcmp()
>
>  tools/perf/util/genelf_debug.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
> index aa5dcc56b2ac..138fdf87eaa2 100644
> --- a/tools/perf/util/genelf_debug.c
> +++ b/tools/perf/util/genelf_debug.c
> @@ -337,6 +337,9 @@ static void emit_lineno_info(struct buffer_ext *be,
>  {
>         size_t i;
>
> +       /* as described in the jitdump format */
> +       const char repeated_name_marker[] = {'\xff', '\0'};
> +
>         /*
>          * Machine state at start of a statement program
>          * address = 0
> @@ -363,7 +366,8 @@ static void emit_lineno_info(struct buffer_ext *be,
>                 /*
>                  * check if filename changed, if so add it
>                  */
> -               if (!cur_filename || strcmp(cur_filename, ent->name)) {
> +               if ((!cur_filename || strcmp(cur_filename, ent->name)) &&
> +                       strcmp(repeated_name_marker, ent->name)) {
>                         emit_lne_define_filename(be, ent->name);
>                         cur_filename = ent->name;
>                         emit_set_file(be, ++cur_file_idx);
> --
> 2.34.1
>
