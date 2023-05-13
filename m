Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64A57015CC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbjEMJdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237424AbjEMJdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:33:20 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEB9BB
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:33:18 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34D9XG3D066105;
        Sat, 13 May 2023 18:33:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Sat, 13 May 2023 18:33:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34D9XFro066099
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 13 May 2023 18:33:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <aaff0a39-3dd1-5efb-bb7b-c2c241ac9c06@I-love.SAKURA.ne.jp>
Date:   Sat, 13 May 2023 18:33:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] debugobject: don't wake up kswapd from fill_pool()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <000000000000008ddb05fb5e2576@google.com>
 <6577e1fa-b6ee-f2be-2414-a2b51b1c5e30@I-love.SAKURA.ne.jp>
 <20230511204458.819f9009d2ef8b46cc163191@linux-foundation.org>
 <d642e597-cf7d-b410-16ce-22dff483fd8e@I-love.SAKURA.ne.jp>
 <87v8gxbthf.ffs@tglx>
 <39c79d27-73ea-06a8-62fe-2b64d0fd8db5@I-love.SAKURA.ne.jp>
 <87bkipbeyr.ffs@tglx>
 <61d7ac52-3352-b7cd-8908-890a29a007d9@I-love.SAKURA.ne.jp>
 <87lehsaavo.ffs@tglx>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87lehsaavo.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/05/13 17:33, Thomas Gleixner wrote:
> Now I just stared at __alloc_pages_slowpath() and looked at the
> condition for wakeup_all_kswapds(). ALLOC_KSWAPD is set because
> debugobject uses GFP_ATOMIC which contains __GFP_KSWAPD_RECLAIM.
> 
> So debug objects needs to have s/GFP_ATOMIC/__GFP_HIGH/ to prevent that
> wakeup path.

Yes. That is exactly what my patch does.

