Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5B95F73EC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 07:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJGF2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 01:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJGF2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 01:28:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13D1C459F;
        Thu,  6 Oct 2022 22:28:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso6259834pjf.5;
        Thu, 06 Oct 2022 22:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbISlDL7a0iQ4bQybEAlot/T7BI00UirHULEdvMSrkQ=;
        b=NUAdajHBG0yY30wE54051yrpose3kT4Bwzwz1tK5Z/jeBgPrgRTrLOUn4WWf3vB47E
         ENfHyBP+1pLqm0Mx5YuFBfE1Fv9wsyQy3mIqG4cpyr+X3EO434mBTyGbD3xfiTL9ynI5
         rz1uHTtvHx/6oZZ/hqQ9DAuBtEzzmRWvyvdUTsR6GAMg5yzl8g4MaopU4rbsvdThMoZK
         YrYY3Rdsp+M6cYnqPpFEUm7IGnymt4iG8jfgsdZcmBtl9qv82tbwoT8IDXjB1iUEekSt
         1FM4M0kmbE0EHEl9K5mUKEaAzkfq/QR/wzgKUMevbFH0VwOuROTqXL35yY+E1j3HBl/A
         i13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbISlDL7a0iQ4bQybEAlot/T7BI00UirHULEdvMSrkQ=;
        b=nJpMisDX4jfoIe5qKo2yOhDOUVOl8jr64JT5XUAwYBsTZI682V9iKsPcUPNzxSZp9s
         hTV6AHE5jEQHuLHZO7z2Vb+iP9Rm4hzZ7y2XgEXELEyh0DoY48MW7VcGIoP4HRKvuMBC
         8CEjH/4/ThCGiCZkTAzldJJ8iVHaNs7+VYq+wXEB53zOEhz56Iox8DEWqvw4L9HiFzmQ
         VAF4SouP4nijgfjMKoVvSVGX6x4nRk5D7mFgjJZmL6pHJijrpEkr0Dw6nvIjkhjHR+cS
         cOCdhkGliRKptHF3vVGdfWtoiSq4++pzVFBF0TB9Xy8EnzTAejgF3R48HHl2jcN7eyDl
         i2mA==
X-Gm-Message-State: ACrzQf3nOMM5qRtKVXLDXMInLNpARzcQwAnMdRmne+J1rm6tfaYfX/1Y
        0RGpVOjC4vWtC4UWJ20uXgXNzM7Flg==
X-Google-Smtp-Source: AMsMyM6FzEoQFzWruQ0JdpAWR+SdhRjwzLZpDsqIVcc4tqin5C3A7aip80SRCBGYOzUuDG0C+Yj13g==
X-Received: by 2002:a17:903:22d1:b0:178:3d35:dfce with SMTP id y17-20020a17090322d100b001783d35dfcemr3422556plg.16.1665120490410;
        Thu, 06 Oct 2022 22:28:10 -0700 (PDT)
Received: from localhost.localdomain ([106.104.115.142])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902860c00b00176c0e055f8sm579480plo.64.2022.10.06.22.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 22:28:09 -0700 (PDT)
From:   chengwei <foxfly.lai.tw@gmail.com>
X-Google-Original-From: chengwei <larry.lai@yunjingtech.com>
To:     pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>
Subject: [PATCH v2 0/2] Add support control UP board CPLD onboard LEDS
Date:   Fri,  7 Oct 2022 13:25:28 +0800
Message-Id: <20221007052530.31621-1-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP board <http://www.upboard.com> is the computer board for 
Professional Makers and Industrial Applications. We want to upstream 
the UP board 40-pin GP-bus Kernel driver for giving the users better 
experience on the software release. (not just download from UP board 
github)

These patches are generated from the Linux kernel mainline tag v6.0.

chengwei (2):
  mfd: Add support for UP board CPLD/FPGA
  leds: Add support for UP board CPLD onboard LEDS

 drivers/leds/Kconfig             |  10 +
 drivers/leds/Makefile            |   1 +
 drivers/leds/leds-upboard.c      |  78 +++++
 drivers/mfd/Kconfig              |  11 +
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/upboard-fpga.c       | 482 +++++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h |  49 ++++
 7 files changed, 632 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 include/linux/mfd/upboard-fpga.h


base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.17.1

