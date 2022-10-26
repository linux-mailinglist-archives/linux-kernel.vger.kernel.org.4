Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B8160DC59
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiJZHlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiJZHlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:41:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B668DBE518
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:41:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k8so16259020wrh.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qX+c/eqfKIRmSzQ2TAxdY0LKUbRjF3m5mcG02oMGx8Q=;
        b=EGnZTiW4mN/u1L+KFftDWxXLRHrI00+AmvAaQQQ1bURMf22zv1OHtlPR/H7SUlo1xJ
         fTLksIEiBVk/vYtUiqhHH+WeQMz81sDDpni+g1os3iml+wBrTaKNtPzeQ2gi9kupiQXT
         iz7ggqhUEm8RugKYJkKqp+ZxE3PnQPjCAKtlF1m1brJaP3z5MqAuxVPc0vPN7sSxpbsg
         anaIGMEx4eOGC7OC8w5Jhy264e2k+OotLo1DqfjJEhvn5EhZWLsI3Kv3iik8lHFDUNrG
         il8K4Mejef+FYzG1mGYubXfdTuAIloBpBQv3eUuIaoVWb4faCOB6LwD+KrRuFx0eGNNO
         vyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qX+c/eqfKIRmSzQ2TAxdY0LKUbRjF3m5mcG02oMGx8Q=;
        b=ugmc74ZmEqV5rJPq7JFZ0rpGM7xuDv5gS/EJ9XP1DAly6i10dcGzCZGH5MnlfFNi2A
         g0KpTXeUn61vGPvJDHplPHpvFJ6fqmsr/a42LqF4D9JiLBs9M6eIkaV4ElK086grdq6c
         w9UMxK1IZBmSAzCMWQ/8Fm8r+F2CFjTH4eKI6tltpWigyJ0BNEi82x0CRctL68y0zLk1
         iM+P4Mq92fzCK09NqkcdkhGLz/rvA9lTdo8rRS0V1gHultPLiZKeoP6ljtmW97wG6EY7
         0oQhFgGY8CrrYCnrlZV77gZPOT80PQOWUKkcRM+I/M6S8Mkb2jMbqcY68IAGLmNkfFCd
         acKQ==
X-Gm-Message-State: ACrzQf05tkdZ59Ovea1nGnierU6j32vs1q4EeSlkzIaxRlDj6Yy0iFbs
        1tHoMfwpHvTy6SNareDZLceG3A==
X-Google-Smtp-Source: AMsMyM5S7b7nFZ2PlRcs8UPcZE5oWqjrYPqMzqX/eLf5/1gT4eLBzzOdYfUXPmu8eE/ZrDy9n/VKEg==
X-Received: by 2002:a5d:46c1:0:b0:236:6a2f:9e53 with SMTP id g1-20020a5d46c1000000b002366a2f9e53mr12098440wrs.256.1666770096085;
        Wed, 26 Oct 2022 00:41:36 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id bd14-20020a05600c1f0e00b003b492753826sm1054980wmb.43.2022.10.26.00.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 00:41:35 -0700 (PDT)
Date:   Wed, 26 Oct 2022 09:41:30 +0200
From:   Corentin LABBE <clabbe@baylibre.com>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        herbert@gondor.apana.org.au
Cc:     ardb@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v10 00/33] crypto: rockchip: permit to pass self-tests
Message-ID: <Y1jkqiYjXT30/hk5@Red>
References: <20220927075511.3147847-1-clabbe@baylibre.com>
 <Y1KctXMZ1+c5uQqd@Red>
 <4780296.31r3eYUQgx@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4780296.31r3eYUQgx@diego>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Oct 21, 2022 at 07:09:53PM +0200, Heiko Stübner a écrit :
> Am Freitag, 21. Oktober 2022, 15:20:53 CEST schrieb Corentin LABBE:
> > Le Tue, Sep 27, 2022 at 07:54:38AM +0000, Corentin Labbe a écrit :
> > > Hello
> > > 
> > > The rockchip crypto driver is broken and do not pass self-tests.
> > > This serie's goal is to permit to become usable and pass self-tests.
> > > 
> > > This whole serie is tested on a rk3328-rock64, rk3288-miqi and
> > > rk3399-khadas-edge-v with selftests (with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y)
> > > 
> > > Regards
> > > 
> > 
> > Hello
> > 
> > Gentle ping since it is a month since this serie was sent and no comment was made (except some reviewed-by).
> > So I think it is ready to be merged, probably thought the crypto tree.
> 
> ideally everything _except_ patches
>  26 +27+28
> would go through the crypto tree.
> 
> So if possible I'd like to pick up those (clock + arm64-dts patches)
> after the crypto people are satisfied with the driver changes.
> 

Hello

I agree with this way.

Herbert any thought ?

Regards
