Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E5A639A91
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiK0Mkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiK0Mkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:40:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C95B263B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:40:31 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669552828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EB/53VcoNSyoAbWn3SJg3+Ux/MQhVRpr/mqLNU0o7js=;
        b=tG6JfF9GryBdY5R1ayDhFW5nVcj8BNhfdr0APEKiJba1hQz6qIiOe5efb58RfrjIUOwt5+
        RugHbJd3u8HkXb/ai/VxhC6/hCxeh3ST002BnKf/61ZC1YlVr+luurAddWDJpKonqY08u5
        G6wDSaoK8gzLbH05rJK7EnLlO4ZPF1zQrBKPTpnJRVnmy5BInef7LZ89XaXIae7ktv+2GN
        9gK9TF4uM5I+E3SgXO0k5zWyqsAOu+ZeTn2arHQiEEUtqXSz9QY6QgQf68GZuEJanLslt2
        zYmML/fl0TgfyLMdkAslGLznJWKaAl50FVGekChjqc6HJ/3z1yOLZQdy/OaK0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669552828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EB/53VcoNSyoAbWn3SJg3+Ux/MQhVRpr/mqLNU0o7js=;
        b=/rsDEyIP1zkZFV+paA9RKRugWWLeuR7RpzdUbBmFNIrfaI1E7mu2cmLePwxTvbwFW0vLz8
        cV9QL3HaPKBt0RDA==
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     fweisbec@gmail.com, mingo@kernel.org, dave@stgolabs.net,
        paulmck@kernel.org, josh@joshtriplett.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next][RFC]torture: avoid offline tick_do_timer_cpu
In-Reply-To: <CAABZP2xNTbrx9iV+KH3VZx1c9Yi97+izNA=XSJQBuOJ4WENFZg@mail.gmail.com>
References: <20221121035140.118651-1-zhouzhouyi@gmail.com>
 <87y1rxwsse.ffs@tglx>
 <CAABZP2xNTbrx9iV+KH3VZx1c9Yi97+izNA=XSJQBuOJ4WENFZg@mail.gmail.com>
Date:   Sun, 27 Nov 2022 13:40:28 +0100
Message-ID: <87v8n0woxv.ffs@tglx>
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

Zhouyi,

On Sun, Nov 27 2022 at 10:45, Zhouyi Zhou wrote:
> On Sun, Nov 27, 2022 at 1:05 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> So, I should construct my patch as:
> We avoid ... by ...

Not "We avoid".

Avoid this behaviour by ....

>> No. We are not exporting this just to make a bogus test case happy.
>>
>> Fix the torture code to handle -EBUSY correctly.
> I am going to do a study on this, for now, I do a grep in the kernel tree:
> find . -name "*.c"|xargs grep cpuhp_setup_state|wc -l
> The result of the grep command shows that there are 268
> cpuhp_setup_state* cases.
> which may make our task more complicated.

Why? The whole point of this torture thing is to stress the
infrastructure.

There are quite some reasons why a CPU-hotplug or a hot-unplug operation
can fail, which is not a fatal problem, really.

So if a CPU hotplug operation fails, then why can't the torture test
just move on and validate that the system still behaves correctly?

That gives us more coverage than just testing the good case and giving
up when something unexpected happens.

I even argue that the torture test should inject random failures into
the hotplug state machine to achieve extended code coverage.

Thanks,

        tglx



