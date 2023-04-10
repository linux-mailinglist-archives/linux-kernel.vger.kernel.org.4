Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFA56DC6E7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjDJMuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjDJMuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D945261
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 05:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681130956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gfI+8pNpKHzSRSbn60p2xLlTui4koSe7i9/TyNPKMTg=;
        b=g1NFzA4Z0CWJ5MxbPPMIRNvRhZjC+JcLPK9bNf8dITcz3gCOP51Tq3oct1xueLLuYiQDeg
        AqxuubiCnoiLSe43tHC9bCxE1rDlCBKkfsGouqKUCJs90Ab7d+f03tgH+gXTIsxH59uqpW
        X1Z4jIxRmNtSiAUzNnc9S3kS/Hp/3X0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-jJ725RxJNFmF6k7MX5U79Q-1; Mon, 10 Apr 2023 08:49:14 -0400
X-MC-Unique: jJ725RxJNFmF6k7MX5U79Q-1
Received: by mail-wm1-f72.google.com with SMTP id u12-20020a05600c19cc00b003f07be0e96bso1802992wmq.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 05:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681130953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfI+8pNpKHzSRSbn60p2xLlTui4koSe7i9/TyNPKMTg=;
        b=Z0EFkC6N+F4N7nXyjq1AlDk4dKImD1crQOJ13DXBxT5G4v7Jzlzgh9ecu7r7JbxS4a
         2ca5uH6KUvA4noei+Uf+u51wsJM78TD6BvfO4RbWOmo4RLSwJH+4MFm43ff8dim7v7Mu
         mHLkii/LybJvEF7RnHtJhlgcdaejubrM+DQLxjsK/N3yfPSGrGvll6oWtW4bV7Vc3q+q
         FxMC+KJA9KDYjD5N5wV0X9jOUthBt1GnsquK8Pfpnqo4Pc9rEYM/z96HkmEPgn/lyBCS
         wuk/n74WogsF2ga37tVr/L1T2dhlaI2rPqgTaLkQAqLSlbgF5C5PnnE584IifBKKOJqs
         Ioeg==
X-Gm-Message-State: AAQBX9dlogJUFMu09dBbceWKM6Z08+c9zlNLKECixxK4uBxLVqMUrg3/
        66CKTdAky8nA4Kqcul9nwhtpmpV77lXVq1XQVfqTNwjuWJLAYPSQfQncF4man2IBqPDLStDT4zu
        FmLIKEiJgbU77hhmgZXnGfGQrP/+5qQA1A33Nni608SJtLmzeL3Wsp1h7ijl8rtyWAcjnDm7m1L
        IOmUwGCCo=
X-Received: by 2002:a5d:5349:0:b0:2c7:1b4c:da75 with SMTP id t9-20020a5d5349000000b002c71b4cda75mr7297859wrv.69.1681130952906;
        Mon, 10 Apr 2023 05:49:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zf/wmB9Myl3vBu+oEHUuKmq0XEAyi0iCtTxsDkx/dzU4MaidTOs+oWSxrEoWjjViR0eA5pqQ==
X-Received: by 2002:a5d:5349:0:b0:2c7:1b4c:da75 with SMTP id t9-20020a5d5349000000b002c71b4cda75mr7297834wrv.69.1681130952548;
        Mon, 10 Apr 2023 05:49:12 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m8-20020adfe0c8000000b002cff0e213ddsm11791320wri.14.2023.04.10.05.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 05:49:12 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Elliott <elliott@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Hansson <newbie13xd@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] ARM: exynos_defconfig: Enable zram as loadable modules
Date:   Mon, 10 Apr 2023 14:49:07 +0200
Message-Id: <20230410124907.3293869-1-javierm@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable zram and dependencies as loadable modules. This allows to use the
/dev/zramX virtual block devices as swap stored in system memory.

Options were taken from commit 5c824e8be64d ("ARM: omap2plus_defconfig:
Enable zram as loadable modules") that does the same for OMAP2+ platforms.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 arch/arm/configs/exynos_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index b0f0baa3a6c4..2d5be864b4ca 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -37,6 +37,8 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_CMA=y
+CONFIG_ZSMALLOC=m
+CONFIG_PGTABLE_MAPPING=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -84,6 +86,8 @@ CONFIG_NFC_SHDLC=y
 CONFIG_NFC_S3FWRN5_I2C=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_ZRAM=m
+CONFIG_ZRAM_WRITEBACK=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y

base-commit: e3adc46da349d4a4cda1c58d8186c5bce0b011fd
-- 
2.40.0

