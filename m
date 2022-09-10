Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9821D5B47B4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 19:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiIJRXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 13:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIJRXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 13:23:46 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861343DBD7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 10:23:45 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y29so5698914ljq.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tch2kJ0ZwAAXIt3jghe1P/fhOA5CPdnSXzRIDQkAtls=;
        b=Z+y46nV1JqDcHlrPOu9G6oFT1l7slb6F/w6nKae0EmGOLBit1p2Kd+LG00eRLH9g/K
         PF6jQRw6AzAJbMYrzpFEPV72m2AgsJCVlEJIJiJoWxka2cSYyiTxnl/eCV//bKoygx8X
         sizZlQE3mcgNbwr787gn0QOsVi9LYhtMtlIbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tch2kJ0ZwAAXIt3jghe1P/fhOA5CPdnSXzRIDQkAtls=;
        b=R8D/P+CokFHeJeQ+P4EVbqlJUIEOz8a5uh+Ce5jdGLEzTKk+OAd+3aQEu2QAwYe1VZ
         Qur6ZupkVd6EmKmTRBy8zTHeOnmE/0+ncnqcLaAVmHQvX/5HrSpCa192kuTjQvUWnIr1
         4ZHcmzsr90D9R3l3drq8ituewnUd8SGHv302oq0z7+ZD9vNL1ALNVgH06WL5qyNQinqx
         K/61FnYb2Zlzgrzs+wTXJq6kTJrE7ypC+oU2KsJWAHZmZNRSdK/ZgCvYp0yasV824zD/
         a9tsBgqec7iP7xtwuymvu1yck3t6+HUfdnKQ3fiZVn6hsCDZ9ks7s7RUu4vmbfWLkgxI
         wdUg==
X-Gm-Message-State: ACgBeo2u1vIdKOUgaFVFpiLYMh+DyKTaIZ58Bxa6GKmSFHQDXjD8S+50
        WGIHTeq+jfBKb4tt+Ne84FDREGMYIzz7L1bhChU=
X-Google-Smtp-Source: AA6agR7/PGwZP8gWbq/5B+59TZVZl9bZnVKcENS32rIH/gZCRIWt5VBtNXxXyszjiQvutvy4Q47Cpw==
X-Received: by 2002:a2e:bf01:0:b0:25f:df1a:f39d with SMTP id c1-20020a2ebf01000000b0025fdf1af39dmr6003468ljr.365.1662830623571;
        Sat, 10 Sep 2022 10:23:43 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id p4-20020ac24ec4000000b004948ddb4e4dsm311139lfr.301.2022.09.10.10.23.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 10:23:42 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id s10so5076801ljp.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 10:23:42 -0700 (PDT)
X-Received: by 2002:a2e:9e11:0:b0:268:c7d0:9662 with SMTP id
 e17-20020a2e9e11000000b00268c7d09662mr5272320ljk.309.1662830622007; Sat, 10
 Sep 2022 10:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220626201712.18064-1-ubizjak@gmail.com> <CAHk-=wiayOnntaOaQtjm4JXNoXjQdkyT3euMKNfn4ozHRk-oqg@mail.gmail.com>
 <CAFULd4bM0=oNvp5VAfHa59nBK3=f++PR3EB2B-Zds1ae+14dfA@mail.gmail.com>
In-Reply-To: <CAFULd4bM0=oNvp5VAfHa59nBK3=f++PR3EB2B-Zds1ae+14dfA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Sep 2022 13:23:25 -0400
X-Gmail-Original-Message-ID: <CAHk-=wiEQeRuAwHYOS6oBmewLBXg6Nd6xMPmMz2E75f660TDSA@mail.gmail.com>
Message-ID: <CAHk-=wiEQeRuAwHYOS6oBmewLBXg6Nd6xMPmMz2E75f660TDSA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF
 for X86_CMPXCHG64
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 2:28 AM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> May I consider this message as a formal Acked-by: for the patch? I'll
> resubmit the patch with a commit message updated to reference
> lockref_put_not_zero instead of the removed lockref_get_or_lock.

Sure, sounds good to me.

It would be particularly nice if you can also see any change in
performance numbers - but that simply may not be possible.

32-bit x86 tends to also be very low core count, so the whole lockref
thing may or may not be measurable (no practical contention on the
lock), but the code certainly seems to get better.

             Linus
