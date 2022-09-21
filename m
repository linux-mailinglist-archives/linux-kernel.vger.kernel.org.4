Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFCF5BFF24
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiIUNtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiIUNtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:49:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0592572696;
        Wed, 21 Sep 2022 06:49:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D177B82370;
        Wed, 21 Sep 2022 13:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C744C433D6;
        Wed, 21 Sep 2022 13:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663768151;
        bh=7CdrmSk3ix6XsmoJN2/gSLhPpcd8E1qqS0s4+WhE+kM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jotdytc7f/1m3zYiQOk8bcz8FjQFfp2MuUe/TmuURUsjlD23vZpZ9nZjiBJpndVMe
         ZsWX5CyrJ7CDPDloWLp3U4AXhUmJBjW50QCqhsrYjGUy4c9uAof9LcCUwH8qDy7+ti
         j8FEa2bfoe9EbEXtPqBymBFYyViUMBBdGnlSGrMRotUAa4E34CHCc3u+RUT6ZzUjRe
         JlTJuKnP/phC/DrCAestDzE7oLokxmKF6nP/jCn8yVFlAdfMs3hywkE7jZclWe3mo9
         9Y80PMvNzvDN08UylBSaMr3C88Bp2k/khYifok/7XvMvKhIG7hYd/wsB7t2BcPiEe8
         0Qt0ZhgF4UeHw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C059C40856; Wed, 21 Sep 2022 14:49:08 +0100 (IST)
Date:   Wed, 21 Sep 2022 14:49:08 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf tools: Honor namespace when synthesizing
 build-id
Message-ID: <YysWVB724LBSFhII@kernel.org>
References: <20220920222822.2171056-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920222822.2171056-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 20, 2022 at 03:28:21PM -0700, Namhyung Kim escreveu:
> It needs to go into a namespace before reading a file.
> 
> Fixes: 4183a8d70a28 ("perf tools: Allow synthesizing the build id for kernel/modules/tasks in PERF_RECORD_MMAP2")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf/urgent.

- Arnaldo

> ---
>  tools/perf/util/synthetic-events.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 0ff57ca24577..289ea17ac5f7 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -367,13 +367,24 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
>  					     bool is_kernel)
>  {
>  	struct build_id bid;
> +	struct nsinfo *nsi;
> +	struct nscookie nc;
>  	int rc;
>  
> -	if (is_kernel)
> +	if (is_kernel) {
>  		rc = sysfs__read_build_id("/sys/kernel/notes", &bid);
> -	else
> -		rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
> +		goto out;
> +	}
> +
> +	nsi = nsinfo__new(event->pid);
> +	nsinfo__mountns_enter(nsi, &nc);
>  
> +	rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
> +
> +	nsinfo__mountns_exit(&nc);
> +	nsinfo__put(nsi);
> +
> +out:
>  	if (rc == 0) {
>  		memcpy(event->build_id, bid.data, sizeof(bid.data));
>  		event->build_id_size = (u8) bid.size;
> -- 
> 2.37.3.968.ga6b4b080e4-goog

-- 

- Arnaldo
