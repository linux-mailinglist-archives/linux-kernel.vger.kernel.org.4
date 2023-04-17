Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9E6E4625
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDQLOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjDQLOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:14:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17BF65AF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:13:39 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i8so16257168plt.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681729969; x=1684321969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ym2iTUwYVaWcJIA6dTtqLmrSL3SannhpVhMnxRPf3Fc=;
        b=SZ12pbssbjHUow9znkGHEbDHYBaDRi91wqJMnjeC+2m3PX/022btfKCJ260Z2TZdqK
         hP+SU4Xt7nufTLUqOQ7Qzwb8z2dNLitHsYzdEjw8DXN+1jKzjMe20d9pady+jbrvNSvV
         COJ9CPh+1FhrqGQe29HsgZtVXCR0MtrvgmAJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681729969; x=1684321969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym2iTUwYVaWcJIA6dTtqLmrSL3SannhpVhMnxRPf3Fc=;
        b=SgazUjqLkKyD+H7nE5t9qYsHmB7fqJlolCmQiQ+DCCZY1fYlDcNs2f/2iZV0rfujlk
         QdqxOaC0U7GnK+eUCo74po3JmoaeSjrKECuekicaMIq6FaTC+2aHcSDfGHxyoRnVrqGS
         5lmoWIRD8F0HNH0KmwAk6irPlm5/IcaYU0ozqRJfUzUNlwYVq99iV0mTcKlhmG5KAn06
         uEvLDdfmdP2WcCjIDL3lgris0MtBoScfQYuBx17G2Nhmsa0Tucx8y7fbpvS8HrSkLNzd
         ZJFYcugs+CuSHvvcX1kuetULuK/rti2I7GtHMuRHDr2maC1F+cZIKldgfx1PUqGlQfr9
         SZRg==
X-Gm-Message-State: AAQBX9cxW709bErWZn31rCW81YyCxa+JFl75OhwM7GjvrQAOzx6te8QJ
        vPIGXNhfzO9lYce6lB9SNbRDCw==
X-Google-Smtp-Source: AKy350YWn3KpPdVRwVstuqwc5G/3ig3SKTF2ExoN3zDvfo327CiLjLu1Tz0B5K5epY34HwTtVNdTnw==
X-Received: by 2002:a17:902:eb89:b0:19c:d309:4612 with SMTP id q9-20020a170902eb8900b0019cd3094612mr11599882plg.6.1681729968673;
        Mon, 17 Apr 2023 04:12:48 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902ee5400b001a19bac463fsm7458297plo.42.2023.04.17.04.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 04:12:48 -0700 (PDT)
Date:   Mon, 17 Apr 2023 20:12:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv4 0/4] zsmalloc: fine-grained fullness and new compaction
 algorithm
Message-ID: <20230417111243.GN25053@google.com>
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
 <CAOUHufZ6jPLJYeshO8=2TaqXRmpOFuMQ92E9sg-oCh54fkqW7g@mail.gmail.com>
 <20230416151853.GK25053@google.com>
 <CAOUHufZk+dxE8UXWwGzGbX1BYxomD_25u2xoWt3vnoQp4xSZqw@mail.gmail.com>
 <20230417024446.GL25053@google.com>
 <CAOUHufYJtB0n314GnMH1ByXL5PTtzzsrMvi2YbHz2YVqTTcYfA@mail.gmail.com>
 <20230417035232.GM25053@google.com>
 <CAJD7tkZFufCacfu-EeqwhQBYXt8dpea1DYhyDgponjFjdLt5Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZFufCacfu-EeqwhQBYXt8dpea1DYhyDgponjFjdLt5Sw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/17 01:29), Yosry Ahmed wrote:
> > @@ -2239,8 +2241,8 @@ static unsigned long __zs_compact(struct zs_pool *pool,
> >                 if (fg == ZS_INUSE_RATIO_0) {
> >                         free_zspage(pool, class, src_zspage);
> >                         pages_freed += class->pages_per_zspage;
> > -                       src_zspage = NULL;
> >                 }
> > +               src_zspage = NULL;
> >
> >                 if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
> >                     || spin_is_contended(&pool->lock)) {
> 
> For my own education, how can this result in the "next is NULL" debug
> error Yu Zhao is seeing?
> 
> IIUC if we do not set src_zspage to NULL properly after putback, then
> we will attempt to putback again after the main loop in some cases.
> This can result in a zspage being present more than once in the
> per-class fullness list, right?
> 
> I am not sure how this can lead to "next is NULL", which sounds like a
> corrupted list_head, because the next ptr should never be NULL as far
> as I can tell. I feel like I am missing something.

That's a good question to which I don't have an answer. We can list_add()
the same zspage twice, unlocking the pool after first list_add() so that
another process (including another zs_compact()) can do something to that
zspage. The answer is somewhere between these lines, I guess.

I can see how, for example, another DEBUG_LIST check can be triggered:
"list_add double add", because we basically can do

	list_add(page, list)
	list_add(page, list)

I can also see how lockdep can be unhappy with us doing

	write_unlock(&zspage->lock);
	write_unlock(&zspage->lock);

But I don't think I see how "next is NULL" happens (I haven't observed
it).
