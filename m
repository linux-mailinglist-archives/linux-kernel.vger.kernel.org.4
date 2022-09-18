Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1915BBE88
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 16:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiIRO47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 10:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIRO4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 10:56:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C551F63A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:56:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kr11so13065468ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lE0151MOVJU7BCff5aIrbc8nw/Cj8NqWzyGXKi//Yt8=;
        b=USYlxGY65uQAuLcRBeamKUF9bG441v20ZKIPL2hAdEVlIPvS0tFo9Abb6r9m+W7KPY
         I4vLDqXcrcVEh8/OOaG4sETMKJvjUU2l6QCD3t63li8dSJ3NbdQuRdvBUcQF7B0I9kQY
         X8HZM9/jAeLipPkMKfthiiWz4vuFHeud5AwLfoYMFVpnVqA6kSgDEV8JmzsdD9xOQ/Qb
         EOdH/aFw87UgnOxte2stPq9oMDryGw154uNuL7byDLYgc++hCTzg0uOGutATcr0H0jD4
         Wh9ncQ2uSmunsbZ1+7ADHXfYtUUR/8gnfTvbfwjofyyPnpvHkwbG+TDGDPh4W7KM+2zz
         YQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lE0151MOVJU7BCff5aIrbc8nw/Cj8NqWzyGXKi//Yt8=;
        b=XI/Q9/tF/U8CpXN2N1SA5jHdjUSI3QuD/QKB+OXRdki2h182OXX81C8fHF5dvSAa2q
         0LJCNMohKsW7fTQWeSSeqd38cPJuCYOLiVkwoNz9NOGWaFl/YithswW5wvjzCqyLgjkx
         M0CcOu29X4THftToodyl6caBKvb8hsP92iARRKsMohl6om47vJPnrxJzrQGhIUdL+8rP
         yGis42Are8wCfj/zAelEaV+TcqskKIzVazdfQEc9c9KEU7bw43BwOWW7VCBuRilp/BHU
         NT0zw/rucDIWAi4QU2Dh7FhQINtT/vIchuPGQmdpCY8F7c30u/fSbcVA2m1Iiw63bPeJ
         yThQ==
X-Gm-Message-State: ACrzQf2ACO4xlJpFTN3KQv9jnhKOicGe4NaOocmA+9CVSQVZTonPdrBW
        TtvzNxk9i6Q4CQRaWH2R+QJ3FlVzkNbsOZBvw7yKZg==
X-Google-Smtp-Source: AMsMyM4QKI9Y/vyxhGGs4ZMj48GrTD5Y1x/6XnaQn20imcRKM1PFqF2ix/utSEmG36MElI6MN8K1EJsDNkNb2TK2QxA=
X-Received: by 2002:a17:906:5d04:b0:77f:ca9f:33d1 with SMTP id
 g4-20020a1709065d0400b0077fca9f33d1mr10216154ejt.526.1663513011575; Sun, 18
 Sep 2022 07:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220914071306.3254881-1-s.hauer@pengutronix.de> <20220914071306.3254881-2-s.hauer@pengutronix.de>
In-Reply-To: <20220914071306.3254881-2-s.hauer@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 18 Sep 2022 16:56:39 +0200
Message-ID: <CACRpkdayh4-MxZJfjWdrGJu-ZJ2jgWStLgN3LZrwG41=wZw4RQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: Add gpio latch driver
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 9:13 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> This driver implements a GPIO multiplexer based on latches connected to
> other GPIOs. A set of data GPIOs is connected to the data input of
> multiple latches. The clock input of each latch is driven by another
> set of GPIOs. With two 8-bit latches 10 GPIOs can be multiplexed into
> 16 GPIOs. GPOs might be a better term as in fact the multiplexed pins
> are output only.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

I see Serge has additional comments but apart from that this
looks acceptable to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
You may want to add set_multiple[_cansleep] later, but it
will survive without it.

Yours,
Linus Walleij
