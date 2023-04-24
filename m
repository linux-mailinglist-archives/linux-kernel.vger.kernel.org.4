Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF42A6EC7D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjDXIZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXIZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:25:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A855E68
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00AAA612BE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C91DC433EF;
        Mon, 24 Apr 2023 08:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682324700;
        bh=wahJLGCz8Bnc65p1CGkD+QO9uiDS+OKs7I3XjdFSkCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvU0XbXG6BVYRHvo7RsTVk1wlXJ3HWyeE4iueTCKb8m6t7R/ImPOubXDT0YTqzR3I
         ta2AahQW1ApoZdcHUrW2zQmVJsh90sbxOKMsF3GateURBZ4kbFecf7tf0sUjWlBzYb
         gE0KHdK3H80cf+XEkg8+G2l3ZrYel6kvv7UvqYvr2+Ze43yurL/RgH5ir34Ctvjyt1
         rOj0jyjREhWZfhxEJmb8j69ml/I13xy3i8fT7JA52GU6ryIElfLMdOXnZsBblAU5+Z
         3IasPqBUfd5oRTBMy0CaqgW+v3rDEE2FX7hlnn7oGPM+8L0g6K6rXfz363ho7p6Yyd
         kRCQUqgqBDoRA==
Date:   Mon, 24 Apr 2023 10:24:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mark Fasheh <mark@fasheh.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>,
        Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ocfs2: reduce ioctl stack usage
Message-ID: <20230424-handtaschen-armut-91885793ecf1@brauner>
References: <20230417205631.1956027-1-arnd@kernel.org>
 <20230418-fortgehen-inkubationszeit-5d3db3f0c2b1@brauner>
 <7555eaf9-b195-5189-3928-c7292e4a0ba5@linux.alibaba.com>
 <20230418-vielmehr-nominieren-7f2adb0f6703@brauner>
 <d1e719ea-95bf-bb96-62db-e550cefe0a80@linux.alibaba.com>
 <20230419142159.fd5ca2e91658fe304e317a72@linux-foundation.org>
 <20230420-wetten-aneignen-8324959e629d@brauner>
 <CAGe7X7mLU0JOftGVA+NHabu-9a=fuaofy+KhpvCJFnkRz5ANtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGe7X7mLU0JOftGVA+NHabu-9a=fuaofy+KhpvCJFnkRz5ANtQ@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 10:01:12AM -0700, Mark Fasheh wrote:
> On Thu, Apr 20, 2023 at 2:34 AM Christian Brauner <brauner@kernel.org> wrote:
> > I think I might not have communicated as clearly as I should have.
> > Simply because I naively assumed that this is unproblematic.
> >
> > By "we" I mean people responsible for "fs/" which now happens to also
> > include me. So the goal of this is for patches falling under fs/ to get
> > picked up more quickly and broadly and share the maintenance burden.
> 
> Did you get buy-in from other folks in 'fs/'? What other projects are
> you carrying? Granted I'm a bit out of the loop these days but this is
> the first I'm hearing of this.
> 
> Andrew has a well oiled machine going, so if he's still ok carrying
> the patches then that's where I'd like them until such time that you
> can provide a tangible benefit.

A patch is sent for something that falls under the fs/ directory. In
this case fs/ocfs2/. The maintainer's of fs/ocfs2/ provide their acks.

A maintainer - In this case my sorry ass - of fs/ looks into the
maintainer's file to make sure that someone will pick up those patches
by looking for a tree entry under the respective fs/ocfs2/ entry.

There is no tree entry.

So the patch is picked up by a respective maintainer of fs/ to ensure
that fixes land in mainline.

So, if you have a tree that you think fs/ocfs2/ belongs to then please
send a patch to add the respective tree into the maintainer's file.

This is especially true when fs/ stuff surprisingly goes via mm/. I
don't want to have to guess what tree you're going through even if it's
been going on for a long time.

There are no bad intentions here but please clarify the ocfs2 entry in
the maintainer's file.
