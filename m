Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1915EB187
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiIZTsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIZTrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:47:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7206549;
        Mon, 26 Sep 2022 12:47:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60BBFB80E6A;
        Mon, 26 Sep 2022 19:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9769C433D7;
        Mon, 26 Sep 2022 19:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664221658;
        bh=aW9LY92YyVBwTPWwFam4+2hBgLQpNDO2B9fLi+qXris=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pE67kRRPBiUELv6RNLYj1s3zroV83bpBRk5v5EOrG+VwiJnvt7k0x6XCqbI6gXVwi
         S5xcjaaNshoQalIutfByhjWGpBIgOAvb0Qdmx4dOgm+V90onSreOtiBNxXqV1gdV+/
         e33oebaDoMXovuM7xWVBXrZVIUzWUXYERBvSgy0VACGQ8jZa0Nf8De6FLmL783nJQ0
         dJiy79afpvZ7in1aO+rs8lGUDMNV1pGrpL9el4nHJJzPQnEvP68RUbs0xt4soFnhED
         BqkgaCXzhi4Evcy4KdagSxPTr2kJDl5cxqEmjwmpeaC30lBaRtIGBGJ5bB+4w1G0My
         c7Gq03o8nRd2g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 88710403B0; Mon, 26 Sep 2022 20:47:35 +0100 (IST)
Date:   Mon, 26 Sep 2022 20:47:35 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, john.garry@huawei.com,
        adrian.hunter@intel.com, ak@linux.intel.com,
        florian.fischer@muhq.space
Subject: Re: [PATCH -next 5/5] perf: Remove unused macro K
Message-ID: <YzIB17zCYhhRJFPY@kernel.org>
References: <20220926031440.28275-1-chenzhongjin@huawei.com>
 <20220926031440.28275-6-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926031440.28275-6-chenzhongjin@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 26, 2022 at 11:14:40AM +0800, Chen Zhongjin escreveu:
> Unused macro reported by [-Wunused-macros].
> 
> This macro is introduced to calculate the 'unit' size, in:
> 'd2fb8b4151a9 ("perf tools: Add new perf_atoll() function to parse string representing size in bytes")'
> 
> '8ba7f6c2faad ("saner perf_atoll()")'
> This commit has simplified the perf_atoll() function and remove the
> 'unit' variable. This macro is not deleted, but nowhere else is using it.
> 
> A single letter macro is confusing and easy to be misused.
> So remove it for code cleaning.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  tools/perf/util/string.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
> index f6d90cdd9225..4f12a96f33cc 100644
> --- a/tools/perf/util/string.c
> +++ b/tools/perf/util/string.c
> @@ -15,7 +15,6 @@ const char *dots =
>  	"....................................................................."
>  	".....................................................................";
>  
> -#define K 1024LL
>  /*
>   * perf_atoll()
>   * Parse (\d+)(b|B|kb|KB|mb|MB|gb|GB|tb|TB) (e.g. "256MB")
> -- 
> 2.17.1

-- 

- Arnaldo
