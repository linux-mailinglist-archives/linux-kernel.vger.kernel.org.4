Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C206C2EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjCUKYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCUKYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:24:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8F71A4B7;
        Tue, 21 Mar 2023 03:24:25 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q14so587804ljm.11;
        Tue, 21 Mar 2023 03:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679394264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uhFdi1uiSeZOwxVmf0kVcvm/UyzlDMDXvQmSf1SDDC8=;
        b=GmUXM8c9wgJmKWFQvRdr5V3g9jTmnYxfcrVwrymq20rqbgLOiRP3ecoRAelvgW0n0E
         inuB0DeC/Yza4JUU0BjxLr9QuqM8Ii9bV0Ub09GNNKNMtojihphe/QaiC3Dk9l6D4rqG
         Uh5UbiU0E/VqNl/rbUaYATH2pquZjH5ISkEDMPL0PUlpNOnaa2STLm9ZFSA3mqgad3pI
         nzC0d5ODRLWkhvYS0WD66FM61GsoZHSytUDpe6EgAua0lG5YPlLcsSbPGvRa3aA1nB+T
         4gYTkl6+Bap2LYYuPVVl7fKvVcFE5jWuTIHINRZQQIMsnMAkxfUSTVwxsNbb0yPL/mMU
         oQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679394264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhFdi1uiSeZOwxVmf0kVcvm/UyzlDMDXvQmSf1SDDC8=;
        b=FvwTM761zt/F78u/rdFB75k7s08OkKvr9gxf5VLnM9ina56V3BeoSVU5kpm6onCz+I
         XdFlPYcam+lCnvJrf8p4qt5ShzjqmpZ0xzfcUFt+FSv/7neHBYaTJO7Njra0PhFxkr4w
         gHTbjvTEC7lDyEvx1gl5TUcXDHc/e+2r+lI4dlhi4m8WiM5/7lVuKAogMMd9w89gJhhy
         sSqck/hx8Ct6EElw62eFoI0T+4H4IS6t/2d0OZh7AWBLGT8UmQlrgYyX+FeXBK/JEkCs
         iHgkHZq0b85v+BkgqrPNTv7/KG8an17EBh76rrig07C7rCesV48kQ8TM5tKQzVoFmVAj
         fVDw==
X-Gm-Message-State: AO0yUKW4PKqkZU2E81fsY2V0f/BLB90GoeTpTOVo5JJMbP6yKwH+lpIO
        53wTFMBDWcvJZk9a/G48rIk=
X-Google-Smtp-Source: AK7set+KMF+Wu8C2Jt5CwGQjhAtjGC9RSF+0DgfVw0yOXHTTNZvvHDvbyir1beiOoNj3T/H9pBwQEw==
X-Received: by 2002:a2e:8806:0:b0:298:ac8b:bf19 with SMTP id x6-20020a2e8806000000b00298ac8bbf19mr692761ljh.50.1679394263576;
        Tue, 21 Mar 2023 03:24:23 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e904c000000b00299f0194108sm2163069ljg.31.2023.03.21.03.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:24:22 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V5 0/3] nvmem: add fixed cells layout
Date:   Tue, 21 Mar 2023 11:24:15 +0100
Message-Id: <20230321102418.4190-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

NVMEM bindings received a new feature recently: layouts. They allow 
defining NVMEM device content in a separated DT node named 
"nvmem-layout". That improvement results in cleaner and more generic
bindings.

New bindings & drivers should use layouts design. If possible we should
also try converting existing bindings & drivers to layouts.

This patchset allows defining NVMEM cells in a new way (using NVMEM
layout feature).

This deprecates support for defining NVMEM cells as direct DT device
node subnodes but IT DOESN'T drop support for that.

PLEASE understand what this patchset handles. It adds new & preferred
way of defining NVMEM cells. This patchset does NOT meant to:
1. Convert ALL existing bindings or drivers (it's a task for later)
2. Add support for new extra features (like multiple layouts)
3. Break any backward compatibility (it WON'T happen)

V5:
Support "fixed-layout" internally in NVMEM core (see PATCH 3/3)

Rafał Miłecki (3):
  dt-bindings: nvmem: layouts: add fixed-layout
  dt-bindings: nvmem: convert base example to use NVMEM fixed cells
    layout
  nvmem: core: add support for fixed cells *layout*

 .../bindings/nvmem/layouts/fixed-cell.yaml    | 31 ++++++++++
 .../bindings/nvmem/layouts/fixed-layout.yaml  | 49 +++++++++++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  5 +-
 .../devicetree/bindings/nvmem/nvmem.yaml      | 61 ++++++++-----------
 drivers/nvmem/core.c                          | 32 +++++++++-
 5 files changed, 136 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml

-- 
2.34.1

