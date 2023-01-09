Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566586633F5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbjAIWag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbjAIWad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:30:33 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E1F9FEA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:30:31 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-4a263c4ddbaso133148417b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 14:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Etjm9Dlk/7tnYluKuL1l8cLN4HXN57cHBo2UWgCm8No=;
        b=RSsUv4doBWTGohcwA0QQ20imwlo+rji/mohqkj5jdECFaQl5cvpATDvzr0roz9Fihz
         FZIbp2zbXD6Nq7ax9iHixOeNXRe1avfQRPqVoWgZYi7jVoa72Zyz5XKAUiAOGTvPgbNK
         djJfAi+tnt8lPIC4YapAVpXMBC/bN+SIs1HHCCQjPJy/9hbXdaHXE2PcQLW5TCc9ycIn
         1BiC9ZmgRl7kMJrE7ELi5ETo1n4GG8OqpIifPfMBMqbAwaZ8OqpZ1MEvtchqqYTWVBnM
         12uXvCsKIof4e7KeiU+9CUIMK0ptewOlPwJp2a+/EvC3BnddrfuBeM7QuVZMUN8ImP7y
         khsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Etjm9Dlk/7tnYluKuL1l8cLN4HXN57cHBo2UWgCm8No=;
        b=6Mzlsc/ogh7PL7LtQQQB+AplGBq4l9Z1MmZqMnIg2o7zgKWyWa+WcKvULZVM9ytLWG
         EGxtBC83ujgnPZc6y90nlyIm28SR3Xvod66ME/CW2bEKvMvfHHCplJAr2BVhx/5+pMS6
         Wi4HW+xtMDg5D5x5Myri1Pv+xNgZcatbq5TFk8U9bmUPmLcknSoPqfjgnUN1XRuYevsY
         BAjWnZ7y23MIWCRY49xRZxSZjAK5H/Yee/B35zX30swc/3AnpwuFShCPPnmL4rQQ8gRm
         v8pddjwD4vdR/twpXllTglUeUHRYN3xXOV/nw1JOovxzsTJNS+tBpS9epS4RZSaphgh1
         AI9A==
X-Gm-Message-State: AFqh2kr4wF5oIxyeSuCvtJfrCeEVuyNRVNwfwYIsxGrfuH3muNRSNQ30
        V0QRzxLgDO9XNPVIl6E3gCTvNOg/LM8yBIXxvfy0Vw==
X-Google-Smtp-Source: AMrXdXu8rVXaogbfcZATppb3MKKC6eSDW4Jqgg7PJkt75Ebg/+tyvdnCOqDDCbszQdaDH6bI6qTTVZx5AdrYOo/aBDI=
X-Received: by 2002:a0d:e347:0:b0:4b9:89a3:3d03 with SMTP id
 m68-20020a0de347000000b004b989a33d03mr2291119ywe.11.1673303430778; Mon, 09
 Jan 2023 14:30:30 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjwrqFcC9-KkfboqATYwLfJHi_8Z5mTrJh=nf8KT_SjUA@mail.gmail.com>
 <20230109174742.GA1191249@roeck-us.net> <CAHk-=whC+YpdympyegB0Wr_0_6=LYggdabkMExRus2DtAdsv-Q@mail.gmail.com>
In-Reply-To: <CAHk-=whC+YpdympyegB0Wr_0_6=LYggdabkMExRus2DtAdsv-Q@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 9 Jan 2023 23:29:54 +0100
Message-ID: <CANpmjNOmDp_sZgRuks3OZfT015vLwSKcfdFFC=yLGPUNOxnecg@mail.gmail.com>
Subject: Re: Linux 6.2-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <kees@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 at 23:18, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
[...]
> > kernel/kcsan/kcsan_test.c: In function '__report_matches':
> > kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes is larger than 1536 bytes
> >
> > Context: CONFIG_SLUB_TINY is enabled with allmodconfig builds.
> > This enables some previously disabled configurations and disables
> > some previously enabled configurations.
>
> I do think that the test code should be a lot more careful about
> random things on stack.
>
> We've had this before with the EXPECT() macros generating *much* too
> much stack space, and it's not ok for test code to violate kernel
> coding standards even if it might be a "odd config that isn't
> realistic".
>
> That function does some odd things, including
>
>         typeof(observed.lines) expect;
>
> WHAT IS THAT TYPE? It turns out that we have
>
>   static struct {
>         spinlock_t lock;
>         int nlines;
>         char lines[3][512];
>   } observed = {
>
> so it's basically a 1.5kB byte array.
>
> And then des
>
>                 char tmp[2][64];
>
> to add some more pressure. So yeah, can't blame the compiler being
> stupid, this is just bad code.
>
> This is all very much a "this needs to be fixed, or the test just
> needs to be removed, because that's not acceptable".
>
> None of this is new, but clearly it was hidden by config issues
> before. Added the guilty parties.

The 1.5kB array is being fixed by
https://lore.kernel.org/lkml/20221231004514.317809-1-jcmvbkbc@gmail.com/
-- I suppose it's fair if you'd like to pull that patch right away, or
wait for the next PR from the xtensa tree (Cc Max).

Thanks,
-- Marco
