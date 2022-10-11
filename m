Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2849A5FBDC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJKWTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJKWTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:19:41 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14354630A;
        Tue, 11 Oct 2022 15:19:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i3so14775639pfk.9;
        Tue, 11 Oct 2022 15:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LU58/FgjDPCb4/HIjKdV8bVA1BTPcHJFbY4JeAoNkso=;
        b=Dda1Fo3vZibxh0267Q/K8n/G26/3vL5nhVEgDWa9oYWXyuyC4vlceQEYklqjoiFI4m
         gslkJAQ7VUfiP6NWf9UdkGkWRRYyRU7Nn+Id5vDYUsqCGLm0SPQxfU1EV+iIPUyq2mWp
         wpsKsVXsWeV9Fg7fGNPWKn2HU/71UeeHZfP3K5CcPvMWx+ccJy2pCEfgszE9AnjWaJAG
         6Ag1CSNBmbwAJK04xIhZlgh6wP6oPLOunmRxgiKCunebfNahGFzRi7iG5VmtPrBRCDER
         MQHZF6v8IpvLGcQdEbNPhM6hIYjSRqq1h4JXSURjSJKnSDh5RHGiD/CqtT9IPFTB8F4D
         h+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LU58/FgjDPCb4/HIjKdV8bVA1BTPcHJFbY4JeAoNkso=;
        b=07CUszVVAMVEGkHacdRlHJ6lRhjtbu7hWI0giaPEv7qol026EJLNFJ8PVj6snVrruC
         7KpTFBXEWoMF5YVK5r4+odUHEWqrv9SLuMMu9Dy8r5tfo/Fj5KNZXaV3OW9HFH8hMc8b
         sfDvFrruklQgJ9ZZ6Jr8wUswcYiBjKX2WITWXv0ATUDpcLVAqU0KvphWuwKEWhED2X17
         icBqZJFq223NDwz6+j0BOXDdarEaec7YW6fou9XfDrJp10gW83DHKkT7nWU5Wg3K8Na+
         +nENwXQdIRMxbpYGX9m/glM3jxWv/O5OrTQ3Tvmv0IFtxoDmu8kIbhEkB9HFXD7kckOp
         J9kQ==
X-Gm-Message-State: ACrzQf1WT31i6bc3HLkDMT9BtkP0y909DMZ72MU+RTe34s7McOC7IZ5P
        faQXmF5knYsMoocOmWFVGBA=
X-Google-Smtp-Source: AMsMyM60TYBBYpvAQZQVq5swUJ8AxjHR56drU7Zo5/27UWyvFpAAvSntAJdq/H+P2tFIcHRfyOgvxA==
X-Received: by 2002:a63:814a:0:b0:460:9253:bf8e with SMTP id t71-20020a63814a000000b004609253bf8emr15238664pgd.469.1665526779242;
        Tue, 11 Oct 2022 15:19:39 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:becc:db10:eb45:dc35])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090ab70600b0020d39ffe987sm60151pjr.50.2022.10.11.15.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 15:19:38 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH 0/7] gpiolib: more quirks to handle legacy names
Date:   Tue, 11 Oct 2022 15:19:28 -0700
Message-Id: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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
Cc: Daniel Thompson <daniel.thompson@linaro.org>=0D
Cc: linux-gpio@vger.kernel.org=0D
Cc: linux-kernel@vger.kernel.org=0D
Cc: linux-arm-kernel@lists.infradead.org=0D
Cc: linux-mediatek@lists.infradead.org=0D
=0D
---=0D
Dmitry Torokhov (7):=0D
      gpiolib: of: add a quirk for legacy names in Mediatek mt2701-cs42448=
=0D
      gpiolib: of: consolidate simple renames into a single quirk=0D
      gpiolib: of: add quirk for locating reset lines with legacy bindings=
=0D
      gpiolib: of: add a quirk for reset line for Marvell NFC controller=0D
      gpiolib: of: add a quirk for reset line for Cirrus CS42L56 codec=0D
      gpiolib: of: factor out code overriding gpio line polarity=0D
      gpiolib: of: add quirk for phy reset polarity for Freescale Ethernet=
=0D
=0D
 drivers/gpio/gpiolib-of.c | 294 +++++++++++++++++++++++++++---------------=
----=0D
 1 file changed, 171 insertions(+), 123 deletions(-)=0D
---=0D
base-commit: cd9fd78f5c11b5e165d9317ef11e613f4aef4dd1=0D
change-id: 20221011-gpiolib-quirks-d452ed31d24e=0D
=0D
Best regards,=0D
Dmitry=0D
=0D
