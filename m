Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3556B9CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjCNRMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjCNRMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:12:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F431ADC2A;
        Tue, 14 Mar 2023 10:12:34 -0700 (PDT)
Date:   Tue, 14 Mar 2023 18:12:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678813952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoXVxWY2RdbpAngboxJV6HcjSFULgSyzrd+jPOr62qw=;
        b=ic5qX8K28DPh4A1SReQAfb52iaiU44STnCj0r+1mF1t/9m46edlxE0jRwvafLuOzGXfujw
        izzkcTLH+jJTrZUbSIb3EqNc5iOsUisI9F506WVyAwup0t6RfhI0MHsU2WzhkEPGAZUCiH
        u1LvDxtNWXjX+9zgOCHxfLjPui+J1/xoq8bd8GBNOYuRjcXAOsa4eRGBy77/26vV9dM/oc
        Q5MUaTAuE7DCw3063AJspuIt865jvU5QYqK05ZtIAnmlWJSKbUMC6cLvgbm4aQ1ZxMg/cm
        4+X8fJpPvrKuWGXio5Xk+pRq5YciKA2a4u+rd/KTBMVfftGJiKVxQnpnT5csfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678813952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoXVxWY2RdbpAngboxJV6HcjSFULgSyzrd+jPOr62qw=;
        b=Hm2fE8egrzz2LImXg9YyZI/bqqxdwwnc/3yBprHNJXsZ5gGkn3yB6Bhl1seDoqJ6He5CHb
        InMunxgqbbMd4aDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v6.3-rc2-rt3
Message-ID: <20230314171231.jwtham4a@linutronix.de>
References: <20230314170502.OHw1_FK3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230314170502.OHw1_FK3@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-14 18:05:04 [+0100], To Thomas Gleixner wrote:
> Dear RT folks!
>=20
> I'm pleased to announce the v6.3-rc2-rt3 patch set.=20
>=20
> Changes since v6.3-rc2-rt2:
>=20
>   - The i915 and other driver using io_mapping_map_atomic_wc() function
>     could deadlock. Reported by Richard Weinberger.
>=20
>   - A larger printk rework by John Ogness. This printk series is based
>     on the latest work by John and most of the patches have been
>     submitted for upstream review.
>     As in the previous version the concept of an atomic console
>     remained. That means a crash (BUG(), panic(), =E2=80=A6) without a at=
omic
>     console driver remains invisible on PREEMPT_RT. The only available
>     atomic console driver is the 8250 UART and has been tested on X86.
>=20
> Known issues
>      - Crystal Wood reported that a filesystem (XFS) may deadlock while
>        flushing during schedule.
>=20
> The delta patch against v6.3-rc2-rt2 is appended below and can be found h=
ere:
> =20
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/incr/patch-6=
=2E3-rc2-rt2-rt3.patch.xz
>=20
> You can get this release via the git tree at:
>=20
>     git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v=
6.3-rc2-rt3
>=20
> The RT patch against v6.3-rc2 can be found here:
>=20
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patch-6=
=2E3-rc2-rt3.patch.xz
>=20
> The split quilt queue is available at:
>=20
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patches=
-6.3-rc2-rt3.tar.xz

This email didn't pass the size restriction on linux-rt-users@ so this
is just a small ping that this release happened. The whole email is in
the archive:
	https://lore.kernel.org/20230314170502.OHw1_FK3@linutronix.de
=20
Sebastian
