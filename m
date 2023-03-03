Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FA36A9DAE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjCCR3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjCCR27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:28:59 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3831A12BD4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 09:28:58 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f13so13255143edz.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 09:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677864536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/1M9vfaJytncd6N1cPBSSvUSzdGMaKgscxLlZgX7nk=;
        b=NvHGuc6t6ldTaK1dEwm6DeC8+MYOtULrkWn1LzSH1hqsTgMhljrY2JKgJFHvvRm9Up
         enHYNky2G7FAljCdFfbc0vVqvUd09228yXW6Fzs+gtWCQM3YMCqmOFskr3igu/+7lzXt
         nMsnNakrNe1U+FWNXdGQXLgh5l14IS31rrX5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677864536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/1M9vfaJytncd6N1cPBSSvUSzdGMaKgscxLlZgX7nk=;
        b=rTgZ6Zb/t+1vBw04ncuKuhY6pHNaG3bdc+/Vb2OiW8HJMgJjuMgiVC3L1T7tk1MPCL
         yzxXcr6G+b+KbnndDsbFbXlqVVpwCs0QteYU6bDyux79GVGSwmednlslxAeRkorl90wq
         LO0Rt6wGImn/WG9vIiKvfs0Evav1fTWpAG8fV9qUUtE9Hlt5l0wYCoDtgCNSuRaTe8dm
         RYRDFBpWCv3hV6CDWnXC47GV6xmVUP8UWiRDobMe3oIFNaC5xuOurJoQukFvjPgcC7Dh
         GS0ZevGed4vLIUtl1hxe//PAvhZV6RU64jqPc8cT+df13v/xd/QGwbzsOFohf+1w9o/e
         RlFA==
X-Gm-Message-State: AO0yUKXdK4g+BZHENHZCnoppKy48RA8BrKCtRitHSU5a34IX6pDkmItt
        04E8e0diUhIFFx+2oJaJr0ZwneAxc4yHh+g4dSYCOQ==
X-Google-Smtp-Source: AK7set8grh79HHMFduMt+a9aALbMcLHLj0apQKMmQduMTz7ga0WHXzHMR6fGlCWxjrO1A5HOLb8cOw==
X-Received: by 2002:a17:906:2da2:b0:8ae:f1cd:9551 with SMTP id g2-20020a1709062da200b008aef1cd9551mr2157749eji.76.1677864536461;
        Fri, 03 Mar 2023 09:28:56 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id uo17-20020a170907cc1100b008b17ed98d05sm1153979ejc.120.2023.03.03.09.28.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 09:28:55 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id i34so13234555eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 09:28:55 -0800 (PST)
X-Received: by 2002:a17:906:398a:b0:877:747e:f076 with SMTP id
 h10-20020a170906398a00b00877747ef076mr1200645eje.0.1677864535375; Fri, 03 Mar
 2023 09:28:55 -0800 (PST)
MIME-Version: 1.0
References: <C8C4DFDA-998F-48AD-93C9-DE16F8080A02@meta.com>
In-Reply-To: <C8C4DFDA-998F-48AD-93C9-DE16F8080A02@meta.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 09:28:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghhViNZCj4ibSr42HjVGdHro_DWW7wCOQ61p2v59cciw@mail.gmail.com>
Message-ID: <CAHk-=wghhViNZCj4ibSr42HjVGdHro_DWW7wCOQ61p2v59cciw@mail.gmail.com>
Subject: Re: [GIT PULL] zstd changes for v6.3-rc1
To:     Nick Terrell <terrelln@meta.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 10:23=E2=80=AFPM Nick Terrell <terrelln@meta.com> wr=
ote:
>
> Zstd fixes for v6.3

Grr.

This tree had five commits in it.

Of the five, two were merges.

And of those two, ABSOLUTELY NONE had any explanation for them AT ALL.

Honestly, I pulled this, and was then *so* fed up with this kind of
garbage that I just decided that I'm better off without this all.

So this got all undone again, and I'm not pulling this kind of sh*t again.

I'm *very* fed up with having to tell people the same thing over and over a=
gain.

Just stop doing merges if you can't be bothered to do do them right.

                Linus
