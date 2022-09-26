Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E745EA60C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbiIZM2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbiIZM13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:27:29 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88050B07CE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:07:32 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28QASd5K098275;
        Mon, 26 Sep 2022 19:28:39 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Mon, 26 Sep 2022 19:28:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28QAScvj098265
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 26 Sep 2022 19:28:39 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d039cbbd-4aa7-58bf-b93d-be23443c52b6@I-love.SAKURA.ne.jp>
Date:   Mon, 26 Sep 2022 19:28:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3] rapidio/tsi721: Replace flush_scheduled_work() with
 flush_work().
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>, Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <0e8a2023-7526-f03a-f520-efafbb0ef45c@I-love.SAKURA.ne.jp>
 <20220925102742.84ccc07ce1e8e591e4d5ce0f@linux-foundation.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220925102742.84ccc07ce1e8e591e4d5ce0f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/09/26 2:27, Andrew Morton wrote:
> On Sat, 24 Sep 2022 14:11:25 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> 
>> Like commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue() using a
>> macro") says, flush_scheduled_work() is dangerous and will be forbidden.
>> We are on the way for removing all flush_scheduled_work() callers from
>> the kernel, and this patch is for removing flush_scheduled_work() call
>>  from tsi721 driver.
>>
>> Since "struct tsi721_device" is per a device struct, I assume that
>> tsi721_remove() needs to wait for only two works associated with that
>> device. Therefore, wait for only these works using flush_work().
>>
>> --- a/drivers/rapidio/devices/tsi721.c
>> +++ b/drivers/rapidio/devices/tsi721.c
>> @@ -2941,7 +2941,8 @@ static void tsi721_remove(struct pci_dev *pdev)
>>  
>>  	tsi721_disable_ints(priv);
>>  	tsi721_free_irq(priv);
>> -	flush_scheduled_work();
>> +	flush_work(&priv->idb_work);
>> +	flush_work(&priv->pw_work);
>>  	rio_unregister_mport(&priv->mport);
> 
> Why not use cancel_work[_sync](), as the flush_scheduled_work() comment
> recommends?
> 

Alan Stern suggested to use cancel_work_sync() in
commit eef6a7d5c2f38ada ("workqueue: warn about flush_scheduled_work()")
and Tejun Heo suggested to use flush_work() in
https://lkml.kernel.org/r/YjivtdkpY+reW0Gt@slm.duckdns.org .

Is there some reason to prefer one over the other?
I think that user-visible results between flush_work() and cancel_work_sync()
are the same because both wait until work completes.

