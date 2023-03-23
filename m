Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C246C68B4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjCWMpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjCWMpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:45:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A95011B;
        Thu, 23 Mar 2023 05:45:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so765200wmq.2;
        Thu, 23 Mar 2023 05:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679575514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86x0zvA5byPNNNQeEfDkZ0SfOCaptmVsPMQn2MPWsCw=;
        b=pWxu6HE9L3uWLBS7HuW28lvIdzq2C/5qeeV420Mtvh+eX3zQWvdw8fccYSmFZXEslv
         U1GHQ6ZkRuMwHP+hPGhMahR+ym7M5qgN+WnrWd/uI6/FXvQT8IdIzWu2xPHydKYxLewg
         WRbmh76GeIEzz+XFHvpLCqkp3Mnr/+4QbJucWZgyUOoiL00t+FGYgHXnz0OJJGetvNWo
         ypjyzhNpPQRjaVbFzGfUnNTj8nZQs20xmSKRvAAWzVmgx+4SkkFCAGR8GavttuFwSbpa
         swK8O/eROiKN6NjoZTj6S72KJ+vTzSf0JYLhngv9k0Yx9djcXa0lxeYBx91yTG0yUTS7
         eweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86x0zvA5byPNNNQeEfDkZ0SfOCaptmVsPMQn2MPWsCw=;
        b=TPznfjzCYYf0tiM9aOeSzYM5/R6+paYcIuS5iowdayZQzqMnL1jMZtYWm5oMy4YihO
         z8Vzl77iqmH/Gr624HDYpGLTmwCdkXqCbfq3wUm+5bXUoillpWO7nOr5XM5Iy50Jsiwu
         0tzcJ0IcO+B9bAI8eUNEGbqjTcPkP+lLbxJIKztbUkVbftf7EgNDI0TFieNFhz1X9RO+
         UI1Xao41ZRnxYOrTu3q/rCyhJhRk+sP7Txk1xzFwNCXL2SqXsdCIUArBdmVN37FQWe1/
         cokmbrtkLXb6juuBKNvFhGmruQj0c5bfuiTNRu+egXC47maawUA9CErHNWCAOJRSADMm
         nmGQ==
X-Gm-Message-State: AO0yUKWoU9qoZkuKSI+b36USu9VId2xpdEGfbi300n3REgRnB8/J2HjJ
        E856rCsk4DtcLuXpbCQK4Wg=
X-Google-Smtp-Source: AK7set86s1gqsxDfS6CDvNip5x9UPde2UgGq76W9Jw+wJll9YwgOkOenQ/4F731zFE3BCaKj5XfXww==
X-Received: by 2002:a7b:c7d1:0:b0:3ed:301c:375c with SMTP id z17-20020a7bc7d1000000b003ed301c375cmr2182556wmk.21.1679575513972;
        Thu, 23 Mar 2023 05:45:13 -0700 (PDT)
Received: from atlantis.lan (255.red-79-146-124.dynamicip.rima-tde.net. [79.146.124.255])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c1c0900b003ee6aa4e6a9sm1942939wms.5.2023.03.23.05.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:45:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        masonccyang@mxic.com.tw, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 1/2] dt-bindings: mtd: nand: Macronix: document new binding
Date:   Thu, 23 Mar 2023 13:45:09 +0100
Message-Id: <20230323124510.2484808-2-noltari@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230323124510.2484808-1-noltari@gmail.com>
References: <20230323124510.2484808-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new "mxic,disable-block-protection" binding documentation.
This binding allows disabling block protection support for those devices not
supporting it.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 Documentation/devicetree/bindings/mtd/nand-macronix.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/nand-macronix.txt b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
index ffab28a2c4d1..03f65ca32cd3 100644
--- a/Documentation/devicetree/bindings/mtd/nand-macronix.txt
+++ b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
@@ -16,6 +16,9 @@ in children nodes.
 Required NAND chip properties in children mode:
 - randomizer enable: should be "mxic,enable-randomizer-otp"
 
+Optional NAND chip properties in children mode:
+- block protection disable: should be "mxic,disable-block-protection"
+
 Example:
 
 	nand: nand-controller@unit-address {
-- 
2.30.2

