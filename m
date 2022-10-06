Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FF75F6E55
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiJFTmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiJFTmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:42:09 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5502FAA3F4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:42:08 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-12c8312131fso3389501fac.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6r/G/FPUQy4dyX7xrRC1W4jJwBxwg1McHDgAeD3KbOs=;
        b=YKJ3k2p8QKCGtiarfIip3UkE7k+qso3S4D5O6YqUUSyP9shpTpIBxQ8/kS+RV0sYfc
         bFuz56vn343CcKDBnRjfLE57o/IssaFZ9TCsZ0xsABahSkoCysy/EDoS3ViORklXE4jd
         tXnlQ+T7k1o9CnYhtqc5Vo8cI0yeVD1kbIflE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6r/G/FPUQy4dyX7xrRC1W4jJwBxwg1McHDgAeD3KbOs=;
        b=nzUxV6UnQAMKbtyP+Ca4aqvIptTgo9bb0vaRpuYNSX09WEdSbCVdOsZ1ykUZ8Gwb1q
         CyBYxuNUDyJfwYnna1bxhp2wFJ6q9SaRjfeliLJ+l7p7G8/sWHZR2I3czgadOlKNIpW6
         mldDqyuTmjH3mFLfF1DIXaTak3iRKko/6m83EHHKpb6JtOakZ/DgGcVRbSE5NHPQRC62
         m3gX5KRWvvCtZgKqzEMsA/NhoMZqBM5hBOYClcu84ofh/FGYfXW5hxdlt4N3LmDG1LvP
         P3I/q4+QGZ3+v0y0xIid/ouGfylV8MSS/AAgmbF3iqxNJc9ePD+sAIwK60u/Sja+3Zr6
         hg6A==
X-Gm-Message-State: ACrzQf2By0pegjjTOKqK1RU/RNQ37Sw7gWnlRiWYIqJpPocYAHjEUU+e
        X4zbmPx7HmWUUvB6VctHbxefxXo4rSyhJA==
X-Google-Smtp-Source: AMsMyM646hVcOJDUxPecBaRiLVy155am85s5g9PhVhnDW+honWTfr9fvtDIIM59wjHfDwUKt7Qa4ZA==
X-Received: by 2002:a05:6870:73c6:b0:131:a2fe:97ea with SMTP id a6-20020a05687073c600b00131a2fe97eamr777693oan.29.1665085327081;
        Thu, 06 Oct 2022 12:42:07 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id i2-20020a4aa6c2000000b00475d676d2d4sm41146oom.16.2022.10.06.12.42.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 12:42:06 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id q10so3204317oib.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:42:06 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr640795oif.126.1665085325931; Thu, 06
 Oct 2022 12:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
 <CAHk-=whUp5Ufur6Bmv=H-rDDTNJJ-KVqOKkL+5FmR01jp0dbcA@mail.gmail.com> <CAPM=9tzr1EAA=OaFmrPFT3UqQO+dixdZTPzs=tqdmgP+F_ojEA@mail.gmail.com>
In-Reply-To: <CAPM=9tzr1EAA=OaFmrPFT3UqQO+dixdZTPzs=tqdmgP+F_ojEA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Oct 2022 12:41:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgmaqcw0mXYM+rMt_h-_g+0hoP3ZUPhizN3VtmqLVFTw@mail.gmail.com>
Message-ID: <CAHk-=whgmaqcw0mXYM+rMt_h-_g+0hoP3ZUPhizN3VtmqLVFTw@mail.gmail.com>
Subject: Re: [git pull] drm for 6.1-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
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

On Thu, Oct 6, 2022 at 12:30 PM Dave Airlie <airlied@gmail.com> wrote:
>
> netconsole?

I've never been really successful with that in the past, and haven't
used it for decades. I guess I could try if nothing else works.

               Linus
