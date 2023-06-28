Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E969F741734
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjF1R3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjF1R2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:28:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979251FFB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:28:04 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6a5fd1f46so968241fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687973282; x=1690565282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k+2E0Rt8HIW6qnRJgQGPRjPuN/s1eCRBBVkSd2Fo7f8=;
        b=ZnbhkWthy3eR2jV3Fa0jSGlCcQtNRPTMENE53fJR5/GZ1tUGT3arTsEAnmrZElUuTA
         hoZmGBf55Q87kt0l2iQkxedGCZL+IPIiuNhVN6vkO345Uht2IpNi+288R8gt+PC2/YZg
         sioXmIMls+2T/khoT/vOXP/w/19FzH2XWyIGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973282; x=1690565282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+2E0Rt8HIW6qnRJgQGPRjPuN/s1eCRBBVkSd2Fo7f8=;
        b=iBhzC1/rcoEpOAuA9Njzogo0AzOLnexSCHp4dkbV/XadhhNvlQsJGADaSW7cFxmE45
         SfzI+4j1mwcMAztmc51S9k5P5hKx6GCWI8ccOJo4sEUiH12ohl30XBxj4YNY68LyswD0
         B3L2j8Mb4o3QXopnPxRj/oDV1uCYoky/UYHJPMoFjMClXNt8l4eEIi3krZZkKvxNDgmw
         Y+yLS8l7xXE2/M3MEifoC/bjXI/ykQKjirGhmZQkl1fUQYtW7/Ik4RfGsBJTG8wWD/xW
         wzhx8frB2sRs0og6YKFSk6QUyac2A1gnFHaOTwzAkQG1WOLCWQd5ER+CZAN7qLwIv/is
         KzGQ==
X-Gm-Message-State: AC+VfDyHs/CBcl4rTn2PgtCHosc7vAdQdlw0Rn7ucmqGKKZYE/13hfx+
        ySxHcfLfOtt1Bu1aDjsdwHv6Lx6zCfb9EltZDRx3JV0r
X-Google-Smtp-Source: ACHHUZ5hrhk8V8bmV8gIpCWbkk6w4gqsJbyV/ylOylavzwalQsVvtiuur00hsds93N9nv+ITFOinZQ==
X-Received: by 2002:a19:e602:0:b0:4f9:5711:2eb8 with SMTP id d2-20020a19e602000000b004f957112eb8mr14544721lfh.33.1687973282481;
        Wed, 28 Jun 2023 10:28:02 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id y3-20020aa7c243000000b0051bdf152295sm4912384edo.76.2023.06.28.10.28.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 10:28:01 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51d9c71fb4bso3826698a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:28:01 -0700 (PDT)
X-Received: by 2002:a05:6402:505:b0:51d:a24b:3d74 with SMTP id
 m5-20020a056402050500b0051da24b3d74mr6867136edv.20.1687973281251; Wed, 28 Jun
 2023 10:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230626085035.e66992e96b4c6d37dad54bd9@linux-foundation.org>
In-Reply-To: <20230626085035.e66992e96b4c6d37dad54bd9@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jun 2023 10:27:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjyJyV=Kyb8XJcLjFEPP-RMF0J6CQfT2OXLmJdM2yEv8w@mail.gmail.com>
Message-ID: <CAHk-=wjyJyV=Kyb8XJcLjFEPP-RMF0J6CQfT2OXLmJdM2yEv8w@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.5-rc1
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 at 08:50, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Linus, please merge the MM updates for the 6.5-rc cycle.
>  [...]
> merge conflict in mm/gup.c, vs block tree:
> https://lkml.kernel.org/r/20230616115856.3ce7682c@canb.auug.org.au

Hmm. I think this merge resolution in -next is wrong.

It now does a common

        folio = try_get_folio(page, refs);
        if (flags & FOLL_GET)
                return folio;

for both FOLL_GET and FOLL_PIN, and then *after* that for the FOLL_PIN
case it does that

        /*
         * Don't take a pin on the zero page - it's not going anywhere
         * and it is used in a *lot* of places.
         */
        if (is_zero_page(page))
                return page_folio(page);

but by then it has already done the try_get_folio().

End result: it has already updated refcounts, despite the comment
saying not to do that.

So I think it needs to match the comment (and the try_grab_page()
logic), and just basically

        if (flags & FOLL_GET)
                return try_get_folio(page, refs);

        if (is_zero_page(page))
                return page_folio(page);

        folio = try_get_folio(page, refs);
        if (!folio)
                return NULL;

instead.

That's what my resolution is going to do, but let's add others to the
participants list just in case somebody goes "No, Linus, the reason
-next does that is XYZ"...

               Linus
