Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9CC7307D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbjFNTJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbjFNTJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:09:03 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE38268B;
        Wed, 14 Jun 2023 12:09:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30fbf253dc7so7966f8f.0;
        Wed, 14 Jun 2023 12:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686769739; x=1689361739;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RavBw/beXNuiIwbQf5+ADzUkWI8HXmt0ibMWsiTo/kg=;
        b=TVPeiuttZZZiOfNszeMva/RqEkNV9mLkPCjfWkzGE55N43P6Kqkhi8UfLFK2YfNhSh
         Zxg7vQKs0QyzrlWsmPOeBqt2A9qnO+x39f4MymaczaiKYztI+DO2OISf6CyOuBw6hFlK
         Gszp/ppT6jRseFLlYmGh9Lp9EuqqAL4z/3y4jhf2Zr07j05Hwq7S+Qe48IgYlH8yR7VM
         ZWrSdgHY1FkeA40c/YuO+TLcFlrj3xnAAIbcSIz1MC6L/BmI7x2k23tATKgw/aC6qVcK
         tmePyDCJihbOMIO2is40QTj4iO0rhIHsG+myXhyGnT6FZAJov1Gc7/EUXMU0awqqBgZL
         K/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686769739; x=1689361739;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RavBw/beXNuiIwbQf5+ADzUkWI8HXmt0ibMWsiTo/kg=;
        b=VhRIh2JzdjNdODrleMb3hSJqurlj+lCCMQ0gbEGju9zk7b6tPJXwDC6QqsmoStZN8V
         DynIw090EgsrQgfx+Or3X6iJaC/hp/9DXknx9YwBoiPaFx4E5Fg+vRrIkQ9VLhKNduLq
         D1mUDDJ1668mvk65ylbA8YU3UMEONkEcelckgL+HnB9ipCzK7dhfwQoRE/EWziMxo4ho
         PBbNCnkGGNdVtxYS1yzl9KHamW5c0M3559uCAJiRHMtob2AkYIgA5CRvgexsL8t6zbyR
         gwldTi9mHetCVYHrUCforgHlEpk4kMJtn4a+8CkyD0VnuBWUBZp2QaKo65NzqWl1C9Pk
         V/Xg==
X-Gm-Message-State: AC+VfDyflTu1lkQc737HRXdr2zeO0DvtHZWY10A7cUX6Hv3Lc8E+mNPV
        hBal9MXfFKfIucm2pzWNgxM=
X-Google-Smtp-Source: ACHHUZ4Gf34RQgRIjH2O/wFqMFU3nYMzpDUcaKJHfSZgyW6i9coP7PRFYh1VcfEHkOeoJxEh9vw36A==
X-Received: by 2002:a5d:5507:0:b0:30e:56b3:60fe with SMTP id b7-20020a5d5507000000b0030e56b360femr2092719wrv.4.1686769739485;
        Wed, 14 Jun 2023 12:08:59 -0700 (PDT)
Received: from [127.0.1.1] (2001-4dd6-393b-ff-f59e-4402-63f8-7ff5.ipv6dyn.netcologne.de. [2001:4dd6:393b:ff:f59e:4402:63f8:7ff5])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5306000000b003110ab70a4fsm2341094wrv.83.2023.06.14.12.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:08:58 -0700 (PDT)
From:   Maximilian Weigand <mweigand2017@gmail.com>
Subject: [PATCH 0/3] backlight: lm3630a: add functionality to change boost
 converter frequency
Date:   Wed, 14 Jun 2023 21:08:51 +0200
Message-Id: <20230602-lm3630a_boost_frequency-v1-0-076472036d1a@mweigand.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEMQimQC/x2N0QrCMAwAf2Xk2UJtWWX+ishIa+YCrtVkE2Xs3
 +18PI7jVlASJoVzs4LQm5VLrnA8NJBGzHcyfKsMzjpvg3XmMfngLfaxFJ37Qei1UE5fE5G60AZ
 Kp7aDWkdUMlEwp3HvJ9SZZBdPoYE//+Xlum0/AtvEh4IAAAA=
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Maximilian Weigand <mweigand@mweigand.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686769738; l=2088;
 i=mweigand@mweigand.net; s=20230601; h=from:subject:message-id;
 bh=EEQE3qlxnzvPdxyG2oGt17X4etiM2QkOKRdSulvTDt8=;
 b=QDW3TR3W/883zra37WNEzh+EauPKNzzRyQ0jUD+mJkih625wuoYVOam6dW69idKvEE8TnOpGi
 voO1JiSbRG6CGLieSDFKFKTLpGGwPABCsKlTwIlwrEUtY7qvyzobyJx
X-Developer-Key: i=mweigand@mweigand.net; a=ed25519;
 pk=Tjuj6PXmCCxzGTRw+9suZuZ41q/etgDHrIbPdkAaTpM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For certain brightness settings the Pine64 PineNote exhibits quite
visible flickering of the led backlights, leading to an unpleasant user
experience. It is understood that flickering is caused by certain power
line ripples interacting with the led driver, inherent to the
specific hardware. The lm3630a led driver is able to change the boost
converter switching frequency. Among other things, changing the boost
frequency can also greatly improve visible flickering issues.

This patchset enables dts control of two frequency modifications that the
hardware is capable of: Switch from a base frequency of 500 kHz to 1
MHz, and activate a frequency shift to 560 kHz or 1.12 MHz,
respectively.

As flickering characteristics are mainly hardware dependent, this should
warrant the inclusion of two dts entries for the lm3630a led driver to
control the boost frequency of the chip on a per-device basis.

Changes were tested on a Pine64 PineNote. The following brightness
settings were found to exhibit serious flickering without either the
frequency shift or the higher boost frequency:

echo 186 > /sys/class/backlight/backlight_warm/brightness
echo 255 > /sys/class/backlight/backlight_cool/brightness

Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
---
Maximilian Weigand (3):
      backlight: lm3630a: add support for changing the boost frequency
      dt-bindings: backlight: lm3630a: add entries to control boost frequency
      arm64: dts: rockchip: shift boost frequency for rk3566-pinenote backlight

 .../bindings/leds/backlight/lm3630a-backlight.yaml           | 12 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi            |  1 +
 drivers/video/backlight/lm3630a_bl.c                         |  9 ++++++++-
 include/linux/platform_data/lm3630a_bl.h                     |  5 +++++
 4 files changed, 26 insertions(+), 1 deletion(-)
---
base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
change-id: 20230602-lm3630a_boost_frequency-bae9656ec759

Best regards,
-- 
Maximilian Weigand <mweigand@mweigand.net>

