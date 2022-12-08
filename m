Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B9F647575
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLHSVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLHSVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:21:49 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D5082FB0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:21:47 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso1676663wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 10:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qIs4lQCakho0r7ShsrtjguOWPhatcvKJaCSKmoAEX/0=;
        b=bPMhmE83Jk2e5zLjjrHbUHSxXVfc9DjtZoT+NqFfuoZw84h2wR7nZ6N6O+XSWAlyvS
         TWejKUyLNXy8n2dsTy1e9zmFnmSBkU4m+AuVINgxXlew/XUlNu98rRLXwrY0O4WnFm39
         bBmpr9WvVBAyfW0eu922Bn6V2opnapL+6IOVvZ6mghfiz8mc2uWr9NbmM/4ZKPPnUbly
         ucwmC3ozpAWtUfEtqu8aArIhopGjNW5903aB64XqfV1Xpl2EN5vUXGq4fsnNluIUTrOc
         bm9qFVlSsXNbREAGaJdkiXsmal6eJ7vVYMAvZbY3oqVfYB0cj+fqRtWKimEZdvLY0qRc
         PUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIs4lQCakho0r7ShsrtjguOWPhatcvKJaCSKmoAEX/0=;
        b=murIEYXw/BvRUSqqanxJFtuCau4k7d5lxm8srfr7SPAJQpkMMl+vANoIxq/epyBuzi
         gS5jFIDE0oLai/GopJQQhmSpC/L24aR0smotaE3N7HCJZL5t+mGMHclJayjOOY1IBz2s
         TIATbJrsOGY0/F82b41iZPXay302ma/7voAl4HcTCrrzQmhAOmEYJZG2TcXHjXECb9OV
         j121Fuq/uEefeprSkpicwyFllrX9Otbiv5O2G+s37kinMrtyV9SRhcosvgPQj39r0y5e
         LCIL/0+QqVyrbYhZSGRodWmfGOu4ccmMpZh3vVpS35V5hhQg0P3Sf9vn8ajOhi7lPm+k
         s3Vg==
X-Gm-Message-State: ANoB5plU+8qlD+yzndGKpQabFtBnOlBHq4f4MauhkZUADPXLguWno5Fg
        UPcV3AbIfypRieND1ruN2KuEQQ==
X-Google-Smtp-Source: AA0mqf4CgjZ6wDAZMUBWiHGDiaJWoAotvFsUx2d17lqrdMojR9a0pLA8aJWz2BXUGfWaNgAmJNCu6Q==
X-Received: by 2002:a1c:720f:0:b0:3c6:e63e:23e6 with SMTP id n15-20020a1c720f000000b003c6e63e23e6mr2666814wmc.21.1670523706065;
        Thu, 08 Dec 2022 10:21:46 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1fd:11b0:f877:1d6c])
        by smtp.gmail.com with ESMTPSA id f26-20020a7bc8da000000b003cfd4e6400csm5770338wml.19.2022.12.08.10.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 10:21:45 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/2] i2c: fortify the subsystem against user-space induced deadlocks
Date:   Thu,  8 Dec 2022 19:21:40 +0100
Message-Id: <20221208182142.250084-1-brgl@bgdev.pl>
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

Several subsystems in the kernel that export device files to user-space
suffer from a bug where keeping an open file descriptor associated with
this device file, unbinding the device from its driver and then calling
any of the supported system calls on that file descriptor will result in
either a crash or - as is the case with i2c - a deadlock.

This behavior has been blamed on extensive usage of device resource
management interfaces but it seems that devres has nothing to do with it,
the problem would be the same whether using devres or freeing resources
in .remove() that should survive the driver detach.

Many subsystems already deal with this by implementing some kind of flags
in the character device data together with locking preventing the
user-space from dropping the subsystem data from under the open device.

In i2c the deadlock comes from the fact that the function unregistering
the adapter waits for a completion which will not be passed until all
references to the character device are dropped.

The first patch in this series is just a tweak of return values of the
notifier callback. The second addresses the deadlock problem in a way
similar to how we fixed this issue in the GPIO subystem. Details are in
the commit message.

Bartosz Golaszewski (2):
  i2c: dev: fix notifier return values
  i2c: dev: don't allow user-space to deadlock the kernel

 drivers/i2c/i2c-core-base.c |  18 ------
 drivers/i2c/i2c-dev.c       | 112 +++++++++++++++++++++++++++++-------
 include/linux/i2c.h         |   2 -
 3 files changed, 91 insertions(+), 41 deletions(-)

-- 
2.37.2

