Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA56725A6E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbjFGJaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbjFGJ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:29:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB7C124
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:29:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51494659d49so1109691a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686130188; x=1688722188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2BLecNjxkMJZi1ruU8F6LcBaR2Y9Qu96nuXiY0dXPmk=;
        b=isP58o13oLsDF+FT8fOKygUY77IyyakLSsuA714GY1lg0P+CeKzRvWMTlV1kuFQo2n
         BWgCyp2VsQ8jpwmfvC+c9wAaYbmtRXwiOT5k7UIsn8xjVJTEMSGFVXZrLOGx4sWely/y
         MhvK7A6e8b9M43nFQ4jFXejGtheuR34J3JgfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130188; x=1688722188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BLecNjxkMJZi1ruU8F6LcBaR2Y9Qu96nuXiY0dXPmk=;
        b=QT70p254T5YZRagzKeRv22KM/2LQAyVq9mZlNi/fFiNxF2IEAyfafytB4IvNEQB/0k
         h2XRau1Slbu5ar/tyD9wg3h3utKbiIllcxvoI0J2VBn56aDrUzJadFJDdoYOaM2xrHRv
         9Cf/IrQX3LjVxB6VigIF9VsmWgBZgse8N/XZ6ilDEphYc/oJUnltCWn/QTmSi/iVtBSu
         Q5s7o1dchuLACB1j5pGMVDL8VAUxUwp/mebIm31RlIEQOX7fnA11dMperNeSypNDSuF/
         d0oudD5ewHfvrTtTCzeh4aFBFWCfpM+xnoUlWJbDtI8ZeLWFAld4DpcP/2T2surczyQz
         BF6w==
X-Gm-Message-State: AC+VfDyKy29JC20DvYmVXJ/DeDcPmEimZO1ZbZKiMzmxsYlwHNrTLkiP
        aazzk/1jvePN6NscpM+hoFjauziR7egnf88JuUfqlg==
X-Google-Smtp-Source: ACHHUZ4RtZ8bbXfXPQLckp4Q6RLjZQVlrtyxd2G4isYyaOtvgQlLxX+BwNlbYVP/XvkkNne4dmBuvgtlrW/TnHr5DdE=
X-Received: by 2002:a17:907:72d0:b0:94f:6218:191d with SMTP id
 du16-20020a17090772d000b0094f6218191dmr5673140ejc.32.1686130188072; Wed, 07
 Jun 2023 02:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnZJGDWUT0D7cT_kWa6W9u8MHwhG8ZbGpn=uY4zYRWJkzZzjA@mail.gmail.com>
 <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com>
 <5d69a11e-c64e-25dd-a982-fd4c935f2bf3@fastmail.fm> <CAJfpeguQ87Vxdn-+c4yYy7=hKnSYwWJNe22f-6dG8FNAwjWBXA@mail.gmail.com>
 <9f79a2b7-c3f4-9c42-e6f3-f3c77f75afa2@fastmail.fm>
In-Reply-To: <9f79a2b7-c3f4-9c42-e6f3-f3c77f75afa2@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Jun 2023 11:29:36 +0200
Message-ID: <CAJfpeguXBpyr_3FV1u-VRA9ZSqmGKVWFWZsXPqB-Tqa_JAx=uw@mail.gmail.com>
Subject: Re: [PATCH 0/6] vfs: provide automatic kernel freeze / resume
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Askar Safin <safinaskar@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 at 10:13, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> Assuming a fuse server process is not handing over requests to other
> threads/forked-processes, isn't the main issue that all fuse server
> tasks are frozen and none is left to take requests? A single non-frozen
> thread should be sufficient for that?

This *might* work.  But there could be auxiliary threads, or the
initial thread could be killed, etc.  It would not be reliable.

> Ah, when all non flagged processes are frozen first no IO should come
> in. Yeah, it mostly works, but I wonder if init/systemd is not going to
> set that flag as well. And then you have an issue when fuse is on a file
> system used by systemd. My long time ago initial interest on fuse is to
> use fuse as root file system and I still do that for some cases - not
> sure if a flag would be sufficient here. I think a freezing score would
> solve more issues.
> Although probably better to do step by step - flag first and score can
> be added later.

I'm not sure how systemd interacts with the freezing process.  If it
does, then the only sane thing to do is to make sure it doesn't have
any filesystem interaction during that time.

Hibernation is a different matter, because it needs the filesystem to
be in a working state while all userspace is frozen.  Hibernate to
fuse would bring up a lot of interesting design questions.

Thanks,
Miklos
