Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6C5711079
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjEYQIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjEYQIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:08:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E18E47
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:08:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-514454733b8so1155746a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685030882; x=1687622882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qTlSjkBOvu6ts2EQmZGpeTeiOlCCdoojabISpYKz8Q=;
        b=eowNGDWi2BVdbUdBijqcCx1CMmOQwJAO3BK6dcQLs37EYV4CtfTJXRMHsxXVMPrzaR
         ZzyBRO7KKsprp3vWCLmomoACs9fNjSXqWYWpVys0jAA51wvTkyv56Zh2IBgVOagw3QBQ
         oeEL9Zs9GaVJCV0ticOBEFjE5MKxfGYYG1hYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030882; x=1687622882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qTlSjkBOvu6ts2EQmZGpeTeiOlCCdoojabISpYKz8Q=;
        b=YZsm9Fjo5kxHSt/It1NL2cB1YpYguo3Kepw5+UQEkDb9RS7PZPsAW3IknpM8TJ+osS
         7qKsPORY5Hpe3hjiDNquFr0cQpZUQga5Nn4WNOopQaYMkOBq57Rie6SoUQWi90tP9a36
         KCdLetjgOn1z5gfqUfJR0NrRWIEYX379+eARhmBILJMe+Z+xNaXi6JrPQzKxTR/Hq3uX
         aBfe7otCBPA1oQCPm01T3dbTu8/eeI5oiOLP3UCHWx3MKjZ/mLiv/2UbOS0/eBN0/5td
         yuhLuvauLvypOQYg5pi7RegDmKUh6yxI/X1S02tQrIL9wC/2QS50dGPc9efVatAb2chc
         5lsQ==
X-Gm-Message-State: AC+VfDxYiHuv8vxqZ06CcQWIIfJpK1bfPKwYdpL5yQ9QKXL608EmQl/J
        gAfXsR/b59m1dwQn7Ry/kXxwnV88Dh4PD12Geuz6R/vH
X-Google-Smtp-Source: ACHHUZ6QBam8QfoGOXckKpuJEVrdNRWwYdfJYqk1szHgnYJkBhokuCG1bH7jK75DrMGADOpWldINxA==
X-Received: by 2002:a17:907:608c:b0:94f:61b2:c990 with SMTP id ht12-20020a170907608c00b0094f61b2c990mr2234962ejc.25.1685030882400;
        Thu, 25 May 2023 09:08:02 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id b24-20020aa7c6d8000000b0050673b13b58sm686377eds.56.2023.05.25.09.08.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 09:08:02 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-514454733b8so1155671a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:08:01 -0700 (PDT)
X-Received: by 2002:a17:907:7faa:b0:96a:937c:5608 with SMTP id
 qk42-20020a1709077faa00b0096a937c5608mr2490223ejc.53.1685030860523; Thu, 25
 May 2023 09:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com>
In-Reply-To: <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 09:07:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
Message-ID: <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        lucas.demarchi@intel.com, christophe.leroy@csgroup.eu,
        peterz@infradead.org, rppt@kernel.org, dave@stgolabs.net,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, colin.i.king@gmail.com,
        jim.cromie@gmail.com, catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
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

On Thu, May 25, 2023 at 4:40=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> kmod normally uses finit_module() only if a module is not compressed,
> otherwise it decompresses it first and then invokes init_module().

Note that it would probably be good to teach Fedora and SuSE to use
the kernel-side decompression, if only because we have it and would
like to try to avoid using the old "load contents from user memory".

Mainly because it allows security modules to actively check for
tampering (ie things like verity etc). Long-term, it would be good to
just deprecate the old init_module() entirely.

But yes:

> It means that these and similarly organized distributions end up using
> init_module(), and adding complexity to optimize finit_module() wouldn't
> actually help in their case.

Yeah, I think the real bug is absolutely in udev, and trying to load
the same module hundreds of times is very very wrong. So I think the
"mitigate it in the kernel" is at most a quick hack to fix user-space
brokenness.

And I don't think 1/2 is acceptable as that "quick hack". Not at all.
It also seems fundamentally buggy, as it uses purely the inode number
as the file identity, which means that it does bad things across
filesystem limits.

That said, I posted an alternate patch that I think _is_ valid as that
quick hack. I don't love it, but it sure is simpler (and avoids the
i_ino bug):

    https://lore.kernel.org/lkml/CAHk-=3DwgKu=3DtJf1bm_dtme4Hde4zTB=3D_7Edg=
R8avsDRK4_jD+uA@mail.gmail.com/

that patch hasn't seen any testing, and for all I know it won't even
boot because of some thinko, but I think it would be acceptable as a
workaround if it does work.

But no, it's not some kind of "fix" for the bug, and yes, using
init_module() rather than finit_module() will circumvent the quick
hack. The true fix would be for udev to do proper handling of its data
structures instead of randomly spraying duplicate module loading
events.

I don't know why udev does what it does. From what Luis told me,
apparently it's just forking stuff and keeping all its data structures
in memory, and has no actual consistency or locking or memory of what
it has done. Luis pointed me at

    https://lore.kernel.org/all/23bd0ce6-ef78-1cd8-1f21-0e706a00424a@suse.c=
om/T/#u

for some udev background.

It's been about a decade since I looked at udev sources, and none of
this encourages me to take a second look, so all of the above may be
me misunderstanding just exactly what the udev problem is. But for
that 'finit' case, we *could* try that simple hack of mine.

I say "hack", but the patch really is pretty simple, and the concept
of "exclusive special access" certainly is not some hack in itself.
It's just not anything we've ever done before. So the hackishness from
that exclusive_deny_write_access() thing in my patch is mainly that it
shouldn't be needed at all (and that the exclusivity should probably
be set some other way).

Comments welcome.

                  Linus
