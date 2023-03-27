Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311E06CA752
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjC0OSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjC0OSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:18:05 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98626A54;
        Mon, 27 Mar 2023 07:16:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h25so11660185lfv.6;
        Mon, 27 Mar 2023 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679926575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hEN6CxeaZDl0mJP9ZYJ+VeHAdDWaws/ieJcjOL6ATL8=;
        b=ChQeGRVfObIFJ2D+tCk4G38Ywu8sf5w0IKv2Z2raD4bR/mlpppD/HllSCU8DEJ8HgE
         PbQtAseuAp3XrvKtw8Hxvl+SSyyaN/Io/i+3Zd/CEldP12j0eDrVUu6F4hntBntsn6v0
         JdjY+2bpZR7WzY1vX5TKgaXJdsqHFMJwpvxMiEYgJmxjkZxr2VuCGp9AwoHI+XaTm69R
         1uhQ94x6yuv3XE2+aloMAILp70ajc1tY0c9EilIbGmXH/huNB7TDGbiWifNtLnFoQ6kl
         V6Qg3ONcMtTjGgBpJaoF5iMNa4Ylg8O6fG808zL2IqYpyhu8L2xBaFetXI5uQ0PKiXBE
         LWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679926575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEN6CxeaZDl0mJP9ZYJ+VeHAdDWaws/ieJcjOL6ATL8=;
        b=mf+PfNJ4fFC0tY5J64odo6Np4aEeSpBpqCG9gA6LuWYq2VP1i8aA1tTIMw2HTaZ+IX
         y48LUt9dEmjCca7jRwG+WNqlkM9h0UPjWqgEHdrcR8FilIGArLjDsUWeZxnqhGcEstNL
         6BVN+C3sh02tOI7Vt0dsq29ahn5U7ZuZBs2vJa4WgmVYGZ/iQ2SID7dbify+JXsTeZZx
         eal8vt3wiY4yBC2wly2GASigdWdTStqVxHHw6IvsSiKrrzgIflryD/CGylF0qcgFJ4kL
         tx5F+wt8hFSOjswGMr6rfizSu2uwdPlTtO6dEV5O/5lKWnsAJm0PUt7JktYcfbhb2iDH
         KGFw==
X-Gm-Message-State: AAQBX9dFECylkVK/+2H3/+MZrxi1+ZflaVpMFzz3DgCok0xDXU/Gj3dr
        9zVlI/BzyCijZ46t/k5jnHU=
X-Google-Smtp-Source: AKy350ZsBIo2tJ8zJ115L0WAvIXrjx5aREjkdaPZi5OhIvkTIj/WXwkslLFFcseehLD+ZMSsb+zRXA==
X-Received: by 2002:ac2:550f:0:b0:4d7:44c9:9f4c with SMTP id j15-20020ac2550f000000b004d744c99f4cmr3329822lfk.4.1679926575279;
        Mon, 27 Mar 2023 07:16:15 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004e977970721sm4444519lfl.219.2023.03.27.07.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 07:16:14 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V6 0/3] nvmem: add fixed cells layout
Date:   Mon, 27 Mar 2023 16:16:08 +0200
Message-Id: <20230327141611.25131-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
V6:
Rename function & add unevaluatedProperties

Rafał Miłecki (3):
  dt-bindings: nvmem: layouts: add fixed-layout
  dt-bindings: nvmem: convert base example to use NVMEM fixed cells
    layout
  nvmem: core: add support for fixed cells *layout*

 .../bindings/nvmem/layouts/fixed-cell.yaml    | 31 ++++++++++
 .../bindings/nvmem/layouts/fixed-layout.yaml  | 50 +++++++++++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  5 +-
 .../devicetree/bindings/nvmem/nvmem.yaml      | 61 ++++++++-----------
 drivers/nvmem/core.c                          | 32 +++++++++-
 5 files changed, 137 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml

-- 
2.34.1

