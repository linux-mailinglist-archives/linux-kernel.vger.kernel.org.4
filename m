Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C59E5E879E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 04:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiIXCu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 22:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiIXCuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 22:50:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D27089829
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 19:50:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n12so2486945wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 19:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wL47zhHiq/j2A0WBvknBWlKiXgBzwgGyo3DpJQYgDuY=;
        b=HYkZn1RjCk5aYEFzRamswVfdOi92tu3C+xNnlhnIpPOHylbj0jA+2SbU848yOyf6cF
         9NqyZoWjX0wisq5a3Ex+YrVzXDi4x0Kr4qipf6uwklCquc1d5NL7Hw7Ty90qjPJErHkC
         vVVARtd7CL5STxaZ0pyokK31+2Skp9yXmoyaXP16lU0y/z2ZddBr2i3WeAmIhgFskpCo
         akk1YDoQS9oDm0GyEen6g2P1zW1e8qi6nREZE+ZV5k35WQ6u0j9AwIhx2rfJ5bLVQny2
         SMiO4+9UJiy3g5D60Satbkxr/07qXfW/Das44UJIQD9JoQETya6ZdqbUW8QIRMUJIUlZ
         ilTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wL47zhHiq/j2A0WBvknBWlKiXgBzwgGyo3DpJQYgDuY=;
        b=TjkV9Z9UzgxZTrZjx1ZlRa29RlfGlDltdHrsqsNfMU01+zZI7k1IpuMA+osts0p8yQ
         nrOBVJaXoLiNJOf1WxrlzKp3qrbOJE4LVm6m4podAXAEkebfyCX0GUOr4pVPz08sIFnM
         4gNYqoVn3hjHb21Z75TKMzjTBPZLMeUiC7cAkn1l29qEJGtKlZPWOOOC/w5VSTA/Kd23
         I8o8+vQgYG7aUDfw7eSAD3oYPQvlHI7JAiPEAI/nohRJnd54xX5Y/lFOY9K7OG3Df9od
         AIzZPWhpJdb9bkZLwDwDCXuT0hr5b59b8FhiW0IJd44hSt/7Eb4mgrIcysLCFl7a37vp
         qhhg==
X-Gm-Message-State: ACrzQf0kforeMTXvtAPDIsyxhBQsQj9D5+rP2iohg4Gp0D/DpIHMA3pQ
        68F8tQlVVjasEGBqWhLXZ2D8pCOV2BASlVxqeSt9EA==
X-Google-Smtp-Source: AMsMyM6opBVt1k0wCOas6RVChU/4OL1I9xASku8lriGHHRKI0MNINwb7Hp5Kvk/XvwiAcpwrBlgSC2J32HkUPMFG8nE=
X-Received: by 2002:adf:e4ca:0:b0:228:d8b7:48a7 with SMTP id
 v10-20020adfe4ca000000b00228d8b748a7mr6659816wrm.300.1663987816166; Fri, 23
 Sep 2022 19:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220924004221.841024-1-namhyung@kernel.org> <20220924004221.841024-3-namhyung@kernel.org>
In-Reply-To: <20220924004221.841024-3-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Sep 2022 19:50:03 -0700
Message-ID: <CAP-5=fWiYVd46LD1MG2ZJidqExtsc6C3E19mFNAAAU9xX45gPA@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf test: Add kernel lock contention test
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Sep 23, 2022 at 5:42 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Add a new shell test to check if both normal perf lock record +
> contention and BPF (with -b) option are working.  Use perf bench
> sched messaging as a workload since it'd create some contention for
> sending and receiving messages.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Great!

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian


> ---
>  tools/perf/tests/shell/lock_contention.sh | 73 +++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100755 tools/perf/tests/shell/lock_contention.sh
>
> diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
> new file mode 100755
> index 000000000000..04bf604e3c6f
> --- /dev/null
> +++ b/tools/perf/tests/shell/lock_contention.sh
> @@ -0,0 +1,73 @@
> +#!/bin/sh
> +# kernel lock contention analysis test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +err=0
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +result=$(mktemp /tmp/__perf_test.result.XXXXX)
> +
> +cleanup() {
> +       rm -f ${perfdata}
> +       rm -f ${result}
> +       trap - exit term int
> +}
> +
> +trap_cleanup() {
> +       cleanup
> +       exit ${err}
> +}
> +trap trap_cleanup exit term int
> +
> +check() {
> +       if [ `id -u` != 0 ]; then
> +               echo "[Skip] No root permission"
> +               err=2
> +               exit
> +       fi
> +
> +       if ! perf list | grep -q lock:contention_begin; then
> +               echo "[Skip] No lock contention tracepoints"
> +               err=2
> +               exit
> +       fi
> +}
> +
> +test_record()
> +{
> +       echo "Testing perf lock record and perf lock contention"
> +       perf lock record -o ${perfdata} -- perf bench sched messaging > /dev/null 2>&1
> +       # the output goes to the stderr and we expect only 1 output (-E 1)
> +       perf lock contention -i ${perfdata} -E 1 -q 2> ${result}
> +       if [ $(cat "${result}" | wc -l) != "1" ]; then
> +               echo "[Fail] Recorded result count is not 1:" $(cat "${result}" | wc -l)
> +               err=1
> +               exit
> +       fi
> +}
> +
> +test_bpf()
> +{
> +       echo "Testing perf lock contention --use-bpf"
> +
> +       if ! perf lock con -b true > /dev/null 2>&1 ; then
> +               echo "[Skip] No BPF support"
> +               exit
> +       fi
> +
> +       # the perf lock contention output goes to the stderr
> +       perf lock con -a -b -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
> +       if [ $(cat "${result}" | wc -l) != "1" ]; then
> +               echo "[Fail] BPF result count is not 1:" $(cat "${result}" | wc -l)
> +               err=1
> +               exit
> +       fi
> +}
> +
> +check
> +
> +test_record
> +test_bpf
> +
> +exit ${err}
> --
> 2.37.3.998.g577e59143f-goog
>
