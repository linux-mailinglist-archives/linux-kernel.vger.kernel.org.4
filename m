Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABA85F103C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiI3QsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiI3QsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:48:06 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774C061D94;
        Fri, 30 Sep 2022 09:48:05 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id l5so5291687oif.7;
        Fri, 30 Sep 2022 09:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ufe88nzN1VZDqveRGmwOvDinqXdimlyziBU/LXzxHXo=;
        b=HZLDAEArP0YjUae6CQG0kkT6+G+XdQXXlbAuEJBk7Vk0jEdWJK14sr5jWeyQFJo42N
         Y00EfZMQl3D14WcUf1T5+cmeMUN5PcB4dcKgEG1BTx0Vo+Iz07jZUR6u47uVQbeKmPwt
         OfQg2jTQbJoRbHi6uNx74PB5f2QCvUUI8H8Om1nDkjnJU4LQyiQPJD+7UMC76O05ewx4
         Q/BozIxAVPYXXK05ruehNnvyEFDXJQC68dkzYqtvcL3aPWU/6bYY/Wt1j64msGeUglDW
         UpQecb97y4LD6nqWuJqSLbp0e7cSyoM52gGMSYP2OZvcmlGjNtpv5rAtJtfXatssaFju
         R/Jg==
X-Gm-Message-State: ACrzQf0GVuWtyf9kt2QkPrJx6+h7REE7ApeG0pJTMZIqqq7Mn4JcykRA
        VDRZZNIdT+MGRdKkqNKazGj8MYNcHCK+E3OKmBc=
X-Google-Smtp-Source: AMsMyM7yPcBSEr4fPPlYDvkeJ5ydywqIzDnfZ/SVnd7U98exXLsoXrfoEbU9i8Lku5SAwxaA+ztjQlAJnrTNBZloDaA=
X-Received: by 2002:a05:6808:181e:b0:350:e92a:9ab1 with SMTP id
 bh30-20020a056808181e00b00350e92a9ab1mr4115652oib.209.1664556484748; Fri, 30
 Sep 2022 09:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220930120939.353315-1-leo.yan@linaro.org>
In-Reply-To: <20220930120939.353315-1-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 30 Sep 2022 09:47:53 -0700
Message-ID: <CAM9d7cibbdOb04qhKkfyRmwtHvttb6-bOu_uAN6D8ke-EJUWZw@mail.gmail.com>
Subject: Re: [PATCH v4] perf test: Introduce script for data symbol testing
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
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

Hi Leo,

On Fri, Sep 30, 2022 at 5:09 AM Leo Yan <leo.yan@linaro.org> wrote:
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
> Channges from v3:
> - Add specific testing chunk for AMD CPUs (Ravi).
>
>  tools/perf/tests/shell/test_data_symbol.sh | 93 ++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_data_symbol.sh
>
> diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
> new file mode 100755
> index 000000000000..43ab1e37407c
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_data_symbol.sh
> @@ -0,0 +1,93 @@
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
> +TEST_PROGRAM=$(mktemp /tmp/__perf_test.program.XXXXX)
> +PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +check_result() {
> +       # The memory report format is as below:
> +       #    99.92%  ...  [.] buf1+0x38
> +       result=$(perf mem report -i ${PERF_DATA} -s symbol_daddr -q 2>&1 |
> +                awk '/buf1/ { print $4 }')
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
> +       rm -f ${TEST_PROGRAM}
> +}
> +
> +trap cleanup_files exit term int
> +
> +# compile test program
> +echo "Compiling test program..."
> +cat << EOF | cc -o ${TEST_PROGRAM} -x c -
> +typedef struct _buf {
> +       char data1;
> +       char reserved[55];
> +       char data2;
> +} buf __attribute__((aligned(64)));
> +
> +static buf buf1;
> +
> +int main(void) {
> +       for (;;) {
> +               buf1.data1++;
> +               buf1.data2 += buf1.data1;
> +       }
> +       return 0;
> +}
> +EOF
> +
> +echo "Recording workload..."
> +
> +# perf mem/c2c internally uses IBS PMU on AMD CPU which doesn't support
> +# user/kernel filtering and per-process monitoring, spin program on
> +# specific CPU and test in per-CPU mode.
> +is_amd=$(egrep -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
> +if (($is_amd >= 1)); then
> +       perf mem record -o ${PERF_DATA} -- -C 0 -- taskset -c 0 $TEST_PROGRAM &

I'm curious why it has "--" before "-C 0"..

Thanks,
Namhyung


> +else
> +       perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM &
> +fi
> +
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
