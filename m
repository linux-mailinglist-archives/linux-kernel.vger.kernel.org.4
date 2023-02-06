Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCB168B963
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjBFKG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjBFKF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:05:57 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B3AC662;
        Mon,  6 Feb 2023 02:05:14 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id dr8so32524724ejc.12;
        Mon, 06 Feb 2023 02:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jjCybrG70/yrOJQ+k9c+KggNESHSfTxWf5w9/d345rg=;
        b=XYp0F6f/n8NUwgEHI4Y57jHwZILsdZNeDJot65k6VwJfBOMyqY/BtuZx6DBXw2VWs2
         JrH0oa8qkvelCSSFVSSi4uAzw5YTTQXlRk2/VLl+fjzH7SZB4fI7ZjaeZ/uSmig1BOEP
         vXgUccwJa4FUOfL+X2myxyVJh6qCpgwhOfIn1CqvHOUjeVTpvW8sRWw2T06DkkzO+TPB
         G1To6fZGioJlcp/Nl5hGlzbNK9zmMaIEjC7/2/UzGB/gpwemUXxPxxXHAGaIezVf416k
         R0e22flz5w8iQDAeLh1va9TIRU8g5O4YukXJIevgPYGfbgu/HVXkfsCepYkMM3HJTUCp
         GQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjCybrG70/yrOJQ+k9c+KggNESHSfTxWf5w9/d345rg=;
        b=7GSOQDIg+LgONXIWkdFJ4TOXK1ZOFYZytgEBC++H9P1P66iAg89930ImIQ9Ynp5WAh
         vBquEG0/bavRlzVHG192hFw3lnKv8mUvaQdeD+S9j788jRTT9ujp3bY04BRLzf3eI775
         qyLKmuJeeayYalYu97mQsYUEwFAJATCeoD6EEL5XRe1XofHsr3Ctbde4P/9nz4+1to/b
         N940hqeMhg8rXOVJhct/c9I+G7xbIILKxWvV2OqiMZg0ITJLI3JxjhDs5/wyHhBn1GlW
         elPSRa0Y8lmIi/NtHA2Ch5uMyTxH8ogYBsyVkAKwZ1oNvSUhrnhAix7bqfct9665YmcJ
         I9qw==
X-Gm-Message-State: AO0yUKUndj1k5FNSh4aeyGZf7K8fGLrTWDXCkurHu0fjo7rhmUBs280R
        6AlURlGGB7a15Yl/Yx2yc58=
X-Google-Smtp-Source: AK7set8OY8hGd/tMl/8d4bnK2M2+cWsHXVnBEJWOcSYaX0EbFKUsI9fIpcJQbtYP0PYxxfP0Tr0X3A==
X-Received: by 2002:a17:906:a847:b0:881:23a:aba5 with SMTP id dx7-20020a170906a84700b00881023aaba5mr19647918ejb.11.1675677913431;
        Mon, 06 Feb 2023 02:05:13 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id s19-20020a1709067b9300b008878909859bsm5240746ejo.152.2023.02.06.02.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:05:13 -0800 (PST)
From:   Willem-Jan de Hoog <arinc9.unal@gmail.com>
X-Google-Original-From: Willem-Jan de Hoog <wdehoog@exalondelft.nl>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Willem-Jan de Hoog <wdehoog@exalondelft.nl>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com
Subject: [PATCH 0/2] nvmem: brcm_nvram: use buffered nvram data for cell values
Date:   Mon,  6 Feb 2023 13:05:00 +0300
Message-Id: <20230206100502.20243-1-wdehoog@exalondelft.nl>
X-Mailer: git-send-email 2.37.2
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

Words from Willem-Jan de Hoog:

On OpenWrt 22.03.3, Asus RT-AC88U does not boot anymore:

  UBI: auto-attach mtd4
  ubi0: attaching mtd4
  ubi0 error: 0xc04f0b3c: PEB 0 contains corrupted VID header, and the
     data does not contain all 0xFF
  ubi0 error: 0xc04f0b4c: this may be a non-UBI PEB or a severe VID
     header corruption which requires manual inspection

The problem seems to be that brcm_nvram_read accesses its (mapped) io
memory. When doing so the correct data is read but after that the
mtd/ubi process fails to work.

The bcm47xx_nvram.c code has buffered the nvram data so the cells value
can be read from there.

Willem-Jan de Hoog (2):
  firmware: bcm47xx_nvram: allow to read from buffered nvram data
  nvmem: brcm_nvram: use bcm47xx buffered data

 drivers/firmware/broadcom/bcm47xx_nvram.c | 14 ++++++++++++++
 drivers/nvmem/brcm_nvram.c                |  8 ++++++++
 include/linux/bcm47xx_nvram.h             |  6 ++++++
 3 files changed, 28 insertions(+)


