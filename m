Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2108D706B64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjEQOlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjEQOlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:41:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F18122;
        Wed, 17 May 2023 07:41:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f420618d5bso6228845e9.1;
        Wed, 17 May 2023 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684334508; x=1686926508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H+KC9aWhk9Nue79yWDp+sL63hK9fCcCnZcN242M9Snc=;
        b=Z7rx8NP8zxZZplHp9JQsq2SOrjhFUCJitdu6cYUYl/XuMw/gP2F8PdmUFww8IXUfN3
         7sLXACqEfM48cfFpUGiQkUvCSEcGwjRhiv7Cjm4b9vTa8tuocSll8b3BAc0XPgWCMXsP
         Lem7kRo0en6+L6oScQiUVFRBwxS53wtDucriSCEF5EymACkM0VM933RuOyLZSMKena7I
         rwR7WRaBBvaSFMV0/0YOUUdg7qZT58/YKJtaPwvF3A/ww0IWz8t+7hzKtkDDICdTRrwo
         z7ctu/OczDbLtrZGEy8vcrhACOJ6/Q86Jp75A0KKa3MDFwDLnPM66ZmEOI6Pu4XV9xwA
         uinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684334508; x=1686926508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+KC9aWhk9Nue79yWDp+sL63hK9fCcCnZcN242M9Snc=;
        b=VVydpwq9RYnKeLAb+ctoHpcelVOTOBtDmo6uDNQ+iXZ5BgP04+s9n3ucn6Lk5asSOb
         FCzQD5Wdgo6HyQeWhsOgd3zl/29m0oKb7rgWDtlRTEB/r2r+qRnNUJbymq1zUIgTc/Bu
         yjBVCedms7b+Swa2oxJ0kCD3Iv78a80j7yxsCrWwIAa0B9lPJpwG/l85p39Qv3E6CfPX
         6Y+1A23xp2JhDLTL4H3utXjBryyYZ28Zhx6i3EDfQVucZfDZAZGSb1dkjbhvaqK7geCj
         tXvvqPBXyzb+v88X0kG3YQfiiUvXNfUnFTZDojHUwOB5e3EEX1kDLoSjYtNkZqaqv5Mv
         biEw==
X-Gm-Message-State: AC+VfDxg+Pt9AXV6xxeHv430klgORX2QKwaOxGVpAjoruiIReLPpm/nO
        gq0yMVQ37c1JWRnJ+AEgUDI=
X-Google-Smtp-Source: ACHHUZ6r9JnZAqQ1Oxz0SzV4SQL/kRkz/ekqEeAXzPzAT7mGp3tOFwEX8x4W11EssaMrKUixYQ/2cQ==
X-Received: by 2002:a7b:cd04:0:b0:3f5:d0ba:3c1a with SMTP id f4-20020a7bcd04000000b003f5d0ba3c1amr1387505wmj.4.1684334507898;
        Wed, 17 May 2023 07:41:47 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id v18-20020a1cf712000000b003edc4788fa0sm2536739wmh.2.2023.05.17.07.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:41:47 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] Add RTC for MStar SSD20xD SoCs
Date:   Wed, 17 May 2023 16:41:41 +0200
Message-Id: <20230517144144.365631-1-romain.perier@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches series adds a new driver for the RTC found in the Mstar
SSD20xD SoCs. It adds a basic rtc driver, the corresponding devicetree
bindings and its documentation.

The rtctest (from selftests) has been passed on this driver, with the
following output:

# rtctest 
TAP version 13
1..8
# Starting 8 tests from 1 test cases.
#  RUN           rtc.date_read ...
# rtctest.c:52:date_read:Current RTC date/time is 17/05/2023 15:58:12.
#            OK  rtc.date_read
ok 1 rtc.date_read
#  RUN           rtc.date_read_loop ...
# rtctest.c:95:date_read_loop:Continuously reading RTC time for 30s (with 11ms breaks after every read).
# rtctest.c:122:date_read_loop:Performed 888 RTC time reads.
#            OK  rtc.date_read_loop
ok 2 rtc.date_read_loop
#  RUN           rtc.uie_read ...
# rtctest.c:137:uie_read:skip update IRQs not supported.
#            OK  rtc.uie_read
ok 3 rtc.uie_read
#  RUN           rtc.uie_select ...
# rtctest.c:166:uie_select:skip update IRQs not supported.
#            OK  rtc.uie_select
ok 4 rtc.uie_select
#  RUN           rtc.alarm_alm_set ...
# rtctest.c:214:alarm_alm_set:skip alarms are not supported.
#            OK  rtc.alarm_alm_set
ok 5 rtc.alarm_alm_set
#  RUN           rtc.alarm_wkalm_set ...
# rtctest.c:274:alarm_wkalm_set:skip alarms are not supported.
#            OK  rtc.alarm_wkalm_set
ok 6 rtc.alarm_wkalm_set
#  RUN           rtc.alarm_alm_set_minute ...
# rtctest.c:324:alarm_alm_set_minute:skip alarms are not supported.
#            OK  rtc.alarm_alm_set_minute
ok 7 rtc.alarm_alm_set_minute
#  RUN           rtc.alarm_wkalm_set_minute ...
# rtctest.c:384:alarm_wkalm_set_minute:skip alarms are not supported.
#            OK  rtc.alarm_wkalm_set_minute
ok 8 rtc.alarm_wkalm_set_minute
# PASSED: 8 / 8 tests passed.
# Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0


Romain Perier (3):
  rtc: Add support for the SSD20xD RTC
  dt-bindings: rtc: Add Mstar SSD20xD RTC devicetree bindings
    documentation
  ARM: dts: mstar: Enable rtc for SSD20xD

 .../bindings/rtc/mstar,ssd20xd-rtc.yaml       |  37 +++
 arch/arm/boot/dts/mstar-infinity2m.dtsi       |   5 +
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ssd20xd.c                     | 249 ++++++++++++++++++
 5 files changed, 303 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/mstar,ssd20xd-rtc.yaml
 create mode 100644 drivers/rtc/rtc-ssd20xd.c

-- 
2.39.2

