Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7446690FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjAMIbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjAMIbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:31:21 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABBD44C78
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:31:20 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p24so22737254plw.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kBEmviVcUaQ36DwQBsnDSO4G5pwhdVpJ2oN92m3Dybg=;
        b=f7++enNZEL4SsuxaJnsnZw81kRX/EsImW+eWHRw7liJ4tZ4GxYfSxv/XoDk7ZDd2Kb
         FLFdF0z+C+Z9lwX4++CP2JAcT8PiOFISW0WmA2vRyABVYWhCZlyXJLkiGFsQ0PvCSeld
         ddHgzgygcReJgHYxDbmh0xcqFJ72wGizpuPdhUkCpsqC0SuDJcNt5idS0k9q+CxmBM6w
         hD4M7U/S+6PopWeq7zmA6sv0KTnREJWg5WYpNCW4CFiw4RsPYYD1bqSxknpqxte95XjR
         8dAPEV4bkf4hfBHTA7wxFVh6AqQjwjn22CmxskfGyaT5l8HKtvU1gTfjmBsWPcVRfqP6
         aMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBEmviVcUaQ36DwQBsnDSO4G5pwhdVpJ2oN92m3Dybg=;
        b=LS6yDJOafgyEntzeRU69jVqSZsq4qhzYWECdymo71SSp8zfWFXWSffZt8LTujMXjUy
         qXiYJtN+durbMGLK8dyBYXcXLyw22c9i0vTzcmrlTGYd2wFvWTv9zoPxUCFwFnbUvQDh
         GBxxR/ljIyz3baKrgCgzLAiv4mOUpYIlXB30aajt0TKEjTp5DtfOkdYn4+BsPTmH0LmM
         b/UGU39UjMhyPozU8tgwka1LgDrPrjIFQXxthW2zZ06a8hm//30CUr88a0hjGYA0Clch
         3tALTUwyquV3oDklkLx6hnmtRdcqNUVQ2XyiG4QG64Q+edmEjY44W9nNd3lz5Ve+dYxH
         mq8w==
X-Gm-Message-State: AFqh2kpgafXUrQFA+shyJCpA9MjXHlIDJuO+/y+kGVY58whSZPuBRFKV
        af9msHLbxQvGxjuWRbNMShzn0A==
X-Google-Smtp-Source: AMrXdXtBLLNn01zlZ5/XfXv/LMaVCWnTxeF7fs3ronY2mkDvlXYwSl7sAG0uTVhhxl6IBWPUAFD17g==
X-Received: by 2002:a17:902:d48a:b0:192:48d1:f06c with SMTP id c10-20020a170902d48a00b0019248d1f06cmr13731785plg.35.1673598680109;
        Fri, 13 Jan 2023 00:31:20 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b0017f73caf588sm13466123plp.218.2023.01.13.00.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 00:31:19 -0800 (PST)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Nylon Chen <nylon.chen@sifive.com>
Subject: [PATCH 0/2] Change PWM-controlled LED pin active mode and algorithm 
Date:   Fri, 13 Jan 2023 16:31:13 +0800
Message-Id: <20230113083115.2590-1-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the circuit diagram of User LEDs - RGB described in the
manual hifive-unmatched-schematics-v3.pdf[0].
The behavior of PWM is acitve-high.

According to the descriptionof PWM for pwmcmp in SiFive FU740-C000
Manual[1].
The pwm algorithm is (PW) pulse active time  = (D) duty * (T) period[2].
The `frac` variable is pulse "inactive" time so we need to invert it.

So this patchset removes active-low in DTS and adds reverse logic to
the driver.

[0]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Unmatched/hifive-unmatched-schematics-v3.pdf
[1]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Unmatched/fu740-c000-manual-v1p2.pdf
[2]:https://en.wikipedia.org/wiki/Duty_cycle

Nylon Chen (2):
  riscv: dts: sifive unmatched: Remove PWM controlled LED's active-low
    properties
  pwm: sifive: change the PWM controlled LED algorithm

 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ----
 drivers/pwm/pwm-sifive.c                            | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

-- 
2.36.1

