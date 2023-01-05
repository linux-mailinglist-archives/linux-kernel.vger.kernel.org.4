Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3F065F41B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbjAETHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjAETGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:06:41 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A92911B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:06:40 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id s9so30718076qtx.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 11:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=50Eb16QjsIw9SD65sdRjmbA7POji/2BHEYoTDmHONlU=;
        b=M5Potr2S3IITg0WUsCyyGdzXmhKZCS5nDWm/pv5x0ntd+fAUu+RsoT/xIB2tmnmrVh
         WfwZEBhv1MHpcyH2h4AZMfM2iK2iaoxI0IM+dVyJ02CD/hOk7k6iqKxfJMDdqhjNgaGe
         5FraqYJDB6wR1BhFxXQETxN2YbGbozMON7V/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50Eb16QjsIw9SD65sdRjmbA7POji/2BHEYoTDmHONlU=;
        b=3GeLaggf4xOfhEKfne8T9QoXeoXbvV91OAyiqC6ZH5Zj5yyyjJwgCZAg7FppVqfAa7
         6tEUMQl1rbTUXvP9+yHtFKzECgiRGi3TYNAZpPGBf5NvJ2JN8pzqa9t+5tHYtSmHrCfY
         WbeGsUt8+3IAn5a5pM72/KDhi1znFBGzcUkAqGfr2qORTSLzgIxLdQh24S3AFS7X8Zxi
         w7nroipS8fD6l5MBdQvc+Zaxi02bmmje/D3Nwe52eJHQyNCLtbojZ/5vZJnYPxSlcZO+
         G9MG9LSc9JJjxzm8/+ejAc/XwO8uXAw0EqpcAH/kDdTdQNtXo+Hb7zRUbT2u5y+NMYFh
         vGng==
X-Gm-Message-State: AFqh2ko1n3gs/Ql8C77XVbtQRoZia2y156XKXrjSaMuGCIBhRXbSL4J9
        27AnhSLWalXbnFO1PYLvGxDHSqACIojwwQwN
X-Google-Smtp-Source: AMrXdXtyxiKy3PpBtWpAEviGzBYrICU/eHMIGyQ03Lfvg4Mz++yshFdfA8zkjlmSEFj8JrizxSFOHQ==
X-Received: by 2002:a05:622a:4a1a:b0:3a5:f9cb:8869 with SMTP id fv26-20020a05622a4a1a00b003a5f9cb8869mr78170636qtb.12.1672945598298;
        Thu, 05 Jan 2023 11:06:38 -0800 (PST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id a10-20020ac844aa000000b00398ed306034sm21749530qto.81.2023.01.05.11.06.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 11:06:37 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id y8so2092999qvn.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 11:06:37 -0800 (PST)
X-Received: by 2002:a05:6214:1185:b0:4c6:608c:6b2c with SMTP id
 t5-20020a056214118500b004c6608c6b2cmr2444140qvv.130.1672945597254; Thu, 05
 Jan 2023 11:06:37 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20230104190115.ceglfefco475ev6c@pali> <CAHk-=wh1x-gbmE72xBPcEnchvmPn=13mU--+7Cfay0dNHCxxuw@mail.gmail.com>
 <20230104205640.o2uy2jk4v6yfm4w3@pali> <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
 <90eb90da-2679-cac0-979d-6ba0cc8ccbb8@kernel.dk> <20230105174210.jbjoqelllcrd57q6@pali>
 <58d3649f-3c8c-8b12-1930-f06f59837ad5@kernel.dk>
In-Reply-To: <58d3649f-3c8c-8b12-1930-f06f59837ad5@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Jan 2023 11:06:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiKUWm3VoYHK-oKixc9nF5Qdwp598MPSoh=jdxKAU1bOw@mail.gmail.com>
Message-ID: <CAHk-=wiKUWm3VoYHK-oKixc9nF5Qdwp598MPSoh=jdxKAU1bOw@mail.gmail.com>
Subject: Re: Linux 6.2-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jan 5, 2023 at 9:45 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Not quite sure what that refers to, as I'm pretty sure I did all of that
> work. But maybe Linus can refresh my memory here :-)

I was definitely there, part of making it actually work for *every*
block device.

Long long ago, it used to be limited to the sg_io() interface, and
only worked for SCSI devices.

So you couldn't actually burn CD's with the regular IDE/ATA CD ROM
drivers directly, but had to use a shim driver, kind of like pktcdvd.
Except I think it was just /dev/cdrom.

See

  https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=90df68e70b

for some of it (exposing SG_IO to all the block ioctls), and the "make
it more usable" parts that made it do sane permission checking in

  https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=a75aaa84276

and the commits preceding it for that part of the work.

But yes, you were very much involved too.

> As mentioned, I don't think this kind of code belongs in the kernel. sr
> or cdrom could easily be modified to support the necessary bits to
> handle a writeable open, but the grunt of the pktcdvd code deals with
> retrieving and writing out bigger chunks of data. And that part really
> does belong in userspace imho.

Well, it's the UDF write support that is the issue.. I didn't even
realize people did that.

You'd presumably have to re-do it as a FUSE thing.

                 Linus
