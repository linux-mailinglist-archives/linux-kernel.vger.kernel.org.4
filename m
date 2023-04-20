Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7743E6E8E25
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjDTJfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjDTJfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:35:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF46FC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:35:04 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b57c49c4cso728064b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1681983304; x=1684575304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02xaOyihgmHWk8PXEKiM2D9tpDK72+IwxLY1vrHA/24=;
        b=iqhQj+YvmgYUadoSx8Q38GJdBLIgRvHSHPqXOVMYrfAEXM3+fTnPvbPtwbJROMhBFi
         9QdybdFqhOqIbMcRM/76IE7KMIIBWw/qViOquAwi7f5sOo1Tq/rMlZM6cAI3mUt87K1r
         j/WH3J/AqFmBek6kgmo1rJ3yDFpFZDb65D85mPBlgwQJUSNSB5v3eTvYxM2qYvVVON5d
         MHUZxVuxKGaW57X5k6m2yX0+tcz/5TNL1hhY3JbXMVEYGTjGAl/4jdNyZZnbESCqsPzC
         UXMDa6bPAYqLTIKW5AwbFR7qFgkC7MQdcFumLTv9Fk6r3srnRhaBEd5I9eTW221l2w3G
         flWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681983304; x=1684575304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02xaOyihgmHWk8PXEKiM2D9tpDK72+IwxLY1vrHA/24=;
        b=CP/cTKhFG35BKk0DMtqylmkcDEzAyxgNQSyIlixOL6e40Gn1gMEuKsVuOGT4MYYcHe
         Z3plNCBCeiIA6LvOyHUwSyFvzKVaxvK7MSItK43GhPUH2aMHs4uAxxztX1xmL75d1w0i
         b7gWK+SZYjs/XwIsWAVrKHGL7ea60J0bZqYuSP7mrF1Bj9biyi6opgOIKeZEAf2uCp1z
         XSBrBlw28wouMW10xE197VVIpzl5CuD35F0AmlLxkMbWpWo4nbdv3RWDC1aNzI/i60J3
         ia4CKuiTZb4iu8QOJgQwzc5kYd98K7VxVnXXJYoJpCkISckrkydeWQDT/xOMcvbxZcSQ
         brpA==
X-Gm-Message-State: AAQBX9flhhfIZjHVEUNA3rQE4/CwcKftebLwA+vfSgS9a+SKlh1VKeqF
        R6eGuw+UE0uu4tAx3uT2HGc1bA==
X-Google-Smtp-Source: AKy350ZtLxzENWOaGa4S3bLhdc+fwFVKBO07vzL/42DsU3U/2Ql2HZ4oAs/YefYgIc+BtMedtJIIfg==
X-Received: by 2002:a05:6a21:1518:b0:ef:53b5:fa01 with SMTP id nq24-20020a056a21151800b000ef53b5fa01mr1066780pzb.49.1681983303722;
        Thu, 20 Apr 2023 02:35:03 -0700 (PDT)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id p5-20020a63c145000000b0051ba9d772f9sm781551pgi.59.2023.04.20.02.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 02:35:03 -0700 (PDT)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     aou@eecs.berkeley.edu, conor@kernel.org,
        emil.renner.berthing@canonical.com, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nylon.chen@sifive.com, nylon7717@gmail.com, zong.li@sifive.com,
        greentime.hu@sifive.com, vincent.chen@sifive.com
Subject: [PATCH v3 0/2] Change PWM-controlled LED pin active mode and algorithm
Date:   Thu, 20 Apr 2023 17:34:55 +0800
Message-Id: <20230420093457.18936-1-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the circuit diagram of User LEDs - RGB described in the manual hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].

The behavior of PWM is acitve-high.

According to the descriptionof PWM for pwmcmp in SiFive FU740-C000 Manual[2].

The pwm algorithm is (PW) pulse active time  = (D) duty * (T) period.
The `frac` variable is pulse "inactive" time so we need to invert it.

So this patchset removes active-low in DTS and adds reverse logic to the driver.

Updated patches: 2
New patches: (none)
Unchanged patches: 1

Links:
- [0]: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf
- [1]: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf
- [2]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf

Changed in v3:
 - Convert the reference link to standard link.
 - Move the inverted function before taking the minimum value.
 - Change polarity check condition(high and low).
 - Pick the biggest period length possible that is not bigger than the requested period.
 
Changed in v2:
 - Convert the reference link to standard link.
 - Fix typo: s/sifive unmatched:/sifive: unmatched:/.
 - Remove active-low from hifive-unleashed-a00.dts.
 - Include this reference link in the dts and pwm commit messages.

Nylon Chen (2):
  riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's
    active-low properties
  pwm: sifive: change the PWM controlled LED algorithm

 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 4 ----
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ----
 drivers/pwm/pwm-sifive.c                            | 9 ++++++---
 3 files changed, 6 insertions(+), 11 deletions(-)

-- 
2.40.0

