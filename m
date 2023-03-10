Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147636B3898
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjCJI3k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 03:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjCJI3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:29:31 -0500
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E141E3CFA;
        Fri, 10 Mar 2023 00:29:29 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id p2so2999684uap.1;
        Fri, 10 Mar 2023 00:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678436968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eM9+oariG5AZHJb2flm0bcRsFcKIv5vHQs/p7YmsVBU=;
        b=MrJbmo9fmzMDQpYESXD8O/vjEtBBGsw/cp5jZ/sftl1jD1pbE+NG98KNpu83xcR5/d
         wKMffsnBILCa+mHlrEcVYwZVzk3CtjLNydnsvs9jKXrycNdcJ8uB6ZYxxxiCtTOsU0WS
         5ijXYCQQFKqUlN+vwI7IkELM/mMNK8GNPTpo9X/pDeqIJ2hXC2mVbUSfrfHUTX7ETsBI
         B6r2McN4U5zipdKOZqSBZxbICWO6I0MhRGan1OvABZH5NVPMPVJiEf2mxA1PvbAwZr3b
         wS0o+QTxQoyyiXiq+7OCedM6uJjZCDMSowLPOp6axZ8aFhyDaIkODGQ2DOqMP6c6GJkq
         Q7Cg==
X-Gm-Message-State: AO0yUKWkmXxeWxazvZ6YQdjCBtQv4qiF6kiWXP6qQZ/syRbEtp9TzLI7
        jNpop4Pt3TzkSQCYiPidx248NEVLQf6Fnw==
X-Google-Smtp-Source: AK7set/LvhXjUnKtMSdmyQydiDygmsVdEciSZmELXYzCEVFsUvwbycIVYzDZoKe9a/8Z5BRsq5NohQ==
X-Received: by 2002:a1f:98d7:0:b0:425:6873:303d with SMTP id a206-20020a1f98d7000000b004256873303dmr10534918vke.9.1678436967970;
        Fri, 10 Mar 2023 00:29:27 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id u185-20020a1f2ec2000000b00416c3a2be7bsm257032vku.25.2023.03.10.00.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:29:27 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id d12so2974847uak.10;
        Fri, 10 Mar 2023 00:29:27 -0800 (PST)
X-Received: by 2002:a81:4306:0:b0:538:49a4:b1e0 with SMTP id
 q6-20020a814306000000b0053849a4b1e0mr896811ywa.2.1678436489434; Fri, 10 Mar
 2023 00:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20230309160201.5163-1-tzimmermann@suse.de> <20230309160201.5163-2-tzimmermann@suse.de>
In-Reply-To: <20230309160201.5163-2-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Mar 2023 09:21:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXsj9RrqUkwLjoxF2rXKcy9UK4Rwv1RcB0cnJXMXJU97g@mail.gmail.com>
Message-ID: <CAMuHMdXsj9RrqUkwLjoxF2rXKcy9UK4Rwv1RcB0cnJXMXJU97g@mail.gmail.com>
Subject: Re: [PATCH v2 001/101] lib: Add option iterator
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, timur@kernel.org, rdunlap@infradead.org,
        paulus@samba.org, benh@kernel.crashing.org, linux@armlinux.org.uk,
        pjones@redhat.com, adaplas@gmail.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, mbroemme@libmpq.org, thomas@winischhofer.net,
        James.Bottomley@hansenpartnership.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, corbet@lwn.net,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Mar 9, 2023 at 5:02 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Add struct option_iter and helpers that walk over individual options
> of an option string. Add documentation.
>
> Kernel parameters often have the format of
>
>   param=opt1,opt2:val,opt3
>
> where the option string contains a number of comma-separated options.
> Drivers usually use strsep() in a loop to extract individual options
> from the string. Each call to strsep() modifies the given string, so
> callers have to duplicate kernel parameters that are to be parsed
> multiple times.
>
> The new struct option_iter and its helpers wrap this code behind a
> clean interface. Drivers can iterate over the options without having
> to know the details of the option-string format. The iterator handles
> string memory internally without modifying the original options.
>
> v2:
>         * improve documentation (Randy)
>         * implement option_iter_next() as function
>         * allow modification of the returned options
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

I> ---
>  Documentation/core-api/kernel-api.rst |   9 +++
>  include/linux/cmdline.h               |  36 +++++++++
>  lib/Makefile                          |   2 +-
>  lib/cmdline_iter.c                    | 109 ++++++++++++++++++++++++++
>  4 files changed, 155 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/cmdline.h
>  create mode 100644 lib/cmdline_iter.c

Just wondering, is there any code that can be shared with/reused from
the existing lib/cmdline.c?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
