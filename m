Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EFF658F74
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiL2ROR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiL2ROP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:14:15 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF7913FB1;
        Thu, 29 Dec 2022 09:14:14 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso13635843wmb.0;
        Thu, 29 Dec 2022 09:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jcjPaTl0uGAp0Qu4WHhMyQRLA30oPKQK1tBXg4Aw8TQ=;
        b=OudauJzgl8RxygbxLrbq8SMVA6pLOnyCGMRrRkLiXS9A3OEpZJzqpXSZ6PYT/0oWeK
         +mpgmxwH1c/m6HCJ87w+NJI+HBgmxcFdn4zQrU3w6wB20NZXpbPPOToMWaJLXBAoUHu5
         myCugp7wxEbirZFmOzwJcHz6hqr4oLiO/kkt7RbNvCYtNgJG340l5ZDRsNbIhRw02A+d
         zBr5NISrXq6XU9CwxQgC3YVLH1RLq/oBKYwWovfLod7un7sgXDmSxvtQyBmwNuZTg3ed
         ed3Y/tY+uaYz68F9csQU511wGjxKWpajX6yAJRniSAWTRUF1kV8Hf/fd1Gb6+pigaU0l
         zQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcjPaTl0uGAp0Qu4WHhMyQRLA30oPKQK1tBXg4Aw8TQ=;
        b=MFq3X4fpOw3ghdu1o+yu0O8SbkSxlwi5aeBhsV4FRAkmIQm5zzH8srDzJvJrJ3A2C9
         TeYQttTR50NrNwFWiSwVO6EOyin1PWoBZX2mWy0hv/LiZxKBr0ygSo9+N2AlRjql9qNd
         3k3qBUrRycyC5BLIYeWpXj3OMf0DaQJjTHz/F9seOE5BeoUmutqdb5M7ua2EtoWd3A99
         tqSMAiCAEAnBel29GdIccdTstqpZzsIdauBHDUqjlcq1urkeaN/h/kZdBrKMfkaeqqdb
         YocbDg6fVKTPCM0Mp9Ia7vWE9dKQ8R9DVgnJ/UIdvplLLPWWKXz8EzHJFfc4uvRYICoB
         komQ==
X-Gm-Message-State: AFqh2koTQVb5RzTd42yeY6678ojZaWFfEOqgu2XZfjjquJTMQxvC+J1w
        U2MwiWQSH6ia4aVwjtocVgwTKyA9vurE5YQt
X-Google-Smtp-Source: AMrXdXv7dsBdIWtGPsMVmIsTq+GDxVpyxPY355Wi5wEjHVg3exOLorsEO8xMH/2NkEIhLt0OYz+rNQ==
X-Received: by 2002:a05:600c:4d22:b0:3cf:a5df:8bb0 with SMTP id u34-20020a05600c4d2200b003cfa5df8bb0mr20223853wmp.37.1672334053055;
        Thu, 29 Dec 2022 09:14:13 -0800 (PST)
Received: from tpt440p.steeds.sam ([2602:fbf6:10:8::2])
        by smtp.gmail.com with ESMTPSA id n41-20020a05600c3ba900b003d358beab9dsm28085366wms.47.2022.12.29.09.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:14:12 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony@atomide.com,
        devicetree@vger.kernel.org, maemo-leste@lists.dyne.org
Subject: [PATCH v3 0/2] ARM: dts: n900: use iio driver for accelerometer
Date:   Thu, 29 Dec 2022 19:13:46 +0200
Message-Id: <20221229171348.3543327-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The accelerometer in the N900 is now supported by the iio framework. This patch
series makes the switch to the new compatible.

The iio framework does not support some of the extended properties in the 
previous driver, but the change is useful for modern userspace, which expects
accelerometers to be exposed via iio.

Sicelo A. Mhlongo (2):
  ARM: dts: n900: rename accelerometer node
  ARM: dts: n900: use iio driver for accelerometer

 arch/arm/boot/dts/omap3-n900.dts | 54 ++++++--------------------------
 1 file changed, 9 insertions(+), 45 deletions(-)

-- 
2.39.0

