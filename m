Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD03657BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 16:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiL1PZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 10:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiL1PZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 10:25:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9853F1402A;
        Wed, 28 Dec 2022 07:25:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20DCA61564;
        Wed, 28 Dec 2022 15:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9ACC433EF;
        Wed, 28 Dec 2022 15:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672241112;
        bh=W6bfM3a4PKbIE7EIvoN/B544EGN62Ti2jZ8ZRlS6agI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dWhrDKZZ054H/PNCvybtl+4JwCrIDKL2nK0cnD+3byQWU1WSy5X7Ko8QVDlWBNLZU
         xWHAgia6r363o5dBy74BERghKah0T21uvYptg9jK3lu9WvPLez4ln/hWne1mwg056w
         9Pm261wOGT7/ywSWiuz0ED2Dn1k5LtIqAMJO2/dW5JX7oKCCHYawZVZorIOUwnYXGJ
         o0BZhEkhRBnRX1oyCmN7hIvPxLDwuo1wd+gGsVxvumhRoeCS/KZz9JoM3X19sF46RG
         72xKX1TlBMaPcROwQ/9AQFVPjp4wSUBF9Mx/j1R6PRlPgOtG807UOumHXJoX8I236y
         utr/qU+bMqmYg==
Message-ID: <f47e877c-c95f-e3e6-b96f-89b0ca582878@kernel.org>
Date:   Wed, 28 Dec 2022 16:25:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: rtla osnoise hist: average duration is always zero
To:     Andreas Ziegler <br015@umbiko.net>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <d7bb31547e9bbf6684801a7bbd857810@umbiko.net>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <d7bb31547e9bbf6684801a7bbd857810@umbiko.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On 12/24/22 13:39, Andreas Ziegler wrote:
> -- Observed in, but not limited to, Linux 6.1.1

Since original commit... The best way to report this is adding
a Fixes: tag. For example:

Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")

> rtla osnoise hist always outputs '0' as average duration value. Example:
> 
> # rtla osnoise hist -P F:1 -c 0-1 -r 900000 -d 1M -b 1 -E 5000 -T 1
> # RTLA osnoise histogram
> # Time unit is microseconds (us)
> # Duration:   0 00:01:00
>   ...
> count:     5629      1364
> min:          1         1
> avg:          0         0
> max:       2955        56
> 
> This is due to sum_sample in osnoise_hist_update_multiple() being calculated as the sum (duration), not as sum (duration * count).

Yeah, that is correct. It works on timerlat hist because timerlat hist collects
each trace event. osnoise hist uses in-kernel histograms, so we need to multiply
the value with the count. This is a leftover from the development phase, as I started
using tracing and then moved to histograms (which is better).

> Rounding, instead of truncating, of the average value would be cool.

I thought: the values were already rounded up, so it might be rounding too much.

But we are in user space. It is just easier to add a two digits precision
to the value, no?

> The following patch would solve the issue described above:
> 
> 
> Sampled duration must be weighted by observed quantity, to arrive at a
> correct average duration value.
> 
> Fix calculation of total duration by summing (duration * count).
> Introduce rounding for calculation of final value.
> 
> Signed-off-by: Andreas Ziegler <br015@umbiko.net>
> 
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -121,6 +121,7 @@
>  {
>      struct osnoise_hist_params *params = tool->params;
>      struct osnoise_hist_data *data = tool->data;
> +    unsigned long long total_duration;
>      int entries = data->entries;
>      int bucket;
>      int *hist;
> @@ -131,10 +132,12 @@
>      if (data->bucket_size)
>          bucket = duration / data->bucket_size;
> 
> +    total_duration = duration * count;
> +
>      hist = data->hist[cpu].samples;
>      data->hist[cpu].count += count;
>      update_min(&data->hist[cpu].min_sample, &duration);
> -    update_sum(&data->hist[cpu].sum_sample, &duration);
> +    update_sum(&data->hist[cpu].sum_sample, &total_duration);

How about re-seding a patch with the code above, adding the:

Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")

and...

>      update_max(&data->hist[cpu].max_sample, &duration);
> 
>      if (bucket < entries)
> @@ -333,7 +336,7 @@
> 
>          if (data->hist[cpu].count)
>              trace_seq_printf(trace->seq, "%9llu ",
> -                    data->hist[cpu].sum_sample / data->hist[cpu].count);
> +                (data->hist[cpu].sum_sample + data->hist[cpu].count / 2) / data->hist[cpu].count);

another patch with this part, adding two digits precision?

>          else
>              trace_seq_printf(trace->seq, "        - ");
>      }
> 
Thanks!
-- Daniel

> Kind regards,
> Andreas

