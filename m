Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4534A6DA221
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbjDFUCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjDFUCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:02:16 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A9583D0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:02:15 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id n125so47324718ybg.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680811334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IWRsZ2R0gmFY3LChOkHfgbf4Qvq3P9/fH9lrLjafpto=;
        b=LRWGk470kfpNXd38RtVM9BvlKwlboaqS0YzuDz+unzuhb1VgqEfXQDgStpvVWVCzgX
         VH16NMWxrxFTvAfw3FVoQ0rOhQSc5tmKdo/EOd2squdilqYlNBi+rlhKgfvkpU/VYOyn
         0ORjZMVrSDULajTv0yUfw2Iw75priMiuroLB1ZGBsRYwH3UcLlGZmybfBSFjhFsJKR7t
         A6bmiwV1v3/CcTEnrZ5FPmdt33zoF8C8dUQnYqBTjAQhB8Ulkbko8scqpUt5qDIfzCYM
         1zd2++jLRIDtzOinnBgeT78PuwJraxIJ57yWc2GpzccQu71smzFoBvjzN+YVtvZ24kB+
         slXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWRsZ2R0gmFY3LChOkHfgbf4Qvq3P9/fH9lrLjafpto=;
        b=veFROHdglnb4wO7ty8c80/YL/WIODPqUpYAvYwXjHZAgOFWsL570bJ7InaHCzDOR5X
         /6oDlwBp+himWcwPq+BgIhrzEq9oEyWypOH/9x1Vu6xBzLcZyq+6gW/EKb13oI4tB7yW
         lmLfBd6aqASZdcJDrssQYP5rhNgNoB+znTxtNB3G8yvnrAHIfpeVkGbVCokLFKHdndQO
         i6/zkNDwCt+zgVxDneiw0j7iphye0mOWFFUUssO/ShvHRopc9eKckxuxg6hCPKpQPgY3
         IAxvVfq3M4liwPeUOOG4BtWdzU5yUSvj2tZBbHupFrqIZS+gu+AAmBxAJ4JGBVDvrsU/
         8Oqw==
X-Gm-Message-State: AAQBX9e0O8W1cYIub3Ot5mfTM+3K7iF7EcEzWti1sYBRpd9ERmpBLO76
        G+5EkMuhdwO6AVCB5bgIr77o7A==
X-Google-Smtp-Source: AKy350b9wAurodpwuCRJ9Fk3uJ1oRAYP1n5ZbGSkYWbHlgU5KLi61/Dy8/2GyUpu2dz0P1F1Eu6hDg==
X-Received: by 2002:a25:6802:0:b0:934:83b7:3f36 with SMTP id d2-20020a256802000000b0093483b73f36mr448758ybc.9.1680811334504;
        Thu, 06 Apr 2023 13:02:14 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id i4-20020a05620a248400b007469c93ac2dsm722424qkn.31.2023.04.06.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:02:14 -0700 (PDT)
Date:   Thu, 6 Apr 2023 16:02:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: global_reclaim() and code documentation (was: Re: [PATCH v3 3/3]
 mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
Message-ID: <20230406200213.GA50192@cmpxchg.org>
References: <20230405200150.GA35884@cmpxchg.org>
 <CAOUHufYCxdAXtw_b1qFT_02L3gWcs3of6Y0-5mmLwr+CeWvLQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYCxdAXtw_b1qFT_02L3gWcs3of6Y0-5mmLwr+CeWvLQQ@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 03:09:27PM -0600, Yu Zhao wrote:
> On Wed, Apr 5, 2023 at 2:01 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > static bool cgroup_reclaim(struct scan_control *sc)
> > {
> >         return sc->target_mem_cgroup;
> > }
> >
> > static bool global_reclaim(struct scan_control *sc)
> > {
> >         return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->target_mem_cgroup);
> > }
> >
> > The name suggests it's the same thing twice, with opposite
> > polarity. But of course they're subtly different, and not documented.
> >
> > When do you use which?
> 
> The problem I saw is that target_mem_cgroup is set when writing to the
> root memory.reclaim. And for this case, a few places might prefer
> global_reclaim(), e.g., in shrink_lruvec(), in addition to where it's
> being used.
>
> If this makes sense, we could 1) document it (or rename it) and apply
> it to those places, or 2) just unset target_mem_cgroup for root and
> delete global_reclaim(). Option 2 might break ABI but still be
> acceptable.

Ah, cgroup_reclaim() tests whether it's limit/proactive reclaim or
allocator reclaim. global_reclaim() tests whether it's root reclaim
(which could be from either after memory.reclaim).

I suppose we didn't clarify when introducing memory.reclaim what the
semantics should be on the root cgroup:

- We currently exclude PGSCAN and PGSTEAL stats from /proc/vmstat for
  limit reclaim to tell cgroup constraints from physical pressure. We
  currently exclude root memory.reclaim activity as well. Seems okay.

- The file_is_tiny heuristic is for allocator reclaim near OOM. It's
  currently excluded for root memory.reclaim, which seems okay too.

- Like limit reclaim, root memory.reclaim currently NEVER swaps when
  global swappiness is 0. The whole cgroup-specific swappiness=0
  semantic is kind of quirky. But I suppose we can keep it as-is.

- Proportional reclaim is disabled for everybody but direct reclaim
  from the allocator at initial priority. Effectively disabled for all
  situations where it might matter, including root memory.reclaim. We
  should also keep this as-is.

- Writeback throttling is interesting. Historically, kswapd set the
  congestion state when running into lots of PG_reclaim pages, and
  clear it when the node is balanced. This throttles direct reclaim.

  Cgroup limit reclaim would set and clear congestion on non-root only
  to do local limit-reclaim throttling. But now root memory.reclaim
  might clear a bit set by kswapd before the node is balanced, and
  release direct reclaimers from throttling prematurely. This seems
  wrong. However, the alternative is throttling memory.reclaim on
  subgroup congestion but not root, which seems also wrong.

- Root memory.reclaim is exempted from the compaction_ready() bail
  condition as well as soft limit reclaim. But they'd both be no-ops
  anyway if we changed cgroup_reclaim() semantics.

IMO we should either figure out what we want to do in those cases
above, at least for writeback throttling.

Are you guys using root-level proactive reclaim?

> If we don't want to decide right now, I can rename global_reclaim() to
> root_reclaim() and move it within #ifdef CONFIG_LRU_GEN and probably
> come back and revisit later.

So conventional vmscan treats root-level memory.reclaim the same as
any other cgroup reclaim. And the cgroup_reclaim() checks are mostly
reserved for (questionable) allocator reclaim-specific heuristics.

Is there a chance lrugen could do the same, and you'd be fine with
using cgroup_reclaim()? Or is it a data structure problem?

If so, I agree it could be better to move it to CONFIG_LRU_GEN and
rename it for the time being. root_reclaim() SGTM.
