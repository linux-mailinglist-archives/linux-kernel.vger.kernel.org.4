Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F75715AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjE3JyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjE3Jxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:53:51 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5D5D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:53:18 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34U9qmfQ063315;
        Tue, 30 May 2023 18:52:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Tue, 30 May 2023 18:52:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34U9pX72063087
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 May 2023 18:51:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c17ff3ff-b3af-fea2-f75e-68cefbc90636@I-love.SAKURA.ne.jp>
Date:   Tue, 30 May 2023 18:51:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] ref_tracker: add stack_depot_save() failure handling to
 ref_tracker_alloc()
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
References: <5fa8dfeb-8eb6-0de0-a335-e0b4336c29e0@I-love.SAKURA.ne.jp>
 <20230529190526.65d13658@kernel.org>
 <CANn89iLpeeJN=QA80c1wZZ0TB+ptzKN_Hq4Cf27C-URvKKbd2Q@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CANn89iLpeeJN=QA80c1wZZ0TB+ptzKN_Hq4Cf27C-URvKKbd2Q@mail.gmail.com>
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

On 2023/05/30 16:22, Eric Dumazet wrote:
>>> Therefore, assume that stack_depot_save(GFP_KERNEL | __GFP_NOFAIL) from
>>> ref_tracker_alloc() can silently fail, and emit "unreliable refcount
>>> tracker." message.
>
> Note: I never assumed stack_depot_save() would enforce/use NOFAIL.

Hmm, I misread this function.

	if (gfp & __GFP_DIRECT_RECLAIM)
		gfp_mask |= __GFP_NOFAIL; // Or'ing to "gfp_mask" than "gfp".
	*trackerp = tracker = kzalloc(sizeof(*tracker), gfp_mask); // <= This is "gfp_mask".
	tracker->alloc_stack_handle = stack_depot_save(entries, nr_entries, gfp); // <= This is "gfp".

So, stack_depot_save(GFP_KERNEL | __GFP_NOFAIL) is not happening.

Then, question becomes whether we want tracker->alloc_stack_handle != NULL or not.
If tracker->alloc_stack_handle == NULL is still useful, this patch will be useless...

