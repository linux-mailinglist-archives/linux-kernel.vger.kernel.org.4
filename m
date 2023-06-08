Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18404728B71
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjFHW4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjFHW4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:56:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6456D2D74;
        Thu,  8 Jun 2023 15:56:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-652d76be8c2so1197102b3a.3;
        Thu, 08 Jun 2023 15:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686264995; x=1688856995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRNO5qzF8eIMBLEORTWc2Zg/96WMOLy0Rgq4CTjwY7Y=;
        b=gHz9I3IzpLLN8CrMdUMHYnAgiA8egk2/MnVJWFrS1R9WjtUVwhkBcv3XFWbDarbqgo
         nR99aGWvBXQ9iU57zC/ZoU6Sb7x+dVwBK/o8tWjo/IYDq1Z/HITpz9xYYIZBgU7LNnfe
         lu6w+DAsD9/WoJvPPeK1XLcq5rPNnVam/Jf9PvgWbZ5FauNb6/OWh9TnQBACU6gqoCHm
         5AFqgS4jh9KjAdVUUlmF0W2TGry9YBUaGs4qovnk/OVkQUQDWGTShNMm+FvNW1lu5Mu+
         4ck52MheYrNO+vWLViUFZKvLfFFEf/bEaRHsb6vs6IvjBfzzmvSOscULyUA/Ol4enNxj
         OWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686264995; x=1688856995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRNO5qzF8eIMBLEORTWc2Zg/96WMOLy0Rgq4CTjwY7Y=;
        b=BAM3mhCU1+5tGn3K0dgRZWXIG9A+f9DbwpwFSQFfM2xy3prfU7InrNRqMoor9kZ8yr
         +sSpqoPQj3qvqCKidl+09HvD8TWytKAa3laVB1UiXQaAWQbeduEn/oVT+pnbM8voDYNw
         2B5GoQf4ko4vkjWNjC7YyHx4lgBiR+FIROvjQ7LItifUXJ/iIUvcDsu4hTMJj6YZT5Df
         k90P3gx1tLYIIbJY1ysSDvO8AccDLYS2TJ9EbWzeo2/+RJ4J2mVHW+I1H5/Ts4AH/IcP
         sw3sJbtwa/74vsnt8GuV2Y7hPr80oRX+N94hmtv+VpdY8pHobAPSeV/OzYzXpGIcP8At
         R0YA==
X-Gm-Message-State: AC+VfDzv3IlyHiY8rvv1B+OLAWvo6mcvCxH/JV3Ssgvfq8JhAVtSS1/9
        KIAGXfeiELHcSJ5LpCjH/Aw=
X-Google-Smtp-Source: ACHHUZ77VN7E88WqlWGh8sKsojka8rd00FTKk6Lr12PhF70Rn3rnq8Jv17dYSJw6zuquF+FYNZ6MZQ==
X-Received: by 2002:a05:6a21:6d8d:b0:10b:58f1:7a6f with SMTP id wl13-20020a056a216d8d00b0010b58f17a6fmr9109480pzb.41.1686264995417;
        Thu, 08 Jun 2023 15:56:35 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id k4-20020aa790c4000000b0063b8d21be5asm1581319pfk.147.2023.06.08.15.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 15:56:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 8 Jun 2023 12:56:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] blk-mq: fix incorrect rq start_time_ns and alloc_time_ns
 after throttled
Message-ID: <ZIJco7_jaVaxpxSR@slm.duckdns.org>
References: <20230601053919.3639954-1-chengming.zhou@linux.dev>
 <ZH4p8tqFc57_OYoH@slm.duckdns.org>
 <c82d6bab-36d0-0403-9304-4415f6ffd972@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c82d6bab-36d0-0403-9304-4415f6ffd972@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jun 06, 2023 at 06:22:28PM +0800, Chengming Zhou wrote:
...
> But for plug batched allocation introduced by the commit 47c122e35d7e
> ("block: pre-allocate requests if plug is started and is a batch"), we can
> rq_qos_throttle() after the allocation of the request. This is what the
> blk_mq_get_cached_request() does.
> 
> In this case, the cached request alloc_time_ns or start_time_ns is much ahead
> if block in any qos ->throttle().

Ah, okay, that's problematic.

> >> This patch add nr_flush counter in blk_plug, so we can tell if the task
> >> has throttled in any qos ->throttle(), in which case we need to correct
> >> the rq start_time_ns and alloc_time_ns.
> >>
> >> Another solution may be make rq_qos_throttle() return bool to indicate
> >> if it has throttled in any qos ->throttle(). But this need more changes.
> >>
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > 
> > Depending on the flush behavior and adjusting alloc_time_ns seems fragile to
> > me and will likely confuse other users of alloc_time_ns too.
> 
> I agree with you, this code is not good. My basic idea is to adjust the cached
> request alloc_time_ns and start_time_ns when throttled.

Would it make sense to skip setting the alloc_time_ns during pre-allocation
and set it later when the pre-allocated rq is actually used? That should
jive better.

Thanks.

-- 
tejun
