Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D6D65F4EE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbjAEUEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbjAEUD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:03:59 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E8D1AA1E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 12:03:58 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h21so30851335qta.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 12:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nyFgCTq7mpDQxxnaH2iWekm8p0N0UGiuR/TanNWh/yA=;
        b=M+BNbz5ArzNxZCPqDT2RLMruiMIq8AW2jrcizzP4J3lMfFszKCX6jI8c/oQa0hFNpW
         /uCG9yHYOMgSoIHIwdTF0S/0tkdlIxbEDDwVMrbhDnjU/pTCsElqqe+9EDvJ3KdeXNOW
         5DeVqve9/jNE3GVfDHCh9RnIEn1psBK9alWVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyFgCTq7mpDQxxnaH2iWekm8p0N0UGiuR/TanNWh/yA=;
        b=JIlugmM4e0/TKKQRGDO+iKdF0d0TkOLGloW4/Kwv8FuI6wgfqFdoYld/vX2ygtziXD
         /5uaB0lX3HXs7ea6L9A8CKHRJsvLGaUkIBULjeHuzSizBhgDZrv3+wWZIyjxzJMyxXM4
         ju4kCOaMdxYyLCCRrYgh2/HkG9DTRt02F3Bw0BA1142cgBL8S9kMt+omOyX8J3kBrn3G
         JeG6FeqY/UuhsFRRPbN/wqs1yEX5Hn1ID+Kc7zEZllPXvZGXYTsWnApVYPBZrnMW78ZZ
         qGkpmBlSmQVRFfy5v0yywRWt2sdzvZeewxByKxaXat42w+FfQIVMGadvnrH7LmTQ/YAq
         Alrg==
X-Gm-Message-State: AFqh2kq0RFsLfSouXcyjSkt4LmCG3RvOtc3bZGN2vSZ96UJBfcVKMdGh
        GweWTHA9tbfmCPU7/qwGpql7IB8KwDM6kSmZ
X-Google-Smtp-Source: AMrXdXsmAxA+85Cc6hbtgqIK5QazRgbURkXTXdm1wWIkoXV6MyT4LKDAyJ9mkPbJWc22MbZjzX2C8Q==
X-Received: by 2002:ac8:528d:0:b0:39c:da20:d437 with SMTP id s13-20020ac8528d000000b0039cda20d437mr74598585qtn.16.1672949036888;
        Thu, 05 Jan 2023 12:03:56 -0800 (PST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id h25-20020ac87159000000b003a82562c90fsm21869213qtp.62.2023.01.05.12.03.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 12:03:56 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id y8so2202656qvn.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 12:03:56 -0800 (PST)
X-Received: by 2002:ad4:4150:0:b0:531:7593:f551 with SMTP id
 z16-20020ad44150000000b005317593f551mr69529qvp.89.1672949035936; Thu, 05 Jan
 2023 12:03:55 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20230104190115.ceglfefco475ev6c@pali> <CAHk-=wh1x-gbmE72xBPcEnchvmPn=13mU--+7Cfay0dNHCxxuw@mail.gmail.com>
 <20230104205640.o2uy2jk4v6yfm4w3@pali> <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
 <90eb90da-2679-cac0-979d-6ba0cc8ccbb8@kernel.dk> <20230105174210.jbjoqelllcrd57q6@pali>
 <58d3649f-3c8c-8b12-1930-f06f59837ad5@kernel.dk> <CAHk-=wiKUWm3VoYHK-oKixc9nF5Qdwp598MPSoh=jdxKAU1bOw@mail.gmail.com>
 <1933bddd-42d7-d92b-974f-f26c46c01547@kernel.dk>
In-Reply-To: <1933bddd-42d7-d92b-974f-f26c46c01547@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Jan 2023 12:03:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjJ=wD5D80hkWNCjJqS+djckAL+nXhXaHaiFzMAMve3rA@mail.gmail.com>
Message-ID: <CAHk-=wjJ=wD5D80hkWNCjJqS+djckAL+nXhXaHaiFzMAMve3rA@mail.gmail.com>
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

On Thu, Jan 5, 2023 at 11:40 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Or even implement it in UDF itself somehow. But yes, ideally we'd punt all
> of this data gathering to userspace and just leave the trivial init/stop
> atapi/scsi commands to cdrom/sr.

I wonder how much of that could be done by just having a different
elevator algorithm for cdrw devices..

Anyway, realistically I suspect the real answer is that "nobody cares
enough any more". I suspect most people haven't used RW optical media
in over a decade, and we're talking about an increasingly dwindling
niche use.

Optical media may still make sense for backup, but probably not the
"filesystem" kind.

So nobody is going to be motivated to do any development in this area,
and the best we can do is probably to just keep it limping along.

Now, it's a bit sad how pktcdvd is the only user of that 'struct
block_device_operations' devnode thing, and I liked how that went away
after the removal of this driver.

And I'm not sure why pktcdvd needs it, everybody else seems to be
happy with gendisk->disk_name.

There's probably other cruft in pktcdvd that could be removed without
removing the whole driver, but I do get the feeling that it's just
less pain to keep the status quo, and that there isn't really much
motivation for anybody to do anything else.

                   Linus
