Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9D624141
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKJLUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKJLUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:20:39 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31476701AC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:20:37 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so1256654pjd.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z49xKikEzQNQPr/bNFHbKiPE/DwFrtp3Y9j7jeVw77k=;
        b=iX+xAuTmnLGuv8l0IwwSc1GTTlXZyOByHxpRC33/REgVHdDbVhr2KjJKoJ3VJYqbhC
         YOVWfEpAmZ/csMuCLCPmk6y1qRHmUtMJYQ3Ay40pQUTDM8RQoXsnW/ZLVwpPtTJI93wz
         6Ra1gfAcrRKe6Xuf6RabDCnSDEJItsDDFtnRCs7i1EMyPTvukkUqd9yU4cxoV0Jhqn0W
         cGvdIc/GirGpt8JW6XwtX37J+UdQwg6bBDcV8h8y1Ifh14OxnK2p7XKNIAUu/iKL1l6F
         fCDYnLqlevf2Jpm11UnDh9JeSa6+6mIgFeCDhJg/nuziAYzfnv225OVRACTSCFSqfgTl
         4tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z49xKikEzQNQPr/bNFHbKiPE/DwFrtp3Y9j7jeVw77k=;
        b=hW1BJRq99Oce5VCv7VOKmvlyUwzu+k8kW3dC9qoHuYaF2Ndh/tMJcQEb3hFWoTLLHS
         Vj3hwxQbhmd0LMNhMIqm+7wgYLn+wmO/BWSpxA9kDojKRm+E2Rum4fapy0fhIVd9JEoQ
         vkgc3feoiqmvEvWvo2Jq3LHC/6V+aCK/fnm3pTcIg0ns4FmJ4Ieyb1HBaBj/6UjyWZOm
         BsM5SV7zLG/PklyvxghOixqpfxTI6HzhbWmcuVMUBbN93uBHh9++I3WvguxXDanpTD6R
         BHen5rI55ZXz7p7ROyDHBgSBhxey9wCDFahQDZaC5ji6P86rIcpuO+9KAMt3B+rlAtr3
         2oug==
X-Gm-Message-State: ACrzQf16k+Z13sC1PO3wDicOJYo+LOs97UIswP+eVKf3GTm35HV7547u
        EaiZc3Y4Vc02ON+tkQhzoRjcdQ==
X-Google-Smtp-Source: AMsMyM4i9P445IT//4DKfgHdHfFeNUbcNPWZgoO/ONBRPhzIOcvxSoVe32zk2/qv3tMxtQBP12dqbw==
X-Received: by 2002:a17:90a:b00a:b0:213:623:2c12 with SMTP id x10-20020a17090ab00a00b0021306232c12mr83959075pjq.153.1668079236300;
        Thu, 10 Nov 2022 03:20:36 -0800 (PST)
Received: from leoy-yangtze.lan (45.78.27.50.16clouds.com. [45.78.27.50])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e5c700b00174d9bbeda4sm11023925plf.197.2022.11.10.03.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 03:20:33 -0800 (PST)
Date:   Thu, 10 Nov 2022 19:20:28 +0800
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
Subject: Re: [PATCH 06/12] perf test: Replace arm callgraph fp test workload
 with leafloop
Message-ID: <Y2zeOZcNjRCnEAVZ@leoy-yangtze.lan>
References: <20221109174635.859406-1-namhyung@kernel.org>
 <20221109174635.859406-7-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109174635.859406-7-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namyung,

On Wed, Nov 09, 2022 at 09:46:29AM -0800, Namhyung Kim wrote:
> So that it can get rid of requirement of a compiler.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  .../perf/tests/shell/test_arm_callgraph_fp.sh | 30 +------------------
>  1 file changed, 1 insertion(+), 29 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> index ec108d45d3c6..9d6d1b2d99c5 100755
> --- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> +++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> @@ -4,44 +4,16 @@
>  
>  lscpu | grep -q "aarch64" || exit 2
>  
> -if ! [ -x "$(command -v cc)" ]; then
> -	echo "failed: no compiler, install gcc"
> -	exit 2
> -fi
> -
>  PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> -TEST_PROGRAM_SOURCE=$(mktemp /tmp/test_program.XXXXX.c)
> -TEST_PROGRAM=$(mktemp /tmp/test_program.XXXXX)
> +TEST_PROGRAM="perf test -w leafloop"
>  
>  cleanup_files()
>  {
>  	rm -f $PERF_DATA
> -	rm -f $TEST_PROGRAM_SOURCE
> -	rm -f $TEST_PROGRAM
>  }
>  
>  trap cleanup_files exit term int
>  
> -cat << EOF > $TEST_PROGRAM_SOURCE
> -int a = 0;
> -void leaf(void) {
> -  for (;;)
> -    a += a;
> -}
> -void parent(void) {
> -  leaf();
> -}
> -int main(void) {
> -  parent();
> -  return 0;
> -}
> -EOF
> -
> -echo " + Compiling test program ($TEST_PROGRAM)..."
> -
> -CFLAGS="-g -O0 -fno-inline -fno-omit-frame-pointer"
> -cc $CFLAGS $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
> -
>  # Add a 1 second delay to skip samples that are not in the leaf() function
>  perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 --user-callchains -- $TEST_PROGRAM 2> /dev/null &
>  PID=$!

I need to append below changes, otherwise the test will fail on Arm64:

--- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
+++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
@@ -30,11 +30,11 @@ wait $PID
 # program
 #      728 leaf
 #      753 parent
-#      76c main
+#      76c leafloop
 # ...
 
 perf script -i $PERF_DATA -F comm,ip,sym | head -n4
 perf script -i $PERF_DATA -F comm,ip,sym | head -n4 | \
        awk '{ if ($2 != "") sym[i++] = $2 } END { if (sym[0] != "leaf" ||
                                                       sym[1] != "parent" ||
-                                                      sym[2] != "main") exit 1 }'
+                                                      sym[2] != "leafloop") exit 1 }'

With appending above change, this patch looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

German, James, would you have chance to review this change?

Thanks,
Leo
