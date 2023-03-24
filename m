Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A532B6C82AC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjCXQzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjCXQzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:55:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BB212D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 518B262A3E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EF5C433D2;
        Fri, 24 Mar 2023 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679676943;
        bh=ZEbjlpAh2WrqUnDW5ZNWKy6ydvQ8KRSfEkJ24vJOxjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ffCp+pIcMsdyYgAbrBCxSn401DJbItZ+VxxFzMHcsXi2VWGOLY2bX/srw/reGOTFQ
         HqDM7b+qO2peo1iRH5gMoLIP79B6AGdrgv++ql4AAaOLvY43id26vhJQxmiQ5e0y9D
         HgLFg8NzMx3WDInKRPa8Pi52ceDBvoD8ian5IzW9zFBjjIKIuaAIgO29qphc08J9FK
         ioqq+J4QaKTZWQsgSxZWYBLajFvYL6lhDnBXUom+gcB5jvj/d+dq2CBdUCrQlYdxE4
         NkMaM+xSythvSS17VvfO/pYobKS/b8MftiyS1DXAKaJUHFJhZwBvauOIfNZmn1KB4H
         1iRgbhZ0SFQaQ==
Date:   Fri, 24 Mar 2023 09:55:42 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     "Colin King (gmail)" <colin.i.king@gmail.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: f2fs: factor out discard_cmd usage from general rb_tree use
Message-ID: <ZB3WDpunfgJZhhQy@google.com>
References: <e50ebe1a-73a0-5800-71e3-0ddd366727ac@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e50ebe1a-73a0-5800-71e3-0ddd366727ac@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24, Colin King (gmail) wrote:
> Hi,
> 
> static analysis with clang scan build has detected a potential issue
> introduced by the following commit:
> 
> commit 7e9775a516ff6c1e73ee2b42ec563cafee38f42f
> Author: Jaegeuk Kim <jaegeuk@kernel.org>
> Date:   Fri Mar 10 11:12:35 2023 -0800
> 
> f2fs: factor out discard_cmd usage from general rb_tree use

Good catch!
I found the bug and will post v2 soon.

> 
> 
> The warning is as follows:
> 
> fs/f2fs/segment.c:1425:4: warning: Value stored to 'tdc' is never read
> [deadcode.DeadStores]
> 
> The while loop in function __update_discard_tree_range is as follows (+ my
> annotations):
> 
> 
>         while (1) {
>                 struct rb_node *node;
>                 struct discard_cmd *tdc = NULL;
> 
> ### tdc is set to NULL
> 
>                 if (prev_dc) {
>                         di.lstart = prev_dc->di.lstart + prev_dc->di.len;
>                         if (di.lstart < lstart)
>                                 di.lstart = lstart;
>                         if (di.lstart >= end)
>                                 break;
> 
>                         if (!next_dc || next_dc->di.lstart > end)
>                                 di.len = end - di.lstart;
>                         else
>                                 di.len = next_dc->di.lstart - di.lstart;
>                         di.start = start + di.lstart - lstart;
>                 }
> 
>                 if (!di.len)
>                         goto next;
> 
>                 if (prev_dc && prev_dc->state == D_PREP &&
>                         prev_dc->bdev == bdev &&
>                         __is_discard_back_mergeable(&di, &prev_dc->di,
> 
> max_discard_blocks)) {
>                         prev_dc->di.len += di.len;
>                         dcc->undiscard_blks += di.len;
>                         __relocate_discard_cmd(dcc, prev_dc);
>                         di = prev_dc->di;
>                         tdc = prev_dc;
> 
> ### tdc is set to prev_dc, however, it is not not read any more with th
> introduction of the "goto next"" statement introduced in the commit
> mentioned earlier
> 
>                         goto next;
>                 }
> 
>                 if (next_dc && next_dc->state == D_PREP &&
>                         next_dc->bdev == bdev &&
>                         __is_discard_front_mergeable(&di, &next_dc->di,
> 
> max_discard_blocks)) {
>                         next_dc->di.lstart = di.lstart;
>                         next_dc->di.len += di.len;
>                         next_dc->di.start = di.start;
>                         dcc->undiscard_blks += di.len;
>                         __relocate_discard_cmd(dcc, next_dc);
> 
> ### tdc is always NULL, there is no path to this code where tdc is ever set
> to a non-NULL value.
> 
>                         if (tdc)
>                                 __remove_discard_cmd(sbi, tdc);
>                         goto next;
>                 }
> 
>                 __insert_discard_cmd(sbi, bdev, di.lstart, di.start,
> di.len);
>  next:
>                 prev_dc = next_dc;
>                 if (!prev_dc)
>                         break;
> 
>                 node = rb_next(&prev_dc->rb_node);
>                 next_dc = rb_entry_safe(node, struct discard_cmd, rb_node);
>         }
> 
