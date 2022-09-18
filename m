Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A315BBE82
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 16:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiIROkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 10:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiIROkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 10:40:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910592252F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:40:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y8so30894608edc.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WJeTo/YoIqzGxBFJQlGTAeJS2JaDh5aCUVTVnuwF7YM=;
        b=Z/2KbxcMC57BZRevUCvexaoh4RLqSuY7+hZthoy4SnlD+bZFq6GBoRcZ/fWJIoMQtf
         +Ju45vTDpB8TYm7gm3nMbR37EYcD9lus81WKL4zNrw8xo9dh1NewU7aVBDn6k8zXBHYo
         DjMwm3ouqFsn0T+JuZy3EWLBcnLELIF57WDi4ux5UfdoiuEZY1VTSj7qab8LH5p3goXg
         WVwQbn1VZpvv8LH6SPccyFutWl1Will7xgwI9Raua6SGkEFdHlwxmCNKMPGWabWkUnSe
         rUnFMnj5BfuL4hYsX72gw4AybGTd6sH/OKcR3pRQxDYcXx2dc6yhrnOqlQa5HQWh5zbL
         1dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WJeTo/YoIqzGxBFJQlGTAeJS2JaDh5aCUVTVnuwF7YM=;
        b=AJGFVL1kxN7o4p2mJPld9VQAhkNgljzNJvkPaD9egs6f9vlrJJNaWiEb36eTgOecWF
         /Xpcabdjpjm0A7gsKCsLiE5Io+xuVl4Uu5fwhbSVH8+x+ZNmlO7TKNNo2IC66XSdmQiC
         uiR2TnXmYweN6NRzEX4vjU2iomdpV+EfJV3hkfi9gxPJeejnVgWJrW89epmp/XXgU8RY
         Bjig581F8X0HE1T3be63SwzWiZ6OHzh5WN6AvXbuMT3Pz5eMar/eHOz9ZZ/1nvQ3ALEx
         /GIPje0CMwkz0m+idfncnxGLMFSPwhonlG5gxidQrQ7O+YWlXQhzzN8qvJ04ymoguszX
         2feg==
X-Gm-Message-State: ACrzQf12ado0kB5jvNV2+hY8vh5CnD4jv6jGW26fymYJkh0uiOVLbits
        owJjL5fcwus3ALhywgLNTXrbZn7GYlrHWLH307mSog==
X-Google-Smtp-Source: AMsMyM7hDs2F6N0cDYpOC844+/sfzkePCFn2OXMPH0gr5/awqAUxuGJMsI5iGClyBfJv6MxsPUtAbJSMah2R7urb35U=
X-Received: by 2002:aa7:d994:0:b0:451:e570:8a7d with SMTP id
 u20-20020aa7d994000000b00451e5708a7dmr11832915eds.205.1663512014151; Sun, 18
 Sep 2022 07:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220914141428.2201784-1-dmitry.torokhov@gmail.com> <20220914141428.2201784-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20220914141428.2201784-2-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 18 Sep 2022 16:40:03 +0200
Message-ID: <CACRpkdad4CVo6xuesaN-rgrq+Tb+MUdAyyeP13V-b-e6FUMvzA@mail.gmail.com>
Subject: Re: [PATCH 2/5] Input: auo-pixcir-ts - switch to using gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 4:14 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This switches the driver to gpiod API and drops uses of of_get_gpio() API.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
