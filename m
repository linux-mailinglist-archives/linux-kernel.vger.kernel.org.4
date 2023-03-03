Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441C46A9A60
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjCCPPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCCPPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:15:18 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D8D1688E;
        Fri,  3 Mar 2023 07:15:17 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id u20so1751445pfm.7;
        Fri, 03 Mar 2023 07:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677856517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wq1NMmnBaG7R4Jcn3pxMO6GwsnbxH/WmZCsywqTc1i0=;
        b=jkc/OSj3h56IQxPeDzjiJfMjHPzC0f2tP52qNIUnNFLfoCvcgLeByiN0S9UKiUcq+4
         sQI9tJDnZnKADdXdN//St4dMa3rSXKBgDVioNQGrlApExYRBexlX6dNoimlEzFsKhe1V
         r+0s2sKiX/cD0WGUMkrWXJp3SlHGRkLFRdJTXAM3sClCleMpRC8EHvprhAhCFf/Vozou
         b/mWemzBsX79BtyWy8/QjvmygU/1jQgK8mIiIRUBjjj/B52Y49ngsSHWzObBUhPUGXdp
         /8QJkIcoYDw5JO7qybySmKJZgK97WaTg15lV0/CJdvO2GsfYzXKV9DTqQ0eQUDcSSA3U
         EAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677856517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wq1NMmnBaG7R4Jcn3pxMO6GwsnbxH/WmZCsywqTc1i0=;
        b=yv+YulvJmoXSf+xSZCQ7v/y/8sCXIXX2eJVUWQVIopIcVsCokqbt3iprsnHjUs8HxZ
         GaxVAAn7amToZBJ+v3oQq9ps+bssiTfTidhKpVjXGwf7fJxvwfUhv60Hm54wmmh4HAlS
         3PbJf/Q0xhTEbTKS0mAwEIgxAmNM9hp2ZdDduBL6SQOEeoa9vSEis5NYNgIxInShr7LF
         iqZZOf6ulo769tyzWeFGU3Q/y9qEtzcqWcPrAa6pw54eTuBIhXCnNRr7OFgrsluDUSgK
         X33BIO2RK/+t+QHFgjmemeqlznFow2pB06mXZ/QSSX7QMGt4nEWnJRSuwbcT1Sya1YKv
         gSdg==
X-Gm-Message-State: AO0yUKX8ZA4jDpuCwwrXNVapSVOftGtAgi62hw9V2kU2MbkHB3GMRTif
        2UQbYxseiYNndqjNZgEJsKd9s5QxYZZaeIFa
X-Google-Smtp-Source: AK7set+jhb4d5Ez6wGa8Um572OznZxavGBtoj7ecy6Rv6X8h1OuyOz8YXR6JpdoEhXUrjhp4sD+SYQ==
X-Received: by 2002:a62:19d6:0:b0:5a8:be36:65a8 with SMTP id 205-20020a6219d6000000b005a8be3665a8mr2378192pfz.27.1677856517365;
        Fri, 03 Mar 2023 07:15:17 -0800 (PST)
Received: from y.ha.lan ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id p4-20020aa78604000000b005a8bdc18453sm1739721pfn.35.2023.03.03.07.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:15:16 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Add CRG driver for Hi3798MV100 SoC
Date:   Fri,  3 Mar 2023 23:14:08 +0800
Message-Id: <20230303151417.104321-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.1
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

This series adds CRG driver for Hi3798MV100 SoC.

David Yang (5):
  clk: hisilicon: Rename Hi3798CV200 to Hi3798
  clk: hisilicon: Extract common functions
  clk: hisilicon: Rename some symbols for Hi3798CV200
  clk: hisilicon: Add inner clocks for Hi3798MV100
  clk: hisilicon: Add CRG driver for Hi3798MV100 SoC

 .../devicetree/bindings/clock/hisi-crg.txt    |   2 +
 drivers/clk/hisilicon/Kconfig                 |   6 +-
 drivers/clk/hisilicon/Makefile                |   2 +-
 drivers/clk/hisilicon/crg-hi3798.c            | 606 ++++++++++++++++++
 drivers/clk/hisilicon/crg-hi3798cv200.c       | 401 ------------
 include/dt-bindings/clock/histb-clock.h       |  13 +
 6 files changed, 625 insertions(+), 405 deletions(-)
 create mode 100644 drivers/clk/hisilicon/crg-hi3798.c
 delete mode 100644 drivers/clk/hisilicon/crg-hi3798cv200.c

-- 
2.39.1

