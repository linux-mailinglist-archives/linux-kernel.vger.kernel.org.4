Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000435F9C80
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiJJKQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJJKQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:16:29 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC73046DB7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:16:27 -0700 (PDT)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29AAG8mP060376;
        Mon, 10 Oct 2022 19:16:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Mon, 10 Oct 2022 19:16:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29AAG8jG060372
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Oct 2022 19:16:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1d2cf65a-ddad-6aa1-ccaa-117c7167cac9@I-love.SAKURA.ne.jp>
Date:   Mon, 10 Oct 2022 19:16:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3] rapidio/tsi721: Replace flush_scheduled_work() with
 flush_work().
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>
References: <0e8a2023-7526-f03a-f520-efafbb0ef45c@I-love.SAKURA.ne.jp>
 <20220925102742.84ccc07ce1e8e591e4d5ce0f@linux-foundation.org>
 <d039cbbd-4aa7-58bf-b93d-be23443c52b6@I-love.SAKURA.ne.jp>
 <YzG/664Z5XqLD/yM@rowland.harvard.edu>
 <14c0f611-3f21-01b0-88d6-05eb1a3d8bc4@I-love.SAKURA.ne.jp>
In-Reply-To: <14c0f611-3f21-01b0-88d6-05eb1a3d8bc4@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/09/27 7:13, Tetsuo Handa wrote:
> On 2022/09/27 0:06, Alan Stern wrote:
>>> Alan Stern suggested to use cancel_work_sync() in
>>> commit eef6a7d5c2f38ada ("workqueue: warn about flush_scheduled_work()")
>>> and Tejun Heo suggested to use flush_work() in
>>> https://lkml.kernel.org/r/YjivtdkpY+reW0Gt@slm.duckdns.org .
>>>
>>> Is there some reason to prefer one over the other?
>>> I think that user-visible results between flush_work() and cancel_work_sync()
>>> are the same because both wait until work completes.
>>
>> No, you haven't got it quite right.  flush_work() waits until the work 
>> completes, but cancel_work_sync() first tries to cancel the work item.  
>> It then waits until the work item is either cancelled or completed.
> 
> I know there is a difference if the cancellation was successful.
> But unless cancel_work_sync() is called immediately after schedule_work(),
> that work likely (e.g. 99%+) already started running or already completed.
> 
>>
>> If the cancellation is successful (i.e., it happens before the work item 
>> starts to run) then the call will return at that time and the work item 
>> will never run -- hence it will never complete.
> 
> A difficult to judge thing is whether the owner/maintainer of that code wants
> that work completed or cancelled.
> Unlike e.g. https://lkml.kernel.org/r/Yy3byxFrfAfQL9xK@intel.com ,
> tsi721_remove() does not say whether pending works should run.
> 

It seems that Tejun is too busy to respond.

Although it is a bit worrisome that tsi721_db_dpc() unconditionally re-enables
IDB interrupts when tsi721_remove() wants to disable all device interrupts (I
don't know behavior/specification of tsi721 hardware), I think it is OK to go
with flush_work() (as with other patches which removed flush_scheduled_work()
usage) because flush_work() matches the behavior of flush_scheduled_work().

It is maintainer's responsibility to fix if re-enabling IDB interrupts is not safe,
using a trick explained in e.g. commit a91b750fd6629354 ("net: rds: don't hold sock
lock when cancelling work from rds_tcp_reset_callbacks()").

