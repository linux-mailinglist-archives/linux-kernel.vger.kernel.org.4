Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB86564ADE1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 03:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiLMCom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 21:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbiLMCoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:44:39 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86260BF2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:44:37 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h16so10812125qtu.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6YrtMVCi4WDvYhEXVLWW1FmmQIRQNnrvyDRxLnMe8wQ=;
        b=H/Kb8jbkK7O8EOgPL9u/zI0bjx5Hpf6Uk8N1TtUotbskhhTLnlwg4lGSWh7Gm1LSUo
         Mll6BV5akO1BfpJ0t4fKjqv83cxZlVhoewqJq6SnQPOV3xGmcaK4RByoy4GbcvFMfbLm
         FxNvN6099PglUOF12in1KnbZdjfRFAP9EJCIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YrtMVCi4WDvYhEXVLWW1FmmQIRQNnrvyDRxLnMe8wQ=;
        b=1MvmglxU0taB0vhMJQ6V58oEQ7BDy4UAoqGDCtnkdKnxBZbfNg1xcOC6dA1UTZz0VR
         4/ZWzY7Fg95QGKK60ujVazlFcsTNogMOaJiDkrjPbGK7fKHi44sN2tnsc8LR0RvE7nra
         1wXXSEeNyxFT9t4xfnPvDTJ5mcC6pZyz1NOukigMikeAJBZuXObtSnsInb9l70aWo40q
         l6yo+zMaKAxPh6ZOmtfKfelwRz5/LT1yy84/kEKM7lJLzQkoV2hkfcS7L2XDKMw2CD8y
         ODkT4E/ExgEHO8Rspi6n9q9wXp47frURz8DCeNozqKHXIQRadDnUFZCTlsqkEpzrqoLJ
         YCSw==
X-Gm-Message-State: ANoB5plgx+HyjU43wwd06z9cmaZaPCyWkBxuQ0K9WdaJCjcgQJrsvUf6
        MXolspmc4NvNktKFBo223u5BAv+yS7I8j46v
X-Google-Smtp-Source: AA0mqf6MaVb6BvpqIKNI94Bs/5B7IuRZyH0V+It/x7Q8Ej9K+9u3h+kq9m5t754vbhehvQmQP2bm+A==
X-Received: by 2002:ac8:6753:0:b0:3a8:16a7:6968 with SMTP id n19-20020ac86753000000b003a816a76968mr8316582qtp.46.1670899476335;
        Mon, 12 Dec 2022 18:44:36 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id f12-20020ac8464c000000b003a7f1e16649sm6956017qto.42.2022.12.12.18.44.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 18:44:34 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id ay32so10790245qtb.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:44:34 -0800 (PST)
X-Received: by 2002:ac8:4992:0:b0:3a7:648d:23d4 with SMTP id
 f18-20020ac84992000000b003a7648d23d4mr18731340qtq.180.1670899474206; Mon, 12
 Dec 2022 18:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20221212134425.b20b80955e5e8a4a36ce1b9a@linux-foundation.org>
 <Y5eoS/UfBhovR70j@zx2c4.com> <20221212142754.5f699c4ff515fd9d42768fb2@linux-foundation.org>
 <e7c6b99a-743f-f40a-0b0f-31730964cb36@suse.cz> <20221212183554.e0a2536e860172282b189ca4@linux-foundation.org>
In-Reply-To: <20221212183554.e0a2536e860172282b189ca4@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 18:44:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjaO_S-kMb1n00suvnTBQS=mY2tH-YG9Tti_5pxnn_tzQ@mail.gmail.com>
Message-ID: <CAHk-=wjaO_S-kMb1n00suvnTBQS=mY2tH-YG9Tti_5pxnn_tzQ@mail.gmail.com>
Subject: Re: [GIT PULL] non-MM commits for 6.2-rc1
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

On Mon, Dec 12, 2022 at 6:35 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Well here's a hacky thing - just look for duplicated patch titles after
> stripping away the hashes.

Please don't do that.

Just use the git machinery that Vlastimil pointed at.

"git cherry" uses the actual patch ID (which is just a hash of the
patch with whitespace removed), so it actually looks at the patch
itself, not just eh first line of the commit message.

If you insist on writing your own shell script for this, please use
that same "patch-id" logic. That's made available by "git patch-id".

But do "man git-cherry" and "man git-patch-id" before you do any of that.

And in no situation should you go "the first line of the commit
message is identical, so the patches must be the same".

                     Linus
