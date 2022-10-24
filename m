Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE3609AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJXGi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiJXGiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:38:20 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CF5537D9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 23:38:17 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id m6so5577855qkm.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 23:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lxnav.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fsOiC+x4jbQg2AI82o1c6FVgGRvae5LgQbo//KCgMPA=;
        b=uGVMATcxl8aJCmPrvkTHCO+PicBfylpepuzLv/A+igtmUM1uWPkck9WS0qESv7wmRS
         aEAsLNQWybz0J83BiTnJZIz8pIZO+ygaWPLdZBMzgetXXsg+Idp6ZLzFH2z38My+eGz4
         wp1rT6DvRqVC5G3K+ZRtVrJ6DeBemIiiOv0oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsOiC+x4jbQg2AI82o1c6FVgGRvae5LgQbo//KCgMPA=;
        b=gjdMUNaolkRVsJYfF7mGO96ni7wV+di4zPfQLxRzhDwyNuDwpjabaAgUFgpyporQpD
         JikrOF0ArGfMUfoS3sVsYdCg6O9i9afIlZ9qpt/bMdUztjbEWD16Z3fZyKAyVlenn89o
         0L/+zPXqFYKXYFHH89u6t9Auc26aD/cGF9/UoHwqkkeNggHTqpnih/2fGZ3pZv0pTsFK
         NwpDwrR6vEWKCmQLxA76lwKpBYO33kAjFYpph5rJqjk87OLa6Ze9GYRMr4/oNAEmWnx7
         1a0tL+cwUkYzTI5Ya31aXQrXF5qQBhjXUrCUHLn5OMULlXaq329fvkLqB23lJCa/xYAv
         zn+A==
X-Gm-Message-State: ACrzQf0pmaj/CcXuzPuYFQn7ipqZ3Vo02CUmmi9+7JMsEyM4FmKgu/Sr
        gex4xyxgjcojadRQADNNOVIb26/JBsWDno/VgV9TpQ==
X-Google-Smtp-Source: AMsMyM5tSVrVszLR+lwo8P+ienZPZ7fnw3WFxIUDrOYZvDhfuAt4jx21oRq7AoW9iVOPfVEw/pXeVAl4MffKsZoQFMo=
X-Received: by 2002:a37:de03:0:b0:6ee:88a2:eb9a with SMTP id
 h3-20020a37de03000000b006ee88a2eb9amr21831942qkj.241.1666593496783; Sun, 23
 Oct 2022 23:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221021135827.1444793-1-mitja@lxnav.com> <20221021135827.1444793-2-mitja@lxnav.com>
 <20221023120634.0dda4b5f@jic23-huawei>
In-Reply-To: <20221023120634.0dda4b5f@jic23-huawei>
From:   =?UTF-8?Q?Mitja_=C5=A0pes?= <mitja@lxnav.com>
Date:   Mon, 24 Oct 2022 08:37:49 +0200
Message-ID: <CACbQKWeA7QDn3tDdP4oNQ9cHyubNCDvCphOLndDDf-gBXpkcDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: pressure: ms5611: fixed value compensation bug
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
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

On Sun, Oct 23, 2022 at 1:06 PM Jonathan Cameron <jic23@kernel.org> wrote:
> Fixes tag?

I believe this should be:
Fixes: 9690d81a02dc ("iio: pressure: ms5611: add support for MS5607
temperature and pressure sensor")

Kind regards,
Mitja
