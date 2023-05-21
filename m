Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377C170AFCE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 21:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjEUTVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 15:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjEUTVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 15:21:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424FAD1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 12:21:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510f3db1cd8so5621605a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 12:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684696898; x=1687288898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HXhFRUhp8ATNRE1IY8Xb1FY1Xv4mWGcfTkE+W6AJow=;
        b=PAm1kCzX2Y7OPOmT60te/tIf6F6s8zGjojbIvuwMyxeQ8rxZdAkxC5rU7iSH/xiFbx
         u/O2VypCPAnFqLVAu81U3SvZICDXoX3/d+n6t0v10NtIrOzdnvSYbFQjfJchUwsUwkvq
         XyEs57loEM7JOyL0tBZrygh5oEicB0SzRbtBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684696898; x=1687288898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HXhFRUhp8ATNRE1IY8Xb1FY1Xv4mWGcfTkE+W6AJow=;
        b=ASgvPh4YoxOB+GxVO125hBNCovaIftjN7b+PgQY4c02tZW2ouA6rKP3vg2Yn8NxgQh
         C6rwFmOFbEwtspYqPSAlVBdgIM+KlVeFzXnUJlFYU6JQbHrFP8hNgMJgQhcdPzt6EJzl
         Yj6apTK7jtUIbxka04gbAXD/OiIQ0VNhSHG6cBQbS2scz8rbd7YtydztLZ97fKIYzkKY
         tPuv763XFCyEjTfVBbHTGVL+SkftPWFf7aJBYAPdCpjgGXhwmHww0E12AryCkSrWQzSi
         Wrbm0ZCgUTcO+QKjCT7geZ/lxTPHNuhppt/KXoEZuTZnM1f7cCb3KtTBfyUKICWd7jk8
         sYXA==
X-Gm-Message-State: AC+VfDwVp/WpsR9vp7W+3cAuqw5Xln+nd4w5eT2BU3etqvLG47wUZq+b
        I7LlJ96Ni5VmIRvaYV0gI+Xhpf53/4U22BENl8maHw==
X-Google-Smtp-Source: ACHHUZ5nVPsTpSEXe6TT+VgX7lRaLLWpNI4os1chm1l7JaYrWEtihKQNPVAMsQNzVMvxl012CeyNtw==
X-Received: by 2002:a50:ee90:0:b0:506:82b7:10c3 with SMTP id f16-20020a50ee90000000b0050682b710c3mr6356934edr.41.1684696898601;
        Sun, 21 May 2023 12:21:38 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7cd17000000b0050d8aac0a1esm2176421edw.19.2023.05.21.12.21.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 12:21:37 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-510f525e06cso5476608a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 12:21:37 -0700 (PDT)
X-Received: by 2002:a05:6402:6d8:b0:50b:fb60:f431 with SMTP id
 n24-20020a05640206d800b0050bfb60f431mr6096635edy.7.1684696897335; Sun, 21 May
 2023 12:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msxkE5cPJ-nQCAibJ+x+hO7uSLpasGm81i6DknQ8M5zWg@mail.gmail.com>
 <CAHk-=wiStOAKntvgzZ79aA=Xc0Zz7byoBxBW_As5cmn5cgkuoQ@mail.gmail.com> <CAH2r5muxwEMA9JpE6ijSbZEByxRmtNSiwcXMbOz+Ojo8_APJUQ@mail.gmail.com>
In-Reply-To: <CAH2r5muxwEMA9JpE6ijSbZEByxRmtNSiwcXMbOz+Ojo8_APJUQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 May 2023 12:21:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeuUNo6o6k4y3nQD2mmT5T04ack7i_UOAetmga-4_SbQ@mail.gmail.com>
Message-ID: <CAHk-=wjeuUNo6o6k4y3nQD2mmT5T04ack7i_UOAetmga-4_SbQ@mail.gmail.com>
Subject: Re: [GIT PULL] ksmbd server fixes
To:     Steve French <smfrench@gmail.com>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 12:03=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
>
> I would be happy to do the move (to fs/smb) of the directories and
> update the config soon (seems reasonably low risk) - let me know if you
> want me to send it this week or wait till 6.5-rc

So I think the "do it now or wait until the 6.5 merge window" is
entirely up to you.

We've often intentionally done big renames during the "quiet time"
after the merge window is oven, just because doing them during the
merge window can be somewhat painful with unnecessary conflicts.

I would *not* want to do it during the last week of the release, just
in case there are small details that need to be fixed up, but doing it
now during the rc3/rc4 kind of timeframe is not only fairly quiet, but
also gives us time to find any surprises.

So in that sense, doing it now is likely one of the better times, and
a pure rename should not be risky from a code standpoint.

At the same time, doing it during the merge window isn't *wrong*
either.  Despite the somewhat painful merge with folio changes, I
don't think fs/cifs/ or fs/ksmbd/ normally have a lot of conflicts,
and git does handle rename conflicts fairly well unless there's just
lots of complexity.

So it's really fine either way. The normal kind of "big changes"
should obviously always be merge window things, but pure renames
really are different and are often done outside of the merge window
(the same way I intentionally did the MAINTAINERS re-ordering just
*after* the merge window)

But we don't do renames often enough to have any kind of strict rules
about things like this.

So I think "whenever is most convenient for you" is the thing to aim
for here. This is *not* a "only during merge window" kind of thing.

                 Linus
