Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81266FCDAA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbjEISVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjEISVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA365FEF;
        Tue,  9 May 2023 11:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C9E9647A6;
        Tue,  9 May 2023 18:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1E4C4339B;
        Tue,  9 May 2023 18:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683656492;
        bh=p9LFEEvugQN4++dg+fFPMCKLX5fbDpBS5vLiqTGWuAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSPiyVS/u4Dh6cFjjlZoWUokqgfgqlhpWfvp1WyYZZ9bX7gmUBIXRhylO7TtjeG2v
         Wq7JWpRd/tLwmfFjIhFexYdTJ70QbbQNt8jJYD2mGVXVRdXZYXXmx8AltjwOnMlCrC
         7+MKYBGJx4KObTNwfbb74iiEnheGOwraTe/Ujj0bOFLOSUxA96yRLC3qarTMATE2+a
         zUXE+fpzF6lyp+u1bOOclxnGBtb7PNQCOBli/a76mestdMsokB+0VGZHKEm9mYEb7u
         7OHywAhXmZ5Kr9a6bDBgsH1qPZNv9YN2SIbvMDYrL+Szi38uWvsiw2LHNBKqiw0L6j
         q/53SlojreDaw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E5A4F403B5; Tue,  9 May 2023 15:21:29 -0300 (-03)
Date:   Tue, 9 May 2023 15:21:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf bpf skels: vmlinux.h uses bpf.h and perf_event.h in
 the source directory
Message-ID: <ZFqPKU0p73sMb+IG@kernel.org>
References: <20230509063649.239942-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509063649.239942-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 09, 2023 at 06:36:49AM +0000, Yang Jihong escreveu:
> Currently, vmlinux.h uses the bpf.h and perf_event.h header files in the
> system path. If the header files in compilation environment are old,
> compilation may fail. For example:
> 
>   /home/yangjihong/linux/tools/perf/util/bpf_skel/.tmp/../vmlinux.h:151:27: error: field has incomplete type 'union perf_sample_weight'
>           union perf_sample_weight weight;


Can this be solved in the Makefile directives for building BPF targets?

- Arnaldo
 
> Use the bpf.h and perf_event.h files in the source code directory to
> avoid compilation compatibility problems.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/util/bpf_skel/vmlinux.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux.h
> index 449b1ea91fc4..af79bcc4c4b7 100644
> --- a/tools/perf/util/bpf_skel/vmlinux.h
> +++ b/tools/perf/util/bpf_skel/vmlinux.h
> @@ -1,11 +1,13 @@
>  #ifndef __VMLINUX_H
>  #define __VMLINUX_H
>  
> -#include <linux/bpf.h>
>  #include <linux/types.h>
> -#include <linux/perf_event.h>
>  #include <stdbool.h>
>  
> +// Use header files in source directory to avoid compilation compatibility problems.
> +#include "../../../include/uapi/linux/perf_event.h"
> +#include "../../../include/uapi/linux/bpf.h"
> +
>  // non-UAPI kernel data structures, used in the .bpf.c BPF tool component.
>  
>  // Just the fields used in these tools preserving the access index so that
> -- 
> 2.30.GIT
> 

-- 

- Arnaldo
