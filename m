Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D704F5BAC3A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiIPLVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiIPLVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:21:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868ED696C3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 04:21:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 29so31011201edv.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 04:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=RgCXg7P8jBlNpXO+s0GPRQNH2EVrlEq1LpukRwXMUko=;
        b=atWUUEik4z9bhmC1h78AbFQ55NJPqAw2voNK8KDH4BEEkZdbpA3bFPPP8xsns4wzp/
         iSxdubaASpEi+i8WrQSi2UKMVCyRfi2reAYXG+zOCg3PKbujp2xJ4PF1SGqowpMobLBO
         Xz4qZD6hed+ad03eNZXeRg6UKRKDIGoTTccqADHYotDb3s2Aqrzud5dY/jzywWFplon0
         QslcoSM671XgA3670hcgxj0fkBnE3SPamuLYBcPy8koudtyyDSm9OI2PzLMQ+i+D9t8l
         73B0JONff9frEDdzKUi6CIoCql89lZ2aEULiubV5Yn7WCV72PhzWIrfZp9+X0JTnvA4f
         LsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RgCXg7P8jBlNpXO+s0GPRQNH2EVrlEq1LpukRwXMUko=;
        b=ZD7CINVBDxWIzI2pw5Z2wuoxzJqUZPB8G3ttBy5k7rYYtDswrHkEuUrferXO6gu8Fm
         fXtu4g41+rbHNnyip0cNSy5MDZvfA6pvFEBuAf1oVcMj3WiUvVj/oPCrBPYRPdSx7YP5
         9A2juOEWNt+4+BbUzOhrSedt+YsWEAR4fXOp8Q4wFaDv5hMQEM+UP2maVtbLEyTxhUHq
         CXGPtbzG3nODueclowNWYTJ2OREJCRRGmKXgH5EszRTQ46l1UjmZgHIrR7u0XHczMRU0
         9/YbxhMCTlikXHihbX/9GVm8Ouzx0qO/QZhECFQcBJnEAdG735W3QK4iif5MRGQNNkfe
         om3Q==
X-Gm-Message-State: ACrzQf2qFq9issjuJjfDUDSMK64ObHA6BgmuzEUx7GDgdMkTsDER4juJ
        mIqs0snUfrEgjtEiQ3yk6ctt6Sj1T9j5lEWfMsLysw==
X-Google-Smtp-Source: AMsMyM6t4xw4Uh4YTEDXooGmNCr7jnFr2oYyXI2aTS6QP5rJUHNFJEgFW+zGS1241tR6qxoOylqZZiaJWQaI0gjPc/k=
X-Received: by 2002:aa7:c050:0:b0:453:4427:a947 with SMTP id
 k16-20020aa7c050000000b004534427a947mr2600202edo.172.1663327264143; Fri, 16
 Sep 2022 04:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220908053949.3564796-1-dmitry.torokhov@gmail.com>
 <20220908053949.3564796-3-dmitry.torokhov@gmail.com> <9056cbec-a411-5f87-a4c1-2f77bb2e3a33@microchip.com>
In-Reply-To: <9056cbec-a411-5f87-a4c1-2f77bb2e3a33@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Sep 2022 13:20:53 +0200
Message-ID: <CACRpkdYH5FdB2+=Jrh4fvPXoz6tU2CyJF=i7cyC1ipS7T3TpqA@mail.gmail.com>
Subject: Re: [PATCH 3/4] gpiolib: rework quirk handling in of_find_gpio()
To:     Conor.Dooley@microchip.com
Cc:     dmitry.torokhov@gmail.com, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 1:04 PM <Conor.Dooley@microchip.com> wrote:
>
> On 08/09/2022 06:39, Dmitry Torokhov wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > Instead of having a string of "if" statements let's put all quirks into
> > an array and iterate over them.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Hey,
> This seems to have landed in -next today as a2b5e207cade which has
> unfortunately broken boot for me:

Michael Walle has sent a patch fixing it:
https://lore.kernel.org/linux-gpio/20220916110118.446132-1-michael@walle.cc/

Yours,
Linus Walleij
