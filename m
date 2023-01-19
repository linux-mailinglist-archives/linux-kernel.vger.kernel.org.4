Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0676667443D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjASVXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjASVV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:21:58 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB307573A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:39 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 7so2617826pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dn0RxgJYP1pitjWvcBOPBfKv5qYbiPXZSo6iw3wnry0=;
        b=Al9hymxXhxF7ur0o9zHC14v0xsnNor6d5ON4fVWgTZLVzNEtoxRSShdRLBC3FKTOce
         HH0NgP5wRufWSrV3BOXwT3yt0hWiSLHUa6qfWpPzBKjtMR5L/6IqP56KvnTME/DqZsny
         R1YMRlfP6OPHytgUr9vkhK/4z68D30VpVjn/lwXFSm4565vGF7STbBi2K2hZiMH+MCqc
         qniJkF+npnPnjO9GuBDlejCeCSk7S5gtt4nhrv/Wy2RyXcOabkTKYJ7B41qSHtg+L+Fg
         7PMCv9PJxkzDOM4o+0HfOsLgCmc/aNzTxIBSqdU0ty6o8xTbm8GGUuRglcYR8RuhmhfQ
         T+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dn0RxgJYP1pitjWvcBOPBfKv5qYbiPXZSo6iw3wnry0=;
        b=30WKxbuqbX+j8kwHBjBZTBeXanJi6c6Nvlgw29/y9DDRoUx2FZItPaypjjZwryBybn
         tl5P7jUPL5zGR4DZNe/n5aejNoh8X9D22ixq0YwbwZd59uB2z7W+9Qllf5kxXxllcACQ
         3crTdlCBI12PvB2vlq2fiAKtKrK2BTz7G9rTX1h9WHkSsEI7xVmXgaUE7POdIvVUc6ea
         qpul48LK1zD18L06l26qzKenUXnR3w2ShqB5KwkMmOhL31Nnd2gFIOuccjw8YiVa2Yim
         0P9QEex/yh+fkF1dT7xDV8DXqHGhd0eAhtPlQMQT57vp5434pj7eBFrtfWxAb2dQwlnn
         gDZg==
X-Gm-Message-State: AFqh2ko5P87I6BAyYrWigu7WuGpxGKcCuqC1bfpfA0krgaFH4E7R26Ct
        C+Gw02hR21ISodwz2Fcq2NM=
X-Google-Smtp-Source: AMrXdXt4aSGxahYuSSuEq0wJQiJOWsmN0KqhITVx1Srh/6G99K5C5pnC5Mn7h6YWcXiC2nY1LQnNUQ==
X-Received: by 2002:aa7:8084:0:b0:58d:e0ee:ede7 with SMTP id v4-20020aa78084000000b0058de0eeede7mr8269731pff.14.1674162939326;
        Thu, 19 Jan 2023 13:15:39 -0800 (PST)
Received: from google.com ([2620:15c:211:201:3bcd:b3d1:c859:f6e2])
        by smtp.gmail.com with ESMTPSA id f127-20020a623885000000b00588cb819473sm20129473pfa.39.2023.01.19.13.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:15:38 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 19 Jan 2023 13:15:36 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 1/3] mm: return the number of pages successfully paged out
Message-ID: <Y8my+BOtiD7w16My@google.com>
References: <20230117231632.2734737-1-minchan@kernel.org>
 <Y8e3lHsYoWjFWbRU@dhcp22.suse.cz>
 <Y8gn0KQDWC/5CZ/w@google.com>
 <Y8gt5Gb7DPaEI2uN@dhcp22.suse.cz>
 <Y8g1VWkdSwt5SUVo@google.com>
 <Y8hjNm+kB8WquUH6@dhcp22.suse.cz>
 <Y8hyS3yVnxXTsFIz@google.com>
 <Y8kIS+nx2/nBfKei@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8kIS+nx2/nBfKei@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:07:23AM +0100, Michal Hocko wrote:
> On Wed 18-01-23 14:27:23, Minchan Kim wrote:
> [...]
> > Let me know if you have other concern or suggestion.
> 
> I would propose to use a tracepoint to track this on the madvise side.
> This way you can both track a per-process effectivity as well a madvise
> originator effectivity (if the policy is implemented by a global monitor
> then it won't get interfering activity by other users of this
> interface). Global counters cannot do neither of that.

I don't think the tracepoint is right approach for the purpose.

I understand we could get the same result using tracepoint using bpf or
something so whenever event happens, a daemon get the result and
accumlate the number so totally same result with global stat. Yeah,
technically it's doable. With the claim, there is nothing we can do
with tracpoint. Checks existing vmstat fields, why do we have them
into vmstat instead of tracepoint? TP is much easiler/fleixible but
with vmstat, we can get the ballpark under fleet easier to sense
what's going on simply, and once we found something weird, we could
turn on the trace to know the detail and TP would work for it.

With process control using process_madvise in centralized controlled
system, I think those two stats are really worth along with other
memory reclaim statistics to be captured for memory health. If we
have needs per-process level tracking(Actually, not for our case),
we could add the tracepoint later.
