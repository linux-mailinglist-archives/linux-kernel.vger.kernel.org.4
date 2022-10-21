Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0976080E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJUVmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJUVmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:42:35 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419AE2A8A51
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:42:34 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t25so2921560qkm.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T2R37JCCGa30iGWXb8Vf5Wr0AmT8I6MQXcpjnTh2wkY=;
        b=I80BmYwmapXMsaFaO7z6zYbaghq7BAhIzcq3bRl9+ijNCbn+7jyWwY0lu51t1rXyFx
         mDpjRRP6dUKPk7ucQ12SPEPo/rKwU8pKTkN+duv7lVufggHpQttUQ8vU0+M/J/sE80oJ
         C1PuDo5G8mzbJFa3TGFzOk66a6+I3X53Vg0Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2R37JCCGa30iGWXb8Vf5Wr0AmT8I6MQXcpjnTh2wkY=;
        b=aVmIAt1jad33V/UwcmISUn38+647AvgD0k0jb3iJ3KzkyP16/+Vu01UcKg9AFZpsCd
         YNZwkj01/ilS/p3SG7mOmbZS3pUVJcezLKYJCUOckPD1/jfAVVl+1mKjgpLxlSptjc8M
         vCYLFuzGPf7+OT1VCPc6F6siOM4Qjlz+K/IEGfywNLL24BHPaOVj9B4QH4FsKIGtyhNh
         rzYLgHd7oXDI6zrdOnQTrsV2ld+BO9M7jUns7H8DBYjdu5C4FgqvORdHEBR2b1SYELvd
         CP/VDGK5mot4GyirJXYnWkXk0crT1D2yQai49zO/4fnvo9Se4+VbaDFAqEhfTK9dCCtD
         6ZHA==
X-Gm-Message-State: ACrzQf08wQ9Y3uLjsNsz+/0aVIRfpiK21y2AaRnxOF4dpQrMZTAg/d+b
        BS2hc+0qCTaihN8KiTZtSHeozkshFeQ2Gg==
X-Google-Smtp-Source: AMsMyM6tCoQayg9Qw9R5ixe7svCqwVNzAAKGmgUwqjSx67/LIxAM75hsQJicATmRRkDpgbS2/cq9YQ==
X-Received: by 2002:a05:620a:319f:b0:6ef:1491:9e10 with SMTP id bi31-20020a05620a319f00b006ef14919e10mr7015265qkb.347.1666388552909;
        Fri, 21 Oct 2022 14:42:32 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id w28-20020a05622a191c00b0039bfe8acff6sm8520334qtc.58.2022.10.21.14.42.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 14:42:32 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id e62so4787974yba.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:42:32 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr19715171ybu.310.1666388551764; Fri, 21
 Oct 2022 14:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhSXRDUw0CGLqinogP6g5rHWz4rg3N4Dr-VV8RshWt56Jw@mail.gmail.com>
In-Reply-To: <CAHC9VhSXRDUw0CGLqinogP6g5rHWz4rg3N4Dr-VV8RshWt56Jw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Oct 2022 14:42:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXx=0AKgMA8dGRROi5EarYxkEfHNu_zsezLgjtPrqNow@mail.gmail.com>
Message-ID: <CAHk-=wgXx=0AKgMA8dGRROi5EarYxkEfHNu_zsezLgjtPrqNow@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v6.1 (#1)
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 8:20 AM Paul Moore <paul@paul-moore.com> wrote:
>
>         The patch, while still fairly small, is a bit
> larger than one might expect from a simple s/GFP_KERNEL/GFP_ATOMIC/
> conversion because we added support for the function to be called with
> different gfp flags depending on the context, preserving GFP_KERNEL
> for those cases that can safely sleep.

Hmm.

So I've pulled this, but that patch actually makes it obvious that
there is only one single possible function for "convert->func", namely
that "convert_context()" function.

So why is that an indirect function call in the first place? That just
makes for slower (particularly in this age of indirect call
speculation costs), and bigger code, and only makes it harder to see
what is going on.

In the call-site, it looks like "Oh, this will call some
conversion-specific callback function".

In reality, there is no context-specific callback, there is only ever
convert_context().

Inefficient and misleading code. Not a great combination.

              Linus
