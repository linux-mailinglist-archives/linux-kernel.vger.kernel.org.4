Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5AF715065
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 22:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjE2UTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 16:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjE2UTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 16:19:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8DBB7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 13:19:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685391547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aLTlfptI5P4dBPx3/ykp9SW+K0hdhL8BSFcrWJbpq1o=;
        b=iwr+Q/ML/D8d8O5bVDJayEMs9gt/0svawzDlFAq+sOL3+2Lop2oyKmPOGTir3uKirlS2/I
        dMvnMdgc2M81lv6Tsa99QvEHFkKEfOKvvX+32uF3DqJU2gsfFRhOYE5jzcqJNKpuy7ajC/
        ybXJoTMVnQM4c5ysJjSzPvucI4gZ4V5PJ5I6Bb2104F1sYPIGYLsqDx6p6LuMr3iRc2XLN
        O7WNogDSYu6Vr+LXWeaaI0BvglPvffKyXaHyIRM6mOAgCWa9ijYMXJhp8iPLbqDw3jEs5Z
        h4DhGHH8tMRe2QfyPO0YfwnL1aZmak6GnyakCoUMEhZmWxey2iJPz49nYWntSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685391547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aLTlfptI5P4dBPx3/ykp9SW+K0hdhL8BSFcrWJbpq1o=;
        b=02KjXCeR0pyA0usSuRg6JvkN7CsI2kUNdtIvuzTodsVj7xQAQFn2DMSJ5BIiC0CU1LxisH
        B6hQnlEhseROKKDA==
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] genirq/msi, platform-msi: Adjust return value of
 msi_domain_prepare_irqs()
In-Reply-To: <CAAhV-H41vDyBktE25Fdb34QtZ_yWSgTq4yMOyfD9H7YytKS3RA@mail.gmail.com>
References: <20230527054633.704916-1-chenhuacai@loongson.cn>
 <20230527054633.704916-2-chenhuacai@loongson.cn> <87pm6llvm6.ffs@tglx>
 <86fs7gdhid.wl-maz@kernel.org>
 <CAAhV-H6KpNhL5VvumvhcAKGOpe-EO0zfzm_xPprP0rTVf18Leg@mail.gmail.com>
 <87ilcblc72.ffs@tglx>
 <CAAhV-H41vDyBktE25Fdb34QtZ_yWSgTq4yMOyfD9H7YytKS3RA@mail.gmail.com>
Date:   Mon, 29 May 2023 22:19:06 +0200
Message-ID: <878rd6lwlh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huacai!

On Mon, May 29 2023 at 17:36, Huacai Chen wrote:
> On Mon, May 29, 2023 at 5:27=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> By default you allow up to 256 interrupts to be allocated, right? So to
>> prevent vector exhaustion, the admin needs to reboot the machine and set
>> a command line parameter to limit this, right? As that parameter is not
>> documented the admin is going to dice a number. That's impractical and
>> just a horrible bandaid.
>
> OK, I think I should update the documents in the new version.

Updating documentation neither makes it more practical (it still
requires a reboot) nor does it justify the abuse of the msi_prepare()
callback.

The only reason why this hack "works" is that there is a historical
mechanism which tells the PCI/MSI core that the number of requested
vectors cannot be allocated, but that there would be $N vectors
possible. But even that return value has no guarantee.

This mechanism is ill defined and really should go away.

Adding yet another way to limit this via msi_prepare() is just
proliferating this ill defined mechanism and I have zero interest in
that.

Let's take a step back and look at the larger picture:

 1) A PCI/MSI irqdomain is attached to a PCI bus=20=20

 2) The number of PCI devices on that PCI bus is usually known at boot
    time _before_ the first device driver is probed.

    That's not entirely true for PCI hotplug devices, but that's hardly
    relevant for an architecture which got designed less than 10 years
    ago and the architects decided that 256 MSI vectors are good enough
    for up to 256 CPUs. The concept of per CPU queues was already known
    at that time, no?

So the irqdomain can tell the PCI/MSI core the maximum number of vectors
available for a particular bus, right?

The default, i.e if the irqdomain does not expose that information,
would be "unlimited", i.e. ULONG_MAX.

Now take that number and divide it by the number of devices on the bus
and you get at least a sensible limit which does not immediately cause
vector exhaustion.

That limit might be suboptimal if there are lots of other devices on
that bus which just require one or two vectors, but that's something
which can be optimized via a generic command line option or even a sysfs
mechanism.

Thanks,

        tglx





