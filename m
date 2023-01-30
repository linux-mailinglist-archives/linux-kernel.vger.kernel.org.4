Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406D9680B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbjA3Kmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjA3Kmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:42:33 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC23131E08
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:42:32 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-50e7a0f0cc8so91486397b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTcQjIvbHVmW9cM95PUDKhv0DPJ5bSRN6ntRWQAraOs=;
        b=hvDI4lgPJWRZk3R2QKawvHU7sbVj90oUD4pDMefOvLlJuOFpuHXf7IDx8EPa1sNvuo
         ij2r55/20IbHj9jGPHiJoszw0RE52sEmWQrfJMoLctxQMT8gjxq7P6pE5UGKyyvv05xn
         +l+uuGkP2kW9LIDWh9qSoCV9RntjZdRQZheoz8ZUj9Y5V+iYW1RWtYG0ou+O7/DfPMoC
         6aYqvMd9jKjXboyHdFk35mDYfzxAojJuoPnTkvvHmkTLHsiOfWz+UqJvX7KF0iMhhr01
         scgqV81iLwimaCSfN7SGs+4KJLD5eZbn+JldkTlRErQFW0bfQO7PygVOueO6pnbtCVjy
         BBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTcQjIvbHVmW9cM95PUDKhv0DPJ5bSRN6ntRWQAraOs=;
        b=ylQr3w+kd7Rc2KHCIs3+677gTw6nHEuiMrMMDn6IF4Dn1j6l05tylSNWLY4LYW1fLP
         62JoynCm2DThpJtgbzmlMkFS5NLlxO5pklH842ibpMdverRUcde4XeplbX0SdsU16jfB
         /if5E/1N61E3GBQZX1hN/jQnuJz+38arnU1FaXRsCziEkdhaYYui2VJ8dFok6lKCA2ZD
         Eubb+xxArJIJ2hiqQfr5YA2c7RJiyz0g7BKjs10mZU3MoalSm/fSZutniWhiJGurMjew
         0riLwECo9mkWjclgE3jLzP9YM6VnlB45/MoAMbxnljg9JcAnUJF/b7+OXMhdVRQgWLFe
         ig+A==
X-Gm-Message-State: AO0yUKWo6zJZFhKbvezo01YVeyc4d9Llw/amlDRADGlUyhbJOjXWYeso
        Egw2iihezeKVTBKvkcnBKsar+2/An6dyWgx6BLjTtQJQHsJDifyb
X-Google-Smtp-Source: AK7set9g7Y3OqYeylx2cTaM4vJZeY9JJp5UI012KzYSTcxzdLerxCAhlffcILUniJNZLW4MYBGDVIIXeNZMefeeimB8=
X-Received: by 2002:a05:690c:706:b0:506:6952:b9c9 with SMTP id
 bs6-20020a05690c070600b005066952b9c9mr2387036ywb.477.1675075351739; Mon, 30
 Jan 2023 02:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20230127154339.157460-1-ulf.hansson@linaro.org> <5743fb1b-eb4b-d169-a467-ee618bcd75f5@kernel.dk>
In-Reply-To: <5743fb1b-eb4b-d169-a467-ee618bcd75f5@kernel.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 Jan 2023 11:42:20 +0100
Message-ID: <CACRpkdbyOcTBbv+EmDcnMXDjgiP1HKpuYgMF_JhTMOnLj7MA3g@mail.gmail.com>
Subject: Re: [PATCH] block: Default to build the BFQ I/O scheduler
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 4:48 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 1/27/23 8:43=E2=80=AFAM, Ulf Hansson wrote:
> > Today BFQ is widely used and it's also the default choice for some of t=
he
> > single-queue-based storage devices. Therefore, let's make it more
> > convenient to build it as default, along with the other I/O schedulers.
> >
> > Let's also build the cgroup support for BFQ as default, as it's likely =
that
> > it's wanted too, assuming CONFIG_BLK_CGROUP is also set, of course.
>
> This won't make much of a difference, when the symbols are already in
> the .config. So let's please not. It may be a 'y' for you by default,
> but for lots of others it is not. Don't impose it on folks.

This part:

 config BFQ_GROUP_IOSCHED
        bool "BFQ hierarchical scheduling support"
        depends on IOSCHED_BFQ && BLK_CGROUP
+       default y
        select BLK_CGROUP_RWSTAT
        help

should certainly be fine. If you select BFQ then it is helpful to get the
group scheduler as well if you have BLK_CGROUP, so Ulf could you
please send this part separately with that motivation?

For the selection of BFQ_IOSCHED:

As major distributions have it in their .configs it is kind of established
standard for them.

The general policy is that the kernel should
provide "sensible defaults", so it is easy to make correct choices even
if starting from scratch, relying on a few different out-of-kernel .configs
from different distros isn't helpful for someone starting from scratch.

What about default enabling it when enabling the relevant subsystems?

The udev script looks like so:

ACTION=3D=3D"add", SUBSYSTEM=3D=3D"block", ENV{DEVTYPE}=3D=3D"disk", \
  KERNEL=3D=3D"mmcblk*[0-9]|msblk*[0-9]|mspblk*[0-9]|sd*[!0-9]|sr*", \
  ATTR{queue/scheduler}=3D"bfq"

i.e. drivers/[mmc|memstick|scsi|ata|cdrom]

This can be achieved by adding weak reverse dependencies to these
subsystems, meaning it will not be default-selected unless you make
use of one of them, and even then it can be manually removed (in
difference from using "select").

Example:

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index 6f25c34e4fec..52fe9d7c21cc 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -37,6 +37,7 @@ config PWRSEQ_SIMPLE
 config MMC_BLOCK
        tristate "MMC block device driver"
        depends on BLOCK
+       imply IOSCHED_BFQ
        default y
        help
          Say Y here to enable the MMC block device driver support.

Since all MMC devices will use BFQ on all major distributions this
makes sense to me. Also it is a policy that can be chosen by each
subsystem maintainer individually.

There is however the bigger problem of how to make a system come
up on eg MMC with BFQ on from the start, which I battled before but
it can be treated as an orthogonal problem.

Yours,
Linus Walleij
