Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BCC740609
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjF0V6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjF0V6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:58:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713AEAB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:58:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51d9a925e9aso3286380a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687903108; x=1690495108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fh2D6/Ks/4taQMoJg+/lggZYIaxAc+pV720Y4sER1yQ=;
        b=E6c2axXY2IgSPyYfP4K992PUGGjvvGpTvfIXxDi75k5pYCGZ9n0qNsz7f0xxjCtVuP
         lRJmgao173LR8u7U0qibwn4X/f6AbsayuMiJ9+90PAEJGPwUSJsWoTcXV1kXO2hZuT6Z
         y4es2Tcz1ZNShly6Atjs7rYe9hu763H7U3XAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687903108; x=1690495108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fh2D6/Ks/4taQMoJg+/lggZYIaxAc+pV720Y4sER1yQ=;
        b=FLZkzsHQ/FgxPi+CgsdWcZ1GYogU8OMqHoyyF+tL9uCqvrEDMZzfXjkiHsOpT+F2FI
         ugMy665zxmnWAdAyRxb+ABgDM1GC0nYvfkD+GVPnEshblJyXOnffUt9VNUaoOMZxnfut
         Rar+dHzKaqeLJLFdIJodqQnBQEMCd6F6taoN8HoNOTS5ZSl5Yn+ffCwH6XqeVb3HOHs7
         U2odq8Vwo2mSqi9bg6aZNuMRkJhPINoWbOU7qWZmUXVGYF+6ApNeR+krNbpouuemzWMt
         qAqz90LDsN/5zbB5Ft3vahL9TV+YobraCzQuheKtBJa2i/Z2XWCMaZNCGdbTBBkpHFtd
         z8ow==
X-Gm-Message-State: AC+VfDwDWbhgHzrHqCp1NchO5Ju2CDaKounFb5ZyBU2kQPTKJE56Nw9k
        Mr8tCZF3ZycuAJG8PUTZ2rFtCsivdlOrz3a4uT8EJpu6
X-Google-Smtp-Source: ACHHUZ5VfoilEWrEK2tncW/eUfSLFX2/qjrRxu7ejgLqYgzFy0sqtd9sF0zKizNHQnhLtKhAW+Veog==
X-Received: by 2002:a17:906:c049:b0:98d:3491:68da with SMTP id bm9-20020a170906c04900b0098d349168damr11230901ejb.44.1687903107636;
        Tue, 27 Jun 2023 14:58:27 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id p21-20020a170906499500b0097404f4a124sm5007354eju.2.2023.06.27.14.58.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 14:58:27 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51cb40f13f6so5677640a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:58:27 -0700 (PDT)
X-Received: by 2002:a05:6402:b23:b0:51b:ec85:6cbd with SMTP id
 bo3-20020a0564020b2300b0051bec856cbdmr11451921edb.2.1687903106734; Tue, 27
 Jun 2023 14:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
 <CAHk-=wghuOwXtMH9u7RAW694BOwf_Q9TeWR2v=GgLy0gjTfu4A@mail.gmail.com>
 <CAHk-=wi9Uwo3-uwB4rT=wK2VKhGq3yEp_U-b2kruogCT=13Mjg@mail.gmail.com>
 <20230627203829.GKZJtIxQhQoC6erNva@fat_crate.local> <CAHk-=whR90bEKrOKmk0O8KtX77bTFQGu3ykDDRhTGwmAw8HzYg@mail.gmail.com>
 <CAHk-=wixYgM6Lz723vzAz8FoOH92zmydR20+J5xyn5yE_e-gpA@mail.gmail.com>
In-Reply-To: <CAHk-=wixYgM6Lz723vzAz8FoOH92zmydR20+J5xyn5yE_e-gpA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Jun 2023 14:58:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbhWCMdFU_yjNxEnHRxqCZZ6Cc7x9n-y2Lci45pPUxnw@mail.gmail.com>
Message-ID: <CAHk-=whbhWCMdFU_yjNxEnHRxqCZZ6Cc7x9n-y2Lci45pPUxnw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/misc for 6.5
To:     Borislav Petkov <bp@alien8.de>
Cc:     Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023 at 14:44, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But now I'm committed, and decided to fix that too, and just
> re-organize the code to get all the cases right.
>
> And now I'm going to actually boot-test the end result too.  Because
> life is too short to spend all my time _just_ with merging.

Well, it boots. And I clearly have networking. But who knows how much
that is actually using the csum_partial() function? Not me. I'm just
along for the ride.

Anyway, that last version handles the 40-byte special case
differently, in that it might have done some arbitrary number of
80-byte chunks first. But it shouldn't really make a difference - it
does check for >= 80- bytes first, but we're talking two extra
instructions.

And that way the end case is always less than 64 bytes, and so the
tests for 32/16/8 work fine.

And now it's committed to my test tree, so I'm not throwing it away,
but I also won't be working on it any more. If somebody wants to time
it using Arjan's little thing, more power to them.

               Linus
