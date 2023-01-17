Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D2266DA22
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbjAQJlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbjAQJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:40:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5240C30B1C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:38:43 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673948322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=huHxyGFkEMa6d1D0Au6QELxVkmDV59quuX0vGDYSXaY=;
        b=pgh2qjtwzxp/nJa3JrElZ2JxShuREDd68JdE2OsjHkpHfJlyUDOKhRrPHHP4aLudOTRna9
        Ns9ZLINgGtYh/9Yy5OXlS7Iryt+jSX6KnbowoOc+o52zSMTIEL2osZlRP566fmne9/fjuu
        ZmpeNn7FqoMO4ZjnHBsk+hW8XeI2BTxfKI0BiPlz9++cxLkhjbReiTTnuXX0d99+D9VoyW
        g/HGppyULW2tu1E8C/CCkTpYwLTmH4LYmEhXqFs2+A+AuSoa8mr5HitkUNDjgTTDRP8o11
        VgmPfnADVuuAUrHyEcD75uqOO+pxfaN4vsuAZflJsl3DNol/pH0TEED2VIblBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673948322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=huHxyGFkEMa6d1D0Au6QELxVkmDV59quuX0vGDYSXaY=;
        b=px5BPESDxGc8ZR6+hAf/v8dN6WWVHToWOLpC98VyASSEh0tO4D1ZyJAulu/8o5HD2KwtT1
        GhXenrlzW8lISbDA==
To:     Yipeng Zou <zouyipeng@huawei.com>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        hewenliang4@huawei.com, chris.zjh@huawei.com, liaochang1@huawei.com
Subject: Re: [RFC PATCH] irqchip/gic-v3: wait irq done to set affinity
In-Reply-To: <89553b60-c5dc-76ad-67a4-594858ebedee@huawei.com>
References: <20230106082136.68501-1-zouyipeng@huawei.com>
 <86pmbrop11.wl-maz@kernel.org>
 <89553b60-c5dc-76ad-67a4-594858ebedee@huawei.com>
Date:   Tue, 17 Jan 2023 10:38:41 +0100
Message-ID: <87tu0plcv2.ffs@tglx>
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

On Mon, Jan 09 2023 at 20:26, Yipeng Zou wrote:
> =E5=9C=A8 2023/1/6 19:55, Marc Zyngier =E5=86=99=E9=81=93:
> index 973ede0197e3..fad08ccb7fd9 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1667,6 +1667,9 @@ static int its_set_affinity(struct irq_data *d,=20
> const struct cpumask *mask_val,
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* don't set the affinity whe=
n the target cpu is same as=20
> current one */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpu !=3D prev_cpu) {
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 // wait irq done on all cpus
> +

There is no way to wait here. The caller holds the interrupt descriptor
lock.

If this is really an issue for LPI, then the only way to deal with that
is CONFIG_GENERIC_PENDING_IRQ, which delays the affinity change to
interrupt context

Why on earth must all the known hardware mistakes be repeated over and
over?

Thanks,

        tglx
