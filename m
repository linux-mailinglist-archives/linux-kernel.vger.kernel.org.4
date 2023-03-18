Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD7F6BFB60
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCRP7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRP66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:58:58 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Mar 2023 08:58:57 PDT
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA6DB440
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 08:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=UoJYitD5hhTMteTIVterFTcXdepPYFO2InWaB6RVd9w=; b=IXs/168u3/Tn+WHV2QDrFH9ZDx
        VlWgq4vV4n2aID9LE30PCUwKIhhe9FIZL2r1lnSGiN6HE/gd25hB2LmeBvYyKGhdjimxDLmlYoRkE
        3riBQWyvAfXQsMe3HJWGk4xfXVBympFip4Ce9t5nAnsBRMsLeA5q1hiD7kIakNr9TXOsTbNbU8z/s
        aXjVAJNgcC9HwSQkW0MgZ1htJT6UC63/UEwdy4V4ligIcyeGE8KMh0WZKUQkWsndnvBnsY/pvSwnM
        OlI317BXP7u2u7ADAqkI1ljLLkthgdxsb0I/5zaePzVWvSItEZdlmRZrcpB+Ak2xMeJmZZ/5QtIzD
        SXTfhCKA==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1pdXn4-000647-Om; Sat, 18 Mar 2023 14:44:14 +0000
Date:   Sat, 18 Mar 2023 14:44:14 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, acme@kernel.org,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: NMI reason 2d when running perf
Message-ID: <ZBXOPvIqybwtihJY@gallifrey>
References: <25fccb43-8338-a690-0009-384dc0640169@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <25fccb43-8338-a690-0009-384dc0640169@kernel.dk>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-21-amd64 (x86_64)
X-Uptime: 14:42:53 up 5 days, 23:05,  1 user,  load average: 0.02, 0.04, 0.01
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jens Axboe (axboe@kernel.dk) wrote:
> Hi,
> 
> When running perf on my Dell R7525 on a running process, I get a ton of:
> 
> [  504.234782] Dazed and confused, but trying to continue
> [  504.267843] Uhhuh. NMI received for unknown reason 2d on CPU 48.
> [  504.267846] Dazed and confused, but trying to continue
> [  504.335975] Uhhuh. NMI received for unknown reason 2d on CPU 48.
> [  504.335977] Dazed and confused, but trying to continue
> [  504.368031] Uhhuh. NMI received for unknown reason 2d on CPU 48.
> [  504.368033] Dazed and confused, but trying to continue
> [  504.371037] Uhhuh. NMI received for unknown reason 2d on CPU 48.
> [  504.371038] Dazed and confused, but trying to continue
> [  504.439165] Uhhuh. NMI received for unknown reason 2d on CPU 48.
> [  504.439167] Dazed and confused, but trying to continue
> 
> spew in dmesg. The box has 2x7763 CPUS. This seems to be a recent
> regression, been using this box for a while and haven't seen this
> before. The test being traced is pinned to CPU 48. The box is currently
> running:

I'm not sure this is new; I've seen this intermittently on AMD boxes
for a few years. Always when running perf or related tools.

Dave

> commit 6015b1aca1a233379625385feb01dd014aca60b5 (origin/master, origin/HEAD)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Tue Mar 14 19:32:38 2023 -0700
> 
>     sched_getaffinity: don't assume 'cpumask_size()' is fully initialized
> 
> with the pending block/io_uring branches merged in for testing.
> 
> -- 
> Jens Axboe
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
