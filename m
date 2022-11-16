Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BD662B043
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 01:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiKPAw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 19:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKPAw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:52:57 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E932F670
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 16:52:56 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 140so14520555pfz.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 16:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xb7zxmPf+ONVcQfpx029D/sCIkvuG5jR1+Y0BJgF2PM=;
        b=blnaeTtTyzXnpZLcVwA0S+muYWw5gbA6AuneyeHjS5EHufk8lvDIW+5DEyky6sjS0I
         SOZM6SUqaeoldKZsm7NXvK7xrMyhmTNRglHT9uMqaatqMEWVXPIqhXHfU/XZiVUoimRX
         DxV966vq8/IKmmmH2Lzw+0wYedFI+IEpZF9ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb7zxmPf+ONVcQfpx029D/sCIkvuG5jR1+Y0BJgF2PM=;
        b=nFnsSXHXIjwl6HWaQUN7YLtSR/pro86NxVRQ14Wlk5p6arcVaVrfq2UEFye7oQNuvm
         c+0COVnNNrzAS1DVNXBsQ7lgcSbyDCTD/sAw6gbi2NNro8VRLUDETE9Sr4tvTZwYnKEA
         gKqfiEB/4dqnUMkS1n9SseGEej+ZpCtqcRFd8QfSRitQOhK1hjkpklnzkgaghQ+ztlcx
         wE+E0RtQoAU2OXtBlTYdYs2zgVQ8l9heTKzqhEUH3TNYdoSMB6u1ZsvPn+Pe4Pro4W5l
         /4bPS7Bzlp4fqiG97opeRV/Vs6aNuq4ZqxQJRjnoU1OesH/gIWtel/hGVyZ/hBTKUhhk
         SMoQ==
X-Gm-Message-State: ANoB5pmhe0EQo+XFlxlMlP00rakU61lhqK+x0bORJ1wh5ffF6Y4Piofr
        REKVa7B6VkIztKDWeX3zP2gNiOA+Q+ZD/Q==
X-Google-Smtp-Source: AA0mqf48PAGcMUFTmYQmJSHT+lbl25BuF1R+3JiN++qxnGv41DmnIxEBd4aKybk+oJEp/VKmrJvylw==
X-Received: by 2002:a63:5d46:0:b0:46f:9c0b:1e86 with SMTP id o6-20020a635d46000000b0046f9c0b1e86mr17621582pgm.508.1668559975565;
        Tue, 15 Nov 2022 16:52:55 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:9603:e3e0:aec4:58d5])
        by smtp.gmail.com with ESMTPSA id a11-20020aa7970b000000b00562664d5027sm9473087pfg.61.2022.11.15.16.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 16:52:54 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:52:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 0/9] zsmalloc/zram: configurable zspage size
Message-ID: <Y3Q0YnpX7jBOHKqp@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <Y21+xp52OQYi/qjQ@google.com>
 <Y22dxEcs2g5mjuQ7@google.com>
 <Y26AbHxhPBJdWZQE@google.com>
 <Y3MrHsaLc8wth00E@google.com>
 <Y3NG4fsjxHGrnbDp@google.com>
 <Y3QfdyKNrZjx5FR8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3QfdyKNrZjx5FR8@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/15 15:23), Minchan Kim wrote:
> Sure, if we start talking about battery, that would have a lot of things
> we need to consider not only from zram-direct but also other indirect-stuffs
> caused caused by memory pressure and workload patterns. That's not what we
> can control and would consume much more battery. I understand your concern
> but also think sysfs per-konb can solve the issue since workload is too
> dynamic even in the same swap file/fs, too. I'd like to try finding a
> sweet spot in general. If it's too hard to have, then, we need to introduce
> the knob with reasonable guideline how we could find it.
> 
> Let me try to see the data under Android workload how much just increase
> the ZS_MAX_PAGES_PER_ZSPAGE blindly will change the data.

I don't want to push for sysfs knob.

What I like about sysfs knob vs KConfig is that sysfs is opt-in. We can
ask folks to try things out, people will know what to look at and they
will keep an eye on metrics, then they come back to us. So we can sit
down, look at the numbers and draw some conclusions. KConfig is not
opt-in. It'll happen for everyone, as a policy, transparently and then
we rely on
a) people tracking metrics that they were not asked to track
b) people noticing changes (positive or negative) in metrics that they
   don't keep an eye on
c) people figuring out that change in metrics is related to zsmalloc
   Kconfig (and that's a very non-obvious conclusion)
d) people reaching out to us

That's way too much to rely on. Chances are we will never hear back.

I understand that you don't like sysfs, and it's not the best thing
probably, but KConfig is not better. I like the opt-in nature of
sysfs - if you change it then you know what you are doing.
