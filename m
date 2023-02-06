Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D195068BB08
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBFLMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBFLMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:12:30 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B4A1E1C9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:12:30 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id a1so13937824ybj.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b5uYJuiofgMdiSpu26KojixH0Uwt9bY3hD6Ug5k0ArQ=;
        b=pWYu8zz/JHVVRUaeiFHbrDmMReLewbnXnwZdDEno4rkrQuq2nIkb3UfuaYlK7cY3JW
         /pId+enbTumilssENS2yxJJPEqVgkx32YCbSyAMJrBv2if0vc3aIa/XbrCJVwjEs4hLO
         IECJXCrC705VtffNcZ8Pj+ywu36ruSctu7KMBx+FDTY0svzkakj4VOskLGhyyAc6daGM
         lxOvKa2m49MkLD5JCdvDL93eTFaqRfhtvx0v31aWW26BgFTlQQzbSwds3aG7XhbFUafZ
         7oAMRJxkjzBuf0P9DkFiq7RdlO/vAYShTj9Pwe6arwy1irCciUmFojcI3OA8x41k8P1Z
         Ye1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5uYJuiofgMdiSpu26KojixH0Uwt9bY3hD6Ug5k0ArQ=;
        b=xdc3xx/+5Z7NgsHHWaj6sMoV3b2e00kdXJ3FRfKmX7mU6dIp/LyPaYUPGLzMPHWbPV
         yjIaP6k/kpysKYb2LfArCqEHz8nOOaFsi2i3WWG44dCMxycnA6O0DYvrb9H7tfsICTea
         AtsvkeVahBOWmyxdn3ZH9TFFBmooZbB0kIyRpzxxbjb9pikuSkC+7yp6gZVrYeut9/5U
         fHcO8xlSWpi7VGPWusbweygPZhejCNekrC0otGyTsXB9jAguOsby8fD9Gu1kdebaDHQ3
         YWyMpFEF8FQvcndfs5qA89aasr54M2vqeJWzuvoiuIXRVlRP51gggI03X8OK2uEN8EJ1
         RZ+g==
X-Gm-Message-State: AO0yUKXtHzNyEWaQn5qXqeuFv0por8U94DN2ZRyInoSRayCwhpd/g0I2
        lzFXtGMPqVDfe5IGYjrgTEJlHyFLrTdM9tq6Z8HumA==
X-Google-Smtp-Source: AK7set/2hz0lVMK+U+w1vtnbkMfVhn5UwbGftM4+jxwW38T4T6bRA0mgFTT0Y9YcJfI0ey5mMQYMrZ8uo2MXhPdqQNM=
X-Received: by 2002:a25:5bd6:0:b0:80b:66c5:9fc5 with SMTP id
 p205-20020a255bd6000000b0080b66c59fc5mr2147989ybb.210.1675681949264; Mon, 06
 Feb 2023 03:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20230203132714.1931596-1-claudiu.beznea@microchip.com>
In-Reply-To: <20230203132714.1931596-1-claudiu.beznea@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Feb 2023 12:12:17 +0100
Message-ID: <CACRpkdYX7_rVTp5o8diBSx0JB4iFGjqyzxsqb7etW67SWD=ZRQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: at91: use devm_kasprintf() to avoid potential leaks
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
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

On Fri, Feb 3, 2023 at 2:29 PM Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:

> Use devm_kasprintf() instead of kasprintf() to avoid any potential
> leaks. At the moment drivers have no remove functionality thus
> there is no need for fixes tag.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Patch applied!

Yours,
Linus Walleij
