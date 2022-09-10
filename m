Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7738F5B47B9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 19:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIJR3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 13:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJR3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 13:29:13 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE79481EE
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 10:29:12 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id o2so5843838lfc.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1kYjnl4fDCj70xdf6hD4EujUSRWcPi+E61T6h9PVR1A=;
        b=gYQ9Ys76Val3aAQiPAESCWsSvNL9GvA4zd862suf1MxfYwf+er8TAUtIGNYLELNhjU
         4MXVOi9QmL7UAisKDBwG/9tRG/uLnS95TKRKZcZHhB2Mur7bCz9KvC6EjZzm2+wQATeO
         MVT3WeLRI1qTqTaEVcnQ5VSN67uYZAPGGdZvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1kYjnl4fDCj70xdf6hD4EujUSRWcPi+E61T6h9PVR1A=;
        b=kNeb6+Zuo9iMm5PUEtLJN4ilAGamznNrx2+tXQwM1QjaLxs6lL0s302K/skcqkeP5T
         glm4stFzUGQBLn91DRO1FAynGcNEtr3JTX0wtbxyfSNFKFQ2L6Xym4JM9Gz51RugazAW
         kAPRusEjeww4RBMnqCrTD2qiPeKP2EaazCr2DFU33y36k3UwtTw5WHK9ZJmz383fkgey
         WcE6ztds5Uoa49Fo+3KcqUh1XSgOM3I1LqXxzm2k3UTy3i5k6s3Cy2vYweqX3LZ3Byeo
         klawIiHY4WIQJDDLZmE76EBgNwaijVadJ9T1o6veDB4HWM3sHf4xbfTQsSZ5hORrf802
         6cvQ==
X-Gm-Message-State: ACgBeo1YnBrDmjN7Wsb+2ah1okq20Xew+/4QmltI8HofZ5gJLbF1EIah
        SUmsUPs8bZEVEUVqIOasvnarms6eGIqQCGk4vfk=
X-Google-Smtp-Source: AA6agR77HC3NcO5bkj+iA8FW0HSElcU2ZOQXgqTEviHYYVR8HQ/nzWLi82zwr6fZvDmmUAFCgPCI5Q==
X-Received: by 2002:a05:6512:c17:b0:498:f034:1c30 with SMTP id z23-20020a0565120c1700b00498f0341c30mr4116554lfu.408.1662830950274;
        Sat, 10 Sep 2022 10:29:10 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c9-20020ac25309000000b0049488c97d39sm314859lfh.212.2022.09.10.10.29.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 10:29:07 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id m15so7983981lfl.9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 10:29:07 -0700 (PDT)
X-Received: by 2002:a05:6512:31c1:b0:498:fe7:b46 with SMTP id
 j1-20020a05651231c100b004980fe70b46mr4653024lfe.549.1662830946873; Sat, 10
 Sep 2022 10:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <YjsCpoRK7W4l6tSh@zn.tnic> <CAHk-=wi9pLxm+dXoCaiGO+f0EbhyfAR_L510vD0c2=hj6rbMXg@mail.gmail.com>
 <YjwsUT/6PkRPjnHE@gmail.com> <YjySjys3QZAWFlfo@dev-arch.thelio-3990X>
 <YkC08gKqJOUM7CA8@gmail.com> <YkHXQTKImf7Wr+Sk@dev-arch.thelio-3990X>
 <YxHD1MkulyL3yB9y@gmail.com> <CAK7LNASyp8SzO3G+th5RgmRNBM_ryKuy0XzaMrdUdo8Sd6RR0A@mail.gmail.com>
 <YxR0UlS0Jpz9uqb7@gmail.com> <CAK7LNATnGO3LHZ7VvJRziDqz50gRq7MUJPOJLMfcv=pCiA=-mg@mail.gmail.com>
 <YxXHTMl/7PhVRSA9@gmail.com> <CAK7LNAQyiNpbLuVjjQ8-GOQECtfQZqsNS8xH0E2ZkLAHYtXt7A@mail.gmail.com>
In-Reply-To: <CAK7LNAQyiNpbLuVjjQ8-GOQECtfQZqsNS8xH0E2ZkLAHYtXt7A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Sep 2022 13:28:50 -0400
X-Gmail-Original-Message-ID: <CAHk-=wiS0rpOSRyh-8hOQm3yT3q_JkLgQj0ur9QuyUKxWU2sdQ@mail.gmail.com>
Message-ID: <CAHk-=wiS0rpOSRyh-8hOQm3yT3q_JkLgQj0ur9QuyUKxWU2sdQ@mail.gmail.com>
Subject: Re: [PATCH] x86/config: Make the x86 defconfigs a bit more usable
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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

On Fri, Sep 9, 2022 at 6:05 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> If you do not like the inconsistency,
> the support for ARCH=i386 and ARCH=x86_64 must be removed.

Is there any sane alternative for "do cross-architecture test builds"?

I do things like "make ARCH=i386 allmodconfig" myself, and I have to
admit that it's annoying that you have to then remember to do "make
ARCH=ii386" to do the actual build too, because otherwise Kcoinfig
will mess up the architecture, because it didn't make it into the
final simplified .config.

This is probably more noticeable with "defconfig" because then the
"ARCH=xyz" part has *other* effects too (ie it is also what says
*which* defconfig to pick).

So this is a bit of an annoyance, in that it's not trivial to just
"make the config for ARCH xyz" and then "make".

                       Linus
