Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B582B5BEFF1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiITWQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiITWQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:16:21 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897086BCC9;
        Tue, 20 Sep 2022 15:15:56 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id n83so5604318oif.11;
        Tue, 20 Sep 2022 15:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Fha+mvoBboYjfgvs7HNSSfPbH2YIEoWIGBnfMq9CF44=;
        b=lFOiwKX9UInYbpmEB/wd0NqNzlYBy9QkrJqpwEjlu4BRxts1MW+NKQRdicM5EQsbyp
         zXas8t7YdRs0SpggSWgpidy5IX3R4uP8zy0k/PuDixapmbh0RudAaBwE2ujed995lbBo
         I54cYmaSLVh0IVkbcAizoPz75CcDgurpPQL3KHJLux6A1qnfh92xopqgynW+UrUdrNju
         EMdDHsofamkztXWF9DlgbjK17FkP65T/6NGCS7PrkJGjRsGqh3e5wDEB+eqfazp1VRmX
         km0+xBYVA7Nbmajt89q/GD/5iw0OdejPO14TEyBrw5fNiS+Gqs4C3d9yXsXLiKk6w6Gj
         L3NQ==
X-Gm-Message-State: ACrzQf0Elzw+zy8yS4LtsVsdVNsIIrUxmIbW5UsHnCpSYDqiiZCYfUu/
        Bdkglt4hK8ZjOQmcsCDXn+pgfgVtnfGLvAowmJUmkXTW
X-Google-Smtp-Source: AMsMyM6bog1uPAHtLMYj5s87Pp7MJ8aHisOsYN2SIq/2TeQ2vH1uEPGVxDg98aVDGVB3t/uqo85A3psElXt2Dha6o/Y=
X-Received: by 2002:aca:d882:0:b0:34d:49bf:3587 with SMTP id
 p124-20020acad882000000b0034d49bf3587mr2551570oig.209.1663712153538; Tue, 20
 Sep 2022 15:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220918032843.27285-1-leo.yan@linaro.org>
In-Reply-To: <20220918032843.27285-1-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Sep 2022 15:15:42 -0700
Message-ID: <CAM9d7cjZt2k8_JtsPvWcDrzaXb0K02-OKYD4bNA3oL35vXa5Zw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] perf test: Introduce script for data symbol testing
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
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

On Sat, Sep 17, 2022 at 8:28 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> This commit introduces a shell script for data symbol testing.
>
> The testing is designed a data structure with 64-byte alignment, it has
> two fields "data1" and "data2", and other fields are reserved.
>
> Using "perf mem" command, we can record and report memory samples for a
> self-contained workload with 1 second duration.  If have no any memory
> sample for the data structure "buf1", it reports failure;  and by
> checking the offset in structure "buf1", if any memory accessing is not
> for "data1" and "data2" fields, it means wrong data symbol parsing and
> returns failure.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>
> Changes from v1:
> - Removed "killall" since the test has no child process (Ian);
> - Used "char" instead of "long" in the buf structure.
>
>  tools/perf/tests/shell/test_data_symbol.sh | 92 ++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_data_symbol.sh
>
> diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
> new file mode 100755
> index 000000000000..d007513ecfbe
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_data_symbol.sh
> @@ -0,0 +1,92 @@
> +#!/bin/bash
> +# Test data symbol
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Leo Yan <leo.yan@linaro.org>, 2022
> +
> +skip_if_no_mem_event() {
> +       perf mem record -e list 2>&1 | egrep -q 'available' && return 0
> +       return 2
> +}
> +
> +skip_if_no_mem_event || exit 2
> +
> +# skip if there's no compiler
> +if ! [ -x "$(command -v cc)" ]; then
> +       echo "skip: no compiler, install gcc"
> +       exit 2
> +fi
> +
> +TEST_PROGRAM_SOURCE=$(mktemp /tmp/__perf_test.program.XXXXX.c)
> +TEST_PROGRAM=$(mktemp /tmp/__perf_test.program.XXXXX)
> +PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +check_result() {
> +       # The memory report format is as below:
> +       #    99.92%  ...  [.] buf1+0x38  ...
> +       result=$(perf mem report -i ${PERF_DATA} --stdio 2>&1 | egrep "buf1" | \
> +               awk '{ for (i = 1; i <= NF; i++) { if ($i ~ /^buf1/) { print $i; break; } } }')

It'd be simpler to use the 'symbol_daddr' sort key alone.

  result=$(perf mem report -i ${PERF_DATA} -s symbol_daddr -q 2>&1 | \
        awk '/buf1/ { print $4 }'


> +
> +       # Testing is failed if has no any sample for "buf1"
> +       [ -z "$result" ] && return 1
> +
> +       while IFS= read -r line; do
> +               # The "data1" and "data2" fields in structure "buf1" have
> +               # offset "0x0" and "0x38", returns failure if detect any
> +               # other offset value.
> +               if [ "$line" != "buf1+0x0" ] && [ "$line" != "buf1+0x38" ]; then
> +                       return 1
> +               fi
> +       done <<< "$result"
> +
> +       return 0
> +}
> +
> +cleanup_files()
> +{
> +       echo "Cleaning up files..."
> +       rm -f ${PERF_DATA}
> +       rm -f ${TEST_PROGRAM_SOURCE}
> +       rm -f ${TEST_PROGRAM}
> +}
> +
> +trap cleanup_files exit term int
> +
> +# compile test program
> +cat << EOF > $TEST_PROGRAM_SOURCE

You could directly call the compiler with a pipe.

> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>

The headers are not used?

> +
> +typedef struct _buf {
> +       char data1;
> +       char reserved[55];
> +       char data2;
> +} buf __attribute__((aligned(64)));
> +
> +static buf buf1;
> +
> +int main() {

s/()/(void)/

> +       int i;

unused.

Thanks,
Namhyung


> +       for (;;) {
> +               buf1.data1++;
> +               buf1.data2 += buf1.data1;
> +       }
> +       return 0;
> +}
> +EOF
> +
> +echo "Compiling test program..."
> +cc $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
> +
> +echo "Recording workload..."
> +perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM &
> +PERFPID=$!
> +
> +sleep 1
> +
> +kill $PERFPID
> +wait $PERFPID
> +
> +check_result
> +exit $?
> --
> 2.34.1
>
