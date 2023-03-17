Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18CA6BDE35
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 02:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCQBiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 21:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCQBin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 21:38:43 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE95BBDFD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 18:38:39 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id h34so2416773uag.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 18:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679017119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gZiMCDMIqB6OVa8oI0SbxOaqsvPFfiDjO4dIGyuTuIg=;
        b=ypwhZFcEyECXNJLrPmBrQBRxwV+y3VDSUZRidDldPrMlkddN8UY8Sd09RHpaiqdiJL
         T7ZnlEx7oQHOvemcAeJimox6CqBwQt5mA6I5dl4zxVDLl84vlluYmnsW3XrJAq59rLmm
         WEPR9GDZf3CMjIEeQ1ImdBuXtn3KtyXxGhGeEnmEZS0j2sqwdmlAlzOwUzK6i/XefAY5
         7Y1tBOyhxN8wEoGSg6Y+f7V7aOput026rhrRVSliNNxcqNUPXZI8t7s/BGDZ4fpJznF2
         a4wY+SXlfzZfwhEPy83h/v6w/SWGnfBLCXxitQ0B/IYAlEUQxW78axaN7PPFkDGCimfx
         W+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679017119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZiMCDMIqB6OVa8oI0SbxOaqsvPFfiDjO4dIGyuTuIg=;
        b=lU3CgJFqb3eEQFIV37GKrZV66/72hhKF3JwOGMCTxm6uboTO/FqeHn89QBmvaOV00v
         jrDK9ywhwBGbH5eO/Kxnz4nF+p45Wrz7r5/lpQ6zKVV8nha09PGQ97mS6QHtEQuu9XT9
         WXGubfU+/N+mwDvmNOAlxfZeb82E5zo2wa5YwXWYtDSovtipyLnNq+0kqXbXdhnOZLHU
         q6lZdxY8XBKFuVwhL6a6ulTnkAMWYbHJSnD0ef63YwJ2dgy9MZDjFd2ImZ1k31ZZuGp1
         sgqpu7fkNfGgYLJlzlIVhF9ClqkNv2KSrzDyquF8Zg75G4hTr70/fT+B8AOY7+B4CHiX
         0v8A==
X-Gm-Message-State: AO0yUKVNtYaYgZ9qxpX60AEzexP+aYdCORGd9e0f9rwoLPjGVJHkbQAS
        ZGAOExcUsGL8mubTS1wbF7p4LjN1CdeZNKHLuk0uAQ==
X-Google-Smtp-Source: AK7set+/q/KOu9X2oqklAu82mx0ZTERuPycsI3lxx4LB0u576R4uCrwSrRzaoqbLzoyXIBsLOflo4MZ1GqF/8zksvhU=
X-Received: by 2002:a1f:b292:0:b0:42d:18f9:d0b6 with SMTP id
 b140-20020a1fb292000000b0042d18f9d0b6mr18388753vkf.2.1679017118886; Thu, 16
 Mar 2023 18:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230314230004.961993-1-alexey.klimov@linaro.org> <c98a3741-273b-8a69-016d-5f3e79f8a71e@acm.org>
In-Reply-To: <c98a3741-273b-8a69-016d-5f3e79f8a71e@acm.org>
From:   Alexey Klimov <alexey.klimov@linaro.org>
Date:   Fri, 17 Mar 2023 01:38:27 +0000
Message-ID: <CANgGJDqhimVZ7Pfes0sT8S2VHo_gTLBYkGFNcfbT5CV5VJz51Q@mail.gmail.com>
Subject: Re: [REGRESSION] CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait()
 and slow-stuck reboots
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     peterz@infradead.org, draszik@google.com, peter.griffin@linaro.org,
        willmcvicker@google.com, mingo@kernel.org, ulf.hansson@linaro.org,
        tony@atomide.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        alim.akhtar@samsung.com, regressions@lists.linux.dev,
        avri.altman@wdc.com, klimova@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 at 23:21, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 3/14/23 16:00, Alexey Klimov wrote:
> > The delay is found to be in device's ->shutdown() methods called from kernel_restart():
> > void kernel_restart_prepare(char *cmd)
> > {
> >       blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
> >       system_state = SYSTEM_RESTART;
> >       usermodehelper_disable();
> >       device_shutdown();      <---- here

[..]

>
> Please let me know if you want me to resubmit patch "scsi: ufs: Remove
> the LUN quiescing code from ufshcd_wl_shutdown()"
> (https://lore.kernel.org/linux-scsi/20220331223424.1054715-14-bvanassche@acm.org/).

This indeed works and helps to reduce reboot time. Thanks!
If you decide to resubmit, feel free to ping me to test it.
However I have no knowledge how comments from Adrian can be addressed.

With that patch the reboot time decreases from 60-100 seconds to
~10-20 seconds. The next
"slow" thing is wlan driver which callback is called from
blocking_notifier_call_chain(&reboot_notifier_list, ...) but obviously
it is not a part of ufs code.

Best regards,
Alexey
