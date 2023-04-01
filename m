Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8FE6D2C1A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 02:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjDAA3t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 20:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjDAA3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 20:29:47 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD29B1D852;
        Fri, 31 Mar 2023 17:29:46 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id s23so17279541uae.5;
        Fri, 31 Mar 2023 17:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680308986; x=1682900986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBlyoCG5LrraHZ99yJ0ZxyQWhF4R6c4+6bmaGeRq1gw=;
        b=SMnyPz1pjMV8PG6aQU2i2rI2ASiL1ZLNfSg73RNExKF1/LcxDHBR42kuoy/K6Yne+F
         0Ar0cnORV446hFV3jVpfwzDZXAzrlS74E/r7uagWjz0nu1I2Fn+5M7ZvSZiYh6GWb6nT
         VqkdICrhQ3GB9GeRZOxb9W4vhkFinM5SDgXsOef5A2jcSYdrAaZMz/ZDRbXNHXFkUgPj
         Q36XkfQZnRX75/3K8pfwXR01OvLHCQeQ+3dgIrg9t0ZCCJW8SgiLUYMkCJv5I1K66xq+
         8jbaxl/W8MSi04wfDYRFEBSq+nkgquznVcR7LFlcWAMzL7dpkQb6ikU8RrgC6Fq5do27
         en1A==
X-Gm-Message-State: AAQBX9eb3jbLBj+5gdcC6txdqS67FisWUxKzdeYLVBHX4rmO/6p34t5Z
        g1VAZk1LzFu6NVLsHko/0DwOUwqMzkiRLfAfvYE=
X-Google-Smtp-Source: AKy350b+UdbtNsbeWTDuQqjj0QTeUrVOfKAec9umZoelcs51P97qffJSP5Eyk5kH+sVF/2qMlW+KV9vHGDkcD3E4/z8=
X-Received: by 2002:a1f:2d11:0:b0:410:329:baaf with SMTP id
 t17-20020a1f2d11000000b004100329baafmr9888056vkt.16.1680308985712; Fri, 31
 Mar 2023 17:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230331004844.1592789-1-irogers@google.com> <20230331004844.1592789-4-irogers@google.com>
In-Reply-To: <20230331004844.1592789-4-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 31 Mar 2023 17:29:34 -0700
Message-ID: <CAM9d7cgRw0mHykCAwZvNP8oAXYUPzEXXaMwvg_krBnyPgrF-3w@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] perf srcline: Support for llvm-addr2line
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 5:49 PM Ian Rogers <irogers@google.com> wrote:
>
> The sentinel value differs for llvm-addr2line. Configure this once and
> then detect when reading records.

