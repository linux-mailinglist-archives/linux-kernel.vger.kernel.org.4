Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C586C4E44
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjCVOoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjCVOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0753B65125
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:42:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o2so12071791plg.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679496146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pxwmBSFcZVlKRN2o7xTs6FmPgfGh/hUZt2I0jJI4Uzw=;
        b=nHKTXN4ONTE5iPdtK6bxzX88vvCyUHpzjWcZpb/oXwtbjMkfcTZLR0gkqIK7+vXLdf
         Hx/QT20vdO4irmqHBlZVajzXeMeuc6Oipd2W710G9yAWPzTv9cgjKaRypicvvGqjUEst
         7hmHt8UoW4P40d9IKBN3+QkZuznkhsk4SGg9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxwmBSFcZVlKRN2o7xTs6FmPgfGh/hUZt2I0jJI4Uzw=;
        b=7HImzHcEzESLH7/fkPVJ9T6iZdiouZ4tKyedsRwFkjjAj3nzyuEXFLiJUSt6KjC3c+
         +Swqc5pdx23QkGhFqXr6zxi1ufTPGweWAJ638a74M0DO/2v5Fjn8Yx2fJsSUP82+XxKK
         Ql6NAuls98DX4d10VDVaU9PBtuO0iXUs5eXATI1b7mU3NHo5E57Yg/YJa1pTw6RwHEFw
         RmJly9nglsRR/KP0vR4F4EhKNbJiQTq+JZ1Pspo8stFm+6//bGXnpbXpYSlHz0hZODai
         sgg2TfO7ojZKXyQ17WxmrLsRA336ZvPmvIdjaulOpWduorgSbuqmdXKN0kay9P1DVYyq
         y34w==
X-Gm-Message-State: AO0yUKVDLh7uo0U+bpCZBQbqHbrFuwD2rJVP/Qo6IiCZnr5qMQuyht7D
        7TIQTt9uFxq7/50T+AqGtAHkjvVKhzsP5vX0ynA=
X-Google-Smtp-Source: AK7set+iRlU3tt5oOy21jSmS16YKjbsRD7AWCrmxuC+5lZWXw9NOPVP9g7FIW7XmVOpDOMZJc8zAYw==
X-Received: by 2002:a05:6a20:be25:b0:db:d9b6:7fad with SMTP id ge37-20020a056a20be2500b000dbd9b67fadmr181988pzb.6.1679496146340;
        Wed, 22 Mar 2023 07:42:26 -0700 (PDT)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com. [209.85.210.182])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b006260645f2a7sm10523528pfb.17.2023.03.22.07.42.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 07:42:25 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id cu12so6011747pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:42:25 -0700 (PDT)
X-Received: by 2002:a65:4308:0:b0:50f:76fb:84b7 with SMTP id
 j8-20020a654308000000b0050f76fb84b7mr856636pgq.6.1679496145212; Wed, 22 Mar
 2023 07:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org> <ZBsSBr87al9ccG96@home.goodmis.org>
In-Reply-To: <ZBsSBr87al9ccG96@home.goodmis.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Mar 2023 15:42:14 +0100
X-Gmail-Original-Message-ID: <CANiDSCt_wvaHBq-Yss0QaKTtefBhWwtahFO8_jw6CPSvBwbbMg@mail.gmail.com>
Message-ID: <CANiDSCt_wvaHBq-Yss0QaKTtefBhWwtahFO8_jw6CPSvBwbbMg@mail.gmail.com>
Subject: Re: [PATCH] kexec: Support purgatories with .text.hot sections
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven

On Wed, 22 Mar 2023 at 15:34, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, Mar 21, 2023 at 12:49:08PM +0100, Ricardo Ribalda wrote:
> > Clang16 links the purgatory text in two sections:
> >
> >   [ 1] .text             PROGBITS         0000000000000000  00000040
> >        00000000000011a1  0000000000000000  AX       0     0     16
> >   [ 2] .rela.text        RELA             0000000000000000  00003498
> >        0000000000000648  0000000000000018   I      24     1     8
> >   ...
> >   [17] .text.hot.        PROGBITS         0000000000000000  00003220
> >        000000000000020b  0000000000000000  AX       0     0     1
> >   [18] .rela.text.hot.   RELA             0000000000000000  00004428
> >        0000000000000078  0000000000000018   I      24    17     8
> >
> > And both of them have their range [sh_addr ... sh_addr+sh_size] on the
> > area pointed by `e_entry`.
> >
> > This causes that image->start is calculated twice, once for .text and
> > another time for .text.hot. The second calculation leaves image->start
> > in a random location.
> >
> > Because of this, the system crashes inmediatly after:
> >
> > kexec_core: Starting new kernel
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > To: Eric Biederman <ebiederm@xmission.com>
> > Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
> > Cc: kexec@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  kernel/kexec_file.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index f1a0e4e3fb5c..b1a25d97d5e2 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -904,7 +904,8 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
> >               if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
> >                   pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
> >                   pi->ehdr->e_entry < (sechdrs[i].sh_addr
> > -                                      + sechdrs[i].sh_size)) {
> > +                                      + sechdrs[i].sh_size) &&
> > +                 kbuf->image->start != pi->ehdr->e_shnum) {
>
> Shouldn't this be: kbuf->image->start == pi->ehdr->e_shnum) {

You are absolutely right, I screwed up when I ported the code from my
test tree to the tree that I use for upstreaming.
Instead of removing all the printks I wrote code.

:S

Will resend the patch

>
> ?
>
> As you want to only do this update when it's not equal to the initial value.
> If this did work, then you may want to make sure that was the initial value.
>
> Also, please add a comment about why you are doing this check.
>
> Thanks!
>
> -- Steve
>
> >                       kbuf->image->start -= sechdrs[i].sh_addr;
> >                       kbuf->image->start += kbuf->mem + offset;
> >               }
> >
> > ---
> > base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
> > change-id: 20230321-kexec_clang16-4510c23d129c
> >
> > Best regards,
> > --
> > Ricardo Ribalda <ribalda@chromium.org>



-- 
Ricardo Ribalda
