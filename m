Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DC65F3691
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJCTni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiJCTn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:43:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7866491C5;
        Mon,  3 Oct 2022 12:43:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso9644670wmq.4;
        Mon, 03 Oct 2022 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=fXqxLaIvRD/O0UCd5hlgue7zJeHLrfk3Vu4E4SjTHno=;
        b=QsQU8v4wE/oWu59m99BCMP3Lp2zuuhAbB4OnvhOfJfvznp0xl5vLssXfl42Befoq7C
         bgoZ0DAYnqF5uUYfxb3hEULbZKzmHyhBuXGh69Qv7PIkyXbhla2jlxo6r09+2k+CSKLW
         by2B9edl9CKwJ6tSyFbkGv2TKU8/9a+2vtR2SRC+Pqp8WFIoIg2hWRDNfyixCFkyfu9j
         XJGuwBBG3iRVcZbpcbTz/XJqKpFVO+Bme1lwe4ZQ/NUgySELl6UwLunwaNC8tuveAgBu
         UlMoG7Ipi/u1mj5shw83SPgrh2J1EATTB533Orn4L6hPRxJ0kTxKksf6ZZoWRr5pcXQR
         sHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=fXqxLaIvRD/O0UCd5hlgue7zJeHLrfk3Vu4E4SjTHno=;
        b=vlyEDl15oApBZgTzaZo2sGBE6W3G+irpJGaTDFw/sK9t/lRnRrdDgpwVTQezKzi1gp
         JoOkokoQSptAsCxC3GrPPz58dwMc34fuFd1uzW37cbFrySFlKZ6k7HHT8NAkefhWU435
         H9J4C/qXgNCy2RW+ipRjbt7FOJ+UffhqmNsm9Lf/BtJV1DRMrmu8tiL/Q1DE+JlBo+LX
         da7hqXikLYtTWX56tMexWWqXZgPYi/2BTRXXfQaaHfCVvrhpp3ezpFRZrhmxfmCBLAoM
         OubT5k3/hYf2g+ZsK8E4997HBYn24FngqoqSGVZwYY+VOgHCZLUjo1OzLVrx2FCrrfVr
         RLXw==
X-Gm-Message-State: ACrzQf2DOYSvUdFWfxiOJqSwAo6XOUYTPLXC+quN+uRAoC6alu44qRVc
        5f+GMCw8+6vltAJTlTXoUBUbTSk39Us=
X-Google-Smtp-Source: AMsMyM6V8RWwX6Z7wosOWjpMxqnU5dZSzz7ccnIFiJIRwj7pncMnNnalC7n3VD2W4XLu9JwXg36XUQ==
X-Received: by 2002:a1c:f002:0:b0:3b4:dda4:b58f with SMTP id a2-20020a1cf002000000b003b4dda4b58fmr7581021wmb.184.1664826203763;
        Mon, 03 Oct 2022 12:43:23 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id q5-20020a05600c2e4500b003b50428cf66sm12041663wmf.33.2022.10.03.12.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 12:43:23 -0700 (PDT)
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
Subject: [PATCH v5 0/2] add device Xiaomi Mi 6 (codename sagit) and board binding
Date:   Mon,  3 Oct 2022 22:43:13 +0300
Message-Id: <20221003194315.943903-1-dsankouski@gmail.com>
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
  arm64: dts: qcom: sagit: add initial device tree for sagit
  dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 687 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |   6 +
 4 files changed, 695 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts

-- 
2.30.2

