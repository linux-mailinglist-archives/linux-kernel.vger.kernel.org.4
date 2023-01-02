Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE86665B39A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjABOuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbjABOuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:50:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983E565EE;
        Mon,  2 Jan 2023 06:50:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4ECB8B80D79;
        Mon,  2 Jan 2023 14:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C679AC433D2;
        Mon,  2 Jan 2023 14:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672671008;
        bh=lfleuzsKM462/HhP6D3FfjsaDO3LkhbzqsrbX2KFmNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oloe5Yx4OcxggkdiWECe7UcqB7EV5spgYYPNgDupdbah59e2N80js9UwAvu8AiDgu
         HCZpkbbQQ8wxc49QOyi5hO+B9APaguEJVIT1pwxUeJxjRDGusfK/L8MOVfWZj7OBBF
         /ixN9i8YtQnlH/7n6l8tdMUK3CkOF96tGhDTvD4dJ5h8Vv24mq7Nquog6BhnmCKI2a
         HD1jaNSA9ut6tAZ5tEsSQzMI7zOWeZ50Kp2xYqQYwjaQpb9XqzinxTFH+PJa8WcgBs
         A4vXKt2p8LIpy/yWRRAE3nmSaDPDjs27miXQFlw7jYMUTnVxtcPO8j2kcd7fhhkX5J
         TCsZDfd3iNv2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8332D40468; Mon,  2 Jan 2023 11:50:05 -0300 (-03)
Date:   Mon, 2 Jan 2023 11:50:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eric Lin <eric.lin@sifive.com>
Cc:     peterz@infradead.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, palmer@dabbelt.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, vincent.chen@sifive.com
Subject: Re: [PATCH] perf tools riscv: Fix perf tool build error on riscv
Message-ID: <Y7LvHY/V6pME33I6@kernel.org>
References: <20221231052731.24908-1-eric.lin@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231052731.24908-1-eric.lin@sifive.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 31, 2022 at 05:27:31AM +0000, Eric Lin escreveu:
> Since the definition of 'struct perf_sample' has been moved to sample.h,
> we need to include this header file to fix the build error as follows:
> 
> arch/riscv/util/unwind-libdw.c: In function 'libdw__arch_set_initial_registers':
> arch/riscv/util/unwind-libdw.c:12:50: error: invalid use of undefined type 'struct perf_sample'
>    12 |         struct regs_dump *user_regs = &ui->sample->user_regs;
>       |                                                  ^~

Thanks, applied.

- Arnaldo

 
> Fixes: 9823147da6c8 ("perf tools: Move 'struct perf_sample' to a separate header file to disentangle headers")
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> ---
>  tools/perf/arch/riscv/util/unwind-libdw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/riscv/util/unwind-libdw.c b/tools/perf/arch/riscv/util/unwind-libdw.c
> index 19536e172850..54a198714eb8 100644
> --- a/tools/perf/arch/riscv/util/unwind-libdw.c
> +++ b/tools/perf/arch/riscv/util/unwind-libdw.c
> @@ -4,7 +4,7 @@
>  #include <elfutils/libdwfl.h>
>  #include "../../util/unwind-libdw.h"
>  #include "../../util/perf_regs.h"
> -#include "../../util/event.h"
> +#include "../../util/sample.h"
>  
>  bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
>  {
> -- 
> 2.17.1

-- 

- Arnaldo
