Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0326291B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiKOGBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiKOGBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:01:10 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AC912AFF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:01:08 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 4so12267653pli.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qbbp7EKV7fq9bVBmYPEt1VHCQM25Vfel3HOW3LqcouU=;
        b=T/9s6RfSTd+Zea5yIicxqn+IcbXtJDKYWooHtIM2M133U9T6uy5fGQ/gU00XxG5NNy
         AZnwPHZHESa8kaxaPhAeE/1yYc9YfFpzqtt+5lK8T58sbkt6Lp4SrqXP/5mmH9nZpx5p
         VdSSSYrAgP8J1VrXaOiJ7wtbif69cjo2vJqkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qbbp7EKV7fq9bVBmYPEt1VHCQM25Vfel3HOW3LqcouU=;
        b=cRbCUSmC1lIqDpO0O1S3enOSxLBULOFLhKiamC36t0WTm+B45Jp3INby9RfTJYzWlt
         bes2eSjDtcSBnXcKYLLsOMM50cQ4K38yiuWF7TzFrJDfjU3VFU029iTF85TN5azXMOVZ
         QqoB/tFM7WAWhigVvEnYhXRIjRLUSK4NDDlDlcgll7OdYAfN1WdumFSYKijpr9LxRfE4
         Tz/yqiA2wu3akuEJguiY36vl8VAt6rCC4+VHEH7srSsGMq0b5fOZadHLG+K5WCYaojuz
         +2wHM+0ZZ31E+t+NmJcg2AZu1oSQPCb1rahPrAfVQvcklyVEQd8gjaPozIqB9VfY7C98
         2NXw==
X-Gm-Message-State: ANoB5pluw5jJXYdN98im4k2T+FLQv1q4IGvCIzryidi09vUpCIpUMKDp
        lJCrIf9Fre+UJjx5XhMJh/obTA==
X-Google-Smtp-Source: AA0mqf7YHseVeZHmH48Yt2HT0XGnJz3qtTmRMwbRzNHwgU9XgL94LA/sXgK8TeM3FZTxLff286SjHA==
X-Received: by 2002:a17:90a:74cf:b0:213:f398:ed51 with SMTP id p15-20020a17090a74cf00b00213f398ed51mr578813pjl.216.1668492067993;
        Mon, 14 Nov 2022 22:01:07 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:3d10:c2ca:ba5b:55e6])
        by smtp.gmail.com with ESMTPSA id m15-20020a656a0f000000b0045dc85c4a5fsm6900883pgu.44.2022.11.14.22.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:01:07 -0800 (PST)
Date:   Tue, 15 Nov 2022 15:01:02 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 0/9] zsmalloc/zram: configurable zspage size
Message-ID: <Y3MrHsaLc8wth00E@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <Y21+xp52OQYi/qjQ@google.com>
 <Y22dxEcs2g5mjuQ7@google.com>
 <Y26AbHxhPBJdWZQE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y26AbHxhPBJdWZQE@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/11 09:03), Minchan Kim wrote:
[..]
> for class in classes:
>     wasted_bytes += class->pages_per_zspage * PAGE_SIZE - an object size
> 
> with *aggressive zpage compaction*. Now, we are relying on shrinker
> (it might be already enough) to trigger but we could change the policy 
> wasted memory in the class size crossed a threshold

Compaction does something good only when we can release zspage in the
end. Otherwise we just hold the global pool->lock (assuming that we
land zsmalloc writeback series) and simply move objects around zspages.
So ability to limit zspage chain size still can be valuable, on another
level, as a measure to reduce dependency on compaction success.

We may be can make compaction slightly more successful. For instance,
if we would start move objects not only within zspages of the same size
class, but, for example, move objects to class size + X (upper size
classes). As an example, when all zspages in class are almost full,
but class size + 1 has almost empty pages. In other words sort of as
is those classes had been merged. (virtual merge). Single pool->look
would be handy for it.

But this is more of a research project (intern project?), with unclear
outcome and ETA. I think in the mean time we can let people start
experimenting with various zspage chain sizes so that may be at some
point we can arrive to a new "default" value for all zspool, higher
than current 4, which has been around for many years. Can't think, at
present, of a better way forward.
