Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01A25B9665
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiIOIcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiIOIcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:32:02 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9B68E9A0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:31:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b35so25873030edf.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BIGBGBntdDKXqz/EQ3wuUT7hkmXxVvDzgAVe4vykiSY=;
        b=yB81I5DoaRjvmvKPiQmh0m/cBng4BWgK5Qla/cakP8oIj9kCayNAXgW0wTwyfKwZxd
         ewdJAB1k9Zcx9DAbbO2t3tP420rxDp6GbvckBuv27CUc4OjH0jOqJvFEWB3mayhSt9T0
         bEAoGe3+/d/m3U1b1l5zNimmLef/g9rMRbSbXf4gzitGncExS7H0nCbTTyXIGuuo3Osi
         9ns0Mpq6yzQjciWf/wCUroLk88RJhED0OczgJMos2+oy837zxBkWXIbAn2GVz3HWT3kH
         z5XpwDh/2yRk7Sinp/NzhoHSs2zx7dMn2c+veJuo41nzBL6aPdhT6VGA5qVppCM2cgZg
         W1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BIGBGBntdDKXqz/EQ3wuUT7hkmXxVvDzgAVe4vykiSY=;
        b=CN2oQ2kq0nT5Uc/x1uZHfij40z3ImMRuRYCMHp27pbTBLsktkBEZ60hy0d/5dPlM9a
         S3pyK+3aapyTBTK0MbQPMV/NNKx1KhzzqZHVx/MBeXfjkXT3lk/TBf0Zxo6/Eyk8k7Ex
         j2XmUO6ai7NdYcfNGCKTySADD9kz1Hd98K65880StRd19Wr93MxHe2kHtvZ77hsiOVZw
         hfivrYqYQwkKvUkA2gsvhWOXsOwTt3kIATnSU2VzgR/7nNU0+l3rQF2xzD01Ru4GwTzX
         NVaiYFBHnk3lEDmGVHis1xpcl1lZju9Q8ucBDSNFM+bLZDsnrG6f+N9oGEJ5VERhoo/v
         Al8A==
X-Gm-Message-State: ACrzQf3mX1yS/tzV3T7LY3k3Nof14Nca+MdbATpVPQ7iGmnLhNadN7YL
        i+GVIO9RclOYEiEMzTyQa/7hEVhaPxkt0kcIb4Ct6w==
X-Google-Smtp-Source: AMsMyM6IUmfXjYAHjh+YBY278q1u5kbWH0c6BrprUo1crA8ni+iao3OLyM8Rkyz4KRI7AQpfdN4PLTbrCl0YiHvnpJI=
X-Received: by 2002:a05:6402:190f:b0:452:d6ba:a150 with SMTP id
 e15-20020a056402190f00b00452d6baa150mr4945425edz.126.1663230717413; Thu, 15
 Sep 2022 01:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220914151558.536226-1-martyn.welch@collabora.co.uk> <20220914151558.536226-5-martyn.welch@collabora.co.uk>
In-Reply-To: <20220914151558.536226-5-martyn.welch@collabora.co.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Sep 2022 10:31:46 +0200
Message-ID: <CACRpkdZBTfnRaFRLDb_OW5oGbtdC2=3VnrM1EL=_SmPVHBX-eQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] gpio: pca953x: Add support for PCAL6534
To:     Martyn Welch <martyn.welch@collabora.co.uk>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Martyn Welch <martyn.welch@collabora.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 5:16 PM Martyn Welch
<martyn.welch@collabora.co.uk> wrote:

> From: Martyn Welch <martyn.welch@collabora.com>
>
> Add support for the NXP PCAL6534. This device is broadly a 34-bit version
> of the PCAL6524. However, whilst the registers are broadly what you'd
> expect for a 34-bit version of the PCAL6524, the spacing of the registers
> has been compacted. This has the unfortunate effect of breaking the bit
> shift based mechanism that is employed to work out register locations used
> by the other chips supported by this driver. To accommodate ths, callback
> functions have been added to allow alterate implementations of
> pca953x_recalc_addr() and pca953x_check_register() for the PCAL6534.
>
> Datasheet: https://www.nxp.com/docs/en/data-sheet/PCAL6534.pdf
> Datasheet: https://www.diodes.com/assets/Datasheets/PI4IOE5V6534Q.pdf
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
