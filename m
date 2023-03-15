Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114956BA556
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCOCst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCOCsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:48:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BE42748A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:48:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h8so26243747ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678848520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnuiaVvlCgp1ALn8ya0APBGL0UevKskru4HwGfDHab8=;
        b=KOLYPvJcr4mwy0YkHqt81kswkMyMvAxVo7vctd7iIUH3ovn5Cr4BcqkrZxQ4eMBAmw
         aNxC2A0G1CibCTLYIkbSbvFlUCDzGdZms+jPQ+EM9z91aPjPSLXjTHRQmNoYLw+zTBgx
         2/9644vF3TkW5dd3uQnlPyjI0KX55Kdzuruak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678848520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnuiaVvlCgp1ALn8ya0APBGL0UevKskru4HwGfDHab8=;
        b=VO+P/k+FjJk+xYhSY4GYEzmrACT8FjTIm6MuOkjEI/hdwGnr5r4zbymzAYaFGqIIui
         8hI5Ywy48DCM4UQdH4ss4anF+TQMAgjIFn6YkMpx34tIm992V0t/4zXD1rWE3MfYQqgM
         nz43pcIWw4BnYU+Bpi0dNjY38KVPchOFtWh/RBovll92v0C7UfzOrfqvTNihTeHpFu42
         dRc4+zHthxTCGfhxN1mzoQAPvTJpTgwBUsqJ/Tf3bV1Wqq0BoQ4i2D8+vqaKtxw72cUP
         HRGm3R/21Vj1PJKpUWKKa/88tkY3qxND0ET1Tq5Bvf0Nt1SMj3AR5GmQjOptO4MT4Nad
         9ZKQ==
X-Gm-Message-State: AO0yUKUtPv3lsf8d+DySvKdUlHMm/b6wvwvH0StMG7V1fctlRuvvxcrf
        8XKLfsHlpDOlYF3mfq3ktarbLqupvDFagY+ojrbFqA==
X-Google-Smtp-Source: AK7set/4lahFps9YddGXNNwyom0chkp5ZhrjwPjO2AJIlLgq/C0MdYeEphLJaBVuIfP+lNz2be3Q5Q==
X-Received: by 2002:a17:906:2886:b0:8af:40b0:3dd1 with SMTP id o6-20020a170906288600b008af40b03dd1mr4668582ejd.27.1678848520245;
        Tue, 14 Mar 2023 19:48:40 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id e19-20020a170906749300b0092b74223806sm1846794ejl.209.2023.03.14.19.48.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 19:48:39 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id x13so22702882edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:48:39 -0700 (PDT)
X-Received: by 2002:a17:907:72c1:b0:8e5:1a7b:8ab2 with SMTP id
 du1-20020a17090772c100b008e51a7b8ab2mr2789469ejc.4.1678848519213; Tue, 14 Mar
 2023 19:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <7d026744-6bd6-6827-0471-b5e8eae0be3f@arm.com> <CAHk-=wiQYOroYNzqe36bv3w-2FuTbgs927dNYwpoy3ttKtus_g@mail.gmail.com>
 <CAHk-=whWPcj4QUTqORbT4X2fS+ZD4s5-38t+3=eyxMA_atXv+w@mail.gmail.com>
In-Reply-To: <CAHk-=whWPcj4QUTqORbT4X2fS+ZD4s5-38t+3=eyxMA_atXv+w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Mar 2023 19:48:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaMzSk6kjxUMvOKK=T2EKWmcyJ_QV0JCowos4pM2a7yw@mail.gmail.com>
Message-ID: <CAHk-=whaMzSk6kjxUMvOKK=T2EKWmcyJ_QV0JCowos4pM2a7yw@mail.gmail.com>
Subject: Re: [BUG] v6.3-rc2 regresses sched_getaffinity() for arm64
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 6:35=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So this does look  like purely a sched_getaffinity() thing (including
> the compat handling for same).
>
> And I can see why sched_getaffinity() uses cpumask_size(): we have no
> other good helper for this.

I decided that the cleanest fix is to just keep the cpumask_size() use
as-is, and just use zalloc_cpumask_var() to make sure the cpumask is
fully initialized.

Yes, we could play games with the exact size, but there just isn't any
excuse for it. Either it's a small on-stack allocation that gets
copied to user space (in which case we really are better off just
initializing it instead of doing anything clever), or it's an explicit
allocation due to the x86-64 MAXSMP case (in which case zeroing the
allocation is the least of our problems).

And zeroing the cpumask was what other somewhat similar cases seemed
to be doing, so it's consistent.

I've pushed out my fix. It looks ObviouslyCorrect(tm), but it would be
good to get verification that it does indeed fix things for you.

Because sometimes things look a bit more obvious than they actually are ;)

              Linus
