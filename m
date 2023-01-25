Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4351B67AE01
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbjAYJbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjAYJbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:31:20 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE486539BB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:31:15 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id p189so8253429iod.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=co74253xmdlMDYdyg36/gvO6JfXXpw4Mm4A134IXmAo=;
        b=nhxuEOigLd/GCweEocmGX954i3D3IFceWuPkN85bs5ZTUHDxtTje6ljBp5xEqfFdJn
         MIoJYivQpf/fzjzX3gDWT+q5jFRKgRKuD+p3c/Q++p7fRaSS/+6MBOIZRLUfeDi1QzFz
         TyCGogN1j1ZakmiG8EWpobckqCz2FtL7k9lQb3qXZb9rxPxvDlyEKRAgsfdfuBtIj3P6
         4mWboxmhzJUvGCJFBWUXvrVQHtpvUoAg+UD39CMVsUprq64kjiJIXrrKt37Izlb1p4Zt
         EO/xHCtqK1yvUKgpJar4gjYjlxlCDppZNPDsjF/HEvnq+CBKuwkjY96jXtiBdhrN6uAz
         0KCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=co74253xmdlMDYdyg36/gvO6JfXXpw4Mm4A134IXmAo=;
        b=EiylppQmJ1KUxL6Q05o612d6neGw+p2fq375CfAzlx6LtcuZuDKgYHLonfakLFKbAk
         P9S4S7uDcYhZ/1D/mnj1stJqd/UgNHwEwA6RVPIYxF0jIubu5FwpnVTQJGKOMpkzkJ68
         0bpfNWwmy+sGg5+m73eF1Vc9JA25L5QOR/h91fKdd3vBU+yswTIvBRfeg06KXoaz8yQc
         aNCUvY/E0EccIRbR/Iw5Q2lpio/e5AjgbW5lw4I0sDs29grY89fiaj8WPw5I/TBgNI6I
         PLYtOehLLQTbqsQ/GErMM+/miH7DJO+hVV9a3/9mq2SR3QWw+zOt5FO+er/pfOC+UVc4
         RY5A==
X-Gm-Message-State: AFqh2kqBMQLzjIiD1tKF3jDnoarsA5YoVPX6AWQ4cH9z+ZIP0Ljg21t6
        l760bBCqbcO1/LLFeGD1+sxsLHwcl8wWb77dwFXnIw==
X-Google-Smtp-Source: AMrXdXukFQe/JANN75/MG/lnGxSmW7i84xDb8nbRxxfUo02+dA1IrQrfqP6mBI2dhE4d8toK9encfqNEyl9fnb04rbw=
X-Received: by 2002:a02:2a4b:0:b0:38c:886a:219a with SMTP id
 w72-20020a022a4b000000b0038c886a219amr4163715jaw.133.1674639074852; Wed, 25
 Jan 2023 01:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20230117163543.1049025-1-jannh@google.com> <CACT4Y+aQUeoWnWmbDG3O2_P75f=2u=VDRA1PjuTtbJsp5Xw2VA@mail.gmail.com>
 <CAG48ez32X1WKryh5ueQ0=Mn=PMKc6zunOYsMHhwMMMxKKaMfqA@mail.gmail.com>
In-Reply-To: <CAG48ez32X1WKryh5ueQ0=Mn=PMKc6zunOYsMHhwMMMxKKaMfqA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 25 Jan 2023 10:30:38 +0100
Message-ID: <CAG48ez34j5HNfjT0ZAuehJm235_izkbYX2EETGSh402U7Hiisw@mail.gmail.com>
Subject: Re: [PATCH] fork, vmalloc: KASAN-poison backing pages of vmapped stacks
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:27 AM Jann Horn <jannh@google.com> wrote:
> Oooh, actually, there is some CIFS code that does vmalloc_to_page()
> and talks about stack memory... I'll report that over on the other
> thread re CIFS weirdness.

Ah, no, nevermind. The corruptions were in ntfs3, not cifs...
