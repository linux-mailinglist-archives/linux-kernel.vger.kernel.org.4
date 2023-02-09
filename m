Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710A469118F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjBITtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjBITs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:48:57 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2594F67798
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:48:55 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cq19so349515edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 11:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uyyumaK9xIPRojo79Q77XEBPKCDiPO3uA+JJHpfAEgA=;
        b=AZFy9HZ53vfM3YDTX4dK7I32YlhT5/F/iQr2XxE+3tLHv580MbFNKnKBzBpuoX/slw
         PjfvwT6grUZ3pOe8wLygEzYEtv1brf6zchhh0beA9epwiFJouS5D4FAEx9mHBiCSfa2n
         6Hcp/yvPEzTW8cxxyAYGalExsZQLzgObV3DpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyyumaK9xIPRojo79Q77XEBPKCDiPO3uA+JJHpfAEgA=;
        b=QIaJENynpvQm4p9VJ7RBLnTte1m4vibYMZbUC988IaQQiVkqLFALEoDSAYy6jTfx7b
         LxZy70/9ZAPac1qlo0wEQJdciUiG22+SW6EUiWHJsUuP4q3+KJRk+mdGXukEjABt3eiW
         HCL16ErtWSW4EoLah9CrNrkcWs+lvXARd5r834VuEDDclhKMYQVzMa+KzjpwjKKQQhvx
         +mi1wsf6JG3tYbx7wN+LRWoFPwb9e2QKMW5MqCBjd70k18bXhoMpMLWiSuqKS1TVyMvL
         pkBFnNCKpkQB49ctyMsQ8lUFrHpAUK9ngKEnKtKq77sxQNs08FmbJYebiScmj/Z3iOpH
         azdA==
X-Gm-Message-State: AO0yUKVreDdTz7M/MNDAkFZGOmJGOYg59OtxFilmWaXfPhi3MLa1v1kA
        EAbcQVxXNdgv/PZDVJu2HH8erDEfP+CDpNiqA0A=
X-Google-Smtp-Source: AK7set9Veah4kzXbWOzQAT1r4N6N57hobqWZfb3925CiCijzsVjg9KOPRxgtzlKCvRFDDXEyOMQr1g==
X-Received: by 2002:a50:d61d:0:b0:4ab:161b:66be with SMTP id x29-20020a50d61d000000b004ab161b66bemr7565108edi.0.1675972133160;
        Thu, 09 Feb 2023 11:48:53 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id t27-20020a508d5b000000b004a20fa37286sm1223021edt.85.2023.02.09.11.48.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 11:48:52 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id qb15so7670922ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 11:48:52 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr2452063ejw.78.1675972132059; Thu, 09 Feb
 2023 11:48:52 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <f6c6d42e-337a-bbab-0d36-cfcc915d26c6@samba.org> <CAHk-=widtNT9y-9uGMnAgyR0kzyo0XjTkExSMoGpbZgeU=+vng@mail.gmail.com>
In-Reply-To: <CAHk-=widtNT9y-9uGMnAgyR0kzyo0XjTkExSMoGpbZgeU=+vng@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Feb 2023 11:48:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=whprvcY=KRh15uqtmVqR2rL-H1yN6RaswHiWPsGHDqsSQ@mail.gmail.com>
Message-ID: <CAHk-=whprvcY=KRh15uqtmVqR2rL-H1yN6RaswHiWPsGHDqsSQ@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 11:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I guarantee that you will only slow things down with some odd async_memcpy.

Extended note: even if the copies themselves would then be done
concurrently with other work (so "not faster, but more parallel"), the
synchronization required at the end would then end up being costly
enough to eat up any possible win. Plus  you'd still end up with a
fundamental problem of "what if the data changes in the meantime".

And that's ignoring all the practical problems of actually starting
the async copy, which traditionally requires virtual to physical
translations (where "physical" is whatever the DMA address space is).

So I don't think there are any actual real cases of async memory copy
engines being even _remotely_ better than memcpy outside of
microcontrollers (and historical computers before caches - people may
still remember things like the Amiga blitter fondly).

Again, the exception ends up being if you can actually use real DMA to
not do a memory copy, but to transfer data directly to or from the
device. That's in some way what 'splice()' is designed to allow you to
do, but exactly by the pipe part ending up being the "conceptual
buffer" for the zero-copy pages.

So this is exactly *why* splicing from a file all the way to the
network will then show any file changes that have happened in between
that "splice started" and "network card got the data". You're supposed
to use splice only when you can guarantee the data stability (or,
alternatively, when you simply don't care about the data stability,
and getting the changed data is perfectly fine).

            Linus
