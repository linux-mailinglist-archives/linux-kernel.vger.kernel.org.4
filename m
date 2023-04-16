Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D346E3BFD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 22:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDPUye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 16:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDPUyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 16:54:32 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD12B2133;
        Sun, 16 Apr 2023 13:54:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50677365fd1so2198611a12.0;
        Sun, 16 Apr 2023 13:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1681678469; x=1684270469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbqqVNzGOI+hATtCpzlQ1GOtPA5LF8eMW+rUvuU9Sis=;
        b=TY2up1IYzC8pjZvMdhx8eGtZx/BaBmT6yhycBCle914vb88iVlSIX31toGZszNqfBv
         DMzb8mC/rJX2a13NTyle/+iZulh5ackAEtZ9yLFKnkxgOxIZ74okVbBqVMKqttLOvDur
         XlkAwWbN2It3I8a5YrWmi3wjCGgz5QOvV6KbhHH9lhyykINsDiMI62OlCT3lhkQlyTWE
         wZYF6WBs9Yr/rb/b3oalu9sGQ3zjKSBYhi4hUQLwco10DvQTSznmTjVI/bURYb6+dxJy
         dqGjy93kRj9LaWw4ZHMiaSQciPOsm8z8yP1v3BSM8Rr3RdOiq3okVzoygrqRogv+XFy1
         mhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681678469; x=1684270469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbqqVNzGOI+hATtCpzlQ1GOtPA5LF8eMW+rUvuU9Sis=;
        b=FqKAmQn4j9WKfRFkQxqgOunroddaXD1RvY/Tzs3IbxtQTqtiHpnV1hUCbtoFcA4+F3
         60DXGBfaoHQ8ptwerWlV1/3rbfG83DHz7ZZdiSkZJ7EHjvMu2EuHJI8/1ffhyv4wusWT
         zqxnTo4j6MoQj2OcCTok6k5G8o19WG2/tmfVXLqHDxIzW0xpqjLx01c1lQcoqIZM85kr
         9jmg19rOfKEac/qsvfukc/f0TvhtvU8DXZ8QTvVib4QRs6KJEKvf0v8KIkAkTMc69NLD
         IWOqNt0Ju/jpdeyuGvrBCjcmPPXGOplaok4zja1BCnAQ8HaXq13MGLAO9YbjJsIgoYlT
         ZfNQ==
X-Gm-Message-State: AAQBX9fZ7/QINSSYjg6oOmw/E2Zy3yKDU7TRVrjH+RutJmbeDwFEPUy+
        rKgzkQYb6sYBUo/ScZvLBkfNIr195uR7wPPBLWrYXjZ1ZVo=
X-Google-Smtp-Source: AKy350a9ZFr+WU3lXgqd6D7Ofo/EcQzK8HMKPpoXrZ6yJzickE0bYDDssYGK2YB94LQPzTqzkAKIWukx+kidRq69yb0=
X-Received: by 2002:aa7:c414:0:b0:506:7d3e:ade1 with SMTP id
 j20-20020aa7c414000000b005067d3eade1mr9269439edq.27.1681678469135; Sun, 16
 Apr 2023 13:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230414152423.19842-1-ddrokosov@sberdevices.ru> <20230414152423.19842-2-ddrokosov@sberdevices.ru>
In-Reply-To: <20230414152423.19842-2-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 16 Apr 2023 22:54:17 +0200
Message-ID: <CAFBinCCEhobbyKHuKDWzTYCQWgNT1-e8=7hMhq1mvT6CuEOjGw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] phy: amlogic: during USB PHY clkin obtaining,
 enable it
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        mturquette@baylibre.com, vkoul@kernel.org, kishon@kernel.org,
        hminas@synopsys.com, Thinh.Nguyen@synopsys.com,
        yue.wang@amlogic.com, hanjie.lin@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Fri, Apr 14, 2023 at 5:24=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
[...]
> -       priv->clk =3D devm_clk_get(dev, "xtal");
> +       priv->clk =3D devm_clk_get_enabled(dev, "xtal");
Generally this works fine but I wouldn't recommend this approach if:
- there's some required wait time after the clock has been enabled
(see phy_meson_g12a_usb2_init - there's already some required wait
time after triggering the reset)
- clock gating (for power saving) is needed when the dwc3 driver is
unloaded by the PHY driver is not

In this case: just manually manage the clock in phy_meson_g12a_usb2_{init,e=
xit}


Best regards,
Martin
