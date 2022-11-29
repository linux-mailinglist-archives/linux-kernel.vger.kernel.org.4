Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D863CB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbiK2W3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbiK2W3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:29:04 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765B970443
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:29:00 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s5so21684742edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6TrUzytMxBgpuzK57XjYnA/tMg3rSbk1sqf4aWr+LLU=;
        b=eW+60F5ZaNSC2vEWF64zkR5vH38+E1w332c473FboCrBKMdYPCULVkM1vLD2EUZaFX
         6SOjRXQZffEKd3kUKL7JfsONN9tZY9FK1LGnH4GJCJ0XsqM3CJ4Wsxh7XDVz9egSx93F
         /IuBBwVFWzHypybwJ9Kp+s91qbenBEmwrD5Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TrUzytMxBgpuzK57XjYnA/tMg3rSbk1sqf4aWr+LLU=;
        b=3w/sgGyPZ3X/WbBPGk7Wq9sIBDQzyP8sICyV2XqfTBscSRpu3bpQLC31XxtbC33F9H
         eV1p7munKegO7pUpXFRHXmuG2H8K0V/drr8tY1Rrw0cJxWTeBj9x4IgoeRuuU2hF6kLn
         m8Fut0uCGytzfQoD9DGSn1PRQR/uxoasIVgdqD/7H9QpRb5Tq9TwwmDYIltXUFkDe2qc
         zNsACrxZbYVpiSu3DcR4fj4kDDDEM97a4/G++mVycplr+SPCVNR2KfE1mZm8Ff0eaFQY
         NT8cEC8Cu60KVul8DGz/VmR9GwxQIHPOZ+fYFxKM6dGZx8yj6iS3HnMl9qnELnMM01Fl
         PCCg==
X-Gm-Message-State: ANoB5pnxZThNLK438VsmNTDJ97h9SxLbO8YAFCk4a3WjPtZuJLfZCZLU
        ndt9bFfmRW30CvTvBRnRI+g6Mx7Wc0YLCET3
X-Google-Smtp-Source: AA0mqf7W+b6y6uzIyP6iM/GjCSm8waXIFDbzMcWYzJkLQmMOYwdLrN0ARF8OrqseqhZgCbhPpbXJVA==
X-Received: by 2002:aa7:c754:0:b0:46b:6096:a884 with SMTP id c20-20020aa7c754000000b0046b6096a884mr7427404eds.152.1669760938696;
        Tue, 29 Nov 2022 14:28:58 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709063d6100b007c081cf2d25sm1598154ejf.204.2022.11.29.14.28.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 14:28:57 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 83-20020a1c0256000000b003d0683389e1so73000wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:28:57 -0800 (PST)
X-Received: by 2002:a05:600c:3c8e:b0:3d0:69f4:d3d0 with SMTP id
 bg14-20020a05600c3c8e00b003d069f4d3d0mr2921033wmb.93.1669760937284; Tue, 29
 Nov 2022 14:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
 <20221117133655.3.Iebd9f79aba0a62015fd2383fe6986c2d6fe12cfd@changeid> <CAD=FV=Wna4BXgr2CyGGe=m+crf3WMy6y8-dp_CH1Ga-Q8TQD7g@mail.gmail.com>
In-Reply-To: <CAD=FV=Wna4BXgr2CyGGe=m+crf3WMy6y8-dp_CH1Ga-Q8TQD7g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 29 Nov 2022 14:28:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U9HwRRHo_Q9EQVMFM9kdPyyjzibdV-44+seJRXzLYRkw@mail.gmail.com>
Message-ID: <CAD=FV=U9HwRRHo_Q9EQVMFM9kdPyyjzibdV-44+seJRXzLYRkw@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/panel-simple: Use ktime_get_boottime for delays
To:     Drew Davenport <ddavenport@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 17, 2022 at 1:14 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Nov 17, 2022 at 12:39 PM Drew Davenport <ddavenport@chromium.org> wrote:
> >
> > ktime_get_boottime continues while the device is suspended. This change
> > ensures that the resume path will not be delayed if the power off delay
> > has already been met while the device is suspended
> >
> > Signed-off-by: Drew Davenport <ddavenport@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/panel/panel-simple.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

7e682946db98 drm/panel-simple: Use ktime_get_boottime for delays
