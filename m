Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1062F711746
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbjEYTV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbjEYTVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:21:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D17AE68
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:17:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96ff9c0a103so161138066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685042185; x=1687634185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIsIFxmLlj97Nfx6D9vKSgsX1a6jDH3TwyPUkCdOSPQ=;
        b=aJXv7msL9DrTUY8nTP6eYzvu5gs+lInFRlOLvZ9dPhvSmMchETpFRUDviL+a9C6jDA
         Tgw2Vv6ChUAI3TMz0fvwdsIjqCo1AKfeWd7A9CXtiLKiSctyFkHT3SKg0LiZk1NajQ4v
         saxwVtNg/PAhoBF+y2USvy4X9nKbiG2Knk+Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685042185; x=1687634185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIsIFxmLlj97Nfx6D9vKSgsX1a6jDH3TwyPUkCdOSPQ=;
        b=cVAcuZu1q7teCoPTpATzVuiHxUgZ9RTDmXaH6gP5z+WVndAAOV7peZPOPsQiP7BnqN
         50BQYESE7+vr1cpA6h/NUYCiBB/ErRkKdQiA2gIkBXgbGLLHKnpevxCRFLqw3xwfBKiW
         5nzgDENw77C/PGglzFUfIXkDhcfKaIiKJszQ4tWwE9nYfaH8hxbNh9OvxQ99pIbfSmD0
         naeA2RHAFl6jsx3mo7OkIgqvaVT/mataEKoJIjLogAZT39T8QTGpBRKc2r6/bPPIsPgc
         Zj52PiYF0IzgV5bxxe/RkiEbRJ3NgedSOHVKn6FCdOK56NQpDtqACwe3kxTqfZiGJj+W
         by7w==
X-Gm-Message-State: AC+VfDxKGXyNwq3zaNgTOalTHPseVS/srMpf3e4TdCrAyGMUkJHUOERG
        RG5QIAd/VKQEEOxAHaXLGT436TVMSRiDF9c7+Zl7yuYJ
X-Google-Smtp-Source: ACHHUZ6QTHtH9ZgDVRrxTKaVVJVN2WV+8sZSwjCXcXN3ZM+gzeV4luDSR23IkGeHv0kDQoX5TIRivw==
X-Received: by 2002:ac2:47f0:0:b0:4f4:dbcc:54da with SMTP id b16-20020ac247f0000000b004f4dbcc54damr376820lfp.27.1685041124236;
        Thu, 25 May 2023 11:58:44 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v28-20020ac2593c000000b004f3946030fasm305060lfi.68.2023.05.25.11.58.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 11:58:44 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2af20198f20so9808231fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:58:43 -0700 (PDT)
X-Received: by 2002:a17:907:6d9e:b0:96f:4ee4:10d4 with SMTP id
 sb30-20020a1709076d9e00b0096f4ee410d4mr2465428ejc.43.1685040638863; Thu, 25
 May 2023 11:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-2-mcgrof@kernel.org>
 <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
 <CAHk-=wgKu=tJf1bm_dtme4Hde4zTB=_7EdgR8avsDRK4_jD+uA@mail.gmail.com> <ZG+kDevFH6uE1I/j@bombadil.infradead.org>
In-Reply-To: <ZG+kDevFH6uE1I/j@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 11:50:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWCDw58fZDLGYVqVC2ee-Zec25unewdHFp8syCZFumvg@mail.gmail.com>
Message-ID: <CAHk-=wgWCDw58fZDLGYVqVC2ee-Zec25unewdHFp8syCZFumvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/kernel_read_file: add support for duplicate detection
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>, hch@lst.de,
        brauner@kernel.org, david@redhat.com, tglx@linutronix.de,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, lennart@poettering.net,
        gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, lucas.demarchi@intel.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com
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

On Thu, May 25, 2023 at 11:08=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> Certainly on the track where I wish we could go. Now this goes tested.
> On 255 cores:
>
> Before:
>
> vagrant@kmod ~ $ sudo systemd-analyze
> Startup finished in 41.653s (kernel) + 44.305s (userspace) =3D 1min 25.95=
8s
> graphical.target reached after 44.178s in userspace.
>
> root@kmod ~ # grep "Virtual mem wasted bytes" /sys/kernel/debug/modules/s=
tats
>  Virtual mem wasted bytes       1949006968
>
>
> ; 1949006968/1024/1024/1024
>         ~1.81515418738126754761
>
> So ~1.8 GiB... of vmalloc space wasted during boot.
>
> After:
>
> systemd-analyze
> Startup finished in 24.438s (kernel) + 41.278s (userspace) =3D 1min 5.717=
s
> graphical.target reached after 41.154s in userspace.
>
> root@kmod ~ # grep "Virtual mem wasted bytes" /sys/kernel/debug/modules/s=
tats
>  Virtual mem wasted bytes       354413398
>
> So still 337.99 MiB of vmalloc space wasted during boot due to
> duplicates.

Ok. I think this will count as 'good enough for mitigation purposes'

> The reason is the exclusive_deny_write_access() must be
> kept during the life of the module otherwise as soon as it is done
> others can still race to load

Yes. The exclusion only applies while the file is actively being read.

> So with two other hunks added (2nd and 4th), this now matches parity with
> my patch, not suggesting this is right,

Yeah, we can't do that, because user space may quite validly want to
write the file afterwards.

Or, in fact, unload the module and re-load it.

So the "exclusion" really needs to be purely temporary.

That said, I considered moving the exclusion to module/main.c itself,
rather than the reading part. That wouild get rid of the hacky "id =3D=3D
READING_MODULE", and put the exclusion in the place that actually
wants it.

And that would allow us to at least extend that temporary exlusion a
bit - we could keep it until the module has actually been loaded and
inited.

So it would probably improve on those numbers a bit more, but you'd
still have the fundamental race where *serial* duplicates end up
always wasting CPU effort and temporary vmalloc space.

                   Linus
