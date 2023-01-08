Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790F06619F4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjAHV15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjAHV1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:27:54 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369286158
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:27:52 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E4E081EC01A9;
        Sun,  8 Jan 2023 22:27:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673213270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=r4z3/oAS0SMZft5YXc1AsiYYCsz+vcZMzz61c1XzNKA=;
        b=MGwkmO6l3+pHEqumYjVwGYwFmfbmT/DfAP8GJhyOIJFe1M042a03+/Xyqy2c2LAcAZkRsc
        fT4k71b7Qf47qfjWa+9nwsba6ZwjU1cxIGSEfCpWiCCFScOTnETFDNqWe5lf6BjzqE4p+A
        ttZ8C4gDxi3EdP2eFxmBzpuyQcgKTTk=
Date:   Sun, 8 Jan 2023 22:27:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Joan Bruguera <joanbrugueram@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Wake-up from suspend to RAM broken under `retbleed=stuff`
Message-ID: <Y7s1Ubyxfdz9V+sp@zn.tnic>
References: <Y7qp80cK+r247eCU@zn.tnic>
 <20230108171159.1311342-1-joanbrugueram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230108171159.1311342-1-joanbrugueram@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2023 at 05:11:59PM +0000, Joan Bruguera wrote:
> Arch Linux kernel config (and I leave any new options at their defaults):
> https://aur.archlinux.org/cgit/aur.git/plain/config?h=linux-mainline&id=20ffc62e08f6b0d48a088bccb6e0c3606b88083a

That .config works here.

> I need to either disable the BPF LSM or apply this patch to boot it:
> https://lore.kernel.org/lkml/20230107051456.8800-1-joanbrugueram@gmail.com/
> I suspend with `systemctl suspend`. Waking up hangs with `retbleed=stuff`
> and works without it.

I booted another, more modern guest which has systemd to see whether a different
userspace could be the issue but it works too.
 
> For verification I booted Fedora-Cloud-Base-Rawhide-20230107.n.0.x86_64.qcow2
> (from https://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/Cloud):
>     qemu-system-x86_64 -nodefaults -enable-kvm -smp 1 -m 1024 -vga std \
>         -hda Fedora-Cloud-Base-Rawhide-20230107.n.0.x86_64.qcow2 \
>         -serial stdio -monitor tcp:127.0.0.1:55555,server,nowait
> I appended `retbleed=stuff,force init=/bin/sh` to the kernel command line,
> suspended through sysfs and then wrote `system_wakeup` on the QEMU monitor.

I guess I'll try that next.

And maybe try that on an Intel machine - I'm using an AMD one but the ",force"
thing enables the same stuffing on AMD too even if it is not the fitting
mitigation for it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
