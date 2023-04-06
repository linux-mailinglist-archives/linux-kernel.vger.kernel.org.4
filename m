Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB206D977F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbjDFNBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDFNBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:01:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127DB83DC;
        Thu,  6 Apr 2023 06:00:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-93071f06a94so134619066b.3;
        Thu, 06 Apr 2023 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680786056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7PolMebzlGo3m+R/p7Qla4pdtm0VZuwEuB1wuOht7GM=;
        b=gHeH3RL3VHlvZzVJG+2SupBaarMZccqhljEfR2BZcLJb2xIqqUvnsDjpKofH+xnNQD
         wqgXtvDL3uQKIGeNbRt3zMiJPpUhk22s6YiljpipCQ/0b0/TXZ8CeGE0hI11dAuTNmi9
         O7L+OVsObvHgskRjSCR2AxM2iQerc9KuhKVHHaC4HKTeQprtEr0KeU/RSb4udi3aQy7e
         1XJlVQqdcEw97FbqTN3Rjz0o9J3raNFCgoOVq0vvvepVGiWNnEXhk4Pw0fcm/YhgY6rO
         8xUzna/2Lej8DLyqSzQ9djlDbqRN7JnSwU7EX3s3twBBOkSQXlXnG/TYc3Ygsu+RqSLL
         c33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680786056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PolMebzlGo3m+R/p7Qla4pdtm0VZuwEuB1wuOht7GM=;
        b=padRb9INg5Xu5qO4QJz8jb1+MOWtBuq4c0lB0BMU1Tn5kB9X1NWNMNI9CHXsazDfax
         VsmzWQHKYuN7HrTBWXDTbWLDCazmnJ8LQEGlyXrU7VxwLY6BCNqFPXPofoBk21SLQQwi
         0kpZYI2DA2QmM6Fxg4rXupX7TuGnfba94WgdDiO5Xdd3GeMydtqMNevaVBjQO6lvW0TT
         VLge2Pv9ngMS5k+weX4r5K2prgdxmX+WISc+1HVtV7FjrOvOTrGQfcyD+hyMnj3k8TEO
         w6sO9QNnkVocuIK0ZPD2iwSHbo8LilGZF9p/etFzqED4Au6qh/g0MmU37O5IEN6VQ59+
         DZOg==
X-Gm-Message-State: AAQBX9cpKL6Tm+HFu2HZAMiWm1QwLL9Jizgh8HEGZ0/homdixErB0XKH
        Cc0CLKoLJubCbiEf/vPIYnY=
X-Google-Smtp-Source: AKy350bjPdLRkx46ycEOqOSzFc2ZVAUAPdgOBSgCNYwQwwbfa79zah7wcLn/RR1+qdWNU1zYLGAsbQ==
X-Received: by 2002:a05:6402:7c2:b0:4fc:6475:d249 with SMTP id u2-20020a05640207c200b004fc6475d249mr5004686edy.3.1680786056096;
        Thu, 06 Apr 2023 06:00:56 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l18-20020a50d6d2000000b004c0239e41d8sm727809edj.81.2023.04.06.06.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 06:00:55 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Fixes for v6.3-rc6
Date:   Thu,  6 Apr 2023 15:00:55 +0200
Message-Id: <20230406130055.1244344-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.3-rc6

for you to fetch changes up to 1271a7b98e7989ba6bb978e14403fc84efe16e13:

  pwm: Zero-initialize the pwm_state passed to driver's .get_state() (2023-03-23 14:44:43 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Fixes for v6.3-rc6

These are some fixes to make sure the PWM state structure is always
initialized to a known state. Prior to this it could happen in some
situations that random data from the stack would leak into the data
structure and cause subtle bugs.

----------------------------------------------------------------
Uwe Kleine-König (6):
      pwm: hibvt: Explicitly set .polarity in .get_state()
      pwm: cros-ec: Explicitly set .polarity in .get_state()
      pwm: iqs620a: Explicitly set .polarity in .get_state()
      pwm: sprd: Explicitly set .polarity in .get_state()
      pwm: meson: Explicitly set .polarity in .get_state()
      pwm: Zero-initialize the pwm_state passed to driver's .get_state()

 drivers/pwm/core.c        | 12 ++++++++++--
 drivers/pwm/pwm-cros-ec.c |  1 +
 drivers/pwm/pwm-hibvt.c   |  1 +
 drivers/pwm/pwm-iqs620a.c |  1 +
 drivers/pwm/pwm-meson.c   |  8 ++++++++
 drivers/pwm/pwm-sprd.c    |  1 +
 6 files changed, 22 insertions(+), 2 deletions(-)
