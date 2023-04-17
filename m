Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3551F6E4672
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjDQL3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjDQL3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:29:30 -0400
Received: from outbound-smtp51.blacknight.com (outbound-smtp51.blacknight.com [46.22.136.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1E4272A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:28:36 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp51.blacknight.com (Postfix) with ESMTPS id 2B1A6FA943
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:13:54 +0100 (IST)
Received: (qmail 19061 invoked from network); 17 Apr 2023 11:13:54 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Apr 2023 11:13:54 -0000
Date:   Mon, 17 Apr 2023 12:13:52 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Wen Yang <wenyang.linux@foxmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        William Lam <william.lam@bytedance.com>,
        Fu Wei <wefu@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: compaction: optimize compact_memory to comply with
 the admin-guide
Message-ID: <20230417111352.v26slrcmz4qo3tnn@techsingularity.net>
References: <tencent_FD958236269FD3A7996FFCF29E9BAA4EA809@qq.com>
 <20230411134801.a4aadef5aba0f51e0d44bb7a@linux-foundation.org>
 <tencent_C3E900CCD37EF2CF49553BD4AC4120932B08@qq.com>
 <tencent_100BD2639951FD669FA1AA40A89983202709@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_100BD2639951FD669FA1AA40A89983202709@qq.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 01:42:44AM +0800, Wen Yang wrote:
> 
> ??? 2023/4/13 00:54, Wen Yang ??????:
> > 
> > ??? 2023/4/12 04:48, Andrew Morton ??????:
> > > On Wed, 12 Apr 2023 02:24:26 +0800 wenyang.linux@foxmail.com wrote:
> > > 
> > > > For the /proc/sys/vm/compact_memory file, the admin-guide states:
> > > > When 1 is written to the file, all zones are compacted such that free
> > > > memory is available in contiguous blocks where possible. This can be
> > > > important for example in the allocation of huge pages although
> > > > processes
> > > > will also directly compact memory as required
> > > > 
> > > > But it was not strictly followed, writing any value would cause all
> > > > zones to be compacted. In some critical scenarios, some applications
> > > > operating it, such as echo 0, have caused serious problems.
> > > Really?  You mean someone actually did this and didn't observe the
> > > effect during their testing?
> > 
> > Thanks for your reply.
> > 
> > Since /proc/sys/vm/compact_memory has been well documented for over a
> > decade:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/admin-guide/sysctl/vm.rst#n109
> > 
> > 
> > it is believed that only writing 1 will trigger trigger all zones to be
> > compacted.
> > 
> > Especially for those who write applications, they may only focus on
> > documentation and generally do not read kernel code.  Moreover, such
> > problems are not easily detected through testing on low pressure
> > machines.
> > 
> > Writing any meaningful or meaningless values will trigger it and affect
> > the entire server:
> > 
> > # echo 1 > /proc/sys/vm/compact_memory
> > # echo 0 > /proc/sys/vm/compact_memory
> > # echo dead > /proc/sys/vm/compact_memory
> > # echo "hello world" > /proc/sys/vm/compact_memory
> > 
> > The implementation of this high-risk operation may require following the
> > admin-guides.
> > 
> > -- 
> > 
> > Best wishes,
> > 
> > Wen
> > 
> > 
> Hello, do you think it's better to optimize the sysctl_compaction_handler
> code or update the admin-guide document?
> 

Enforce the 1 on the unlikely chance that the sysctl handler is ever
extended to do something different and expects a bitmask. The original
intent intent of the sysctl was debugging -- demonstrating a contiguous
allocation failure when aggressive compaction should have succeeded. Later
some machines dedicated to batch jobs used the compaction sysctl to compact
memory before a new job started to reduce startup latencies.

Drop the justification "In some critical scenarios, some applications
operating it, such as echo 0, have caused serious problems." from the
changelog. I cannot imagine a sane "critical scenario" where an application
running as root is writing expected garbage to proc or sysfs files and
then surprised when something unexpected happens.

-- 
Mel Gorman
SUSE Labs
