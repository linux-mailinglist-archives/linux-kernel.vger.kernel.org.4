Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4736112F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiJ1Nf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiJ1Nfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:35:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E5174B9A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:35:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m15so7860918edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WSwQM4r3Aloa2EOq8rU0uP3kNCarhDXB0thjIbc77xg=;
        b=STyBewDO/7n9ft69SvCHqaswoHQvZFRM3ljBu+AQ9E6wq3TtWYkWUMcr+eiu3te4+S
         oIhlMd2D9UcNJ6mi9XJk2mqIzApoFYoKjMbM88SfD8kRmNogMRGMZoOgHJ1llBQ0bpXl
         weTsPE4Syk7c1GQffwixdScJufTiulEPVRlKx1bI/N09XwMTOHyoFKo5TXZ1+a1S339g
         suMm3HROwfKIj/2ACxboL+ThNqSaF6bk6q3NLZ7fJHIQTs+RVon+IoKK5eNosi2um7Qn
         f3wqQUE9RSyasQCicPx044wTuwhQNvFE9i3qMrqHi4yGa0MeSBAzR2C8mWjWxbISEu6Q
         TdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSwQM4r3Aloa2EOq8rU0uP3kNCarhDXB0thjIbc77xg=;
        b=gmg23IJBMt08Iuoc+GdCRRI5cVGU1cjsHQV10zQnzm6XAsEDuJ/621cvAPBlevhbkp
         vuDp/kd04voNkpD/FXARXoVzdA3DYbDyVUChNUZG97Ml9UKs9+/6L2upHJmEqIPGKiFo
         bbnAdFAGToNpoZIl7r3h7ctyfOqDnHturUw8BKIrHERq/fs+7fnPht/fUAY6d3iTKDno
         n6JhiNHjZw7R2EdSAQ1iJskkJpEXzP/Iiy7OibAR8Bu3wb+mUoccOOzNLs9fYnZroqJT
         rv0KGTx+YIVn8UJJa4bTgp9PiywK3/8/29PY4lXQzkVugqN2idGJ6VZ76ApB2Dw45VU7
         mCYQ==
X-Gm-Message-State: ACrzQf3ebSPhb27yBi7cFq2UjAYjFpudSQ+QHuoYIJkYroD7MqFV2f8A
        sPnjj53L6phVa3PthihJeS1XASHfbaTN7YMk
X-Google-Smtp-Source: AMsMyM6LVAkBeUbJXuZCHehVOHMks5GfyGlenLV/x11aGi6VugERXZO0ftYFMJ+FIrvXED9FlWuYKw==
X-Received: by 2002:a05:6402:1941:b0:457:13a:cce9 with SMTP id f1-20020a056402194100b00457013acce9mr51736950edz.265.1666964151837;
        Fri, 28 Oct 2022 06:35:51 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id mf7-20020a170906cb8700b007aa239cf4d9sm2190907ejb.89.2022.10.28.06.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 06:35:51 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        devicetree@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 0/2] leds: lp55xx: support disabling the charge pump
Date:   Fri, 28 Oct 2022 15:34:57 +0200
Message-Id: <20221028133501.95833-1-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new option in the devicetree "ti,disable-charge-pump" disables the internal
charge pump. This can be used to avoid current flowing into the Vout pin when
an external supply has been connected to drive the LEDs.

Maarten Zanders (2):
  dt-bindings: leds-lp55xx: add ti,disable-charge-pump
  leds: lp55xx: add option to disable charge pump

 .../devicetree/bindings/leds/leds-lp55xx.yaml     |  5 +++++
 drivers/leds/leds-lp5521.c                        |  6 ++++--
 drivers/leds/leds-lp5523.c                        | 15 +++++++++++----
 drivers/leds/leds-lp55xx-common.c                 |  3 +++
 drivers/leds/leds-lp8501.c                        |  5 ++++-
 include/linux/platform_data/leds-lp55xx.h         |  3 +++
 6 files changed, 30 insertions(+), 7 deletions(-)


base-commit: 5f52a8ba7e91215c3d046d298fb328d1b9f7897d
-- 
2.37.3

