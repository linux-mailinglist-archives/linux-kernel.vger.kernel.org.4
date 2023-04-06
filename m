Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00316DA004
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbjDFSkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238976AbjDFSkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:40:10 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FD75BA9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:40:08 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id k17so47138102ybm.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680806408; x=1683398408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tDxQywOSdJZ62hvlZ9uXSvV2uAIfe+HPEX1kpCQThA=;
        b=KGGEJZb1ldKi8UdMzGq8Tt+Tm+ZyQnwd81KyOCWi4ye0hFgB8/A7re8Vs4xxbtmwTt
         ylIsmLiEj3g0BH20A3VqFhAf7Kqgoww0lS+8m9QQtpQzfdYXl8ep+slb4mgAhCIKsKb2
         rLUJXnnfDZllftWWtjS9NC8R/Hj+A9jm9qxeCAreWfNiL7A3UFt5WgeUoewerExwUQ8P
         Q1McItq399p6DecGsak2kZwAisfmnsrreS4jTpE5E/eJqJ/w2yT4i2LyVvWVQx3qy485
         gMpy97uHfcltSv9RIw1hGZJQau0kg8YHx1YaEZDUnyLjJcAY82BzrvSnI9GFIIBwXPQg
         Tx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806408; x=1683398408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tDxQywOSdJZ62hvlZ9uXSvV2uAIfe+HPEX1kpCQThA=;
        b=Rj9eyhGvulcA0gobSDkxmdjUaQrHReQ/80bCtnd696wmYOB/ceU+gN+xhBrHPAAZ8O
         2jPUbfAvY568XLmH6I1Xp+OaLHvOXnQ/Gf/cC/K7eXcaVMA9CB17hjAR52UZqK74ejJL
         +QoIfLC8Yp4mItmimwAWfr6O0MwpXYJvGYSNRPk9bsntUIiN7VpBinhMSD6Cm2kztsor
         hVTBsZiW39q/KcODRsZ+iCG4oRdrM6lxPYiZZHKb9YD7gAupt6TQZtwIOph8O/xtevQb
         FZldpKY7idgVQgHQ7qa61b21/Ek9rRXV+pWaJ7CA7nNsMrTxR5aErN4neAHXVe9zKJjt
         XXUw==
X-Gm-Message-State: AAQBX9d7m6gbKVxDJ0PB9GR9UeGY0grVmnUyhVMSg8QcBVH9UfDtHoyy
        B/zjbO+vFh4VHKFCgycK4RcLEbLnJFNW0SPeiVXvqDMIM2IoX0Aofg==
X-Google-Smtp-Source: AKy350bNH2UiDypg7pjawpP0vuRPdf2OqbGI2sZFumvAbeJ6ID8tOLqFDe39K+qMQ++FgBttLW/Oh3B1Ljy6uUEAQcc=
X-Received: by 2002:a25:cfd8:0:b0:b8b:fca4:7454 with SMTP id
 f207-20020a25cfd8000000b00b8bfca47454mr1508238ybg.4.1680806407972; Thu, 06
 Apr 2023 11:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <ZC8Dbux56HbJjpTy@char.us.oracle.com>
In-Reply-To: <ZC8Dbux56HbJjpTy@char.us.oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Apr 2023 14:39:57 -0400
Message-ID: <CAHC9VhQ2rLpjczvb4993fQiMau7ZXLe8aTLtMZO_iF42w=1frg@mail.gmail.com>
Subject: Re: Semantics of blktrace with lockdown (integrity) enabled kernel.
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, nathanl@linux.ibm.com, junxiao.bi@oracle.com,
        joe.jin@oracle.com, Eric <eric.snowberg@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 1:38=E2=80=AFPM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> Hey Jens, Paul, James, Nathan,
>
> We are trying to use blktrace with a kernel that has lockdown enabled and=
 find that it cannot run.
>
> Specifically the issue is that we are trying to do is pretty simple:
>
> strace -f blktrace -d /dev/sda -w 60
>
> [pid 148882] <... mprotect resumed>)    =3D 0
> [pid 148881] openat(AT_FDCWD, "/sys/kernel/debug/block/sda/trace0", O_RDO=
NLY|O_NONBLOCK <unfinished ...>
> [pid 148882] sched_setaffinity(0, 8, [1]) =3D 0
> [pid 148881] <... openat resumed>)      =3D -1 EPERM (Operation not permi=
tted)
>
> which fails. The analysis from Eric (CCed) is that
>
> All debugfs entries do not exist until blktrace is run.  It is opening
> /sys/kernel/debug/block/sda/trace0 which isn=E2=80=99t there normally. Wh=
ile running the utility,
> to place something in it, it must have the write permission set.  When ex=
iting out of
> blktrace, the entry is gone, both on a machine running with secure boot e=
nabled
> and one with it disabled.  Which also indicates the write permission was =
set,
> otherwise the entry would still be there.
>
> The fix is simple enough (see attachment) but we are not sure about the s=
emantics of what
> lockdown has in mind.
>
> Looking at the include/linux/security.h the LOCKDOWN_TRACEFS exists which=
 would
> imply that it is expected that operations with tracefs *should* work with=
 lockdown (integrity mode).
>
> But at the same point, debugfs writable attributes are a nono with lockdo=
wn.
>
> So what is the right way forward?

What did you use as a basis for your changes?  I'm looking at the
patch you sent and it appears to be making a change to a
debugfs_lockdown_whitelisted() function defined in
fs/debugfs/internal.h which does not exist in Linus' tree.  If I
search through all of the archives on lore.kernel.org the only hit I
get is your email, so it seems doubtful it is in a subsystem tree
which hasn't made its way to Linus yet.

Before we go any further, can you please verify that your issue is
reproducible on a supported, upstream tree (preferably Linus')?

--=20
paul-moore.com
