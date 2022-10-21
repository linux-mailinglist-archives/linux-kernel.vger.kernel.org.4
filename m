Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F50B6079AA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJUOeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJUOek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:34:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E601F2D2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:34:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z97so6572778ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lD0xgbVkvhygXmPzL7EMrxyMcD+kjNgjJAnULQCkoIg=;
        b=lTprzbMUXUupoaSFA6UAyc6cElH1N3JEnI4k13G0pTpJEu3Ej0mzoFZlr4CF1+Ud8m
         LB7R/XAZOjZJogN8NRAuhbD5TEmx0KAlank7AwEpw7IoWJZ7WZ/lwKt5eK0cQYJxk7pj
         AO004nZp+ikIUmXX3fN47RsgS16YuKigjcD1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lD0xgbVkvhygXmPzL7EMrxyMcD+kjNgjJAnULQCkoIg=;
        b=SXCQunrkusSClF9Cpif9eaqYJmsMIsRR5YBWTtMd0DwhOQJZ/SeOXEn0hIEOjTXIMF
         mIr5HfNELgMoei0LxLQb2s6fdeO3Ac95zTG5sS/B+cCyfhRy2cGf102JuGCRG4IIEJS/
         r7TElXdABijgwSue2yN9omlTL8/yvg6WIZfcoE+iftXAOlA3iaPDYHhmHN7YRtHqNi74
         2NdFVyLrkv+kSFji+GrhXIJlboAKjpwka6wuB6g9Hg5KrVWJmBvbMSJWK9Jzcnet0WT9
         AOkal09xVgW8SdkpsuO7N4Lk0ndFD8jI6LeF5bPo5nXG6KMD0Q6N/Ff034pXnN8zubWv
         bh3g==
X-Gm-Message-State: ACrzQf3+7I2kYUmf6cEzF9voxb7+B4+Cu4nDHqIe8nG2OxaXe28x3UZF
        SiLwOT6G7FxoUwof+YUwjDfIldS6FyTKPFMg
X-Google-Smtp-Source: AMsMyM536Wq6mwJWgNCmYSKQ6K6/FQpTIct+wArNFuXHVX6tnocEU/cp22Gqkf1LXSRsAPpcrJHrVQ==
X-Received: by 2002:a17:907:8693:b0:791:a37d:e9ac with SMTP id qa19-20020a170907869300b00791a37de9acmr14361783ejc.7.1666362874825;
        Fri, 21 Oct 2022 07:34:34 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id u20-20020a17090626d400b0078907275a44sm11741502ejc.42.2022.10.21.07.34.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 07:34:34 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id v1so5086835wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:34:33 -0700 (PDT)
X-Received: by 2002:a5d:6488:0:b0:22b:3b0b:5e72 with SMTP id
 o8-20020a5d6488000000b0022b3b0b5e72mr12861240wri.138.1666362873435; Fri, 21
 Oct 2022 07:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221021025801.2898500-1-sean.hong@quanta.corp-partner.google.com>
In-Reply-To: <20221021025801.2898500-1-sean.hong@quanta.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 Oct 2022 07:34:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WUXFO8sM_y-keP+Qvy7qVPrxguTnD1YyL5rmgpK3dVPg@mail.gmail.com>
Message-ID: <CAD=FV=WUXFO8sM_y-keP+Qvy7qVPrxguTnD1YyL5rmgpK3dVPg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add INX N116BGE-EA2 (HW: C2)
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 20, 2022 at 7:58 PM Sean Hong
<sean.hong@quanta.corp-partner.google.com> wrote:
>
> Add support for the INX - N116BGE-EA2 (HW: C2) panel.
>
> Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

For these simple table entries, I don't see any reason to delay before
landing, so pushed to drm-misc-next.

4ab5953f0af7 drm/panel-edp: Add INX N116BGE-EA2 (HW: C2)
