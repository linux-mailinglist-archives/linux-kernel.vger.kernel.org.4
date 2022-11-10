Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472FD6241B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiKJLpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKJLpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:45:40 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992A825EB9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:45:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g24so1219936plq.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rEttJhmYxbK+bpKNQ6hY/ZpH/AsD9RX4L/v7gB3yLyc=;
        b=JLSP+J3z1+/NevUw/HJD78BlTABJMUSdYxjsZbhiaEJ0lxjlGUEiWrm/VTRIkBM1bq
         swrl/RnC1VyPPiujuc+UBjIDX2TdtB1Xb2p+chhdLk0gKVMc5Xn4Kr83+V3nqt5hZcS1
         cnugBlSvynslfcCs4gvuf5+AqZwn3gnZb7qCLvAG+fFWn2K/hmsIRS/x2A8pxmAxFnJJ
         fLk+0kCEChVdp1Q3ZK8ylSKEpWNYquL7xKP0K59KZrVxvBw3OrEwIaVYipT1TqOoXrws
         JZOrG2MkUr74+eHtw2M93Kn92loEgeOu16zT+VlnETeuCCbnPDVHsXIiCeHijLpbkBiP
         zbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEttJhmYxbK+bpKNQ6hY/ZpH/AsD9RX4L/v7gB3yLyc=;
        b=6mAa44VWQ9yUOKd/4FJ4gF0Nvlpl4nAyDCW8Ob/TxILb/0ZL0gqjA6uoXIFW23BXcb
         H6Rhz5L9aqPbQB0jOEOwypbJxp40XVdQV6rzdUHvcn0TbReCsA6Dh5Kdf5T1vOlBp/gA
         7xHKTCCb9oYi88gVt1/j6CywFDbOeQBIBjrmZqDWiF8ixryFKpjZp7mfUPWZKkRIzwua
         R97OiS6XxA8mZVR3aANYp88xZ//fQMNQUqVwXuBV2R/YZrJy03ltVmrGgZR730tO237O
         DbC7v3JM4ft6M8ZCES22MngMiQ0JcYabq4KIYaFS8NZB23oTM9OEIIaZje0QbuPhefQ1
         qv2Q==
X-Gm-Message-State: ACrzQf2+URI/wWjb8q1aBDwCEG6PfpJdl29875A8rttl5CJzmygKXrww
        MJ5jcP1t9TcfB2arRZ3v39LSkQ==
X-Google-Smtp-Source: AMsMyM5C+MrAJeWCMAuKHKiFHrmoXzl+vd1Ttu46cfhKc5cB2FEGXlFS+bcigwq8BmPXuYsr10d5mg==
X-Received: by 2002:a17:90b:4d05:b0:202:ec78:9d73 with SMTP id mw5-20020a17090b4d0500b00202ec789d73mr66328964pjb.103.1668080734199;
        Thu, 10 Nov 2022 03:45:34 -0800 (PST)
Received: from leoy-yangtze.lan (45.78.27.50.16clouds.com. [45.78.27.50])
        by smtp.gmail.com with ESMTPSA id 69-20020a17090a09cb00b00212d4c50647sm2898874pjo.36.2022.11.10.03.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 03:45:33 -0800 (PST)
Date:   Thu, 10 Nov 2022 19:45:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
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
Subject: Re: [PATCH 08/12] perf test: Replace arm spe fork test workload with
 sqrtloop
Message-ID: <Y2zkWN68nv+wYhIj@leoy-yangtze.lan>
References: <20221109174635.859406-1-namhyung@kernel.org>
 <20221109174635.859406-9-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109174635.859406-9-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 09:46:31AM -0800, Namhyung Kim wrote:
> So that it can get rid of requirement of a compiler.  I've also removed
> killall as it'll kill perf process now and run the test workload for 10
> sec instead.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

The patch looks good to me and I tested on Arm64 machine:

Tested-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/tests/shell/test_arm_spe_fork.sh | 44 +--------------------
>  1 file changed, 1 insertion(+), 43 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_arm_spe_fork.sh b/tools/perf/tests/shell/test_arm_spe_fork.sh
> index c920d3583d30..da810e1b2b9e 100755
> --- a/tools/perf/tests/shell/test_arm_spe_fork.sh
> +++ b/tools/perf/tests/shell/test_arm_spe_fork.sh
> @@ -11,14 +11,7 @@ skip_if_no_arm_spe_event() {
>  
>  skip_if_no_arm_spe_event || exit 2
>  
> -# skip if there's no compiler
> -if ! [ -x "$(command -v cc)" ]; then
> -	echo "failed: no compiler, install gcc"
> -	exit 2
> -fi
> -
> -TEST_PROGRAM_SOURCE=$(mktemp /tmp/__perf_test.program.XXXXX.c)
> -TEST_PROGRAM=$(mktemp /tmp/__perf_test.program.XXXXX)
> +TEST_PROGRAM="perf test -w sqrtloop 10"
>  PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  PERF_RECORD_LOG=$(mktemp /tmp/__perf_test.log.XXXXX)
>  
> @@ -27,43 +20,10 @@ cleanup_files()
>  	echo "Cleaning up files..."
>  	rm -f ${PERF_RECORD_LOG}
>  	rm -f ${PERF_DATA}
> -	rm -f ${TEST_PROGRAM_SOURCE}
> -	rm -f ${TEST_PROGRAM}
>  }
>  
>  trap cleanup_files exit term int
>  
> -# compile test program
> -cat << EOF > $TEST_PROGRAM_SOURCE
> -#include <math.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <sys/wait.h>
> -
> -int workload() {
> -  while (1)
> -    sqrt(rand());
> -  return 0;
> -}
> -
> -int main() {
> -  switch (fork()) {
> -    case 0:
> -      return workload();
> -    case -1:
> -      return 1;
> -    default:
> -      wait(NULL);
> -  }
> -  return 0;
> -}
> -EOF
> -
> -echo "Compiling test program..."
> -CFLAGS="-lm"
> -cc $TEST_PROGRAM_SOURCE $CFLAGS -o $TEST_PROGRAM || exit 1
> -
>  echo "Recording workload..."
>  perf record -o ${PERF_DATA} -e arm_spe/period=65536/ -vvv -- $TEST_PROGRAM > ${PERF_RECORD_LOG} 2>&1 &
>  PERFPID=$!
> @@ -78,8 +38,6 @@ echo Log lines after 1 second = $log1
>  
>  kill $PERFPID
>  wait $PERFPID
> -# test program may leave an orphan process running the workload
> -killall $(basename $TEST_PROGRAM)
>  
>  if [ "$log0" = "$log1" ];
>  then
> -- 
> 2.38.1.431.g37b22c650d-goog
> 
