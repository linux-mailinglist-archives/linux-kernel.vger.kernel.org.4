Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0E45F720B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiJFXsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJFXsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:48:33 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BCFFF8C7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:48:32 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so2496714oom.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pJMiQ46/KiBnfg6+facy6y32ur475qAL7V2FIVVnoOc=;
        b=H1uJFisEq86b1igTJeZ3icitP5usONcBgntp3Bmdfd7L7c+PbhZBFOBQP0sdQg07ow
         qxLoPLeON8LDcpeAyeJpP8HIJaym87ZqEiNnbYwcA07TYw/IVxsX/YQ5VYNjq29zKAWi
         PPHD1nPoH08WKswGp2QF09NZBEnNJqKOysIbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJMiQ46/KiBnfg6+facy6y32ur475qAL7V2FIVVnoOc=;
        b=yW/0PZf07lwz2lBfPWgt7u9l4G5tzizIwnEuWKFmCi9vVFwjhIeuzRh31oaOPNfGX6
         apjTM+XsUK9783UtaDieAwY5VteNbQmQI7swSjnwb6H49DMAoVExnlVC3px8C4HnSC14
         OaPY7lELn3BWlhveKwnHo26s7/z1RNnZtJ/2kgvTQyoAVCrIysnlc1Y3ODlNukD6S+VO
         KsMhX/1gRMC4ic3cbV1JiCcvKj0LvkdTifcrsxr1XmxAmRijXMAW0nc9mbIZ3V+PMcuR
         jM1CsflIGW5hl/4aYGbOVrdtCNFQh6gUKt1dXWvgyI9GUObQuEYgvBFWqnxnC0wwYPmI
         MtqQ==
X-Gm-Message-State: ACrzQf3HCUymDeIDmRM17LJ9zw5ZHGs3UH4Fi5Ihh/L8S1VkdDl96sXC
        vVz8/azB/5ZSB8qywrX1HYROzZTsYY5/4A==
X-Google-Smtp-Source: AMsMyM6ULwC9pyXqBqeqscaU6Ec2r/2lOiLpSKl/6LE3x5ncYYMRP7I64gQXkpyY9YjeYZGIcRPO/g==
X-Received: by 2002:a4a:928e:0:b0:476:6c03:f0c5 with SMTP id i14-20020a4a928e000000b004766c03f0c5mr808829ooh.78.1665100111743;
        Thu, 06 Oct 2022 16:48:31 -0700 (PDT)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id 13-20020a9d010d000000b0066104449828sm476282otu.28.2022.10.06.16.48.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 16:48:29 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so2496673oom.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:48:29 -0700 (PDT)
X-Received: by 2002:a05:6830:611:b0:65c:26ce:5dc with SMTP id
 w17-20020a056830061100b0065c26ce05dcmr1007394oti.176.1665100109301; Thu, 06
 Oct 2022 16:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <Yz6W+j+l0cJbr5dX@debian> <CAHk-=whR8T1x6DRnOMJsorajT3A-y9+j5Mpeh0zcUXcJiJWheg@mail.gmail.com>
 <202210061328.37FCC30@keescook> <CADVatmMOEtX_vpR2iv9r7n5x76xjuyHwx6duERqjMutb=AKrhA@mail.gmail.com>
In-Reply-To: <CADVatmMOEtX_vpR2iv9r7n5x76xjuyHwx6duERqjMutb=AKrhA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Oct 2022 16:48:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2P3=W3iAsuhiMWMZSBPXQQJXudRAONp0xSuCQ218f_g@mail.gmail.com>
Message-ID: <CAHk-=wh2P3=W3iAsuhiMWMZSBPXQQJXudRAONp0xSuCQ218f_g@mail.gmail.com>
Subject: Re: mainline build failure due to 5d8c3e836fc2 ("drm/amd/display: fix
 array-bounds error in dc_stream_remove_writeback()")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
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

On Thu, Oct 6, 2022 at 1:50 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> > And it looks like Sudip's proposed fix for this particular code is
> > additionally fixing unsigned vs signed as well. I think -Warray-bounds
> > did its job (though, with quite a confusing index range in the report).
>
> Not my. Linus's. I just tested. :)

I suspect Kees meant Stephen's other patch that Hamza pointed at, and
that is perhaps the cleaner version.

That said, I hate how this forces us to write random code changes just
to make a compiler just randomly _happen_ to not complain about it.

                   Linus
