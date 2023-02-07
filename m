Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9E668DEF2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjBGRbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBGRbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:31:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0590C1E9ED
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:30:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AD96B81A5F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F09C433D2;
        Tue,  7 Feb 2023 17:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675791048;
        bh=Wmit7s0XDZGseMoaHNMsaLbPp1g2aCFjJOI4HtoV9r0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FX9NFSxzBeZMRCk9dS74Q3QofjjPJl91Aw8tEiV2w2RzBlcaOxaPLoXVL6eIiaxrv
         riNlQdsFeWeqgZfbAF5ACuiQhvWIGnRHGF2PkdfW/eAkNdfq+zFW612eDB9Z5vXAh1
         3J48ymWHbEFUnmguNEVhxeBVsbN4S4LOcyhIcMj5aVNsgvfBy9hmeScktfXV3Lbz1v
         NdJnVkMx8KdsBF25DZgsv5wu9Po0aZVYDug9UVAbvKo/H9J9xbgq3RR15U9hzXHCjV
         8IIhuYtR0VtXakn2QtAM9DQMBOM7ISuV84ygTud/k5r7+k7CCflGUTZHrQjHknfLQ3
         PFaDF2TtD7waw==
Date:   Tue, 7 Feb 2023 09:30:45 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] objtool: reduce maximum memory usage
Message-ID: <20230207173045.ue77yxvp67p3hsrv@treble>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
 <20230129214339.76hyytrllggbvuat@t-8ch.de>
 <20230131000356.5u2siglndnjyarql@treble>
 <20230131035442.yzq4opasci7azt2j@t-8ch.de>
 <20230131172713.lhsunmdhww4kduwv@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131172713.lhsunmdhww4kduwv@treble>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 09:27:15AM -0800, Josh Poimboeuf wrote:
> On Tue, Jan 31, 2023 at 03:54:42AM +0000, Thomas Weißschuh wrote:
> > On Mon, Jan 30, 2023 at 04:03:56PM -0800, Josh Poimboeuf wrote:
> > > On Sun, Jan 29, 2023 at 09:43:39PM +0000, Thomas Weißschuh wrote:
> > > > On Tue, Dec 27, 2022 at 04:00:57PM +0000, Thomas Weißschuh wrote:
> > > > > The processing of vmlinux.o with objtool is the most memory-intensive step
> > > > > of a kernel build. By reducing the maximum memory usage here we can reduce
> > > > > the maximum memory usage of the whole kernel build.
> > > > > Therefore memory pressure on memory starved machines is relieved during
> > > > > kernel builds and the build is faster as less swapping has to occur.
> > > > 
> > > > Friendly ping.
> > > > 
> > > > These patches can also applied one by one, the only dependency is from
> > > > patch 5 to patch 4.
> > > 
> > > Thanks, I'll go ahead and take five of them now.
> > 
> > Thanks.
> > 
> > I have another half-finished series that replaces the doubly-linked
> > list_heads used by elf.h with a custom singly-linked list.
> > This would save a few pointers per struct.
> > 
> > Do you think this is worth it?
> 
> Maybe, depending on the memory savings.

FYI, there were more memory usage complaints, so Peter worked up a nice
series to do this and more:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=objtool/core

-- 
Josh
