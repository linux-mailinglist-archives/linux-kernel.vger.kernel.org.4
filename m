Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6DB6F59A2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjECOPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjECOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:15:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD03CA3;
        Wed,  3 May 2023 07:15:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55AAD62D4F;
        Wed,  3 May 2023 14:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B679C433EF;
        Wed,  3 May 2023 14:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683123335;
        bh=IkxIKxJBkrgQPXunbrz4Ou5SNcSK24nQwje5URudgcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xm1I2ZJiaBQZx+BjFE4+WvP5IRB6Xryb9boIW3/GShpVTSKt11Vsjaz83dEGdacIy
         Bbza5H7fg6TI24uT+QqxB59Ozyqq0r9Obo8cqbx7VI0rvchvABvyUoqWvl7J5qdxyx
         4jr3rIy2yUSge5QrnWGQyJogV8xCepAVQsajjrbX0YwhL3UxZEmrBRIyfAb4J50gyL
         c6MgU07Hmg5qHXpGA+rE6zccY+KG4DmcVaP/DktWjHSTJbWkI6/6F/FwAGFJM3s8Os
         4p+9hBWdGsTNzKAIdhTCiVdxxVSinULnNVlA2lqKKxDgEEvOVHtHNcKB/Isb8HekFo
         k/JfvNdVxsRTg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 05405403B5; Wed,  3 May 2023 11:15:32 -0300 (-03)
Date:   Wed, 3 May 2023 11:15:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] Fix perf test probe libc's inet_pton on x86_64
Message-ID: <ZFJshPeWTCoGwbzr@kernel.org>
References: <20230503081255.3372986-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503081255.3372986-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 03, 2023 at 10:12:55AM +0200, Thomas Richter escreveu:
> The test case probe libc's inet_pton & backtrace it with ping
> fails with Fedora 38 on x86_64.
> 
> Function getaddrinfo() does not show up in the call chain anymore:
>  # ./perf script
>  ping  1803 [000] 728.567146: probe_libc:inet_pton: (7f5275afc840)
>            133840 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
>             27b4a __libc_start_call_main+0x7a (/usr/lib64/libc.so.6)
>             27c0b __libc_start_main@@GLIBC_2.34+0x8b (/usr/lib64/libc.so.6)
> 
>  ping  1803 [000]   728.567184: probe_libc:inet_pton: (7f5275afc840)
>            133840 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
>              493e main+0xcde (/usr/bin/ping)
>             27b4a __libc_start_call_main+0x7a (/usr/lib64/libc.so.6)
> 
>  #
> which causes the test case to fail. Remove function getaddrinfo()
> from list of expected functions.
> 
> Output before:
>  # ./perf test 'libc'
>  91: probe libc's inet_pton & backtrace it with ping    : FAILED!
>  #
> 
> Output after:
>  # ./perf test 'libc'
>  91: probe libc's inet_pton & backtrace it with ping    : Ok
>  #

Thanks, tested and applied.

- Arnaldo
 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index b4149b2db4c6..8d5915d3ad6f 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -51,7 +51,6 @@ trace_libc_inet_pton_backtrace() {
>  		;;
>  	*)
>  		eventattr='max-stack=3'
> -		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
>  		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>  		;;
>  	esac
> -- 
> 2.40.1
