Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222A460D247
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiJYROI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJYROG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:14:06 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D9A13A7DF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:14:03 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1322d768ba7so16439474fac.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fr7GdiWrtN9B19qeTj7Me9FrzmlF9xRzUCrAupjNT7w=;
        b=P0bZcEbb5P7tG0bCAYDU8wdktUzEqJgyf9RpmbNRqhMWzzjDrNErxxLcQLB6h1UUVh
         O5UtOfg6nwRiLVXPIQQ7YhBc8KAmxJnTE1NxDsbKUDHAK2fQVpK7oYYU1BBsMcYAF2Ot
         YgYOHQmhSTGZ95srGYMU2XUkP21R2+IcWxhxjMCnALyyOF36/TfRx8FxggWdMDeYbWAC
         /bv22aNDVlpDjlYvktfb0IbUPymmau/+sXge0Do0XYDWhDb2neFvemXBt+4u69tOYiuW
         TPnHulTKMRdSQdRFfMKq8nW0PFSNot6FqZFQkIbTNP9WIVr77yYVMtxBbS0ww/5VePkJ
         pG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fr7GdiWrtN9B19qeTj7Me9FrzmlF9xRzUCrAupjNT7w=;
        b=LmkGB1sLNMzNhL4ZGiIHPOENoRwLKJrSoRdBHQPfLd79VnxUyuDCG31J6bJYn34Sfn
         kX7JXBv8eHLumPC3uG+wYhInM0wMz6HcAcxQs+I/Vk1G6hmtZpxZq+FLH5oDsGJlDL84
         C2QAuYc5gwudX2Pdsi0GILyHCE6tY4+HtDpAIM4kPLRucCsLORSxkQsHnloIo2TpSML4
         JSjELkA8qsKg6C4eJ01ZjpvUo5w42dXj/bPsCrRk3av09QpZHUIzgwfNIUsDpJaWVQux
         sGa5H/hofco2+1M9yrPKDFgQFdKKf3pp4r7+eNPuGX+bd6wY4c2tk8CoJMW2sYCPU7Mu
         /r0w==
X-Gm-Message-State: ACrzQf02+hw23D+gAJPSfpOmljTc4D+drA9EM9ku/W9DJIoEupYvtnIv
        iAf4dI9V6aeH2JZFI6MdMRw=
X-Google-Smtp-Source: AMsMyM7+2KTbK72LZ9ertBtSjnvjSrIr2aF3YBgcvD8JXt9fAvt7+iL01Up9ozvyEzNrQE+2SWjplw==
X-Received: by 2002:a05:6870:f629:b0:131:7eaa:42bc with SMTP id ek41-20020a056870f62900b001317eaa42bcmr40155940oab.174.1666718042946;
        Tue, 25 Oct 2022 10:14:02 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id cc14-20020a05683061ce00b00661948e6119sm1253465otb.47.2022.10.25.10.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 10:14:02 -0700 (PDT)
Date:   Tue, 25 Oct 2022 10:11:51 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/2] bitmap: add sanity check function for find_bit()
Message-ID: <Y1gY18JGz4zKw+gW@yury-laptop>
References: <20221020032024.1804535-1-yury.norov@gmail.com>
 <20221020032024.1804535-2-yury.norov@gmail.com>
 <CAHk-=whij5pwOkG5HhMRzrvc4BTzhgj9h=wHo=tMVGasKE+p1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whij5pwOkG5HhMRzrvc4BTzhgj9h=wHo=tMVGasKE+p1w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 03:19:24PM -0700, Linus Torvalds wrote:
> On Wed, Oct 19, 2022 at 8:24 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > This patch adds runtime check for the pointers to be aligned.
> 
> No. Don't add pointless things like this. It only adds code, with no advantage.

Sure. Patch #1 is mostly for Russell to address his concern about
unaligned bitmaps on ARM32. And it looks like it found nothing.
 
> The bitmap ops all operate on 'unsigned long', and if a bitmap isn't
> aligned, we'll take a fault on the architectures that don't do
> unaligned accesses natively.

ARMv6 may or may not support unaligned access depending on SCTLR.U
bit. This is what Russell was concerned about in the other email.
As far as I understand, linux enables that feature.

ARMv7 deprecates that bit and supports unaligned dereference
unconditionally, with few exceptions like exclusive access.

https://developer.arm.com/documentation/ddi0406/b/Appendices/ARMv6-Differences/Application-level-memory-support/Alignment?lang=en
Thanks,
Yury
 
> And the find-bit functions simply aren't special enough to have this
> kind of random testing, when the *basic* bitmap functions like
> "set_bit()" and friends all do the accesses without any alignment
> checks.
> 
> The fact that filesystem code often uses bitmap functions with a cast
> from 'char *' is immaterial. Those things are already aligned
> (typically they are a whole disk block). They just weren't an array of
> 'unsigned long'.
>
>                 Linus

