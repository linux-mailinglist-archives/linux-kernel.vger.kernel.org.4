Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A5468AAF0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 16:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjBDPaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 10:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjBDPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 10:30:17 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC02925E31;
        Sat,  4 Feb 2023 07:30:16 -0800 (PST)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 314FU8ut021268;
        Sun, 5 Feb 2023 00:30:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sun, 05 Feb 2023 00:30:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 314FU7oc021265
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 5 Feb 2023 00:30:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e89ad942-cab6-fad1-1cc2-98885d829ea7@I-love.SAKURA.ne.jp>
Date:   Sun, 5 Feb 2023 00:30:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Converting dev->mutex into dev->spinlock ?
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
 <Y951z0Au9MlP1GxX@rowland.harvard.edu>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y951z0Au9MlP1GxX@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/05 0:12, Alan Stern wrote:
>>  it would solve many deadlocks in driver code if you can update
> 
> What deadlocks?  If there are so many deadlocks floating around in 
> driver code, why haven't we heard about them before now?

Since dev->mutex is hidden from lockdep checks, nobody can see lockdep warnings.
syzbot is reporting real deadlocks without lockdep warnings, for the fundamental
problem you mentioned in https://lkml.kernel.org/r/Pine.LNX.4.44L0.0804171117450.18040-100000@iolanthe.rowland.org
is remaining. I'm suggesting you that now is time to address this fundamental problem.

>> (by e.g. replacing dev->mutex with dev->spinlock and dev->atomic_flags).
>> But I'm not familiar enough to propose such change...
> 
> Such a change cannot be made.  Consider this: Driver callbacks often
> need to sleep.  But when a thread holds a spinlock, it is not allowed to 
> sleep.  Therefore driver callbacks must not be invoked while a spinlock 
> is held.

What I'm suggesting is "Do not call driver callbacks with dev->mutex held,
by rewriting driver core code".

