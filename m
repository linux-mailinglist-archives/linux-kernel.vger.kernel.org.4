Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020286D2C07
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 02:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjDAATc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 20:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjDAAT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 20:19:29 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF941EFF2;
        Fri, 31 Mar 2023 17:19:18 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id 89so17324075uao.0;
        Fri, 31 Mar 2023 17:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680308358; x=1682900358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kN1OI426ezj2MWajyPtGNRa8U4BJeq5PITvMLQQ1/Y=;
        b=DeQTue7QWuuU289VaxS3cHYPwUXvJ2MCX9j1RO6RRpfWJDAMtnpC0I/mtfFBfs3nmM
         gcMd9lT1kWZ4yM8V6g3vzvf4y8n0703ZhnQuNAVdf1BbVTTPslfcKmp5cKqG3EtuMjel
         Hi7/oFSYQCt73oXvWVpFI+Z+WtVfjB8zWjFPk26OZrU2Kjef3bmPzVv7jZR3qIidWcKl
         wt47Sun/b/BZgBxyz9hoiOL1tKGVD7Cu12R7DCXIZelOwzbPm7JaiGNXKcAPn0JSrYox
         NYWFc+ROyR7kL1XpyOueL5bNOH0qP0rBC2KVgfNi1MZq2r8JiFarm6BWy1Pe0X+M2mXN
         C7tg==
X-Gm-Message-State: AAQBX9ddKXhlX5tGHPluUPEeIkkBH2MsCMK5X1iFZ9ernMqUaH18SFUG
        zVDEKeLLpVb8G/06viW5h5neJw4UunOeSvbKK+A=
X-Google-Smtp-Source: AKy350aS07PTliXHfT/6Fq04P4riBefEIEVNi71XSk6owR1j8k7Nb0TCatxE3WstsfhhsfpiDIWmIjP0RuLipcCwExM=
X-Received: by 2002:a05:6122:2e9:b0:400:f286:4e07 with SMTP id
 b9-20020a05612202e900b00400f2864e07mr11620548vko.9.1680308357755; Fri, 31 Mar
 2023 17:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230331004844.1592789-1-irogers@google.com> <20230331004844.1592789-2-irogers@google.com>
In-Reply-To: <20230331004844.1592789-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 31 Mar 2023 17:19:06 -0700
Message-ID: <CAM9d7cjXGO-xd1tKDUHUrYtG=94aXnubRrUNe6EmyuGwo3=okA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] tools api: Add io__getline
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

Hi Ian,

On Thu, Mar 30, 2023 at 5:49 PM Ian Rogers <irogers@google.com> wrote:
>
> Reads a line to allocated memory up to a newline following the getline
> API.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/io.h        | 40 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/tests/api-io.c | 36 +++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
>
> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> index 777c20f6b604..d874e8fa8b07 100644
> --- a/tools/lib/api/io.h
> +++ b/tools/lib/api/io.h
> @@ -7,7 +7,9 @@
>  #ifndef __API_IO__
>  #define __API_IO__
>
> +#include <errno.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <unistd.h>
>
>  struct io {
> @@ -112,4 +114,42 @@ static inline int io__get_dec(struct io *io, __u64 *dec)
>         }
>  }
>
> +/* Read up to and including the first newline following the pattern of getline. */
> +static inline ssize_t io__getline(char **line_out, size_t *line_len_out, struct io *io)
> +{
> +       char buf[128];
> +       int buf_pos = 0;
> +       char *line = NULL;
> +       size_t line_len = 0;
> +       int ch = 0;
> +
> +       /* TODO: reuse previously allocated memory. */
> +       free(*line_out);
> +       while (ch != '\n') {
> +               ch = io__get_char(io);
> +
> +               if (ch < 0)
> +                       break;
> +
> +               if (buf_pos == sizeof(buf)) {
> +                       line = realloc(line, line_len + sizeof(buf));
> +                       if (!line)
> +                               return -ENOMEM;

We can use a temp variable for the failure case, and also free
the original line before returning the error.


> +                       memcpy(&line[line_len], buf, sizeof(buf));
> +                       line_len += sizeof(buf);
> +                       buf_pos = 0;
> +               }
> +               buf[buf_pos++] = (char)ch;
> +       }
> +       line = realloc(line, line_len + buf_pos + 1);
> +       if (!line)
> +               return -ENOMEM;

Ditto.

Thanks,
Namhyung


> +       memcpy(&line[line_len], buf, buf_pos);
> +       line[line_len + buf_pos] = '\0';
> +       line_len += buf_pos;
> +       *line_out = line;
> +       *line_len_out = line_len;
> +       return line_len;
> +}
> +
>  #endif /* __API_IO__ */
> diff --git a/tools/perf/tests/api-io.c b/tools/perf/tests/api-io.c
> index e91cf2c127f1..0ff39cdfcb01 100644
> --- a/tools/perf/tests/api-io.c
> +++ b/tools/perf/tests/api-io.c
> @@ -289,6 +289,40 @@ static int test_get_dec(void)
>         return ret;
>  }
>
> +static int test_get_line(void)
> +{
> +       char path[PATH_MAX];
> +       struct io io;
> +       char test_string[1024];
> +       char *line = NULL;
> +       size_t i, line_len = 0;
> +       size_t buf_size = 128;
> +       int ret = 0;
> +
> +       for (i = 0; i < 512; i++)
> +               test_string[i] = 'a';
> +       test_string[512] = '\n';
> +       for (i = 513; i < 1023; i++)
> +               test_string[i] = 'b';
> +       test_string[1023] = '\0';
> +
> +       if (setup_test(path, test_string, buf_size, &io))
> +               return -1;
> +
> +       EXPECT_EQUAL((int)io__getline(&line, &line_len, &io), 513);
> +       EXPECT_EQUAL((int)strlen(line), 513);
> +       for (i = 0; i < 512; i++)
> +               EXPECT_EQUAL(line[i], 'a');
> +       EXPECT_EQUAL(line[512], '\n');
> +       EXPECT_EQUAL((int)io__getline(&line, &line_len, &io), 510);
> +       for (i = 0; i < 510; i++)
> +               EXPECT_EQUAL(line[i], 'b');
> +
> +       free(line);
> +       cleanup_test(path, &io);
> +       return ret;
> +}
> +
>  static int test__api_io(struct test_suite *test __maybe_unused,
>                         int subtest __maybe_unused)
>  {
> @@ -300,6 +334,8 @@ static int test__api_io(struct test_suite *test __maybe_unused,
>                 ret = TEST_FAIL;
>         if (test_get_dec())
>                 ret = TEST_FAIL;
> +       if (test_get_line())
> +               ret = TEST_FAIL;
>         return ret;
>  }
>
> --
> 2.40.0.348.gf938b09366-goog
>
