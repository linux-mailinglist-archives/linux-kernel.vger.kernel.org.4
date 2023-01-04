Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA9565DF17
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjADVcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjADVcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:32:45 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0285B55
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 13:32:42 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h26so28471391qtu.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 13:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2turiCrgvhT7JsPJtbGc6evHDvXG0YxBW3ZsSwumhM=;
        b=bpjpAYwmnENODKo5ZZHfzMqhSaG4KVL4paZQ8iWUV3GxJ1ZqmF7QVJpaKz2iIkEsBM
         LSBG130Cnnf1bNxsKWPC8tsSEQidjlX01eEfO2+ZbFdwG0Aqz7WkJoy5utuT+DODajKZ
         C4RJAkWdpl17idzKsGSs6cNOCZm17sZhhWz74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2turiCrgvhT7JsPJtbGc6evHDvXG0YxBW3ZsSwumhM=;
        b=m9knfdI/7+g0vYj+io4iEXeYzWuALbTlbiOkGSNJ+6vgcULqIBZ2pkLQnVdHGTGMyx
         s6C70OuAgw8q2Cnk9BYbX43kQ4bRdt8AQB4A7q2FwaHjuDj7vYnWwIx0Irs/2bXSyN/W
         Rf6feD89GYesJtk3G0apLv2q7WuUXZLR6ORB1z4Hvv4AF252QqmYUI+PwdB14Vbgxdcm
         cktMpmuaROr67nPLhzF7sgucMa7pdT0agFmQksHrbneF8EqxI5nz/x3GVGqN/UPkCZva
         P2DcoYegjS49iutHsz51ceiDxIBXux9O3Jgigki/YuCT4KPafFQ2hlV1hvUM9qw1+nMs
         xnYA==
X-Gm-Message-State: AFqh2kqF4oTETr5wWeimqe2inpkBhsh3LWOLtaQyVzlank18y9ODenbK
        ODrk4ADB34oHlkbuwXdehGEEyxJ7cI/DFVcy
X-Google-Smtp-Source: AMrXdXttNNWd9slnScwEsK1ZzG+h4f3zkq3Sr9ZCItdUZ36p1QAhvTEe138WBZTyZGephFlbqRY32w==
X-Received: by 2002:a05:622a:11c8:b0:3a5:3134:48ac with SMTP id n8-20020a05622a11c800b003a5313448acmr94469033qtk.3.1672867961591;
        Wed, 04 Jan 2023 13:32:41 -0800 (PST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id fc16-20020a05622a489000b003a6a7a20575sm20797868qtb.73.2023.01.04.13.32.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 13:32:41 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id pj1so16951047qkn.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 13:32:40 -0800 (PST)
X-Received: by 2002:a05:620a:1379:b0:6fc:c48b:8eab with SMTP id
 d25-20020a05620a137900b006fcc48b8eabmr1820069qkl.216.1672867960665; Wed, 04
 Jan 2023 13:32:40 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20230104190115.ceglfefco475ev6c@pali> <CAHk-=wh1x-gbmE72xBPcEnchvmPn=13mU--+7Cfay0dNHCxxuw@mail.gmail.com>
 <20230104205640.o2uy2jk4v6yfm4w3@pali>
In-Reply-To: <20230104205640.o2uy2jk4v6yfm4w3@pali>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Jan 2023 13:32:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
Message-ID: <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
Subject: Re: Linux 6.2-rc1
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Jan 4, 2023 at 12:56 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Last time I did big retest of optical media was two years ago. At that
> time kernel was not able to mount CD-RW disc in full read-write mode
> from the normal node /dev/cdrom. Via pktcdvd driver mapping it was
> possible without any issue.

So that is part of the problem here: pretty much nobody uses optical
media any more, and the whole driver has been orphaned and has no
maintainer (for the last five years - it's why it was removed, after
all).

And people _have_ been using the normal /dev/cdrom for this, so it
almost certainly isn't entirely broken. But the test coverage is
getting increasingly sparse...

> Was there any change in last 5 (or more) years in this CD-RW area?

There's been a fair amount of cleanup wrt all the SCSI ioctl handling
in the last 5 years (and before).

But:

> Mounting CD-RW media in read-only mode via normal /dev/cdrom node
> always worked fine. Also "burning" CD-R media with userspace burning
> tools on normal /dev/cdrom node also worked.

Yeah, that's all I ever personally have done, and that most definitely
has been there for decades...

> But here it is CD-RW media in read-write mode with kernel udf
> filesystem driver without any userspace involved (after proper
> formatting).

... but I'm not sure about direct writeable mount support.

That may indeed be an area that only pktcdvd ended up doing. I've
never used it myself, even historically.

Let's bring in more people. Because they may not have thought about
some RW UDF case.

The removal seems to revert cleanly, although it does require
reverting a few subsequent commits too (that removed code that only
pktcdvd used):

    git revert db1c7d779767 85d6ce58e493 f40eb99897af

where we have

    db1c7d779767 block: bio_copy_data_iter
    85d6ce58e493 block: remove devnode callback from struct
block_device_operations
    f40eb99897af pktcdvd: remove driver.

Christoph, Jens? See

    https://lore.kernel.org/lkml/20230104190115.ceglfefco475ev6c@pali/

for the beginning of this thread.

                 Linus
