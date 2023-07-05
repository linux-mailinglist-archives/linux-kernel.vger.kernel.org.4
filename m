Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5B5748891
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjGEPzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjGEPzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:55:15 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D34D1735
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:55:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso10993674e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688572503; x=1691164503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eeaxsIv3ASkEqAp4A3iR6v0UBJ1ipY1YSW/EwS5Gbfg=;
        b=AhGj7ky8jTBSKOuEojGS9F6gTYYvLzrVyV523zpA6suMcy9RF6RN/DaZQg1tZ0eyST
         V57QJNTrNJtKuK3MW1lAuHLfC3Pw5WsP5K/jysZTN/Ok3Wo6Wm9ra498J45DdATtr1n1
         YGaGv2m5C5cXGqyLOnhi3ZbxTQb/L27sDSVss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572503; x=1691164503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeaxsIv3ASkEqAp4A3iR6v0UBJ1ipY1YSW/EwS5Gbfg=;
        b=X0fjX0/ztQ1TtOanEYCgcV210yhrq6EcEF9Euz519Al5UDChKECBMVrZ0jm32YoleX
         JZULaniLJ0ulJ09ljuQPT4IaMdudj9g0pOpQR4xMH5B60CWp14GA/v0NcJXNaAHDEYnV
         nIT2EWuQqs/y0P8UjtWHFuQ3LCyHlHt2hLP1NFsu5BYeT/LrrsKEkNuuECKJDY2uqmlW
         WRuxJezKy+VnUQl6NOIjOEMvu8tVWG0sDD9oClIi6+u9Pkz85EEdNQMYDAHolL6rEhtD
         xUxPj82FeNeFr76zVicpWYoelH5gg64Dua3d983PS4Cfh3t+890DVcDGOvC+vapDUtUL
         uHQg==
X-Gm-Message-State: ABy/qLZa6hRI7Kh3dsc6TPFpQlK1i1YEsEnv8Bwq3d34ZKpnECjap+mX
        fBC1grPmlnJFSfsf3WSiVIflW+/Mfmr51ZZ5RqnGYTRE
X-Google-Smtp-Source: APBJJlFChyFanlaYKFE6A7JIydmHBPHeYZsNJZxBOM1nWY8sPaUIf+L+65keES+HJIer7wjqgSe8xg==
X-Received: by 2002:a05:6512:3bc:b0:4f7:6775:2a66 with SMTP id v28-20020a05651203bc00b004f767752a66mr10365671lfp.53.1688572502565;
        Wed, 05 Jul 2023 08:55:02 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id d16-20020aa7c1d0000000b0051e26c7a154sm1165096edp.18.2023.07.05.08.55.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 08:55:02 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51e29913c35so528051a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:55:02 -0700 (PDT)
X-Received: by 2002:aa7:d502:0:b0:51d:d1ca:eab9 with SMTP id
 y2-20020aa7d502000000b0051dd1caeab9mr12543171edq.32.1688572501752; Wed, 05
 Jul 2023 08:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <202307041023.bcdbbfc0-oliver.sang@intel.com> <CAHk-=wi3Nb4t-JH6BGE5TOynik=-0kXyBGi3bLKTA85rvqHngQ@mail.gmail.com>
 <b57f35f9-53ae-5a99-d8b7-f1915c1cd1d0@nvidia.com>
In-Reply-To: <b57f35f9-53ae-5a99-d8b7-f1915c1cd1d0@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jul 2023 08:54:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgi--892SZiqC8JWvF-vE7C+82X0VPHTCwbUpmbJWT0fw@mail.gmail.com>
Message-ID: <CAHk-=wgi--892SZiqC8JWvF-vE7C+82X0VPHTCwbUpmbJWT0fw@mail.gmail.com>
Subject: Re: [linus:master] [gup] a425ac5365: WARNING:at_mm/gup.c:#__get_user_pages
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Wed, 5 Jul 2023 at 00:27, John Hubbard <jhubbard@nvidia.com> wrote:
>
> So it boils down to this: crashpad is reading from a valid starting
> address, inside the vma for the ld-linux-x86-64.so.2 file, but it reads
> a full 4KB page's worth, which takes it past the end of that vma.
>
> And although the expand_stack() logic is there as part of the
> __access_remote_vm() path, that logic ignores the size of the read! So
> it slips past without trying to expand the stack.
>
> Note that while next vma is indeed the stack, it is 919 GB away--a very
> large gap.

Ok, that's just the warning being a bit too simplistic.

For the case of a accessing past the end of the previous vma, old
kernels wouldn't have expanded the stack either, because not only do
we have a stack size ulimit, but even if you set that to infinity we
leave a guard gap between the previous mapping and the stack and don't
allow them to grow together.

I made the warning be about "any access below the stack" rather than
try to limit it, so your warning is basically a situation where no
actual semantic change has happened, and it's just that the warning
was overly broad.

I'll tighten it up, and switch the WARN_ON_ONCE() to just do a
"dump_stack()" so that it won't cause problems with the syzbot tests
either.

                Linus
