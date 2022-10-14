Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD465FE84D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 07:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJNFFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 01:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJNFFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 01:05:08 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F43B4E41F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 22:05:06 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id z8so3060064qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 22:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c58OXeLn4p9khAmfcGXdtPDfOgfwmf+kmuPnuHvzL7o=;
        b=KzF1jdXnGbTJGSkKyBE4RwB3Ujud9hmwzc6rWNY2CUDd2lzj6W97T1r7U909VWQ6H5
         ToXCuBuLX463El6MEE+4YLVdbhFN/u0nIg4r+vKcwDlBvvT/iUI+qi2WGeKZLkd7Z1ZU
         fxFCJ5ptXsQOl6XMySW4b7Rcwfny+qwPFyhmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c58OXeLn4p9khAmfcGXdtPDfOgfwmf+kmuPnuHvzL7o=;
        b=rMfNvQcOe0dchDHVgwYhioCpYcVh3Debt7AMyAbaWlRZbSnPy88Y+tXP+QD0+CM1me
         amsbkrqn+bD5hkPtxfcjKrr93Wx5DhwIQVOayUMICchf2Axpy57KudbBRsidyW3pxQnu
         Uv9SiQ2AIxNfcgGiFwfjw3rCcJc/4HLKzkLU2bbITn7LE+LbRPyFpV953trGYdKAI5Oe
         tizCNdExJ3xP3DQv7iuHXQmlVOFWB3zUy7iAESzQ/9eR/QZ1pDecMedvgNBxNcsRy8n/
         mqLD6910zU1Rrp6dfeXTF5+xgCx47u83j1HQhFk3FdugqsXMjLHeJV5mklkPqvPXsYXC
         4Ryg==
X-Gm-Message-State: ACrzQf2uc2qV/0G5xHQuGGNNPG+3h9hrJpoWqp8UoboioQN3b7kC3LoO
        lSVEbu5QasTUKPq3PYPidmib/LblkYlWYQ==
X-Google-Smtp-Source: AMsMyM5cCZ7u6oqYWNCpzBEAG/E4GhovcHzWMnpbke2URHtOmfjuBe/fG/q08FKd+6pnndAnhWqmYQ==
X-Received: by 2002:a05:622a:614:b0:39c:cd36:ff9a with SMTP id z20-20020a05622a061400b0039ccd36ff9amr2749284qta.432.1665723904883;
        Thu, 13 Oct 2022 22:05:04 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id t200-20020a3746d1000000b006cbcdc6efedsm1463984qka.41.2022.10.13.22.05.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 22:05:03 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3608b5e634aso36324367b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 22:05:03 -0700 (PDT)
X-Received: by 2002:a0d:fe07:0:b0:360:c3e9:fc8a with SMTP id
 o7-20020a0dfe07000000b00360c3e9fc8amr3101468ywf.441.1665723903437; Thu, 13
 Oct 2022 22:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9ty3DGWa8vnfumgSrpSgWnixWjikb6C0Zk_5bW+deKLVQw@mail.gmail.com>
In-Reply-To: <CAPM=9ty3DGWa8vnfumgSrpSgWnixWjikb6C0Zk_5bW+deKLVQw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Oct 2022 22:04:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whStfYqRSsFXeoCmTeJu0VHNwfP_tYO7pKDMw-uQpraDg@mail.gmail.com>
Message-ID: <CAHk-=whStfYqRSsFXeoCmTeJu0VHNwfP_tYO7pKDMw-uQpraDg@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.1-rc1
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

On Thu, Oct 13, 2022 at 5:29 PM Dave Airlie <airlied@gmail.com> wrote:
>
> Round of fixes for the merge window stuff, bunch of amdgpu and i915
> changes, this should have the gcc11 warning fix, amongst other
> changes.

Some of those amd changes aren't "fixes". They are some major code changes.

We're still in the merge window, so I'm letting it slide, but calling
then "fixes" really stretches things. They are fixes exactly the same
way completely new development can "fix" things.

                      Linus
