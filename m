Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678986C08C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 02:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCTB7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 21:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjCTB73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 21:59:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1D05585
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 18:59:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ek18so41055741edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 18:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679277565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veHR4OeBVdmMM7ZoMMD2LEaF+ZQb01kUcsthEQZ+G8o=;
        b=JUvhM1ww44wVWzpYn0XewEO2cNKXa8pqfSt+TKE48b9urwwr21dQCVM18DqP95AqxZ
         Vk2aTV254+R5vJUVXgZqfKuHvF3rpyuYvAbBkJq2M8rbyf3dXyxrYdKdAincFMNvVkLE
         iIZVlYP73DV5wvZZl4UsQnx2ZjPB8cdNp5hIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679277565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veHR4OeBVdmMM7ZoMMD2LEaF+ZQb01kUcsthEQZ+G8o=;
        b=KF3uRjp7epQDRozM91btfoqIo4okl4xO7vI0kbiFOdHzrdb+uJaqfwm/231g+9k4gD
         dYwuRFKL6mMLeJBcBmJ1sqsKw1epDiXrMjWc0aLDQkXpevnzzqB4ygPe10wdPxRVhV+E
         q2UiWSyqPmoX29iTTuUJRwTsd7T/1Cdiz98Y/wUuIaw2fJCE9CroSU97AxHcAxMxPpoL
         xmXsJexriEPmOVJrlE0DthzKfXQ1KrnqZVU4ZzwS15j4AzaLchhHSddv3QTq3UU8UR+R
         OHFEvFBrz1gwCDTBtrt6GrdPYjAO+ORBrniVWNzy9VXuYoQ1ukE9ckZiCPxBrxWFL/pT
         wKJg==
X-Gm-Message-State: AO0yUKX5TR9aMJiTD8a8WaxMpHJ2KUuoUMuCpaqre0KP0hzhGhIV/UXj
        WKpVETc3glxSlG0CVpMZ2sRfz0FeDZYEl7qSFZ1iRw==
X-Google-Smtp-Source: AK7set8S2T277+W2fLt2w6W4A5YS7iCRtMBSvIVbC4YB251jldKkJqsbzG0q5Og2P5ISmqUlPnBiLA==
X-Received: by 2002:a17:906:57d1:b0:92f:e7e2:b7b3 with SMTP id u17-20020a17090657d100b0092fe7e2b7b3mr8392788ejr.5.1679277565227;
        Sun, 19 Mar 2023 18:59:25 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id o2-20020a170906774200b009273859a9bdsm3742057ejn.122.2023.03.19.18.59.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 18:59:24 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id w9so41107643edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 18:59:24 -0700 (PDT)
X-Received: by 2002:a17:906:2294:b0:927:912:6baf with SMTP id
 p20-20020a170906229400b0092709126bafmr2817236eja.15.1679277564111; Sun, 19
 Mar 2023 18:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230320005258.1428043-1-sashal@kernel.org> <20230320005258.1428043-9-sashal@kernel.org>
In-Reply-To: <20230320005258.1428043-9-sashal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Mar 2023 18:59:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpK-Gm-nOybRKs1LTD5yb7rPHQ4+=PCDvq61mUpBskYw@mail.gmail.com>
Message-ID: <CAHk-=wgpK-Gm-nOybRKs1LTD5yb7rPHQ4+=PCDvq61mUpBskYw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.2 09/30] cpumask: fix incorrect cpumask scanning
 result checks
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vernon Yang <vernon2gm@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>, mpe@ellerman.id.au,
        tytso@mit.edu, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, christophe.leroy@csgroup.eu,
        npiggin@gmail.com, dmitry.osipenko@collabora.com, joel@jms.id.au,
        nathanl@linux.ibm.com, gustavoars@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
        linux-scsi@vger.kernel.org
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

On Sun, Mar 19, 2023 at 5:53=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> [ Upstream commit 8ca09d5fa3549d142c2080a72a4c70ce389163cd ]

These are technically real fixes, but they are really just "documented
behavior" fixes, and don't actually matter unless you also have
596ff4a09b89 ("cpumask: re-introduce constant-sized cpumask
optimizations"), which doesn't look like stable material.

And if somebody *does* decide to backport commit 596ff4a09b89, you
should then backport all of

  6015b1aca1a2 sched_getaffinity: don't assume 'cpumask_size()' is
fully initialized
  e7304080e0e5 cpumask: relax sanity checking constraints
  63355b9884b3 cpumask: be more careful with 'cpumask_setall()'
  8ca09d5fa354 cpumask: fix incorrect cpumask scanning result checks

but again, none of these matter as long as the constant-sized cpumask
optimized case doesn't exist.

(Technically, FORCE_NR_CPUS also does the constant-size optimizations
even before, but that will complain loudly if that constant size then
doesn't match nr_cpu_ids, so ..).

                   Linus
