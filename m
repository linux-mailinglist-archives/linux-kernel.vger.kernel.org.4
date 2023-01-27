Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F0067E96A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjA0P0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbjA0P0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:26:35 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA237C704
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:26:32 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id me3so14653544ejb.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9lCm2tMGNVKG6SWJp8e+YHP+g7R9bSQ20DL1jjRz9r0=;
        b=bbjGC6z9OVURgKt9VG4FKQztxD1j00SaCwSLpdaFsCfe20fjvGBgYkKNYV6QnSvb5U
         mmMjeNscAdpiKrqEuEotSNiPB7c7sAExKvVpYBbUuZZUmZsfwtNVtXVqXNbDj4fvNjmY
         MdG+81V/FPZXqhHnAP8sdtMbLPIsHS1gd4WuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lCm2tMGNVKG6SWJp8e+YHP+g7R9bSQ20DL1jjRz9r0=;
        b=vtGi7DYQ2xbpIgEyQn8eIqsiWFogcHE6tp9reJjJguDgi0QGr9vYAZjK2Gg26Q+ohk
         MssQUvUqUCBSOvIKJ/WehM63WqVih8fsbpC/OiZO2eBBQJay22153l6HBndvqFxBqVOq
         OXqcTgyVyDFJ7MzrXMpar6Dp0mxPtRdKfIRbEOF3w0OK/vmvsjjCYlJy3s5BdofEeENS
         nNa4cGl8UxO4fX5ZEnHc1Q/+wBPw3fzoW23gkv7/Ya8vLia/0lSQxXPF2/oChznEBaWg
         5kbTGNGPuqhusfTI58hGGzpSqIFayR26p8tKePLmQsFgJXrMZeY8DVcKnGAFqFfuznEu
         XniQ==
X-Gm-Message-State: AFqh2kqx1LCkdn6JdPm+KrHXZq7luA5dK3jQTqa+xZmXoOg1cR7mZPoA
        S9tS2RV+oqBkPmIAif26uOB3DvYFPJun1hmClP1pdg==
X-Google-Smtp-Source: AMrXdXsTaQwz9TAD4rVJPOzzyithzlpBYYsLgWwxH4XVWPutH94i7xmf530C53weISltIhZ9TNtMoQ7rNydz0nbu+IE=
X-Received: by 2002:a17:906:2e94:b0:84d:ac8:ec37 with SMTP id
 o20-20020a1709062e9400b0084d0ac8ec37mr6058289eji.138.1674833190571; Fri, 27
 Jan 2023 07:26:30 -0800 (PST)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 27 Jan 2023 16:26:19 +0100
Message-ID: <CAJfpeguv6BpewqDjDLqQv2yaR+nPLmmAp++JWNquWpXt7eiepQ@mail.gmail.com>
Subject: [GIT PULL] overlayfs fixes for 6.2-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
tags/ovl-fixes-6.2-rc6

Fix two bugs, a recent one introduced in the last cycle, and an older
one from v5.11.

Thanks,
Miklos

---
Miklos Szeredi (2):
      ovl: fix tmpfile leak
      ovl: fail on invalid uid/gid mapping at copy up

---
 fs/overlayfs/copy_up.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
