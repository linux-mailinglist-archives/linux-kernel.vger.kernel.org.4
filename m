Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B2766AAC6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjANJxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjANJxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:53:21 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A557A83
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:53:19 -0800 (PST)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 30E9rHhX010636;
        Sat, 14 Jan 2023 18:53:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Sat, 14 Jan 2023 18:53:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.20] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 30E9rHHu010632
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 14 Jan 2023 18:53:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e68b4c88-a278-90d0-0ce0-9d4e161366cc@I-love.SAKURA.ne.jp>
Date:   Sat, 14 Jan 2023 18:53:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 (repost)] locking/lockdep: add
 debug_show_all_lock_holders()
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <41f43b27-d910-78e0-c0b3-f2885fe1cd22@I-love.SAKURA.ne.jp>
 <Y8J3gAXLf4yc0FcL@gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y8J3gAXLf4yc0FcL@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/14 18:36, Ingo Molnar wrote:
> Yeah, so note how you introduce a function with a parameter:
> 
> 	void __debug_show_all_locks(bool show_stack)
> 
> ... only to then *hide* the new parameter via helper functions:
> 
> 	static inline void debug_show_all_locks(void)
> 	{
> 		__debug_show_all_locks(false);
> 	}
> 
> 	static inline void debug_show_all_lock_holders(void)
> 	{
> 		__debug_show_all_locks(true);
> 	}
> 
> ... which is a *strong* hint by our universe that the new parameter was 
> probably a bad idea to begin with.
> 
> Given how small debug_show_all_locks() is to begin with, I'd suggest simply 
> duplicating the loop into debug_show_all_lock_holders() or so.

Initial version at https://lkml.kernel.org/r/82af40cc-bf85-2b53-b8f9-dfc12e66a781@I-love.SAKURA.ne.jp
was duplicating the loop.

Waiman Long suggested me not to duplicate the loop at
https://lkml.kernel.org/r/3e027453-fda4-3891-3ec3-5623f1525e56@redhat.com .

Please talk with Waiman. I'm fine with either approach.

