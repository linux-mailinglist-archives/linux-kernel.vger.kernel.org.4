Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225167017FA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 17:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbjEMPI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 11:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEMPI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 11:08:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BB2172C
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 08:08:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-965e4be7541so1885323566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683990503; x=1686582503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrMPRtTxcv74Ng8wNryDIV11KZXuJe9+P1FFJBFwcZ0=;
        b=JYPfd3aSMqnoHARUlznUxq8gBAeDmi51c7HoNwt0ALTFRaD7rrsH57twX6F20vtb81
         x2Icy37sGJW+K503Y7UfjVdURfDnqXeEEca8GU77GSzKZZ25XnWs8TZTSZ9PDXC1eFg7
         jGrFfyt71Dx37Ki0IdH5iJI3EjPEri7Er+c1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683990503; x=1686582503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrMPRtTxcv74Ng8wNryDIV11KZXuJe9+P1FFJBFwcZ0=;
        b=czRfU5KEDLvHDA0pU/MS+cMVoZnxv00sp1k6n/vFecVrcJ15dnoESJyi03hMaTihBP
         hCLhMf1P4ggJMJFQs0BaC6rO4dBzGgm8tHIagvsQOi1kD2o+kHfptpjQrZUQC8dSMK52
         NUjBl/Lqem8fEPS0gGNoT+p5VT9qUnbepBOEDFd6TqbRu89MXVVV4esgbJIIyESMU3Eb
         /+r5U3lXydIOTVLzyqfxQVUdPZpvH44Cs7PFPjx1cm3CFLj1uf9NFysF30ecQECiWnpb
         0LjcVVv2vv8aMyNznNtiV3oXTLUFRdvKih+MbVAxbpV1v9PWp8LmvQePK54hCiCcQUjZ
         HUxA==
X-Gm-Message-State: AC+VfDyTM/+1QIOQf5ONHaMAgMhtSRdgTyUh9wk9uYDahXa4vxkWIYEf
        g7GKknhPiQ3SI6m5U4GnHPveiZsZ9NFtl6XyaW0EWA==
X-Google-Smtp-Source: ACHHUZ58yLIaenn0elwKILz7knUpcJisd5lER6OF2oSSlxDl8THh49SrLeLG/uMftF2snQmabB2J6Q==
X-Received: by 2002:a17:907:9304:b0:94a:7716:e649 with SMTP id bu4-20020a170907930400b0094a7716e649mr25061888ejc.13.1683990503636;
        Sat, 13 May 2023 08:08:23 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id z23-20020a17090674d700b0096ac911ecb8sm1415923ejl.55.2023.05.13.08.08.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 08:08:22 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so19534469a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 08:08:21 -0700 (PDT)
X-Received: by 2002:a17:907:783:b0:862:c1d5:ea1b with SMTP id
 xd3-20020a170907078300b00862c1d5ea1bmr25847436ejb.8.1683990501510; Sat, 13
 May 2023 08:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com> <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com> <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
In-Reply-To: <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 May 2023 10:08:04 -0500
X-Gmail-Original-Message-ID: <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
Message-ID: <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Mike Christie <michael.christie@oracle.com>,
        nicolas.dichtel@6wind.com, Christian Brauner <brauner@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 7:39=E2=80=AFAM Thorsten Leemhuis <linux@leemhuis.i=
nfo> wrote:
>
> Jumping in here, as I found another problem with that patch: it broke
> s2idle on my laptop when a qemu-kvm VM is running, as freezing user
> space processes now fails for me:

Hmm. kthreads have PF_NOFREEZE by default, which is probably the reason.

Adding

        current->flags |=3D PF_NOFREEZE;

to the vhost_task setup might just fix it, but it feels a bit off.

The way io_uring does this is to  do

                if (signal_pending(current)) {
                        struct ksignal ksig;

                        if (!get_signal(&ksig))
                                continue;
                        break;
                }

in the main loop, which ends up handling the freezer situation too.
But it should handle things like SIGSTOP etc as well, and also exit on
actual signals.

I get the feeling that the whole "vhost_task_should_stop()" logic
should have the exact logic above, and basically make those threads
killable as well.

Hmm?

                Linus
