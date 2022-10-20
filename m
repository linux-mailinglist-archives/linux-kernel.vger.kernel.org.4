Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64237606A70
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJTVmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJTVmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:42:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1CD1F9A3B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:42:20 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r18so735982pgr.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4U2oRpEjTt90CCnZjjeopSsGGPuFt6V1dC88+PCMvw=;
        b=GWp+bilgMCKBcaGjpynNExn+Ry13uXeJeOkskYn1urGTOcD1+6YtikQKTLA7Jn18J4
         piJFYwflANHCj7UVMrz+Dp2H4JHC0iE3EumUNYw85zJnAroT7AYNzOoAe/db/TPudovX
         PXDSvbJfNgTwqc3dmCiKHWjzViNRwbaC97brjgsAc7byPvdVb8Q6Rvxf5zs4F/LjphZO
         C6EVyDgz4bY/Jq6r3eY3OiAVAAs9/2HHApz/LbJkZdCwbjnTtBH8RnDKBtpoBuuqoJ8P
         RxWqDembgGWqc8g1ApX61z9RDIbTuQUxbV9G3gRZ0WdRUBBUu/gVD8/0Ji0NwQRFMAKA
         Mvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4U2oRpEjTt90CCnZjjeopSsGGPuFt6V1dC88+PCMvw=;
        b=pyfknsLP3JBhySlwA3rsLuAq831mLzxPynC5KeEDaUrmvb1QUklZ4FnkCzElPeB2Ow
         9h6c0Neerv8qdLuYo4aAbT3bD1zt+r+4WuKMfpsxGRa3+GGoJb14NxTTXCUVeZ+foO63
         ezBD75O/jcN4PGmk+RU6ah4pvgFNaKl+7pPjKF37eyzgW6qWeVh2XuVTsr2h05sKoM6I
         NGwCxRRTncfoMtjol6ZWQSPLu7HZR3EZtiXtI1BanDx4zrTBnYwsb71X7CReqLmAjDIb
         QgpoRbWCRTV2qrGpczQ7LiNXvUBQWr9a2pXJerG4uiiXuG3rBuV0+X7iRhtillmBep3h
         RdxA==
X-Gm-Message-State: ACrzQf0JqMNhQxYU+kDH+qczGX7Xz8aWTlpmeqq8XleW0mDiBs7FeFc9
        uFspLpq2IMqjTIBhTAFrqZGqZw==
X-Google-Smtp-Source: AMsMyM72Rbp4Al2d06kXuEPpLt+FzPYg9SSAnrt0SabeXS4rNJ99Y0yyilEJeDHibB48AG2bYKNlpw==
X-Received: by 2002:a05:6a00:15c8:b0:565:bc96:1c5b with SMTP id o8-20020a056a0015c800b00565bc961c5bmr15760269pfu.52.1666302140329;
        Thu, 20 Oct 2022 14:42:20 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 7-20020a620407000000b0056283e2bdbdsm13802450pfe.138.2022.10.20.14.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:42:19 -0700 (PDT)
Date:   Thu, 20 Oct 2022 21:42:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, dmatlack@google.com, andrew.jones@linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] KVM: selftests: Run dirty_log_perf_test on
 specific CPUs
Message-ID: <Y1HAuDAP66HNk1rT@google.com>
References: <20221010220538.1154054-1-vipinsh@google.com>
 <20221010220538.1154054-6-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010220538.1154054-6-vipinsh@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022, Vipin Sharma wrote:
> @@ -383,6 +383,18 @@ static void help(char *name)
>  	backing_src_help("-s");
>  	printf(" -x: Split the memory region into this number of memslots.\n"
>  	       "     (default: 1)\n");
> +	printf(" -c: Pin tasks to physical CPUs.  Takes a list of comma separated\n"
> +	       "     values (target pCPU), one for each vCPU, plus an optional\n"
> +	       "     entry for the main application task (specified via entry\n"
> +	       "     <nr_vcpus + 1>).  If used, entries must be provided for all\n"
> +	       "     vCPUs, i.e. pinning vCPUs is all or nothing.\n\n"
> +	       "     Example: ./dirty_log_perf_test -v 3 -c 22,23,24,50\n"
> +	       "     will create 3 vCPUs, and pin vCPU0=>pCPU22, vCPU1=>pCPU23\n"
> +	       "     vCPU2=>pCPU24, and pin the application task to pCPU50.\n"
> +	       "     To leave the application task unpinned, drop the final\n"
> +	       "     entry:\n"
> +	       "       ./dirty_log_perf_test -v 3 -c 22,23,24\n\n"
> +	       "     (default: no pinning)\n");

Any objection to tweaking the formatting to make the output easier to parse?  And
to match the indentation used by guest_modes_help().  E.g. This

	printf(" -c: Pin tasks to physical CPUs.  Takes a list of comma separated\n"
	       "     values (target pCPU), one for each vCPU, plus an optional\n"
	       "     entry for the main application task (specified via entry\n"
	       "     <nr_vcpus + 1>).  If used, entries must be provided for all\n"
	       "     vCPUs, i.e. pinning vCPUs is all or nothing.\n\n"
	       "     E.g. to create 3 vCPUs, pin vCPU0=>pCPU22, vCPU1=>pCPU23\n"
	       "     vCPU2=>pCPU24, and pin the application task to pCPU50:\n\n"
	       "         ./dirty_log_perf_test -v 3 -c 22,23,24,50\n\n"
	       "     To leave the application task unpinned, drop the final entry:\n\n"
	       "         ./dirty_log_perf_test -v 3 -c 22,23,24\n\n"
	       "     (default: no pinning)\n");

yields:

 -c: Pin tasks to physical CPUs.  Takes a list of comma separated
     values (target pCPU), one for each vCPU, plus an optional
     entry for the main application task (specified via entry
     <nr_vcpus + 1>).  If used, entries must be provided for all
     vCPUs, i.e. pinning vCPUs is all or nothing.

     E.g. to create 3 vCPUs, pin vCPU0=>pCPU22, vCPU1=>pCPU23
     vCPU2=>pCPU24, and pin the application task to pCPU50:

         ./dirty_log_perf_test -v 3 -c 22,23,24,50

     To leave the application task unpinned, drop the final entry:

         ./dirty_log_perf_test -v 3 -c 22,23,24

     (default: no pinning)


versus:

 -c: Pin tasks to physical CPUs.  Takes a list of comma separated
     values (target pCPU), one for each vCPU, plus an optional
     entry for the main application task (specified via entry
     <nr_vcpus + 1>).  If used, entries must be provided for all
     vCPUs, i.e. pinning vCPUs is all or nothing.

     Example: ./dirty_log_perf_test -v 3 -c 22,23,24,50
     will create 3 vCPUs, and pin vCPU0=>pCPU22, vCPU1=>pCPU23
     vCPU2=>pCPU24, and pin the application task to pCPU50.
     To leave the application task unpinned, drop the final
     entry:
       ./dirty_log_perf_test -v 3 -c 22,23,24

     (default: no pinning)

