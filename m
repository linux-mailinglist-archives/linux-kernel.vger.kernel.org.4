Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CBC67FA85
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 20:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjA1ToJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 14:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjA1ToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 14:44:07 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AD3AD
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 11:44:05 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id kt14so21977401ejc.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 11:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDr/fu6cZzh/kjW/9yOTtMVpnZToyjsJMLDkL1Bx/po=;
        b=hU+h1UYNyEmeQX2qUOJs7BSO2eV1R8a9DwLO26nhK2BhO3O2vdOQC4FI8PR4xB8Kcc
         QUu9F8wC6zQ5LLH+WdkCqf/Oe10YqkQMOzHCU2CnEoiBHEZkxIMI8+nS0nDRHjt1I0Ty
         jL1AZu0DY0cHkJdXM4cidVviVH/AifhRoY5Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDr/fu6cZzh/kjW/9yOTtMVpnZToyjsJMLDkL1Bx/po=;
        b=phoNF8zxcR0akgQzGhadcY2ACJwbrqgqrdp+KMDMjCVrvx2mjZ58GxFNKh5So5rtEq
         A5epFp1vNZpzIFTnbuTIMBMRJTFMZ4RDaZxLKlXnYPEwhrwGUjhmbhMSb2H5z8ChuCjs
         BptzrT2u3fPhMlwaFcLfKdCQWbdtz/0klzGx9aUFuRB+o/4RY9RWCbxVHaKKy4tZ2PCt
         e7H7nVC7ek8wPBEXHWCFBH4Vo9Nvg1Mlw2anN/+MKdPiHM4axob2dpdy6QnJ82Gl8wfV
         to2KeMxCtOHWL7FfbZLiyszT8qOK/82ZJ7FlwYgHNCgsL6pDULB/qDJZTDfcs22gXXAK
         c/MQ==
X-Gm-Message-State: AO0yUKWA+YxW6SWvjLd6hNFqMpahw2kfSDqHvlA7x+Oi3T//0a21l2Uk
        Hmdm0Wixce9qMVbJgf/eH5wmjy5oKdaAnF52dyU=
X-Google-Smtp-Source: AK7set/dQ8lylGRrdZc7p/0gvrxFau3TH5pFgMqt5bSKHKpLWzUitgZsZWMCgJe6muMS3ZJ9mLAWuw==
X-Received: by 2002:a17:906:d1d0:b0:878:6df7:ce74 with SMTP id bs16-20020a170906d1d000b008786df7ce74mr10100559ejb.23.1674935043946;
        Sat, 28 Jan 2023 11:44:03 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id op27-20020a170906bcfb00b0084bfd56fb3bsm4224496ejb.162.2023.01.28.11.44.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 11:44:03 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id hw16so21836683ejc.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 11:44:03 -0800 (PST)
X-Received: by 2002:a17:906:add6:b0:878:51a6:ff35 with SMTP id
 lb22-20020a170906add600b0087851a6ff35mr2801326ejb.43.1674935042905; Sat, 28
 Jan 2023 11:44:02 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
 <90eb90da-2679-cac0-979d-6ba0cc8ccbb8@kernel.dk> <20230105174210.jbjoqelllcrd57q6@pali>
 <58d3649f-3c8c-8b12-1930-f06f59837ad5@kernel.dk> <CAHk-=wiKUWm3VoYHK-oKixc9nF5Qdwp598MPSoh=jdxKAU1bOw@mail.gmail.com>
 <1933bddd-42d7-d92b-974f-f26c46c01547@kernel.dk> <CAHk-=wjJ=wD5D80hkWNCjJqS+djckAL+nXhXaHaiFzMAMve3rA@mail.gmail.com>
 <182bc0ee-51e3-b8c4-59f7-dcf702865a95@kernel.dk> <20230106165809.vkz7lr7gi3xce22e@pali>
 <fd143218-d8ba-e6c5-9225-b8e2aee09979@kernel.dk> <20230128193458.ukl35ev4mwbjmu6b@pali>
In-Reply-To: <20230128193458.ukl35ev4mwbjmu6b@pali>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 Jan 2023 11:43:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=whfor49J0YTYi6zauiJ_MWwF-XwhSty+HvD4CzxFQ_ZGA@mail.gmail.com>
Message-ID: <CAHk-=whfor49J0YTYi6zauiJ_MWwF-XwhSty+HvD4CzxFQ_ZGA@mail.gmail.com>
Subject: Re: pktcdvd
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Jan 28, 2023 at 11:35 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello! Sorry for a longer delay. Now I have started testing it with
> Linux 6.2.0-rc5. Adding mapping works fine. Reading also works. Mounting
> filesystem also works, reading mounted fs also. But after writing some
> data to fs and calling sync cause kernel oops. Below is the dmesg log.
> "sync" freezes and never finish.
>
> [ 1284.701497] pktcdvd: pktcdvd0: writer mapped to sr0
> [ 1321.432589] pktcdvd: pktcdvd0: Fixed packets, 32 blocks, Mode-2 disc
> [ 1321.437543] pktcdvd: pktcdvd0: maximum media speed: 10
> [ 1321.437546] pktcdvd: pktcdvd0: write speed 10x
> [ 1327.098955] pktcdvd: pktcdvd0: 590528kB available on disc
> [ 1329.737263] UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2023/01=
/28 19:16 (103c)
> [ 1435.627449] ------------[ cut here ]------------
> [ 1435.627466] kernel BUG at drivers/block/pktcdvd.c:2434!

Well, this is very much an example of one of the BUG_ON() cases I
absolutely hate - not only did it cause the traceback (which can be
interesting), it also effectively killed the machine in the process.

So that BUG_ON() most definitely shouldn't be a BUG_ON().

Turning it into a WARN_ON() (possibly even of the "ONCE" variety)
together with then finishing the IO with a bio_io_error() would have
been a better option for debugging.

Of course, the real fix is to fix whatever causes it, and I don't know
what that is.

So I'm just piping up to once more highlight my hatred of using
BUG_ON() for "this shouldn't happen" debug code. It's basically never
the right thing to do unless you are in core code that would kill the
machine anyway.

                      Linus