Thanks for fixing this!

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/srcline.c | 65 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 62 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 2da86e57215d..423ddf3967b0 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -435,7 +435,50 @@ static struct child_process *addr2line_subprocess_init(const char *addr2line_pat
>         return a2l;
>  }
>
> +enum a2l_style {
> +       BROKEN,
> +       GNU_BINUTILS,
> +       LLVM,
> +};
> +
> +static enum a2l_style addr2line_configure(struct child_process *a2l)
> +{
> +       static bool cached;
> +       static enum a2l_style style;
> +
> +       if (!cached) {
> +               char buf[128];
> +               struct io io;
> +               int ch;
> +
> +               if (write(a2l->in, ",\n", 2) != 2)
> +                       return BROKEN;
> +
> +               io__init(&io, a2l->out, buf, sizeof(buf));
> +               ch = io__get_char(&io);
> +               if (ch == ',') {
> +                       style = LLVM;
> +                       cached = true;
> +               } else if (ch == '?') {
> +                       style = GNU_BINUTILS;
> +                       cached = true;
> +               } else {
> +                       style = BROKEN;
> +               }
> +               do {
> +                       ch = io__get_char(&io);
> +               } while (ch > 0 && ch != '\n');

Maybe better to io__getline() ?

> +               if (style == GNU_BINUTILS) {
> +                       do {
> +                               ch = io__get_char(&io);
> +                       } while (ch > 0 && ch != '\n');
> +               }
> +       }
> +       return style;
> +}
> +
>  static int read_addr2line_record(struct io *io,
> +                                enum a2l_style style,
>                                  char **function,
>                                  char **filename,
>                                  unsigned int *line_nr)
> @@ -462,6 +505,12 @@ static int read_addr2line_record(struct io *io,
>
>         if (io__getline(&line, &line_len, io) < 0 || !line_len)
>                 goto error;
> +
> +       if (style == LLVM && line_len == 2 && line[0] == ',') {
> +               zfree(&line);
> +               return 0;
> +       }
> +
>         if (function != NULL)
>                 *function = strdup(strim(line));
>
> @@ -471,7 +520,8 @@ static int read_addr2line_record(struct io *io,
>         if (io__getline(&line, &line_len, io) < 0 || !line_len)
>                 goto error;
>
> -       if (filename_split(line, line_nr == NULL ? &dummy_line_nr : line_nr) == 0) {
> +       if (filename_split(line, line_nr == NULL ? &dummy_line_nr : line_nr) == 0 &&
> +           style == GNU_BINUTILS) {
>                 ret = 0;
>                 goto error;
>         }
> @@ -523,6 +573,7 @@ static int addr2line(const char *dso_name, u64 addr,
>         char buf[128];
>         ssize_t written;
>         struct io io;
> +       enum a2l_style a2l_style;
>
>         if (!a2l) {
>                 if (!filename__has_section(dso_name, ".debug_line"))
> @@ -538,6 +589,12 @@ static int addr2line(const char *dso_name, u64 addr,
>                         pr_warning("%s %s: addr2line_subprocess_init failed\n", __func__, dso_name);
>                 goto out;
>         }
> +       a2l_style = addr2line_configure(a2l);
> +       if (a2l_style == BROKEN) {
> +               if (!symbol_conf.disable_add2line_warn)
> +                       pr_warning("%s: addr2line configuration failed\n", __func__);
> +               goto out;
> +       }
>
>         /*
>          * Send our request and then *deliberately* send something that can't be interpreted as

Can you please update the comment about the LLVM behavior?

Thanks,
Namhyung


> @@ -557,7 +614,8 @@ static int addr2line(const char *dso_name, u64 addr,
>         }
>         io__init(&io, a2l->out, buf, sizeof(buf));
>
> -       switch (read_addr2line_record(&io, &record_function, &record_filename, &record_line_nr)) {
> +       switch (read_addr2line_record(&io, a2l_style,
> +                                     &record_function, &record_filename, &record_line_nr)) {
>         case -1:
>                 if (!symbol_conf.disable_add2line_warn)
>                         pr_warning("%s %s: could not read first record\n", __func__, dso_name);
> @@ -567,7 +625,7 @@ static int addr2line(const char *dso_name, u64 addr,
>                  * The first record was invalid, so return failure, but first read another
>                  * record, since we asked a junk question and have to clear the answer out.
>                  */
> -               switch (read_addr2line_record(&io, NULL, NULL, NULL)) {
> +               switch (read_addr2line_record(&io, a2l_style, NULL, NULL, NULL)) {
>                 case -1:
>                         if (!symbol_conf.disable_add2line_warn)
>                                 pr_warning("%s %s: could not read delimiter record\n",
> @@ -606,6 +664,7 @@ static int addr2line(const char *dso_name, u64 addr,
>
>         /* We have to read the records even if we don't care about the inline info. */
>         while ((record_status = read_addr2line_record(&io,
> +                                                     a2l_style,
>                                                       &record_function,
>                                                       &record_filename,
>                                                       &record_line_nr)) == 1) {
> --
> 2.40.0.348.gf938b09366-goog
>
