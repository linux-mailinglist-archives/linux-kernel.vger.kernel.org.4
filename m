Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B679C5F6E4D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiJFTkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiJFTkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:40:04 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4EB2A261
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:40:01 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n83so3177108oif.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2rfFLTjrQP4Fs05vC2spzCNZmbqViurrXQPntyMULUc=;
        b=YOZJVG6+3eUoB+z47gniaYwRj4q892BGbzsUmXa8JZ749nhmg4i+5R9Xkmj7Teg7Ts
         qUsfZETBoSEUctCMzSHOHnJyiQnagLgha0o6TI8FZi2nYSdju6Q10U7rXsMWGIcI8QfE
         sZdoeav9x+37Lg1XTxyJ0M4yci7/w3Xooven0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rfFLTjrQP4Fs05vC2spzCNZmbqViurrXQPntyMULUc=;
        b=U5wmF22ZHCSdqUfW61IaS+zVaEU1gHBRWQtOBJfqggVPC9uUO9JTm0AcMO8RS7cKTr
         z/NYdmk9mkhcRpP2ct+KP6djlJoKj2AtGSFN7vGJ5UdE0cp8tn3C7t1Eo8jTVH+ebh4j
         TzG2pClIY5wV3LkgZ+Ij3eY+NMg8FuF5hPCazuelheOtzsjq9jQGEAQMoqo/z2TL1BaO
         zZIJZpBbQ6kL8UnR0bVaBwhOimUj21hrk7LHKsb6bA/hSMPwTYUKsnNNLIo62p6J9v4Y
         Ed3YUb5HCctEhAWj04nPgnEnpzLlf85EO0mmuJlA04YGg+CK8UGdFOm5MbGAUYo/j/Xm
         aJvQ==
X-Gm-Message-State: ACrzQf0Oe2G8FZGr+FgsXdLIdirJcbyOrdRnWZ+xbC9kpNN2c9agvdWi
        0GtWjIgekwxWGWG3ARdeLcYdI8/XITEMgQ==
X-Google-Smtp-Source: AMsMyM5wraS23fncZg1OLyLE9CyUqfh4NTPU+Sp9aq02yf6jFLA2rglfPxn8cTV3PSk5ig6TK0t5Mg==
X-Received: by 2002:a05:6808:16a1:b0:353:b8d9:c277 with SMTP id bb33-20020a05680816a100b00353b8d9c277mr5732372oib.204.1665085199540;
        Thu, 06 Oct 2022 12:39:59 -0700 (PDT)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id n2-20020a4aa7c2000000b0047634c1c419sm41837oom.12.2022.10.06.12.39.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 12:39:57 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id c13-20020a4ac30d000000b0047663e3e16bso2116417ooq.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:39:57 -0700 (PDT)
X-Received: by 2002:a05:6820:1992:b0:475:c2c0:3f92 with SMTP id
 bp18-20020a056820199200b00475c2c03f92mr493824oob.96.1665085196830; Thu, 06
 Oct 2022 12:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <Yz6W+j+l0cJbr5dX@debian>
In-Reply-To: <Yz6W+j+l0cJbr5dX@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Oct 2022 12:39:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whR8T1x6DRnOMJsorajT3A-y9+j5Mpeh0zcUXcJiJWheg@mail.gmail.com>
Message-ID: <CAHk-=whR8T1x6DRnOMJsorajT3A-y9+j5Mpeh0zcUXcJiJWheg@mail.gmail.com>
Subject: Re: mainline build failure due to 5d8c3e836fc2 ("drm/amd/display: fix
 array-bounds error in dc_stream_remove_writeback()")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Thu, Oct 6, 2022 at 1:51 AM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> This is only seen with gcc-11, gcc-12 builds are ok.

Hmm. This seems to be some odd gcc issue.

I *think* that what is going on is that the test

        j = 0 ; j < MAX_DWB_PIPES

makes gcc decide that "hey, j is in the range [0,MAX_DWB_PIPES[", and
then since MAX_DWB_PIPES is 1, that simplifies to "j must be zero".
Good range analysis so far.

But for 'i', we start off with that lower bound of 0, but the upper
bound is not fixed (the test for "i" is: "i < stream->num_wb_info").

And then that "if (i != j)", so now gcc decides that it can simplify
that to "if (i != 0)", and then simplifies *that* to "oh, the lower
bound of 'i' in that code is actually 1.

So then it decides that "stream->writeback_info[i]" must be out of bounds.

Of course, the *reality* is that stream->num_wb_info should be <=
MAX_DWB_PIPES, and as such (with the current MAX_DWB_PIPES value of 1)
it's not that 'i' can be 1, it's that the code in question cannot be
reached at all.

What confuses me is that error message ("array subscript [0, 0] is
outside array bounds of 'struct dc_writeback_info[1]') which seems to
be aware that the value is actually 0.

So this seems to be some gcc-11 range analysis bug, but I don't know
what the fix is. I suspect some random code change would magically
just make gcc realize it's ok after all, but since it all depends on
random gcc confusion, I don't know what the random code change would
be.

The fix *MAY* be to just add a '&& i < MAX_DWB_PIPES' to that loop
too, and then gcc will see that both i and j are always 0, and that
the code is unreachable and not warn about it. Hmm? Can you test that?

And the reason gcc-12 builds are ok probably isn't that gcc-12 gets
this right, it's simply that gcc-12 gets so many *opther* things wrong
that we already disabled -Warray-bounds with gcc-12 entirely.

If somebody cannot come up with a fix, I suspect the solution is "gcc
array bounds analysis is terminally buggy" and we just need to disable
it for gcc-11 too.

Kees, any idea? Who else might be interested in fixing a -Warray-bounds issue?

                 Linus
