Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60482632F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiKUWHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiKUWHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:07:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47A1330
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 14:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3A345CE1921
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 22:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B22C433D6;
        Mon, 21 Nov 2022 22:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669068455;
        bh=xKl+5O5K9KyORH5vJyHv7kuCYgI2QDjuOh2HfIan11o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=huiFhHq8u0L7LTK0KWEjINP8i9FYRuRFHvPKj3tZsnaEM305owlyUGjwjLlsKRYp2
         XVnRUbgLl1xsmfId3CF+a1+PwRvkRZr50T90HCU6twroBHao6J0pQCEkev5XHjU5yW
         kyhEG4qIX0N9XiXkIkwvjteRHZo3c5DA2yamWLDw=
Date:   Mon, 21 Nov 2022 14:07:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] tools/vm/slabinfo-gnuplot: Use "grep -E" instead of
 "egrep"
Message-Id: <20221121140734.397eacb569252aafee64c498@linux-foundation.org>
In-Reply-To: <1668825419-30584-1-git-send-email-yangtiezhu@loongson.cn>
References: <1668825419-30584-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2022 10:36:59 +0800 Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> The latest version of grep claims the egrep is now obsolete so the build
> now contains warnings that look like:
> 	egrep: warning: egrep is obsolescent; using grep -E
> fix this up by moving the related file to use "grep -E" instead.
> 
>   sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/vm`
> 
> Here are the steps to install the latest grep:
> 
>   wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
>   tar xf grep-3.8.tar.gz
>   cd grep-3.8 && ./configure && make
>   sudo make install
>   export PATH=/usr/local/bin:$PATH
> 
> ...
>
> --- a/tools/vm/slabinfo-gnuplot.sh
> +++ b/tools/vm/slabinfo-gnuplot.sh
> @@ -150,7 +150,7 @@ do_preprocess()
>  	let lines=3
>  	out=`basename "$in"`"-slabs-by-loss"
>  	`cat "$in" | grep -A "$lines" 'Slabs sorted by loss' |\
> -		egrep -iv '\-\-|Name|Slabs'\
> +		grep -E -iv '\-\-|Name|Slabs'\
>  		| awk '{print $1" "$4+$2*$3" "$4}' > "$out"`
>  	if [ $? -eq 0 ]; then
>  		do_slabs_plotting "$out"
> @@ -159,7 +159,7 @@ do_preprocess()
>  	let lines=3
>  	out=`basename "$in"`"-slabs-by-size"
>  	`cat "$in" | grep -A "$lines" 'Slabs sorted by size' |\
> -		egrep -iv '\-\-|Name|Slabs'\
> +		grep -E -iv '\-\-|Name|Slabs'\
>  		| awk '{print $1" "$4" "$4-$2*$3}' > "$out"`
>  	if [ $? -eq 0 ]; then
>  		do_slabs_plotting "$out"

Thanks.  I'll add a cc:stable to this, in an attempt to make older
kernels work well with newer toolchains.

