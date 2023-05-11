Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C186FEEFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbjEKJgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbjEKJgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:36:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C95D8A4E
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:36:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683797792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0MlX4bO/xsxPE0sSg+a9U+jP9cGlaqB1yl1v5aiA+/E=;
        b=TTbWyGieMlEBBfbnkkY2EjapO14NeDqkq0x0sOHxK+4SkaEf9CTwaLgxc37OSO/YGqdnL4
        NdqPIWtt3FzESBpZZZi3JSVyEdOmqep77spuecl+uzVA62tKAzK3WZn/MKql+w/1H41ilH
        9axz1e4Pz8rhXM1DVP/coKZgThf6AT2m73CBHYD6PN/1iFOj5DxCm8aH1hJ4j98Yr4RNNV
        jTIzypG7lXD8Gxmf+buhXmD5sZFL51nkoVCL+5/3PvXqrHU5lJO2PWk/GWzyQmIuadvKHL
        QP/+KtnOlfmxt/VPks9SrKZEW77RGT9I53tUXGM2AXDrwNlyLDOKJ1NYklganQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683797792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0MlX4bO/xsxPE0sSg+a9U+jP9cGlaqB1yl1v5aiA+/E=;
        b=2hBMTzm/9BDA3Z81b8FkbaaU1N6TgJ2274PVQdsEibctklbW7+IwuVAriE+8iE2S51Co7A
        vkqTM4imuSxSBSCA==
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Andrey Vagin <avagin@openvz.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Emelyanov <xemul@openvz.org>
Subject: Re: [RFD] posix-timers: CRIU woes
In-Reply-To: <cc8aa6a4-a187-f3ad-fec9-05f037a3886d@virtuozzo.com>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx> <878rdy32ri.ffs@tglx>
 <87v8h126p2.ffs@tglx> <875y911xeg.ffs@tglx> <87ednpyyeo.ffs@tglx>
 <CANaxB-wV9iUT6=Y9nZCWbJhiscMrnAQh4fUXs7Tb8pr=-HwSYQ@mail.gmail.com>
 <cc8aa6a4-a187-f3ad-fec9-05f037a3886d@virtuozzo.com>
Date:   Thu, 11 May 2023 11:36:31 +0200
Message-ID: <87r0rnciqo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11 2023 at 11:17, Pavel Tikhomirov wrote:
> On 10.05.2023 16:16, Andrey Vagin wrote:
>>>
>>> So because of that half thought out user space ABI we are now up the
>>> regression creek without a paddle, unless CRIU can accomodate to a
>>> different restore mechanism to lift this restriction from the kernel.
>>>
>> If you give us a new API to create timers with specified id-s, we will
>> figure out how to live with it. It isn't good to ask users to update
>> CRIU to work on new kernels, but here are reasons and event improvements
>> for CRIU, so I think it's worth it.
>
> I agree, any API to create timers with specified id-s would work for new 
> CRIU versions.

The real question is whether this will cause any upheaval when a new
kernel meets a non-updated CRIU stack.

You know the UABI regression rules of the kernel...

Thanks,

        tglx

