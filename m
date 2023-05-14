Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3AC701C2F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 09:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjENHru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 03:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjENHrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 03:47:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1E02109
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 00:47:44 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaf706768cso88251965ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 00:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1684050463; x=1686642463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=psVi+uu7gPRH/n0OWz4yeAMRQ5ZWsimFDEGiHD2LvJ8=;
        b=AWe4i2zm1twY3RzeclNA2KPZeLsVWmdvGhmCNhP/v3rJcaUQfX6BVh8bK9hUZNK6tZ
         LSsur3BEk57P2fPhgbvkp7++cjUrCUY4BH2LgWSRS+DDBD2oTRvuaYOouCfLb8yVkzvD
         8IKT89FT0EI1MRY6pK9gPBQ4QImGr87/+vgsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684050463; x=1686642463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psVi+uu7gPRH/n0OWz4yeAMRQ5ZWsimFDEGiHD2LvJ8=;
        b=DL17TYy6b4uwxPdaiyXC5gXVgBAd6Xwc6fok6n26xcrH0BR0fYtyyZJOb+NOvZpOKS
         VIMuE3wojFI/jA20oHfkSkL+Y5RJKFtkPRTEge+8i9IiToaB3efteiItIgO4Iu8qGMM7
         9EEZFuIKTMs9nfxJUPeABkx7lyeoeyqFoWpR3aTLIbZ9DVq/j+0lQgl2g7ISbS1ljwVZ
         qhedwFenQQYvtjeIgKDrJKr9kQlS6wJYDRSPSCmWRL6ap6SVcy4fxVeW/MI15ih80Rh0
         MDpy1FTg2BIQXIWeVv75x2w6Sjc1sXHOiOUmugRzLf5IE9XKiXHj3uQ5khYL8YdA3C4T
         fSFQ==
X-Gm-Message-State: AC+VfDx7iMfrhMWnGp4MLgBRfKwIOyuxfPw3hSOcQ37WvHVbZc2WRiM7
        zoJs3YXbUJG3OyU3P6KMv677mA==
X-Google-Smtp-Source: ACHHUZ4sU9ia39wRPGImmuBohUL/goFz3e8Wrk/4kGZN2jmxqB16YV/nrkvMbJ9ZwHM67Dcx/yR0ig==
X-Received: by 2002:a17:903:1110:b0:1ab:74c:bdf2 with SMTP id n16-20020a170903111000b001ab074cbdf2mr41326845plh.28.1684050463081;
        Sun, 14 May 2023 00:47:43 -0700 (PDT)
Received: from 8add390ca20e.heitbaum.com ([122.199.31.3])
        by smtp.googlemail.com with ESMTPSA id j4-20020a17090276c400b00194caf3e975sm10903363plt.208.2023.05.14.00.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 00:47:42 -0700 (PDT)
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        anarsoul@gmail.com, alistair@alistair23.me
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-bluetooth@vger.kernel.org,
        Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH 0/3] Bluetooth: btrtl: Add support for RTL8822BS
Date:   Sun, 14 May 2023 07:47:28 +0000
Message-Id: <20230514074731.70614-1-rudi@heitbaum.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent support of the RTL8822BS SDIO WiFi and the 
BROKEN_LOCAL_EXT_FEATURES_PAGE_2 quirk complete the enablement by 
adding Bluetooth support on the RTL8822BS UART with hci_ver = 0x07.

The RTL8822BS requires the BROKEN_LOCAL_EXT_FEATURES_PAGE_2 quirk.

Test results:

[   10.029959] Bluetooth: hci0: RTL: examining hci_ver=07 hci_rev=000b lmp_ver=07 lmp_subver=8822
[   10.047194] Bluetooth: hci0: RTL: rom_version status=0 version=2
[   10.047250] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822bs_fw.bin
[   10.114730] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822bs_config.bin
[   10.237433] Bluetooth: hci0: RTL: cfg_sz 75, total sz 24543
[   11.244540] Bluetooth: hci0: RTL: fw version 0xaa89f793
[   11.279285] Bluetooth: hci0: broken local ext features page 2

Rudi Heitbaum (3):
  dt-bindings: net: realtek-bluetooth: Add RTL8822BS
  Bluetooth: btrtl: Add support for RTL8822BS UART
  arm64: dts: allwinner: h6: tanix-tx6: Add compatible bluetooth

 .../devicetree/bindings/net/realtek-bluetooth.yaml  | 13 ++++++++-----
 .../boot/dts/allwinner/sun50i-h6-tanix-tx6.dts      |  2 +-
 drivers/bluetooth/btrtl.c                           | 12 +++++++++++-
 drivers/bluetooth/hci_h5.c                          |  6 ++++++
 4 files changed, 26 insertions(+), 7 deletions(-)


base-commit: bb7c241fae6228e89c0286ffd6f249b3b0dea225
-- 
2.25.1

