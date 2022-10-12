Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07785FBFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 06:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiJLEKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 00:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJLEKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 00:10:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE061BEBA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 21:09:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d24so15142112pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 21:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Jp/SlFFCMnEqsPO2g0Uz7D7qlR6JXLE91xSSG+WAMc=;
        b=c+CI1oX/GK7oQoDAFXFEIeFq+n5gebCxncSL823QuPOrI3EDyL21744NZE4Jm6raOD
         CR2/zIS9C7QVPX4PJzsve0ZFu4ayMbk7dQm8Xza/royFj1YDTXcuj5ADIj8d9gIfGZ39
         HC37sSNHYUT2ELEs9XscBxLK46UcF2O363xiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Jp/SlFFCMnEqsPO2g0Uz7D7qlR6JXLE91xSSG+WAMc=;
        b=NRIeoywr42qtxNa0mGlCHeqZWA7qeetNh7bW8tldIfmwh9as8M03trCDtxSVG+1nI+
         ctCJiPklIiZ6bu0klXdWmfRQqdihk9bWwNY9cBufL8iiSzktcsOC02uGmYUi/WJXMkW0
         GHgicWgz5o+YNyn4Knu/drfWNZuEzabpCDEbDEa88BijN4Im28gTuJAVSWRLAEyByDCn
         MEsdIHP4mcys5hqNZrNYaKArgod/Vjfx2xuEtTb2QgXqu48vciFjj0VmH6xmGlazsnIK
         ttY9Q6Q1viWhwaZtuBxitqaTJtzxaT9gm1ekWFRe8fZhiKAILOBZp3JfyAyqym9LMVHh
         5xKA==
X-Gm-Message-State: ACrzQf30PUE7htLb8szChePKjfbdARvBMLwtluDao7K3pr4sulK6mCkP
        9RaxUmFpT6jEQf2mpKVDPHeKdQ==
X-Google-Smtp-Source: AMsMyM4Vb6519yEaSc6tKHm4MULKtZ9uPf/0ltYaqpMpw9hNlY92DquROq/RqFfhafpl8bOivlElJQ==
X-Received: by 2002:a17:903:509:b0:179:ffcf:d275 with SMTP id jn9-20020a170903050900b00179ffcfd275mr27545911plb.150.1665547797438;
        Tue, 11 Oct 2022 21:09:57 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:4704:5b50:96e5:620f])
        by smtp.gmail.com with UTF8SMTPSA id w12-20020a170902e88c00b00176ba091cd3sm9448702plg.196.2022.10.11.21.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 21:09:56 -0700 (PDT)
From:   Dan Callaghan <dcallagh@chromium.org>
To:     chrome-platform@lists.linux.dev
Cc:     LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Dan Callaghan <dcallagh@chromium.org>
Subject: [PATCH v5 0/1] Add a driver for the ChromeOS human presence sensor (HPS)
Date:   Wed, 12 Oct 2022 15:09:17 +1100
Message-Id: <20221012040918.272582-1-dcallagh@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a driver for the ChromeOS human presence sensor
(a.k.a. HPS) device, attached on the I2C bus. The sensor is a
hardware-isolated module which reports a high-level presence signal,
e.g., whether there is person in front of the computer or not.

The driver exposes the device to userspace as a character device, which
can be used to control the power state of the device. The driver
automatically turns power off to the sensor unless a process is using
it.

More information about HPS, its firmware and communication protocol can
be found at
https://chromium.googlesource.com/chromiumos/platform/hps-firmware.

Changes in v5:
- Updated MAINTAINERS.

Changes in v4:
- Simplified open/release pm logic.
- Renamed device to "cros-hps".
- Stylistics cleanups.

Changes in v3:
- Moved from drivers/misc to drivers/platform/chrome.

Changes in v2:
- Removed custom ioctl interface.
- Reworked to use miscdev.

Sami Kyöstilä (1):
  platform/chrome: add a driver for HPS

 MAINTAINERS                            |   6 +
 drivers/platform/chrome/Kconfig        |  10 ++
 drivers/platform/chrome/Makefile       |   1 +
 drivers/platform/chrome/cros_hps_i2c.c | 151 +++++++++++++++++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_hps_i2c.c


base-commit: 8edd2752b0aa498b3a61f3caee8f79f7e0567fad
-- 
2.38.0.rc1.362.ged0d419d3c-goog

