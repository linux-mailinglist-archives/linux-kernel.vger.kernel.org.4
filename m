Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B096292D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiKOH7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiKOH7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:59:35 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E851B495
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:59:34 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id h193so12558953pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DdOHxmLLhGQ2JS9VW3BK8nUHmYD6rCy1tiLuitS/qc8=;
        b=VyVL1Bz+AZz4KIISx7l8OK+u+Ne9T1mg0PrhTLKUq57AoS4ltny4XHyWDRP3srrYg7
         7+LrXDAXXa/jJY17NUc5skWgpLqYxy/9dcfQHAyZ7oCojp92eWJ+IXXaHyLw9euzjgcQ
         B6NRNt+i2c3fkrwebxYTbTRmh6NxZLpK/Hoho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdOHxmLLhGQ2JS9VW3BK8nUHmYD6rCy1tiLuitS/qc8=;
        b=k7ekit3FcqkasOUE/2QYKRcN3BgHVRV6pkKfkbucn4GpBYH1NtLxjPouFXpHPvNWqZ
         T2Azm+5x7lC03H6Lp8sVdiwqLRB6VJDRLATalh3Pwu+GoA1iE9ZbArsQImusWRpXwpP9
         Nu87gXsv4Uizev6NzsASRo+ywQ1qU8y8DwD+c6PUMbRnfvE6M8emD8R2lnExxOzCOPON
         A4sVZWqShZbe6jteDLuVN+MZlg5X+alznS72LAS3MteNWoeYAy00kO+a5lhka/LEd7HD
         Rzt0xaMWV5l/bzFhVa084GIqTZKa2Llj+agX5IuvfStfzwCJJBPnk+aYHmZnHjtOJuw6
         Z6yA==
X-Gm-Message-State: ANoB5pkru1Cw3PfRKACryyTc5MisLhhcVgLAyzdAeQ0VIFA5fxTvPr3e
        L01TGH0a+f+VKIqO80W0oxPo+VYrN2F7NA==
X-Google-Smtp-Source: AA0mqf7W2F5p+UWpTOghIiQlnL/OofJ/jf5ouCPUJe19FXfixiaZSfa48cupX1iJVLSdfMhoD67Tbg==
X-Received: by 2002:a05:6a00:b49:b0:562:bcf8:7b35 with SMTP id p9-20020a056a000b4900b00562bcf87b35mr17603263pfo.52.1668499174008;
        Mon, 14 Nov 2022 23:59:34 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:3d10:c2ca:ba5b:55e6])
        by smtp.gmail.com with ESMTPSA id i187-20020a6287c4000000b0056262811c5fsm8052909pfe.59.2022.11.14.23.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 23:59:33 -0800 (PST)
Date:   Tue, 15 Nov 2022 16:59:29 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 0/9] zsmalloc/zram: configurable zspage size
Message-ID: <Y3NG4fsjxHGrnbDp@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <Y21+xp52OQYi/qjQ@google.com>
 <Y22dxEcs2g5mjuQ7@google.com>
 <Y26AbHxhPBJdWZQE@google.com>
 <Y3MrHsaLc8wth00E@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3MrHsaLc8wth00E@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/15 15:01), Sergey Senozhatsky wrote:
> On (22/11/11 09:03), Minchan Kim wrote:
> [..]
> > for class in classes:
> >     wasted_bytes += class->pages_per_zspage * PAGE_SIZE - an object size
> > 
> > with *aggressive zpage compaction*. Now, we are relying on shrinker
> > (it might be already enough) to trigger but we could change the policy 
> > wasted memory in the class size crossed a threshold
> 
> Compaction does something good only when we can release zspage in the
> end. Otherwise we just hold the global pool->lock (assuming that we
> land zsmalloc writeback series) and simply move objects around zspages.
> So ability to limit zspage chain size still can be valuable, on another
> level, as a measure to reduce dependency on compaction success.
> 
> We may be can make compaction slightly more successful. For instance,
> if we would start move objects not only within zspages of the same size
> class, but, for example, move objects to class size + X (upper size
> classes). As an example, when all zspages in class are almost full,
> but class size + 1 has almost empty pages. In other words sort of as
> is those classes had been merged. (virtual merge). Single pool->look
> would be handy for it.

What I'm trying to say here is that "aggressiveness of compaction"
probably should be measured not by compaction frequency, but by overall
cost of compaction operations.

Aggressive frequency of compaction doesn't help us much if the state of
the pool doesn't change significantly between compactions. E.g. if we do
10 compaction calls, then only the first one potentially compacts some
zspages, the remaining ones don't do anything.

Cost of compaction operations is a measure of how hard compaction tries.
Does it move object to neighbouring classes and so on? May be we can do
something here.

But then the question is - how do we control that we don't drain battery
too fast? And perhaps some other questions too.
