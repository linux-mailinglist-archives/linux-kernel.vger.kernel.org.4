Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493D16AA637
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 01:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjCDA2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 19:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCDA2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:28:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF47D234D1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 16:28:19 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677889698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/FC/UQmlqseWhfDNlw3KINn/RGKWtZAvczLpBONhlE=;
        b=pqYwVhy7BgbDiw1L0yaduE3wKzUCMDsN3ZNX3OjSCcDgTdWF1FlK/m8o2fTWyWQAfh7Ezm
        JmKQDTxwomWXlxGtTY4iOR0Z1O/Vr7abL6htP88+P19OOVP/87b1IjD6V2PYnfFhTTncqV
        j0w5GRujKdtB78+LM4TweRIlk9grUx4KrNNP0h/uviy7M8461abD4ARDbJbjrbSmdrFg29
        1alYcODBvyvRn3xNXOFegwZWuDSe1LpzHFGidrAStEwc7vGdYJyNo0W1hIXGUQbO3+/hrs
        i3IkKQYOc45z1t/8izAOVRRkN4QBvma7YhzejbAhO3esQuYGaUE3s1xdSw7PHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677889698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/FC/UQmlqseWhfDNlw3KINn/RGKWtZAvczLpBONhlE=;
        b=LgbePq1cFz/NWvRrP+tUOrjS9F3eJuadoBjO97vw6SoMX4FQw5ca5VrX6vzH2/u5WuA4TI
        36dFZMkmqrgGDIBA==
To:     David Woodhouse <dwmw2@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Subject: Re: IRQ affinity not working on Xen pci-platform device
In-Reply-To: <1060e7786498f384634b01c335bf7bf43365e1fe.camel@infradead.org>
References: <07866eaf6354dd43d87cffb6eebf101716845b66.camel@infradead.org>
 <87fsalkcck.ffs@tglx>
 <1060e7786498f384634b01c335bf7bf43365e1fe.camel@infradead.org>
Date:   Sat, 04 Mar 2023 01:28:17 +0100
Message-ID: <87356ljr6m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David!

On Fri, Mar 03 2023 at 16:54, David Woodhouse wrote:
> On Fri, 2023-03-03 at 17:51 +0100, Thomas Gleixner wrote:
>> >=20
>> > [=C2=A0=C2=A0=C2=A0 0.577173] ACPI: \_SB_.LNKC: Enabled at IRQ 11
>> > [=C2=A0=C2=A0=C2=A0 0.578149] The affinity mask was 0-3
>> > [=C2=A0=C2=A0=C2=A0 0.579081] The affinity mask is 0-3 and the handler=
 is on 2
>> > [=C2=A0=C2=A0=C2=A0 0.580288] The affinity mask is 0 and the handler i=
s on 2
>>=20
>> What happens is that once the interrupt is requested, the affinity
>> setting is deferred to the first interrupt. See the marvelous dance in
>> arch/x86/kernel/apic/msi.c::msi_set_affinity().
>>=20
>> If you do the setting before request_irq() then the startup will assign
>> it to the target mask right away.
>>=20
>> Btw, you are using irq_get_affinity_mask(), which gives you the desired
>> target mask. irq_get_effective_affinity_mask() gives you the real one.
>>=20
>> Can you verify that the thing moves over after the first interrupt or is
>> that too late already?
>
> It doesn't seem to move. The hack to just return IRQ_NONE if invoked on
> CPU !=3D 0 was intended to do just that. It's a level-triggered interrupt
> so when the handler does nothing on the "wrong" CPU, it ought to get
> invoked again on the *correct* CPU and actually=C2=A0work that time.

So much for the theory. This is virt after all so it does not
necessarily behave like real hardware.

> But no, as the above logs show, it gets invoked twice *both* on CPU2.

Duh. I missed that. Can you instrument whether this ends up in in the
actual irq affinity setter function of the underlying irq chip at all?

> If I do the setting before request_irq() then it should assign it right
> away (unless that IRQ was already in use?

Correct.

> It's theoretically a shared PCI INTx line). But even then, that would
> mean I'm messing with affinity on an IRQ I haven't even requested yet
> and don't own?

Well, that's not any different from userspace changing the affinity of
an interrupt.

Thanks,

        tglx
