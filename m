Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B480D5BAF2C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiIPOWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiIPOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:21:52 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFC1B0B10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:21:50 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28GELhZs076041;
        Fri, 16 Sep 2022 23:21:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Fri, 16 Sep 2022 23:21:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28GELhNs076038
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 16 Sep 2022 23:21:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ce9a2543-84eb-a7e3-c6f2-636d378d9d68@I-love.SAKURA.ne.jp>
Date:   Fri, 16 Sep 2022 23:21:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 (REPOST)] rapidio/tsi721: Replace
 flush_scheduled_work() with flush_work().
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <8347375e-29fd-cd45-2b07-5504c9ddbd0c@I-love.SAKURA.ne.jp>
 <20220814171422.49b14550b9f3f3794166316e@linux-foundation.org>
 <410a1a56-2f14-5cee-e5ce-61afe516b8fc@I-love.SAKURA.ne.jp>
In-Reply-To: <410a1a56-2f14-5cee-e5ce-61afe516b8fc@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matt and Alexandre, what can I do on this patch?

On 2022/08/15 18:47, Tetsuo Handa wrote:
> On 2022/08/15 9:14, Andrew Morton wrote:
>> On Thu, 28 Jul 2022 10:02:13 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>>
>>> Since "struct tsi721_device" is per a device struct, I assume that
>>> tsi721_remove() needs to wait for only two works associated with that
>>> device. Therefore, wait for only these works using flush_work().
>>
>> The changelog provides no reason for making this change.  Correctness?
>> Efficiency?
> 
> For reducing locking dependency chains that might lead to deadlock.
> 
> The reason was explained in commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
> using a macro"). For example, after the fact it turned out that a blind conversion patch
> fixed a deadlock problem at https://syzkaller.appspot.com/bug?extid=2d6ac90723742279e101
> which was hidden due to use of lockdep_set_novalidate_class() call.
> 
> Many of flush_scheduled_work() callers have been removed by v6.0-rc1, but not all
> patches were verbose (because the reason was already explained).
> 
>   a1124c84d467 power: supply: ab8500: Remove flush_scheduled_work() call.
>   162b05524ed3 rtc: Replace flush_scheduled_work() with flush_work().
>   31a1e4a5c104 platform/surface: avoid flush_scheduled_work() usage
>   90c3ca3f247d scsi: mpt3sas: Remove flush_scheduled_work() call
>   62ebaf2f9261 ath6kl: avoid flush_scheduled_work() usage
>   76faa32077b0 iio: light: tsl2563: Replace flush_scheduled_work() with cancel_delayed_work_sync().
>   4bbdc208a5ff staging: olpc_dcon: Replace flush_scheduled_work() with flush_work().
>   c4f135d64382 workqueue: Wrap flush_workqueue() using a macro
>   9cf62d91e4b7 RDMA/mlx4: Avoid flush_scheduled_work() usage
>   549f39a58acf IB/isert: Avoid flush_scheduled_work() usage
>   1b3ce51dde36 Input: psmouse-smbus - avoid flush_scheduled_work() usage
>   0a2f4b5785ca crypto: atmel - Avoid flush_scheduled_work() usage
>   eeff214dbfcb wfx: avoid flush_workqueue(system_highpri_wq) usage
>   0b8d7622ab18 aoe: Avoid flush_scheduled_work() usage
>   cc271ab86606 wwan_hwsim: Avoid flush_scheduled_work() usage
>   ff815a89398d RDMA/core: Avoid flush_workqueue(system_unbound_wq) usage
> 
> There are 7 callers remaining as of v6.0-rc1, and I'm pinging them for heads up.
> 
>   drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>   drivers/gpu/drm/i915/display/intel_display.c
>   drivers/gpu/drm/i915/gt/selftest_execlists.c
>   drivers/md/dm.c
>   drivers/message/fusion/mptscsih.c
>   drivers/rapidio/devices/tsi721.c
>   drivers/scsi/qla2xxx/qla_target.c
> 
> If you want to update patch description, you can insert the following.
> 
> ----------------------------------------
> 
> Like commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue() using a
> macro") says, flush_scheduled_work() is dangerous and will be forbidden.
> We are on the way for removing all flush_scheduled_work() callers from
> the kernel, and this patch is for removing flush_scheduled_work() call
>  from tsi721 driver.
> 

