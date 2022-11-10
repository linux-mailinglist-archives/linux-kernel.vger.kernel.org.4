Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ADD62488C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiKJRpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiKJRpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:45:35 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D71F2D744;
        Thu, 10 Nov 2022 09:45:34 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso1513957otr.9;
        Thu, 10 Nov 2022 09:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPpfbWaI3T66n3ewzSWLfdfeEmXCkCg9bjbn97uFpp4=;
        b=1n/Ds6wlaAT9cz6CjMuXVjLf8uWq//K4zf5hNZtUeyXr8HEmVqTRGR8rhAylm8xY1U
         0EoHrnb8Dm/c1nWywSNvi6prLWX9sXfl5q+HqOtUzpT/FPj87Iq4v2oW+u3Ndurrnu+r
         JpzZJ1LI6INND7NAlQHg3YLWcz0Pw+4wXeAze8arbbDSDmZzo9VT8jdUflzhyq4EFv3T
         ykw2TFkjjwV4AfEmrCiKnH91sslz4/5ixonfGZfYCAuRBsGqgDqk2RNG5EVNw6qMl6Wi
         FOgjNTgofdg6UAlhhd3MD+fbOsDRbVl8JpwmLzI4UipUlPKPdmlCI2akxl5aB5QmR8H3
         +ejQ==
X-Gm-Message-State: ACrzQf3zaKeamh5WkEJk/YvB5rxZL7Sn8/ggu5x5Kl6VHt3wX6Ed524o
        B52p31Pz9VB2bwJ/bs5hXm9Vw/8lz+rm+KuNCNiIQNV1
X-Google-Smtp-Source: AMsMyM7tiQy3EnWBe1RU2sVayoHXrExXthRSyPPbGaiP1ORGd4VBJGSzGQ72NJjYlxtf5mXN0yQQsmNf6H3wB2AgNkU=
X-Received: by 2002:a9d:67c9:0:b0:66c:6bc6:cc80 with SMTP id
 c9-20020a9d67c9000000b0066c6bc6cc80mr1699836otn.206.1668102333479; Thu, 10
 Nov 2022 09:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20221109174635.859406-1-namhyung@kernel.org> <20221109174635.859406-7-namhyung@kernel.org>
 <Y2zeOZcNjRCnEAVZ@leoy-yangtze.lan>
In-Reply-To: <Y2zeOZcNjRCnEAVZ@leoy-yangtze.lan>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Nov 2022 09:45:22 -0800
Message-ID: <CAM9d7chTMdMyF45O9_NP_em3+BL1i+5hV=VjeY1visuUFF-p0g@mail.gmail.com>
Subject: Re: [PATCH 06/12] perf test: Replace arm callgraph fp test workload
 with leafloop
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        German Gomez <german.gomez@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Thu, Nov 10, 2022 at 3:20 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Namyung,
>
> On Wed, Nov 09, 2022 at 09:46:29AM -0800, Namhyung Kim wrote:
> > So that it can get rid of requirement of a compiler.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  .../perf/tests/shell/test_arm_callgraph_fp.sh | 30 +------------------
> >  1 file changed, 1 insertion(+), 29 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> > index ec108d45d3c6..9d6d1b2d99c5 100755
> > --- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> > +++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> > @@ -4,44 +4,16 @@
> >
> >  lscpu | grep -q "aarch64" || exit 2
> >
> > -if ! [ -x "$(command -v cc)" ]; then
> > -     echo "failed: no compiler, install gcc"
> > -     exit 2
> > -fi
> > -
> >  PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> > -TEST_PROGRAM_SOURCE=$(mktemp /tmp/test_program.XXXXX.c)
> > -TEST_PROGRAM=$(mktemp /tmp/test_program.XXXXX)
> > +TEST_PROGRAM="perf test -w leafloop"
> >
> >  cleanup_files()
> >  {
> >       rm -f $PERF_DATA
> > -     rm -f $TEST_PROGRAM_SOURCE
> > -     rm -f $TEST_PROGRAM
> >  }
> >
> >  trap cleanup_files exit term int
> >
> > -cat << EOF > $TEST_PROGRAM_SOURCE
> > -int a = 0;
> > -void leaf(void) {
> > -  for (;;)
> > -    a += a;
> > -}
> > -void parent(void) {
> > -  leaf();
> > -}
> > -int main(void) {
> > -  parent();
> > -  return 0;
> > -}
> > -EOF
> > -
> > -echo " + Compiling test program ($TEST_PROGRAM)..."
> > -
> > -CFLAGS="-g -O0 -fno-inline -fno-omit-frame-pointer"
> > -cc $CFLAGS $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
> > -
> >  # Add a 1 second delay to skip samples that are not in the leaf() function
> >  perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 --user-callchains -- $TEST_PROGRAM 2> /dev/null &
> >  PID=$!
>
> I need to append below changes, otherwise the test will fail on Arm64:

Thanks for the fix, will add it to v2.

>
> --- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> +++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> @@ -30,11 +30,11 @@ wait $PID
>  # program
>  #      728 leaf
>  #      753 parent
> -#      76c main
> +#      76c leafloop
>  # ...
>
>  perf script -i $PERF_DATA -F comm,ip,sym | head -n4
>  perf script -i $PERF_DATA -F comm,ip,sym | head -n4 | \
>         awk '{ if ($2 != "") sym[i++] = $2 } END { if (sym[0] != "leaf" ||
>                                                        sym[1] != "parent" ||
> -                                                      sym[2] != "main") exit 1 }'
> +                                                      sym[2] != "leafloop") exit 1 }'
>
> With appending above change, this patch looks good to me:
>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Great, thanks a lot!
Namhyung


>
> German, James, would you have chance to review this change?
>
> Thanks,
> Leo
