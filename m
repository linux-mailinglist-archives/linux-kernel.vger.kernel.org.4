Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036555EDEC5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbiI1O20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiI1O2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:28:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94319AB1A0;
        Wed, 28 Sep 2022 07:28:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30B4261EC3;
        Wed, 28 Sep 2022 14:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D989C433D6;
        Wed, 28 Sep 2022 14:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664375301;
        bh=glY7sliTzxJPV71rU1eGaj4hM/6vlaTJ6XqbZLxii2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4VTagMSGKufx1cXX2Z4W9q6vyFcUDeTG/7uh1zO1LQ/vJUMnD97PSKAvH7b0RH0a
         vzGve6VDTl4VvS5p+brwq5qk9q1wivx4dvwTXIfc7F4xPtNILCKibyvPKLd/Gh/4zd
         qWU7hDCUHCOS9Svz6w8+5++d3mFTo68OWrrvJnq8jORRWviqeoqvanzE3ztxaxy9UE
         vZBkcZkkwacnAWGBqjkzDzuuJHhYFJoFMC6knAbYwhB6+EcOIuCmKMxcaK3aYat+h2
         hQ3DBIIktab83tcFzL/kfzVMaGTUMmHCS+lm52jDxD2Rr4EBhpT4G1zHz4gP9hqyRb
         HDfptXXiEcsiw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 30B7C405F0; Wed, 28 Sep 2022 11:28:19 -0300 (-03)
Date:   Wed, 28 Sep 2022 11:28:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     zhengjun.xing@linux.intel.com, Ian Rogers <irogers@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
Subject: Re: [PATCH] perf test: Fix test case 87 ("perf record tests") for
 hybrid systems
Message-ID: <YzRaAxFrg56uph+W@kernel.org>
References: <20220927051513.3768717-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927051513.3768717-1-zhengjun.xing@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 27, 2022 at 01:15:13PM +0800, zhengjun.xing@linux.intel.com escreveu:
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> 
> The test case 87 ("perf record tests") failed on hybrid systems,the event
> "cpu/br_inst_retired.near_call/p" is only for non-hybrid system. Correct
> the test event to support both non-hybrid and hybrid systems.
> 
> Before:
>  # ./perf test 87
>  87: perf record tests                                   : FAILED!
> 
> After:
>  # ./perf test 87
>  87: perf record tests                                   : Ok

Looks sane, applied.

Ian, consider providing your Acked-by,

- Arnaldo
 
> Fixes: 24f378e66021 ("perf test: Add basic perf record tests")
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/tests/shell/record.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 00c7285ce1ac..301f95427159 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -61,7 +61,7 @@ test_register_capture() {
>      echo "Register capture test [Skipped missing registers]"
>      return
>    fi
> -  if ! perf record -o - --intr-regs=di,r8,dx,cx -e cpu/br_inst_retired.near_call/p \
> +  if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
>      -c 1000 --per-thread true 2> /dev/null \
>      | perf script -F ip,sym,iregs -i - 2> /dev/null \
>      | egrep -q "DI:"
> -- 
> 2.25.1

-- 

- Arnaldo
