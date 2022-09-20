Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8B65BEF58
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 23:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiITVrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 17:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiITVrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 17:47:19 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C3361D50;
        Tue, 20 Sep 2022 14:47:18 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id t62so5523004oie.10;
        Tue, 20 Sep 2022 14:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nNOJO5Rfau/4P4r51NLfOvsWPmiGi6ydKZx53FmD4Qg=;
        b=Rh3m7qcSZw6oAUS+pp9BvgQma6bYAIHAwizVeVSkac6gOxHqTgmkosG5d5I7UWL/Us
         Z2JqzBAJxiB32AjsgOxFF+56PGM8kQiCwdWOlumaU/U+OUSNwVXLmwv21eolZWpji9ak
         NhiGran4nraUsMt8z7BcrKRYeqUa1DejiEK6rpleUwl1tpL8q9qbiTgwNmtCu9GjFVOZ
         K8oyCUhdjiLECaPZIiRj7r0UltgDbQWKtTJ5rJrSLx4BVMd2nvS3Kxc+dwwuW52cpFr3
         u81prG7I7cVs7d/Gism2Uq3RxvXb15a7vFy8dNjZCfRDNvsJK4GbaagmyZG5BVRz1RSZ
         t1Ag==
X-Gm-Message-State: ACrzQf0zXsGYgsQcQqVXMovzS6rwEM9OTGj4+qOhAZs1NPMwGHJl5cvG
        pto7lBQsyz10HS1Wjf/EnvSrl78dz3vMjjYD8bE=
X-Google-Smtp-Source: AMsMyM6rzZj410WRr0VQRjv7ZiJ0O2AOrtaWx9t+YrwUx9jhgWRASDmUqPdgsJTYcyKo+MaUX+ab8aTT4409HzOooE4=
X-Received: by 2002:aca:d882:0:b0:34d:49bf:3587 with SMTP id
 p124-20020acad882000000b0034d49bf3587mr2506665oig.209.1663710436869; Tue, 20
 Sep 2022 14:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220918031524.26719-1-leo.yan@linaro.org> <20220918031524.26719-3-leo.yan@linaro.org>
In-Reply-To: <20220918031524.26719-3-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Sep 2022 14:47:05 -0700
Message-ID: <CAM9d7ciR0b5GSASVPxn-r5sBTJW9KZXcQYEsV4zRan5bdgmRCg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf test: Introduce script for java symbol testing
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Sat, Sep 17, 2022 at 8:15 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> This commit introduces a script for testing java symbols.
>
> The test records java program, inject samples with JIT samples, check
> specific JIT symbols in the report, the test will pass only when these
> two symbols are detected.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/tests/shell/test_java_symbol.sh | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_java_symbol.sh
>
> diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/tests/shell/test_java_symbol.sh
> new file mode 100755
> index 000000000000..d96fea405ea9
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_java_symbol.sh
> @@ -0,0 +1,69 @@
> +#!/bin/bash
> +# Test java symbol
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Leo Yan <leo.yan@linaro.org>, 2022
> +
> +PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +PERF_INJ_DATA=$(mktemp /tmp/__perf_test.perf.data.inj.XXXXX)
> +
> +cleanup_files()
> +{
> +       echo "Cleaning up files..."
> +       rm -f ${PERF_DATA}
> +       rm -f ${PERF_INJ_DATA}
> +}
> +
> +trap cleanup_files exit term int
> +
> +if [ -e "$PWD/tools/perf/libperf-jvmti.so" ]; then
> +       LIBJVMTI=$PWD/tools/perf/libperf-jvmti.so
> +elif [ -e "$PWD/libperf-jvmti.so" ]; then
> +       LIBJVMTI=$PWD/libperf-jvmti.so
> +elif [ -e "$PREFIX/lib64/libperf-jvmti.so" ]; then
> +       LIBJVMTI=$PREFIX/lib64/libperf-jvmti.so
> +elif [ -e "$PREFIX/lib/libperf-jvmti.so" ]; then
> +       LIBJVMTI=$PREFIX/lib/libperf-jvmti.so
> +if [ -e "/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-generic//')/libperf-jvmti.so" ]; then

s/if/elif/ ?

> +       LIBJVMTI=/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-generic//')/libperf-jvmti.so
> +else
> +       echo "Fail to find libperf-jvmti.so"
> +       # JVMTI is a build option, skip the test if fail to find lib
> +       exit 2
> +fi
> +
> +cat <<EOF | perf record -k 1 -o $PERF_DATA jshell -s -J-agentpath:$LIBJVMTI

Wouldn't it check if jshell is available first?

Thanks,
Namhyung


> +int fib(int x) {
> +       return x > 1 ? fib(x - 2) + fib(x - 1) : 1;
> +}
> +
> +int q = 0;
> +
> +for (int i = 0; i < 10; i++)
> +       q += fib(i);
> +
> +System.out.println(q);
> +EOF
> +
> +if [ $? -ne 0 ]; then
> +       echo "Fail to record for java program"
> +       exit 1
> +fi
> +
> +if ! perf inject -i $PERF_DATA -o $PERF_INJ_DATA -j; then
> +       echo "Fail to inject samples"
> +       exit 1
> +fi
> +
> +# Below is an example of the instruction samples reporting:
> +#   8.18%  jshell           jitted-50116-29.so    [.] Interpreter
> +#   0.75%  Thread-1         jitted-83602-1670.so  [.] jdk.internal.jimage.BasicImageReader.getString(int)
> +perf report --stdio -i ${PERF_INJ_DATA} 2>&1 | \
> +       egrep " +[0-9]+\.[0-9]+% .* (Interpreter|jdk\.internal).*" > /dev/null 2>&1
> +
> +if [ $? -ne 0 ]; then
> +       echo "Fail to find java symbols"
> +       exit 1
> +fi
> +
> +exit 0
> --
> 2.34.1
>
