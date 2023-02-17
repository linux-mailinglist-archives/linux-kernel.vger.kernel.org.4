Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F33F69ABA1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBQMgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBQMgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:36:47 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAD1635AE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:36:45 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r11so863343wru.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5JwFyvTKPrBTTWWlAH9q8tj837s8qKAd0NcHWFWLflQ=;
        b=Ts7Ft9TYg7/N10qTzOnQfhX32Cb15Gk7X195lbTdKeXA5ijaht7DqwExgnVXZfeOxT
         fjHywgFPvdse57dd6FHLpJjF2zVtkVfZ4yuFOY6+znlgZ/YkggGyR40Pjol4I5Syka6A
         4XkfFiXLtUBQaoGAmQZqYmqL3w2dsKnJL3wn2hgDCQE6lsZKJ2AFbBc+enl5vFSBAUfQ
         DDU8HHnjNJLP6HyO/dspDAK4TMDn6YcLftJ3wJTt8evutsYLUnj7A+9S6nlfwQbe49KS
         ngvwjxQtrHy1s3PoRbPOZGBXxPSDzXuuwgaQ0vcGLzDwWI7rG+aG69IES+nCDDWWPFko
         2GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JwFyvTKPrBTTWWlAH9q8tj837s8qKAd0NcHWFWLflQ=;
        b=F9ajV+9iWYsVFZAH7tfLVnNqHz9Qs9jK+r9VRhoQh63nSZCY1N+PV2HTZ7UXygiscb
         QcOkudkA3ZmaVQIOEgtfp6QsmICaiHrjn+AmioxsGJEWckjxuA1sGWzXg4kg+FZQDDc6
         mVOcIMHaTfD+yksq15OnQ+VJarKcWxKFYC5b6dwokW9EWVKqTrIsftWMlr0OG9Le0E9Q
         5UBnjNWXs7A4t9qS3GgYb0x/jRmp9J0DumW0wPLu0dP1TqaeofpczjWIeC1XdIz8wjKJ
         dEKVI7qJxk67L694OvSqQJgm4nv9lhnealgv8ssim4ztiRR5SjVEhwDQYuVTjSk84bGB
         W8gA==
X-Gm-Message-State: AO0yUKWRNOXTAbppJExHerf5BU5o8AZBjDw4oZAuUZ8E8xh6hcGVapU5
        Kh3z3EHWzbVbImWAKQtq9lfJ2JyAFPYzrRQT
X-Google-Smtp-Source: AK7set+rZXG1C9KBOtQYHtGWYCMTVD67lUyPhrhHKtpnDArqoiWJshuBdF+sicSnsX14gLm+NteB6g==
X-Received: by 2002:a05:6000:1685:b0:2c5:3fce:423b with SMTP id y5-20020a056000168500b002c53fce423bmr5566920wrd.4.1676637403718;
        Fri, 17 Feb 2023 04:36:43 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1191:9464:3947:1946])
        by smtp.gmail.com with ESMTPSA id x16-20020a5d60d0000000b002c5640f9bf9sm4077228wrt.85.2023.02.17.04.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 04:36:43 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.2 - part 2
Date:   Fri, 17 Feb 2023 13:36:42 +0100
Message-Id: <20230217123642.115329-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

This missed the last PR as I only applied it today but it's a one-liner that
fixes a memory leak in the GPIO simulator that's triggered every time libgpiod
tests are run in user-space. Please pull for v6.2.

Bartosz

The following changes since commit b8b3b0bfb742f0cbb006c66b10216b724ce42e25:

  Merge tag 'intel-gpio-v6.2-2' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-current (2023-02-16 13:31:42 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.2-part2

for you to fetch changes up to 79eeab1d85e0fee4c0bc36f3b6ddf3920f39f74b:

  gpio: sim: fix a memory leak (2023-02-17 12:02:26 +0100)

----------------------------------------------------------------
gpio fixes for v6.2

- fix a memory leak in gpio-sim

----------------------------------------------------------------
Bartosz Golaszewski (1):
      gpio: sim: fix a memory leak

 drivers/gpio/gpio-sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
