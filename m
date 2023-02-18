Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0417369BBEC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 21:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBRUt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 15:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBRUty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:49:54 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5256C14200;
        Sat, 18 Feb 2023 12:49:53 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o28-20020a05600c511c00b003dc4050c94aso1020890wms.4;
        Sat, 18 Feb 2023 12:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VQu4KERsOXR2QRxIcOaaW/fj82rXSW/v9N9/yRjlFqM=;
        b=USzv0g1pjUOFzXXkMOK1jOkcff0+ryQNvrLN8CLjUKBypzFK5nkJVUMgedgUCxRqvo
         fMcDr5Ej0GNyP3N8DKmPNDVwHWE7f4s0JZ0PRYLB9bVvJvIgczvL9Lx+o3FImvcJR4Pg
         9HahUDTOKk3zwhLC8EAyJCwwMD/ynPEkjSZPfcaCxyY207eEY6t1HdUmIvf3uYFRl8lI
         X1o0Ovred3tMhKptrQu3mfqxyAgk7MZYtrRBjQ7b+YzhUQog1Q3DVbbQBh+c8Q3Gt+st
         4WpjrAlgHY4l9uRVZT027Mk265yCNXnJ+7QS5zuZTmztfRm9chXzRksYVB2yJU9EX65W
         eRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQu4KERsOXR2QRxIcOaaW/fj82rXSW/v9N9/yRjlFqM=;
        b=EqYOtYa8chZJDlRqBAkBcggCcKNQvBivysGMq3L4OrdJe0yzA04KPE7iO1LnCyV+90
         F6CHhT6bNzx/UXDiU30ZmYMFuoSCzTXi0uJ9Cs6QwG7gYUvp9zWlLOer6+6fM/3Jd6CR
         nllXCbPT2XhzLi5hy9z4uPOxSnNUDO9r3MDsJ1A4CmegFaLVzC18F+B71WgKwL+G3IwI
         hs+iW/mA1cF65cRr3dIYispzLQGc4SrhZZTz2A16j7bvCNb4KNQelWx1a2sH5Pp3YlOA
         QdyPfgIohd3gQpAuUzPWu1ZqBDfZ5WSJm9PtXk06BjGRoWIFKP2w8FFK9WZIq4pqwTaF
         eOUA==
X-Gm-Message-State: AO0yUKXDF4b4TFRdzLK03guD62JcD/qR9d7TYmHtcfJrBbDPW/jL4xmA
        dCk7LQI19gJGunn42VvcJNH41S0Y/9k=
X-Google-Smtp-Source: AK7set+jFlwMImrrgKk+XmaHhYffzfbTL0fFauxmwVeEwtuQeWUCaVF+QVHhoMWrYD5E8UbF/XfGhQ==
X-Received: by 2002:a05:600c:4aa8:b0:3e2:a9e:4eaa with SMTP id b40-20020a05600c4aa800b003e20a9e4eaamr7663973wmp.35.1676753391687;
        Sat, 18 Feb 2023 12:49:51 -0800 (PST)
Received: from localhost (94.197.47.81.threembb.co.uk. [94.197.47.81])
        by smtp.gmail.com with ESMTPSA id az17-20020a05600c601100b003dd1bd0b915sm6075114wmb.22.2023.02.18.12.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 12:49:51 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sre@kernel.org, wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] AXP20x USB power supply remove use of variant IDs
Date:   Sat, 18 Feb 2023 20:49:41 +0000
Message-Id: <20230218204946.106316-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this series is to remove the driver's dependence on
variant IDs, because they are hard to maintain and make it more
difficult to add support for new chip variants.

Regmap fields are used to replace ID checks and handle bits/fields
that may differ (or not exist at all) on certain variants.

Aidan MacDonald (5):
  power: supply: axp20x_usb_power: Simplify USB current limit handling
  power: supply: axp20x_usb_power: Use regmap fields for VBUS monitor
    feature
  power: supply: axp20x_usb_power: Use regmap fields for USB BC feature
  power: supply: axp20x_usb_power: Use regmap field for VBUS disabling
  power: supply: axp20x_usb_power: Remove variant IDs from VBUS polling
    check

 drivers/power/supply/axp20x_usb_power.c | 285 +++++++++++-------------
 1 file changed, 130 insertions(+), 155 deletions(-)

-- 
2.39.2

