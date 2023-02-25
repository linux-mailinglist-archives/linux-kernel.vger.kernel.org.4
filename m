Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB916A268B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 02:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBYBfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 20:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBYBfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:35:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBA519F01
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 17:35:43 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ee7so4387320edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 17:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6y2kSPi11D0yTP/isu7pwaO4frgXiHyKw+zLPrXRqVM=;
        b=IvpJMeRLy7eCQbaNJP4QFWyxFshYi5gHXU8xW1Vu7Jo8yW49OS0sGaxOffU8IWxP3Y
         qKzEEHePIVR6TjcCcAJzHG7PHotdzLUrMRp9+rJMUUjm5I6TdJd2HFIKBSpZI9itKeBP
         e//jzGwMNTEHXZzPMRbkkxCc/F5owBIFrDYno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6y2kSPi11D0yTP/isu7pwaO4frgXiHyKw+zLPrXRqVM=;
        b=yaWl45K6SxRqwa1580COW7mnnNyfxQje0gGh4ih9Rvj2T9X5xMmNQT6RWzlqbPi4d7
         dYvsyhXbJBwWnyYtEllB0/p9kOjD5ALpQEV0Xb56empXJ7m47yUvUUT6PYG4+mqvJy2D
         0vyKnruzahcaowjfzFhYxF5Ulz+2YB1qpsLwN2VAGEEt9jJOXXxscAlWTbGVmIzXXqFQ
         XRIgHr+uw2hy8O0jslxxycRyPNfE9pvwAAOPP8e79ejyiLauo7OJ99XcREbWzB3jFAy2
         o2OpqwJWEnLml2/zXJIrTwmE3YFLkeoqbWc6VbKJHPMYfemZEW3CR5f9+/C3p/zvXg6E
         QZIA==
X-Gm-Message-State: AO0yUKUJXHBYjFh2+KgHqNj6Nw3+59oOrJ6UUBOQ60xpPeAKmMedymeY
        tiu+VD/qgCc2HmsFhCUf+zmqEaoLsLvwZpzBkt3RCQ==
X-Google-Smtp-Source: AK7set8WqbdtvMlk7UyL1Z0gRV7nYOXOZGD2ik8x2xCCNJHhEx5QSvVBr7AETT4S4FppQKn7ErbhQw==
X-Received: by 2002:a17:906:6d11:b0:87d:ed60:cb7e with SMTP id m17-20020a1709066d1100b0087ded60cb7emr28086983ejr.68.1677288942101;
        Fri, 24 Feb 2023 17:35:42 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id h12-20020a170906530c00b008d71e08c78dsm233511ejo.81.2023.02.24.17.35.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 17:35:41 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id o15so1814216edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 17:35:41 -0800 (PST)
X-Received: by 2002:a17:906:40cc:b0:877:747d:4a82 with SMTP id
 a12-20020a17090640cc00b00877747d4a82mr12237781ejk.0.1677288941207; Fri, 24
 Feb 2023 17:35:41 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9txhVJ3t_3-wMdWH7F+=_BbW19NYxAnm2cceP2uHR47_5w@mail.gmail.com>
 <CAPM=9tzPxixXnRuk0Jfs2ESw-eY43H_e5_FtGbxAhRmvaByYwA@mail.gmail.com>
In-Reply-To: <CAPM=9tzPxixXnRuk0Jfs2ESw-eY43H_e5_FtGbxAhRmvaByYwA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 17:35:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4ShzDcZVx07ObELz06dL7m3Ax-p014rAmxGQ3D0brXA@mail.gmail.com>
Message-ID: <CAHk-=wj4ShzDcZVx07ObELz06dL7m3Ax-p014rAmxGQ3D0brXA@mail.gmail.com>
Subject: Re: drm next for 6.3-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, Feb 24, 2023 at 5:30 PM Dave Airlie <airlied@gmail.com> wrote:
>
> Any issues with this? I get nervous around 48hrs :-)

It was merged on Wednesday evening. See commit a5c95ca18a98.

If you were waiting for a pr-tracker-bot reply, I think you need to
put "{GIT PULL]" in the subject line for the automation to trigger on
it.

             Linus
