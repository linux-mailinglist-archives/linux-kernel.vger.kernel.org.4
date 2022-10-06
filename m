Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F87F5F6212
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiJFHw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiJFHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:52:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610CE696DD;
        Thu,  6 Oct 2022 00:52:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w10so1634883edd.4;
        Thu, 06 Oct 2022 00:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rnL+He7Da96VSkLj6A5rMl8m0utiApVsa5fPZkDJuiw=;
        b=HtrBMIvhzgwLJN84v8LhNtOWCsKsU7iYvaCdghCbFPaj+cIg8kfZ9+Lq0HL9/HLDw/
         UeYIQHP48m83GO1UvPJqbKRk8UXO/hl9oy9zmmcCVL1UpzjQa+NxQJsH/2r5SL6Qi3+y
         8wSNX1hrV4Sin9tX2Gjzo8bxrEkJ1S1NBi6VCne24Lr/EyVjuvOjEh4U3YjOYcG+X/EI
         O6gua54cfepUng/FCbFsRq8Sm12WNIhQht42QohIYOTcE2goRmUUPyYaRQi57SPk000h
         JVvsiZuPZSNxK2Rdjzd/qSwRDx2YF5lM6/3TWjDlR4O4Tg52JbVQJiEY+649ZHnrTTjK
         CIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnL+He7Da96VSkLj6A5rMl8m0utiApVsa5fPZkDJuiw=;
        b=Ia88TRP1SbsLVZnyEJLdm2RQkeuypDgdYqdZPajMzNdfFprUNyM5C6zw6/QQ+wzZxd
         j0Nz56vBoiBzSVBronCh6V1JkjnGVGG5s7P9hs3AYxdMXXBybNnXfRpHtJZ1+6g8eCSM
         6sEZ43rterhncXvn3NJJWKWC2E2FP9vw/H48fqLIEdWILFG47odBnYaXxKpTHVaijvTK
         amB+5Jt7eCDYJJjKTM6SJxbCMqTzPb7tw2SJgZyYTl/iS/8z47n0aHdpx2/jQVZA/DAM
         zjp4J3rJAl57pGBxHdt6z6lMc2VaUbf/pc/AhbtvU090E8SSTr15baV/VY9dvU13v6pH
         CXjg==
X-Gm-Message-State: ACrzQf2VpTU0FsA+F9mTUJAsZSxY8sc5Y2EmuqiEbtbG9D5xzCPYvmWA
        8cw/64lIQ+LqpmF3Mv7mO5JmtYVy0Wc=
X-Google-Smtp-Source: AMsMyM4aQEmWXWYdB6HUtiu2uSbwjl6xnbWYKkSAZDQiXg+F3JIJAnLovTFgUXNKzGqsCAM2togF9Q==
X-Received: by 2002:a05:6402:3481:b0:459:50a9:5ab2 with SMTP id v1-20020a056402348100b0045950a95ab2mr3280941edc.279.1665042741638;
        Thu, 06 Oct 2022 00:52:21 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id g25-20020a056402321900b004542e65337asm5338329eda.51.2022.10.06.00.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 00:52:21 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v7 0/2] add device Xiaomi Mi 6 (codename sagit) and board binding
Date:   Thu,  6 Oct 2022 10:51:23 +0300
Message-Id: <20221006075125.1056605-1-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Add initial support for Xiaomi Mi 6 phone (codename sagit)

Dzmitry Sankouski (2):
  dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
  arm64: dts: qcom: sagit: add initial device tree for sagit

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 681 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |   8 +
 4 files changed, 691 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts

-- 
2.30.2

