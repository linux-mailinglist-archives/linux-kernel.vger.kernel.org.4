Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3340E6878B7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjBBJYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjBBJX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:23:58 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A9A5421D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:23:55 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hx15so4070351ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pylWIAOIiR5skZ+1kMPoVcH9WvFuUK+jl3IbeuDoWjc=;
        b=JB/kNWdhKyrzvI6OOcUBul4X7b7Gc8XUGhuDDBnhnXc6sj9ZwK3XOlHV504iRfRWcL
         bmDhDvWLSDGfkW4W9B3YXYrGYs5fJcKPzNH3eEbulmHOJkryhXG+g9YIenQBjmI9WdFW
         sEPPjIxxc1z370K/kWS1JcUQ++P4vftF93fLBtCYX00XEfsLJpJVHQPfeYnYmTiLdKlb
         /lLhZB9rd7touERwPcjW8TA6iiAz+Srwyj5eR76sT2ls2EyoGOk15ividhHpthXpiwn8
         5f39fJHSwwUaColQDN58sfEZHhtWIVviD7fJlce0CBTwf/7/fQQixTluQEKXec9VxF5Y
         n4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pylWIAOIiR5skZ+1kMPoVcH9WvFuUK+jl3IbeuDoWjc=;
        b=WOifkIUTquDFP0fCJ5Y4yM5Zt97TASKQh2zRLSIN5V3W3X60/UN9cgENBwamrkhGAp
         +uk7YAg8WpfvVRkuHSFGeXgfw7cB8iTzahs6SwHJ9NYgWBR2G/LLaiOspG/FuzyBoiqu
         J6fcEylFQ1j/nd/kjNBuelpbGmnXbOatoMJckryHWWKDbOsELetRXGsHE7O9K5az58aN
         fPCYZhlfaeFHqgsZCAx9fVEsJKwM5A9dpGEWwlGhsiRY9oHOYCrD917qjjxVdRc3F43p
         db4+Z+l0RXCEKYjk0nfxvnUvK8zvEO0PXunLR3DmZmVvmW8O/ccyYM+JuZzZTzUkN5ac
         mHrw==
X-Gm-Message-State: AO0yUKUhJxHbpCczQ8XHPiLUZlehe8nhuKUYrivJSqTjGRdfkKs6PWvU
        GXEV9jBUMf+/8AqKzCsA7Y/sNQ==
X-Google-Smtp-Source: AK7set/n3JVz221kaZq3wXdWomFwew7p7XaEOoJoRxKDtdYwTnH+nnAIEsHoj4PcC7Dd4wFL9H5tFw==
X-Received: by 2002:a17:907:1607:b0:7d3:c516:6ef4 with SMTP id hb7-20020a170907160700b007d3c5166ef4mr7261465ejc.20.1675329834223;
        Thu, 02 Feb 2023 01:23:54 -0800 (PST)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id j4-20020a170906474400b00856ad9108e7sm11372658ejs.70.2023.02.02.01.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:23:53 -0800 (PST)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] leds: lp55xx: configure internal charge pump
Date:   Thu,  2 Feb 2023 10:23:23 +0100
Message-Id: <20230202092325.21241-1-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new option in the devicetree "ti,charge-pump-mode" allows the user to
configure the charge pump in a certain mode. The previous implementation
was "auto" mode, which remains the default.

v1 of the patch implemented a bool to disable the charge pump and had some
issues in the yaml binding.

v2 implemented all options of the charge pump as a string which was too
complex to parse & check.

v3 (this version) replaces the string by constants.

Maarten Zanders (2):
  dt-bindings: leds-lp55xx: add ti,charge-pump-mode
  leds: lp55xx: configure internal charge pump

 .../devicetree/bindings/leds/leds-lp55xx.yaml  |  8 ++++++++
 drivers/leds/leds-lp5521.c                     | 12 ++++++------
 drivers/leds/leds-lp5523.c                     | 18 +++++++++++++-----
 drivers/leds/leds-lp55xx-common.c              | 14 ++++++++++++++
 drivers/leds/leds-lp8501.c                     |  8 ++++++--
 include/dt-bindings/leds/leds-lp55xx.h         | 10 ++++++++++
 include/linux/platform_data/leds-lp55xx.h      |  3 +++
 7 files changed, 60 insertions(+), 13 deletions(-)
 create mode 100644 include/dt-bindings/leds/leds-lp55xx.h

-- 
2.37.3

