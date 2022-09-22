Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98C75E585C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiIVCGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiIVCGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:06:38 -0400
Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com [47.90.199.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478AC98D1F;
        Wed, 21 Sep 2022 19:06:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQQI7Fc_1663812392;
Received: from 30.97.56.134(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQQI7Fc_1663812392)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 10:06:33 +0800
Message-ID: <8b595d99-9d77-dcbe-4d1a-14bbb12b912b@linux.alibaba.com>
Date:   Thu, 22 Sep 2022 10:06:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V4 5/8] ublk_drv: consider recovery feature in aborting
 mechanism
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20220921095849.84988-1-ZiyangZhang@linux.alibaba.com>
 <20220921095849.84988-6-ZiyangZhang@linux.alibaba.com>
 <Yyup5vt32fULKIJu@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <Yyup5vt32fULKIJu@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/22 08:18, Ming Lei wrote:
> On Wed, Sep 21, 2022 at 05:58:46PM +0800, ZiyangZhang wrote:
>> With USER_RECOVERY feature enabled, the monitor_work schedules
>> quiesce_work after finding a dying ubq_daemon. The monitor_work
>> should also abort all rqs issued to userspace before the ubq_daemon is
>> dying. The quiesce_work's job is to:
>> (1) quiesce request queue.
>> (2) check if there is any INFLIGHT rq. If so, we retry until all these
>>     rqs are requeued and become IDLE. These rqs should be requeued by
>> 	ublk_queue_rq(), task work, io_uring fallback wq or monitor_work.
>> (3) complete all ioucmds by calling io_uring_cmd_done(). We are safe to
>>     do so because no ioucmd can be referenced now.
>> (5) set ub's state to UBLK_S_DEV_QUIESCED, which means we are ready for
>>     recovery. This state is exposed to userspace by GET_DEV_INFO.
>>
>> The driver can always handle STOP_DEV and cleanup everything no matter
>> ub's state is LIVE or QUIESCED. After ub's state is UBLK_S_DEV_QUIESCED,
>> user can recover with new process.
>>
>> Note: we do not change the default behavior with reocvery feature
>> disabled. monitor_work still schedules stop_work and abort inflight
>> rqs. And finally ublk_device is released.
>>
>> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> 
> This version is close to be ready, just some debug logging needs
> be removed, see inline comment. Also I'd suggest you to learn to
> use bpftrace a bit, then basically you needn't to rely on kernel
> logging.
> 
> If these logging is removed, you will see how simple the patch becomes
> compared with previous version.

Current version is simpler, thanks for reviewing, Ming.
Debug logging will be removed in V5 and I will send it out soon.

Regards,
Zhang
