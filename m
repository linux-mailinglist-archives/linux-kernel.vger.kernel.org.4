Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211E962EACF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbiKRBSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKRBSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:18:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49727EAA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:18:00 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668734278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OaUPbO6earlu9AsWr0Xwr8fyZn4kNeWtkN90s6Cvozw=;
        b=1v5eUZlIpmig19ckA5SJqANcOKrmCm2/exEzINHFwrbH3sUPmo9qtvAuSeu1GSuqGCK4Po
        meEIFhfFMMgnn0RV5eXFo2/YsCUG7mzZCcOR+0RNSgGFF9u/6EhtmGCGyCH28MhDSgA8eC
        O3sQqIq/IldNBHWkWPYcLETdTJHc1RAN9QiV+TCkx/hTdIS3Pcl4zC0rHAjouHNBCS7Ts9
        HZJ+M3jfBsnwn7cyY8ebFeBWwkxM+Mj+8mp7eY5S+MgcLtz9Hv+qHXe+kLEGPKid+UgIRt
        oNsT203gSsH2KgC0zHnT0dR9xwXDkWK2eRJc8DLHD4wdBNTGsf2/IBqmPzlDBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668734278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OaUPbO6earlu9AsWr0Xwr8fyZn4kNeWtkN90s6Cvozw=;
        b=Goj9ENaJOb6eZoB+ccPrZjC6xLaOeSHc0GkH7PN3v0NwXBzsVnY7LdniMtXDUb4OV7h1I/
        DB+hl0IGnvCP29Dw==
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+6fb78d577e89e69602f9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Steven Rostedt <rosted@goodmis.org>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [syzbot] WARNING in call_timer_fn
In-Reply-To: <d38fe3c3-1f0b-b5f6-2895-aee9476b20bf@I-love.SAKURA.ne.jp>
References: <0000000000009d5daa05ed9815fa@google.com>
 <20221117024511.3606-1-hdanton@sina.com>
 <20221117125523.3783-1-hdanton@sina.com> <87wn7tlg4n.ffs@tglx>
 <CABBYNZKnCyLkRKH=DFZbDSL=m0O5PUVkQjtiB0xpCZM7v78HmQ@mail.gmail.com>
 <CABBYNZJYbzX9xoqU8_KEArTJ2=5eMTiDTjMbNjEYNVmi1rkp+A@mail.gmail.com>
 <d38fe3c3-1f0b-b5f6-2895-aee9476b20bf@I-love.SAKURA.ne.jp>
Date:   Fri, 18 Nov 2022 02:17:58 +0100
Message-ID: <875yfdkqm1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18 2022 at 09:53, Tetsuo Handa wrote:
> On 2022/11/18 6:16, Luiz Augusto von Dentz wrote:
> The comment for drain_workqueue() says
>
>  * Wait until the workqueue becomes empty.  While draining is in progress,
>  * only chain queueing is allowed.  IOW, only currently pending or running
>  * work items on @wq can queue further work items on it.  @wq is flushed
>  * repeatedly until it becomes empty.  The number of flushing is determined
>  * by the depth of chaining and should be relatively short.  Whine if it
>  * takes too long.
>
> but why limited to "only currently pending or running work items on @wq" (that is,
> only process context) ?
>
> Although drain_workqueue() is also called from destroy_workqueue() (which would cause
> use-after-free bug if interrupt handler calls queue_work() some time after drain_workqueue()),
> I think that we can wait for drain_workqueue() to call __flush_workqueue() again if a further
> work item is queued from interrupt handler...

Which is correct because at that point it's expecting to only accept the
pending and chained pending work otherwise it will go on in circles and/or
just be unable to provide the functionality of draining work, right?

> Anyway, stopping all works and delayed works before calling
> drain_workqueue() would address this problem.

Only partially.

You also have to make sure that none of the works can be rearmed or
rescheduled after that point by any other context, e.g interrupts ...

Thanks,

        tglx
