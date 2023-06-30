Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E592743C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjF3NHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjF3NHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:07:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2D4E6A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 06:07:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688130438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j91/nF/TAtkgDhiwgLLKVItWTovmcF2c3HrZwokhsSA=;
        b=aYAGYNYpmmwN4K7BMvslpndDJW+uXfah720i49QjPMQZXzTjUmyVMgrbKj7wlcLCzdAFa/
        qlIvw21V9/i0zi4oFa2GpUQE2fCPrCgBT7C4uH7C1U0GMvj+Xd7hQpBOv+jYrHRUTP7YFY
        22SYmlYJiNVkcgbEq23N3RDcXRRfWG3bTNihuZDV+WIOm1H/jaQ+gdu2NV7JCK/VKBCLy+
        0NGKm5ESsvlM1LYW1h1CVst/Cimv7g/FtaDnWJBvB6KvM3j+ByK3xfLr+dNXFz9MPdJ7R+
        l1rtxYcrh3fhx2puneOyGLcL0h0db8Q9JxAW6XKsSMC8f/0AoOCAGCnfUEoAsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688130438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j91/nF/TAtkgDhiwgLLKVItWTovmcF2c3HrZwokhsSA=;
        b=6vr/4y85cJ0n6Wmu5PtlyffGAZmQPZtgrumXUfykp0OkSdn7MIeYQRJPLSd9aQ4rqQVgTw
        G3Eq+6LMWT/gCTCA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 14/45] posix-timers: Consolidate interval retrieval
In-Reply-To: <ZJ67nQ6Q8F3mu6Jb@lothringen>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.816970056@linutronix.de>
 <ZJww66Svi84Bvw9Z@localhost.localdomain> <87ttuq14xp.ffs@tglx>
 <ZJ67nQ6Q8F3mu6Jb@lothringen>
Date:   Fri, 30 Jun 2023 15:07:17 +0200
Message-ID: <875y75yu7u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30 2023 at 13:25, Frederic Weisbecker wrote:
> On Thu, Jun 29, 2023 at 08:47:30PM +0200, Thomas Gleixner wrote:
>> On Wed, Jun 28 2023 at 15:08, Frederic Weisbecker wrote:
>>=20
>> > Le Tue, Jun 06, 2023 at 04:37:40PM +0200, Thomas Gleixner a =C3=A9crit=
 :
>> >> There is no point to collect the current interval in the posix clock
>> >> specific settime() and gettime() callbacks. Just do it right in the c=
ommon
>> >> code.
>> >>=20
>> >> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> >
>> > The only difference I see is that we now return the old interval
>> > even if the target is reaped, which probably doesn't matter anyway.
>>=20
>> But we don't return it to user space because ret !=3D 0 in that case.
>
> In the case of ->set yes but in the case of ->get there is no error
> handling.

SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
		struct __kernel_itimerspec __user *, setting)
{
	struct itimerspec64 cur_setting;

	int ret =3D do_timer_gettime(timer_id, &cur_setting);
	if (!ret) {
		if (put_itimerspec64(&cur_setting, setting))

How exactly does this end up being copied to user space if ret !=3D 0?

Thanks,

        tglx
