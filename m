Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C16D2179
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjCaN2g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 09:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjCaN2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:28:34 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CA51EFCF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:28:19 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id y4so89669998edo.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680269298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9kQgeyK17OKmqbFzH4IRm1k3jZcfLqZAx4ecVwrUaE=;
        b=mF9loRzn77b0Bbcs2FoGj+EummwxhbXK1B/RK53Tl/ZX4Zbae8cJCt6m1tOXPPmNbq
         lAfncF/2pV/9THVRR2BINq1p290eRhG7pDgyY9bz3XPRuSYTqXKU0GsH/wDZW1butkjT
         dYbW/CAyTELzG5vADRTzA1qwXeu33M9hAB59jaBmDIJi1RFMdno1eTv4LjmlVPGCp0dI
         SDzkAVzbmPUTCbIg5pk0ppD0wGVt91vhL7GcL3XrUUywkBJkyfwlSgcGRcdOaVtkBpn2
         x0RfRvgsoe57aM0htspj+s/wUHov94BqPJsjMgkGB9hynA8psVzgXvLpgdF+evTKJZrX
         wgBQ==
X-Gm-Message-State: AAQBX9eQl/fibVN8c8cbOa0GRxULCPEy+egZspoRhOTsaNKQqsrDZeEN
        Gc6xhsSIPrLKREv+uO48VArz2g5KYTQkuw==
X-Google-Smtp-Source: AKy350ahXSxuC4EF9SDrkQBsTS+LcXS003CreW1XJr0qVUMCuR6H2bkImL56JKvgx1HnTQvuUOv5Mw==
X-Received: by 2002:a05:6402:28c:b0:501:cde8:c523 with SMTP id l12-20020a056402028c00b00501cde8c523mr26838465edv.6.1680269297354;
        Fri, 31 Mar 2023 06:28:17 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id v14-20020a50954e000000b004fc649481basm1043669eda.58.2023.03.31.06.28.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 06:28:16 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id ew6so89527898edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:28:16 -0700 (PDT)
X-Received: by 2002:a17:907:a412:b0:947:9f2a:8ca4 with SMTP id
 sg18-20020a170907a41200b009479f2a8ca4mr1531769ejc.9.1680269296254; Fri, 31
 Mar 2023 06:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st>
