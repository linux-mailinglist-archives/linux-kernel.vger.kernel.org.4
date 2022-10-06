Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634615F6E63
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiJFTsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiJFTsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:48:06 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB09B1144E8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:48:05 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso3397560fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ooBJ63voK+T4xhw7PLOjKLg/v7+jeOQeInbK0q07EDY=;
        b=YUgBKmPubr3qEDT/uQzIu40ebZdL46QgivXJHjm7SuA5KBtGisGZG8/SWXBwMMh5id
         qB3UA/SZZ6VP+mEKxdXSpnHHRzxqSnllv+Hy0WnVO9aHP/O6Cb2bpmxd07axJQzzgetn
         mEkWiEUw3DnRWOFq7bexOR+HwYCNKj+NNnoXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ooBJ63voK+T4xhw7PLOjKLg/v7+jeOQeInbK0q07EDY=;
        b=Fl+0h+CbhZGHm/8nJlLKktl0Qw9uk/9JtfApuC4ZSdI8udPLwRD6tqt8WO6l9JIpC8
         53IRIib4iAYQ9wYt7MPVyfwwvIWCo+c99ZBj4JZjKQulsdHrhS6gzrf0wxjhiyvFmTiH
         9saHAAfHVx0qA5VZZQx/WZZ8KUAtfNJ0O49Fmt1xzM8gac1M7r28xsawx0AOJsG0UXE7
         0e+42JNAWl7fHdUbLYCVLMUxKBRyH2cBJmbdAqqgIyXwwwVrRnJHoUaqGTWVJW2txC88
         XjUvC/vvN6Dxlll08ABWTca+v+a45DO6PaHDu8WUv3L0je4n0IpXE4uggQovGqiTv/fn
         3OOA==
X-Gm-Message-State: ACrzQf2I3mKBfmtWfmnnYEOshoP17HNrI+0x00NpJmjsdbdFvo0rIAQO
        5C5Cjx2xJNekwpUlvd2jZQKUpT7yygqMGQ==
X-Google-Smtp-Source: AMsMyM41wHxwcWF1p1r7xFidJG3dTmqMR4mhvgSUTV5uBwZ8Hgyixnfst0LDN9/QF+Md/dZnmAIxQA==
X-Received: by 2002:a05:6870:b407:b0:131:8535:698b with SMTP id x7-20020a056870b40700b001318535698bmr6188131oap.263.1665085683914;
        Thu, 06 Oct 2022 12:48:03 -0700 (PDT)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id 185-20020a4a03c2000000b004767c273d3csm68649ooi.5.2022.10.06.12.48.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 12:48:02 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id d22-20020a4a5216000000b0047f740d5847so2110407oob.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:48:02 -0700 (PDT)
X-Received: by 2002:a05:6830:1e43:b0:660:fb97:9313 with SMTP id
 e3-20020a0568301e4300b00660fb979313mr648468otj.69.1665085682355; Thu, 06 Oct
 2022 12:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
 <CAHk-=whUp5Ufur6Bmv=H-rDDTNJJ-KVqOKkL+5FmR01jp0dbcA@mail.gmail.com> <CADnq5_Of-8ZyBxee0fZ=0x-eV-2NX_+e9sd-9nmuHdLugSHp2g@mail.gmail.com>
In-Reply-To: <CADnq5_Of-8ZyBxee0fZ=0x-eV-2NX_+e9sd-9nmuHdLugSHp2g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Oct 2022 12:47:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi43xD06UgO2McDT3R=ze_aHgOGjcDOoggSwmQRv2kA+A@mail.gmail.com>
Message-ID: <CAHk-=wi43xD06UgO2McDT3R=ze_aHgOGjcDOoggSwmQRv2kA+A@mail.gmail.com>
Subject: Re: [git pull] drm for 6.1-rc1
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
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

On Thu, Oct 6, 2022 at 12:28 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Maybe you are seeing this which is an issue with GPU TLB flushes which
> is kind of sporadic:
> https://gitlab.freedesktop.org/drm/amd/-/issues/2113

Well, that seems to be 5.19, and while timing changes (or whatever
other software updates) could have made it start trigger, this machine
has been pretty solid otgerwise.

> Are you seeing any GPU page faults in your kernel log?

Nothing even remotely like that "no-retry page fault" in that issue
report. Of course, if it happens just before the whole thing locks
up...

                   Linus
