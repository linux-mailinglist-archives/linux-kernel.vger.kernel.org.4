Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB5972B959
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjFLH5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjFLH4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:56:40 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A761BEB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:55:53 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51669dd574aso1047650a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686556534; x=1689148534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8atXZoT1043zoF0AV+s/iPvTpj1b62bruyUjnsB0cvs=;
        b=CKt4pg+tCee9u06Ds+Fu+MbcN1s7jnkuZtumq+olB2GDUakEcf5SiYSXTmr9VGojbU
         nu3W3l6md4zR68lvux88+m2GISkwUrPMgpFEbS8Gtv8Ft8QHoTZtdHJuqmhMzqFGGW8L
         c8vEtrTIUG53exLIVKl6iKqCw8egrvquBH14er132jC4O95tmZCBSep+bqmpGZwebD2C
         U6mxQAycKMpJJieekbZt72NPuXBy/wvcN/nUJe1BGwOHJ7OWl3YGwfUAuC9t5Ta84Pto
         T00Bghv/cAId86bDiB6SZ0D0UDcvPuZaJEuPebildz/zeivRKtlhmo6amDIwdGdHrNGf
         8gFw==
X-Gm-Message-State: AC+VfDz97QnzPCcjy30NX3CA3eJPffKx8mc9ubMDs6zW0fAdlSJJpK7r
        vjvJz10QIFMfP5eFcZuxM+eAWwmAIJc=
X-Google-Smtp-Source: ACHHUZ7maAbmSth6MfGoaJGsA2c1PpprEyO0wMcPcFlkjZp1P6ViPI3nHS+BLQDEuXbQr9VIBU1b7Q==
X-Received: by 2002:a05:600c:3843:b0:3f7:1483:b229 with SMTP id s3-20020a05600c384300b003f71483b229mr6538633wmr.3.1686551814910;
        Sun, 11 Jun 2023 23:36:54 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b003f735ba7736sm10268780wmq.46.2023.06.11.23.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 23:36:54 -0700 (PDT)
Message-ID: <7a17d0f9-c624-2b30-476e-1a039f978c4e@grimberg.me>
Date:   Mon, 12 Jun 2023 09:36:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>, kbusch@kernel.org,
        axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1685350577.git.chunguang.xu@shopee.com>
 <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
 <CADtkEeeVWZ_b9mDWzwaq_5hdfZ53-RX2rd1SDDem=YsSBQ_g8A@mail.gmail.com>
 <ZIEnQpAgeqm0xcQP@ovpn-8-23.pek2.redhat.com>
 <febff498-63e6-efe2-2f5a-9a9fa7e767c0@grimberg.me>
 <ZIZ10UGQOJCWgjkX@ovpn-8-23.pek2.redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZIZ10UGQOJCWgjkX@ovpn-8-23.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> Hi Ming:
