Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B06069F939
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjBVQo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBVQoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:44:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2154C26
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:44:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B9B861320
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 16:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162CFC433D2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 16:44:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Yy5qhSAV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1677084261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ytZ/9V9l82SpQHYswEJBnfudI5otYuO3mmgDWO1ZxeM=;
        b=Yy5qhSAVrdGq7BFKOAAeI+8zwjnJnXA87WeXgx1yNxfuVj1CXfukhmbzopOOnEfgjmnWRR
        2ZAhFXNVawapXprfIDbCV1E5AlfDRhJe0NLl1gbtBzrw9jyLKOIsaxPwJQvfmbWYpYiAXn
        uQyZc5HlV+oimT82U8c/Jm1UrZn726o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 876385f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 22 Feb 2023 16:44:21 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-536b7ffdd34so123208397b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:44:20 -0800 (PST)
X-Gm-Message-State: AO0yUKWufcNBv0f2v7jp6Xm2q9STtCrcW7OPiEAhrTBoP3Wu5H/aWj5E
        UNApxzQGP5xF973IFO/Zvxav5VhbWYa4kAPwnUY=
X-Google-Smtp-Source: AK7set/zDbh6zeSULPnAijSMPZIv+Sz9djtU4pXVVPebljXJcoe8bEt6lTlctzM+QU7mVrQDNHQQ8IISiqGdgO2kAB0=
X-Received: by 2002:a0d:fb41:0:b0:538:3f0b:425c with SMTP id
 l62-20020a0dfb41000000b005383f0b425cmr273075ywf.43.1677084259874; Wed, 22 Feb
 2023 08:44:19 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk>
 <alpine.DEB.2.21.2302122311470.46819@angie.orcam.me.uk> <877cwltmno.ffs@tglx>
 <alpine.DEB.2.21.2302140447190.6368@angie.orcam.me.uk> <DDFBF35E-D837-4CDC-8EF8-2CBF75C77901@zytor.com>
In-Reply-To: <DDFBF35E-D837-4CDC-8EF8-2CBF75C77901@zytor.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 22 Feb 2023 17:44:08 +0100
X-Gmail-Original-Message-ID: <CAHmME9r4DnQDkx0VSzfuYDyUhNOHy0d3XBzF+hipU7EVy0raKA@mail.gmail.com>
Message-ID: <CAHmME9r4DnQDkx0VSzfuYDyUhNOHy0d3XBzF+hipU7EVy0raKA@mail.gmail.com>
Subject: Re: [PING][PATCH v3] x86: Use `get_random_u8' for kernel stack offset randomization
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:43 PM H. Peter Anvin <hpa@zytor.com> wrote:
> No, I do indeed agree. We're talking something that is a part of an opera=
tion that is already fairly expensive. Now, if RDRAND is available on the h=
ardware then that could be used if someone really wants it to go faster... =
but get_random_*() seems saner than doing ad hoc hacks.

Do you want to go ahead and apply Maciej's patch in [1] then?

[1] https://lore.kernel.org/lkml/alpine.DEB.2.21.2301302011150.55843@angie.=
orcam.me.uk/
