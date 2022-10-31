Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07966133B6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiJaKgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJaKg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB22DFDD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667212521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q0efRchM9ZeGr72lQGrgRFLN0rbNent472GldOE/r0s=;
        b=Sg61PVdlM8Hww/+y1qX9CX+16o6HqVS7Q9GPVTTqe6EJU6J/M0k/JucHeruLvn7CrVzV7L
        5evOnJfXTqXZ/udkrkUn0tsNJr2JdrTbUA1+Q09JjdGxH+N+6HHD3zutLNA2Wvw+VEYzM8
        nuQCczJyXeAVU+K7Fs7E2mIk8TgNWcU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-317-VcYr-4oCP5mRWy8turxooA-1; Mon, 31 Oct 2022 06:35:20 -0400
X-MC-Unique: VcYr-4oCP5mRWy8turxooA-1
Received: by mail-qt1-f198.google.com with SMTP id 17-20020ac85711000000b0039ccd4c9a37so7435193qtw.20
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0efRchM9ZeGr72lQGrgRFLN0rbNent472GldOE/r0s=;
        b=uwJSe20fSfCfIAUh58OmFxhBYL4xLxgDbUEXT3k13GtQyu3vvfrKxzjctbgwhDAhKQ
         NduceN4dNR2ju8dLdM5eJ0QhycFS9j0+Kgr1F0EeHF6+IfCOru+qol6xLKUo6RD1fIyv
         sggfG7vTASoNp1dW7ICR7w5S8svFU/Cp5wXqC/dft1+Zjdltm5I8eBAqf8r/19FU3b5v
         ZRJRfEdV22vC2ZLbtlELuyjhw0ZLrS5AX6uPGGeLY4KDA6j4egE36ZoCvHzf6tS8GXsm
         dLQpItKSZ2DfSxukQzMrwBBs2kuFvAm+1QeTwxvbEArO0v76J0X3keWW0mydhZ1baYjF
         CInA==
X-Gm-Message-State: ACrzQf1kxJHNMFgE1PrQcndDRTHX1VbddU/EOnOQAdEqBDl/Q0q2cTba
        exFf7nhCVNxf1i6QiJfhcq5H8BQFObuYQC47n4BfklS9inSXzwwmZ5PLLRihwIpIw4/gT9SGIK5
        4ffsAJMXdelhG/HABVy/s16tj
X-Received: by 2002:a05:620a:1997:b0:6f7:13e7:3400 with SMTP id bm23-20020a05620a199700b006f713e73400mr8651492qkb.90.1667212520372;
        Mon, 31 Oct 2022 03:35:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6neCWdbtUxWXDEkSKwnFyg7rzcRCnDsXrcaOB1L6kptqWwEIYT1QxYzdlr0DRfv70KxNZh5Q==
X-Received: by 2002:a05:620a:1997:b0:6f7:13e7:3400 with SMTP id bm23-20020a05620a199700b006f713e73400mr8651474qkb.90.1667212520185;
        Mon, 31 Oct 2022 03:35:20 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id l10-20020a37f90a000000b006b9c9b7db8bsm4454268qkj.82.2022.10.31.03.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 03:35:19 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Ruipeng Qi <qiruipeng@lixiang.com>, mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        ruipengqi7@gmail.com, Ruipeng Qi <qiruipeng@lixiang.com>
Subject: Re: [PATCH] sched/fair: Change mode of period_timer to
 HRTIMER_MODE_ABS_PINNED_HARD
In-Reply-To: <20221020091742.2962-1-qiruipeng@lixiang.com>
References: <20221020091742.2962-1-qiruipeng@lixiang.com>
Date:   Mon, 31 Oct 2022 10:35:17 +0000
Message-ID: <xhsmhcza8waai.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/22 17:17, Ruipeng Qi wrote:
> Previous mode of period_timer is HRTIMER_MODE_ABS_PINNED,which means
> timer callback function will be executed in soft irq context.
>
> When one task group runs out of quota in a period,but holding lock of
> softirq_ctrl,the task will be rescheduled later,and then a system stall
> occurs:
>  - next period comes,
>  - __do_softirq can't acquire lock of softirq_ctrl,
>  - __do_softirq will not be invoked,
>  - callback of period_timer will not be invoked,
>  - task group will not get any quota in any new period.
>  - a system stall occurs.
>
> Changing mode of period_timer to HRTIMER_MODE_ABS_PINNED_HARD,which mean
> timer callback function executed in hard irq context fix this problem.
>

What you want here is some form of PI between the task doing the timer
soft expiry and the one holding the softirq_ctrl.lock. This doesn't happen
ATM because of should_wake_ksoftirqd() - if the lock is held then we won't
wake ksoftirqd, so we won't get a PI.

If you look at the RT stack, this commit gives you that:
c1d68f0da449 ("softirq: Use a dedicated thread for timer wakeups.")
(from linux-6.1.y-rt-rebase)

