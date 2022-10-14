Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CC55FF332
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiJNRyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJNRyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:54:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7726464;
        Fri, 14 Oct 2022 10:54:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so5392976pjo.4;
        Fri, 14 Oct 2022 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=avPRhaqVHvgZmZ8GBsQ+20zIBPkvVr2QT+2++f0G4/A=;
        b=kZhR7KCRXJWnF12BPar5TJ6Jp7jOQu5oh+cHmvhzLyF05zeCaifFNhGK2RV9jJxsw7
         VimZgYTfdukHBQwvv7OanK1IwigLv/d+xhi0TP3zAwnVA6N9Pky4WjZPRXan0Z3MsufV
         QghtZKG+k2mOjGl0Vg0S/t1x77BZevIUhmuxGLeSWD54IdegSklXCjVAKnkT2Oo/lxWy
         2oWrH07lFCfFz6RCEuX6Jkpdeh2zLOt+eRMKV+TxgFflN6h9xcTnhT+iZgpDyxPmGITV
         pgq28asdkYqtuLzYBAHXMMVsZ9e6VVSZGlgtf3K/gA4Or5CvN8E9zKThvuSlj1BcZEgG
         QOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avPRhaqVHvgZmZ8GBsQ+20zIBPkvVr2QT+2++f0G4/A=;
        b=tlXApg3FsPBKm8p7ItkyTwX2T1vF4R7JWZTtPpOnZMYcqpvjKT6H8fZT8mYCgvijAP
         VReRDyBZzgC/xeYF+TBhlpDFSCAoBT9NAvOfWnGvgCkV39uaCs3HpbzB9DYNmNDkIWEe
         n0UXr+m3NtfyyTRPKDKXyCxVqV3+o+mBaOkuLz5TEFatx42nPhDXI+n/Px0zsAZRB/dr
         wBP1u7roBeZe9qpzBk5yK/lxNIPd60LJEoWUIc5wpJi5u5aQxQB2Fvnc02H/X0zjf8YH
         w9yNukL+eXqhTfjsudPnwph7J5MgOSFMGDZMdfrnnflz0MI4I3KSn1DzCjKiIv4bU+Zu
         wdYA==
X-Gm-Message-State: ACrzQf3ksjGajVS6qt2Ro1NqH3CSqkI/xdUQRj3H7ppd9eKkC2GQmCnY
        CNagtJhDVgiKL7ny8k2uJRI=
X-Google-Smtp-Source: AMsMyM5Hzc4Cp+r46/Ag2/jYccuv+/04FsvP087ujnP8b9BZmiBEMZsSts2Cbd5GXI0ayAon/amZ9w==
X-Received: by 2002:a17:90b:3c8f:b0:20d:959b:26f4 with SMTP id pv15-20020a17090b3c8f00b0020d959b26f4mr7161668pjb.104.1665770077786;
        Fri, 14 Oct 2022 10:54:37 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:da06:5604:594f:f6af])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b0017f7819732dsm2011780plb.77.2022.10.14.10.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:54:37 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org
Subject: [PATCH v2 0/9] gpiolib: more quirks to handle legacy names
Date:   Fri, 14 Oct 2022 10:54:24 -0700
Message-Id: <20221011-gpiolib-quirks-v2-0-73cb7176fd94@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-5166b
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to converting several drivers to gpiod API, and to keep=0D
existing DTS working, this series adds additional quirks to locate=0D
gpio lines with legacy names.=0D
=0D
Additionally the quirk handling has been reworked (once again) to pull=0D
all simple renames (ones that do not involve change of indices or other=0D
complex manipulations) into a single quirk with a table containing=0D
transformations. This should make adding new quirks easier.=0D
When using legacy names gpiolib will emit a message to nudge users to=0D
update DTSes (when possible).=0D
=0D
Note that the last patch requires the following change from the OF tree:=0D
=0D
        88269151be67 ("of: base: make of_device_compatible_match() accept c=
onst device node")=0D
=0D
The change is also available in mainline - it has been merged in 6.1=0D
merge window.=0D
=0D
Thanks.=0D
=0D
To: Linus Walleij <linus.walleij@linaro.org>=0D
To: Bartosz Golaszewski <brgl@bgdev.pl>=0D
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=0D
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>=0D
Cc: Daniel Thompson <daniel.thompson@linaro.org>=0D
Cc: linux-gpio@vger.kernel.org=0D
Cc: linux-kernel@vger.kernel.org=0D
Cc: linux-arm-kernel@lists.infradead.org=0D
Cc: linux-mediatek@lists.infradead.org=0D
=0D
---=0D
Changes in v2:=0D
- fixed 'fsl,imx8mq-fec' & 'fsl,imx8qm-fec' compatibles issue noticed=0D
  by Alexander Stein=0D
- implemented Daniel Thompson's suggestion on tightening configs=0D
  selecting renaming quirks and added a comment to discourage adding=0D
  rename quirks without checks for specific compatible(s) =0D
- added a polarity quirk for Himax LCDs=0D
- collected reviewed-by tags=0D
- Link to v1: https://lore.kernel.org/r/20221011-gpiolib-quirks-v1-0-e01d9d=
3e7b29@gmail.com=0D
=0D
---=0D
Dmitry Torokhov (9):=0D
      gpiolib: of: add a quirk for legacy names in Mediatek mt2701-cs42448=
=0D
      gpiolib: of: consolidate simple renames into a single quirk=0D
      gpiolib: of: tighten selection of gpio renaming quirks=0D
      gpiolib: of: add quirk for locating reset lines with legacy bindings=
=0D
      gpiolib: of: add a quirk for reset line for Marvell NFC controller=0D
      gpiolib: of: add a quirk for reset line for Cirrus CS42L56 codec=0D
      gpiolib: of: factor out code overriding gpio line polarity=0D
      gpiolib: of: add quirk for phy reset polarity for Freescale Ethernet=
=0D
      gpiolib: of: add a quirk for reset line polarity for Himax LCDs=0D
=0D
 drivers/gpio/gpiolib-of.c | 344 ++++++++++++++++++++++++++++++------------=
----=0D
 1 file changed, 222 insertions(+), 122 deletions(-)=0D
---=0D
base-commit: cd9fd78f5c11b5e165d9317ef11e613f4aef4dd1=0D
change-id: 20221011-gpiolib-quirks-d452ed31d24e=0D
=0D
Best regards,=0D
Dmitry=0D
=0D
