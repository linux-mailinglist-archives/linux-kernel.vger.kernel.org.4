Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72036683565
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjAaSdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjAaSd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:33:26 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D79359765;
        Tue, 31 Jan 2023 10:32:27 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t7so6749112wrp.5;
        Tue, 31 Jan 2023 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pmfwiug2vCvfWKAJuMbDLrLuqCSQQyxwRBO0nWickj4=;
        b=ZiUQqG4kL6Wt8nv+2ejxhjtEQ4u/bPZs3rh6zHg1QNVc9Gz8RBF86Um1FZJnEY3biM
         lcqxYN+dr8OWKArxQlrYvw83rvabKcyIeC8cTNkdNdS3+HNPTrGrEjKaYIGso3BNwU5G
         nxOA657lUVZ5xF+fbEXrIEvcepOhRA22wQlu8BAE5hXlTCw6hQLcUBe9NlvXRz9Ea+8D
         9b/8smWHdvdsWEcOYWP+kgFK5/enyNU/yZGlI6mtkVSc+v9iV8cA0FX7BONOKAuoXDrI
         r5UHAHKKvNwcIEO1zaj0oWDlEzBOV54Tu/XXRafufNjnDtoMZE8gzo+CCvhS7RB/HBWB
         TU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmfwiug2vCvfWKAJuMbDLrLuqCSQQyxwRBO0nWickj4=;
        b=WRl47RXIHxklXtzCzTC9KL+J40tEPp/ki3bFCgc7XxLk/wMugzndQ5WiiDqr+WaczE
         tz3qehDeawTFQrJQFm2gN1QZZ0pnxguV4MpVApqz8vdDDpImjONq4EE6fh9PSFiYIBr9
         3CA+0CxUJMihz6NnLFV7y3Ewm+llspNOk3TtcUQYguqIRnXWrEeMyU/21KpkY+OR5oP8
         W79DCFkR4NTfWrmFnMGAD0bVguNXDc2nh3l/SCfCIZhcA9tz+1eitiddYcoLDhCmWM70
         rKifmO/j5VGCiICNMWb/pAjsIaCapSv572gOPen9WWFUDmwfMUmQa5WQ49+86KuK5f0j
         HerQ==
X-Gm-Message-State: AO0yUKXHlqH19Klj5gHDBgAB5CziP/yj+BVyS7VlulG+0e84xkJO3v+W
        +U5iB7cs6Cbb8S+qMVsfSaAUuoMm4Bw=
X-Google-Smtp-Source: AK7set/plZAoM6/JpYaTJheKuSus0+0knEK9IiWHLuL87LafAun7GTiLX51w9N9IBAPTbVsXDXGI2A==
X-Received: by 2002:a5d:64e6:0:b0:2bf:ba69:71ef with SMTP id g6-20020a5d64e6000000b002bfba6971efmr16984wri.1.1675189944538;
        Tue, 31 Jan 2023 10:32:24 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.googlemail.com with ESMTPSA id c7-20020adffb47000000b002ba2646fd30sm17307311wrs.36.2023.01.31.10.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:32:24 -0800 (PST)
From:   David Virag <virag.david003@gmail.com>
Cc:     David Virag <virag.david003@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: [PATCH 0/2] Remove SEC S5M MFDs with no compatibles
Date:   Tue, 31 Jan 2023 19:30:05 +0100
Message-Id: <20230131183008.4451-1-virag.david003@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S5M8751 and S5M8763 MFD PMICs have no compatibles, and board file
support for them was removed, resulting in essentially no way for these
chips to be used anymore (unless they get dt compatibles).
They seemingly have never been in any board files upstream and I only
found references to the SM8751 being on the SMDK6450 board (which has
been unsupported for many years now) in a downstream Samsung Galaxy S2
kernel tree.

The patches should be applied in order.

David Virag (2):
  mfd: sec: Remove PMICs without compatibles
  rtc: s5m: Drop S5M8763 support

 drivers/mfd/sec-core.c              | 46 ---------------
 drivers/mfd/sec-irq.c               | 89 ----------------------------
 drivers/rtc/rtc-s5m.c               | 82 +-------------------------
 include/linux/mfd/samsung/core.h    |  2 -
 include/linux/mfd/samsung/irq.h     | 50 ----------------
 include/linux/mfd/samsung/s5m8763.h | 90 -----------------------------
 6 files changed, 3 insertions(+), 356 deletions(-)
 delete mode 100644 include/linux/mfd/samsung/s5m8763.h

-- 
2.39.0

