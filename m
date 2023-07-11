Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4842474F605
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGKQsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjGKQrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:47:51 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E6E1997
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:47:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b698937f85so97543281fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689094038; x=1691686038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U2CJtNA/0mITyVD5x12gejKNioPrhHv1tiOXdLtkt0Q=;
        b=B91IiqS0yBY17d0YOqmYOy0+i0PLZOGSTRs+jHU5f5/gALkqM6fypyaFLlAKCBu0n7
         1GH/D2VcfG6qY71PYudEVp+MPqmg5Inlu8o6jjZoK+mCyGSAOujouLAJgcmAHpMiZMeH
         Ai+6hmmuyL70bwuTy+bXvKBWj1w8p0mL6OBY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689094038; x=1691686038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2CJtNA/0mITyVD5x12gejKNioPrhHv1tiOXdLtkt0Q=;
        b=kmBP96n2mGzhj8eG9y1EkV8B5wJY5Dd0Q0bdMb9LlTeXud+B5+0XxUVNmHHIw3GsgS
         otvztCgkiuAH1JUaqvKGNrtrodRB6chgUF13BK/WbH5ChwTi7r1+KBBd1S/llQAVZ+Pn
         XDfEczmaW5Kw++8QhWQeCPlE8FerMrRu9IQnWxSooQRALe6UUOgrRJs461iRfJ9dVOWE
         i/K5Wq27ihELdIoyqHe0w9NysdjhVKhXkyVVeagU+/prIn1V1QCKsibkhHVwwykE+gG1
         AukaTg6CWUvv7dtJRlF30xb1pWIEdUTpPjUPo4+VxwjVjUhG/iuOlOLQ3Wh8axl3djFy
         9atQ==
X-Gm-Message-State: ABy/qLYvtpREb42eiTfx4enIgx/n+KUwP1Mvx7YP61zdCpZ4dA5FQ0Ww
        dyVZdUqh/jihMB3OtLWnSytqvGg+dLHsWuV6CtSj2p4Y
X-Google-Smtp-Source: APBJJlHFCfLho0NqnOO4R/XbbFMSAu6zduCa6uY10kb5Ml/fg99TVjB7r19I4jwU9QQhi808n6vovw==
X-Received: by 2002:a2e:8007:0:b0:2b3:3e19:a047 with SMTP id j7-20020a2e8007000000b002b33e19a047mr13558136ljg.6.1689094038475;
        Tue, 11 Jul 2023 09:47:18 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906370800b009929ab17be0sm1342357ejc.162.2023.07.11.09.47.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 09:47:18 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso7257263a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:47:18 -0700 (PDT)
X-Received: by 2002:aa7:d052:0:b0:51e:2a57:1d93 with SMTP id
 n18-20020aa7d052000000b0051e2a571d93mr13616464edo.16.1689094037813; Tue, 11
 Jul 2023 09:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com> <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
 <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com> <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info> <20230711120609.GB27050@lst.de>
In-Reply-To: <20230711120609.GB27050@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jul 2023 09:47:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXh9sgLo24RO02JjfD0m3HE5NADRPWoEd+dW6bruFhVA@mail.gmail.com>
Message-ID: <CAHk-=whXh9sgLo24RO02JjfD0m3HE5NADRPWoEd+dW6bruFhVA@mail.gmail.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        "Clemens S." <cspringsguth@gmail.com>,
        Martin Belanger <martin.belanger@dell.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        =?UTF-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 at 05:06, Christoph Hellwig <hch@lst.de> wrote:
>
> As far as I can tell Windows completely ignores the IDs.  Which, looking
> back, I'd love to be able to do as well, but they are already used
> by udev for the /dev/disk/by-id/ links.   Those are usually not used
> on desktop systems, as they use the file system labels and UUIDs, but
> that doesn't work for non-file system uses.

The thing is, the nvme code seems to actively do completely stuipid
things in this area.

> And all this has been working really well with the good old enterprise
> SSDs, it's just that the cheap consumer devices keep f*cking it up.

Christoph, deal with reality, not with what you think things should look like.

Anybody who expected unique ID's is frankly completely incompetent.
People should have *known* not to do this.

 "Those Who Do Not Learn History Are Doomed To Repeat It"
          - Santayana

and we have NEVER EVER seen devices with reliably unique IDs. Really.
We've had these uuid's before (ask Greg about USB devices one day, and
that was *recent*).

We've always known that vendors will fill in a fixed value, and
somebody still decided to make this a correctness issue?

Christoph, don't blame vendors. Somebody did indeed f*ck up.  But it was you.

> If we'd take it away now we'd break existing users, which puts us between
> a rock and a hard place.

Well, here's a suggestion: stop making it worse.

For example, we have this completely unacceptable garbage:

        ret = nvme_global_check_duplicate_ids(ctrl->subsys, &info->ids);
        if (ret) {
                dev_err(ctrl->device,
                        "globally duplicate IDs for nsid %d\n", info->nsid);
                nvme_print_device_info(ctrl);
                return ret;
        }

iow, the code even checks for and *notices* that there are duplicate
IDs, and what does it do? It then errors out.

Then expecting people TO WAIT FOR A NEW KERNEL VERSION when you
noticed something wrong? What an absolute crock.

So stop blaming anybody else.

I think the code should *default* to "unreliable uuid", and then if
you're sure it's actually ok, then you use it. Then some rare
enterprise user with multipathing  - who is going to be very very
careful about which device to use anyway - can use the "approved
list".

Or "Oh, I noticed a non-unique UUID, let me generate one for you based
on physical location".

But this "my disk doesn't work in v6.0 and later because some clown
added a duplicate check that shouldn't be there" is not a good thing
to then try to make excuses for.

            Linus
