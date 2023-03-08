Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB186AFB1B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCHA3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCHA3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:29:43 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EC4A2253;
        Tue,  7 Mar 2023 16:29:37 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y11so16120592plg.1;
        Tue, 07 Mar 2023 16:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678235377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=neil0YcjMg5OlZpgLIxN4QQb0hZIOV/hSlbbEvfwcFw=;
        b=O5S1Vcfg3uY4QpCcu7Bp2GrToAHmSBtsVBC0XsCmkclppUzv3Czvwb/cxp3/oF3yAJ
         sTq2vumZPMfNUZA25qjAnkfphtJ8ApfZEbG8JR50UQLnNDwFMNYB+GlhUvr/fvK3cWsh
         D2aVK/uP0FaUYo0POzsZfW6++y92hYyRz9v5cfFMDOY2+LSUut9Zy3HTX6b9DMwtvGKP
         iGz+HpYH1BID6cNO0mH3wdDVGRCBb9jqsyPORcd9V34qO9IhymsSaTK0FRyzc/RXi7IZ
         JzlzW3LYDrQ770ouZkZy9PMv2D6QviuA3HdxYqfMMHq5do9PWpxPdDMM6GYvkI21Bms+
         yOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=neil0YcjMg5OlZpgLIxN4QQb0hZIOV/hSlbbEvfwcFw=;
        b=d+WLH3ZuwKiIersSP2jqtjC9sYfLEJSZIBUD/rSvrri9avGsQ+RbAN37VZsl0eRmkS
         /YtqLmXsE4kC2QgYvkWIFiv79z2GaqZhsm25Cf9wUhkPhEKZtO1zk3EC/i2hnRloLgIm
         1VIcNiaHmh8YPLJzN/w9ov9GP5VGMbcl43HFnsA6GeGMtG+tzA4ByQqFLntCCs9Lhwzb
         eCkPcUHTOAUyit6vrSHerRUn6iNTO0f3AhXTxFf/TYmibu8yNmQSR0P3H+ytr5veB5/F
         5wflsC+e77vKaBaFIiEdDeT5Y2MA4mj5dxRIhdmHO8QVberqpSO6kcOlpvX8SQYm9M5f
         cvkQ==
X-Gm-Message-State: AO0yUKXb4t+A0t4Z2COeLZhRYYGqKxOjeV1qsAu9QZs+4WL++nD8m8cD
        YUw1Tt58eEABVmg21GLycP+gO59KsRg/Xw==
X-Google-Smtp-Source: AK7set8TC6sUXmdHpRsNnZmMrxB0ZJ2/9fbZMOAORQMMKffjtrjfGvxtdRek02q0fbuwZk3Wcpn+uA==
X-Received: by 2002:a17:90b:17c4:b0:234:e0c:caaa with SMTP id me4-20020a17090b17c400b002340e0ccaaamr17074287pjb.6.1678235377098;
        Tue, 07 Mar 2023 16:29:37 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id k20-20020a63d854000000b004fbb4a55b64sm8311779pgj.86.2023.03.07.16.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:29:36 -0800 (PST)
Date:   Wed, 8 Mar 2023 08:29:28 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add Novatek NT36523
 bindings
Message-ID: <ZAfW6AbFLkKwxZZA@Gentoo>
References: <20230220121258.10727-1-lujianhua000@gmail.com>
 <CACRpkdZ=6bU2gPv4zVzMBFaCgEY+fkRbrnLAB6NGOhWus1gwaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZ=6bU2gPv4zVzMBFaCgEY+fkRbrnLAB6NGOhWus1gwaA@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 11:22:35PM +0100, Linus Walleij wrote:
> On Mon, Feb 20, 2023 at 1:13 PM Jianhua Lu <lujianhua000@gmail.com> wrote:
> 
> > Novatek NT36523 is a display driver IC used to drive DSI panels.
> >
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> > Changes in v2:
> >   - Drop unnecessary description
> >   - dsi0 -> dsi
> >   - Correct indentation
> 
> I'd like Konrad and Neil to look at this before we merge it.
> 
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vddio-supply
> > +  - vddpos-supply
> > +  - vddneg-supply
> 
> It appears vddpos and vddneg are not necessary on
> all variants, can they be made non-required?
It can be non-required, this panel's positive regulator and negative
regulator are supplied by backlight IC, the both regulator of Konrad's
NT36523W panel are supplied by secure firmware layer.
> 
> It is also possible to do some - if -construction of course
> based on the compatible, if we want to be fancy.
> 
> Yours,
> Linus Walleij
