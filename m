Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C31F639A66
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiK0MTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiK0MTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:19:49 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE821006D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:19:48 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ho10so19756080ejc.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jza6Z//NnhC603MChrX9Y1mxWIhgstBbV7SQVlCghrA=;
        b=u9BsVmQn4l1P9N5SSYmW95s95Wcd71k2mP3wh4YR1pz1VvY+owHKVAO4cIUKlK42MP
         fGna7JGde7R5krea4qJqHAOdVnCzDjsiFXakjrjVD5T6Lyx7Ez2p35KPQOBBcGG6a914
         fbemsDLTCcD66b2vR+9GAd+JhIZL93DfcMEnad6f1t/XkqtzHxmxXfnb22oqvqPPMGAi
         e6RDdUldlyCx7VFn/6NP4jb+hudQQlHVeY3uKaS/xve46s7pZE6Sn0pkLoYkaK2f9dQf
         Hl60TofyvIILNqcEKiMfMchzYvZtt5+RcSitft/eZCIQ5TrpboCe7ft0pZiDUVsnifEh
         9VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jza6Z//NnhC603MChrX9Y1mxWIhgstBbV7SQVlCghrA=;
        b=RVbyzeiL/L4vLSXxetevXr6ZqYPOnJwvV5owKhbnA6DAa/x7YudfNi9j5zfAgChCKZ
         F3Odgqvr3gdhAbsfUZfPPFPLKW1z6pMRCEPqo+QRwxP9pzeKxa5Y//W+IEGsbsho1Rws
         xFiy5TCDGJi7sejWjPkn2PDBsbkncOe0HXvkmT9ylCG4y1R7DnDXfH5PUuyn5eqf1z7a
         /2vNyhsdwdISiZ6YIoEtJpLM98o7hez568tWqfdgWx2qeN8Gz1UjgzVtfttY9cQZo9I3
         6E5jerBZY1MdxPflz1QxdJ7B1SmQZWlSZicx7T0isO7h4RtZaq/u4VBc9y42U4NKpf8Y
         MN0Q==
X-Gm-Message-State: ANoB5pn8gHeJ65+JeCrbhe4qNRjzNSDXqMVR4ShUx5OIxPEUk/BFVsJl
        44+9kWcHo+h2pO+sxkThiUURqGWA4PspUVbl/twjrw==
X-Google-Smtp-Source: AA0mqf44+RQqrxuAnUVydhj6enVKkFQO9iOFt0II1GZhmlIzhD1xCZyb+TpdrO2pph0BWrZGOg8nfdhgqrYYD8JMPkQ=
X-Received: by 2002:a17:907:a044:b0:7bc:27ab:6b2d with SMTP id
 gz4-20020a170907a04400b007bc27ab6b2dmr11615745ejc.750.1669551586661; Sun, 27
 Nov 2022 04:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20221108115543.1425199-1-apatel@ventanamicro.com> <mvmiljpd4ht.fsf@suse.de>
In-Reply-To: <mvmiljpd4ht.fsf@suse.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 27 Nov 2022 17:49:34 +0530
Message-ID: <CAAhSdy2FnvRYo6AySDpKAt+O+8RzyH8fNaZekjyqs1pnmg_RQA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Exit run-loop immediately if xfer_to_guest fails
To:     Andreas Schwab <schwab@suse.de>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 5:48 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On Nov 08 2022, Anup Patel wrote:
>
> > If xfer_to_guest_mode_handle_work() fails in the run-loop then exit
> > the run-loop immediately instead of doing it after some more work.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/kvm/vcpu.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> > index 71ebbc4821f0..17d5b3f8c2ee 100644
> > --- a/arch/riscv/kvm/vcpu.c
> > +++ b/arch/riscv/kvm/vcpu.c
> > @@ -984,8 +984,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> >       while (ret > 0) {
> >               /* Check conditions before entering the guest */
> >               ret = xfer_to_guest_mode_handle_work(vcpu);
> > -             if (!ret)
> > -                     ret = 1;
> > +             if (ret)
> > +                     continue;
>
> If that is supposed to exit the loop, it would be clearer to just use
> break.

This is a convention within the run-loop that we continue whenever
whenever "ret" is no longer suitable to continue. I don't see any
particular advantage in breaking this convention over here.

>
> > +             ret = 1;
>
> There is a condition on ret <= 0 later in the loop that no longer can be
> true.

Yes, for now the "ret <= 0" check is useless and the compiler will
optimize this comparison. We will be soon having more stuff added
to run-loop (such as AIA update) which will make "ret <= 0" check
useful again.

>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."

Queued this patch for Linux-6.2

Thanks,
Anup
