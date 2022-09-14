Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0962D5B889B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiINMus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiINMuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:50:44 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14E677554
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:50:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z13so8099677edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=K6WJMwP9TbXezrcFsb+pta0EfIwLar+TBDNhiWZanb0=;
        b=D8ZN2cUS/7eafu5ZwZde+hRVJf2S46PebOPPENpiKd9lNrz5CJi53nP6CIrrJe/Hd1
         z44RBizqYQcRgt26Q52haOYkE0fbeXXI7mgKb7nW6EMibuIjz19GVLkPJg3qt4FymWBc
         cYPaGZzF2XEltkWIXtWntX4s8a2loBTKXdLf6+yAwihMjp2eyKUEVnRgEvLoFWBL6Sgs
         KhnIhHfyj9AvGV79m0dwN3YfwqArL/8xZNw53is2t7SAkanxWiEMOYfoLpxH2OVIr2/f
         8DAYix1pJKP4Ne6/hWj1fvKJ8I3pqaLhynXwZAvd03x/hBT7KJfJkk3Um2a7iUD4cdwl
         HTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=K6WJMwP9TbXezrcFsb+pta0EfIwLar+TBDNhiWZanb0=;
        b=BiGgEi09SmW9+RuG9G0tj7BnuZ7GtGvG85kVMiVhbAhUe8XtFwFG/oqzivJp+a3b+T
         MnRY/m1Ug0h0vu0eLInsxRZ9qu8yROr52CHt6SKNix3aqb5KK5pjs+d4Z+dg9Y/VYXSd
         SNpAdr4ZS/tye8m+pn0yoyxrzAlcazBrcVR2XG8K5s7nZ9eP7exTyE85DbIlqPFiTi3p
         EhmzlIP0cMMcfk0C+PRKozEBIfHAoxx59KQ1KqOUgq0xx9YSi2JASCPwTGqyeKaRwqSn
         ihXRTmm+7os+/2MSaoYldG1ZYDOwIAout25INGLZ5nwfwT/vLlbXnc+S4Yr6v2hDMyVu
         N97w==
X-Gm-Message-State: ACgBeo32bd8gOy4RPxBaa92qVJCRAyBx9T/nvxe4yV1Bb3PF9/aYdFee
        5qz7+wHdxYX2ZkscK+kDTRWROvkhDGrcUMavUvcYBBCbZJs=
X-Google-Smtp-Source: AA6agR7CrjEwUrw/bpSgwa14FRhj8mPEGhjvzZqS0Va8peBJXwqwiOmDTX7y5weL2eTF479yravfqaB236V/5zGvriQ=
X-Received: by 2002:a05:6402:4517:b0:443:7fe1:2d60 with SMTP id
 ez23-20020a056402451700b004437fe12d60mr30408220edb.133.1663159842597; Wed, 14
 Sep 2022 05:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220913071659.94677-1-wupeng58@huawei.com>
In-Reply-To: <20220913071659.94677-1-wupeng58@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Sep 2022 14:50:31 +0200
Message-ID: <CACRpkdY+PPu3iqhjjT6R+dOMB9M6=j0jdmzu6Uhp6Mhsov5wvQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: htc-i2cpld: Fix an IS_ERR() vs NULL bug in htcpld_core_probe
To:     Peng Wu <wupeng58@huawei.com>
Cc:     lee@kernel.org, linux-kernel@vger.kernel.org, liwei391@huawei.com
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

On Tue, Sep 13, 2022 at 9:19 AM Peng Wu <wupeng58@huawei.com> wrote:

> The gpiochip_request_own_desc() function returns error pointers on error,
> it doesn't return NULL.
>
> Fixes: 0ef5164a81fbf ("mfd/omap1: htc-i2cpld: Convert to a pure GPIO driver")
> Signed-off-by: Peng Wu <wupeng58@huawei.com>

Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
