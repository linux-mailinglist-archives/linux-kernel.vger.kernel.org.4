Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720FA5EB1A4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiIZTwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiIZTwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:52:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A61F9EE;
        Mon, 26 Sep 2022 12:52:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D0186129B;
        Mon, 26 Sep 2022 19:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4B4C433D6;
        Mon, 26 Sep 2022 19:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664221919;
        bh=bgsgz2grzEE537Qs/RlpiyBgkh/XZEjx6j5sbTdljEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GfathvNGTX/eVb4grOp75I+Zxhe7wdYp/8VWxsVc+vqao/jfHLRispl/UbNN1A1Za
         VftObsznsr0CoBnfgOSZrOY8tSu3zUdN7OCptiWY48D16fG6UXloJp5SHHpOxQ1tMH
         d2ZATmJEdSk87zwSfXUHxQHRdEx0hOOWOl0BEkMpdSt3NeRHIA+q1SMbj7aAjsS9kt
         3eU11ioUwSxNjTgyJwMAuwsPrGlsarQ44Jh6DDgli7bnL5trhKLn2B70/XsjXaxJ29
         aQbDQwZgFwsBMP2w8qRiADXB2+MkFAPs/WkKUlBitK2K0gWo9yyCIie0D2RN9nCg+6
         qW++12Pqm5G6g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A9D1B403B0; Mon, 26 Sep 2022 20:51:56 +0100 (IST)
Date:   Mon, 26 Sep 2022 20:51:56 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, john.garry@huawei.com,
        adrian.hunter@intel.com, ak@linux.intel.com,
        florian.fischer@muhq.space
Subject: Re: [PATCH -next 2/5] perf: Fix incorrectly parsed flags in filter
Message-ID: <YzIC3EpZaDNQlFOe@kernel.org>
References: <20220926031440.28275-1-chenzhongjin@huawei.com>
 <20220926031440.28275-3-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926031440.28275-3-chenzhongjin@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 26, 2022 at 11:14:37AM +0800, Chen Zhongjin escreveu:
> When parsing flags in filter, the strtoul function uses wrong parsing
> condition (tok[1] = 'x'), which can make the flags be corrupted and
> treat all numbers start with 0 as hex.
> 
> In fact strtoul() will auto test hex format when base == 0 (See
> _parse_integer_fixup_radix). So there is no need to test this again.
> 
> Remove the unnessesary is_hexa test.

Thanks, applied.

- Arnaldo

 
> Fixes: 154c978d484c ("libbeauty: Introduce strarray__strtoul_flags()")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  tools/perf/builtin-trace.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index c7bb7a8222a6..7ecd76428440 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -615,11 +615,8 @@ bool strarray__strtoul_flags(struct strarray *sa, char *bf, size_t size, u64 *re
>  		if (isalpha(*tok) || *tok == '_') {
>  			if (!strarray__strtoul(sa, tok, toklen, &val))
>  				return false;
> -		} else {
> -			bool is_hexa = tok[0] == 0 && (tok[1] = 'x' || tok[1] == 'X');
> -
> -			val = strtoul(tok, NULL, is_hexa ? 16 : 0);
> -		}
> +		} else
> +			val = strtoul(tok, NULL, 0);
>  
>  		*ret |= (1 << (val - 1));
>  
> -- 
> 2.17.1

-- 

- Arnaldo
