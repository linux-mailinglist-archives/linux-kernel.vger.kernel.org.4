Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FADB5F102D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiI3QlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiI3QlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:41:22 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DA518736B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:41:20 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id g130so5234365oia.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vB5Cit1qlgwA4leXT66n18iypc7LDJDE0w8r4rLqzqc=;
        b=VIrCOVi4X9YFy445rGJ4l2kgquwicILGfEndEovWbO5N4Lawl7mduwunTPdmsyfX5i
         r5hd9dv7V+oaqTXGtLzEloU9J93ZTRQGQCA/kscKzZbt51fH0WDfnZwKecW2bA6TMzj8
         orAGCNF6lve9To/lY0galgrf/5siuzYULgA9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vB5Cit1qlgwA4leXT66n18iypc7LDJDE0w8r4rLqzqc=;
        b=Dw/Hjo4eraXz0IiVcQP0/P/Lh9mrnLbOeArpLGD4ZaL1Uull2sX03H3y9DxGTWLx3T
         bNzxKIE5JNq0cgGuzEJ9kbm5AySd+YADj3QZv0yizOOxq+r6wA6WUaD04IGwAz3qVfNr
         zXYMP6+Do48EfQwO+zglWXsLLEav4nRCLvb2Z55+bgli2EN9n0wykAJtc2MIyHgR7A7w
         7huqcrgB3joi1GPoDMETjmW1WlURH1km1Vj15hC0Wc8eCHhbAnXU9sX5ysjIXw0x6JzT
         Mp7IHLo5WZpuB20c95N1skOu1KQkNRaeME3ZcfOSHOviUN091KfACSzRK9JQe9giALTl
         r3MQ==
X-Gm-Message-State: ACrzQf1pEzD3xsnj0VChToROGYYgn5Cu7wzJJoFfTxm60bV6sz2sWM6j
        YoQAis3O01RPdrvLIzVXvTfuAZNgJKQU1g==
X-Google-Smtp-Source: AMsMyM7kEXm2NZSTZQ0u3qduLwN9x5W2IuX9PyVoQJK/IrL+t9tHqzNxDz3BAIxhZTfm9DacSKrfHQ==
X-Received: by 2002:a05:6808:1985:b0:34f:c592:b8c2 with SMTP id bj5-20020a056808198500b0034fc592b8c2mr9677507oib.3.1664556078987;
        Fri, 30 Sep 2022 09:41:18 -0700 (PDT)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com. [209.85.160.47])
        by smtp.gmail.com with ESMTPSA id x22-20020a05680801d600b003514e125e12sm615913oic.35.2022.09.30.09.41.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 09:41:18 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1318106fe2cso6039153fac.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:41:18 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr5239613oad.126.1664556077774; Fri, 30
 Sep 2022 09:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <d78137ce-f6d0-e8d9-9248-2ec84b502b72@leemhuis.info>
In-Reply-To: <d78137ce-f6d0-e8d9-9248-2ec84b502b72@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Sep 2022 09:41:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg233O80=VWhk+DQet=oqq7cxzwoZVFgbCmCJ_TQQ+Y7A@mail.gmail.com>
Message-ID: <CAHk-=wg233O80=VWhk+DQet=oqq7cxzwoZVFgbCmCJ_TQQ+Y7A@mail.gmail.com>
Subject: Re: Manual Linux regressions report for mainline [2022-09-30]
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 4:44 AM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Graphical issues on Lenovo Yoga 7 14ARB7 laptop since v6.0-rc1
> --------------------------------------------------------------
> https://lore.kernel.org/lkml/c1f8886a-5624-8f49-31b1-e42b6d20dcf5@augustwikerfors.se/
>
> Unlikely to hit many people afaics. A fix is posted and somewhat
> reviewed, but not yet merged by the maintainers afaics:
> https://lore.kernel.org/amd-gfx/20220928172726.128863-1-sunpeng.li@amd.com/

Actually, it's already in my tree because it came in with the drm
fixes pull this morning.

> efi_pstore and ramoops backends are unable to properly decompress dmesg
> sometimes
> -----------------------------------------------------------------------
> https://lore.kernel.org/all/20220929215515.276486-1-gpiccoli@igalia.com/
>
> Reported in the past 24 hours, includes a revert. Kees wasn't able to
> reproduce the problem. Guess developers will look into this today.

The revert also made it to me this morning, so that people can look
into it after 6.0.

The others are still open.

                   Linus
