Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEDA722008
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjFEHtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFEHs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F00D3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685951289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VGkR4tMfNbDgtB0o7CKTM6cPx5ZMqgLHeB2CGeYB4eI=;
        b=TYX7SqV0gLSXl80kbFoRRjPcWqY4Dt+VKU5ysZrQwn27kfypHNUrm8xxCyPQLNU//BNXN7
        EbONR6ORgUhFtQt8rfsgZWGsZyuHiyMjVITAXcM47WNvkw1bzVvl8rs6pz2pFONssapvd+
        fnSUIgPBHwCV8nx2Sp5h0r1Jp/DsN70=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121--4dlYjgEPViTaSj0T3oCSA-1; Mon, 05 Jun 2023 03:48:08 -0400
X-MC-Unique: -4dlYjgEPViTaSj0T3oCSA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f6cc1997fdso21954235e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 00:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685951287; x=1688543287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGkR4tMfNbDgtB0o7CKTM6cPx5ZMqgLHeB2CGeYB4eI=;
        b=Vza7yj7NawzKQSP7eGzoLorS+3diAy5ohko5OLDLfT58zoEuJGZPkkDr90loT+Cf8C
         vECHmS5zPJtW7rVN1SXn+dV0Ghmnx38Vo5CMAsqrpfZ4PSOZcRoMfKlEPl5t6WQxZaa5
         bej/9LrQ4vmRjPojdMwz59OHFSwxSn5WjPkKIBZVYp9UGCDiNwi/NF452CtogWecq3SB
         i2/KTAiaoVXOKXf600n4pz/bzKbmE3JRZGCumrvlxCYz8S0QwuxhG8oXB5jBZB17qlau
         AQyolcNlY1nOnSvpMJpoUJrK+OfIHtihAt5ZPuSehIuSMCUkw6Ux5kyia0clu9VeITux
         x2Pw==
X-Gm-Message-State: AC+VfDwcXlBqrKVQqPEdP6+F99C35yOpcldYAAfSsKUQnHK0nFtFavXe
        OpwnacxUKdd2bp5rnV8w9RBSfLk6mg6ssFAVSwBCe2zZCyduGS0oyVX03MMzR7MAFk/dkeNbMT4
        hnjbtseORksJI5eHhiQ5IuN3uUJ4DTBrX4NMdsxOjiWUpMQOa0P+IgLL9BI+O/F8UiI9SM5Lglk
        rc/mztLG8=
X-Received: by 2002:a1c:4b04:0:b0:3f7:246e:cd2e with SMTP id y4-20020a1c4b04000000b003f7246ecd2emr5265806wma.23.1685951287329;
        Mon, 05 Jun 2023 00:48:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6HJOy+bVutAb7WQLT6j3pU44tUaR1qLXEO8VnPsMONwfgesftWuRQxvkdzmRmRsnT2DMy9OA==
X-Received: by 2002:a1c:4b04:0:b0:3f7:246e:cd2e with SMTP id y4-20020a1c4b04000000b003f7246ecd2emr5265786wma.23.1685951286962;
        Mon, 05 Jun 2023 00:48:06 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q21-20020a1ce915000000b003f4fb5532a1sm9715192wmc.43.2023.06.05.00.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:48:06 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 0/5] drm/ssd130x: A few enhancements and cleanups
Date:   Mon,  5 Jun 2023 09:47:48 +0200
Message-Id: <20230605074753.562332-1-javierm@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While working on adding support for the SSD132X family of 4-bit grayscale
Solomon OLED panel controllers, I noticed a few things in the driver that
can be improved and make extending to support other chip families easier.

I've split the preparatory patches in this series and will post the actual
SSD132X support as a separate patch-set once this one is merged.

Best regards,
Javier


Javier Martinez Canillas (5):
  drm/ssd130x: Make default width and height to be controller dependent
  dt-bindings: display: ssd1307fb: Remove default width and height
    values
  drm/ssd130x: Set the page height value in the device info data
  drm/ssd130x: Don't allocate buffers on each plane update
  drm/ssd130x: Remove hardcoded bits-per-pixel in ssd130x_buf_alloc()

 .../bindings/display/solomon,ssd1307fb.yaml   |   8 +-
 drivers/gpu/drm/solomon/ssd130x.c             | 124 ++++++++++++------
 drivers/gpu/drm/solomon/ssd130x.h             |   6 +
 3 files changed, 93 insertions(+), 45 deletions(-)

-- 
2.40.1

