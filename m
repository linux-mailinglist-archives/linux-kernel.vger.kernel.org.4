Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D4261F45E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiKGNaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiKGN3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:29:53 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672501D302
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:29:42 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id k2so30131479ejr.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 05:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PM+GvzUOrpzLT7Pau7GHi0eg8fby8y8JxEhzd+k4CsQ=;
        b=VTrxRNePenGfST2wcxSrNrVGneCGqAxict2RxEPTu4I4YlZxOZQdbWtyBocBb/05PP
         dzu01Yv75KglfeLY5TfGFVCM/E1b/ZjSI7UAA5mmeGJ3KDyxXn1/rn5N2WVoPfQ1WDo1
         m1OENUtHehsnS59tJWyVD52Kv066ZBa0iCPCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PM+GvzUOrpzLT7Pau7GHi0eg8fby8y8JxEhzd+k4CsQ=;
        b=6445+Ss/IAR6UHZkUDQR/KfUMd4mSIOJbA1hddx7ZcRM7oQ0qqBOwrF1NDnQP8Xh1/
         pnsVby4BigcMYRtQTu+veNbH3rgZd3Qq7zMiidNDDdYSOaJY8KSQ2u4EGbcjt7hkB5/w
         +TG2cvMsT6UloHr5uB9rajQF89E/Wtq/XRDB6bwW/CoV7WSAm9wozXk1g1sXc10MMom8
         pr/7D0voXBpKauIehfcBZcDA+NTX6p22nTR2BtLlK0o8C7Fwce1KWEj74Ab8z5VQcNr/
         qPCXhE010XJnQo8R/UK3uvO0nvfyayghMYnqWn3Oj4A994nk9F7PCNG5N0VKhonShTK4
         +ruA==
X-Gm-Message-State: ACrzQf2ej4tc41ScIXI2voaw0wbGLH64Y/iuiRieA+Z2Ex9D+5rUrdJt
        e62EVL1d6+WByKEBKQsLlKeXuP4Z4/2lOfRLMoVW6g==
X-Google-Smtp-Source: AMsMyM68sr6fthD5zp+UAeoptxjNTP5Wb1s5z2aihH+2ec/bLWdIELqUV8UOT76xZfmV62a3oENwjLwe0QW00TpO9Bs=
X-Received: by 2002:a17:906:371a:b0:7ad:c01c:6fa0 with SMTP id
 d26-20020a170906371a00b007adc01c6fa0mr43776661ejc.267.1667827781033; Mon, 07
 Nov 2022 05:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20221016170046.171936-1-work.viveris@nightmared.fr>
In-Reply-To: <20221016170046.171936-1-work.viveris@nightmared.fr>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 7 Nov 2022 14:29:29 +0100
Message-ID: <CAJfpegspZ5UJJQZNi6Rdn6wPDfoZE6REFJ-XXX3sebhrHnQ=uw@mail.gmail.com>
Subject: Re: [PATCH] fuse: enable unprivileged mounts for fuseblk
To:     Simon Thoby <work.viveris@nightmared.fr>
Cc:     CONZELMANN Francois <Francois.CONZELMANN@viveris.fr>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Oct 2022 at 19:00, Simon Thoby <work.viveris@nightmared.fr> wrote:
>
> Commit 4ad769f3c346ec3d458e255548dec26ca5284cf6 ("fuse: Allow fully
> unprivileged mounts") enabled mounting filesystems with the 'fuse' type for
> any user with CAP_SYS_ADMIN inside their respective user namespace, but did
> not do so for the 'fuseblk' filesystem type.
>
> Some FUSE filesystems implementations - like ntfs-3g - prefer using
> 'fuseblk' over 'fuse', which imply unprivileged users could not use these
> tools - in their "out-of-the-box" configuration, as these tools can always
> be patched to use the 'fuse' filesystem type to circumvent the problem.
>
> Enable unprivileged mounts for the 'fuseblk' type, thus uniformizing the
> behavior of the two FUSE filesystem types.
>
> Signed-off-by: Simon Thoby <work.viveris@nightmared.fr>

NAK in this form.

Please look at all the places where there's a difference between the
fuse and the fuseblk behavior and give proof that they won't result in
a security issue in case fuseblk is mounted unprivileged.

As a possibly much better alternative, try modifying the ntfs-3g code
to be able to work using the "fuse" fs type as well.

Thanks,
Miklos

fuseblk enables synchronouse RELEASE and DESTROY requests that are
unsuitable for unprivileged operation.


Thanks,
Miklos
