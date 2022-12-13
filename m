Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF4264B7B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiLMOrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbiLMOq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:46:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE53810F1;
        Tue, 13 Dec 2022 06:46:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DEE8B811D8;
        Tue, 13 Dec 2022 14:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B70C433D2;
        Tue, 13 Dec 2022 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670942815;
        bh=NwJuTwiyOhsyAz5MnkG/oH20O7yCyhCQSiBMpco+whI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=owV3wvWwqrFmWp0fmFkw4XsUh1NJRfkSeCG7/gQIfg+qXQUdqbfHKG9OklXREka4I
         M1/NayxyoA8WpauDMAyeoSwsrN6Z4YUsMKby6fcFg57EYVyLALQbsBjwR8EMuob46e
         s+kMftmF6tUp3IottLrMOY+kRsjRr4UOTRjSjcRVYmPNOTHRwrz36KcEDN+v7Ss75s
         YGJd7JVkf3P5IVBH1VHgZi2+Tv+9hxo5VI/kR0faD+2aqfryGC0sgtj+JO6fa39FZZ
         /uHQFJHp2HEfmUpwn9ib4cYFELGGbDRYGePDcRBqbFLUDldqhWd6RKGVktsIWG1c4f
         t2aM7j7w8osdg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 514D840367; Tue, 13 Dec 2022 11:46:52 -0300 (-03)
Date:   Tue, 13 Dec 2022 11:46:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        svens@linux.ibm.com
Subject: Re: [PATCH 2/2] perf/test: Fix perf test 89 on x86
Message-ID: <Y5iQXJaQOrhjLZQW@kernel.org>
References: <20221213105729.1447368-1-tmricht@linux.ibm.com>
 <20221213105729.1447368-2-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213105729.1447368-2-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 13, 2022 at 11:57:29AM +0100, Thomas Richter escreveu:
> perf test '89: probe libc's inet_pton & backtrace it with ping'
> fails on x86. Debugging revealed a changed stack trace for the
> ping command using probes:
> 
> ping 35729 [002]  8006.365063: probe_libc:inet_pton: (3ff9603e7c0)
>                   12be50 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
>                   4fca main+0x139b (/usr/bin/ping)
> 
> The line getaddrinfo.... in the call stack is gone.
> It was introduced with glibc version 2.36.8 released
> with Fedora 37.
> 
> Output before on x86
>  # ./perf test 89
>  89: probe libc's inet_pton & backtrace it with ping   : FAILED!
>  #
> 
> Output after on x86:
>  # ./perf test 89
>  89: probe libc's inet_pton & backtrace it with ping   : Ok
>  #

Not having at the current state of that script, that $expected may be a
subset of the actual backtrace, i.e. will this continue working with
the systems where that getaddrinfo line appear?

- Arnaldo
 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index 0f01c62cbee9..51ae8b906055 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -50,7 +50,6 @@ trace_libc_inet_pton_backtrace() {
>  		;;
>  	*)
>  		eventattr='max-stack=3'
> -		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
>  		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>  		;;
>  	esac
> -- 
> 2.38.1

-- 

- Arnaldo
