Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE55F60730C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiJUI4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiJUI4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:56:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405008E71E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:56:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b2so5497283eja.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NYrwhi16X5/3SFMiHALA32aV8nqAFGSfduJWXT+ZmfA=;
        b=TDhVMfud9VAZwnS8X4AWhWj5ZCfkWDcnpssLqNHsRBKjs+EihqzYt4oXeCewoH/0jQ
         8BtEziI7BM9Y94IGBpt85J3YTJiKmmNg6tPK4/AGMa0IVHZFyDlmuIwVJqdqN7CtUeKL
         TAF12XEXXThtODAl55aVvlgSzjY1YXBch67ySji7ypPMRxfgQPjNklsUFNb21YP3XNPf
         NcmnHKM837GTgiN+9ZR4a30vJOuzoxd0qmX1pFgsuYJCShRRy7ksGK9eKmY7P2sk3pee
         1HuND87Gr7EQC/IITCl7GXsBMeyn08XUfGPFg7oa/ASyt9RUxvvXGvH1B0WBvHdPVD+G
         5Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYrwhi16X5/3SFMiHALA32aV8nqAFGSfduJWXT+ZmfA=;
        b=nxP5yAWiqkRtcP8G4CuoQzdh7l21TROZctmIy6BUFu+Moo4zfQp/hEnFuD0+NSHuZo
         YRESGW/pmzdaq+THB9/ofozP21rd2qwd1BOOX3fhtQp4S3Ecy5IU84p+3pElCozcvgXU
         VyeV7cQy7YUT4zheE9YTF/0ujoR8oEXGfVxy+c2vG/U5U7SQUlVWQ0B3uvM+zNGKOUlh
         TGKx3N5hRpRZRcQw7koDerqFwCpkUcmeA/z6jiceCwe0IFiyHzQwnPgwRguCuc4F1zzY
         +68AsS2S1tpdMjH4Xgu7TWNxuS9BZKd2xIIo+H0nZFFFWY/4fsC9g11rVzol3/kS8l6x
         hcOg==
X-Gm-Message-State: ACrzQf2zW5s2OIc0ugQEkPB22CUreD7o5Eb9lLw3O/5PZd9LgGydw7dO
        NzTrcF2b/J+1z9E24mA/x8VgqC3T7e4h9bpFrAI+Qg==
X-Google-Smtp-Source: AMsMyM4yxyDYDupkHsdCM3pgOrn8sEVec9iYraBTwkj5aNBc2Uw8egkLYxTPGpqJ2vMQVoB/AkxugQf/lFbyPKYRh4Q=
X-Received: by 2002:a17:907:a06b:b0:78d:d25f:b726 with SMTP id
 ia11-20020a170907a06b00b0078dd25fb726mr14780288ejc.203.1666342563338; Fri, 21
 Oct 2022 01:56:03 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Oct 2022 10:55:52 +0200
Message-ID: <CACRpkdbqRy5pXiy2r5CBiBXd8j7VbXKq40pmx_eXtFMynyAMug@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for the v6.1 series
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some first pin control fixes for the v6.1 series.
I try to be quicker to get fixes upstream now.

Details in the signed tag!

Please pull it in.

Yours,
Linus Walleij

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.1-2

for you to fetch changes up to 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

----------------------------------------------------------------
Some pin control fixes for v6.1:

- Fix typos in UART1 and MMC in the Ingenic driver.

- A really well researched glitch bug fix to the Qualcomm driver
  that was tracked down and fixed by Dough Anderson from
  Chromium. Hats off for this one!

- Revert two patches on the Xilinx ZynqMP driver: this needs a
  proper solution making use of firmware version information to
  adapt to different firmware releases.

- Fix interrupt triggers in the Ocelot driver.

----------------------------------------------------------------
