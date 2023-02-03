Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEAD6893DC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjBCJeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBCJeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:34:14 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4021B991FD;
        Fri,  3 Feb 2023 01:34:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bk16so4057612wrb.11;
        Fri, 03 Feb 2023 01:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PrpHGxtp6SiIsYCBAXbLESWsdf1GZxXOD4QBV4HnKkE=;
        b=Q53KMx1FaGoZB8omwcg/8lMDUWH8RynX5ZJI9OP4zc5RTiEYVBrU8YWR6A6ZVsJJQN
         6I/Oksj2UmaxL+DrotU8KkPJ+97/E2Otf+T0rh0SFKlkxQcVPr6wrr3Z0zCUi+yu777L
         fq7MYXijRqs5Gm7v4ZhoSJvB4IIayGPhADvowpRJM0DKqECbfM7Vfsy0kambcJ3qrt1E
         8JOhZBwbXzNDN/FHzhVx/wdf+47ZDTcKMASj151xNadMt+WLRNyTJ6+njpBJwqb1THYz
         pugxPHcIcHYF3zWoo4Hf+2dNM678lYIaJ8NIu2JEPeATNLxvQvXC/pSPf2WVGzG7Yb6V
         lxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrpHGxtp6SiIsYCBAXbLESWsdf1GZxXOD4QBV4HnKkE=;
        b=0ZjycoVGVvU2H42cit9sOyR5hdvKFss7SJ8IIqZ0yiOssCBqwqAJZif54Yo+wJRX3S
         F7ZCb4ppOJgb1TVv8zZRPUN516t+MECloNSsaUeqofUXK9QnPrCbFq69gLUzLih2XKg6
         yhNl80UPhDqtYs2wXP9c8FsaQE4uXvwy5B2uFmrqRs8O4MENQpmudtKAwRc33FOE1Q4Z
         FB5q8R1mMjFREuxMo5aQkosTV/G+6RIfEGmL/Km3XISM7q2LpsdoZOSeyvTF9uw5uUQZ
         SWAcpsn/qmaZi6x1rZ5/teHh5h9t7RprkQGF9eugsy83FYqDC4Z44QHvTp0eUSQM9CR2
         BQsQ==
X-Gm-Message-State: AO0yUKVvD8Jw936nspQuht1TpK3NnBWz6HZFhl0vQPG5yIQJUzErxjVT
        aI2laocSR2i2tXHtU/nmIyo=
X-Google-Smtp-Source: AK7set+jYNAoWVf7sPL6TkpgCcimgDU4GTphlkH5OxnWpXE31u5dIfM5v2bxFmP5APXSvpXsJYEMGQ==
X-Received: by 2002:adf:fa84:0:b0:2bf:e449:e72a with SMTP id h4-20020adffa84000000b002bfe449e72amr7840109wrr.60.1675416849629;
        Fri, 03 Feb 2023 01:34:09 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r7-20020adff107000000b002c285b4d2b5sm1533259wro.101.2023.02.03.01.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 01:34:09 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Emanuel Strobel <emanuel.strobel@yahoo.com>
Subject: [PATCH v2 0/2] media: rc: add keymap and bindings for Dreambox remotes
Date:   Fri,  3 Feb 2023 09:34:03 +0000
Message-Id: <20230203093405.1616564-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This series adds bindings and common keymap for the Dreambox RC10/RC0
and RC20/RC-BT remote devices.

Changes since v1:
- Split bindings and keymap into separate patches
- Revise keymap description to clarify non-IR keys and mappings
- Revise tagging and key ordering in the keymap

In v1 the RC10/RC0 keymap is incorrectly tagged as RC20/RC-BT and vice
versa, resulting in some missing //RADIO and //TV keys. Correcting the
tagging then reordering the keys to match physical layouts [0] and [1]
results in no missing keys. The keymaps worked, but I've gotten things
confused when translating from Emanuel's original keymap. So apologies
for the confusion.

Christian Hewitt (1):
  dt-bindings: media: rc: add rc-dreambox binding

Emanuel Strobel (1):
  media: rc: add common keymap for Dreambox RC10/RC0 and RC20/RC-BT
    remotes

 .../devicetree/bindings/media/rc.yaml         |   1 +
 drivers/media/rc/keymaps/Makefile             |   1 +
 drivers/media/rc/keymaps/rc-dreambox.c        | 151 ++++++++++++++++++
 include/media/rc-map.h                        |   1 +
 4 files changed, 154 insertions(+)
 create mode 100644 drivers/media/rc/keymaps/rc-dreambox.c

-- 
2.34.1

