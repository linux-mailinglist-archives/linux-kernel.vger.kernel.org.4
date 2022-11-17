Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30EF62E6A4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbiKQVPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240624AbiKQVPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:15:10 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A2A84310
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:15:07 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v27so4452542eda.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AJq99VDc3uDQq7O+HFYnDWAxxsnyohDRV5q4kWwOTKw=;
        b=VajPH4qUqNXInYGFZBCL1XWvY2DoBv+EJ4EMb3tvm60Gk01Rx9OYP4Z8n7nK6QFbEI
         aJhw0Ynf1HnZfQutJfEDy2uq/T0OMnQNGGHFyE7oKBsVtjz9rx1j4Ob4eTaNZ2/QIswE
         Jm14XbI8RwHFRdLPGhPGiR8Bl8w5dzM+1jF6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJq99VDc3uDQq7O+HFYnDWAxxsnyohDRV5q4kWwOTKw=;
        b=VfjHmJurbdwmB0bwCuVIHKR8PyCqPbU0aDo7o+hitUIL46hdgsf5WHaE1NSu7+r9Nr
         8ChwPkCv2u++LNp6T0xkE1fU1JIYwD9Aw338It1S2YyBw0ISxZmcXeMFysj4LXzPXYvC
         s8w3zSAsgSAYk/Arqreyx/9aAOKu55nuHxLALHKfigaOaJn4XUTQSzCg3DBvddFwDVeO
         zyx+bv5gJYGo02w7rvhpJuXfCCOyVCdCfhGlmh5o8F3ML5l9yajLMzPzd0t7lLzwyfWs
         FPJVh1jMmKJxPVWp+VhuxUw/jogoZO6N40+j5i9iYgy+YPtjlmf2helD8D4wk3LbHywA
         /Vog==
X-Gm-Message-State: ANoB5pnQFbYWgpXxav+Nfa9WnFUeOSakF/Zw+hypghhdAGEnnJkCRFRj
        iZFwsauoaZr8jKshkxdhncVK9I2M7IpfnRwO
X-Google-Smtp-Source: AA0mqf4KgCl7EWrEOUsjGhmM6y6/fUyc2u2IrpB0ksSN/LpH6kOiIEmTzMhohp3SjpzT0/9bqkPcXA==
X-Received: by 2002:aa7:c841:0:b0:45d:2a5:2db8 with SMTP id g1-20020aa7c841000000b0045d02a52db8mr3773733edt.105.1668719705795;
        Thu, 17 Nov 2022 13:15:05 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id jo3-20020a170906f6c300b0077f324979absm836941ejb.67.2022.11.17.13.15.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 13:15:03 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso5340218wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:15:02 -0800 (PST)
X-Received: by 2002:a05:600c:5118:b0:3cf:8e70:f34f with SMTP id
 o24-20020a05600c511800b003cf8e70f34fmr2871562wms.93.1668719702670; Thu, 17
 Nov 2022 13:15:02 -0800 (PST)
MIME-Version: 1.0
References: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
 <20221117133655.3.Iebd9f79aba0a62015fd2383fe6986c2d6fe12cfd@changeid>
In-Reply-To: <20221117133655.3.Iebd9f79aba0a62015fd2383fe6986c2d6fe12cfd@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Nov 2022 13:14:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wna4BXgr2CyGGe=m+crf3WMy6y8-dp_CH1Ga-Q8TQD7g@mail.gmail.com>
Message-ID: <CAD=FV=Wna4BXgr2CyGGe=m+crf3WMy6y8-dp_CH1Ga-Q8TQD7g@mail.gmail.com>
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

On Thu, Nov 17, 2022 at 12:39 PM Drew Davenport <ddavenport@chromium.org> wrote:
>
> ktime_get_boottime continues while the device is suspended. This change
> ensures that the resume path will not be delayed if the power off delay
> has already been met while the device is suspended
>
> Signed-off-by: Drew Davenport <ddavenport@chromium.org>
> ---
>
>  drivers/gpu/drm/panel/panel-simple.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
