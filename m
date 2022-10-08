Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC445F8525
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 13:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJHLzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 07:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiJHLzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 07:55:35 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712AE43140
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 04:55:32 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id h8QOovA5ITyouh8QOoKFYq; Sat, 08 Oct 2022 13:55:27 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Oct 2022 13:55:27 +0200
X-ME-IP: 86.243.100.34
Message-ID: <6a57b91b-8614-6596-ae0f-acce6a31d161@wanadoo.fr>
Date:   Sat, 8 Oct 2022 13:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/i915/perf: remove redundant variable 'taken'
Content-Language: fr
To:     Colin Ian King <colin.i.king@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221007195345.2749911-1-colin.i.king@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221007195345.2749911-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 07/10/2022 à 21:53, Colin Ian King a écrit :
> The assignment to variable taken is redundant and so it can be
> removed as well as the variable too.
> 
> Cleans up clang-scan build warnings:
> warning: Although the value stored to 'taken' is used in the enclosing
> expression, the value is never actually read from 'taken'
> [deadcode.DeadStores]

Hi,

#define OA_TAKEN(tail, head)	((tail - head) & (OA_BUFFER_SIZE - 1))

So if the result is not used, maybe calling OA_TAKEN() can be removed as 
well?
It looks like a no-op in such a case.

CJ

> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/gpu/drm/i915/i915_perf.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> index 0defbb43ceea..15816df916c7 100644
> --- a/drivers/gpu/drm/i915/i915_perf.c
> +++ b/drivers/gpu/drm/i915/i915_perf.c
> @@ -656,7 +656,6 @@ static int gen8_append_oa_reports(struct i915_perf_stream *stream,
>   	size_t start_offset = *offset;
>   	unsigned long flags;
>   	u32 head, tail;
> -	u32 taken;
>   	int ret = 0;
>   
>   	if (drm_WARN_ON(&uncore->i915->drm, !stream->enabled))
> @@ -692,7 +691,7 @@ static int gen8_append_oa_reports(struct i915_perf_stream *stream,
>   
>   
>   	for (/* none */;
> -	     (taken = OA_TAKEN(tail, head));
> +	     OA_TAKEN(tail, head);
>   	     head = (head + report_size) & mask) {
>   		u8 *report = oa_buf_base + head;
>   		u32 *report32 = (void *)report;
> @@ -950,7 +949,6 @@ static int gen7_append_oa_reports(struct i915_perf_stream *stream,
>   	size_t start_offset = *offset;
>   	unsigned long flags;
>   	u32 head, tail;
> -	u32 taken;
>   	int ret = 0;
>   
>   	if (drm_WARN_ON(&uncore->i915->drm, !stream->enabled))
> @@ -984,7 +982,7 @@ static int gen7_append_oa_reports(struct i915_perf_stream *stream,
>   
>   
>   	for (/* none */;
> -	     (taken = OA_TAKEN(tail, head));
> +	     OA_TAKEN(tail, head);
>   	     head = (head + report_size) & mask) {
>   		u8 *report = oa_buf_base + head;
>   		u32 *report32 = (void *)report;