In-Reply-To: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st>
From:   Neal Gompa <neal@gompa.dev>
Date:   Fri, 31 Mar 2023 09:27:39 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-hO5F5AbjftFXYmVEJadkUAoV6-PUbk1HVTQnTRyD1mg@mail.gmail.com>
Message-ID: <CAEg-Je-hO5F5AbjftFXYmVEJadkUAoV6-PUbk1HVTQnTRyD1mg@mail.gmail.com>
Subject: Re: [PATCH 0/5] mailbox: apple: Move driver into soc/apple and stop
 using the subsystem
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Janne Grunau <j@jannau.net>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 9:14 AM Hector Martin <marcan@marcan.st> wrote:
>
> Once upon a time, Apple machines had some mailbox hardware, and we had
> to write a driver for it. And since it was a mailbox, it felt natural to
> use the Linux mailbox subsystem.
>
> More than a year later, it has become evident that was not the right
> decision.
>
> Linux driver class subsystems generally exist for a few purposes:
> 1. To allow mixing and matching generic producers and consumers.
> 2. To implement common code that is likely to be shared across drivers,
>    and do so correctly so correct code only has to be written once.
> 3. To force drivers into a "correct" design, such that driver authors
>    avoid common pitfalls.
>
> The mailbox subsystem does not do any of the above for us:
> 1. Mailbox hardware is not generic; "mailbox" is a vague idea, not a
>    standard for communication. Almost all mailbox consumers are tied to
>    one or a few producers. There is practically no mixing and matching
>    possible. We have one (1) consumer subsystem (RTKit) talking to one
>    (1) mailbox driver (apple-mailbox). We might have a second consumer
>    in the future (SEP), but there will still be no useful
>    combinatronics with other drivers.
> 2. The mailbox subsystem implements a bunch of common code for queuing,
>    but we don't need that because our hardware has hardware queues. It
>    also implements a bunch of common code for supporting multiple
>    channels, but we don't need that because our hardware only has one
>    channel (it has "endpoints" but those are just tags that are part of
>    the message). On top of this, the mailbox subsystem makes design
>    decisions unsuitable for our use case. Its queuing implementation
>    has a fixed queue size and fails sends when full instead of pushing
>    back by blocking, which is completely unsuitable for high-traffic
>    mailboxes with hard reliability requirements, such as ours. We've
>    also run into multiple issues around using mailbox in an atomic
>    context (required for SMC reboot/shutdown requests).
> 3. Mailbox doesn't really do much for us as far as driver design.
>    If anything, it has been forcing us to add extra workarounds for the
>    impedance mismatches between the subsystem core and the hardware.
>    Other drivers already are inconsistent in how they use the mailbox
>    core, because the documentation is unclear on various details.
>
> The interface for mailboxes is very simple - basically just a send() and
> a receive callback. This series quite literally just rips out the
> middleman, and connects both sides together directly. There just isn't
> anything useful the mailbox common code is doing for us - it's just a
> pile of complexity in the middle that adds bugs, impedance mismatches,
> overhead, and offers no extra features we can use.
>
> This series offers:
>
> - A modest reduction in overall code size (-27 net lines excluding #1).
> - Fixes a pile of bugs related to using the mailbox subsystem and its
>   quirks and limitations (race conditions when messages are already in
>   the queue on startup, atomic issues, the list goes on).
> - Adds runtime-PM support.
> - Adds support for the FIFOs in the mailbox hardware, improving
>   performance.
> - Simplifies code by removing extraneous memory allocations (the
>   mailbox subsystem requires consumers to pass pointers to messages,
>   instead of inlining them, even though messages are usually only one or
>   two registers in size) and the requisite cleanup/freeing in the
>   completion path.
>
> In addition, it paves the way for future Apple-specific mailbox
> optimizations, such as adding the ability to de-duplicate message sends
> if the same message is already known to be in the FIFO (which can be
> done by keeping a rolling history of recently sent messages). This is
> useful for doorbell-style messages, which are redundant to send more
> than once if not yet processed.
>
> Apple Silicon platforms use these mailboxes pervasively, including as
> part of the GPU submission hot path. On top of that, bad interactions
> with firmware coprocessors can cause immediate lockups or crashes with
> no recovery possible but a reboot. Our requirements for reliability and
> performance are probably much higher than the average mailbox user, and
> we'd much rather not have a bunch of common code getting in the way of
> performance profiling and future optimization. It doesn't make much
> sense for the mailbox subsystem either, since solving these issues would
> require major refactoring that is unlikely to provide significant
> benefit to most other users.
>
> So let's just call usage of the mailbox subsystem a failed experiment,
> and move the driver into soc/apple, where we can control the API and can
> add whatever peculiarities we need for our mailboxes. Farewell, mailbox.
>
> There are no changes to the DT bindings. This driver has been shipping
> in Asahi stable kernel packages for a week, with no regressions
> reported by any users.
>
> As an additional non-kernel-related benefit, this introduces a direct
> module dependency between consumers and the mailbox producer. This, in
> turn, is in the critical path for the NVMe driver on these platforms.
> Prior to this series, we had to have custom initramfs hooks to add
> apple-mailbox to distro initramfses, and accidentally removing these
> hooks would result in a completely unbootable system (there is no way
> for standard initramfs machinery to detect soft consumer/producer
> relationships like this, they usually just go looking for block device
> modules and their direct dependencies). We still need the initramfs
> hooks for other things, but with this change, completely removing all
> Apple-related initramfs hooks will at least result in a *bootable*
> system so you can fix the problem. This has already bit several users,
> and it also means many more distros have a chance of working out of the
> box (enough to let you install extra stuff) on these platforms, instead
> of having a hard requirement that *every single distro* fix up their
> initramfs generation in order to even boot/install on these platforms at
> all.
>
> Jassi: Ideally I'd like to get an ack on this and merge it all through
> asahi-soc, so we don't have to play things patch-by-patch across
> multiple merge cycles to avoid potentially broken intermediate states.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
> Hector Martin (5):
>       soc: apple: rtkit: Get rid of apple_rtkit_send_message_wait
>       soc: apple: mailbox: Add ASC/M3 mailbox driver
>       soc: apple: rtkit: Port to the internal mailbox driver
>       mailbox: apple: Delete driver
>       soc: apple: mailbox: Rename config symbol to APPLE_MAILBOX
>
>  MAINTAINERS                        |   2 -
>  drivers/mailbox/Kconfig            |  12 -
>  drivers/mailbox/Makefile           |   2 -
>  drivers/mailbox/apple-mailbox.c    | 441 -------------------------------------
>  drivers/soc/apple/Kconfig          |  15 +-
>  drivers/soc/apple/Makefile         |   3 +
>  drivers/soc/apple/mailbox.c        | 434 ++++++++++++++++++++++++++++++++++++
>  drivers/soc/apple/mailbox.h        |  48 ++++
>  drivers/soc/apple/rtkit-internal.h |   8 +-
>  drivers/soc/apple/rtkit.c          | 133 +++--------
>  include/linux/apple-mailbox.h      |  19 --
>  include/linux/soc/apple/rtkit.h    |  18 --
>  12 files changed, 529 insertions(+), 606 deletions(-)
> ---
> base-commit: bdfe6de2695c5bccc663a5a7d530f81925d8bc10
> change-id: 20230328-soc-mailbox-3cb6bb2b0b2d
>
> Best regards,
> --
> Hector Martin <marcan@marcan.st>
>
>

Series LGTM.

Acked-by: Neal Gompa <neal@gompa.dev>



--
真実はいつも一つ！/ Always, there's only one truth!
