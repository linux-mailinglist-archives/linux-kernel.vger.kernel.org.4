Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B386FC46B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbjEILBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjEILBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:01:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D6F76BF
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:01:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30789a4c537so2027264f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 04:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683630065; x=1686222065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iIvyFHCh+tjos91/JHqT3UVsNGFiYlOd/dE9tn924wg=;
        b=T+LHn4HoLxJM2i4Ex0kvWt+We1F5eNxilbowCtdanBMKveFhT+Ihp8c2Lx3j8bCRgJ
         qJZxO3YjD9VYNuVxuw2hpzsJX4nAsCq7iXWGdmqPL5qTktuBVlAOaUvdFM11uXENDb/I
         yidIfD2y0N0c/OJWfTFOTy4GiGC0qbr7QB2A45I44aw43ZKJKbzjQJYN3uRRoV1Fzc0w
         VhEabGu21sQqTl35s+v1FH/RL4OwUCesie/KVNq8+nH0ZSp4ciMoazLOXFJJqHGNSXGD
         Xo0BlPeFkGFqkOsT8/C+125W6kV/wFu95AJH9DujAntKHmlOVoDc4xgbkLwZAxUH4d63
         mTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683630065; x=1686222065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIvyFHCh+tjos91/JHqT3UVsNGFiYlOd/dE9tn924wg=;
        b=IiBLx12SofsEu+UScwhWZeqvhBrP7Zrvf98biLBFFcmKbTtfHMITD4AiVogD7d/vdJ
         WASkAfKwha4CjyNrsCpVDku1Kiytg26ICEQzIxIZgrG2iE/KnmvW8AAyNxkafyQJjRz+
         9UFPb1oZK08m5WGy6Cbhji9tn5vNOD58sYgWYASGaaL1f1QxDT+8FBZoqwm1+5Rsr4Ls
         RjnyXI1yE2QilzTN4M9GWvwdo6D/EErdvOfrGfHpLD4hwcJF2YwduSP3Dva16GSRXoCX
         NIU8QnoZsgqLAMMFV5gCVs714On7tKxVb7f072s8/5ncFGBVw1q4fXsgfJ1Lmnu6DpEE
         LSPw==
X-Gm-Message-State: AC+VfDyiVtJf4inEZjw82zwe8hotBIe3x28fsA6PzoKpKaI31Wa3BBWX
        +aLksUuvR79KOqsSOnHrX0NjbCIJMVM=
X-Google-Smtp-Source: ACHHUZ4BjOPJQwbCPskIcglTDICT1D3KO2ONTlZ38HQqgr6nqgpJPb9Hn3sFdhW9m0TV7umf706+4g==
X-Received: by 2002:a5d:58e9:0:b0:306:340c:4737 with SMTP id f9-20020a5d58e9000000b00306340c4737mr8915416wrd.67.1683630064995;
        Tue, 09 May 2023 04:01:04 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d508b000000b00307a86a4bcesm772278wrt.35.2023.05.09.04.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:01:04 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] regmap-irq: Cleanups and remove unused functionality
Date:   Tue,  9 May 2023 12:00:54 +0100
Message-Id: <20230509110100.3980123-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a straightforward patch series, mostly just removing a bunch
of old features that were only used by a handful of drivers.

- 1/6 is a documentation fix
- 2/6, 3/6, and 4/6 remove unused, deprecated functionality
- 5/6 makes the behavior of .handle_mask_sync() a bit more consistent
  w.r.t. mask and unmask registers, to aid maintainability.
- 6/6 removes now-unused "inverted mask/unmask" compatibility code.

Aidan MacDonald (6):
  regmap-irq: Fix typo in documentation for .get_irq_reg()
  regmap-irq: Remove virtual registers
  regmap-irq: Remove type registers
  regmap-irq: Remove support for not_fixed_stride
  regmap-irq: Minor adjustments to .handle_mask_sync()
  regmap-irq: Drop backward compatibility for inverted mask/unmask

 drivers/base/regmap/regmap-irq.c | 269 ++++++-------------------------
 include/linux/regmap.h           |  30 +---
 2 files changed, 48 insertions(+), 251 deletions(-)

-- 
2.39.2

