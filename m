Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F2B6C1D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjCTRU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjCTRTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:19:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B185B2DE74
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:15:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i5so2704724eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679332487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVgWDorTw0IdLkGaMvMMy9AFx6YqJaCeHBK8myDlk6A=;
        b=TkgcSoMo4utawLQICl8E4yxmgVen7z6kShX4LbzEW3s5Q4Y60awf8hh7aND4zD+iSi
         /kfMcbvY+HBZ5nnG1U1MMcm19nvPnKekv9xjLRHsjuKLA6F+LRhy1+vCikQpGaMBXBaz
         FUiFHH6ZoQxI6MWN4xZOKcfxkoAqoipvC453s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVgWDorTw0IdLkGaMvMMy9AFx6YqJaCeHBK8myDlk6A=;
        b=utFvnpe7izHNKcp2ah4WeqaE58+y+quNtqoyal79J5pWLmu0hXGZ659IqpXBCXZ8wO
         U9EuB/GFKDMz3P2Anlyl7JXVpBnPa4uU46liWFKoPdIqFCRoqFh/xYlktFY/ewZaJdmD
         Sx/qHk3gS6oDZBscBxppv5g4sjvC2/GYYRRyHyNKJYeiZvzJZ3Kjs4fp0MY+nB1PMpRX
         HRyngqRNyH5zXbZzXJzMHEQKL2AnYcqaXxtATVeXZTONt/HaQEJ+nmWdQbeTibkV2XJS
         yPUpX0MpKYjfAmN5us71u4Nd6a3dkdvZO9YplRlj1P2MbqmsCWm1DCM7WCBiZ4X/+gTV
         YjVQ==
X-Gm-Message-State: AO0yUKXVnl+sscACPPFuxSNQN3qBUrccYFOdElkGNpNcopyoVXu13Stq
        uOqnBbNhPyasmnsYn+mDePVdrz67LfP9qaZ8bozSEU6m
X-Google-Smtp-Source: AK7set+WQBjZHrEetaXoxOZlRgwQg74GMQbTB6uPnjv4AahqR3KDk0fkQpeY+1jluB3LlgOnPB+DEw==
X-Received: by 2002:a17:906:f6c6:b0:931:ad32:79ed with SMTP id jo6-20020a170906f6c600b00931ad3279edmr9343250ejb.12.1679332486709;
        Mon, 20 Mar 2023 10:14:46 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090668cc00b008d044ede804sm2637940ejr.163.2023.03.20.10.14.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:14:46 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id i5so2704401eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:14:45 -0700 (PDT)
X-Received: by 2002:a17:907:6e28:b0:933:f6e8:26d9 with SMTP id
 sd40-20020a1709076e2800b00933f6e826d9mr2790573ejc.15.1679332485637; Mon, 20
 Mar 2023 10:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230320071442.172228-1-pedro.falcato@gmail.com> <20230320115153.7n5cq4wl2hmcbndf@wittgenstein>
In-Reply-To: <20230320115153.7n5cq4wl2hmcbndf@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Mar 2023 10:14:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
Message-ID: <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
To:     Christian Brauner <brauner@kernel.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Mar 20, 2023 at 4:52=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> So before we continue down that road should we maybe treat this as a
> chance to fix the old bug? Because this behavior of returning -ENOTDIR
> has existed ever since v5.7 now. Since that time we had three LTS
> releases all returning ENOTDIR even if the file was created.

Ack.

I think considering that the return value has been broken for so long,
I think we can pretty much assume that there are no actual users of
it, and we might as well clean up the semantics properly.

Willing to send that patch in and we'll get it tested in the crucible
of the real world?

                Linus
