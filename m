Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C8D73C730
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFXGyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFXGyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:54:15 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FB32710
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:54:14 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 35O6sCnm092696;
        Sat, 24 Jun 2023 15:54:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Sat, 24 Jun 2023 15:54:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 35O6sCG8092693
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 24 Jun 2023 15:54:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
Date:   Sat, 24 Jun 2023 15:54:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.co>, Will Deacon <will@kernel.org>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-2-bigeasy@linutronix.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230623171232.892937-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/06/24 2:12, Sebastian Andrzej Siewior wrote:
>  include/linux/seqlock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 3926e90279477..d778af83c8f36 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -512,8 +512,8 @@ do {									\
>  
>  static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
>  {
> -	do_raw_write_seqcount_begin(s);
>  	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
> +	do_raw_write_seqcount_begin(s);
>  }
>  
>  /**

Why not to do the same on the end side?

 static inline void do_write_seqcount_end(seqcount_t *s)
 {
- 	seqcount_release(&s->dep_map, _RET_IP_);
 	do_raw_write_seqcount_end(s);
+	seqcount_release(&s->dep_map, _RET_IP_);
 }

