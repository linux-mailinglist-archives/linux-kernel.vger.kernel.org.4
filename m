Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387A75FF377
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJNSPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJNSP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:15:28 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E203387A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:15:27 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id t4-20020a9d7f84000000b00661c3d864f9so2316585otp.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KM3d9mUdbDj0z6oafXxyZzutznAV5jWXZ9fQzWHF6Bs=;
        b=TsKo2S7GdpxCnrWyTu2QEbbgciSN5woqwIPML3g0E6pmL75LsB288Sf+10bV5E1FMd
         +Cw39hD+tRwMpp7CEfBS80jSkGVcSwaae/dPmihuAxxWq7V7xBbSQfW1nes3ZLh+Mnsr
         72Y30bhKclxNEcE+iZB8casHWCU81PWTfK/qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KM3d9mUdbDj0z6oafXxyZzutznAV5jWXZ9fQzWHF6Bs=;
        b=E27NtvHLp7VAXidaD4TsnwVLbC14jzVT3ZCW1g/ebYByjEafbKWZAFhdKeJa4c2CEV
         VcbcDOgabkg/JWuSBM31JrYdvE1JMhT4296bcsWDotfHU6TuWDnQs1ZYulOYBMDIiO2d
         rYvqHOMernALq7Ru2BY5K1mCJFDtNUSBBQc3Hpa2JCuuHL2jKGoCLvrg2zaKHEJjR5J6
         Y0L8KFkXCXo4abncZoqP/dwcvBPxntfYcBZz2bRbg4iUx5u8NGPe/iK8+2aMHPWihXHt
         G8YWF1H76Rw9yOVcbzJDC5sTeFjzQulCicw6DbrAyeVqthAVrIc6aMO9XoGyrWaOTrsK
         2imw==
X-Gm-Message-State: ACrzQf3+hSR37DUFV0kATbkCpe/72EmKodXicABKhnT5i/o3DozxCQLn
        bdnMuO95CYPbdTDLQKdRn+c2Z0wf9gs0hg==
X-Google-Smtp-Source: AMsMyM74Cg31oDHr083nRel73yy2eGI54KkYXDU22DJbH4LKkBWQ9N/EsGJbKUbtgaMzwMfCKHVk/g==
X-Received: by 2002:a9d:191:0:b0:661:a5db:56d1 with SMTP id e17-20020a9d0191000000b00661a5db56d1mr3136048ote.125.1665771326541;
        Fri, 14 Oct 2022 11:15:26 -0700 (PDT)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com. [209.85.160.53])
        by smtp.gmail.com with ESMTPSA id 1-20020a4a1d01000000b0047634c1c419sm1242538oog.12.2022.10.14.11.15.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 11:15:23 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-136b5dd6655so6800093fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:15:22 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr3564382oad.126.1665771322642; Fri, 14
 Oct 2022 11:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221014152102.1755050-1-nathan@kernel.org>
In-Reply-To: <20221014152102.1755050-1-nathan@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Oct 2022 11:15:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8LT6iN7ZFE_6Yfydne9gWYJaJzD1ntSuGhMv8SkKCcw@mail.gmail.com>
Message-ID: <CAHk-=wg8LT6iN7ZFE_6Yfydne9gWYJaJzD1ntSuGhMv8SkKCcw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix build breakage with CONFIG_DEBUG_FS=n
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Yunxiang Li <Yunxiang.Li@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Fri, Oct 14, 2022 at 8:22 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> After commit 8799c0be89eb ("drm/amd/display: Fix vblank refcount in vrr
> transition"), a build with CONFIG_DEBUG_FS=n is broken due to a
> misplaced brace, along the lines of:

Thanks, applied.

              Linus
