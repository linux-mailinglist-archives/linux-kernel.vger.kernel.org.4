Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E00C6D0026
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjC3JtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC3Jsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:48:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBED93D4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:47:34 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id c4so705185pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680169647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OdosBDolGQNzQB/45PIpdghJGHYdgirOF9Wp82woz8M=;
        b=DzY3/3o26OIw7qcpZgeVcNxZuUJ5S5Hh2cq7op2GiHG/qGCmRrKe7/N+OfJAji7oq8
         QJPrDLRHfhipXnJ+dBbB4+BuUxhwlHXYHrfSQevBnmY+1/uHTzJd01Pu7e+5XI8LX5rF
         EAaCmJc0LDsxQhhTCiA03yQHOAGcbec4WI2dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680169647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdosBDolGQNzQB/45PIpdghJGHYdgirOF9Wp82woz8M=;
        b=sjGlohAP6LbFlQzEkDJXjzt0w6wD3oBr4GigdX4WBRuaLgUwfyai7VsMEMZQI6c18N
         dLYBH4a0F3AkKVZBDJfqyoDMJikpcAmbFfeNZ3YtzcHqUzZ+dqzxdCc9uE+ytihQey4U
         4n5UWZimzZztjEDjtuH24Hc3TpIq/oPZ8BdV7E9+PrjrTXwKt433pu9Wow5IHJNR36BK
         7pGM7qJIojJl61BE0HA0lU22eukr/5/W4UgwvaafEp/zZuFV89MzofRpD5zxqp9eHgHT
         IU4ghC9paQUf4Z3IYDaH9+0/2wLo2KBWek3J5QLxd0RjPkrxa8tpjfXp/VCgxokz8h+P
         TjcA==
X-Gm-Message-State: AAQBX9dtWgGTGUQtrlWgbLroHJ79cRS6cSznj7mcQwFjjW6DjusncFub
        VDC3BauNTs6HTEVLMzS7S+cKNCJ/4Y/2iTxMbXChOQ==
X-Google-Smtp-Source: AKy350ZpFxHD9QM/8mPi19jBhkrhzhHazz3N9lTEznKgjzbrzbOU8JrLxL5u+kw7Y0KmTaiewWrlJA==
X-Received: by 2002:a17:90b:3911:b0:23f:9d83:ad76 with SMTP id ob17-20020a17090b391100b0023f9d83ad76mr24207104pjb.23.1680169646772;
        Thu, 30 Mar 2023 02:47:26 -0700 (PDT)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com. [209.85.216.49])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b0019c93ee6902sm24377605plh.109.2023.03.30.02.47.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 02:47:26 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id d13so16748964pjh.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:47:26 -0700 (PDT)
X-Received: by 2002:a17:90b:2d82:b0:23b:349d:a159 with SMTP id
 sj2-20020a17090b2d8200b0023b349da159mr2215812pjb.3.1680169645576; Thu, 30 Mar
 2023 02:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v4-0-1340518f98e9@chromium.org>
 <20230321-kexec_clang16-v4-1-1340518f98e9@chromium.org> <ZCU+63H7GzPlL6QJ@kernel.org>
In-Reply-To: <ZCU+63H7GzPlL6QJ@kernel.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 30 Mar 2023 11:47:14 +0200
X-Gmail-Original-Message-ID: <CANiDSCsbmmkfRGC-GvhX-RSZGU0CT7ZqLo6Z=RmccoM7zbPcsA@mail.gmail.com>
Message-ID: <CANiDSCsbmmkfRGC-GvhX-RSZGU0CT7ZqLo6Z=RmccoM7zbPcsA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kexec: Support purgatories with .text.hot sections
To:     Simon Horman <horms@kernel.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        stable@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Philipp Rudo <prudo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon

Thanks for your review!

On Thu, 30 Mar 2023 at 09:49, Simon Horman <horms@kernel.org> wrote:
>
> On Mon, Mar 27, 2023 at 05:06:53PM +0200, Ricardo Ribalda wrote:
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
>
> s/inmediatly/immediately/
>
> >
> > kexec_core: Starting new kernel
> >
> > Cc: stable@vger.kernel.org
>
> Maybe a fixes tag is warranted here.
>
> > Reviewed-by: Ross Zwisler <zwisler@google.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  kernel/kexec_file.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index f1a0e4e3fb5c..25a37d8f113a 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -901,10 +901,21 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
> >               }
> >
> >               offset = ALIGN(offset, align);
> > +
> > +             /*
> > +              * Check if the segment contains the entry point, if so,
> > +              * calculate the value of image->start based on it.
> > +              * If the compiler has produced more than one .text sections
>
> nit: s/sections/section/
>
> > +              * (Eg: .text.hot), they are generally after the main .text
>
> If this is the general case, then are there cases where this doesn't hold?

When looking at this issue, I have only seen .text.hot after .text.
But I cannot warantee that future versions of llvm or gcc decide to
swap the order.

I am going to add a WARN whenever there are two overlapping .text
sections so the user has the chance to update their linker script.

>
> > +              * section, and they shall not be used to calculate
> > +              * image->start. So do not re-calculate image->start if it
> > +              * is not set to the initial value.
> > +              */
> >               if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
> >                   pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
> >                   pi->ehdr->e_entry < (sechdrs[i].sh_addr
> > -                                      + sechdrs[i].sh_size)) {
> > +                                      + sechdrs[i].sh_size) &&
> > +                 kbuf->image->start == pi->ehdr->e_entry) {
> >                       kbuf->image->start -= sechdrs[i].sh_addr;
> >                       kbuf->image->start += kbuf->mem + offset;
> >               }
> >
> > --
> > 2.40.0.348.gf938b09366-goog-b4-0.11.0-dev-696ae
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >



--
Ricardo Ribalda
