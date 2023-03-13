Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5976B860A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCMXZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCMXZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:25:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7127E637C6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 16:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6BF9B815E0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189B7C433EF;
        Mon, 13 Mar 2023 23:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678749937;
        bh=WbrDrJpuTnnSk2w8RT6EI2i+T6ZvKGJ5P2Ykj7gxCug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sE/RBzw1R7lgXqBjPYW7/1uSGPN+8TNZyaXrjgKgk/qAo7gW8j4teZ3UxIEWgKjIN
         gjxFD9Zi74eXzS10I7r626NuI4JjX52x/7yfrJ4fedyOf1+QeBw865+ubx8JxrTRCa
         lCZ9RRWHVpHGvl2SfM9UwdD4hyjT26Fspcyr+aiXmLWztdIJxfvO9g7zU3DcpESU9q
         YRpZxxho3UhQebaY7ZBEYXmlUaCANRZ3fOqQgiThxF5c/V8x6HCaqgBCoOdFc7UFCL
         7nG7qIy/N9oq0tG15z7FYSY8R7xJrtRnyOgQBYMNhV82dvM1XHNjzBn19t18kUh6o6
         qkG7FOQIEKiLQ==
Date:   Tue, 14 Mar 2023 00:25:33 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.3-rc2
Message-ID: <ZA+w7d3RqGN/hAoM@localhost.localdomain>
References: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
 <d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net>
 <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
 <ZA+ttVOPBvNOYHoC@lothringen>
 <CAHk-=whwQxk12jfe28DV4-1-d9np1hKFtTy-ua=F4EcT8jcOOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whwQxk12jfe28DV4-1-d9np1hKFtTy-ua=F4EcT8jcOOA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Mar 13, 2023 at 04:17:06PM -0700, Linus Torvalds a écrit :
> On Mon, Mar 13, 2023 at 4:11 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > So the hardirq interrupted some code that has softirqs disabled (or
> > servicing) from the preempt mask POV but not from lockdep POV.
> 
> .. but those are two different counters, so isn't that *always* racy?
> IOW, one counter being updated before the other...
> 
> IOW, isn't this *why* that check isn't supposed to ever trigger at all
> from hard-irq context?

Right but these two values are always modified within the same IRQs
disabled section.
