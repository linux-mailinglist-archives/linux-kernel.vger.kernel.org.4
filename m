Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1C866E4D9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjAQRYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjAQRW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:22:58 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40B149948
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:22:43 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id r15so4538018qtx.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1wkcBqmofA04c9jcFvMRG1CTfOla63rohknUm+bkZuI=;
        b=Zmv4mLxdPkwdhWU2+KlKPYPoZDU6vd0YR886xdzB2ZdFVWwZ7UsXLPBqUCQ5n6wYYE
         y0hvuwyht3n0D8zLJaoqZVhYMTBx2N7uzU/ATZlotJwwW+DUFZUe2jp4bU6MoXlnRS+k
         ytr/2zUVDgyKjFAIvGfwsLtQpvUe+dSwwG/oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wkcBqmofA04c9jcFvMRG1CTfOla63rohknUm+bkZuI=;
        b=OR77pB59Kt0gxYmEd0pfxBbFYusI9e7hV2o11Tj7U0/9PHNJ65oG0rWBFlS5/La8Fi
         E7AEa61eNg7xHj9JQ44OyYyl1LWnxH61PApZjgBKbVU+TBm0Gb9rzLRi+vM/j+gKCGg0
         LO1dWSSH2kGdZr9VHQuX25e+JebrnBsYix5cEEJpU4DmTPPbFcxgkgTN4Jb0jjeAkGqd
         LoWKs2fonJWK5aO0G+tw3w7m9obUiM9V7nnT0NhlosyUVq14fN50g2kxP7IFYGa95cMz
         YmKV8sDJgYOT9/YbRy4+5+WniZTM99Khq9oOi05O7rkvPoMycY+3/7PQrYkmMA7WRnlw
         CM2A==
X-Gm-Message-State: AFqh2kqVE+8Xp3u9ji2PUzm2bBltyWIVDMkVlHY6QoDrYsIhXGB22QfK
        I3kbM6CSDtng5JyZ7VyTM3xLgpxjt+uK9ZY5
X-Google-Smtp-Source: AMrXdXvM6MkFCoyuLltu5sVD2Ozw2G9Jx/PIZnXd6Clqaz+CvYICTV3UVwmFhOKbxPPn2T/cIuz0dw==
X-Received: by 2002:a05:622a:4a0f:b0:3b0:b9a4:a20f with SMTP id fv15-20020a05622a4a0f00b003b0b9a4a20fmr5413903qtb.4.1673976162702;
        Tue, 17 Jan 2023 09:22:42 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id m5-20020ac86885000000b0039cba52974fsm16255085qtq.94.2023.01.17.09.22.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 09:22:42 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id j9so22110954qvt.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:22:42 -0800 (PST)
X-Received: by 2002:a05:6214:5d11:b0:531:7593:f551 with SMTP id
 me17-20020a0562145d1100b005317593f551mr193396qvb.89.1673976162017; Tue, 17
 Jan 2023 09:22:42 -0800 (PST)
MIME-Version: 1.0
References: <d101b94f-cbd6-dac0-f5d1-f6cb32585d0c@I-love.SAKURA.ne.jp>
In-Reply-To: <d101b94f-cbd6-dac0-f5d1-f6cb32585d0c@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jan 2023 09:22:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpViMCG7aN-e0fsdJmSdpNVqTyvCWhzS_XkD-u2jxm_Q@mail.gmail.com>
Message-ID: <CAHk-=whpViMCG7aN-e0fsdJmSdpNVqTyvCWhzS_XkD-u2jxm_Q@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.2
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>
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

On Tue, Jan 17, 2023 at 2:58 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
>   git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20230117

Pulled, but I really would have liked a proper pull request with shortlog etc.

               Linus
