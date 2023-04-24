Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF456ED617
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjDXUYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjDXUYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:24:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE2F5FCD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:24:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5066ce4f725so7179111a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682367882; x=1684959882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxCLtSdGwxBRfdBDT+38EgcoqndbjUK9jgH7vNQBcQ8=;
        b=YwbPHFY0+bJ35N9w1d1LfBOZaXSG0x7/b5xc08r7fmyx4DxT7cWXxD5RHphwK817zm
         bS5imXBEJmBUj/+m9sOXC1UxdO8xqDe13Q11pvpoFElA/F7LvlBHYHLt4xTfHZ5jpb/o
         styGfIId6cQ3TynnIoocr9VknReWBBVFXlJz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682367882; x=1684959882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxCLtSdGwxBRfdBDT+38EgcoqndbjUK9jgH7vNQBcQ8=;
        b=jfqCXzIDAIgumcqsR1Z2UNLlvpwKRI3cZiu+dqv59rrKtNx7QRTplyxxxD5R9iWaRS
         HPJ3dYmctah+xEU4881X0QGB8mlUFKYbPPYfMoEVo9fo+czVo572k1pHXMneoMemMUvA
         UzSB97cB29BjrT++NZ89WlnOeqat2GjGw+jYxE4Yz+kk2hH+/6Ps3yMcmUGhnSutx1u0
         ARqscixpwz9fP27WA9efMj4tTTMy4PhJTH+HZzlllNme10u50xdk/CJ+SVNBmPfY/or3
         8XWql7LZO+vuzRpZgqdD4tLlrbM80Ozmw2WNhzWLsNLO9V7oHCJM53phnkcM5u4/sQ3n
         Cpfw==
X-Gm-Message-State: AAQBX9f06RW5VKRYez+DVeeDoyfqL8LpNrJShWWsRURbFvDI2BxXHVHg
        ZF9AXnke1XRZoYHB0Y1jjNvW2OoGKMJaZAwCfUXfaBqD
X-Google-Smtp-Source: AKy350ZevzNxIEdLDS4pvkSj/aFseRGck6dA4be1rOgKHzZcodgPFn8FJXrdgIbHKMSqiMdLGzLyTA==
X-Received: by 2002:a17:906:71c2:b0:94e:e35f:6fed with SMTP id i2-20020a17090671c200b0094ee35f6fedmr11310550ejk.75.1682367881983;
        Mon, 24 Apr 2023 13:24:41 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906494500b0094eaa31aa63sm5921690ejt.77.2023.04.24.13.24.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 13:24:41 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-50847469a7fso7168485a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:24:41 -0700 (PDT)
X-Received: by 2002:aa7:d796:0:b0:506:b8ca:e07e with SMTP id
 s22-20020aa7d796000000b00506b8cae07emr11668877edq.11.1682367880901; Mon, 24
 Apr 2023 13:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
In-Reply-To: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 13:24:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
Message-ID: <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
Subject: Re: [GIT PULL] pidfd updates
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Apr 21, 2023 at 6:42=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> This adds a new pidfd_prepare() helper which allows the caller to
> reserve a pidfd number and allocates a new pidfd file that stashes the
> provided struct pid.

So I've pulled this, but I have to say that I think the "cleanup" part
is pretty nasty - and that's also visible in the interface.

In particular, pidfd_prepare() ends up returning two things, so you
have that ugly "return by reference of the third arguments", but you
also end up not being able to have one single cleanup, you have to
(continue) to do a pair of them:

    put_unused_fd(pidfd);
    fput(pidfd_file);

and I really think the old model of just having a single return value,
and doing a single "close()" was a much nicer in many ways.

Now, the reason I pulled is that I agree that actually making the fd
*visible* to user space is a big mistake.

But I really think a potentially much nicer model would have been to
extend our "get_unused_fd_flags()" model.

IOW, we could have instead marked the 'struct file *' in the file
descriptor table as being "not ready yet".

I wonder how nasty it would have been to have the low bit of the
'struct file *' mark "not ready to be used yet" or something similar.
You already can't just access the 'fdt->fd[]' array willy-nilly since
we have both normal RCU issues _and_ the somewhat unusual spectre
array indexing issues.

So looking around with

    git grep -e '->fd\['

we seem to be pretty good about that and it probably wouldn't be too
horrid to add a "check low bit isn't set" to the rules.

Then pidfd_prepare() could actually install the file pointer in the fd
table, just marked as "not ready", and then instead of "fd_install()",
yuo'd have "fd_expose(fd)" or something.

I dislike interfaces that return two different things. Particularly
ones that are supposed to be there to make things easy for the user. I
think your pidfd_prepare() helper fails that "make it easy to use"
test.

Hmm?

Anyway, I think it's an improvement even so, but I wanted to just say
that I think this could maybe have been done with a nicer model.

               Linus
