Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EF75BABDB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiIPK7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiIPK6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:58:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C64B6D75
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:46:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w28so6941757edi.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=9nGXI3rWxOZ8NHTVQvlMO9I4kmNG+wDn/0VKOuYYbWY=;
        b=fE2f0sdwj7xt5sk8vnG5J2uHo1AAJ25Dy0BoEyDsqQy1D4SUogDm9xAJtD77fIN+Ie
         EEEQ902UP8j0IXjey3sbypI3qT2R7G0xHLLkppeHs700m7BBUNXXqNzIK5s9F9Ul0ohV
         oM+NGwPtcgVuLjwxXSS75Mq7qccOBlAMU4lQd5bum18LC6i+DLvuZmT6McfX4wGETGL+
         1tGTVdWUzjm3bungP1MSKwCx3MiRE1aDtfjxlCOrH8dOzGYPjU7hFQNMNheIWnRuRRHH
         1VcT4Of+KhH4RkyguiX6wvJx26akjR9hLhrc/PDca1n1c23PW9JocEvtM7OFpXFJBnrh
         Afkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9nGXI3rWxOZ8NHTVQvlMO9I4kmNG+wDn/0VKOuYYbWY=;
        b=tjQArhD8Bnyc2q/CPSqFMUa0HDA2KA6B9lXZJIhqD1jfkLxUgdDk+qusuHWVkhWiha
         dKyEsscSlMr0ozoxF5CHuOGG2XQ2a1jh7Zfglg6TRdQWwp3iaskCr2bOJR2HflwNWkB6
         UHzs3P6MBcO4ZWN8vfkMTSUv2SUJhss5pmIizi/UEl2S9nemeBLYcE4zNS/ezAQB8J7G
         VpjdscB2WPRMpYXNO9zX1kJhNmxvMDgDxlWTM1QHNw3KNytgpXI3ivhhLJzlRAXeR0Fo
         p932e9qAaAKdcDnr1LKUNZnHk6cegGrsuA58Aw/mWJwoDqMJ0DzFtT7Lks+w7D7tAfk1
         5evQ==
X-Gm-Message-State: ACrzQf3bfHXfUjwC1PT53uVXoVNo9yYBKgoa6jXRyBu9xQyumhuOUhki
        ClBQEYTmgp8zx/CuPUwGBtGq0A==
X-Google-Smtp-Source: AMsMyM6bpuSzPsKAI4XGGueEEUQjuAHWhExoZiL6HgwVKGcwKfqvm+/F3L+9U6zXVBBpLocLWodR6A==
X-Received: by 2002:aa7:d614:0:b0:453:f01:75c4 with SMTP id c20-20020aa7d614000000b004530f0175c4mr3431232edr.302.1663325170983;
        Fri, 16 Sep 2022 03:46:10 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be (ptr-4xh0y3vvunoijj2gi1k.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:cef1:93b4:727b:dd58])
        by smtp.gmail.com with ESMTPSA id fi24-20020a1709073ad800b0072af4af2f46sm10148434ejc.74.2022.09.16.03.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 03:46:10 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v4 0/3] iio: temperature: mlx90632: Add powermanagement
Date:   Fri, 16 Sep 2022 12:45:49 +0200
Message-Id: <cover.1663324968.git.cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crt Mori <cmo@melexis.com>

As discussed previously on the group under the
"Controlling device power management from terminal" thread the mlx90632
sensor provides measurement capabilities under sleep_step mode. This
series runtime suspends the unused chip to sleep step mode to save power
but in case of continuous sequential reading it switches to continuous
mode for faster readouts. This value is hardcoded to
MLX90632_MEAS_MAX_TIME (with some buffer) and not user configurable.

The sensor runtime suspension is set to MLX90632_SLEEP_DELAY_MS which is
hardcoded to 3 times as much as MEAS_MAX_TIME.

Changes in v4 (per review comments from Jonathan Cameron):

 - Migrate back to devm_pm_runtime_enable and remove the pm_disable function
 - Remove pm stuff from remove and also sleep, since when iio device is
   not registered also sleep makes no sense.
 - Replace use EOPNOTSUPP as per checkpatch suggestion although some drivers
   still use ENOTSUPP.
 - Change the style of read frequency

Changes in v3 (per review comments from Jonathan Cameron):

 - Change the "available" attribute presentation to more recent way
   suggested
 - Replace devm_pm_runtime_enable with enable and devm_add_action_or_reset
 - When suspending device also put it to lower power mode in case there is
   dummy regulator
 - Use more switch cases instead of if/else

Changes in v2:

 - apply review comments from Andy Shevchenko

Crt Mori (3):
  iio: temperature: mlx90632 Add runtime powermanagement modes
  iio: temperature: mlx90632 Read sampling frequency
  iio: temperature: mlx90632 Change return value of sensor measurement
    channel

 drivers/iio/temperature/mlx90632.c | 402 +++++++++++++++++++++++++----
 1 file changed, 347 insertions(+), 55 deletions(-)

-- 
2.34.1

