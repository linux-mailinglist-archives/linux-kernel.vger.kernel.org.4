Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C4162C82F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbiKPSvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbiKPSul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:50:41 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1400168C58
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:47:07 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id p18so12292238qkg.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6mUWcAUsHBLBBOyPZl9KLfZxNzmpm7+WnSZ6t7cdFnY=;
        b=U7dU9rv6wUpFKpXsiQgGTKHI1hOhD02/8YUvZyUexZM44blcMCXRGGDvsVwpihMpCg
         DIulg/dlhgxKhfU+3Lcr+hbAyQ3jN0jbIsxVUJasZCrsnbqL7HwqcLDq3ySQRfjehh4E
         KAYEZXQsL1ygEwCovCE/tuMViSZr67pc5yQ6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mUWcAUsHBLBBOyPZl9KLfZxNzmpm7+WnSZ6t7cdFnY=;
        b=Fp0kbl2AwlKAOxMnNvsX49YmSFaZHsdADXlg3ZiOYMvIcvUb5DPtXVBu3HTJ2DMKwx
         KpfHRILx+FWIv4Ojx9Qogt9KOn3xY9aZJ9rd3/X+fCF9m6+KOhBPSAtnxsxHeVA3wkwC
         QWpqTHFTBHi6mrdE6jozgjtvG63tkrvRY8qrEn5Uhy8VIazXBEmXKE4GROgmO02LCZhF
         /3SHvezfnjTiNyTncrlrhneizHVVH292ujeeNDmL37WJ2kwLaHnsAQbBKBqk5yqt4Oc0
         wMXM2iBgOE3+qfGC4P19pjWH0LK5zHLELWtPhX9hL4bC3VwSAxMVjzsSIb1U1nUVokXA
         FWPg==
X-Gm-Message-State: ANoB5pnE4aTyy4NntZJfYYAwg25d+98A78uU7tygfuNu935ZOIxhIp/p
        UUncnpPfrzx5ao3O6QRX/nUDtyRWZAIrdg==
X-Google-Smtp-Source: AA0mqf4nDJZVrql20bdqWENWgAqJCxDmkCq99Mud78q83DkS8Cu6I9eb/DuLKPtT/v05V4upsJUB2Q==
X-Received: by 2002:a05:620a:2b8b:b0:6fa:b570:2da7 with SMTP id dz11-20020a05620a2b8b00b006fab5702da7mr19895404qkb.597.1668624425811;
        Wed, 16 Nov 2022 10:47:05 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id m5-20020ac866c5000000b003a4f2510e5dsm9082498qtp.24.2022.11.16.10.47.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 10:47:05 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id p18so12292187qkg.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:47:05 -0800 (PST)
X-Received: by 2002:a05:620a:2795:b0:6fb:628a:1aea with SMTP id
 g21-20020a05620a279500b006fb628a1aeamr16303743qkp.697.1668624424863; Wed, 16
 Nov 2022 10:47:04 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdaJy5hhrMfdZWtpoBUxBEc1QnxaX4pRzQVUBoEoKqrwzA@mail.gmail.com>
In-Reply-To: <CACRpkdaJy5hhrMfdZWtpoBUxBEc1QnxaX4pRzQVUBoEoKqrwzA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Nov 2022 10:46:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi0_VS4r7y9=4jyvpnVLMLkWpDz-xjGxWtTBSefB8VfYQ@mail.gmail.com>
Message-ID: <CAHk-=wi0_VS4r7y9=4jyvpnVLMLkWpDz-xjGxWtTBSefB8VfYQ@mail.gmail.com>
Subject: Re: [GIT PULL] pin control fixes for v6.1
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
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

On Wed, Nov 16, 2022 at 6:57 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> GPG might need some UX polish

Hahhhahhhahaaa [takes breath] hahahahaaa!

pgp (and gpg) "needing UX polish" is like saying "cars might need
wheels" or "fish might need water".

There's being cryptic, there's being actively user-hostile. And then
there is pgp.

I point people to

   https://www.vice.com/en/article/vvbw9a/even-the-inventor-of-pgp-doesnt-use-pgp

whenever they wonder about some oddity in pgp/gpg.

                  Linus
