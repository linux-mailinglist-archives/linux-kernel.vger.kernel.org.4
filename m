Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB65E741024
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjF1LgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjF1LgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:36:18 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8322D63
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:36:17 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-76547539775so449142985a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687952176; x=1690544176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=skyq5jJecX8gUzH/HELKhPjfwUeihuLQSPsIi6eg0Xg=;
        b=nIS0UlARyFAuCW2qzN87wbOXLlUXoB5UUaCDASFT2QFcOUJ5dAClbAzVKhizUmxCjy
         mhVB/WHlMOZrDwgO0nOyfXLYxhb8Y6E3RT7IBLLMojQ7nsxzAdiOs95KTO1EuPEklMxR
         N21rifgjXEp9ZhY2ZwTzV9GjGBDmlVapq99mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687952176; x=1690544176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skyq5jJecX8gUzH/HELKhPjfwUeihuLQSPsIi6eg0Xg=;
        b=RoN3n2KhhXHjLp1OCapG5+KEOiYMxIhhKKtfw+8OGy7dig1dO6JoZFrzls07QZTc7W
         w8PEYQM67uQknvJYXISpydKYFLcquzUdph4KW9uZJdoeMr5JpXAwuSPpLNHDP7UBVzSe
         mZojrFs7Z0w7iKZ5wtc7VhV4pnlvVAoWR57I8ffCiA43HitgizwWsA0ZpkOK/fqU93wG
         yYxVdUB8SMrFQgOQ9AHWRb1GvMgIe7g6RwCfL87esNiZcG+Xhgsc/v+XaB9BG4cNmnZC
         EpurWhx66zJqXAyFaRWDO/ruq7L2gWaCHpVXV/xG4n/x2A/R2oMznVW0j3ZVir2fHu6F
         WQ/A==
X-Gm-Message-State: AC+VfDxp2NuRuGwZc2DYDo4waWq0E7lDpxZl4MVLJczKV0C0ncx7LZsa
        NGasq3M88BlShqYgJK8HmWpmZJC++HgP377mPEaCqQ==
X-Google-Smtp-Source: ACHHUZ6Gl1OP4RcVNbGGhzU3406Wj6rCZC0miZzEmlXqqfBk4SceNoNddiGS96R+W9kKUd3DUR/V6g==
X-Received: by 2002:a05:620a:31a9:b0:765:3eba:1663 with SMTP id bi41-20020a05620a31a900b007653eba1663mr19218243qkb.52.1687952176510;
        Wed, 28 Jun 2023 04:36:16 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id z19-20020a05620a101300b007625382f4d6sm4966758qkj.84.2023.06.28.04.36.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 04:36:15 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-635d9d6daabso28724446d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:36:15 -0700 (PDT)
X-Received: by 2002:a05:6214:c63:b0:62b:6999:ab7b with SMTP id
 t3-20020a0562140c6300b0062b6999ab7bmr36306952qvj.16.1687952174945; Wed, 28
 Jun 2023 04:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230627120058.2214509-1-matteorizzo@google.com>
 <20230627120058.2214509-2-matteorizzo@google.com> <e8924389-985a-42ad-9daf-eca2bf12fa57@acm.org>
 <CAHKB1wJANtT27WM6hrhDy_x9H9Lsn4qRjPDmXdKosoL93TJRYg@mail.gmail.com>
In-Reply-To: <CAHKB1wJANtT27WM6hrhDy_x9H9Lsn4qRjPDmXdKosoL93TJRYg@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 28 Jun 2023 13:36:04 +0200
X-Gmail-Original-Message-ID: <CANiDSCvjCoj3Q3phbmdhdG-veHNRrfD-gBu=FuZkmrgJ2uxiJg@mail.gmail.com>
Message-ID: <CANiDSCvjCoj3Q3phbmdhdG-veHNRrfD-gBu=FuZkmrgJ2uxiJg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add a new sysctl to disable io_uring system-wide
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        jordyzomer@google.com, evn@google.com, poprdi@google.com,
        corbet@lwn.net, axboe@kernel.dk, asml.silence@gmail.com,
        akpm@linux-foundation.org, keescook@chromium.org,
        rostedt@goodmis.org, dave.hansen@linux.intel.com,
        chenhuacai@kernel.org, steve@sk2.org, gpiccoli@igalia.com,
        ldufour@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matteo

On Tue, 27 Jun 2023 at 20:15, Matteo Rizzo <matteorizzo@google.com> wrote:
>
> On Tue, 27 Jun 2023 at 19:10, Bart Van Assche <bvanassche@acm.org> wrote:
> > I'm using fio + io_uring all the time on Android devices. I think we need a
> > better solution than disabling io_uring system-wide, e.g. a mechanism based
> > on SELinux that disables io_uring for apps and that keeps io_uring enabled
> > for processes started via 'adb root && adb shell ...'
>
> Android already uses seccomp to prevent untrusted applications from using
> io_uring. This patch is aimed at server/desktop environments where there is
> no easy way to set a system-wide seccomp policy and right now the only way
> to disable io_uring system-wide is to compile it out of the kernel entirely
> (not really feasible for e.g. a general-purpose distro).
>
> I thought about adding a capability check that lets privileged processes
> bypass this sysctl, but it wasn't clear to me which capability I should use.
> For userfaultfd the kernel uses CAP_SYS_PTRACE, but I wasn't sure that's
> the best choice here since io_uring has nothing to do with ptrace.
> If anyone has any suggestions please let me know. A LSM hook also sounds
> like an option but it would be more complicated to implement and use.

Have you considered that the new sysctl is "sticky like kexec_load_disabled.
When the user disables it there is no way to turn it back on until the
system is rebooted.

Best regards!

-- 
Ricardo Ribalda
