Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BEF5EB469
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiIZWQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiIZWQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:16:24 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139781A22F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:16:05 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28QME1Pq063652;
        Tue, 27 Sep 2022 07:14:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Tue, 27 Sep 2022 07:14:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28QME0k9063649
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 27 Sep 2022 07:14:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <14c0f611-3f21-01b0-88d6-05eb1a3d8bc4@I-love.SAKURA.ne.jp>
Date:   Tue, 27 Sep 2022 07:13:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3] rapidio/tsi721: Replace flush_scheduled_work() with
 flush_work().
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <0e8a2023-7526-f03a-f520-efafbb0ef45c@I-love.SAKURA.ne.jp>
 <20220925102742.84ccc07ce1e8e591e4d5ce0f@linux-foundation.org>
 <d039cbbd-4aa7-58bf-b93d-be23443c52b6@I-love.SAKURA.ne.jp>
 <YzG/664Z5XqLD/yM@rowland.harvard.edu>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YzG/664Z5XqLD/yM@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/09/27 0:06, Alan Stern wrote:
>> Alan Stern suggested to use cancel_work_sync() in
>> commit eef6a7d5c2f38ada ("workqueue: warn about flush_scheduled_work()")
>> and Tejun Heo suggested to use flush_work() in
>> https://lkml.kernel.org/r/YjivtdkpY+reW0Gt@slm.duckdns.org .
>>
>> Is there some reason to prefer one over the other?
>> I think that user-visible results between flush_work() and cancel_work_sync()
>> are the same because both wait until work completes.
> 
> No, you haven't got it quite right.  flush_work() waits until the work 
> completes, but cancel_work_sync() first tries to cancel the work item.  
> It then waits until the work item is either cancelled or completed.

I know there is a difference if the cancellation was successful.
But unless cancel_work_sync() is called immediately after schedule_work(),
that work likely (e.g. 99%+) already started running or already completed.

> 
> If the cancellation is successful (i.e., it happens before the work item 
> starts to run) then the call will return at that time and the work item 
> will never run -- hence it will never complete.

A difficult to judge thing is whether the owner/maintainer of that code wants
that work completed or cancelled.
Unlike e.g. https://lkml.kernel.org/r/Yy3byxFrfAfQL9xK@intel.com ,
tsi721_remove() does not say whether pending works should run.

