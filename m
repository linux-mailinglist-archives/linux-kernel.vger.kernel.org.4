Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E752E6F20B4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346220AbjD1WKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjD1WKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:10:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E4D44A0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:10:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50a145a0957so21596056a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682719840; x=1685311840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4iO4gL3f17c/4O7Vnz35nnzwF/arL2tqtDIT8Zr1GM=;
        b=TRz4P5zya+02wAD5k9pUGU3E1ZPd4oKqZWJpJRd66+EHgLth+bwWuUxENORKbFzOfy
         MfOoADTIknRTqnlQN+1eQ7qPTVwnhtZTAHWcsCZYep9onAv1rYD2UEqf+3IO8Dnf8oFR
         IrUNjfSMcGgnSfSijcNrJFzho/VrrMpvnCWaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682719840; x=1685311840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4iO4gL3f17c/4O7Vnz35nnzwF/arL2tqtDIT8Zr1GM=;
        b=Njmr/LbgJr4My2vlibZ3Uck2Vfx2L4enfSsPzJQVXg+hfakObCe0JIcH1J8DdcnrzC
         gizuzl3YGPlCutE1lx1dY8jYNzR3kYfkhlxw5a2O4lIDoNcvrPlsG/VNiqjLgjyA51qm
         2Zya0jszace2P//yfGDvkKz9ItuQBT3QStCxOvrKHPlZhefccCQRF3p2fRVLdgcKiXSy
         YWpW209laMUPlshRyL9HJcRIr5GmqaVBd4sCDfWmbsLLfAhC8lZ6ufvN0qo+FCwQn5vv
         EceU6bRaPob05kWUDiDX7tU5eMJ/nfrKl0CeqtdgOsDu9pCTZ1UjqQveNsFaWfGWv9ge
         Yk2A==
X-Gm-Message-State: AC+VfDy1jv8l1AvtRrbfrPxISUnc9l5H8ayE63Z2oCTKnzffgv2TcxTG
        HJ4f5uAN1OSYzgAbytENaM450XWff8pWO3HqMuSGIw==
X-Google-Smtp-Source: ACHHUZ6hiWyBgyv9UpiXoIhOJeyzYkRaRU77bxBbBnlwFE5iN5bdoWZuCaElDWjfWmPxX9orTrh0OQ==
X-Received: by 2002:a05:6402:510d:b0:506:bd27:a2f0 with SMTP id m13-20020a056402510d00b00506bd27a2f0mr219611edd.15.1682719839753;
        Fri, 28 Apr 2023 15:10:39 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7d0cb000000b0050687dbb5dasm9601379edo.31.2023.04.28.15.10.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 15:10:39 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-50a145a0957so21595935a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:10:39 -0700 (PDT)
X-Received: by 2002:a17:906:9f07:b0:94f:2a13:4df4 with SMTP id
 fy7-20020a1709069f0700b0094f2a134df4mr9961168ejc.22.1682719391201; Fri, 28
 Apr 2023 15:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <ZErgOfOLrBwluTbd@gmail.com>
In-Reply-To: <ZErgOfOLrBwluTbd@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Apr 2023 15:02:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-t1N7a2dH=y7MCjctk_Zw77C8_V6cfS-UC7f3jXAF6g@mail.gmail.com>
Message-ID: <CAHk-=wj-t1N7a2dH=y7MCjctk_Zw77C8_V6cfS-UC7f3jXAF6g@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler changes for v6.4
To:     Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
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

On Thu, Apr 27, 2023 at 1:51=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>  - Fix performance regression introduced by mm_cid

This causes a conflict with commit b20b0368c614 ("mm: fix memory leak
on mm_init error handling") that came in through the MM tree.

That conflict is trivial to resolve, and I did so.

Except I also checked my resolution with what was going on in
linux-next, and it's different.

I'm pretty sure the resolution in linux-next is wrong, but I thought
I'd mention this, since clearly this wasn't caught in linux-next.

Or maybe it's me that did it wrong, but hey, that couldn't actually
happen, could it?

                  Linus
