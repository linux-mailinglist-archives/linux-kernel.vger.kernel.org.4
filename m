Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8956BF13F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCQS6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCQS6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:58:33 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D1D16317
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 11:57:51 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id fy17so4136321qtb.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679079399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PTdUlyOfdt8if93QsQQjrsJH2A0sNNFk09AT9iR57Ws=;
        b=EFi3o0HArF7UU3RivOVQRrRlFW6IQCaBsnCtxNHNCGuutqLAXEx8v31+MZ2nNQY+Tg
         FaeF8G47moLnzYjlgYcpsL4zHbS1+XqXmfiOuBODfSQ1uVBlTkeJFAHKAxsFaubZmE5x
         Zipjfqwm3/dJi7P5ugUcx1BfyqT8Caou44eRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679079399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTdUlyOfdt8if93QsQQjrsJH2A0sNNFk09AT9iR57Ws=;
        b=dQ4HIyN0556xfuqxt7xCG0UCs972cvUTv7c1tjD8S1ygn8GdjR6YztuNsB32zyFZ60
         EvT22EZGEHNlhIxehp8x/nlIEM/JlCcCqpsuGZk9vOMDNroKd7BMT9itIXHkiW8Hmsum
         1AyWgr04ft9Wo7HxXFwjWmEpuKdBJGRTADRp6dGqfqykyfiC0Tbh+csdcF9wvnyGFhs2
         VMdpiWi1YxapUxuINsLMIwS4V0PYIGfjxBMNERPLpDImkhlEpILIG2SzRGZuhDPedd+m
         adVcJqIWKWzwuuYS4TicBUFRAuPNl+DMzQ4kFfUcf6jWwLCyAxU7AaQUM0mbkkeaWkLU
         oP/A==
X-Gm-Message-State: AO0yUKVlDORSxNXS0kc4GaE2vTaSVHeq7eYjyvDvJyMPcOxj7mzLDNJ1
        oygHm3waD9f1WDnI9tUp/RjfPKiZ0PElyBfdgW5+Cw==
X-Google-Smtp-Source: AK7set9jipsIbDPeQ8GoSgJyYG70m2o786TV4vW4nF1NZSCv49CfSTMV5e2Aa66Gvx3kXmdFh0Da1Q==
X-Received: by 2002:a05:622a:1394:b0:3bf:b896:ff63 with SMTP id o20-20020a05622a139400b003bfb896ff63mr14593551qtk.52.1679079399521;
        Fri, 17 Mar 2023 11:56:39 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id r142-20020a37a894000000b00706c1f7a608sm2156724qke.89.2023.03.17.11.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 11:56:39 -0700 (PDT)
Date:   Fri, 17 Mar 2023 14:56:37 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kai =?utf-8?Q?Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mptcp@lists.linux.dev
Subject: Re: [PATCH 0/2] docs & checkpatch: allow Closes tags with links
Message-ID: <20230317185637.ebxzsdxivhgzkqqw@meerkat.local>
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
 <c27709bd-90af-ec4f-de0b-3a4536bc17ca@leemhuis.info>
 <81f8be3e-4860-baf9-8e13-fec3a103245b@tessares.net>
 <CAHk-=wh0v1EeDV3v8TzK81nDC40=XuTdY2MCr0xy3m3FiBV3+Q@mail.gmail.com>
 <CAKMK7uESvC-zgGJEup1OAmf34Rk8s5cCrSBYUNP_REFUuer1-w@mail.gmail.com>
 <7974f3ec-3f17-c21c-139b-fd5651871a75@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7974f3ec-3f17-c21c-139b-fd5651871a75@tessares.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 07:41:04PM +0100, Matthieu Baerts wrote:
> @Konstantin: would it be OK for your future Bugzilla bot to deal with
> the generic "Link:" tag instead of the specific "Closes:" one?

Yes and no -- we can easily figure out that "it's a bugzilla link and it
points at this bug", but we can't make any decisions based on it. Just because
it's a bug that is mentioned in a commit doesn't really mean that the bug is
fixed and we should close it.

E.g. it could be something like:

    foo: initial workaround for bar

    This implements a workaround for problems with bar (see bug link below).
    It's not a complete fix, so further work is required to address all issues
    identified in the bug report.

    Link: https://bugzilla.kernel.org/show_bug.cgi?id=5551212

It would be wrong here to auto-close this bug, but we can certainly add a new
comment that says:

    This bug was mentioned in commit abcd1234:
    https://git.kernel.org/linus/abcd1234

-K