>>>>
>>>> Ming Lei <ming.lei@redhat.com> 于2023年6月6日周二 23:15写道：
>>>>>
>>>>> Hello Chunguang,
>>>>>
>>>>> On Mon, May 29, 2023 at 06:59:22PM +0800, brookxu.cn wrote:
>>>>>> From: Chunguang Xu <chunguang.xu@shopee.com>
>>>>>>
>>>>>> We found that nvme_remove_namespaces() may hang in flush_work(&ctrl->scan_work)
>>>>>> while removing ctrl. The root cause may due to the state of ctrl changed to
>>>>>> NVME_CTRL_DELETING while removing ctrl , which intterupt nvme_tcp_error_recovery_work()/
>>>>>> nvme_reset_ctrl_work()/nvme_tcp_reconnect_or_remove().  At this time, ctrl is
>>>>>
>>>>> I didn't dig into ctrl state check in these error handler yet, but error
>>>>> handling is supposed to provide forward progress for any controller state.
>>>>>
>>>>> Can you explain a bit how switching to DELETING interrupts the above
>>>>> error handling and breaks the forward progress guarantee?
>>>>
>>>> Here we freezed ctrl, if ctrl state has changed to DELETING or
>>>> DELETING_NIO(by nvme disconnect),  we will break up and lease ctrl
>>>> freeze, so nvme_remove_namespaces() hang.
>>>>
>>>> static void nvme_tcp_error_recovery_work(struct work_struct *work)
>>>> {
>>>>           ...
>>>>           if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
>>>>                   /* state change failure is ok if we started ctrl delete */
>>>>                   WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
>>>>                                ctrl->state != NVME_CTRL_DELETING_NOIO);
>>>>                   return;
>>>>           }
>>>>
>>>>           nvme_tcp_reconnect_or_remove(ctrl);
>>>> }
>>>>
>>>>
>>>> Another path, we will check ctrl state while reconnecting, if it changes to
>>>> DELETING or DELETING_NIO, we will break up and lease ctrl freeze and
>>>> queue quiescing (through reset path), as a result Hang occurs.
>>>>
>>>> static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>>>> {
>>>>           /* If we are resetting/deleting then do nothing */
>>>>           if (ctrl->state != NVME_CTRL_CONNECTING) {
>>>>                   WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
>>>>                           ctrl->state == NVME_CTRL_LIVE);
>>>>                   return;
>>>>           }
>>>>           ...
>>>> }
>>>>
>>>>>> freezed and queue is quiescing . Since scan_work may continue to issue IOs to
>>>>>> load partition table, make it blocked, and lead to nvme_tcp_error_recovery_work()
>>>>>> hang in flush_work(&ctrl->scan_work).
>>>>>>
>>>>>> After analyzation, we found that there are mainly two case:
>>>>>> 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() while it issue
>>>>>>      new IO to load partition table.
>>>>>
>>>>> Yeah, nvme freeze usage is fragile, and I suggested to move
>>>>> nvme_start_freeze() from nvme_tcp_teardown_io_queues to
>>>>> nvme_tcp_configure_io_queues(), such as the posted change on rdma:
>>>>>
>>>>> https://lore.kernel.org/linux-block/CAHj4cs-4gQHnp5aiekvJmb6o8qAcb6nLV61uOGFiisCzM49_dg@mail.gmail.com/T/#ma0d6bbfaa0c8c1be79738ff86a2fdcf7582e06b0
>>>>
>>>> While drive reconnecting, I think we should freeze ctrl or quiescing queue,
>>>> otherwise nvme_fail_nonready_command()may return BLK_STS_RESOURCE,
>>>> and the IOs may retry frequently. So I think we may better freeze ctrl
>>>> while entering
>>>> error_recovery/reconnect, but need to unfreeze it while exit.
>>>
>>> quiescing is always done in error handling, and freeze is actually
>>> not a must, and it is easier to cause race by calling freeze & unfreeze
>>> from different contexts.
>>>
>>> But yes, unquiesce should have been done after exiting error handling, or
>>> simply do it in nvme_unquiesce_io_queues().
>>>
>>> And the following patch should cover all these hangs:
>>>
>>
>> Ming, are you sending a formal patchset for this?
> 
> Not yet, will do it.

Would like it to get to the next pull request going out this week...

>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 3ec38e2b9173..83d3818fc60b 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -4692,6 +4692,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>>>    	 */
>>>    	nvme_mpath_clear_ctrl_paths(ctrl);
>>> +	/* unquiesce io queues so scan work won't hang */
>>> +	nvme_unquiesce_io_queues(ctrl);
>>
>> What guarantees that the queues won't be quiesced right after this
>> by the transport?
> 
> Please see nvme_change_ctrl_state(), if controller state is in
> DELETING, new NVME_CTRL_RESETTING/NVME_CTRL_CONNECTING can be entered
> any more.

Yes, this relies on the fact that nvme_remove_namespaces is only called
after DELETING state was set. ok.

>> I'm still unclear why this affects the scan_work?
> 
> As Chunguang mentioned, if error recover is terminated by nvme deletion,
> the controller can be kept in quiesced state, then in-queue IOs can'tu
> move on, meantime new error recovery can't be started successfully because
> controller state is NVME_CTRL_DELETING, so any pending IOs(include those
> from scan context) can't be completed.

Yes. please separate to individual patches when submitting though.
