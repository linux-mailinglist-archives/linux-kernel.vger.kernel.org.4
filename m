Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8D4621E64
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKHVQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiKHVQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:16:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E3056564;
        Tue,  8 Nov 2022 13:16:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 67221CE1CE6;
        Tue,  8 Nov 2022 21:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B96C433D6;
        Tue,  8 Nov 2022 21:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667942158;
        bh=pcLNw0Istjy7ekvKgb8Hilkkldz4DcMsYXFQYpKmAlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgu7z3UzcSjB/Z7s2EP8kGi4vJBqUD0Jy7owy+6TdGHdk43+aoz9JLnxRD7RsAmpi
         vFOZIxUrEAbmLcpQ7CTx7Cso2JdZp/eLuF7EqyS90qZ8hpSec/DO4CXB1ny9mKjxRA
         l8ZUOM28rh1HMvbDdYUHxji4vHb0kbBOdk0LjtPVutkaf1Ytk6VUdPgiWc+RzHmtua
         tt4LePODoyltJopnsUjOPFL00VGKhraIVXSnphMVXqOAmpRL7VjE81LrR+B2WHjYlf
         g/6ykC3YCYSNk6urDQR0SPg0kih41RxbbmBNJaoB8AlKk9my5rp3s3F4J6jsGUMENz
         JYpctaswuiE1Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C7B4E4034E; Tue,  8 Nov 2022 18:15:55 -0300 (-03)
Date:   Tue, 8 Nov 2022 18:15:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Donglin Peng <dolinux.peng@gmail.com>
Cc:     peterz@infradead.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf tools: exclude the include/perf/ directory
Message-ID: <Y2rHC5W1qi0PGwc2@kernel.org>
References: <20221103092704.173391-1-dolinux.peng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103092704.173391-1-dolinux.peng@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 03, 2022 at 02:27:04AM -0700, Donglin Peng escreveu:
> Commit 3af1dfdd51e0 ("perf build: Move perf_dlfilters.h in the
> source tree") moved perf_dlfilters.h to the include/perf/ directory
> while include/perf is ignored because it has 'perf' in the name.
> Newly created files in the include/perf/ directory will be ignored.

Thanks, applied.

- Arnaldo

 
> Can check:
> 
> Before:
> $ touch tools/perf/include/perf/junk
> $ git status | grep junk
> $ git check-ignore -v tools/perf/include/perf/junk
> tools/perf/.gitignore:6:perf    tools/perf/include/perf/junk
> 
> After:
> $ git status | grep junk
> tools/perf/include/perf/junk
> $ git check-ignore -v tools/perf/include/perf/junk
> 
> Add !include/perf/ to perf's .gitignore file.
> 
> Fixes: 3af1dfdd51e0 ("perf build: Move perf_dlfilters.h in the source tree")
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> Changes in v2:
> - add 'Fixes:' tag in commit message
> - make commit message more clearer
> ---
>  tools/perf/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> index a653311d9693..fd7a6ff9e7aa 100644
> --- a/tools/perf/.gitignore
> +++ b/tools/perf/.gitignore
> @@ -4,6 +4,7 @@ PERF-GUI-VARS
>  PERF-VERSION-FILE
>  FEATURE-DUMP
>  perf
> +!include/perf/
>  perf-read-vdso32
>  perf-read-vdsox32
>  perf-help
> -- 
> 2.25.1

-- 

- Arnaldo
