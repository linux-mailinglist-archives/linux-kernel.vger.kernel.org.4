Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4F170E7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbjEWVu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbjEWVu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:50:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937EBE58
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:50:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3095b1b6e02so10612f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1684878639; x=1687470639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J6tMHyvFrOcwG0jlhJO8dd6aDQxsBeyHtoQoAF3lB8=;
        b=mzhpbjdw1OSIUhqFFtQGUP/6Jyij6fJOYZ32o2BNK8tezWHzLOxA7m856Zib1HkW86
         RcbBSwkYCL6gg54LGBF4jnz8aa61CtX17MvQi3tV3oigRpmosKghef2D3QGkW8hA6XKO
         zF1WRY8NOMmtZ2nF+8WZZ25zJ0rzL1dH32Nk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878639; x=1687470639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J6tMHyvFrOcwG0jlhJO8dd6aDQxsBeyHtoQoAF3lB8=;
        b=ApkQdVSaPF57LKL+CabzHnJkE/BUCjtAUL1YCBnhrC0UWP4y1lpgilS6jMYIBgfoVo
         Eif0GzsxhCDN3zbDFNnreMWpY4fSgawDGewgnKapoPlnUFS70/D1KwgAwSJuAEOr2F3h
         lZaqlSp2lx7UDJm+ZVPi0eVc2yxoJs3eL9tggpEFISwOZlImrrn1Wnj+okhdRNh+fV4x
         ZwfZegeabMtrmXZSVdhYBvffyZJLfsvNWXDPL7EM6u4yVnTD2vmOGJPFb5D60Bwm6a2o
         ZLBE9PLsAqLdJXW5lLiRC5JlJUi8SxQq8JNeMEVKxTLvn19RPQvWgwoAKv8S/9291S8V
         Jewg==
X-Gm-Message-State: AC+VfDyMvettOv542Sad9WmKRHoX81XqxzClN0F208nu1UYmK8tR+oWl
        hwBg/f8wzgba6xc9CYDUP90cRsn2yb0EbrRIOaE0zg==
X-Google-Smtp-Source: ACHHUZ77ktq2SZqtw0VOQD9K5mXATk8+8O9mStErD1qNFrmPGlSLofDwqDj1JpXjweKSZfnTpsQ7WVrhfRXOS4B83QM=
X-Received: by 2002:a5d:43cb:0:b0:306:2c39:5d52 with SMTP id
 v11-20020a5d43cb000000b003062c395d52mr11022072wrr.57.1684878639084; Tue, 23
 May 2023 14:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230523181624.19932-1-ivan@cloudflare.com> <CAHC9VhTtbbiwyOqiFfveWF6hV-Wb5cuhk0r8EdUi0kVb0v4P_Q@mail.gmail.com>
In-Reply-To: <CAHC9VhTtbbiwyOqiFfveWF6hV-Wb5cuhk0r8EdUi0kVb0v4P_Q@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Tue, 23 May 2023 14:50:27 -0700
Message-ID: <CABWYdi2A8ZfVJjmDpwiNhvYD8m-+PC5MsNRzofX7SXn2TTyY9Q@mail.gmail.com>
Subject: Re: [PATCH] audit: check syscall bitmap on entry to avoid extra work
To:     Paul Moore <paul@paul-moore.com>
Cc:     audit@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 12:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> Before seriously considering something like this, I would really like
> to see some time put into profiling the original overhead and some
> designs on how that could be improved.  Without that, patches like
> this look like drive-by band-aids which have already caused enough
> headaches for audit maintenance.

Hello Paul,

Could you elaborate on what exactly you would like to see added? It's
not clear to me what is missing.

There's a benchmark in the commit description with the numbers
attached, which quantifies and explains the existing overhead. In my
experience, people on Linux mailing lists frown upon external links to
images, but if it helps to visualize the effects, I have some
flamegraphs for the benchmark from the commit message:

* 10 rules, before:
https://r2.ivan.computer/audit-syscall-bitmap/flamegraph-before.svg?s=3Daud=
it
* 10 rules, with patch applied:
https://r2.ivan.computer/audit-syscall-bitmap/flamegraph-after.svg?s=3Daudi=
t

Here's a couple extra:

* 0 rules, auditd running:
https://r2.ivan.computer/audit-syscall-bitmap/flamegraph-after.svg?s=3Daudi=
t
* 11 rules (extra rule matching the running syscalls):
https://r2.ivan.computer/audit-syscall-bitmap/flamegraph-after-match.svg?s=
=3Daudit

The bitmap design mirrors what tracepoints implement for syscall entry/exit=
:

* https://elixir.bootlin.com/linux/v6.4-rc1/source/kernel/trace/trace_sysca=
lls.c#L585

I am happy to consider a different design if you have one in mind.
